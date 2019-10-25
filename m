Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3B4E4083
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2019 02:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730251AbfJYATg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 24 Oct 2019 20:19:36 -0400
Received: from mga09.intel.com ([134.134.136.24]:29069 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730212AbfJYATg (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 24 Oct 2019 20:19:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2019 17:19:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,226,1569308400"; 
   d="scan'208";a="202458937"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by orsmga006.jf.intel.com with ESMTP; 24 Oct 2019 17:19:35 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     tony.luck@intel.com, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, bberg@redhat.com
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, hdegoede@redhat.com,
        ckellner@redhat.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC][PATCH] x86, mce, therm_throt: Optimize notifications of thermal throttle
Date:   Thu, 24 Oct 2019 17:19:24 -0700
Message-Id: <20191025001924.10199-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Some modern systems have very tight thermal tolerances. Because of this
they may cross thermal thresholds when running normal workloads (even
during boot). The CPU hardware will react by limiting power/frequency
and using duty cycles to bring the temperature back into normal range.

Thus users may see a "critical" message about the "temperature above
threshold" which is soon followed by "temperature/speed normal". These
messages are rate limited, but still may repeat every few minutes.

A test run on a laptop with Intel 8th Gen i5 core for two hours with a
workload resulted in 20K+ thermal interrupts per CPU for core level and
another 20K+ interrupts at package level. The kernel logs were full of
throttling messages.

Brief background, on why there are so many thermal interrupts in a
modern system:
From IvyBridge, there is another offset called TCC offset is introduced.
This adds an offset to the real PROCHOT temperature target. So effectively
this interrupt is generated much before the PROCHOT. There will be several
very short throttling by the processor using adaptive thermal monitoring
at this threshold, instead of more aggressive action close to PROCHOT.
This offset is configured by OEMs and some tend to be more conservative
than others. So logging such events just generates noise in the logs.

The real value of these threshold interrupts, is to debug problems with
the external cooling solutions and performance issues due to excessive
throttling.

So the solution here:
- Show in the current thermal_throttle folder, the maximum time for one
throttling event and total amount of time, the system was in throttling
state.
- Don't log short excursions.
- Log only when, in spite of thermal throttling the temperature is rising.
This is done by monitoring temperature trend using three point moving
average. On the high threshold interrupt trigger a delayed workqueue,
which monitors the threshold violation log bit, calculates moving moving
average and logs when temperature trend is raising. When the log bit is
clear and temperature is below threshold temperature, it will print
"Normal" message. Once a high threshold event is logged, it rate limits
number of log messages.
- Reduce the logging severity to warning.

With this patch, on the same test laptop, no warnings are printed in logs
as the max time the processor could bring the temperature under control is
only 280 ms.

This implementation is done with the inputs from Alan Cox and Tony Luck.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 arch/x86/kernel/cpu/mce/therm_throt.c | 193 +++++++++++++++++++++++---
 1 file changed, 172 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/therm_throt.c b/arch/x86/kernel/cpu/mce/therm_throt.c
index 6e2becf547c5..e06f8d475207 100644
--- a/arch/x86/kernel/cpu/mce/therm_throt.c
+++ b/arch/x86/kernel/cpu/mce/therm_throt.c
@@ -47,8 +47,19 @@ struct _thermal_state {
 	bool			new_event;
 	int			event;
 	u64			next_check;
+	u64			last_interrupt_time;
+	struct delayed_work	therm_work;
 	unsigned long		count;
 	unsigned long		last_count;
+	unsigned long		max_time_ms;
+	unsigned long		total_time_ms;
+	int			rate_control_active;
+	int			level;
+	int			sample_index;
+	int			sample_count;
+	int			average;
+	int			baseline_temp;
+	u8			temp_samples[3];
 };
 
 struct thermal_state {
@@ -121,8 +132,22 @@ define_therm_throt_device_one_ro(package_throttle_count);
 define_therm_throt_device_show_func(package_power_limit, count);
 define_therm_throt_device_one_ro(package_power_limit_count);
 
+define_therm_throt_device_show_func(core_throttle, max_time_ms);
+define_therm_throt_device_one_ro(core_throttle_max_time_ms);
+
+define_therm_throt_device_show_func(package_throttle, max_time_ms);
+define_therm_throt_device_one_ro(package_throttle_max_time_ms);
+
+define_therm_throt_device_show_func(core_throttle, total_time_ms);
+define_therm_throt_device_one_ro(core_throttle_total_time_ms);
+
+define_therm_throt_device_show_func(package_throttle, total_time_ms);
+define_therm_throt_device_one_ro(package_throttle_total_time_ms);
+
 static struct attribute *thermal_throttle_attrs[] = {
 	&dev_attr_core_throttle_count.attr,
+	&dev_attr_core_throttle_max_time_ms.attr,
+	&dev_attr_core_throttle_total_time_ms.attr,
 	NULL
 };
 
@@ -135,6 +160,95 @@ static const struct attribute_group thermal_attr_group = {
 #define CORE_LEVEL	0
 #define PACKAGE_LEVEL	1
 
+#define THERM_THROT_POLL_INTERVAL	HZ
+#define THERM_STATUS_PROCHOT_LOG	BIT(1)
+
+static void therm_throt_clear_therm_status_log(int level)
+{
+	u64 msr_val;
+	int msr;
+
+	msr = (level == CORE_LEVEL) ? MSR_IA32_THERM_STATUS :
+			MSR_IA32_PACKAGE_THERM_STATUS;
+	rdmsrl(msr, msr_val);
+	wrmsrl(msr, msr_val & ~THERM_STATUS_PROCHOT_LOG);
+}
+
+static void therm_throt_get_therm_status(int level, int *proc_hot, int *temp)
+{
+	u64 msr_val;
+	int msr;
+
+	msr = (level == CORE_LEVEL) ? MSR_IA32_THERM_STATUS :
+			MSR_IA32_PACKAGE_THERM_STATUS;
+	rdmsrl(msr, msr_val);
+	*proc_hot = msr_val & THERM_STATUS_PROCHOT_LOG ? 1 : 0;
+	*temp = (msr_val >> 16) & 0x7F;
+}
+
+static void therm_throt_active_work(struct work_struct *work)
+{
+	struct _thermal_state *state = container_of(to_delayed_work(work),
+						struct _thermal_state, therm_work);
+	int i, avg, this_cpu, hot, temp;
+	u64 now = get_jiffies_64();
+
+	this_cpu = smp_processor_id();
+
+	therm_throt_get_therm_status(state->level, &hot, &temp);
+	/* temperature value is offset from the max so lesser means hotter */
+	if (!hot && temp > state->baseline_temp) {
+		if (state->rate_control_active)
+			pr_warn("CPU%d: %s temperature/speed normal (total events = %lu)\n",
+				this_cpu,
+				state->level == CORE_LEVEL ? "Core" : "Package",
+				state->count);
+
+		state->rate_control_active = 0;
+		return;
+	}
+
+	if (time_before64(now, state->next_check) &&
+			  state->rate_control_active)
+		goto re_arm;
+
+	state->next_check = now + CHECK_INTERVAL;
+
+	if (state->count != state->last_count) {
+		/* There was one new thermal interrupt */
+		state->last_count = state->count;
+		state->average = 0;
+		state->sample_count = 0;
+		state->sample_index = 0;
+	}
+
+	state->temp_samples[state->sample_index] = temp;
+	state->sample_count++;
+	state->sample_index = (state->sample_index + 1) % ARRAY_SIZE(state->temp_samples);
+	if (state->sample_count < ARRAY_SIZE(state->temp_samples))
+		goto re_arm;
+
+	avg = 0;
+	for (i = 0; i < ARRAY_SIZE(state->temp_samples); ++i)
+		avg += state->temp_samples[i];
+
+	avg /= ARRAY_SIZE(state->temp_samples);
+
+	if (state->average > avg) {
+		pr_warn("CPU%d: %s temperature is above threshold, cpu clock is throttled (total events = %lu)\n",
+			this_cpu,
+			state->level == CORE_LEVEL ? "Core" : "Package",
+			state->count);
+		state->rate_control_active = 1;
+	}
+
+	state->average = avg;
+
+re_arm:
+	therm_throt_clear_therm_status_log(state->level);
+	schedule_delayed_work_on(this_cpu, &state->therm_work, THERM_THROT_POLL_INTERVAL);
+}
+
 /***
  * therm_throt_process - Process thermal throttling event from interrupt
  * @curr: Whether the condition is current or not (boolean), since the
@@ -178,27 +292,23 @@ static void therm_throt_process(bool new_event, int event, int level)
 	if (new_event)
 		state->count++;
 
-	if (time_before64(now, state->next_check) &&
-			state->count != state->last_count)
-		return;
+	if (event == THERMAL_THROTTLING_EVENT) {
+		if (new_event && !state->last_interrupt_time) {
+			int hot;
 
-	state->next_check = now + CHECK_INTERVAL;
-	state->last_count = state->count;
+			therm_throt_get_therm_status(state->level, &hot, &state->baseline_temp);
 
-	/* if we just entered the thermal event */
-	if (new_event) {
-		if (event == THERMAL_THROTTLING_EVENT)
-			pr_crit("CPU%d: %s temperature above threshold, cpu clock throttled (total events = %lu)\n",
-				this_cpu,
-				level == CORE_LEVEL ? "Core" : "Package",
-				state->count);
-		return;
-	}
-	if (old_event) {
-		if (event == THERMAL_THROTTLING_EVENT)
-			pr_info("CPU%d: %s temperature/speed normal\n", this_cpu,
-				level == CORE_LEVEL ? "Core" : "Package");
-		return;
+			state->last_interrupt_time = now;
+			schedule_delayed_work_on(this_cpu, &state->therm_work, THERM_THROT_POLL_INTERVAL);
+		} else if (old_event && state->last_interrupt_time) {
+			unsigned long throttle_time;
+
+			throttle_time = jiffies_delta_to_msecs(now - state->last_interrupt_time);
+			if (throttle_time > state->max_time_ms)
+				state->max_time_ms = throttle_time;
+			state->total_time_ms += throttle_time;
+			state->last_interrupt_time = 0;
+		}
 	}
 }
 
@@ -244,20 +354,47 @@ static int thermal_throttle_add_dev(struct device *dev, unsigned int cpu)
 	if (err)
 		return err;
 
-	if (cpu_has(c, X86_FEATURE_PLN) && int_pln_enable)
+	if (cpu_has(c, X86_FEATURE_PLN) && int_pln_enable) {
 		err = sysfs_add_file_to_group(&dev->kobj,
 					      &dev_attr_core_power_limit_count.attr,
 					      thermal_attr_group.name);
+		if (err)
+			goto del_group;
+	}
+
 	if (cpu_has(c, X86_FEATURE_PTS)) {
 		err = sysfs_add_file_to_group(&dev->kobj,
 					      &dev_attr_package_throttle_count.attr,
 					      thermal_attr_group.name);
-		if (cpu_has(c, X86_FEATURE_PLN) && int_pln_enable)
+		if (err)
+			goto del_group;
+
+		err = sysfs_add_file_to_group(&dev->kobj,
+					      &dev_attr_package_throttle_max_time_ms.attr,
+					      thermal_attr_group.name);
+		if (err)
+			goto del_group;
+
+		err = sysfs_add_file_to_group(&dev->kobj,
+					      &dev_attr_package_throttle_total_time_ms.attr,
+					      thermal_attr_group.name);
+		if (err)
+			goto del_group;
+
+		if (cpu_has(c, X86_FEATURE_PLN) && int_pln_enable) {
 			err = sysfs_add_file_to_group(&dev->kobj,
 					&dev_attr_package_power_limit_count.attr,
 					thermal_attr_group.name);
+			if (err)
+				goto del_group;
+		}
 	}
 
+	return 0;
+
+del_group:
+	sysfs_remove_group(&dev->kobj, &thermal_attr_group);
+
 	return err;
 }
 
