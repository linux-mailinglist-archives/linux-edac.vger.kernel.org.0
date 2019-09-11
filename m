Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83B8EB0014
	for <lists+linux-edac@lfdr.de>; Wed, 11 Sep 2019 17:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbfIKPbO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 11 Sep 2019 11:31:14 -0400
Received: from m12-18.163.com ([220.181.12.18]:47958 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727656AbfIKPbO (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 11 Sep 2019 11:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=G+zk1J2IeHPBI7vEM3
        ZYnSQJc0NEwQOO4SkgHULEzpM=; b=gdj6GJk1pqksz1xwT8ns1iumQEgMoBYtyb
        FQXO4Y3OCFu8qs4pBSu4LWyfXhdKs0vV3+ieHJyLMB9NGRL2g6y+foHSYHo6wnm2
        q6yP7MW5imqvW6hEkG9uT16oqCQa7WSenaLRKk0FBOyx9xFJRVp93NrTK3efi3Ni
        AhOblsqr0=
Received: from localhost.localdomain.localdomain (unknown [115.238.229.131])
        by smtp14 (Coremail) with SMTP id EsCowADX8de0Enld18mCMg--.48550S2;
        Wed, 11 Sep 2019 23:28:54 +0800 (CST)
From:   Xiaochun Lee <lixiaochun.2888@163.com>
To:     tony.luck@intel.com, bp@alien8.de
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, lixiaochun.2888@163.com,
        Xiaochun Lee <lixc17@lenovo.com>
Subject: [PATCH] x86/mce: add a switch of CONFIG_X86_MCELOG_LEGACY
Date:   Wed, 11 Sep 2019 23:28:50 +0800
Message-Id: <1568215730-11471-1-git-send-email-lixiaochun.2888@163.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: EsCowADX8de0Enld18mCMg--.48550S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr1fXw4DWr1UCw1DtFy8AFb_yoW8WrWkp3
        ySka95GFWrur4UJayj9r4kW343WryvgrW2qw48C348t3s8J3s7GFZ7Gay2qa48Z3s5Gr4F
        yan8XFW3Z3yxCaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jCeHDUUUUU=
X-Originating-IP: [115.238.229.131]
X-CM-SenderInfo: 5ol0xtprfk30aosymmi6rwjhhfrp/1tbiQBYtQFSIcWyXNQAAsY
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Xiaochun Lee <lixc17@lenovo.com>

Add CONFIG_X86_MCELOG_LEGACY to control the
behavior of several functions be compiled.

Signed-off-by: Xiaochun Lee <lixc17@lenovo.com>
---
 arch/x86/kernel/cpu/mce/dev-mcelog.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c b/arch/x86/kernel/cpu/mce/dev-mcelog.c
index 7c8958d..6add0ce 100644
--- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
+++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
@@ -82,7 +82,7 @@ static void mce_do_trigger(struct work_struct *work)
 
 static DECLARE_WORK(mce_trigger_work, mce_do_trigger);
 
-
+#ifdef CONFIG_X86_MCELOG_LEGACY
 void mce_work_trigger(void)
 {
 	if (mce_helper[0])
@@ -113,6 +113,7 @@ static ssize_t set_trigger(struct device *s, struct device_attribute *attr,
 }
 
 DEVICE_ATTR(trigger, 0644, show_trigger, set_trigger);
+#endif
 
 /*
  * mce_chrdev: Character device /dev/mcelog to read and clear the MCE log.
@@ -276,6 +277,7 @@ static long mce_chrdev_ioctl(struct file *f, unsigned int cmd,
 	}
 }
 
+#ifdef CONFIG_X86_MCELOG_LEGACY
 void mce_register_injector_chain(struct notifier_block *nb)
 {
 	blocking_notifier_chain_register(&mce_injector_chain, nb);
@@ -287,6 +289,7 @@ void mce_unregister_injector_chain(struct notifier_block *nb)
 	blocking_notifier_chain_unregister(&mce_injector_chain, nb);
 }
 EXPORT_SYMBOL_GPL(mce_unregister_injector_chain);
+#endif
 
 static ssize_t mce_chrdev_write(struct file *filp, const char __user *ubuf,
 				size_t usize, loff_t *off)
-- 
1.8.3.1


