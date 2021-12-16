Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C444147790F
	for <lists+linux-edac@lfdr.de>; Thu, 16 Dec 2021 17:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbhLPQ33 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 16 Dec 2021 11:29:29 -0500
Received: from mail-dm6nam11on2050.outbound.protection.outlook.com ([40.107.223.50]:8128
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239173AbhLPQ32 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 16 Dec 2021 11:29:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkcRVCuw5R9WZCff9WlP/K2QG3JjEJVIcBCzVVQS3OBLJ2h9LcUcoTwTdb/FmTSOmKQN3b1QaYs/0gNNmB56sEARJru5lWaSOR/GLZsWGm0oSI5Ja8+5cuH8gWN8jMVaNp3OtSAYmgFaJu0AfHUClt5rfDSzucVs10Sh21f3/f7eAq+CGHCc+8tcV+6sjdAkJLnlMQpAf2RqmaWtyRhm0IcHJmH1ygXyUTDIG72o+1IcsLRdJsuCPhVJkJjQKtFXmFGeZlq6ZnqT6mhJjVcG+7OOvRHud/pdHRStgy3Mxf4c13wmm40l3YoWoHigP1bNEWFmD1vXXA9t1erahjxhRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKNuRbAE4YE4/CpCjApadC2BS8cTjWTk8gEVQiTN4z0=;
 b=W4aq1uSLTcUFb7ulgUeboTzLP3JNPT/x0v6V2nw3B7kjrhA61F0jE8HyoBHmb58Bz2yVaeaXyMGV8kpNQWMgodVCunPWAe1q2ZnPX3tGTaiqq75LCEEh+MUjvFOpyLgYdb84ceZtVwdKmEfEA3xZaVGriy39vdw9bsN8MjB9wZcNixa48YGPuZsSiriNzEJ/3hvBXjEbOrrFdcerTex/bDMo4OZsXdPbc+n98qv5/2ox51XpmekjWcuguR3HrA2u8yLQyKS8GJ6P5ah7XtGepE6byjiGZUP6C6kyr1J5msFgDXh4Z+k7TOQk8i5FIJAAl7uALC5vJ8GAIBULCILF8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKNuRbAE4YE4/CpCjApadC2BS8cTjWTk8gEVQiTN4z0=;
 b=K0ueD9R+98mQC0Gr/0F36PCdlIW7e65Pd1UQzykucCLRS4X1bqQPW5IBoR0H4D3JRryDXrDnWZOfEyY7mUghQsLsEZhDueN0wTLdtolXq6v8IQjstylQ5nwUJ7KkZpgWWoFPJC2Kg3jd+BOMPUZE37CeM8k8YYJ9ApSTUhz1CQI=
Received: from MW3PR05CA0030.namprd05.prod.outlook.com (2603:10b6:303:2b::35)
 by BN7PR12MB2785.namprd12.prod.outlook.com (2603:10b6:408:2d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Thu, 16 Dec
 2021 16:29:25 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::ce) by MW3PR05CA0030.outlook.office365.com
 (2603:10b6:303:2b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.13 via Frontend
 Transport; Thu, 16 Dec 2021 16:29:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Thu, 16 Dec 2021 16:29:24 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 16 Dec
 2021 10:29:23 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <william.roche@oracle.com>, <alexander.deucher@amd.com>,
        <mukul.joshi@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 2/2] x86/MCE/AMD, EDAC/mce_amd: Support non-uniform MCA bank type enumeration
Date:   Thu, 16 Dec 2021 16:29:05 +0000
Message-ID: <20211216162905.4132657-3-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211216162905.4132657-1-yazen.ghannam@amd.com>
References: <20211216162905.4132657-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdabc78c-98bc-44ee-9385-08d9c0b1392e
X-MS-TrafficTypeDiagnostic: BN7PR12MB2785:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB2785231D95FCEAA1B6EAC2A1F8779@BN7PR12MB2785.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7xkHYW5+R6W2yFoutcjBapsHKJY8EzvFfF7ibIRfMMLF7reHuEd0X5f0UwRGSRVqRZjsgvm0X3ZD1UGM8EwhFljwZVuVILhJov0Faf2waZZ9CbcqDc4lXYF9sqRP5cih5PzNPucI6eNH1i1QZo4ejttSg+c+WdB8MTbWX1+5MSlklbo2TqZJ5emEDfiw2T4JhVM5IgggyXC+3NRBvwmHQfGOKkwsOkp1tivMmlZdFDv7aP6FJ43jrdSzqZqROlm9f4LN3SICbodFXMumdwZ9aICSaohbTK+wx506HNqdu0J7FvrUb2Rs7cagdP6r628IWftHqQG2Ou0gzr2mAp3vUpPqsi0Qhrkmgta2NHWVT/AxP4OHb4MAbWA3i5gAtMUURSisEaVms6KJc54XJ/qzQFUY+iEoS2t5F4JUf25un1l59x2BWmsF+kP0KUER6WyHEBL3veWJP/LkR2oOt8CXH3e3EKj2ZuJW+J6eMVtsddRnbXnnH1ExPq/Yo2QEuQF1yHQt7CcpzY2iE0+VkTXxguisFylP0yf2ZW1zv1/B4pdMLRSqdRw12gJT8TDtIt9qwfuDhbE9uxTfslwVEwPOv1ngwu58acneRL9MfIDQwzkgkKspqfgifB3bX70dTks9J461p0YYLpKoZFohmxTqO3rLdoooyWFiF/Gll5u7wauTkfeVAA2N9lajjD7Q9+4QAgGraneyhvdF6SagGtDKanO9cRvY9B4joxGjdCk0k4jiiNJOcrWXQ37KKbQb5kH4QRRc2Mk+ytEBAR6NnAuqRETmOkkluWxYYh8nBm/HuxAycJjrZubSfaDncMi95Gu9wzM8G6evKgXda2zcB3Xo/hbxLjSmPe6VqLhhHNWeeKlmIZwy1VoOti1TI66hd42W
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(36860700001)(2616005)(82310400004)(356005)(316002)(508600001)(15650500001)(4326008)(1076003)(44832011)(36756003)(5660300002)(16526019)(47076005)(86362001)(336012)(70586007)(186003)(6916009)(426003)(26005)(966005)(8936002)(2906002)(83380400001)(70206006)(81166007)(40460700001)(7696005)(8676002)(6666004)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 16:29:24.9171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdabc78c-98bc-44ee-9385-08d9c0b1392e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2785
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

AMD systems currently lay out MCA bank types such that the type of bank
number "i" is either the same across all CPUs or is Reserved/Read-as-Zero.

For example:

  Bank # | CPUx | CPUy
    0      LS     LS
    1      RAZ    UMC
    2      CS     CS
    3      SMU    RAZ

Future AMD systems will lay out MCA bank types such that the type of
bank number "i" may be different across CPUs.

For example:

  Bank # | CPUx | CPUy
    0      LS     LS
    1      RAZ    UMC
    2      CS     NBIO
    3      SMU    RAZ

Change the structures that cache MCA bank types to be per-CPU and update
smca_get_bank_type() to handle this change.

Move some SMCA-specific structures to amd.c from mce.h, since they no
longer need to be global.

Break out the "count" for bank types from struct smca_hwid, since this
should provide a per-CPU count rather than a system-wide count.

Apply the "const" qualifier to the struct smca_hwid_mcatypes array. The
values in this array should not change at runtime.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20211203020017.728440-4-yazen.ghannam@amd.com

v1->v2:
* Rework due to dropping patch 1 from v1.

 arch/x86/include/asm/mce.h              | 18 +-------
 arch/x86/kernel/cpu/mce/amd.c           | 59 +++++++++++++++----------
 drivers/edac/mce_amd.c                  | 11 +----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |  2 +-
 4 files changed, 39 insertions(+), 51 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 52d2b35cac2d..cc73061e7255 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -329,22 +329,6 @@ enum smca_bank_types {
 	N_SMCA_BANK_TYPES
 };
 
-#define HWID_MCATYPE(hwid, mcatype) (((hwid) << 16) | (mcatype))
-
-struct smca_hwid {
-	unsigned int bank_type;	/* Use with smca_bank_types for easy indexing. */
-	u32 hwid_mcatype;	/* (hwid,mcatype) tuple */
-	u8 count;		/* Number of instances. */
-};
-
-struct smca_bank {
-	struct smca_hwid *hwid;
-	u32 id;			/* Value of MCA_IPID[InstanceId]. */
-	u8 sysfs_id;		/* Value used for sysfs name. */
-};
-
-extern struct smca_bank smca_banks[MAX_NR_BANKS];
-
 extern const char *smca_get_long_name(enum smca_bank_types t);
 extern bool amd_mce_is_memory_error(struct mce *m);
 
@@ -352,7 +336,7 @@ extern int mce_threshold_create_device(unsigned int cpu);
 extern int mce_threshold_remove_device(unsigned int cpu);
 
 void mce_amd_feature_init(struct cpuinfo_x86 *c);
-enum smca_bank_types smca_get_bank_type(unsigned int bank);
+enum smca_bank_types smca_get_bank_type(unsigned int cpu, unsigned int bank);
 #else
 
 static inline int mce_threshold_create_device(unsigned int cpu)		{ return 0; };
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index ffe8ea8bc877..345ccdf329bc 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -71,6 +71,22 @@ static const char * const smca_umc_block_names[] = {
 	"misc_umc"
 };
 
+#define HWID_MCATYPE(hwid, mcatype) (((hwid) << 16) | (mcatype))
+
+struct smca_hwid {
+	unsigned int bank_type;	/* Use with smca_bank_types for easy indexing. */
+	u32 hwid_mcatype;	/* (hwid,mcatype) tuple */
+};
+
+struct smca_bank {
+	const struct smca_hwid *hwid;
+	u32 id;			/* Value of MCA_IPID[InstanceId]. */
+	u8 sysfs_id;		/* Value used for sysfs name. */
+};
+
+static DEFINE_PER_CPU_READ_MOSTLY(struct smca_bank[MAX_NR_BANKS], smca_banks);
+static DEFINE_PER_CPU_READ_MOSTLY(u8[N_SMCA_BANK_TYPES], smca_bank_counts);
+
 struct smca_bank_name {
 	const char *name;	/* Short name for sysfs */
 	const char *long_name;	/* Long name for pretty-printing */
@@ -126,14 +142,14 @@ const char *smca_get_long_name(enum smca_bank_types t)
 }
 EXPORT_SYMBOL_GPL(smca_get_long_name);
 
-enum smca_bank_types smca_get_bank_type(unsigned int bank)
+enum smca_bank_types smca_get_bank_type(unsigned int cpu, unsigned int bank)
 {
 	struct smca_bank *b;
 
 	if (bank >= MAX_NR_BANKS)
 		return N_SMCA_BANK_TYPES;
 
-	b = &smca_banks[bank];
+	b = &per_cpu(smca_banks, cpu)[bank];
 	if (!b->hwid)
 		return N_SMCA_BANK_TYPES;
 
@@ -141,7 +157,7 @@ enum smca_bank_types smca_get_bank_type(unsigned int bank)
 }
 EXPORT_SYMBOL_GPL(smca_get_bank_type);
 
-static struct smca_hwid smca_hwid_mcatypes[] = {
+static const struct smca_hwid smca_hwid_mcatypes[] = {
 	/* { bank_type, hwid_mcatype } */
 
 	/* Reserved type */
@@ -219,9 +235,6 @@ static struct smca_hwid smca_hwid_mcatypes[] = {
 	{ SMCA_GMI_PHY,	 HWID_MCATYPE(0x269, 0x0)	},
 };
 
-struct smca_bank smca_banks[MAX_NR_BANKS];
-EXPORT_SYMBOL_GPL(smca_banks);
-
 /*
  * In SMCA enabled processors, we can have multiple banks for a given IP type.
  * So to define a unique name for each bank, we use a temp c-string to append
@@ -277,8 +290,9 @@ static void smca_set_misc_banks_map(unsigned int bank, unsigned int cpu)
 
 static void smca_configure(unsigned int bank, unsigned int cpu)
 {
+	u8 *bank_counts = this_cpu_ptr(smca_bank_counts);
+	const struct smca_hwid *s_hwid;
 	unsigned int i, hwid_mcatype;
-	struct smca_hwid *s_hwid;
 	u32 high, low;
 	u32 smca_config = MSR_AMD64_SMCA_MCx_CONFIG(bank);
 
@@ -314,10 +328,6 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 
 	smca_set_misc_banks_map(bank, cpu);
 
-	/* Return early if this bank was already initialized. */
-	if (smca_banks[bank].hwid && smca_banks[bank].hwid->hwid_mcatype != 0)
-		return;
-
 	if (rdmsr_safe(MSR_AMD64_SMCA_MCx_IPID(bank), &low, &high)) {
 		pr_warn("Failed to read MCA_IPID for bank %d\n", bank);
 		return;
@@ -328,10 +338,11 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 
 	for (i = 0; i < ARRAY_SIZE(smca_hwid_mcatypes); i++) {
 		s_hwid = &smca_hwid_mcatypes[i];
+
 		if (hwid_mcatype == s_hwid->hwid_mcatype) {
-			smca_banks[bank].hwid = s_hwid;
-			smca_banks[bank].id = low;
-			smca_banks[bank].sysfs_id = s_hwid->count++;
+			this_cpu_ptr(smca_banks)[bank].hwid = s_hwid;
+			this_cpu_ptr(smca_banks)[bank].id = low;
+			this_cpu_ptr(smca_banks)[bank].sysfs_id = bank_counts[s_hwid->bank_type]++;
 			break;
 		}
 	}
@@ -617,7 +628,7 @@ prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
 
 bool amd_filter_mce(struct mce *m)
 {
-	enum smca_bank_types bank_type = smca_get_bank_type(m->bank);
+	enum smca_bank_types bank_type = smca_get_bank_type(m->extcpu, m->bank);
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 
 	/* See Family 17h Models 10h-2Fh Erratum #1114. */
@@ -655,7 +666,7 @@ static void disable_err_thresholding(struct cpuinfo_x86 *c, unsigned int bank)
 	} else if (c->x86 == 0x17 &&
 		   (c->x86_model >= 0x10 && c->x86_model <= 0x2F)) {
 
-		if (smca_get_bank_type(bank) != SMCA_IF)
+		if (smca_get_bank_type(smp_processor_id(), bank) != SMCA_IF)
 			return;
 
 		msrs[0] = MSR_AMD64_SMCA_MCx_MISC(bank);
@@ -723,7 +734,7 @@ bool amd_mce_is_memory_error(struct mce *m)
 	u8 xec = (m->status >> 16) & 0x1f;
 
 	if (mce_flags.smca)
-		return smca_get_bank_type(m->bank) == SMCA_UMC && xec == 0x0;
+		return smca_get_bank_type(m->extcpu, m->bank) == SMCA_UMC && xec == 0x0;
 
 	return m->bank == 4 && xec == 0x8;
 }
@@ -1039,7 +1050,7 @@ static struct kobj_type threshold_ktype = {
 	.release		= threshold_block_release,
 };
 
-static const char *get_name(unsigned int bank, struct threshold_block *b)
+static const char *get_name(unsigned int cpu, unsigned int bank, struct threshold_block *b)
 {
 	enum smca_bank_types bank_type;
 
@@ -1050,7 +1061,7 @@ static const char *get_name(unsigned int bank, struct threshold_block *b)
 		return th_names[bank];
 	}
 
-	bank_type = smca_get_bank_type(bank);
+	bank_type = smca_get_bank_type(cpu, bank);
 	if (bank_type >= N_SMCA_BANK_TYPES)
 		return NULL;
 
@@ -1060,12 +1071,12 @@ static const char *get_name(unsigned int bank, struct threshold_block *b)
 		return NULL;
 	}
 
-	if (smca_banks[bank].hwid->count == 1)
+	if (per_cpu(smca_bank_counts, cpu)[bank_type] == 1)
 		return smca_get_name(bank_type);
 
 	snprintf(buf_mcatype, MAX_MCATYPE_NAME_LEN,
-		 "%s_%x", smca_get_name(bank_type),
-			  smca_banks[bank].sysfs_id);
+		 "%s_%u", smca_get_name(bank_type),
+			  per_cpu(smca_banks, cpu)[bank].sysfs_id);
 	return buf_mcatype;
 }
 
@@ -1121,7 +1132,7 @@ static int allocate_threshold_blocks(unsigned int cpu, struct threshold_bank *tb
 	else
 		tb->blocks = b;
 
-	err = kobject_init_and_add(&b->kobj, &threshold_ktype, tb->kobj, get_name(bank, b));
+	err = kobject_init_and_add(&b->kobj, &threshold_ktype, tb->kobj, get_name(cpu, bank, b));
 	if (err)
 		goto out_free;
 recurse:
@@ -1176,7 +1187,7 @@ static int threshold_create_bank(struct threshold_bank **bp, unsigned int cpu,
 	struct device *dev = this_cpu_read(mce_device);
 	struct amd_northbridge *nb = NULL;
 	struct threshold_bank *b = NULL;
-	const char *name = get_name(bank, NULL);
+	const char *name = get_name(cpu, bank, NULL);
 	int err = 0;
 
 	if (!dev)
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index cfd3f7ae9251..cc5c63feb26a 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -1166,20 +1166,13 @@ static void decode_mc6_mce(struct mce *m)
 /* Decode errors according to Scalable MCA specification */
 static void decode_smca_error(struct mce *m)
 {
-	struct smca_hwid *hwid;
-	enum smca_bank_types bank_type;
+	enum smca_bank_types bank_type = smca_get_bank_type(m->extcpu, m->bank);
 	const char *ip_name;
 	u8 xec = XEC(m->status, xec_mask);
 
-	if (m->bank >= ARRAY_SIZE(smca_banks))
+	if (bank_type >= N_SMCA_BANK_TYPES)
 		return;
 
-	hwid = smca_banks[m->bank].hwid;
-	if (!hwid)
-		return;
-
-	bank_type = hwid->bank_type;
-
 	if (bank_type == SMCA_RESERVED) {
 		pr_emerg(HW_ERR "Bank %d is reserved.\n", m->bank);
 		return;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 08133de21fdd..75dad0214dc7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2647,7 +2647,7 @@ static int amdgpu_bad_page_notifier(struct notifier_block *nb,
 	 * and error occurred in DramECC (Extended error code = 0) then only
 	 * process the error, else bail out.
 	 */
-	if (!m || !((smca_get_bank_type(m->bank) == SMCA_UMC_V2) &&
+	if (!m || !((smca_get_bank_type(m->extcpu, m->bank) == SMCA_UMC_V2) &&
 		    (XEC(m->status, 0x3f) == 0x0)))
 		return NOTIFY_DONE;
 
-- 
2.25.1

