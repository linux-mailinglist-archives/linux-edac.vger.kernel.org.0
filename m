Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B01003D22A
	for <lists+linux-edac@lfdr.de>; Tue, 11 Jun 2019 18:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387610AbfFKQY4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 11 Jun 2019 12:24:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57237 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbfFKQYz (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 11 Jun 2019 12:24:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5BGORFo281192
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 11 Jun 2019 09:24:27 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5BGORFo281192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560270268;
        bh=2R/qm8dOfX1IEArBEkYJmzTC5f9So52GY4H8rVT3QHQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=uKvpmSrw7Z/UiiIYZEjQcek34vyV4EiA+ZAnKAoaBqUPtUONVVFqLW3aXPtIevbox
         TJDAZJbZba3vjnC3/g3JcuRY9NT8y8McUNdRUR7i2VQQxuIDVdwC2MdVJx1AogeqvB
         UVTgy6obIlqCAwzUMkcJOkBtr3fWURlRGsVrA/qdOE1aOd/u7zfLzjj65LMMMuqXfn
         OmTH64uyrthtdwOnDrRHN/Exdm4gU6/iTiwZlml+1M967G4h75d+VFOgRk7dhv4Q9v
         WmJLrCg/qYDKiqxvRfLkvZy7Ul6LaASc27cgrVa6agbevGGo54Rwfy8vL9k1pBQn2j
         lxoNlh2dycw4A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5BGORls281185;
        Tue, 11 Jun 2019 09:24:27 -0700
Date:   Tue, 11 Jun 2019 09:24:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yazen Ghannam <tipbot@zytor.com>
Message-ID: <tip-95d057f54664f3c6e8f650faf5690b82b30a9e52@git.kernel.org>
Cc:     mingo@kernel.org, bp@suse.de, yazen.ghannam@amd.com,
        tglx@linutronix.de, x86@kernel.org, tony.luck@intel.com,
        linux-edac@vger.kernel.org, mingo@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com,
          linux-edac@vger.kernel.org, tony.luck@intel.com,
          yazen.ghannam@amd.com, tglx@linutronix.de, x86@kernel.org,
          mingo@kernel.org, bp@suse.de
In-Reply-To: <20190607201752.221446-4-Yazen.Ghannam@amd.com>
References: <20190607201752.221446-4-Yazen.Ghannam@amd.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/MCE/AMD: Don't cache block addresses on SMCA
 systems
Git-Commit-ID: 95d057f54664f3c6e8f650faf5690b82b30a9e52
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

Commit-ID:  95d057f54664f3c6e8f650faf5690b82b30a9e52
Gitweb:     https://git.kernel.org/tip/95d057f54664f3c6e8f650faf5690b82b30a9e52
Author:     Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate: Fri, 7 Jun 2019 20:18:04 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Tue, 11 Jun 2019 15:22:41 +0200

x86/MCE/AMD: Don't cache block addresses on SMCA systems

On legacy systems, the addresses of the MCA_MISC* registers need to be
recursively discovered based on a Block Pointer field in the registers.

On Scalable MCA systems, the register space is fixed, and particular
addresses can be derived by regular offsets for bank and register type.
This fixed address space includes the MCA_MISC* registers.

MCA_MISC0 is always available for each MCA bank. MCA_MISC1 through
MCA_MISC4 are considered available if MCA_MISC0[BlkPtr]=1.

Cache the value of MCA_MISC0[BlkPtr] for each bank and per CPU. This
needs to be done only during init. The values should be saved per CPU
to accommodate heterogeneous SMCA systems.

Redo smca_get_block_address() to directly return the block addresses.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: "x86@kernel.org" <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190607201752.221446-4-Yazen.Ghannam@amd.com
---
 arch/x86/kernel/cpu/mce/amd.c | 73 ++++++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 36 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index d904aafe6409..d4d6e4b7f9dc 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -101,11 +101,6 @@ static struct smca_bank_name smca_names[] = {
 	[SMCA_PCIE]	= { "pcie",		"PCI Express Unit" },
 };
 
-static u32 smca_bank_addrs[MAX_NR_BANKS][NR_BLOCKS] __ro_after_init =
-{
-	[0 ... MAX_NR_BANKS - 1] = { [0 ... NR_BLOCKS - 1] = -1 }
-};
-
 static const char *smca_get_name(enum smca_bank_types t)
 {
 	if (t >= N_SMCA_BANK_TYPES)
@@ -199,6 +194,9 @@ static char buf_mcatype[MAX_MCATYPE_NAME_LEN];
 static DEFINE_PER_CPU(struct threshold_bank **, threshold_banks);
 static DEFINE_PER_CPU(unsigned int, bank_map);	/* see which banks are on */
 
+/* Map of banks that have more than MCA_MISC0 available. */
+static DEFINE_PER_CPU(u32, smca_misc_banks_map);
+
 static void amd_threshold_interrupt(void);
 static void amd_deferred_error_interrupt(void);
 
@@ -208,6 +206,28 @@ static void default_deferred_error_interrupt(void)
 }
 void (*deferred_error_int_vector)(void) = default_deferred_error_interrupt;
 
+static void smca_set_misc_banks_map(unsigned int bank, unsigned int cpu)
+{
+	u32 low, high;
+
+	/*
+	 * For SMCA enabled processors, BLKPTR field of the first MISC register
+	 * (MCx_MISC0) indicates presence of additional MISC regs set (MISC1-4).
+	 */
+	if (rdmsr_safe(MSR_AMD64_SMCA_MCx_CONFIG(bank), &low, &high))
+		return;
+
+	if (!(low & MCI_CONFIG_MCAX))
+		return;
+
+	if (rdmsr_safe(MSR_AMD64_SMCA_MCx_MISC(bank), &low, &high))
+		return;
+
+	if (low & MASK_BLKPTR_LO)
+		per_cpu(smca_misc_banks_map, cpu) |= BIT(bank);
+
+}
+
 static void smca_configure(unsigned int bank, unsigned int cpu)
 {
 	unsigned int i, hwid_mcatype;
@@ -245,6 +265,8 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 		wrmsr(smca_config, low, high);
 	}
 
+	smca_set_misc_banks_map(bank, cpu);
+
 	/* Return early if this bank was already initialized. */
 	if (smca_banks[bank].hwid)
 		return;
@@ -455,42 +477,21 @@ static void deferred_error_interrupt_enable(struct cpuinfo_x86 *c)
 	wrmsr(MSR_CU_DEF_ERR, low, high);
 }
 
