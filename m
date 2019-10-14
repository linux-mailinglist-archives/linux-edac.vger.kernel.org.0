Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 259B8D6B2A
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2019 23:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387973AbfJNVVG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 14 Oct 2019 17:21:06 -0400
Received: from mga18.intel.com ([134.134.136.126]:21857 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387506AbfJNVVE (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 14 Oct 2019 17:21:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Oct 2019 14:21:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,296,1566889200"; 
   d="scan'208";a="185610161"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by orsmga007.jf.intel.com with ESMTP; 14 Oct 2019 14:21:03 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     tony.luck@intel.com, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, bberg@redhat.com
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, hdegoede@redhat.com,
        ckellner@redhat.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/2] x86, mce, therm_throt: Optimize logging of thermal throttle messages
Date:   Mon, 14 Oct 2019 14:21:00 -0700
Message-Id: <20191014212101.25719-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <2c2b65c23be3064504566c5f621c1f37bf7e7326.camel@redhat.com>
References: <2c2b65c23be3064504566c5f621c1f37bf7e7326.camel@redhat.com>
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

The solution here is to set a timeout when the temperature first exceeds
the threshold. If the CPU returns to normal before the timeout fires,
we skip printing any messages. If we reach the timeout, then there may be
a real thermal issue (e.g. inoperative or blocked fan) and we print the
message (together with a count of how many thermal events have occurred).
A rate control method is used to avoid printing repeatedly on these broken
systems.

Some experimentation with fans enabled showed that temperature returned
to normal on a laptop in ~4 seconds. With fans disabled it took over 10
seconds. Default timeout is thus set to 8 seconds, but may be changed
with kernel boot parameter: "x86_therm_warn_delay". This default interval
is twice of typical sampling interval for cooling using running average
power limit from user space thermal control softwares.

In addition a new sysfs attribute is added to show what is the maximum
amount of time in miili-seconds the system was in throttled state. This
will allow to change x86_therm_warn_delay, if required.

Suggested-by: Alan Cox <alan@linux.intel.com>
Commit-comment-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 arch/x86/kernel/cpu/mce/therm_throt.c | 94 ++++++++++++++++++++++-----
 1 file changed, 77 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/therm_throt.c b/arch/x86/kernel/cpu/mce/therm_throt.c
index 6e2becf547c5..b2e9d10bef44 100644
--- a/arch/x86/kernel/cpu/mce/therm_throt.c
+++ b/arch/x86/kernel/cpu/mce/therm_throt.c
@@ -47,8 +47,13 @@ struct _thermal_state {
 	bool			new_event;
 	int			event;
 	u64			next_check;
+	u64			last_interrupt_time;
+	struct timer_list	timer;
 	unsigned long		count;
-	unsigned long		last_count;
+	unsigned long		max_time_ms;
+	int			rate_control_active;
+	int			cpu;
+	int			level;
 };
 
 struct thermal_state {
@@ -121,8 +126,15 @@ define_therm_throt_device_one_ro(package_throttle_count);
 define_therm_throt_device_show_func(package_power_limit, count);
 define_therm_throt_device_one_ro(package_power_limit_count);
 
+define_therm_throt_device_show_func(core_throttle, max_time_ms);
+define_therm_throt_device_one_ro(core_throttle_max_time_ms);
+
+define_therm_throt_device_show_func(package_throttle, max_time_ms);
+define_therm_throt_device_one_ro(package_throttle_max_time_ms);
+
 static struct attribute *thermal_throttle_attrs[] = {
 	&dev_attr_core_throttle_count.attr,
+	&dev_attr_core_throttle_max_time_ms.attr,
 	NULL
 };
 
@@ -135,6 +147,19 @@ static const struct attribute_group thermal_attr_group = {
 #define CORE_LEVEL	0
 #define PACKAGE_LEVEL	1
 
+#define THERM_THROT_WARN_INTERVAL_MS	8000
+static unsigned int thermal_warn_interval = THERM_THROT_WARN_INTERVAL_MS;
+
+static void therm_throt_active_timer_fn(struct timer_list *t)
+{
+	struct _thermal_state *state = from_timer(state, t, timer);
+
+	pr_crit("CPU%d: %s temperature is above threshold, cpu clock is throttled from last %d milli seconds (total events = %lu)\n",
+		state->cpu,
+		state->level == CORE_LEVEL ? "Core" : "Package",
+		thermal_warn_interval, state->count);
+}
+
 /***
  * therm_throt_process - Process thermal throttling event from interrupt
  * @curr: Whether the condition is current or not (boolean), since the
@@ -174,31 +199,42 @@ static void therm_throt_process(bool new_event, int event, int level)
 
 	old_event = state->new_event;
 	state->new_event = new_event;
+	state->level = level;
 
 	if (new_event)
 		state->count++;
 
 	if (time_before64(now, state->next_check) &&
-			state->count != state->last_count)
+			  state->rate_control_active)
 		return;
 
+	state->rate_control_active = 0;
+
 	state->next_check = now + CHECK_INTERVAL;
-	state->last_count = state->count;
 
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
+	if (event == THERMAL_THROTTLING_EVENT) {
+		if (new_event && !state->last_interrupt_time) {
+			state->last_interrupt_time = now;
+			if (!timer_pending(&state->timer))
+				mod_timer(&state->timer,
+					  (now + msecs_to_jiffies(thermal_warn_interval)));
+		} else if (old_event && state->last_interrupt_time) {
+			unsigned long throttle_time;
+			int ret;
+
+			ret = del_timer(&state->timer);
+			throttle_time = jiffies_delta_to_msecs(now - state->last_interrupt_time);
+			if (!ret) {
+				pr_crit("CPU%d: %s temperature/speed normal (total events = %lu, throttled time: %lu milli seconds)\n",
+					state->cpu,
+					state->level == CORE_LEVEL ? "Core" : "Package",
+					state->count, throttle_time);
+				state->rate_control_active = 1;
+			}
+			if (throttle_time > state->max_time_ms)
+				state->max_time_ms = throttle_time;
+			state->last_interrupt_time = 0;
+		}
 	}
 }
 
@@ -252,6 +288,9 @@ static int thermal_throttle_add_dev(struct device *dev, unsigned int cpu)
 		err = sysfs_add_file_to_group(&dev->kobj,
 					      &dev_attr_package_throttle_count.attr,
 					      thermal_attr_group.name);
+		err = sysfs_add_file_to_group(&dev->kobj,
+					      &dev_attr_package_throttle_max_time_ms.attr,
+					      thermal_attr_group.name);
 		if (cpu_has(c, X86_FEATURE_PLN) && int_pln_enable)
 			err = sysfs_add_file_to_group(&dev->kobj,
 					&dev_attr_package_power_limit_count.attr,
@@ -269,15 +308,28 @@ static void thermal_throttle_remove_dev(struct device *dev)
 /* Get notified when a cpu comes on/off. Be hotplug friendly. */
 static int thermal_throttle_online(unsigned int cpu)
 {
+	struct thermal_state *state = &per_cpu(thermal_state, cpu);
 	struct device *dev = get_cpu_device(cpu);
 
+	state->package_throttle.cpu = cpu;
+	state->core_throttle.cpu = cpu;
+
+	timer_setup(&state->package_throttle.timer, therm_throt_active_timer_fn, 0);
+	timer_setup(&state->core_throttle.timer, therm_throt_active_timer_fn, 0);
+
 	return thermal_throttle_add_dev(dev, cpu);
 }
 
 static int thermal_throttle_offline(unsigned int cpu)
 {
+	struct thermal_state *state = &per_cpu(thermal_state, cpu);
 	struct device *dev = get_cpu_device(cpu);
 
+	del_timer(&state->package_throttle.timer);
+	del_timer(&state->core_throttle.timer);
+	state->package_throttle.last_interrupt_time = 0;
+	state->core_throttle.last_interrupt_time = 0;
+
 	thermal_throttle_remove_dev(dev);
 	return 0;
 }
@@ -522,3 +574,11 @@ void intel_init_thermal(struct cpuinfo_x86 *c)
 	/* enable thermal throttle processing */
 	atomic_set(&therm_throt_en, 1);
 }
+
+static int __init therm_warn_delay(char *str)
+{
+	get_option(&str, &thermal_warn_interval);
+
+	return 0;
+}
+early_param("x86_therm_warn_delay", therm_warn_delay);
-- 
2.17.2

