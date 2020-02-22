Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45AB5169041
	for <lists+linux-edac@lfdr.de>; Sat, 22 Feb 2020 17:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgBVQYr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 22 Feb 2020 11:24:47 -0500
Received: from mga06.intel.com ([134.134.136.31]:49589 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgBVQYr (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 22 Feb 2020 11:24:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Feb 2020 08:24:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,472,1574150400"; 
   d="scan'208";a="236874461"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by orsmga003.jf.intel.com with ESMTP; 22 Feb 2020 08:24:46 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     tony.luck@intel.com, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: [PATCH] x86/mce/therm_throt: Handle case where throttle_active_work() is called on behalf of an offline CPU
Date:   Sat, 22 Feb 2020 08:24:32 -0800
Message-Id: <20200222162432.497201-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

During cpu-hotplug test with CONFIG_PREEMPTION and CONFIG_DEBUG_PREEMPT
enabled, Chris reported error:

BUG: using smp_processor_id() in preemptible [00000000] code: kworker/1:0/17
caller is throttle_active_work+0x12/0x280

Here throttle_active_work() is a work queue callback scheduled with
schedule_delayed_work_on(). This will not cause this error for the use
of smp_processor_id() under normal conditions as there is a check for
"current->nr_cpus_allowed == 1".
But when the target CPU is offline the workqueue becomes unbound.
Then the work queue callback can be scheduled on another CPU and the
error is printed for the use of smp_processor_id() in preemptible context.

When the workqueue is not getting called on the target CPU, simply return.
This is done by adding a cpu field in the _thermal_state struct and match
the current CPU id.

Once workqueue is scheduled, prevent CPU offline. In this way, the log
bits are checked and cleared on the correct CPU. Also use get_cpu() to
get current CPU id and prevent preemption before we finish processing.

Fixes: f6656208f04e ("x86/mce/therm_throt: Optimize notifications of thermal throttle")
Reported-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/therm_throt.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/therm_throt.c b/arch/x86/kernel/cpu/mce/therm_throt.c
index 58b4ee3cda77..4dab8a4558f9 100644
--- a/arch/x86/kernel/cpu/mce/therm_throt.c
+++ b/arch/x86/kernel/cpu/mce/therm_throt.c
@@ -61,6 +61,7 @@
  * @new_event:			Stores the last high/low status of the
  *				THERM_STATUS_PROCHOT or
  *				THERM_STATUS_POWER_LIMIT.
+ * @cpu:			CPU id for this instance.
  * @level:			Stores whether this _thermal_state instance is
  *				for a CORE level or for PACKAGE level.
  * @sample_index:		Index for storing the next sample in the buffer
@@ -86,6 +87,7 @@ struct _thermal_state {
 	unsigned long		total_time_ms;
 	bool			rate_control_active;
 	bool			new_event;
+	int			cpu;
 	u8			level;
 	u8			sample_index;
 	u8			sample_count;
@@ -239,11 +241,19 @@ static void __maybe_unused throttle_active_work(struct work_struct *work)
 {
 	struct _thermal_state *state = container_of(to_delayed_work(work),
 						struct _thermal_state, therm_work);
-	unsigned int i, avg, this_cpu = smp_processor_id();
+	unsigned int i, avg, this_cpu;
 	u64 now = get_jiffies_64();
 	bool hot;
 	u8 temp;
 
+	get_online_cpus();
+	this_cpu = get_cpu();
+
+	if (state->cpu != this_cpu) {
+		state->rate_control_active = false;
+		goto end;
+	}
+
 	get_therm_status(state->level, &hot, &temp);
 	/* temperature value is offset from the max so lesser means hotter */
 	if (!hot && temp > state->baseline_temp) {
@@ -254,7 +264,7 @@ static void __maybe_unused throttle_active_work(struct work_struct *work)
 				state->count);
 
 		state->rate_control_active = false;
-		return;
+		goto end;
 	}
 
 	if (time_before64(now, state->next_check) &&
@@ -296,6 +306,10 @@ static void __maybe_unused throttle_active_work(struct work_struct *work)
 re_arm:
 	clear_therm_status_log(state->level);
 	schedule_delayed_work_on(this_cpu, &state->therm_work, THERM_THROT_POLL_INTERVAL);
+
+end:
+	put_cpu();
+	put_online_cpus();
 }
 
 /***
@@ -359,6 +373,7 @@ static void therm_throt_process(bool new_event, int event, int level)
 
 		state->baseline_temp = temp;
 		state->last_interrupt_time = now;
+		state->cpu = this_cpu;
 		schedule_delayed_work_on(this_cpu, &state->therm_work, THERM_THROT_POLL_INTERVAL);
 	} else if (old_event && state->last_interrupt_time) {
 		unsigned long throttle_time;
-- 
2.24.1

