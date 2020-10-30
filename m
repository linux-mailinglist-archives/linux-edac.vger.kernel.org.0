Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFC42A0774
	for <lists+linux-edac@lfdr.de>; Fri, 30 Oct 2020 15:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgJ3OIs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 30 Oct 2020 10:08:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:55052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgJ3OIr (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 30 Oct 2020 10:08:47 -0400
Received: from localhost.localdomain (HSI-KBW-46-223-126-90.hsi.kabel-badenwuerttemberg.de [46.223.126.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51DEC206F7;
        Fri, 30 Oct 2020 14:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604066923;
        bh=gVwo9EBasTd5741/ywKxMppouneV4DWFezQFj6Bex30=;
        h=From:To:Cc:Subject:Date:From;
        b=amwa4WWGtNqEMtFTjOayAnVMIGT2+0I8ryTpdaUUhYIGwxkBnRB3hQNLL/O0J2hrA
         Ov42nwGE4vasvA5nJfmNug6iqtaCKWSU/qS6PzumOb3Vzo5YfSXkGZDlcyzT5pPUeK
         s0r1NgHksnHH+J262ok0biKeJJvDQrYHt/MsamYE=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Paolo Bonzini <pbonzini@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-edac@vger.kernel.org,
        kvm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org
Subject: [PATCH] [v3] x86: apic: avoid -Wshadow warning in header
Date:   Fri, 30 Oct 2020 15:06:36 +0100
Message-Id: <20201030140834.852488-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

There are hundreds of warnings in a W=2 build about a local
variable shadowing the global 'apic' definition:

arch/x86/kvm/lapic.h:149:65: warning: declaration of 'apic' shadows a global declaration [-Wshadow]

Avoid this by renaming the global 'apic' variable to the more descriptive
'x86_local_apic'. It was originally called 'genapic', but both that
and the current 'apic' seem to be a little overly generic for a global
variable.

Fixes: c48f14966cc4 ("KVM: inline kvm_apic_present() and kvm_lapic_enabled()")
Fixes: c8d46cf06dc2 ("x86: rename 'genapic' to 'apic'")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v3: rename the global from x86_system_apic to x86_local_apic

v2: rename the global instead of the local variable in the header

This is only tested in an allmodconfig build, after fixing up a
few mistakes in the original search&replace. It's likely that I
missed a few others, but this version should be sufficient to
decide whether this is a good idea in the first place, as well
as if there are better ideas for the new name.
---
 arch/x86/hyperv/hv_apic.c             |  2 ++
 arch/x86/hyperv/hv_spinlock.c         |  4 ++--
 arch/x86/include/asm/apic.h           | 18 +++++++++---------
 arch/x86/kernel/acpi/boot.c           |  2 +-
 arch/x86/kernel/apic/apic.c           | 18 +++++++++---------
 arch/x86/kernel/apic/apic_flat_64.c   |  8 ++++----
 arch/x86/kernel/apic/apic_numachip.c  |  4 ++--
 arch/x86/kernel/apic/bigsmp_32.c      |  2 +-
 arch/x86/kernel/apic/hw_nmi.c         |  2 +-
 arch/x86/kernel/apic/io_apic.c        | 19 ++++++++++---------
 arch/x86/kernel/apic/ipi.c            | 22 +++++++++++-----------
 arch/x86/kernel/apic/msi.c            |  2 +-
 arch/x86/kernel/apic/probe_32.c       | 20 ++++++++++----------
 arch/x86/kernel/apic/probe_64.c       | 12 ++++++------
 arch/x86/kernel/apic/vector.c         |  8 ++++----
 arch/x86/kernel/apic/x2apic_cluster.c |  3 ++-
 arch/x86/kernel/apic/x2apic_phys.c    |  2 +-
 arch/x86/kernel/apic/x2apic_uv_x.c    |  2 +-
 arch/x86/kernel/cpu/common.c          | 14 ++++++++------
 arch/x86/kernel/cpu/mce/inject.c      |  4 ++--
 arch/x86/kernel/cpu/topology.c        |  8 ++++----
 arch/x86/kernel/irq_work.c            |  2 +-
 arch/x86/kernel/kvm.c                 |  6 +++---
 arch/x86/kernel/nmi_selftest.c        |  2 +-
 arch/x86/kernel/smpboot.c             | 20 +++++++++++---------
 arch/x86/kernel/vsmp_64.c             |  2 +-
 arch/x86/kvm/vmx/vmx.c                |  2 +-
 arch/x86/mm/srat.c                    |  2 +-
 arch/x86/platform/uv/uv_irq.c         |  4 ++--
 arch/x86/platform/uv/uv_nmi.c         |  2 +-
 arch/x86/xen/apic.c                   |  8 ++++----
 drivers/iommu/amd/iommu.c             | 10 ++++++----
 drivers/iommu/intel/irq_remapping.c   |  4 ++--
 33 files changed, 125 insertions(+), 115 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index 284e73661a18..9df6ed521048 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -254,6 +254,8 @@ static void hv_send_ipi_self(int vector)
 
 void __init hv_apic_init(void)
 {
+	struct apic *apic = x86_local_apic;
+
 	if (ms_hyperv.hints & HV_X64_CLUSTER_IPI_RECOMMENDED) {
 		pr_info("Hyper-V: Using IPI hypercalls\n");
 		/*
diff --git a/arch/x86/hyperv/hv_spinlock.c b/arch/x86/hyperv/hv_spinlock.c
index f3270c1fc48c..01576e14460e 100644
--- a/arch/x86/hyperv/hv_spinlock.c
+++ b/arch/x86/hyperv/hv_spinlock.c
@@ -20,7 +20,7 @@ static bool __initdata hv_pvspin = true;
 
 static void hv_qlock_kick(int cpu)
 {
-	apic->send_IPI(cpu, X86_PLATFORM_IPI_VECTOR);
+	x86_local_apic->send_IPI(cpu, X86_PLATFORM_IPI_VECTOR);
 }
 
 static void hv_qlock_wait(u8 *byte, u8 val)
@@ -64,7 +64,7 @@ PV_CALLEE_SAVE_REGS_THUNK(hv_vcpu_is_preempted);
 
 void __init hv_init_spinlocks(void)
 {
-	if (!hv_pvspin || !apic ||
+	if (!hv_pvspin || !x86_local_apic ||
 	    !(ms_hyperv.hints & HV_X64_CLUSTER_IPI_RECOMMENDED) ||
 	    !(ms_hyperv.features & HV_MSR_GUEST_IDLE_AVAILABLE)) {
 		pr_info("PV spinlocks disabled\n");
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 4e3099d9ae62..34294fc8f2da 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -361,7 +361,7 @@ struct apic {
  * always just one such driver in use - the kernel decides via an
  * early probing process which one it picks - and then sticks to it):
  */
-extern struct apic *apic;
+extern struct apic *x86_local_apic;
 
 /*
  * APIC drivers are probed based on how they are listed in the .apicdrivers
@@ -395,37 +395,37 @@ extern int lapic_can_unplug_cpu(void);
 
 static inline u32 apic_read(u32 reg)
 {
-	return apic->read(reg);
+	return x86_local_apic->read(reg);
 }
 
 static inline void apic_write(u32 reg, u32 val)
 {
-	apic->write(reg, val);
+	x86_local_apic->write(reg, val);
 }
 
 static inline void apic_eoi(void)
 {
-	apic->eoi_write(APIC_EOI, APIC_EOI_ACK);
+	x86_local_apic->eoi_write(APIC_EOI, APIC_EOI_ACK);
 }
 
 static inline u64 apic_icr_read(void)
 {
-	return apic->icr_read();
+	return x86_local_apic->icr_read();
 }
 
 static inline void apic_icr_write(u32 low, u32 high)
 {
-	apic->icr_write(low, high);
+	x86_local_apic->icr_write(low, high);
 }
 
 static inline void apic_wait_icr_idle(void)
 {
-	apic->wait_icr_idle();
+	x86_local_apic->wait_icr_idle();
 }
 
 static inline u32 safe_apic_wait_icr_idle(void)
 {
-	return apic->safe_wait_icr_idle();
+	return x86_local_apic->safe_wait_icr_idle();
 }
 
 extern void __init apic_set_eoi_write(void (*eoi_write)(u32 reg, u32 v));
@@ -494,7 +494,7 @@ static inline unsigned int read_apic_id(void)
 {
 	unsigned int reg = apic_read(APIC_ID);
 
-	return apic->get_apic_id(reg);
+	return x86_local_apic->get_apic_id(reg);
 }
 
 extern int default_apic_id_valid(u32 apicid);
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 7bdc0239a943..8b7fbfbd86b7 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -211,7 +211,7 @@ acpi_parse_x2apic(union acpi_subtable_headers *header, const unsigned long end)
 	 * to not preallocating memory for all NR_CPUS
 	 * when we use CPU hotplug.
 	 */
-	if (!apic->apic_id_valid(apic_id)) {
+	if (!x86_local_apic->apic_id_valid(apic_id)) {
 		if (enabled)
 			pr_warn(PREFIX "x2apic entry ignored\n");
 		return 0;
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index b3eef1d5c903..8490810451e6 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -241,7 +241,7 @@ static int modern_apic(void)
 static void __init apic_disable(void)
 {
 	pr_info("APIC: switched to apic NOOP\n");
-	apic = &apic_noop;
+	x86_local_apic = &apic_noop;
 }
 
 void native_apic_wait_icr_idle(void)
@@ -519,7 +519,7 @@ static int lapic_timer_set_oneshot(struct clock_event_device *evt)
 static void lapic_timer_broadcast(const struct cpumask *mask)
 {
 #ifdef CONFIG_SMP
-	apic->send_IPI_mask(mask, LOCAL_TIMER_VECTOR);
+	x86_local_apic->send_IPI_mask(mask, LOCAL_TIMER_VECTOR);
 #endif
 }
 
@@ -1444,7 +1444,7 @@ static void lapic_setup_esr(void)
 		return;
 	}
 
-	if (apic->disable_esr) {
+	if (x86_local_apic->disable_esr) {
 		/*
 		 * Something untraceable is creating bad interrupts on
 		 * secondary quads ... for the moment, just leave the
@@ -1570,7 +1570,7 @@ static void setup_local_APIC(void)
 
 #ifdef CONFIG_X86_32
 	/* Pound the ESR really hard over the head with a big hammer - mbligh */
-	if (lapic_is_integrated() && apic->disable_esr) {
+	if (lapic_is_integrated() && x86_local_apic->disable_esr) {
 		apic_write(APIC_ESR, 0);
 		apic_write(APIC_ESR, 0);
 		apic_write(APIC_ESR, 0);
@@ -1581,17 +1581,17 @@ static void setup_local_APIC(void)
 	 * Double-check whether this APIC is really registered.
 	 * This is meaningless in clustered apic mode, so we skip it.
 	 */
-	BUG_ON(!apic->apic_id_registered());
+	BUG_ON(!x86_local_apic->apic_id_registered());
 
 	/*
 	 * Intel recommends to set DFR, LDR and TPR before enabling
 	 * an APIC.  See e.g. "AP-388 82489DX User's Manual" (Intel
 	 * document number 292116).  So here it goes...
 	 */
-	apic->init_apic_ldr();
+	x86_local_apic->init_apic_ldr();
 
 #ifdef CONFIG_X86_32
-	if (apic->dest_logical) {
+	if (x86_local_apic->dest_logical) {
 		int logical_apicid, ldr_apicid;
 
 		/*
@@ -2463,7 +2463,7 @@ int generic_processor_info(int apicid, int version)
 #endif
 #ifdef CONFIG_X86_32
 	early_per_cpu(x86_cpu_to_logical_apicid, cpu) =
-		apic->x86_32_early_logical_apicid(cpu);
+		x86_local_apic->x86_32_early_logical_apicid(cpu);
 #endif
 	set_cpu_possible(cpu, true);
 	physid_set(apicid, phys_cpu_present_map);
@@ -2499,7 +2499,7 @@ void __init apic_set_eoi_write(void (*eoi_write)(u32 reg, u32 v))
 static void __init apic_bsp_up_setup(void)
 {
 #ifdef CONFIG_X86_64
-	apic_write(APIC_ID, apic->set_apic_id(boot_cpu_physical_apicid));
+	apic_write(APIC_ID, x86_local_apic->set_apic_id(boot_cpu_physical_apicid));
 #else
 	/*
 	 * Hack: In case of kdump, after a crash, kernel might be booting
diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index 7862b152a052..8b9eb2285b88 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -20,8 +20,8 @@
 static struct apic apic_physflat;
 static struct apic apic_flat;
 
-struct apic *apic __ro_after_init = &apic_flat;
-EXPORT_SYMBOL_GPL(apic);
+struct apic *x86_local_apic __ro_after_init = &apic_flat;
+EXPORT_SYMBOL_GPL(x86_local_apic);
 
 static int flat_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
 {
@@ -53,7 +53,7 @@ static void _flat_send_IPI_mask(unsigned long mask, int vector)
 	unsigned long flags;
 
 	local_irq_save(flags);
-	__default_send_IPI_dest_field(mask, vector, apic->dest_logical);
+	__default_send_IPI_dest_field(mask, vector, x86_local_apic->dest_logical);
 	local_irq_restore(flags);
 }
 
@@ -191,7 +191,7 @@ static void physflat_init_apic_ldr(void)
 
 static int physflat_probe(void)
 {
-	if (apic == &apic_physflat || num_possible_cpus() > 8 ||
+	if (x86_local_apic == &apic_physflat || num_possible_cpus() > 8 ||
 	    jailhouse_paravirt())
 		return 1;
 
diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/apic_numachip.c
index 35edd57f064a..2292b1614c9f 100644
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -159,12 +159,12 @@ static void numachip_send_IPI_self(int vector)
 
 static int __init numachip1_probe(void)
 {
-	return apic == &apic_numachip1;
+	return x86_local_apic == &apic_numachip1;
 }
 
 static int __init numachip2_probe(void)
 {
-	return apic == &apic_numachip2;
+	return x86_local_apic == &apic_numachip2;
 }
 
 static void fixup_cpu_id(struct cpuinfo_x86 *c, int node)
diff --git a/arch/x86/kernel/apic/bigsmp_32.c b/arch/x86/kernel/apic/bigsmp_32.c
index 98d015a4405a..4832dd7e453c 100644
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -176,7 +176,7 @@ void __init generic_bigsmp_probe(void)
 	if (!probe_bigsmp())
 		return;
 
-	apic = &apic_bigsmp;
+	x86_local_apic = &apic_bigsmp;
 
 	for_each_possible_cpu(cpu) {
 		if (early_per_cpu(x86_cpu_to_logical_apicid,
diff --git a/arch/x86/kernel/apic/hw_nmi.c b/arch/x86/kernel/apic/hw_nmi.c
index 34a992e275ef..0ced5a1bf602 100644
--- a/arch/x86/kernel/apic/hw_nmi.c
+++ b/arch/x86/kernel/apic/hw_nmi.c
@@ -31,7 +31,7 @@ u64 hw_nmi_get_sample_period(int watchdog_thresh)
 #ifdef arch_trigger_cpumask_backtrace
 static void nmi_raise_cpu_backtrace(cpumask_t *mask)
 {
-	apic->send_IPI_mask(mask, NMI_VECTOR);
+	x86_local_apic->send_IPI_mask(mask, NMI_VECTOR);
 }
 
 void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 7b3c7e0d4a09..7bd1c09e6c94 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1457,7 +1457,7 @@ void __init setup_ioapic_ids_from_mpc_nocheck(void)
 	 * This is broken; anything with a real cpu count has to
 	 * circumvent this idiocy regardless.
 	 */
-	apic->ioapic_phys_id_map(&phys_cpu_present_map, &phys_id_present_map);
+	x86_local_apic->ioapic_phys_id_map(&phys_cpu_present_map, &phys_id_present_map);
 
 	/*
 	 * Set the IOAPIC ID to the value stored in the MPC table.
@@ -1483,7 +1483,7 @@ void __init setup_ioapic_ids_from_mpc_nocheck(void)
 		 * system must have a unique ID or we get lots of nice
 		 * 'stuck on smp_invalidate_needed IPI wait' messages.
 		 */
-		if (apic->check_apicid_used(&phys_id_present_map,
+		if (x86_local_apic->check_apicid_used(&phys_id_present_map,
 					    mpc_ioapic_id(ioapic_idx))) {
 			printk(KERN_ERR "BIOS bug, IO-APIC#%d ID %d is already used!...\n",
 				ioapic_idx, mpc_ioapic_id(ioapic_idx));
@@ -1498,7 +1498,7 @@ void __init setup_ioapic_ids_from_mpc_nocheck(void)
 			ioapics[ioapic_idx].mp_config.apicid = i;
 		} else {
 			physid_mask_t tmp;
-			apic->apicid_to_cpu_present(mpc_ioapic_id(ioapic_idx),
+			x86_local_apic->apicid_to_cpu_present(mpc_ioapic_id(ioapic_idx),
 						    &tmp);
 			apic_printk(APIC_VERBOSE, "Setting %d in the "
 					"phys_id_present_map\n",
@@ -2462,7 +2462,8 @@ static int io_apic_get_unique_id(int ioapic, int apic_id)
 	 */
 
 	if (physids_empty(apic_id_map))
-		apic->ioapic_phys_id_map(&phys_cpu_present_map, &apic_id_map);
+		x86_local_apic->ioapic_phys_id_map(&phys_cpu_present_map,
+						    &apic_id_map);
 
 	raw_spin_lock_irqsave(&ioapic_lock, flags);
 	reg_00.raw = io_apic_read(ioapic, 0);
@@ -2478,10 +2479,10 @@ static int io_apic_get_unique_id(int ioapic, int apic_id)
 	 * Every APIC in a system must have a unique ID or we get lots of nice
 	 * 'stuck on smp_invalidate_needed IPI wait' messages.
 	 */
-	if (apic->check_apicid_used(&apic_id_map, apic_id)) {
+	if (x86_local_apic->check_apicid_used(&apic_id_map, apic_id)) {
 
 		for (i = 0; i < get_physical_broadcast(); i++) {
-			if (!apic->check_apicid_used(&apic_id_map, i))
+			if (!x86_local_apic->check_apicid_used(&apic_id_map, i))
 				break;
 		}
 
@@ -2494,7 +2495,7 @@ static int io_apic_get_unique_id(int ioapic, int apic_id)
 		apic_id = i;
 	}
 
-	apic->apicid_to_cpu_present(apic_id, &tmp);
+	x86_local_apic->apicid_to_cpu_present(apic_id, &tmp);
 	physids_or(apic_id_map, apic_id_map, tmp);
 
 	if (reg_00.bits.ID != apic_id) {
@@ -2948,8 +2949,8 @@ static void mp_setup_entry(struct irq_cfg *cfg, struct mp_chip_data *data,
 			   struct IO_APIC_route_entry *entry)
 {
 	memset(entry, 0, sizeof(*entry));
-	entry->delivery_mode = apic->irq_delivery_mode;
-	entry->dest_mode     = apic->irq_dest_mode;
+	entry->delivery_mode = x86_local_apic->irq_delivery_mode;
+	entry->dest_mode     = x86_local_apic->irq_dest_mode;
 	entry->dest	     = cfg->dest_apicid;
 	entry->vector	     = cfg->vector;
 	entry->trigger	     = data->trigger;
diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index 387154e39e08..6532ef8629c5 100644
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -52,9 +52,9 @@ void apic_send_IPI_allbutself(unsigned int vector)
 		return;
 
 	if (static_branch_likely(&apic_use_ipi_shorthand))
-		apic->send_IPI_allbutself(vector);
+		x86_local_apic->send_IPI_allbutself(vector);
 	else
-		apic->send_IPI_mask_allbutself(cpu_online_mask, vector);
+		x86_local_apic->send_IPI_mask_allbutself(cpu_online_mask, vector);
 }
 
 /*
@@ -68,12 +68,12 @@ void native_smp_send_reschedule(int cpu)
 		WARN(1, "sched: Unexpected reschedule of offline CPU#%d!\n", cpu);
 		return;
 	}
-	apic->send_IPI(cpu, RESCHEDULE_VECTOR);
+	x86_local_apic->send_IPI(cpu, RESCHEDULE_VECTOR);
 }
 
 void native_send_call_func_single_ipi(int cpu)
 {
-	apic->send_IPI(cpu, CALL_FUNCTION_SINGLE_VECTOR);
+	x86_local_apic->send_IPI(cpu, CALL_FUNCTION_SINGLE_VECTOR);
 }
 
 void native_send_call_func_ipi(const struct cpumask *mask)
@@ -85,14 +85,14 @@ void native_send_call_func_ipi(const struct cpumask *mask)
 			goto sendmask;
 
 		if (cpumask_test_cpu(cpu, mask))
-			apic->send_IPI_all(CALL_FUNCTION_VECTOR);
+			x86_local_apic->send_IPI_all(CALL_FUNCTION_VECTOR);
 		else if (num_online_cpus() > 1)
-			apic->send_IPI_allbutself(CALL_FUNCTION_VECTOR);
+			x86_local_apic->send_IPI_allbutself(CALL_FUNCTION_VECTOR);
 		return;
 	}
 
 sendmask:
-	apic->send_IPI_mask(mask, CALL_FUNCTION_VECTOR);
+	x86_local_apic->send_IPI_mask(mask, CALL_FUNCTION_VECTOR);
 }
 
 #endif /* CONFIG_SMP */
@@ -224,7 +224,7 @@ void default_send_IPI_mask_allbutself_phys(const struct cpumask *mask,
  */
 void default_send_IPI_single(int cpu, int vector)
 {
-	apic->send_IPI_mask(cpumask_of(cpu), vector);
+	x86_local_apic->send_IPI_mask(cpumask_of(cpu), vector);
 }
 
 void default_send_IPI_allbutself(int vector)
@@ -260,7 +260,7 @@ void default_send_IPI_mask_sequence_logical(const struct cpumask *mask,
 	for_each_cpu(query_cpu, mask)
 		__default_send_IPI_dest_field(
 			early_per_cpu(x86_cpu_to_logical_apicid, query_cpu),
-			vector, apic->dest_logical);
+			vector, x86_local_apic->dest_logical);
 	local_irq_restore(flags);
 }
 
@@ -279,7 +279,7 @@ void default_send_IPI_mask_allbutself_logical(const struct cpumask *mask,
 			continue;
 		__default_send_IPI_dest_field(
 			early_per_cpu(x86_cpu_to_logical_apicid, query_cpu),
-			vector, apic->dest_logical);
+			vector, x86_local_apic->dest_logical);
 		}
 	local_irq_restore(flags);
 }
@@ -297,7 +297,7 @@ void default_send_IPI_mask_logical(const struct cpumask *cpumask, int vector)
 
 	local_irq_save(flags);
 	WARN_ON(mask & ~cpumask_bits(cpu_online_mask)[0]);
-	__default_send_IPI_dest_field(mask, vector, apic->dest_logical);
+	__default_send_IPI_dest_field(mask, vector, x86_local_apic->dest_logical);
 	local_irq_restore(flags);
 }
 
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 6313f0a05db7..942da5023c72 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -32,7 +32,7 @@ static void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg)
 
 	msg->address_lo =
 		MSI_ADDR_BASE_LO |
-		((apic->irq_dest_mode == 0) ?
+		((x86_local_apic->irq_dest_mode == 0) ?
 			MSI_ADDR_DEST_MODE_PHYSICAL :
 			MSI_ADDR_DEST_MODE_LOGICAL) |
 		MSI_ADDR_REDIRECTION_CPU |
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index 67b6f7c049ec..14bd89df18c2 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -113,8 +113,8 @@ static struct apic apic_default __ro_after_init = {
 
 apic_driver(apic_default);
 
-struct apic *apic __ro_after_init = &apic_default;
-EXPORT_SYMBOL_GPL(apic);
+struct apic *x86_local_apic __ro_after_init = &apic_default;
+EXPORT_SYMBOL_GPL(x86_local_apic);
 
 static int cmdline_apic __initdata;
 static int __init parse_apic(char *arg)
@@ -126,7 +126,7 @@ static int __init parse_apic(char *arg)
 
 	for (drv = __apicdrivers; drv < __apicdrivers_end; drv++) {
 		if (!strcmp((*drv)->name, arg)) {
-			apic = *drv;
+			x86_local_apic = *drv;
 			cmdline_apic = 1;
 			return 0;
 		}
@@ -164,12 +164,12 @@ void __init default_setup_apic_routing(void)
 	 * - we find more than 8 CPUs in acpi LAPIC listing with xAPIC support
 	 */
 
-	if (!cmdline_apic && apic == &apic_default)
+	if (!cmdline_apic && x86_local_apic == &apic_default)
 		generic_bigsmp_probe();
 #endif
 
-	if (apic->setup_apic_routing)
-		apic->setup_apic_routing();
+	if (x86_local_apic->setup_apic_routing)
+		x86_local_apic->setup_apic_routing();
 }
 
 void __init generic_apic_probe(void)
@@ -179,7 +179,7 @@ void __init generic_apic_probe(void)
 
 		for (drv = __apicdrivers; drv < __apicdrivers_end; drv++) {
 			if ((*drv)->probe()) {
-				apic = *drv;
+				x86_local_apic = *drv;
 				break;
 			}
 		}
@@ -187,7 +187,7 @@ void __init generic_apic_probe(void)
 		if (drv == __apicdrivers_end)
 			panic("Didn't find an APIC driver");
 	}
-	printk(KERN_INFO "Using APIC driver %s\n", apic->name);
+	printk(KERN_INFO "Using APIC driver %s\n", x86_local_apic->name);
 }
 
 /* This function can switch the APIC even after the initial ->probe() */
@@ -202,9 +202,9 @@ int __init default_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
 			continue;
 
 		if (!cmdline_apic) {
-			apic = *drv;
+			x86_local_apic = *drv;
 			printk(KERN_INFO "Switched to APIC driver `%s'.\n",
-			       apic->name);
+			       x86_local_apic->name);
 		}
 		return 1;
 	}
diff --git a/arch/x86/kernel/apic/probe_64.c b/arch/x86/kernel/apic/probe_64.c
index c46720f185c0..1d11b21c2ef2 100644
--- a/arch/x86/kernel/apic/probe_64.c
+++ b/arch/x86/kernel/apic/probe_64.c
@@ -24,10 +24,10 @@ void __init default_setup_apic_routing(void)
 
 	for (drv = __apicdrivers; drv < __apicdrivers_end; drv++) {
 		if ((*drv)->probe && (*drv)->probe()) {
-			if (apic != *drv) {
-				apic = *drv;
+			if (x86_local_apic != *drv) {
+				x86_local_apic = *drv;
 				pr_info("Switched APIC routing to %s.\n",
-					apic->name);
+					x86_local_apic->name);
 			}
 			break;
 		}
@@ -40,10 +40,10 @@ int __init default_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
 
 	for (drv = __apicdrivers; drv < __apicdrivers_end; drv++) {
 		if ((*drv)->acpi_madt_oem_check(oem_id, oem_table_id)) {
-			if (apic != *drv) {
-				apic = *drv;
+			if (x86_local_apic != *drv) {
+				x86_local_apic = *drv;
 				pr_info("Setting APIC routing to %s.\n",
-					apic->name);
+					x86_local_apic->name);
 			}
 			return 1;
 		}
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 1eac53632786..1722dce7da69 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -122,7 +122,7 @@ static void apic_update_irq_cfg(struct irq_data *irqd, unsigned int vector,
 	lockdep_assert_held(&vector_lock);
 
 	apicd->hw_irq_cfg.vector = vector;
-	apicd->hw_irq_cfg.dest_apicid = apic->calc_dest_apicid(cpu);
+	apicd->hw_irq_cfg.dest_apicid = x86_local_apic->calc_dest_apicid(cpu);
 	irq_data_update_effective_affinity(irqd, cpumask_of(cpu));
 	trace_vector_config(irqd->irq, vector, cpu,
 			    apicd->hw_irq_cfg.dest_apicid);
@@ -800,7 +800,7 @@ static int apic_retrigger_irq(struct irq_data *irqd)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&vector_lock, flags);
-	apic->send_IPI(apicd->cpu, apicd->vector);
+	x86_local_apic->send_IPI(apicd->cpu, apicd->vector);
 	raw_spin_unlock_irqrestore(&vector_lock, flags);
 
 	return 1;
@@ -876,7 +876,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_irq_move_cleanup)
 		 */
 		irr = apic_read(APIC_IRR + (vector / 32 * 0x10));
 		if (irr & (1U << (vector % 32))) {
-			apic->send_IPI_self(IRQ_MOVE_CLEANUP_VECTOR);
+			x86_local_apic->send_IPI_self(IRQ_MOVE_CLEANUP_VECTOR);
 			continue;
 		}
 		free_moved_vector(apicd);
@@ -894,7 +894,7 @@ static void __send_cleanup_vector(struct apic_chip_data *apicd)
 	cpu = apicd->prev_cpu;
 	if (cpu_online(cpu)) {
 		hlist_add_head(&apicd->clist, per_cpu_ptr(&cleanup_list, cpu));
-		apic->send_IPI(cpu, IRQ_MOVE_CLEANUP_VECTOR);
+		x86_local_apic->send_IPI(cpu, IRQ_MOVE_CLEANUP_VECTOR);
 	} else {
 		apicd->prev_vector = 0;
 	}
diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index b0889c48a2ac..1ac445cc5c2a 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -61,7 +61,8 @@ __x2apic_send_IPI_mask(const struct cpumask *mask, int vector, int apic_dest)
 		if (!dest)
 			continue;
 
-		__x2apic_send_IPI_dest(dest, vector, apic->dest_logical);
+		__x2apic_send_IPI_dest(dest, vector,
+				       x86_local_apic->dest_logical);
 		/* Remove cluster CPUs from tmpmask */
 		cpumask_andnot(tmpmsk, tmpmsk, &cmsk->mask);
 	}
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index bc9693841353..b4a37751dd54 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -92,7 +92,7 @@ static int x2apic_phys_probe(void)
 	if (x2apic_mode && (x2apic_phys || x2apic_fadt_phys()))
 		return 1;
 
-	return apic == &apic_x2apic_phys;
+	return x86_local_apic == &apic_x2apic_phys;
 }
 
 /* Common x2apic functions, also used by x2apic_cluster */
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 714233cee0b5..80354a565a7b 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -796,7 +796,7 @@ static void uv_send_IPI_self(int vector)
 
 static int uv_probe(void)
 {
-	return apic == &apic_x2apic_uv_x;
+	return x86_local_apic == &apic_x2apic_uv_x;
 }
 
 static struct apic apic_x2apic_uv_x __ro_after_init = {
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 35ad8480c464..69c12cc86879 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -780,7 +780,8 @@ void detect_ht(struct cpuinfo_x86 *c)
 		return;
 
 	index_msb = get_count_order(smp_num_siblings);
-	c->phys_proc_id = apic->phys_pkg_id(c->initial_apicid, index_msb);
+	c->phys_proc_id = x86_local_apic->phys_pkg_id(c->initial_apicid,
+						       index_msb);
 
 	smp_num_siblings = smp_num_siblings / c->x86_max_cores;
 
@@ -788,8 +789,9 @@ void detect_ht(struct cpuinfo_x86 *c)
 
 	core_bits = get_count_order(c->x86_max_cores);
 
-	c->cpu_core_id = apic->phys_pkg_id(c->initial_apicid, index_msb) &
-				       ((1 << core_bits) - 1);
+	c->cpu_core_id = x86_local_apic->phys_pkg_id(c->initial_apicid,
+						      index_msb) &
+					       ((1 << core_bits) - 1);
 #endif
 }
 
@@ -1442,7 +1444,7 @@ static void generic_identify(struct cpuinfo_x86 *c)
 		c->initial_apicid = (cpuid_ebx(1) >> 24) & 0xFF;
 #ifdef CONFIG_X86_32
 # ifdef CONFIG_SMP
-		c->apicid = apic->phys_pkg_id(c->initial_apicid, 0);
+		c->apicid = x86_local_apic->phys_pkg_id(c->initial_apicid, 0);
 # else
 		c->apicid = c->initial_apicid;
 # endif
@@ -1481,7 +1483,7 @@ static void validate_apic_and_package_id(struct cpuinfo_x86 *c)
 #ifdef CONFIG_SMP
 	unsigned int apicid, cpu = smp_processor_id();
 
-	apicid = apic->cpu_present_to_apicid(cpu);
+	apicid = x86_local_apic->cpu_present_to_apicid(cpu);
 
 	if (apicid != c->apicid) {
 		pr_err(FW_BUG "CPU%u: APIC id mismatch. Firmware: %x APIC: %x\n",
@@ -1535,7 +1537,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	apply_forced_caps(c);
 
 #ifdef CONFIG_X86_64
-	c->apicid = apic->phys_pkg_id(c->initial_apicid, 0);
+	c->apicid = x86_local_apic->phys_pkg_id(c->initial_apicid, 0);
 #endif
 
 	/*
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 3a44346f2276..e241746b0cd0 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -252,8 +252,8 @@ static void __maybe_unused raise_mce(struct mce *m)
 					mce_irq_ipi, NULL, 0);
 				preempt_enable();
 			} else if (m->inject_flags & MCJ_NMI_BROADCAST)
-				apic->send_IPI_mask(mce_inject_cpumask,
-						NMI_VECTOR);
+				x86_local_apic->send_IPI_mask(mce_inject_cpumask,
+							       NMI_VECTOR);
 		}
 		start = jiffies;
 		while (!cpumask_empty(mce_inject_cpumask)) {
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index d3a0791bc052..a3f9a2e6c0d1 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -137,16 +137,16 @@ int detect_extended_topology(struct cpuinfo_x86 *c)
 	die_select_mask = (~(-1 << die_plus_mask_width)) >>
 				core_plus_mask_width;
 
-	c->cpu_core_id = apic->phys_pkg_id(c->initial_apicid,
+	c->cpu_core_id = x86_local_apic->phys_pkg_id(c->initial_apicid,
 				ht_mask_width) & core_select_mask;
-	c->cpu_die_id = apic->phys_pkg_id(c->initial_apicid,
+	c->cpu_die_id = x86_local_apic->phys_pkg_id(c->initial_apicid,
 				core_plus_mask_width) & die_select_mask;
-	c->phys_proc_id = apic->phys_pkg_id(c->initial_apicid,
+	c->phys_proc_id = x86_local_apic->phys_pkg_id(c->initial_apicid,
 				die_plus_mask_width);
 	/*
 	 * Reinit the apicid, now that we have extended initial_apicid.
 	 */
-	c->apicid = apic->phys_pkg_id(c->initial_apicid, 0);
+	c->apicid = x86_local_apic->phys_pkg_id(c->initial_apicid, 0);
 
 	c->x86_max_cores = (core_level_siblings / smp_num_siblings);
 	__max_die_per_package = (die_level_siblings / core_level_siblings);
diff --git a/arch/x86/kernel/irq_work.c b/arch/x86/kernel/irq_work.c
index 890d4778cd35..950bd4d6de4a 100644
--- a/arch/x86/kernel/irq_work.c
+++ b/arch/x86/kernel/irq_work.c
@@ -28,7 +28,7 @@ void arch_irq_work_raise(void)
 	if (!arch_irq_work_has_interrupt())
 		return;
 
-	apic->send_IPI_self(IRQ_WORK_VECTOR);
+	x86_local_apic->send_IPI_self(IRQ_WORK_VECTOR);
 	apic_wait_icr_idle();
 }
 #endif
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 7f57ede3cb8e..ef2bf5ea3354 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -325,7 +325,7 @@ static notrace void kvm_guest_apic_eoi_write(u32 reg, u32 val)
 	 */
 	if (__test_and_clear_bit(KVM_PV_EOI_BIT, this_cpu_ptr(&kvm_apic_eoi)))
 		return;
-	apic->native_eoi_write(APIC_EOI, APIC_EOI_ACK);
+	x86_local_apic->native_eoi_write(APIC_EOI, APIC_EOI_ACK);
 }
 
 static void kvm_guest_cpu_init(void)
@@ -554,8 +554,8 @@ static void kvm_send_ipi_mask_allbutself(const struct cpumask *mask, int vector)
  */
 static void kvm_setup_pv_ipi(void)
 {
-	apic->send_IPI_mask = kvm_send_ipi_mask;
-	apic->send_IPI_mask_allbutself = kvm_send_ipi_mask_allbutself;
+	x86_local_apic->send_IPI_mask = kvm_send_ipi_mask;
+	x86_local_apic->send_IPI_mask_allbutself = kvm_send_ipi_mask_allbutself;
 	pr_info("setup PV IPIs\n");
 }
 
diff --git a/arch/x86/kernel/nmi_selftest.c b/arch/x86/kernel/nmi_selftest.c
index a1a96df3dff1..7f4c6db7abae 100644
--- a/arch/x86/kernel/nmi_selftest.c
+++ b/arch/x86/kernel/nmi_selftest.c
@@ -75,7 +75,7 @@ static void __init test_nmi_ipi(struct cpumask *mask)
 	/* sync above data before sending NMI */
 	wmb();
 
-	apic->send_IPI_mask(mask, NMI_VECTOR);
+	x86_local_apic->send_IPI_mask(mask, NMI_VECTOR);
 
 	/* Don't wait longer than a second */
 	timeout = USEC_PER_SEC;
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 9a94934fae5f..3ffece2d269e 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -756,7 +756,7 @@ wakeup_secondary_cpu_via_nmi(int apicid, unsigned long start_eip)
 	/* Target chip */
 	/* Boot on the stack */
 	/* Kick the second */
-	apic_icr_write(APIC_DM_NMI | apic->dest_logical, apicid);
+	apic_icr_write(APIC_DM_NMI | x86_local_apic->dest_logical, apicid);
 
 	pr_debug("Waiting for send to finish...\n");
 	send_status = safe_apic_wait_icr_idle();
@@ -983,7 +983,7 @@ wakeup_cpu_via_init_nmi(int cpu, unsigned long start_ip, int apicid,
 	if (!boot_error) {
 		enable_start_cpu0 = 1;
 		*cpu0_nmi_registered = 1;
-		if (apic->dest_logical == APIC_DEST_LOGICAL)
+		if (x86_local_apic->dest_logical == APIC_DEST_LOGICAL)
 			id = cpu0_logical_apicid;
 		else
 			id = apicid;
@@ -1080,8 +1080,9 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
 	 * Otherwise,
 	 * - Use an INIT boot APIC message for APs or NMI for BSP.
 	 */
-	if (apic->wakeup_secondary_cpu)
-		boot_error = apic->wakeup_secondary_cpu(apicid, start_ip);
+	if (x86_local_apic->wakeup_secondary_cpu)
+		boot_error = x86_local_apic->wakeup_secondary_cpu(apicid,
+								   start_ip);
 	else
 		boot_error = wakeup_cpu_via_init_nmi(cpu, start_ip, apicid,
 						     cpu0_nmi_registered);
@@ -1132,7 +1133,7 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
 
 int native_cpu_up(unsigned int cpu, struct task_struct *tidle)
 {
-	int apicid = apic->cpu_present_to_apicid(cpu);
+	int apicid = x86_local_apic->cpu_present_to_apicid(cpu);
 	int cpu0_nmi_registered = 0;
 	unsigned long flags;
 	int err, ret = 0;
@@ -1143,7 +1144,7 @@ int native_cpu_up(unsigned int cpu, struct task_struct *tidle)
 
 	if (apicid == BAD_APICID ||
 	    !physid_isset(apicid, phys_cpu_present_map) ||
-	    !apic->apic_id_valid(apicid)) {
+	    !x86_local_apic->apic_id_valid(apicid)) {
 		pr_err("%s: bad cpu %d\n", __func__, cpu);
 		return -EINVAL;
 	}
@@ -1280,7 +1281,7 @@ static void __init smp_sanity_check(void)
 	 * Should not be necessary because the MP table should list the boot
 	 * CPU too, but we do it for the sake of robustness anyway.
 	 */
-	if (!apic->check_phys_apicid_present(boot_cpu_physical_apicid)) {
+	if (!x86_local_apic->check_phys_apicid_present(boot_cpu_physical_apicid)) {
 		pr_notice("weird, boot CPU (#%d) not listed by the BIOS\n",
 			  boot_cpu_physical_apicid);
 		physid_set(hard_smp_processor_id(), phys_cpu_present_map);
@@ -1467,8 +1468,9 @@ __init void prefill_possible_map(void)
 			pr_warn("Boot CPU (id %d) not listed by BIOS\n", cpu);
 
 			/* Make sure boot cpu is enumerated */
-			if (apic->cpu_present_to_apicid(0) == BAD_APICID &&
-			    apic->apic_id_valid(apicid))
+			if (x86_local_apic->cpu_present_to_apicid(0) ==
+					BAD_APICID &&
+			    x86_local_apic->apic_id_valid(apicid))
 				generic_processor_info(apicid, boot_cpu_apic_version);
 		}
 
diff --git a/arch/x86/kernel/vsmp_64.c b/arch/x86/kernel/vsmp_64.c
index 796cfaa46bfa..03c0050f1f29 100644
--- a/arch/x86/kernel/vsmp_64.c
+++ b/arch/x86/kernel/vsmp_64.c
@@ -135,7 +135,7 @@ static int apicid_phys_pkg_id(int initial_apic_id, int index_msb)
 static void vsmp_apic_post_init(void)
 {
 	/* need to update phys_pkg_id */
-	apic->phys_pkg_id = apicid_phys_pkg_id;
+	x86_local_apic->phys_pkg_id = apicid_phys_pkg_id;
 }
 
 void __init vsmp_init(void)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index d14c94d0aff1..3ffbe5b339a4 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3943,7 +3943,7 @@ static inline bool kvm_vcpu_trigger_posted_interrupt(struct kvm_vcpu *vcpu,
 		 * which has no effect is safe here.
 		 */
 
-		apic->send_IPI_mask(get_cpu_mask(vcpu->cpu), pi_vec);
+		x86_local_apic->send_IPI_mask(get_cpu_mask(vcpu->cpu), pi_vec);
 		return true;
 	}
 #endif
diff --git a/arch/x86/mm/srat.c b/arch/x86/mm/srat.c
index dac07e4f5834..9e02fd79dc7e 100644
--- a/arch/x86/mm/srat.c
+++ b/arch/x86/mm/srat.c
@@ -40,7 +40,7 @@ acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa)
 		return;
 	pxm = pa->proximity_domain;
 	apic_id = pa->apic_id;
-	if (!apic->apic_id_valid(apic_id)) {
+	if (!x86_local_apic->apic_id_valid(apic_id)) {
 		printk(KERN_INFO "SRAT: PXM %u -> X2APIC 0x%04x ignored\n",
 			 pxm, apic_id);
 		return;
diff --git a/arch/x86/platform/uv/uv_irq.c b/arch/x86/platform/uv/uv_irq.c
index 18ca2261cc9a..33895ba927f2 100644
--- a/arch/x86/platform/uv/uv_irq.c
+++ b/arch/x86/platform/uv/uv_irq.c
@@ -35,8 +35,8 @@ static void uv_program_mmr(struct irq_cfg *cfg, struct uv_irq_2_mmr_pnode *info)
 	mmr_value = 0;
 	entry = (struct uv_IO_APIC_route_entry *)&mmr_value;
 	entry->vector		= cfg->vector;
-	entry->delivery_mode	= apic->irq_delivery_mode;
-	entry->dest_mode	= apic->irq_dest_mode;
+	entry->delivery_mode	= x86_local_apic->irq_delivery_mode;
+	entry->dest_mode	= x86_local_apic->irq_dest_mode;
 	entry->polarity		= 0;
 	entry->trigger		= 0;
 	entry->mask		= 0;
diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
index eafc530c8767..1acb85b0f806 100644
--- a/arch/x86/platform/uv/uv_nmi.c
+++ b/arch/x86/platform/uv/uv_nmi.c
@@ -597,7 +597,7 @@ static void uv_nmi_nr_cpus_ping(void)
 	for_each_cpu(cpu, uv_nmi_cpu_mask)
 		uv_cpu_nmi_per(cpu).pinging = 1;
 
-	apic->send_IPI_mask(uv_nmi_cpu_mask, APIC_DM_NMI);
+	x86_local_apic->send_IPI_mask(uv_nmi_cpu_mask, APIC_DM_NMI);
 }
 
 /* Clean up flags for CPU's that ignored both NMI and ping */
diff --git a/arch/x86/xen/apic.c b/arch/x86/xen/apic.c
index e82fd1910dae..a7c3f35ce32b 100644
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -191,12 +191,12 @@ static struct apic xen_pv_apic = {
 
 static void __init xen_apic_check(void)
 {
-	if (apic == &xen_pv_apic)
+	if (x86_local_apic == &xen_pv_apic)
 		return;
 
-	pr_info("Switched APIC routing from %s to %s.\n", apic->name,
+	pr_info("Switched APIC routing from %s to %s.\n", x86_local_apic->name,
 		xen_pv_apic.name);
-	apic = &xen_pv_apic;
+	x86_local_apic = &xen_pv_apic;
 }
 void __init xen_init_apic(void)
 {
@@ -204,7 +204,7 @@ void __init xen_init_apic(void)
 	/* On PV guests the APIC CPUID bit is disabled so none of the
 	 * routines end up executing. */
 	if (!xen_initial_domain())
-		apic = &xen_pv_apic;
+		x86_local_apic = &xen_pv_apic;
 
 	x86_platform.apic_post_init = xen_apic_check;
 }
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b9cf59443843..01a8d1b7fc74 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3671,8 +3671,10 @@ static void irq_remapping_prepare_irte(struct amd_ir_data *data,
 
 	data->irq_2_irte.devid = devid;
 	data->irq_2_irte.index = index + sub_handle;
-	iommu->irte_ops->prepare(data->entry, apic->irq_delivery_mode,
-				 apic->irq_dest_mode, irq_cfg->vector,
+	iommu->irte_ops->prepare(data->entry,
+				 x86_local_apic->irq_delivery_mode,
+				 x86_local_apic->irq_dest_mode,
+				 irq_cfg->vector,
 				 irq_cfg->dest_apicid, devid);
 
 	switch (info->type) {
@@ -3943,8 +3945,8 @@ int amd_iommu_deactivate_guest_mode(void *data)
 	entry->hi.val = 0;
 
 	entry->lo.fields_remap.valid       = valid;
-	entry->lo.fields_remap.dm          = apic->irq_dest_mode;
-	entry->lo.fields_remap.int_type    = apic->irq_delivery_mode;
+	entry->lo.fields_remap.dm          = x86_local_apic->irq_dest_mode;
+	entry->lo.fields_remap.int_type    = x86_local_apic->irq_delivery_mode;
 	entry->hi.fields.vector            = cfg->vector;
 	entry->lo.fields_remap.destination =
 				APICID_TO_IRTE_DEST_LO(cfg->dest_apicid);
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 0cfce1d3b7bb..01ae7e674974 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1113,7 +1113,7 @@ static void prepare_irte(struct irte *irte, int vector, unsigned int dest)
 	memset(irte, 0, sizeof(*irte));
 
 	irte->present = 1;
-	irte->dst_mode = apic->irq_dest_mode;
+	irte->dst_mode = x86_local_apic->irq_dest_mode;
 	/*
 	 * Trigger mode in the IRTE will always be edge, and for IO-APIC, the
 	 * actual level or edge trigger will be setup in the IO-APIC
@@ -1122,7 +1122,7 @@ static void prepare_irte(struct irte *irte, int vector, unsigned int dest)
 	 * irq migration in the presence of interrupt-remapping.
 	*/
 	irte->trigger_mode = 0;
-	irte->dlvry_mode = apic->irq_delivery_mode;
+	irte->dlvry_mode = x86_local_apic->irq_delivery_mode;
 	irte->vector = vector;
 	irte->dest_id = IRTE_DEST(dest);
 	irte->redir_hint = 1;
-- 
2.27.0

