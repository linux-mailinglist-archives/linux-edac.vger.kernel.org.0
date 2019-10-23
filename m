Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADCB2E137A
	for <lists+linux-edac@lfdr.de>; Wed, 23 Oct 2019 09:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389888AbfJWH4F convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Wed, 23 Oct 2019 03:56:05 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:58344 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727574AbfJWH4E (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 23 Oct 2019 03:56:04 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
        by Forcepoint Email with ESMTPS id 992C3B43E8505BBCA215;
        Wed, 23 Oct 2019 15:56:02 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notessmtp.zte.com.cn [10.30.1.239])
        by mse-fl1.zte.com.cn with ESMTP id x9N7svf9034682;
        Wed, 23 Oct 2019 15:54:57 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019102315551692-90833 ;
          Wed, 23 Oct 2019 15:55:16 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     tony.luck@intel.com
Cc:     bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, up2wing@gmail.com, wang.liang82@zte.com.cn
Subject: [PATCH] x86/mce/amd: fix -Wmissing-prototypes warnings
Date:   Wed, 23 Oct 2019 15:57:17 +0800
Message-Id: <1571817437-7570-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-10-23 15:55:17,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-10-23 15:55:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-MAIL: mse-fl1.zte.com.cn x9N7svf9034682
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

We get two warnings when build kernel W=1:
arch/x86/kernel/cpu/mce/amd.c:586:6: warning: no previous prototype for ‘disable_err_thresholding’ [-Wmissing-prototypes]

Make the function static to fix this.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
 arch/x86/kernel/cpu/mce/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 6ea7fdc..5167bd2 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -583,7 +583,7 @@ bool amd_filter_mce(struct mce *m)
  * - Prevent possible spurious interrupts from the IF bank on Family 0x17
  *   Models 0x10-0x2F due to Erratum #1114.
  */
-void disable_err_thresholding(struct cpuinfo_x86 *c, unsigned int bank)
+static void disable_err_thresholding(struct cpuinfo_x86 *c, unsigned int bank)
 {
 	int i, num_msrs;
 	u64 hwcr;
-- 
1.8.3.1

