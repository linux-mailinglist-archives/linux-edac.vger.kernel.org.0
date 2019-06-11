Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A77E3D222
	for <lists+linux-edac@lfdr.de>; Tue, 11 Jun 2019 18:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403932AbfFKQXr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 11 Jun 2019 12:23:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46235 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403829AbfFKQXr (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 11 Jun 2019 12:23:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5BGMtBI279192
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 11 Jun 2019 09:22:55 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5BGMtBI279192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560270175;
        bh=rt2bLxwFtIF8EjLn/YQ9s71qq3Li0G9Z8fIlpxOtgxQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Cxg3JkB075vbodttiPFzYRiO81AgUIxcG+bF0A4in96uex2v093F87L5blBSoa51P
         vzJfKWOn5hMt7AiGA5rEA9q5WjfGhj3kge7m+x2qzVIjr/WX8hGbVlUHO6TUOB6gmy
         qtDfHjbKUo1+1u4XAqA4+BMggyWQs2+I2+m1+if+bnHaUrgoL1JnfmNyWOw2iJ+T+2
         SCMM00NuDMarccsKXwars17/aAmAk0zSPO6ZI0FSeurg9lrojKlLzpfeNeNrKFcYPP
         ril6Etb1MtG/h8qq+LAJzYezjRgWNCd3qGgpM8yPMVmZfVrrd3D0L+4IJ7yCwGfdzy
         gGZMeseh7ZWeA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5BGMsvl279189;
        Tue, 11 Jun 2019 09:22:54 -0700
Date:   Tue, 11 Jun 2019 09:22:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yazen Ghannam <tipbot@zytor.com>
Message-ID: <tip-95fdce6b24f3526c2bd1aad15978d238b79da6bd@git.kernel.org>
Cc:     linux-edac@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
        tony.luck@intel.com, mingo@redhat.com, tglx@linutronix.de,
        x86@kernel.org, bp@suse.de, linux-kernel@vger.kernel.org,
        yazen.ghannam@amd.com
Reply-To: x86@kernel.org, bp@suse.de, linux-kernel@vger.kernel.org,
          yazen.ghannam@amd.com, tglx@linutronix.de, mingo@redhat.com,
          linux-edac@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
          tony.luck@intel.com
In-Reply-To: <20190607201752.221446-2-Yazen.Ghannam@amd.com>
References: <20190607201752.221446-2-Yazen.Ghannam@amd.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/MCE: Make struct mce_banks[] static
Git-Commit-ID: 95fdce6b24f3526c2bd1aad15978d238b79da6bd
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Commit-ID:  95fdce6b24f3526c2bd1aad15978d238b79da6bd
Gitweb:     https://git.kernel.org/tip/95fdce6b24f3526c2bd1aad15978d238b79da6bd
Author:     Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate: Fri, 7 Jun 2019 20:18:03 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Tue, 11 Jun 2019 15:13:51 +0200

x86/MCE: Make struct mce_banks[] static

The struct mce_banks[] array is only used in mce/core.c so move its
definition there and make it static. Also, change the "init" field to
bool type.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: "x86@kernel.org" <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190607201752.221446-2-Yazen.Ghannam@amd.com
---
 arch/x86/kernel/cpu/mce/core.c     | 11 ++++++++++-
 arch/x86/kernel/cpu/mce/internal.h | 10 ----------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 282916f3b8d8..55bdbedde0b8 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -65,7 +65,16 @@ static DEFINE_MUTEX(mce_sysfs_mutex);
 
 DEFINE_PER_CPU(unsigned, mce_exception_count);
 
-struct mce_bank *mce_banks __read_mostly;
+#define ATTR_LEN               16
+/* One object for each MCE bank, shared by all CPUs */
+struct mce_bank {
+	u64			ctl;			/* subevents to enable */
+	bool			init;			/* initialise bank? */
+	struct device_attribute	attr;			/* device attribute */
+	char			attrname[ATTR_LEN];	/* attribute name */
+};
+
+static struct mce_bank *mce_banks __read_mostly;
 struct mce_vendor_flags mce_flags __read_mostly;
 
 struct mca_config mca_cfg __read_mostly = {
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index a34b55baa7aa..35b3e5c02c1c 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -22,17 +22,8 @@ enum severity_level {
 
 extern struct blocking_notifier_head x86_mce_decoder_chain;
 
-#define ATTR_LEN		16
 #define INITIAL_CHECK_INTERVAL	5 * 60 /* 5 minutes */
 
-/* One object for each MCE bank, shared by all CPUs */
-struct mce_bank {
-	u64			ctl;			/* subevents to enable */
-	unsigned char init;				/* initialise bank? */
-	struct device_attribute attr;			/* device attribute */
-	char			attrname[ATTR_LEN];	/* attribute name */
-};
-
 struct mce_evt_llist {
 	struct llist_node llnode;
 	struct mce mce;
@@ -47,7 +38,6 @@ struct llist_node *mce_gen_pool_prepare_records(void);
 extern int (*mce_severity)(struct mce *a, int tolerant, char **msg, bool is_excp);
 struct dentry *mce_get_debugfs_dir(void);
 
-extern struct mce_bank *mce_banks;
 extern mce_banks_t mce_banks_ce_disabled;
 
 #ifdef CONFIG_X86_MCE_INTEL
