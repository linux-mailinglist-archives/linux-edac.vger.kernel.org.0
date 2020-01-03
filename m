Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 608C812F97C
	for <lists+linux-edac@lfdr.de>; Fri,  3 Jan 2020 16:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbgACPHn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 3 Jan 2020 10:07:43 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:20597 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbgACPHn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 3 Jan 2020 10:07:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1578064063; x=1609600063;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TInWHT1nyTPvbMS5z8zVcpKZsV2aYQwc/ahyoW7Tc+8=;
  b=g/bqTZWTnyFqcxFNxZ/WAaymmgnD+GtXtuhDOcXq6Dh99n3TsZuWOI2R
   aUy5d5PS0liRSfkC0nnwCOlHN3BpjjxUZHWGnPQ0HPa5cFXuANvJFxuYn
   25EC9Qu0XQI7+WIN8HmIEoLeFFiLA3fNAjvNJKVzd5y+jy1Wy+7hMx1RT
   c=;
IronPort-SDR: falGAzFI29AzgGAlTF6HJ8cdlr8CGF9r3fVDeGzcWyZcigigBzOOwnCcgoqK0nG/hMVSKii53Z
 +XFDLuKDNR7w==
X-IronPort-AV: E=Sophos;i="5.69,391,1571702400"; 
   d="scan'208";a="9979313"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-87a10be6.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 03 Jan 2020 15:07:40 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2c-87a10be6.us-west-2.amazon.com (Postfix) with ESMTPS id 79E2EA1D03;
        Fri,  3 Jan 2020 15:07:39 +0000 (UTC)
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id 003F7bZo020445
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Jan 2020 16:07:37 +0100
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id 003F7bT0020444;
        Fri, 3 Jan 2020 16:07:37 +0100
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH v2 1/6] x86/mce: Take action on UCNA/Deferred errors again
Date:   Fri,  3 Jan 2020 16:07:17 +0100
Message-Id: <20200103150722.20313-2-jschoenh@amazon.de>
X-Mailer: git-send-email 2.22.0.3.gb49bb57c8208.dirty
In-Reply-To: <20200103150722.20313-1-jschoenh@amazon.de>
References: <20200103150722.20313-1-jschoenh@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Commit fa92c5869426 ("x86, mce: Support memory error recovery for both
UCNA and Deferred error in machine_check_poll") added handling of UCNA
and Deferred errors by adding them to the ring for SRAO errors.

Later, commit fd4cf79fcc4b ("x86/mce: Remove the MCE ring for Action
Optional errors") switched storage from the SRAO ring to the unified
pool that is still in use today. In order to only act on the intended
errors, a filter for MCE_AO_SEVERITY is used -- effectively removing
handling of UCNA/Deferred errors again.

Extend the severity filter to include UCNA/Deferred errors again.
Also, generalize the naming of the notifier from SRAO to UC to capture
the extended scope.

Note, that this change may cause a message like the following to appear,
as the same address may be reported as SRAO and as UCNA:

 Memory failure: 0x5fe3284: already hardware poisoned

Technically, this is a return to previous behavior.

Fixes: fd4cf79fcc4b ("x86/mce: Remove the MCE ring for Action Optional errors")
Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
Changes v1->v2:
- rename notifier from SRAO to UC (as requested by Tony)
- extend commit message (per remark from Tony)
- don't mention Linux versions (per remark from Boris)

There was some discussion on v1, whether the SRAO/UC notifier does
the right thing or not. While it seems to be correct as is for Intel
(per Tony), there were some concerns for AMD (per Yazen). Hence, there
is a new patch 5 in this series, which disables the notifier on AMD.
---
 arch/x86/include/asm/mce.h     |  2 +-
 arch/x86/kernel/cpu/mce/core.c | 31 ++++++++++++++++---------------
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index dc2d4b206ab7..c8ff6f6750ef 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -144,7 +144,7 @@ struct mce_log_buffer {
 
 enum mce_notifier_prios {
 	MCE_PRIO_FIRST		= INT_MAX,
-	MCE_PRIO_SRAO		= INT_MAX - 1,
+	MCE_PRIO_UC		= INT_MAX - 1,
 	MCE_PRIO_EXTLOG		= INT_MAX - 2,
 	MCE_PRIO_NFIT		= INT_MAX - 3,
 	MCE_PRIO_EDAC		= INT_MAX - 4,
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 8994fe7751a4..16134ce587fd 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -156,10 +156,8 @@ void mce_log(struct mce *m)
 }
 EXPORT_SYMBOL_GPL(mce_log);
 
-static struct notifier_block mce_srao_nb;
-
 /*
- * We run the default notifier if we have only the SRAO, the first and the
+ * We run the default notifier if we have only the UC, the first and the
  * default notifier registered. I.e., the mandatory NUM_DEFAULT_NOTIFIERS
  * notifiers registered on the chain.
  */
@@ -580,26 +578,29 @@ static struct notifier_block first_nb = {
 	.priority	= MCE_PRIO_FIRST,
 };
 
-static int srao_decode_notifier(struct notifier_block *nb, unsigned long val,
-				void *data)
+static int uc_decode_notifier(struct notifier_block *nb, unsigned long val,
+			      void *data)
 {
 	struct mce *mce = (struct mce *)data;
 	unsigned long pfn;
 
-	if (!mce)
+	if (!mce || !mce_usable_address(mce))
 		return NOTIFY_DONE;
 
-	if (mce_usable_address(mce) && (mce->severity == MCE_AO_SEVERITY)) {
-		pfn = mce->addr >> PAGE_SHIFT;
-		if (!memory_failure(pfn, 0))
-			set_mce_nospec(pfn);
-	}
+	if (mce->severity != MCE_AO_SEVERITY &&
+	    mce->severity != MCE_DEFERRED_SEVERITY)
+		return NOTIFY_DONE;
+
+	pfn = mce->addr >> PAGE_SHIFT;
+	if (!memory_failure(pfn, 0))
+		set_mce_nospec(pfn);
 
 	return NOTIFY_OK;
 }
-static struct notifier_block mce_srao_nb = {
-	.notifier_call	= srao_decode_notifier,
-	.priority	= MCE_PRIO_SRAO,
+
+static struct notifier_block mce_uc_nb = {
+	.notifier_call	= uc_decode_notifier,
+	.priority	= MCE_PRIO_UC,
 };
 
 static int mce_default_notifier(struct notifier_block *nb, unsigned long val,
@@ -1970,7 +1971,7 @@ int __init mcheck_init(void)
 {
 	mcheck_intel_therm_init();
 	mce_register_decode_chain(&first_nb);
-	mce_register_decode_chain(&mce_srao_nb);
+	mce_register_decode_chain(&mce_uc_nb);
 	mce_register_decode_chain(&mce_default_nb);
 	mcheck_vendor_init_severity();
 
-- 
2.22.0.3.gb49bb57c8208.dirty

