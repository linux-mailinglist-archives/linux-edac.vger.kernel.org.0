Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7449C12F987
	for <lists+linux-edac@lfdr.de>; Fri,  3 Jan 2020 16:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgACPIE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 3 Jan 2020 10:08:04 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:28273 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbgACPID (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 3 Jan 2020 10:08:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1578064083; x=1609600083;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z3tkOD4FG1FNGsCTSm+doFuNCbFR2kiicI330Grt1Ls=;
  b=DMyYrFTZ5N/znj46NzoqHqlQK+IVJ0E8Raq272GnZlp89a182pe1LFel
   azIxYGzVQrwNF8FSlKGsk0DmkW3rHNQfBCMo4s0aegB/Fd3Fg/q2G8/SB
   q1xBpF1ihrSGtMSkvU+6WVoMgpQ2yvF3a07ngUqk0RF3oI7T22kiccDGQ
   0=;
IronPort-SDR: j/1aZfZMIEify9CS7bxtKFpVmv3DbjadmiJ6p8Keovlx4Hcznlj640wtQ3rbdsm0sb1sgXa8tG
 rdIoBRWwoGYQ==
X-IronPort-AV: E=Sophos;i="5.69,390,1571702400"; 
   d="scan'208";a="16652123"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 03 Jan 2020 15:07:44 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan2.amazon.com [10.0.93.210])
        by email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com (Postfix) with ESMTPS id B9D05A2861;
        Fri,  3 Jan 2020 15:07:40 +0000 (UTC)
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id 003F7cx3020489
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Jan 2020 16:07:38 +0100
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id 003F7cHx020488;
        Fri, 3 Jan 2020 16:07:38 +0100
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH v2 6/6] x86/mce: Dynamically register default MCE handler
Date:   Fri,  3 Jan 2020 16:07:22 +0100
Message-Id: <20200103150722.20313-7-jschoenh@amazon.de>
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

The default MCE handler takes action, when no external MCE handler is
registered. Instead of checking for external handlers within the default
MCE handler, only register the default MCE handler when there are no
external handlers in the first place.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
New in v2. This is something that became possible due to patch 4.
I'm not entirely happy with it.

One the one hand, I'm wondering whether there's a nicer way to handle
(de-)registration races.

On the other hand, I'm starting to question the whole logic to "only print
the MCE if nothing else in the kernel has a handler registered". Is that
really how it should be? For example, there are handlers that filter for a
specific subset of MCEs. If one of those is registered, we're losing all
information for MCEs that don't match.

A possible solution to the latter would be to have a "handled" or "printed"
flag within "struct mce" and print the MCE based on that in the default
handler. What do you think?
---
 arch/x86/kernel/cpu/mce/core.c | 90 ++++++++++++++++++++--------------
 1 file changed, 52 insertions(+), 38 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index d8fe5b048ee7..3b6e37c5252f 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -156,36 +156,6 @@ void mce_log(struct mce *m)
 }
 EXPORT_SYMBOL_GPL(mce_log);
 
-/*
- * We run the default notifier as long as we have no external
- * notifiers registered on the chain.
- */
-static atomic_t num_notifiers;
-
-static void mce_register_decode_chain_internal(struct notifier_block *nb)
-{
-	if (WARN_ON(nb->priority > MCE_PRIO_MCELOG && nb->priority < MCE_PRIO_EDAC))
-		return;
-
-	blocking_notifier_chain_register(&x86_mce_decoder_chain, nb);
-}
-
-void mce_register_decode_chain(struct notifier_block *nb)
-{
-	atomic_inc(&num_notifiers);
-
-	mce_register_decode_chain_internal(nb);
-}
-EXPORT_SYMBOL_GPL(mce_register_decode_chain);
-
-void mce_unregister_decode_chain(struct notifier_block *nb)
-{
-	atomic_dec(&num_notifiers);
-
-	blocking_notifier_chain_unregister(&x86_mce_decoder_chain, nb);
-}
-EXPORT_SYMBOL_GPL(mce_unregister_decode_chain);
-
 static inline u32 ctl_reg(int bank)
 {
 	return MSR_IA32_MCx_CTL(bank);
@@ -606,18 +576,19 @@ static struct notifier_block mce_uc_nb = {
 	.priority	= MCE_PRIO_UC,
 };
 
+/*
+ * We run the default notifier as long as we have no external
+ * notifiers registered on the chain.
+ */
+static atomic_t num_notifiers;
+
 static int mce_default_notifier(struct notifier_block *nb, unsigned long val,
 				void *data)
 {
 	struct mce *m = (struct mce *)data;
 
-	if (!m)
-		return NOTIFY_DONE;
-
-	if (atomic_read(&num_notifiers))
-		return NOTIFY_DONE;
-
-	__print_mce(m);
+	if (m)
+		__print_mce(m);
 
 	return NOTIFY_DONE;
 }
@@ -628,6 +599,49 @@ static struct notifier_block mce_default_nb = {
 	.priority	= MCE_PRIO_LOWEST,
 };
 
+static void update_default_notifier_registration(void)
+{
+	bool has_notifiers = !!atomic_read(&num_notifiers);
+
+retry:
+	if (has_notifiers)
+		blocking_notifier_chain_unregister(&x86_mce_decoder_chain,
+						   &mce_default_nb);
+	else
+		blocking_notifier_chain_cond_register(&x86_mce_decoder_chain,
+						      &mce_default_nb);
+
+	if (has_notifiers != !!atomic_read(&num_notifiers)) {
+		has_notifiers = !has_notifiers;
+		goto retry;
+	}
+}
+
+static void mce_register_decode_chain_internal(struct notifier_block *nb)
+{
+	if (WARN_ON(nb->priority > MCE_PRIO_MCELOG &&
+		    nb->priority < MCE_PRIO_EDAC))
+		return;
+
+	blocking_notifier_chain_register(&x86_mce_decoder_chain, nb);
+}
+
+void mce_register_decode_chain(struct notifier_block *nb)
+{
+	atomic_inc(&num_notifiers);
+	mce_register_decode_chain_internal(nb);
+	update_default_notifier_registration();
+}
+EXPORT_SYMBOL_GPL(mce_register_decode_chain);
+
+void mce_unregister_decode_chain(struct notifier_block *nb)
+{
+	atomic_dec(&num_notifiers);
+	update_default_notifier_registration();
+	blocking_notifier_chain_unregister(&x86_mce_decoder_chain, nb);
+}
+EXPORT_SYMBOL_GPL(mce_unregister_decode_chain);
+
 /*
  * Read ADDR and MISC registers.
  */
@@ -1972,7 +1986,7 @@ int __init mcheck_init(void)
 	mce_register_decode_chain_internal(&first_nb);
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
 		mce_register_decode_chain_internal(&mce_uc_nb);
-	mce_register_decode_chain_internal(&mce_default_nb);
+	update_default_notifier_registration();
 	mcheck_vendor_init_severity();
 
 	INIT_WORK(&mce_work, mce_gen_pool_process);
-- 
2.22.0.3.gb49bb57c8208.dirty

