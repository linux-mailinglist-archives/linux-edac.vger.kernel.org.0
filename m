Return-Path: <linux-edac+bounces-2092-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 145F89A019B
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 08:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6448AB25177
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 06:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3C51B0137;
	Wed, 16 Oct 2024 06:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2K2QBi94"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A02A18C93B;
	Wed, 16 Oct 2024 06:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729060896; cv=fail; b=MLcd7otf0i/V3GBJ16Khux6wd4yxC/HLpn3OjyESIvAGl1ay3SpH3I7w3hSlynl2j7r6+j68BTIwNOUW1kQ5yTy3laMQKK6Wtz0yinZ7vQDyEvdj91Zk21jnyPhY4cXiuqQnF51LEQGZ2v2qum/qdnUgv9iKXr0jt9v3HAhHAn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729060896; c=relaxed/simple;
	bh=nZnTfP7D/JUBZ48e6ireRnopg1bzWIyrHbRnPBdRIV0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sfFDwYrjEd33g/A59sS7cH2EHDaOiggFhjwatPCBPDRmSFR+R99UNc+O4zk9MAiruZZLQF5K8CYskrByINcqN5z8QkuKXYdFCf2FOQ+YVWs489a4zs9cZXgzaInlVzTkgFhhu7/jNxWgiP3gnGEb/s4nB515fmV7WvaFo+ixGn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2K2QBi94; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R8gPO74Vfu5Q4e+2ZSkNVMyneNkoNTAnOkeqoZYnxGwqUFKCJ58K5ADmqEo1U8PBKj7Mz0AAr3gBvlrKIZmqlPoev351oZKy/3tLbONg5/lV8vCW4hueivpQR3LzVyWvyhHWpWa51vra89+YnrTTcKriCki7rZukoQS3J1sPCuaN8FZ0yq3vtGCfAJYIT9550SDxDZpBmXFzdhC8XlEieW4LlmDXMNM7ZaDyr5Njoq3ECefZw1uG4lMLLFls/i1tZf5GdFSamTVnYPQZOP/qBafpO+T0Bi1Rb65mhyla7Gvg5Gza5Bqp3kgUDjgZIJNqA/cTpitQN5C4KQfn24tZ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94vue54+OnYWJRo8fRs+9t/0+QadbO5lCOwTy6UU7ws=;
 b=QBlx6hDa3KpFZCWXlqf2QK8bp470X9DUl8znvBRQz33NUPvSjfZCAHmbZyI7hOlWEsp5ML+QNpFZ8LTxLFQDuWb2ktBwjJSpTBJNTvXoTNe7TP1c+3kEEcI8M+AcNofBjnbi8HUYoBd6NMdnPInRHYi1RgxZlNpKWCJ90AAS9VDg953DkjMVl9IlBl2InJx6/7LXldvx+dWIc5g6wtVncq71qsK2awYk2qClLHtLYT97I4pNs+FMSjLIiZGiF/8ToyTxpX7nZGuPwJkZ3K0hNzki7cznL5fToW7VCv6no3o/63lUZ+YLQsw84tdB7h2NwQi0Zc5dAvIoVTa3f8S1kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94vue54+OnYWJRo8fRs+9t/0+QadbO5lCOwTy6UU7ws=;
 b=2K2QBi94qtLBwCR76oaW8cyZelzmId1hRLaVcOi8in5wHF7AJWynD0xOySd0mizwVuwAaaNAnprM8QypuYkU/37ZVsnrtMC9xOzUDMIwE1IRuJvpYI6TOlqX/+4AP9CGhvA4qyqD+GMSv5xNaZ53qAK48IMv3BED0BPKdXRjoRE=
