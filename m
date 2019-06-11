Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDEB3D226
	for <lists+linux-edac@lfdr.de>; Tue, 11 Jun 2019 18:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391573AbfFKQYT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 11 Jun 2019 12:24:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55235 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391563AbfFKQYT (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 11 Jun 2019 12:24:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5BGNfrX279284
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 11 Jun 2019 09:23:41 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5BGNfrX279284
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560270222;
        bh=ijaLVibtRYCxoxKMvEDdKtWNBE+t67OqTsylEjwrMqc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Vcdom3E/WZVFcPysVy09S1Rq5yFBa9MEXSw6wAMNS84RRB5cE/atdwaYtMGtQBANT
         oqdGtmySnqP20/r116p27A0sCSTVoJ845BfgItC+p/RmB1vTcx3t3cTzDd7UhnFnXz
         E9knFvW1P05SmiIkg2rPaYZnD8OH5XUd8m/Qgi1gvocUE3KDjSc7Q2EnRhJ7pLQDHV
         aUw/fH36vvFk9kPJAR4XMtu9kR8J8IWzqczV5AA67i22xwWaQaLruZblVJxHmPO6V8
         7QCfeM1xg9Xz9y0BnMb7bfPNnrIZmAUkwG9CFKQOeZuaosc/yv3P89sgKQ89dFLiaH
         xlF/r4EJMJCxg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5BGNe0V279281;
        Tue, 11 Jun 2019 09:23:40 -0700
Date:   Tue, 11 Jun 2019 09:23:40 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yazen Ghannam <tipbot@zytor.com>
Message-ID: <tip-b4914508f1fe0eca1cd011b6026ff762a1aa62d5@git.kernel.org>
Cc:     rong.a.chen@intel.com, x86@kernel.org, linux-edac@vger.kernel.org,
        bp@suse.de, hpa@zytor.com, tglx@linutronix.de,
        yazen.ghannam@amd.com, tony.luck@intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com
Reply-To: x86@kernel.org, rong.a.chen@intel.com,
          linux-edac@vger.kernel.org, bp@suse.de, hpa@zytor.com,
          yazen.ghannam@amd.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, mingo@redhat.com,
          tony.luck@intel.com, mingo@kernel.org
In-Reply-To: <20190607201752.221446-3-Yazen.Ghannam@amd.com>
References: <20190607201752.221446-3-Yazen.Ghannam@amd.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/MCE: Make mce_banks a per-CPU array
Git-Commit-ID: b4914508f1fe0eca1cd011b6026ff762a1aa62d5
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

Commit-ID:  b4914508f1fe0eca1cd011b6026ff762a1aa62d5
Gitweb:     https://git.kernel.org/tip/b4914508f1fe0eca1cd011b6026ff762a1aa62d5
Author:     Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate: Fri, 7 Jun 2019 20:18:04 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Tue, 11 Jun 2019 15:22:13 +0200

x86/MCE: Make mce_banks a per-CPU array

Current AMD systems have unique MCA banks per logical CPU even though
the type of the banks may all align to the same bank number. Each CPU
will have control of a set of MCA banks in the hardware and these are
not shared with other CPUs.

For example, bank 0 may be the Load-Store Unit on every logical CPU, but
each bank 0 is a unique structure in the hardware. In other words, there
isn't a *single* Load-Store Unit at MCA bank 0 that all logical CPUs
share.

This idea extends even to non-core MCA banks. For example, CPU0 and CPU4
may see a Unified Memory Controller at bank 15, but each CPU is actually
seeing a unique hardware structure that is not shared with other CPUs.

Because the MCA banks are all unique hardware structures, it would be
good to control them in a more granular way. For example, if there is a
known issue with the Floating Point Unit on CPU5 and a user wishes to
disable an error type on the Floating Point Unit, then it would be good
to do this only for CPU5 rather than all CPUs.

Also, future AMD systems may have heterogeneous MCA banks. Meaning
the bank numbers may not necessarily represent the same types between
CPUs. For example, bank 20 visible to CPU0 may be a Unified Memory
Controller and bank 20 visible to CPU4 may be a Coherent Slave. So
granular control will be even more necessary should the user wish to
control specific MCA banks.

Split the device attributes from struct mce_bank leaving only the MCA
bank control fields.

Make struct mce_banks[] per_cpu in order to have more granular control
over individual MCA banks in the hardware.

Allocate the device attributes statically based on the maximum number of
MCA banks supported. The sysfs interface will use as many as needed per
CPU. Currently, this is set to mca_cfg.banks, but will be changed to a
per_cpu bank count in a future patch.

Allocate the MCA control bits statically. This is in order to avoid
locking warnings when memory is allocated during secondary CPUs' init
sequences.

Also, remove the now unnecessary return values from
__mcheck_cpu_mce_banks_init() and __mcheck_cpu_cap_init().

Redo the sysfs store/show functions to handle the per_cpu mce_banks[].

 [ bp: s/mce_banks_percpu/mce_banks_array/g ]

[ Locking issue reported by ]
Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: "x86@kernel.org" <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190607201752.221446-3-Yazen.Ghannam@amd.com
---
 arch/x86/kernel/cpu/mce/core.c | 76 ++++++++++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 55bdbedde0b8..49fac95d036b 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -65,16 +65,21 @@ static DEFINE_MUTEX(mce_sysfs_mutex);
 
 DEFINE_PER_CPU(unsigned, mce_exception_count);
 
-#define ATTR_LEN               16
-/* One object for each MCE bank, shared by all CPUs */
 struct mce_bank {
 	u64			ctl;			/* subevents to enable */
 	bool			init;			/* initialise bank? */
+};
+static DEFINE_PER_CPU_READ_MOSTLY(struct mce_bank[MAX_NR_BANKS], mce_banks_array);
+
+#define ATTR_LEN               16
+/* One object for each MCE bank, shared by all CPUs */
+struct mce_bank_dev {
 	struct device_attribute	attr;			/* device attribute */
 	char			attrname[ATTR_LEN];	/* attribute name */
+	u8			bank;			/* bank number */
 };
+static struct mce_bank_dev mce_bank_devs[MAX_NR_BANKS];
 
-static struct mce_bank *mce_banks __read_mostly;
 struct mce_vendor_flags mce_flags __read_mostly;
 
 struct mca_config mca_cfg __read_mostly = {
@@ -684,6 +689,7 @@ DEFINE_PER_CPU(unsigned, mce_poll_count);
  */
 bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 {
+	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
 	bool error_seen = false;
 	struct mce m;
 	int i;
@@ -1131,6 +1137,7 @@ static void __mc_scan_banks(struct mce *m, struct mce *final,
 			    unsigned long *toclear, unsigned long *valid_banks,
 			    int no_way_out, int *worst)
 {
+	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
 	struct mca_config *cfg = &mca_cfg;
 	int severity, i;
 
@@ -1472,27 +1479,23 @@ int mce_notify_irq(void)
 }
 EXPORT_SYMBOL_GPL(mce_notify_irq);
 
-static int __mcheck_cpu_mce_banks_init(void)
+static void __mcheck_cpu_mce_banks_init(void)
 {
+	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
 	int i;
 
-	mce_banks = kcalloc(MAX_NR_BANKS, sizeof(struct mce_bank), GFP_KERNEL);
-	if (!mce_banks)
-		return -ENOMEM;
-
 	for (i = 0; i < MAX_NR_BANKS; i++) {
 		struct mce_bank *b = &mce_banks[i];
 
 		b->ctl = -1ULL;
 		b->init = 1;
 	}
-	return 0;
 }
 
 /*
  * Initialize Machine Checks for a CPU.
  */
-static int __mcheck_cpu_cap_init(void)
+static void __mcheck_cpu_cap_init(void)
 {
 	u64 cap;
 	u8 b;
@@ -1505,11 +1508,7 @@ static int __mcheck_cpu_cap_init(void)
 
 	mca_cfg.banks = max(mca_cfg.banks, b);
 
-	if (!mce_banks) {
-		int err = __mcheck_cpu_mce_banks_init();
-		if (err)
-			return err;
-	}
+	__mcheck_cpu_mce_banks_init();
 
 	/* Use accurate RIP reporting if available. */
 	if ((cap & MCG_EXT_P) && MCG_EXT_CNT(cap) >= 9)
@@ -1517,8 +1516,6 @@ static int __mcheck_cpu_cap_init(void)
 
 	if (cap & MCG_SER_P)
 		mca_cfg.ser = 1;
-
-	return 0;
 }
 
 static void __mcheck_cpu_init_generic(void)
@@ -1545,6 +1542,7 @@ static void __mcheck_cpu_init_generic(void)
 
 static void __mcheck_cpu_init_clear_banks(void)
 {
+	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
 	int i;
 
 	for (i = 0; i < mca_cfg.banks; i++) {
@@ -1588,6 +1586,7 @@ static void quirk_sandybridge_ifu(int bank, struct mce *m, struct pt_regs *regs)
 /* Add per CPU specific workarounds here */
 static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 {
+	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
 	struct mca_config *cfg = &mca_cfg;
 
 	if (c->x86_vendor == X86_VENDOR_UNKNOWN) {
@@ -1824,7 +1823,9 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
 	if (!mce_available(c))
 		return;
 
-	if (__mcheck_cpu_cap_init() < 0 || __mcheck_cpu_apply_quirks(c) < 0) {
+	__mcheck_cpu_cap_init();
+
+	if (__mcheck_cpu_apply_quirks(c) < 0) {
 		mca_cfg.disabled = 1;
 		return;
 	}
@@ -1958,6 +1959,7 @@ int __init mcheck_init(void)
  */
 static void mce_disable_error_reporting(void)
 {
+	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
 	int i;
 
 	for (i = 0; i < mca_cfg.banks; i++) {
@@ -2060,26 +2062,41 @@ static struct bus_type mce_subsys = {
 
 DEFINE_PER_CPU(struct device *, mce_device);
 
-static inline struct mce_bank *attr_to_bank(struct device_attribute *attr)
+static inline struct mce_bank_dev *attr_to_bank(struct device_attribute *attr)
 {
-	return container_of(attr, struct mce_bank, attr);
+	return container_of(attr, struct mce_bank_dev, attr);
 }
 
 static ssize_t show_bank(struct device *s, struct device_attribute *attr,
 			 char *buf)
 {
-	return sprintf(buf, "%llx\n", attr_to_bank(attr)->ctl);
+	u8 bank = attr_to_bank(attr)->bank;
+	struct mce_bank *b;
+
+	if (bank >= mca_cfg.banks)
+		return -EINVAL;
+
+	b = &per_cpu(mce_banks_array, s->id)[bank];
+
+	return sprintf(buf, "%llx\n", b->ctl);
 }
 
 static ssize_t set_bank(struct device *s, struct device_attribute *attr,
 			const char *buf, size_t size)
 {
+	u8 bank = attr_to_bank(attr)->bank;
+	struct mce_bank *b;
 	u64 new;
 
 	if (kstrtou64(buf, 0, &new) < 0)
 		return -EINVAL;
 
-	attr_to_bank(attr)->ctl = new;
+	if (bank >= mca_cfg.banks)
+		return -EINVAL;
+
+	b = &per_cpu(mce_banks_array, s->id)[bank];
+
+	b->ctl = new;
 	mce_restart();
 
 	return size;
@@ -2194,7 +2211,7 @@ static void mce_device_release(struct device *dev)
 	kfree(dev);
 }
 
-/* Per cpu device init. All of the cpus still share the same ctrl bank: */
+/* Per CPU device init. All of the CPUs still share the same bank device: */
 static int mce_device_create(unsigned int cpu)
 {
 	struct device *dev;
@@ -2227,7 +2244,7 @@ static int mce_device_create(unsigned int cpu)
 			goto error;
 	}
 	for (j = 0; j < mca_cfg.banks; j++) {
-		err = device_create_file(dev, &mce_banks[j].attr);
+		err = device_create_file(dev, &mce_bank_devs[j].attr);
 		if (err)
 			goto error2;
 	}
@@ -2237,7 +2254,7 @@ static int mce_device_create(unsigned int cpu)
 	return 0;
 error2:
 	while (--j >= 0)
-		device_remove_file(dev, &mce_banks[j].attr);
+		device_remove_file(dev, &mce_bank_devs[j].attr);
 error:
 	while (--i >= 0)
 		device_remove_file(dev, mce_device_attrs[i]);
@@ -2259,7 +2276,7 @@ static void mce_device_remove(unsigned int cpu)
 		device_remove_file(dev, mce_device_attrs[i]);
 
 	for (i = 0; i < mca_cfg.banks; i++)
-		device_remove_file(dev, &mce_banks[i].attr);
+		device_remove_file(dev, &mce_bank_devs[i].attr);
 
 	device_unregister(dev);
 	cpumask_clear_cpu(cpu, mce_device_initialized);
@@ -2280,6 +2297,7 @@ static void mce_disable_cpu(void)
 
 static void mce_reenable_cpu(void)
 {
+	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
 	int i;
 
 	if (!mce_available(raw_cpu_ptr(&cpu_info)))
@@ -2337,10 +2355,12 @@ static __init void mce_init_banks(void)
 {
 	int i;
 
-	for (i = 0; i < mca_cfg.banks; i++) {
-		struct mce_bank *b = &mce_banks[i];
+	for (i = 0; i < MAX_NR_BANKS; i++) {
+		struct mce_bank_dev *b = &mce_bank_devs[i];
 		struct device_attribute *a = &b->attr;
 
+		b->bank = i;
+
 		sysfs_attr_init(&a->attr);
 		a->attr.name	= b->attrname;
 		snprintf(b->attrname, ATTR_LEN, "bank%d", i);
