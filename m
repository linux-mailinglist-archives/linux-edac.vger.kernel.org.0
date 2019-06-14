Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B59746092
	for <lists+linux-edac@lfdr.de>; Fri, 14 Jun 2019 16:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfFNOXM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 14 Jun 2019 10:23:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34709 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbfFNOXM (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 14 Jun 2019 10:23:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5EEM7KK1728286
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 14 Jun 2019 07:22:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5EEM7KK1728286
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560522128;
        bh=JAKCTuiVrZTQewej6UvSkL18qrJJw5+v+R9FxjGeUZs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=NuIH9kzGosb6134SUWyP6ybZAWd6sapHJ7iY8seT70pcxq89JCc2Ib+IdRvJ8Uysa
         lsz2tpF9VgRKXGXKnh7xMfR9PVOJGrJKG7aKrlR0MiR2E7w1LIwhKh6Y9Tb0BYkPGz
         /wZPMjLtUtvJnIhYxR3sF+2jqSSI+H+mt4lYwQvPsbx34jsZkIssO60QY0KG12eM1W
         mpKfkpPiGsZrMG3hcZ4WuUQUqDujMGwPfkh/1F9UhGVoEGvjMd2XNhBAHw53ZSgGq+
         rApqe00WtfD781w+v6WkFzHC9bm66+Axz8jGM9ynQQ/JQse4G4Cnh2G2XtXWm69Jfz
         KxlbAC7vyzn4A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5EEM6xe1728277;
        Fri, 14 Jun 2019 07:22:06 -0700
Date:   Fri, 14 Jun 2019 07:22:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Greg Kroah-Hartman <tipbot@zytor.com>
Message-ID: <tip-6e4f929ea8b2097b0052f6674de839a3c9d477e9@git.kernel.org>
Cc:     tglx@linutronix.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        tony.luck@intel.com, hpa@zytor.com, bp@suse.de, mingo@redhat.com,
        x86@kernel.org, mingo@kernel.org
Reply-To: bp@suse.de, linux-edac@vger.kernel.org, tony.luck@intel.com,
          hpa@zytor.com, x86@kernel.org, mingo@redhat.com,
          mingo@kernel.org, gregkh@linuxfoundation.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <20190612151531.GA16278@kroah.com>
References: <20190612151531.GA16278@kroah.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/mce: Do not check return value of debugfs_create
 functions
Git-Commit-ID: 6e4f929ea8b2097b0052f6674de839a3c9d477e9
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-3.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        T_DATE_IN_FUTURE_96_Q autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Commit-ID:  6e4f929ea8b2097b0052f6674de839a3c9d477e9
Gitweb:     https://git.kernel.org/tip/6e4f929ea8b2097b0052f6674de839a3c9d477e9
Author:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
AuthorDate: Wed, 12 Jun 2019 17:15:31 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Fri, 14 Jun 2019 16:04:21 +0200

x86/mce: Do not check return value of debugfs_create functions

When calling debugfs functions, there is no need to ever check the
return value. The function can work or not, but the code logic should
never do something different based on this.

The only way this can fail is if:

 * debugfs superblock can not be pinned - something really went wrong with the
 vfs layer.
 * file is created with same name - the caller's fault.
 * new_inode() fails - happens if memory is exhausted.

so failing to clean up debugfs properly is the least of the system's
sproblems in uch a situation.

 [ bp: Extend commit message, remove unused err var in inject_init(). ]

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190612151531.GA16278@kroah.com
---
 arch/x86/kernel/cpu/mce/core.c     | 16 +++++-----------
 arch/x86/kernel/cpu/mce/inject.c   | 37 +++++--------------------------------
 arch/x86/kernel/cpu/mce/severity.c | 14 +++-----------
 3 files changed, 13 insertions(+), 54 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index c2c93e9195ed..066562a1ea20 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2516,22 +2516,16 @@ static int fake_panic_set(void *data, u64 val)
 DEFINE_DEBUGFS_ATTRIBUTE(fake_panic_fops, fake_panic_get, fake_panic_set,
 			 "%llu\n");
 
-static int __init mcheck_debugfs_init(void)
+static void __init mcheck_debugfs_init(void)
 {
-	struct dentry *dmce, *ffake_panic;
+	struct dentry *dmce;
 
 	dmce = mce_get_debugfs_dir();
-	if (!dmce)
-		return -ENOMEM;
-	ffake_panic = debugfs_create_file_unsafe("fake_panic", 0444, dmce,
-						 NULL, &fake_panic_fops);
-	if (!ffake_panic)
-		return -ENOMEM;
-
-	return 0;
+	debugfs_create_file_unsafe("fake_panic", 0444, dmce, NULL,
+				   &fake_panic_fops);
 }
 #else
-static int __init mcheck_debugfs_init(void) { return -EINVAL; }
+static void __init mcheck_debugfs_init(void) { }
 #endif
 
 DEFINE_STATIC_KEY_FALSE(mcsafe_key);
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 5d108f70f315..1f30117b24ba 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -645,7 +645,6 @@ static const struct file_operations readme_fops = {
 
 static struct dfs_node {
 	char *name;
-	struct dentry *d;
 	const struct file_operations *fops;
 	umode_t perm;
 } dfs_fls[] = {
@@ -659,49 +658,23 @@ static struct dfs_node {
 	{ .name = "README",	.fops = &readme_fops, .perm = S_IRUSR | S_IRGRP | S_IROTH },
 };
 
-static int __init debugfs_init(void)
+static void __init debugfs_init(void)
 {
 	unsigned int i;
 
 	dfs_inj = debugfs_create_dir("mce-inject", NULL);
-	if (!dfs_inj)
-		return -EINVAL;
-
-	for (i = 0; i < ARRAY_SIZE(dfs_fls); i++) {
-		dfs_fls[i].d = debugfs_create_file(dfs_fls[i].name,
-						    dfs_fls[i].perm,
-						    dfs_inj,
-						    &i_mce,
-						    dfs_fls[i].fops);
-
-		if (!dfs_fls[i].d)
-			goto err_dfs_add;
-	}
-
-	return 0;
-
-err_dfs_add:
-	while (i-- > 0)
-		debugfs_remove(dfs_fls[i].d);
 
-	debugfs_remove(dfs_inj);
-	dfs_inj = NULL;
-
-	return -ENODEV;
+	for (i = 0; i < ARRAY_SIZE(dfs_fls); i++)
+		debugfs_create_file(dfs_fls[i].name, dfs_fls[i].perm, dfs_inj,
+				    &i_mce, dfs_fls[i].fops);
 }
 
 static int __init inject_init(void)
 {
-	int err;
-
 	if (!alloc_cpumask_var(&mce_inject_cpumask, GFP_KERNEL))
 		return -ENOMEM;
 
-	err = debugfs_init();
-	if (err) {
-		free_cpumask_var(mce_inject_cpumask);
-		return err;
-	}
+	debugfs_init();
 
 	register_nmi_handler(NMI_LOCAL, mce_raise_notify, 0, "mce_notify");
 	mce_register_injector_chain(&inject_nb);
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 65201e180fe0..27fd6816e270 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -404,21 +404,13 @@ static const struct file_operations severities_coverage_fops = {
 
 static int __init severities_debugfs_init(void)
 {
-	struct dentry *dmce, *fsev;
+	struct dentry *dmce;
 
 	dmce = mce_get_debugfs_dir();
-	if (!dmce)
-		goto err_out;
-
-	fsev = debugfs_create_file("severities-coverage", 0444, dmce, NULL,
-				   &severities_coverage_fops);
-	if (!fsev)
-		goto err_out;
 
+	debugfs_create_file("severities-coverage", 0444, dmce, NULL,
+			    &severities_coverage_fops);
 	return 0;
-
-err_out:
-	return -ENOMEM;
 }
 late_initcall(severities_debugfs_init);
 #endif /* CONFIG_DEBUG_FS */
