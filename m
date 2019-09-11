Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F38DAFD96
	for <lists+linux-edac@lfdr.de>; Wed, 11 Sep 2019 15:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfIKNSo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 11 Sep 2019 09:18:44 -0400
Received: from m12-17.163.com ([220.181.12.17]:60873 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbfIKNSo (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 11 Sep 2019 09:18:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=4eKBAeEwoeMZVkuUtS
        L8Uoxj5VbgjI3K62DMyA7tptc=; b=LsCuQBXnCwLJkzHYucP87Lm2ZFqjEqCiAb
        geJUOFONS350eWCvYfqXDeerGodM3tIIuveJL2ChgPf2CYSfrVEBO1A8AEODvdlG
        8whB5QYklTHaQAbTg6LtBBY+/0sGjn/EuLbtZta9tobtKcHyFxloTjhwKnw6xI0L
        OZYjABmRo=
Received: from localhost.localdomain.localdomain (unknown [115.238.229.131])
        by smtp13 (Coremail) with SMTP id EcCowAAHN+jy83hdTZmkLw--.510S2;
        Wed, 11 Sep 2019 21:17:40 +0800 (CST)
From:   Xiaochun Lee <lixiaochun.2888@163.com>
To:     tony.luck@intel.com, bp@alien8.de
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, lixiaochun.2888@163.com,
        Xiaochun Lee <lixc17@lenovo.com>
Subject: [PATCH V2] x86/mce: set cmci_disabled unmodifiable in FF mode
Date:   Wed, 11 Sep 2019 21:17:25 +0800
Message-Id: <1568207845-9393-1-git-send-email-lixiaochun.2888@163.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: EcCowAAHN+jy83hdTZmkLw--.510S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF1xAFy3GF1rur4DAF1UKFg_yoW5WFW7pr
        Zruw48tF48uFy5Kas8Cr1ku3W5Xry5C3s3G3WUG3WrJ3W5J34Sqr4kZw1fXFyUur95WF1S
        9r1qqF1Iyw4xJFJanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jikuxUUUUU=
X-Originating-IP: [115.238.229.131]
X-CM-SenderInfo: 5ol0xtprfk30aosymmi6rwjhhfrp/1tbiDhQtQFXltpUY8wAAsP
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Xiaochun Lee <lixc17@lenovo.com>

When enabled Firmware First mode in UEFI and
all banks are Machine Check Bank, then to make
it non-modifiable so that it can't be reenable
from sysfs again.

Signed-off-by: Xiaochun Lee <lixc17@lenovo.com>
---
 arch/x86/kernel/cpu/mce/core.c     |  4 ++--
 arch/x86/kernel/cpu/mce/intel.c    | 15 ++++++++++++++-
 arch/x86/kernel/cpu/mce/internal.h |  1 +
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 743370e..cee4d70 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2164,7 +2164,7 @@ static ssize_t set_ignore_ce(struct device *s,
 			mce_timer_delete_all();
 			on_each_cpu(mce_disable_cmci, NULL, 1);
 			mca_cfg.ignore_ce = true;
-		} else {
+		} else if (!mca_cfg.allbanks_is_mcbank) {
 			/* enable ce features */
 			mca_cfg.ignore_ce = false;
 			on_each_cpu(mce_enable_ce, (void *)1, 1);
@@ -2190,7 +2190,7 @@ static ssize_t set_cmci_disabled(struct device *s,
 			/* disable cmci */
 			on_each_cpu(mce_disable_cmci, NULL, 1);
 			mca_cfg.cmci_disabled = true;
-		} else {
+		} else if (!mca_cfg.allbanks_is_mcbank) {
 			/* enable cmci */
 			mca_cfg.cmci_disabled = false;
 			on_each_cpu(mce_enable_ce, NULL, 1);
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index e43eb67..e15b573 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -267,6 +267,7 @@ static void cmci_discover(int banks)
 	unsigned long flags;
 	int i;
 	int bios_wrong_thresh = 0;
+	unsigned int mce_bank_count = 0;
 
 	raw_spin_lock_irqsave(&cmci_discover_lock, flags);
 	for (i = 0; i < banks; i++) {
@@ -277,8 +278,10 @@ static void cmci_discover(int banks)
 			continue;
 
 		/* Skip banks in firmware first mode */
-		if (test_bit(i, mce_banks_ce_disabled))
+		if (test_bit(i, mce_banks_ce_disabled)) {
+			mce_bank_count++;
 			continue;
+		}
 
 		rdmsrl(MSR_IA32_MCx_CTL2(i), val);
 
@@ -330,6 +333,16 @@ static void cmci_discover(int banks)
 		pr_info_once(
 			"bios_cmci_threshold: Make sure your BIOS supports this boot option\n");
 	}
+	/*
+	 * After the loop exit, if the mce_bank_count
+	 * equal to the banks, it illustrate all the
+	 * banks are belong to the list of Machine
+	 * Check Bank, so here set sysfs interface
+	 * no-modifiable in FF mode.
+	 */
+	if (banks == mce_bank_count)
+		mca_cfg.allbanks_is_mcbank = true;
+
 }
 
 /*
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 43031db..7949c01 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -110,6 +110,7 @@ struct mca_config {
 	bool dont_log_ce;
 	bool cmci_disabled;
 	bool ignore_ce;
+	bool allbanks_is_mcbank;
 
 	__u64 lmce_disabled		: 1,
 	      disabled			: 1,
-- 
1.8.3.1


