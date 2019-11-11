Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE6CBF8265
	for <lists+linux-edac@lfdr.de>; Mon, 11 Nov 2019 22:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfKKVni (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 11 Nov 2019 16:43:38 -0500
Received: from mga07.intel.com ([134.134.136.100]:33174 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbfKKVni (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 11 Nov 2019 16:43:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2019 13:43:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,293,1569308400"; 
   d="scan'208";a="202186945"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga008.fm.intel.com with ESMTP; 11 Nov 2019 13:43:35 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     tony.luck@intel.com, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, bberg@redhat.com
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, hdegoede@redhat.com,
        ckellner@redhat.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] x86, mce, therm_throt: Optimize notifications of thermal throttle
Date:   Mon, 11 Nov 2019 13:43:12 -0800
Message-Id: <20191111214312.81365-1-srinivas.pandruvada@linux.intel.com>
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
messages are rate-limited, but still may repeat every few minutes.

This issue became worse starting with the Ivy Bridge generation of
CPUs because they include a TCC activation offset in the MSR
IA32_TEMPERATURE_TARGET. OEMs use this to provide alerts long before
critical temperatures are reached.

A test run on a laptop with Intel 8th Gen i5 core for two hours with a
workload resulted in 20K+ thermal interrupts per CPU for core level and
another 20K+ interrupts at package level. The kernel logs were full of
throttling messages.

The real value of these threshold interrupts, is to debug problems with
the external cooling solutions and performance issues due to excessive
throttling.

So the solution here is the following:
- In the current thermal_throttle folder, show the maximum time for one
throttling event and total amount of time, the system was in throttling
state.
- Do not log short excursions.
- Log only when, in spite of thermal throttling the temperature is rising.
On the high threshold interrupt trigger a delayed workqueue, that
monitors the threshold violation log bit (THERM_STATUS_PROCHOT_LOG). When
the log bit is set, this workqueue callback calculates three point moving
average and logs warning message when the temperature trend is rising.
When this log bit is clear and temperature is below threshold temperature,
then the workqueue callback logs "Normal" message". Once a high threshold
event is logged, the logging is rate limited.

With this patch, on the same test laptop, no warnings are printed in logs
as the max time the processor could bring the temperature under control is
only 280 ms.

This implementation is done with the inputs from Alan Cox and Tony Luck.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---

Version History:
v1:
Changes compared to RFC PATCH:
	Addressed comments from Boris
	Rebased to tip/master
	Added kenrel doc for struct
	Edits to the commit description
	Optimize storage for _thermal_state
	Ignore invalid sample for threshold high

 arch/x86/kernel/cpu/mce/therm_throt.c | 251 +++++++++++++++++++++++---
 1 file changed, 227 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/therm_throt.c b/arch/x86/kernel/cpu/mce/therm_throt.c
index bc441d68d060..c102fcff23f3 100644
--- a/arch/x86/kernel/cpu/mce/therm_throt.c
+++ b/arch/x86/kernel/cpu/mce/therm_throt.c
@@ -40,15 +40,58 @@
 #define THERMAL_THROTTLING_EVENT	0
 #define POWER_LIMIT_EVENT		1
 
-/*
- * Current thermal event state:
+/**
+ * struct _thermal_state - Represent the current thermal event state
+ * @next_check:			Stores the next timestamp, when it is allowed
+ *				to log the next warning message.
+ * @last_interrupt_time:	Stores the timestamp for the last threshold
+ *				high event.
+ * @therm_work:			Delayed workqueue structure
+ * @count:			Stores the current running count for thermal
+ *				or power threshold interrupts.
+ * @last_count:			Stores the previous running count for thermal
+ *				or power threshold interrupts.
+ * @max_time_ms:		This shows the maximum amount of time CPU was
+ *				in throttled state for a single thermal
+ *				threshold high to low state.
+ * @total_time_ms:		This is a cumulative time during which CPU was
+ *				in the throttled state.
+ * @rate_control_active:	Flag to set, when throttling message is logged.
+ *				This is used for the purpose of rate-control.
+ * @new_event:			Stores the last high/low status of the
+ *				THERM_STATUS_PROCHOT or
+ *				THERM_STATUS_POWER_LIMIT.
+ * @level:			Stores whether this _thermal_state instance is
+ *				for a CORE level or for PACKAGE level.
+ * @sample_index:		Index for storage for the next sample in the
+ *				buffer temp_samples[].
+ * @sample_count:		Total number of samples collected in the buffer
+ *				temp_samples[].
+ * @average:			The last moving average of temperature samples
+ * @baseline_temp:		Temperature at which thermal threshold high
+ *				interrupt was generated.
+ * @temp_samples:		Storage for temperature samples to calculate
+ *				moving average.
+ *
+ * This structure is used to represent data related to thermal state for a CPU.
+ * There is a separate storage for core and package level for each CPU.
  */
 struct _thermal_state {
-	bool			new_event;
-	int			event;
 	u64			next_check;
+	u64			last_interrupt_time;
+	struct delayed_work	therm_work;
 	unsigned long		count;
 	unsigned long		last_count;
+	unsigned long		max_time_ms;
+	unsigned long		total_time_ms;
+	bool			rate_control_active;
+	bool			new_event;
+	u8			level;
+	u8			sample_index;
+	u8			sample_count;
+	u8			average;
+	u8			baseline_temp;
+	u8			temp_samples[3];
 };
 
 struct thermal_state {
@@ -121,8 +164,22 @@ define_therm_throt_device_one_ro(package_throttle_count);
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
 
@@ -135,6 +192,105 @@ static const struct attribute_group thermal_attr_group = {
 #define CORE_LEVEL	0
 #define PACKAGE_LEVEL	1
 
+#define THERM_THROT_POLL_INTERVAL	HZ
+#define THERM_STATUS_PROCHOT_LOG	BIT(1)
+
+static void clear_therm_status_log(int level)
+{
+	int msr;
+	u64 msr_val;
+
+	if (level == CORE_LEVEL)
+		msr = MSR_IA32_THERM_STATUS;
+	else
+		msr = MSR_IA32_PACKAGE_THERM_STATUS;
+
+	rdmsrl(msr, msr_val);
+	wrmsrl(msr, msr_val & ~THERM_STATUS_PROCHOT_LOG);
+}
+
+static void get_therm_status(int level, bool *proc_hot, u8 *temp)
+{
+	int msr;
+	u64 msr_val;
+
+	if (level == CORE_LEVEL)
+		msr = MSR_IA32_THERM_STATUS;
+	else
+		msr = MSR_IA32_PACKAGE_THERM_STATUS;
+
+	rdmsrl(msr, msr_val);
+	if (msr_val & THERM_STATUS_PROCHOT_LOG)
+		*proc_hot = true;
+	else
+		*proc_hot = false;
+
+	*temp = (msr_val >> 16) & 0x7F;
+}
+
+static void throttle_active_work(struct work_struct *work)
+{
+	struct _thermal_state *state = container_of(to_delayed_work(work),
+						struct _thermal_state, therm_work);
+	unsigned int i, avg, this_cpu = smp_processor_id();
+	u64 now = get_jiffies_64();
+	bool hot;
+	u8 temp;
+
+	get_therm_status(state->level, &hot, &temp);
+	/* temperature value is offset from the max so lesser means hotter */
+	if (!hot && temp > state->baseline_temp) {
+		if (state->rate_control_active)
+			pr_info("CPU%d: %s temperature/speed normal (total events = %lu)\n",
+				this_cpu,
+				state->level == CORE_LEVEL ? "Core" : "Package",
+				state->count);
+
+		state->rate_control_active = false;
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
+		state->rate_control_active = true;
+	}
+
+	state->average = avg;
+
+re_arm:
+	clear_therm_status_log(state->level);
+	schedule_delayed_work_on(this_cpu, &state->therm_work, THERM_THROT_POLL_INTERVAL);
+}
+
 /***
  * therm_throt_process - Process thermal throttling event from interrupt
  * @curr: Whether the condition is current or not (boolean), since the
@@ -178,27 +334,33 @@ static void therm_throt_process(bool new_event, int event, int level)
 	if (new_event)
 		state->count++;
 
-	if (time_before64(now, state->next_check) &&
-			state->count != state->last_count)
+	if (event != THERMAL_THROTTLING_EVENT)
 		return;
 
-	state->next_check = now + CHECK_INTERVAL;
-	state->last_count = state->count;
+	if (new_event && !state->last_interrupt_time) {
+		bool hot;
+		u8 temp;
+
+		get_therm_status(state->level, &hot, &temp);
+		/*
+		 * Ignore short temperature spike as the system is not close
+		 * to PROCHOT. 10C offset is large enough to ignore. It is
+		 * already dropped from the high threshold temperature.
+		 */
+		if (temp > 10)
+			return;
 
-	/* if we just entered the thermal event */
-	if (new_event) {
-		if (event == THERMAL_THROTTLING_EVENT)
-			pr_warn("CPU%d: %s temperature above threshold, cpu clock throttled (total events = %lu)\n",
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
+		state->baseline_temp = temp;
+		state->last_interrupt_time = now;
+		schedule_delayed_work_on(this_cpu, &state->therm_work, THERM_THROT_POLL_INTERVAL);
+	} else if (old_event && state->last_interrupt_time) {
+		unsigned long throttle_time;
+
+		throttle_time = jiffies_delta_to_msecs(now - state->last_interrupt_time);
+		if (throttle_time > state->max_time_ms)
+			state->max_time_ms = throttle_time;
+		state->total_time_ms += throttle_time;
+		state->last_interrupt_time = 0;
 	}
 }
 
@@ -244,20 +406,47 @@ static int thermal_throttle_add_dev(struct device *dev, unsigned int cpu)
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
 
@@ -269,15 +458,29 @@ static void thermal_throttle_remove_dev(struct device *dev)
 /* Get notified when a cpu comes on/off. Be hotplug friendly. */
 static int thermal_throttle_online(unsigned int cpu)
 {
+	struct thermal_state *state = &per_cpu(thermal_state, cpu);
 	struct device *dev = get_cpu_device(cpu);
 
+	state->package_throttle.level = PACKAGE_LEVEL;
+	state->core_throttle.level = CORE_LEVEL;
+
+	INIT_DELAYED_WORK(&state->package_throttle.therm_work, throttle_active_work);
+	INIT_DELAYED_WORK(&state->core_throttle.therm_work, throttle_active_work);
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
+	state->package_throttle.rate_control_active = false;
+	state->core_throttle.rate_control_active = false;
+
 	thermal_throttle_remove_dev(dev);
 	return 0;
 }
-- 
2.17.2

