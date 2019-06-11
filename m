Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6E003D232
	for <lists+linux-edac@lfdr.de>; Tue, 11 Jun 2019 18:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388533AbfFKQ0b (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 11 Jun 2019 12:26:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57785 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388316AbfFKQ0a (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 11 Jun 2019 12:26:30 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5BGPxG6281418
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 11 Jun 2019 09:25:59 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5BGPxG6281418
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560270360;
        bh=SS+UICKF/metzs7xe0exeFTrU6MZuDiE1jEE1TzFNTM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=briybXxXjG6Oa3Z+9kIfrmP+3PMFmi5PtN9fStFhCylfmf+lzRBF0uiHU6gEp+enO
         +zvY1uzVRVJK85rUEO5CBrxqOcSiJ2dU+brO9a087Q4a7oo4vpnan+v9GFvc9eDn7U
         fK/DRE1jPAA1yET0dlAc7Rs+PWNRmpeaXlC8htSalkC/DkP1GEXX5PjZNcAavfqyJL
         6WD8m/bp/SwyHlpTRafud/pUC8Mf/ettJne2ZkTFHSdQO9mNwEMu4RYYjSCnEVfcbh
         OQ/5iPtqQfl3D+usZz7y3tWhvSrVtUgtypPiC0XtQ8jb6VsXhc0A5uqLemiendjH+b
         taDeaxeqFwy0g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5BGPwqE281415;
        Tue, 11 Jun 2019 09:25:58 -0700
Date:   Tue, 11 Jun 2019 09:25:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yazen Ghannam <tipbot@zytor.com>
Message-ID: <tip-068b053dca0e2ab40b3d953b102a178654eec282@git.kernel.org>
Cc:     x86@kernel.org, tony.luck@intel.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, yazen.ghannam@amd.com, mingo@kernel.org,
        tglx@linutronix.de, hpa@zytor.com, linux-edac@vger.kernel.org,
        bp@suse.de
Reply-To: tony.luck@intel.com, x86@kernel.org,
          linux-kernel@vger.kernel.org, mingo@redhat.com,
          yazen.ghannam@amd.com, mingo@kernel.org,
          linux-edac@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
          bp@suse.de
In-Reply-To: <20190607201752.221446-6-Yazen.Ghannam@amd.com>
References: <20190607201752.221446-6-Yazen.Ghannam@amd.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/MCE: Determine MCA banks' init state properly
Git-Commit-ID: 068b053dca0e2ab40b3d953b102a178654eec282
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

Commit-ID:  068b053dca0e2ab40b3d953b102a178654eec282
Gitweb:     https://git.kernel.org/tip/068b053dca0e2ab40b3d953b102a178654eec282
Author:     Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate: Fri, 7 Jun 2019 20:18:06 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Tue, 11 Jun 2019 15:23:34 +0200

x86/MCE: Determine MCA banks' init state properly

The OS is expected to write all bits to MCA_CTL for each bank,
thus enabling error reporting in all banks. However, some banks
may be unused in which case the registers for such banks are
Read-as-Zero/Writes-Ignored. Also, the OS may avoid setting some control
bits because of quirks, etc.

A bank can be considered uninitialized if the MCA_CTL register returns
zero. This is because either the OS did not write anything or because
the hardware is enforcing RAZ/WI for the bank.

Set a bank's init value based on if the control bits are set or not in
hardware. Return an error code in the sysfs interface for uninitialized
banks.

Do a final bank init check in a separate function which is not part of
any user-controlled code flows. This is so a user may enable/disable a
bank during runtime without having to restart their system.

 [ bp: Massage a bit. Discover bank init state at boot. ]

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: "x86@kernel.org" <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190607201752.221446-6-Yazen.Ghannam@amd.com
---
 arch/x86/kernel/cpu/mce/core.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 10f9f140985e..c2c93e9195ed 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1490,6 +1490,11 @@ static void __mcheck_cpu_mce_banks_init(void)
 	for (i = 0; i < n_banks; i++) {
 		struct mce_bank *b = &mce_banks[i];
 
+		/*
+		 * Init them all, __mcheck_cpu_apply_quirks() is going to apply
+		 * the required vendor quirks before
+		 * __mcheck_cpu_init_clear_banks() does the final bank setup.
+		 */
 		b->ctl = -1ULL;
 		b->init = 1;
 	}
@@ -1562,6 +1567,33 @@ static void __mcheck_cpu_init_clear_banks(void)
 	}
 }
 
+/*
+ * Do a final check to see if there are any unused/RAZ banks.
+ *
+ * This must be done after the banks have been initialized and any quirks have
+ * been applied.
+ *
+ * Do not call this from any user-initiated flows, e.g. CPU hotplug or sysfs.
+ * Otherwise, a user who disables a bank will not be able to re-enable it
+ * without a system reboot.
+ */
+static void __mcheck_cpu_check_banks(void)
+{
+	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
+	u64 msrval;
+	int i;
+
+	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
+		struct mce_bank *b = &mce_banks[i];
+
+		if (!b->init)
+			continue;
+
+		rdmsrl(msr_ops.ctl(i), msrval);
+		b->init = !!msrval;
+	}
+}
+
 /*
  * During IFU recovery Sandy Bridge -EP4S processors set the RIPV and
  * EIPV bits in MCG_STATUS to zero on the affected logical processor (SDM
@@ -1849,6 +1881,7 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
 	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_vendor(c);
 	__mcheck_cpu_init_clear_banks();
+	__mcheck_cpu_check_banks();
 	__mcheck_cpu_setup_timer();
 }
 
@@ -2085,6 +2118,9 @@ static ssize_t show_bank(struct device *s, struct device_attribute *attr,
 
 	b = &per_cpu(mce_banks_array, s->id)[bank];
 
+	if (!b->init)
+		return -ENODEV;
+
 	return sprintf(buf, "%llx\n", b->ctl);
 }
 
@@ -2103,6 +2139,9 @@ static ssize_t set_bank(struct device *s, struct device_attribute *attr,
 
 	b = &per_cpu(mce_banks_array, s->id)[bank];
 
+	if (!b->init)
+		return -ENODEV;
+
 	b->ctl = new;
 	mce_restart();
 
