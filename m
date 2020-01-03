Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 399A312F980
	for <lists+linux-edac@lfdr.de>; Fri,  3 Jan 2020 16:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgACPHp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 3 Jan 2020 10:07:45 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:2000 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbgACPHp (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 3 Jan 2020 10:07:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1578064064; x=1609600064;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iHsaaNSb6QuBd5deQsg49o2tayu5boXDGXFCOP8fQzk=;
  b=Fk6TLzpdu7D3QWekW6/8JbQ6qiy+I3Y6wm0Z5KU9X3bJN7+e5Bvmpzd4
   gvv5igoUd90w7nxGRwyacv26BSllz8JX2AjHwqJ0DEc/y9g7tVWmbyD5Z
   LFpdKN/GMUSxnKnQS/kzBNSEOxovQBzH29rqGT2mqzaVKb6gHcC3hF5qe
   A=;
IronPort-SDR: dzSxum0Eg4ym7IdAnqI5ApmAWoDS4hbW1dA4MiC2R/lbhYUFwc/P4ZlINqPgjvjg++vg67PfRM
 Hl3Us7UKpoPg==
X-IronPort-AV: E=Sophos;i="5.69,390,1571702400"; 
   d="scan'208";a="10829622"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-27fb8269.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 03 Jan 2020 15:07:44 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1e-27fb8269.us-east-1.amazon.com (Postfix) with ESMTPS id A32F0A1C46;
        Fri,  3 Jan 2020 15:07:40 +0000 (UTC)
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id 003F7coI020473
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Jan 2020 16:07:38 +0100
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id 003F7cqx020472;
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
Subject: [PATCH v2 4/6] x86/mce: Allow a variable number of internal MCE decode notifiers
Date:   Fri,  3 Jan 2020 16:07:20 +0100
Message-Id: <20200103150722.20313-5-jschoenh@amazon.de>
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

Get rid of the compile time constant of internal (or mandatory)
MCE decode notifiers in preparation for future changes. Instead,
distinguish explicitly between internal and external MCE decode
notifiers.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
New in v2, preparation for patches 5 and 6.
---
 arch/x86/kernel/cpu/mce/core.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 1d91ce956772..d48deb127071 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -157,21 +157,24 @@ void mce_log(struct mce *m)
 EXPORT_SYMBOL_GPL(mce_log);
 
 /*
- * We run the default notifier if we have only the UC, the first and the
- * default notifier registered. I.e., the mandatory NUM_DEFAULT_NOTIFIERS
+ * We run the default notifier as long as we have no external
  * notifiers registered on the chain.
  */
-#define NUM_DEFAULT_NOTIFIERS	3
 static atomic_t num_notifiers;
 
-void mce_register_decode_chain(struct notifier_block *nb)
+static void mce_register_decode_chain_internal(struct notifier_block *nb)
 {
 	if (WARN_ON(nb->priority > MCE_PRIO_MCELOG && nb->priority < MCE_PRIO_EDAC))
 		return;
 
+	blocking_notifier_chain_register(&x86_mce_decoder_chain, nb);
+}
+
+void mce_register_decode_chain(struct notifier_block *nb)
+{
 	atomic_inc(&num_notifiers);
 
-	blocking_notifier_chain_register(&x86_mce_decoder_chain, nb);
+	mce_register_decode_chain_internal(nb);
 }
 EXPORT_SYMBOL_GPL(mce_register_decode_chain);
 
@@ -611,7 +614,7 @@ static int mce_default_notifier(struct notifier_block *nb, unsigned long val,
 	if (!m)
 		return NOTIFY_DONE;
 
-	if (atomic_read(&num_notifiers) > NUM_DEFAULT_NOTIFIERS)
+	if (atomic_read(&num_notifiers))
 		return NOTIFY_DONE;
 
 	__print_mce(m);
@@ -1966,9 +1969,9 @@ __setup("mce", mcheck_enable);
 int __init mcheck_init(void)
 {
 	mcheck_intel_therm_init();
-	mce_register_decode_chain(&first_nb);
-	mce_register_decode_chain(&mce_uc_nb);
-	mce_register_decode_chain(&mce_default_nb);
+	mce_register_decode_chain_internal(&first_nb);
+	mce_register_decode_chain_internal(&mce_uc_nb);
+	mce_register_decode_chain_internal(&mce_default_nb);
 	mcheck_vendor_init_severity();
 
 	INIT_WORK(&mce_work, mce_gen_pool_process);
-- 
2.22.0.3.gb49bb57c8208.dirty