Received: from CH5PR04CA0011.namprd04.prod.outlook.com (2603:10b6:610:1f4::27)
 by SN7PR12MB6792.namprd12.prod.outlook.com (2603:10b6:806:267::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 06:41:30 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::cf) by CH5PR04CA0011.outlook.office365.com
 (2603:10b6:610:1f4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Wed, 16 Oct 2024 06:41:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 06:41:29 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 01:41:28 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <x86@kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<qiuxu.zhuo@intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<rostedt@goodmis.org>, <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
	<john.allen@amd.com>, <avadhut.naik@amd.com>
Subject: [PATCH v6 5/5] EDAC/mce_amd: Add support for FRU Text in MCA
Date: Wed, 16 Oct 2024 06:36:31 +0000
Message-ID: <20241016064021.2773618-6-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016064021.2773618-1-avadhut.naik@amd.com>
References: <20241016064021.2773618-1-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|SN7PR12MB6792:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a0ea322-0a85-4f17-b11b-08dcedad911c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dCRmVQUqesNw57Jj1wQmpeJCGQvJPMI2mHDblS/QnFhJ5vYT7svzbRKWkdD3?=
 =?us-ascii?Q?Oz1IA/O5Synw5/1pFEYmxUnCR6Z52VfcmfYZXswKtgLvbjRSkcsTyEAzayDd?=
 =?us-ascii?Q?DjQ2GyAGTXZov4pHDO/1MTd+ATNOmvYxWUWqPhRqIhknb39PJAjipVyMZjNx?=
 =?us-ascii?Q?bJbBQpoeaEjVMSz4y09jEXo7cF3RTOlMwV1mslplANi/9fzUln4UMHRRf3xm?=
 =?us-ascii?Q?itXVuJhK1YPI3557UyB+m+OsIHB6yxDD0tM0LyWwEjI3utTshpZPjvomVMOq?=
 =?us-ascii?Q?D5BzilBLYkUntVllqeAmjJwnqaB2iYxNEE6YmqQInoyCcL134ancQWIjKbme?=
 =?us-ascii?Q?pBS9UHNxiHNHYesPuy1kCG0cT/SK2UNfvUV78uCZWLhzpPGovP0ArqyQ6gME?=
 =?us-ascii?Q?zrMEmunNZF/XKqmDeBu+yGT8OWAQ8tvKNmxZ+Q+t9OehEsA0oRF6rJNDBMnx?=
 =?us-ascii?Q?TVchM5D+DSFUD7hLsABrSLsikRcMpazchiTlI/PYfGR+TaQ476UaAPvAl5Qx?=
 =?us-ascii?Q?WKf3BkxSVu0fqNbqtsoOfFCdE20pnHyzp7rh7nMwAUYzd3NGKHAICIq90PkS?=
 =?us-ascii?Q?hSreO8OYJw1j9eG83GMF47kt22TTaMPonMV0JZhngHAWwajgTe/GxjlUy2ll?=
 =?us-ascii?Q?1ipBFuds4l4nWpBRiw2j/RQBSdoZg3KvyOSziwBTv8KKg0DfjspXN2EzFrwp?=
 =?us-ascii?Q?V0IvNvrCz/OvHB4KovE9qn1s5AU0hnyyTvvDCEtRm7CtBM4BcKFckWM1sQEk?=
 =?us-ascii?Q?b60nJwL4ybNN+0jPQmQC/luNt+RbEvaxoHSX2l4CC+qlwGtc0z4UeZftZMMf?=
 =?us-ascii?Q?8BvsUYBlh2bo4GYKKQ180guiBV3Y0lj1gEHSHZXd6kGtQA4AXDgUX8jzxtHZ?=
 =?us-ascii?Q?TDNcJgKqD2PuleRGMx75EsxOTEt5lYFkcapaZ8JgNDyIv8qj6nnX2ZLPotwP?=
 =?us-ascii?Q?aPFjnILuAcT3lyF1aCE50V4OO3tva7iJiMapC6RukCpkxav0/iUAlNzo+yGb?=
 =?us-ascii?Q?qrBaCBjfSDrdQLvuF1OfIan48dsTxTSuon5BWuX5A0ejWScVY/s6InTnD6nt?=
 =?us-ascii?Q?rsNakYOFRaSthk0tpORZnyO64Q8jH/AeILwkoL06CgxbNe1I0r1MCQKOX5Q4?=
 =?us-ascii?Q?z66Me9oBRQM+U/t6AYysBjqzJ4IZ2C93EY2wOlp2Bw2IKi6Pn3gBTRicCL+P?=
 =?us-ascii?Q?SJJv8ie+d7p8Xz87fP16QoQ8zHRJvtDAB/0SXTLFYUZs/83+BD9cyJggRn1T?=
 =?us-ascii?Q?cktt9AW4fdJpXtRQ9qI5mbTXUxgZzaAoyTacD/zBsVnJotqqS7Yk5VNw52Yo?=
 =?us-ascii?Q?9JapfTAxRhh2oF3Cn5MLdX4pwTNhsH77SqQNbONk9OU8KX4zGDv0GyJo7dyy?=
 =?us-ascii?Q?g7wALxkgRopkabJ4egYOPfawMH3P?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 06:41:29.8532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0ea322-0a85-4f17-b11b-08dcedad911c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6792

From: Yazen Ghannam <yazen.ghannam@amd.com>

A new "FRU Text in MCA" feature is defined where the Field Replaceable
Unit (FRU) Text for a device is represented by a string in the new
MCA_SYND1 and MCA_SYND2 registers. This feature is supported per MCA
bank, and it is advertised by the McaFruTextInMca bit (MCA_CONFIG[9]).

The FRU Text is populated dynamically for each individual error state
(MCA_STATUS, MCA_ADDR, et al.). This handles the case where an MCA bank
covers multiple devices, for example, a Unified Memory Controller (UMC)
bank that manages two DIMMs.

Since MCA_CONFIG[9] is instrumental in decoding FRU Text, it has to be
exported through the mce_record tracepoint so that userspace tools like
the rasdaemon can determine if FRU Text has been reported through the
MCA_SYND1 and MCA_SYND2 registers and output it.

[Yazen: Add Avadhut as co-developer for wrapper changes.]

Co-developed-by: Avadhut Naik <avadhut.naik@amd.com>
Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
---
Changes in v2:
[1] https://lore.kernel.org/linux-edac/20240521125434.1555845-1-yazen.ghannam@amd.com/
[2] https://lore.kernel.org/linux-edac/20240523155641.2805411-1-yazen.ghannam@amd.com/

1. Drop dependencies on sets [1] and [2] above and rebase on top of
tip/master.

Changes in v3:
1. Modify commit message per feedback provided.
2. Remove call to memset() for the string frutext. Instead, just ensure
that it is NULL terminated.
2. Fix SoB chain to properly reflect the patch path.

Changes in v4:
1. Rebase on top of tip/master to avoid merge conflicts.

Changes in v5:
1. No changes except rebasing on top of tip/master.

Changes in v6:
1. No changes except rebasing on top of tip/master.
---
 arch/x86/include/asm/mce.h     |  2 ++
 arch/x86/kernel/cpu/mce/amd.c  |  1 +
 arch/x86/kernel/cpu/mce/apei.c |  2 ++
 arch/x86/kernel/cpu/mce/core.c |  3 +++
 drivers/edac/mce_amd.c         | 21 ++++++++++++++-------
 5 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index c2466b20fe79..72a69ad7d692 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -61,6 +61,7 @@
  *  - TCC bit is present in MCx_STATUS.
  */
 #define MCI_CONFIG_MCAX		0x1
+#define MCI_CONFIG_FRUTEXT	BIT_ULL(9)
 #define MCI_IPID_MCATYPE	0xFFFF0000
 #define MCI_IPID_HWID		0xFFF
 
@@ -213,6 +214,7 @@ struct mce_hw_err {
 		struct {
 			u64 synd1;		/* MCA_SYND1 MSR */
 			u64 synd2;		/* MCA_SYND2 MSR */
+			u64 config;		/* MCA_CONFIG MSR */
 		} amd;
 	} vendor;
 };
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 6ca80fff1fea..65ace034af08 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -796,6 +796,7 @@ static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
 
 	if (mce_flags.smca) {
 		rdmsrl(MSR_AMD64_SMCA_MCx_IPID(bank), m->ipid);
+		rdmsrl(MSR_AMD64_SMCA_MCx_CONFIG(bank), err.vendor.amd.config);
 
 		if (m->status & MCI_STATUS_SYNDV) {
 			rdmsrl(MSR_AMD64_SMCA_MCx_SYND(bank), m->synd);
diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 0a89947e47bc..19a1c72fc2bf 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -155,6 +155,8 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 		fallthrough;
 	/* MCA_CONFIG */
 	case 4:
+		err.vendor.amd.config = *(i_mce + 3);
+		fallthrough;
 	/* MCA_MISC0 */
 	case 3:
 		m->misc = *(i_mce + 2);
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index b7f4a49a1053..923983009c61 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -208,6 +208,8 @@ static void __print_mce(struct mce_hw_err *err)
 			pr_cont("SYND2 %llx ", err->vendor.amd.synd2);
 		if (m->ipid)
 			pr_cont("IPID %llx ", m->ipid);
+		if (err->vendor.amd.config)
+			pr_cont("CONFIG %llx ", err->vendor.amd.config);
 	}
 
 	pr_cont("\n");
@@ -681,6 +683,7 @@ static noinstr void mce_read_aux(struct mce_hw_err *err, int i)
 
 	if (mce_flags.smca) {
 		m->ipid = mce_rdmsrl(MSR_AMD64_SMCA_MCx_IPID(i));
+		err->vendor.amd.config = mce_rdmsrl(MSR_AMD64_SMCA_MCx_CONFIG(i));
 
 		if (m->status & MCI_STATUS_SYNDV) {
 			m->synd = mce_rdmsrl(MSR_AMD64_SMCA_MCx_SYND(i));
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 194d9fd47d20..d69a1466f0bc 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -795,6 +795,7 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 	struct mce *m = (struct mce *)data;
 	struct mce_hw_err *err = to_mce_hw_err(m);
 	unsigned int fam = x86_family(m->cpuid);
+	u64 mca_config = err->vendor.amd.config;
 	int ecc;
 
 	if (m->kflags & MCE_HANDLED_CEC)
@@ -814,11 +815,7 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 		((m->status & MCI_STATUS_PCC)	? "PCC"	  : "-"));
 
 	if (boot_cpu_has(X86_FEATURE_SMCA)) {
-		u32 low, high;
-		u32 addr = MSR_AMD64_SMCA_MCx_CONFIG(m->bank);
-
-		if (!rdmsr_safe(addr, &low, &high) &&
-		    (low & MCI_CONFIG_MCAX))
+		if (mca_config & MCI_CONFIG_MCAX)
 			pr_cont("|%s", ((m->status & MCI_STATUS_TCC) ? "TCC" : "-"));
 
 		pr_cont("|%s", ((m->status & MCI_STATUS_SYNDV) ? "SyndV" : "-"));
@@ -853,8 +850,18 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 
 		if (m->status & MCI_STATUS_SYNDV) {
 			pr_cont(", Syndrome: 0x%016llx\n", m->synd);
-			pr_emerg(HW_ERR "Syndrome1: 0x%016llx, Syndrome2: 0x%016llx",
-				 err->vendor.amd.synd1, err->vendor.amd.synd2);
+			if (mca_config & MCI_CONFIG_FRUTEXT) {
+				char frutext[17];
+
+				frutext[16] = '\0';
+				memcpy(&frutext[0], &err->vendor.amd.synd1, 8);
+				memcpy(&frutext[8], &err->vendor.amd.synd2, 8);
+
+				pr_emerg(HW_ERR "FRU Text: %s", frutext);
+			} else {
+				pr_emerg(HW_ERR "Syndrome1: 0x%016llx, Syndrome2: 0x%016llx",
+					 err->vendor.amd.synd1, err->vendor.amd.synd2);
+			}
 		}
 
 		pr_cont("\n");
-- 
2.43.0