@@ -269,15 +406,29 @@ static void thermal_throttle_remove_dev(struct device *dev)
 /* Get notified when a cpu comes on/off. Be hotplug friendly. */
 static int thermal_throttle_online(unsigned int cpu)
 {
+	struct thermal_state *state = &per_cpu(thermal_state, cpu);
 	struct device *dev = get_cpu_device(cpu);
 
+	state->package_throttle.level = PACKAGE_LEVEL;
+	state->core_throttle.level = CORE_LEVEL;
+
+	INIT_DELAYED_WORK(&state->package_throttle.therm_work, therm_throt_active_work);
+	INIT_DELAYED_WORK(&state->core_throttle.therm_work, therm_throt_active_work);
+
 	return thermal_throttle_add_dev(dev, cpu);
 }
 
 static int thermal_throttle_offline(unsigned int cpu)
 {
+	struct thermal_state *state = &per_cpu(thermal_state, cpu);
 	struct device *dev = get_cpu_device(cpu);
 
+	cancel_delayed_work(&state->package_throttle.therm_work);
+	cancel_delayed_work(&state->core_throttle.therm_work);
+
+	state->package_throttle.rate_control_active = 0;
+	state->core_throttle.rate_control_active = 0;
+
 	thermal_throttle_remove_dev(dev);
 	return 0;
 }
-- 
2.17.2