-static u32 smca_get_block_address(unsigned int bank, unsigned int block)
+static u32 smca_get_block_address(unsigned int bank, unsigned int block,
+				  unsigned int cpu)
 {
-	u32 low, high;
-	u32 addr = 0;
-
-	if (smca_get_bank_type(bank) == SMCA_RESERVED)
-		return addr;
-
 	if (!block)
 		return MSR_AMD64_SMCA_MCx_MISC(bank);
 
-	/* Check our cache first: */
-	if (smca_bank_addrs[bank][block] != -1)
-		return smca_bank_addrs[bank][block];
-
-	/*
-	 * For SMCA enabled processors, BLKPTR field of the first MISC register
-	 * (MCx_MISC0) indicates presence of additional MISC regs set (MISC1-4).
-	 */
-	if (rdmsr_safe(MSR_AMD64_SMCA_MCx_CONFIG(bank), &low, &high))
-		goto out;
-
-	if (!(low & MCI_CONFIG_MCAX))
-		goto out;
-
-	if (!rdmsr_safe(MSR_AMD64_SMCA_MCx_MISC(bank), &low, &high) &&
-	    (low & MASK_BLKPTR_LO))
-		addr = MSR_AMD64_SMCA_MCx_MISCy(bank, block - 1);
+	if (!(per_cpu(smca_misc_banks_map, cpu) & BIT(bank)))
+		return 0;
 
-out:
-	smca_bank_addrs[bank][block] = addr;
-	return addr;
+	return MSR_AMD64_SMCA_MCx_MISCy(bank, block - 1);
 }
 
 static u32 get_block_address(u32 current_addr, u32 low, u32 high,
-			     unsigned int bank, unsigned int block)
+			     unsigned int bank, unsigned int block,
+			     unsigned int cpu)
 {
 	u32 addr = 0, offset = 0;
 
@@ -498,7 +499,7 @@ static u32 get_block_address(u32 current_addr, u32 low, u32 high,
 		return addr;
 
 	if (mce_flags.smca)
-		return smca_get_block_address(bank, block);
+		return smca_get_block_address(bank, block, cpu);
 
 	/* Fall back to method we used for older processors: */
 	switch (block) {
@@ -637,7 +638,7 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 		disable_err_thresholding(c, bank);
 
 		for (block = 0; block < NR_BLOCKS; ++block) {
-			address = get_block_address(address, low, high, bank, block);
+			address = get_block_address(address, low, high, bank, block, cpu);
 			if (!address)
 				break;
 
@@ -1254,7 +1255,7 @@ static int allocate_threshold_blocks(unsigned int cpu, unsigned int bank,
 	if (err)
 		goto out_free;
 recurse:
-	address = get_block_address(address, low, high, bank, ++block);
+	address = get_block_address(address, low, high, bank, ++block, cpu);
 	if (!address)
 		return 0;
 
