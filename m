Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB884D134B
	for <lists+linux-edac@lfdr.de>; Wed,  9 Oct 2019 17:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730256AbfJIPzW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 9 Oct 2019 11:55:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60802 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729883AbfJIPzW (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 9 Oct 2019 11:55:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C8A4630BB370;
        Wed,  9 Oct 2019 15:55:21 +0000 (UTC)
Received: from ben-x1.muc.redhat.com (dhcp-64-153.muc.redhat.com [10.32.64.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B44C60920;
        Wed,  9 Oct 2019 15:55:19 +0000 (UTC)
From:   Benjamin Berg <bberg@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Benjamin Berg <bberg@redhat.com>,
        Christian Kellner <ckellner@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-edac@vger.kernel.org
Subject: [PATCH] x86/mce: Lower throttling MCE messages to warnings
Date:   Wed,  9 Oct 2019 17:54:24 +0200
Message-Id: <20191009155424.249277-1-bberg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 09 Oct 2019 15:55:21 +0000 (UTC)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On modern CPUs it is quite normal that the temperature limits are
reached and the CPU is throttled. In fact, often the thermal design is
not sufficient to cool the CPU at full load and limits can quickly be
reached when a burst in load happens. This will even happen with
technologies like RAPL limitting the long term power consumption of
the package.

So these messages do not usually indicate a hardware issue (e.g.
insufficient cooling). Log them as warnings to avoid confusion about
their severity.

Signed-off-by: Benjamin Berg <bberg@redhat.com>
Tested-by: Christian Kellner <ckellner@redhat.com>
---
 arch/x86/kernel/cpu/mce/therm_throt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/therm_throt.c b/arch/x86/kernel/cpu/mce/therm_throt.c
index 6e2becf547c5..bc441d68d060 100644
--- a/arch/x86/kernel/cpu/mce/therm_throt.c
+++ b/arch/x86/kernel/cpu/mce/therm_throt.c
@@ -188,7 +188,7 @@ static void therm_throt_process(bool new_event, int event, int level)
 	/* if we just entered the thermal event */
 	if (new_event) {
 		if (event == THERMAL_THROTTLING_EVENT)
-			pr_crit("CPU%d: %s temperature above threshold, cpu clock throttled (total events = %lu)\n",
+			pr_warn("CPU%d: %s temperature above threshold, cpu clock throttled (total events = %lu)\n",
 				this_cpu,
 				level == CORE_LEVEL ? "Core" : "Package",
 				state->count);
-- 
2.23.0

