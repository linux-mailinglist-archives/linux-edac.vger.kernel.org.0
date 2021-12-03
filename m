Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07080466F77
	for <lists+linux-edac@lfdr.de>; Fri,  3 Dec 2021 03:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242760AbhLCCEL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 2 Dec 2021 21:04:11 -0500
Received: from mail-bn8nam11on2063.outbound.protection.outlook.com ([40.107.236.63]:12682
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240452AbhLCCEK (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 2 Dec 2021 21:04:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VntDbr1OM2OkEhMp8i+FSPSbLSgg950jKVGEtf6HcNiUdn9SEaTXw7jlQDWTkUf3b5+j7rJBnbkmvdw2f/3znw0AhO4ZyetJTIG+nDpgosM4pDZrqtOK+7W02rCl+EfbINy3t57YZmcFnfWWR6sQVcpEeuxmQ+gxSHrbgyE6crM2UyVvcu1LzV3ZEXznJ+sRaLckoOsVPfmH9bLsLwf+XLndV9yq/qMFoz41Q+3uebiN1DsxDVNnCxp+YkZufOiKPy1DNu8M0O87SEpyUPMgiMQC3dyBMB83ZKMMslfPc7kytJ6IHn7jgRmntxp9DLdliTfxu35GPxUtsjd7Zf61gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0xnq6v3UhD9JHw0TAcW0Wwha0BdHCuJ50A2NsbI0m4=;
 b=TwkuZEtNF4fxNiJGFFYiXmD3HLkIg4p+JF5OJF4KzMhz8BXRJtzGszJPMeK1eb51DM9vO1dsex05v4WvsueXMa/kuI02rf7hDCEzUsY/be38GeiZxTGegVev6n5DVL/A5Vi1OXaqlmedMaWiH9r92jEHocv7Vcv+/HC0ENG8UZIXUxw0RjOoX8skUCVJT9HPLdXnAWVazeOrTA1spjSyFzE8EymegOvuy7UU9gwHf9+b7B7eQ3YsO/syoMYHvtT13WlO+B00GdwiUFS1IC/ElB2UI/G8qrmVE235E43ASUen+IDIoNlLs1TuUNvw2FnXISCIgS8hYyBZvUV22vx9qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0xnq6v3UhD9JHw0TAcW0Wwha0BdHCuJ50A2NsbI0m4=;
 b=AtduXfHCHuyLctYUt1pcaxvkjg5flbLIb0Vo8Afd4mHnPLV74NxQFUydDS1qVc+M51OKJqYEw8iLXrb5AEHbGbXrwcRfvkegHlnDlcjCN2A1anr8Q59ZFrOo8qHLtienoI5xJrgClAq9wRBbRJ0UQXdQVOVxeQ5D4v+dNuXrros=
Received: from MW4PR04CA0339.namprd04.prod.outlook.com (2603:10b6:303:8a::14)
 by MW2PR12MB4682.namprd12.prod.outlook.com (2603:10b6:302:e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 02:00:44 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::36) by MW4PR04CA0339.outlook.office365.com
 (2603:10b6:303:8a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14 via Frontend
 Transport; Fri, 3 Dec 2021 02:00:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 02:00:43 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 2 Dec
 2021 20:00:42 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <mukul.joshi@amd.com>, <alexander.deucher@amd.com>,
        <william.roche@oracle.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 3/3] x86/MCE/AMD, EDAC/mce_amd: Support non-uniform MCA bank type enumeration
Date:   Fri, 3 Dec 2021 02:00:17 +0000
Message-ID: <20211203020017.728440-4-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211203020017.728440-1-yazen.ghannam@amd.com>
References: <20211203020017.728440-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 561ee843-a21e-4fd4-eac5-08d9b600b742
X-MS-TrafficTypeDiagnostic: MW2PR12MB4682:
X-Microsoft-Antispam-PRVS: <MW2PR12MB4682938B5F0B7528EA8FC8D2F86A9@MW2PR12MB4682.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mBUptQPLndBPSKDtZA0QSrnihuhfJVf7d7AEIo6735UNxE/AWtLQerqqLXfDGc52yZ8aZOPqIKvovI+3CiLO8jz1KWwh51CIwR5VwDx5gXhYwH4rjZh+wAVoy+gTgle3OVDXpLydnYnYOEpIhO6TXwgrUn9QWDv/IA1ua6Rg6bRJuyu5tGuLQ2e8yTcBp8OsZme+kvzXWQ4IWjk9rRAn/B4NYdzTXGtc4MVlF7ec0j25A9jnz8CiNL+Q5Lwh3X/cJvALKY2dIY0yQM5rT9uXATOSqtd2iUhMJA8xy5mJhuxrDcVWM+gsuqkrNPZT+iMHINBcHLD92nFlR/QcJMrB8dAXavIf3kMio8h30ZHgjLGx9y4O2xkZCElG8XrcoPLI6bEqy4aZADnr/Ny/2Nj3U3+jLIx0PKuA/MtWXB5KwcBZgPiCUHGS+pquy5O2SuOkhEP+Jk/A15fPBbV6DL+mw8c4qBJ+/uuNYU4FAEaii/RprNh/ARaAXgQe0T7R4Q4OPuAumPOcAU2EDMTD514fy3SrLUXqapLMpuZHUqrd5IdSPmbFV53WjhSzg5hQ+lrsGC6ujb6FV715hBtdqRFrf9Kdat6ZbgXW5Gdi7bB5pJJWJEfkeeVaLjEtnjoaI2oKe1s0zDXI9tOjpqdmpUOl2tUc0lPKV7XeEYFUcOhY4FIDwjdGn4H+yvCkQDWoGs+d72t6E7xr4PdaHqY5riDZ0mhHXT7Z3RdznvmTHMunzP58tVaoT5shEGJaI0X185/GNbaEwzj7kP5iyIgS1udTXoGLpC2A7miWpqO8H+C1vuI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(2906002)(7696005)(16526019)(356005)(1076003)(70586007)(186003)(2616005)(30864003)(36756003)(40460700001)(70206006)(508600001)(5660300002)(86362001)(8936002)(426003)(26005)(82310400004)(15650500001)(4326008)(36860700001)(54906003)(336012)(6666004)(81166007)(316002)(83380400001)(47076005)(44832011)(6916009)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 02:00:43.8944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 561ee843-a21e-4fd4-eac5-08d9b600b742
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB4682
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
 arch/x86/include/asm/mce.h              | 18 +-------
 arch/x86/kernel/cpu/mce/amd.c           | 60 ++++++++++++++-----------
 drivers/edac/mce_amd.c                  | 12 +----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |  2 +-
 4 files changed, 38 insertions(+), 54 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index d6834e8fbb6a..a0b3cdd8e6ec 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -330,22 +330,6 @@ enum smca_bank_types {
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
 
@@ -353,7 +337,7 @@ extern int mce_threshold_create_device(unsigned int cpu);
 extern int mce_threshold_remove_device(unsigned int cpu);
 
 void mce_amd_feature_init(struct cpuinfo_x86 *c);
-enum smca_bank_types smca_get_bank_type(unsigned int bank);
+enum smca_bank_types smca_get_bank_type(unsigned int cpu, unsigned int bank);
 #else
 
 static inline int mce_threshold_create_device(unsigned int cpu)		{ return 0; };
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index e12a8f3414f5..6ec87e580145 100644
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
@@ -127,14 +143,14 @@ const char *smca_get_long_name(enum smca_bank_types t)
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
 
@@ -142,7 +158,7 @@ enum smca_bank_types smca_get_bank_type(unsigned int bank)
 }
 EXPORT_SYMBOL_GPL(smca_get_bank_type);
 
-static struct smca_hwid smca_hwid_mcatypes[] = {
+static const struct smca_hwid smca_hwid_mcatypes[] = {
 	/* { bank_type, hwid_mcatype } */
 
 	/* Reserved type */
@@ -223,9 +239,6 @@ static struct smca_hwid smca_hwid_mcatypes[] = {
 	{ SMCA_UNKNOWN,  HWID_MCATYPE(0xFFF, 0xFFFF)	},
 };
 
-struct smca_bank smca_banks[MAX_NR_BANKS];
-EXPORT_SYMBOL_GPL(smca_banks);
-
 /*
  * In SMCA enabled processors, we can have multiple banks for a given IP type.
  * So to define a unique name for each bank, we use a temp c-string to append
@@ -281,8 +294,9 @@ static void smca_set_misc_banks_map(unsigned int bank, unsigned int cpu)
 
 static void smca_configure(unsigned int bank, unsigned int cpu)
 {
+	u8 *bank_counts = this_cpu_ptr(smca_bank_counts);
+	const struct smca_hwid *s_hwid;
 	unsigned int i, hwid_mcatype;
-	struct smca_hwid *s_hwid;
 	u32 high, low;
 	u32 smca_config = MSR_AMD64_SMCA_MCx_CONFIG(bank);
 
@@ -318,10 +332,6 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 
 	smca_set_misc_banks_map(bank, cpu);
 
-	/* Return early if this bank was already initialized. */
-	if (smca_banks[bank].hwid && smca_banks[bank].hwid->hwid_mcatype != 0)
-		return;
-
 	if (rdmsr_safe(MSR_AMD64_SMCA_MCx_IPID(bank), &low, &high)) {
 		pr_warn("Failed to read MCA_IPID for bank %d\n", bank);
 		return;
@@ -335,9 +345,9 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 
 		if (hwid_mcatype == s_hwid->hwid_mcatype ||
 		    s_hwid->bank_type == SMCA_UNKNOWN) {
-			smca_banks[bank].hwid = s_hwid;
-			smca_banks[bank].id = low;
-			smca_banks[bank].sysfs_id = s_hwid->count++;
+			this_cpu_ptr(smca_banks)[bank].hwid = s_hwid;
+			this_cpu_ptr(smca_banks)[bank].id = low;
+			this_cpu_ptr(smca_banks)[bank].sysfs_id = bank_counts[s_hwid->bank_type]++;
 			break;
 		}
 	}
@@ -623,7 +633,7 @@ prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
 
 bool amd_filter_mce(struct mce *m)
 {
-	enum smca_bank_types bank_type = smca_get_bank_type(m->bank);
+	enum smca_bank_types bank_type = smca_get_bank_type(m->extcpu, m->bank);
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 
 	/* See Family 17h Models 10h-2Fh Erratum #1114. */
@@ -661,7 +671,7 @@ static void disable_err_thresholding(struct cpuinfo_x86 *c, unsigned int bank)
 	} else if (c->x86 == 0x17 &&
 		   (c->x86_model >= 0x10 && c->x86_model <= 0x2F)) {
 
-		if (smca_get_bank_type(bank) != SMCA_IF)
+		if (smca_get_bank_type(smp_processor_id(), bank) != SMCA_IF)
 			return;
 
 		msrs[0] = MSR_AMD64_SMCA_MCx_MISC(bank);
@@ -729,7 +739,7 @@ bool amd_mce_is_memory_error(struct mce *m)
 	u8 xec = (m->status >> 16) & 0x1f;
 
 	if (mce_flags.smca)
-		return smca_get_bank_type(m->bank) == SMCA_UMC && xec == 0x0;
+		return smca_get_bank_type(m->extcpu, m->bank) == SMCA_UMC && xec == 0x0;
 
 	return m->bank == 4 && xec == 0x8;
 }
@@ -1045,7 +1055,7 @@ static struct kobj_type threshold_ktype = {
 	.release		= threshold_block_release,
 };
 
-static const char *get_name(unsigned int bank, struct threshold_block *b)
+static const char *get_name(unsigned int cpu, unsigned int bank, struct threshold_block *b)
 {
 	enum smca_bank_types bank_type;
 
@@ -1056,7 +1066,7 @@ static const char *get_name(unsigned int bank, struct threshold_block *b)
 		return th_names[bank];
 	}
 
-	bank_type = smca_get_bank_type(bank);
+	bank_type = smca_get_bank_type(cpu, bank);
 	if (bank_type >= N_SMCA_BANK_TYPES)
 		return NULL;
 
@@ -1066,11 +1076,11 @@ static const char *get_name(unsigned int bank, struct threshold_block *b)
 		return NULL;
 	}
 
-	if (smca_banks[bank].hwid->count == 1) {
+	if (per_cpu(smca_bank_counts, cpu)[bank_type] == 1) {
 		if (bank_type == SMCA_UNKNOWN) {
 			snprintf(buf_mcatype, MAX_MCATYPE_NAME_LEN,
 				 "%s_%x", smca_get_name(bank_type),
-					  smca_banks[bank].id);
+					  per_cpu(smca_banks, cpu)[bank].id);
 
 			return buf_mcatype;
 		} else {
@@ -1081,11 +1091,11 @@ static const char *get_name(unsigned int bank, struct threshold_block *b)
 	if (b && bank_type == SMCA_UNKNOWN) {
 		snprintf(buf_mcatype, MAX_MCATYPE_NAME_LEN,
 			 "%s_%x_block_%u", smca_get_name(bank_type),
-			 smca_banks[bank].id, b->block);
+			 per_cpu(smca_banks, cpu)[bank].id, b->block);
 	} else {
 		snprintf(buf_mcatype, MAX_MCATYPE_NAME_LEN,
 			 "%s_%u", smca_get_name(bank_type),
-				  smca_banks[bank].sysfs_id);
+				  per_cpu(smca_banks, cpu)[bank].sysfs_id);
 	}
 
 	return buf_mcatype;
@@ -1143,7 +1153,7 @@ static int allocate_threshold_blocks(unsigned int cpu, struct threshold_bank *tb
 	else
 		tb->blocks = b;
 
-	err = kobject_init_and_add(&b->kobj, &threshold_ktype, tb->kobj, get_name(bank, b));
+	err = kobject_init_and_add(&b->kobj, &threshold_ktype, tb->kobj, get_name(cpu, bank, b));
 	if (err)
 		goto out_free;
 recurse:
@@ -1198,7 +1208,7 @@ static int threshold_create_bank(struct threshold_bank **bp, unsigned int cpu,
 	struct device *dev = this_cpu_read(mce_device);
 	struct amd_northbridge *nb = NULL;
 	struct threshold_bank *b = NULL;
-	const char *name = get_name(bank, NULL);
+	const char *name = get_name(cpu, bank, NULL);
 	int err = 0;
 
 	if (!dev)
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 720df7b4d6ab..39ffde96a343 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -1166,20 +1166,10 @@ static void decode_mc6_mce(struct mce *m)
 /* Decode errors according to Scalable MCA specification */
 static void decode_smca_error(struct mce *m)
 {
-	struct smca_hwid *hwid;
-	enum smca_bank_types bank_type;
+	enum smca_bank_types bank_type = smca_get_bank_type(m->extcpu, m->bank);
 	const char *ip_name;
 	u8 xec = XEC(m->status, xec_mask);
 
-	if (m->bank >= ARRAY_SIZE(smca_banks))
-		return;
-
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

