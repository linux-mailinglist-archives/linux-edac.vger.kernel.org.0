Return-Path: <linux-edac+bounces-1591-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BFF941F8D
	for <lists+linux-edac@lfdr.de>; Tue, 30 Jul 2024 20:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 389461C2319E
	for <lists+linux-edac@lfdr.de>; Tue, 30 Jul 2024 18:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5117B18C905;
	Tue, 30 Jul 2024 18:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lqHTWQDd"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8878378276;
	Tue, 30 Jul 2024 18:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722364219; cv=fail; b=UbPfJ58JXYOkUQNVnmtVe+4BquDRPQ1xt3Xg0gKmoNB749U9AwOj25OebQQ/joyXzcAWf/WRzNgIQuKayOzAC0zO2CeSsTVJszGa134zYjgPwdrn5vJlYrS/cqQmXnDUfLMvY+VYkwX6Ilb6WviRTRnxAE4VfNnr1skd3RH+eXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722364219; c=relaxed/simple;
	bh=FhG2EaK89ZCaeaJMR/EkMCZ2Fx1B3Lncn96hLUxg7Bc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lAAeZcJo3ACWlMnyvbZolCaq2l0WY9zD6u3VUrmTu+5/P1z/q8FCVB7NbPEOukQ621QW4d772kM78cPe6h75NBVzz5spi8arBzTw0inVgtEadKPETuPRgjl4iRe+5zR+15b5hWOY3LKrMK+K1sR/3Yn9s32TatE+Fq/gy8zqY1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lqHTWQDd; arc=fail smtp.client-ip=40.107.237.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XGvqdhjxeXVru9OZZgXn+4TJF75tE+86ubSxFD4xCW6tiZCXMPFo0RWTXDPWE6cbpxFyGnDNcaF9gf1rZaROAjlhiFRfoDldNK+3Zf/kLdmqdUGqCqNxCKmNXdFuvKcbWJjYhXuGYMf7RrzHJYNp3X5oV/5SRanaoX88YCXVTE4ZrW4K1F6YeUMmTN1e3jvG/EdvAi7CmPcgSmjCQyiSb68WtY1PgxmHURjnQXhihkOtbI8sQw94kFdWJMwSc/ObpKzoPf/whrkDs7lo+RGNYiJlp0C3XZzZVR/xRU2q/LPb1Wd02oeugZUGEaP7fmCtmTCUvfSPni4WuGlR+3qGIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPFqe9F+rCoO3WkMPy5xiZAq79F7uQHDhquXHSOBObI=;
 b=i7QrTRVDw4QeL0kA3Sxs5mntRJ6NvnHVXVE7I1iu202dx3gycI6aDyaNvgDMoM2ijPyw0nQrDaA1JggpDT5LhtbUnV2rOfWWSi6csTN9hWGTcr1aTQZydFt0w0Fi0gH/LNWtAMIT5977MnfOx5J23FJJH6ob2+xLN6pKODSyJpXLOMOTkn4b1SsVGqHnGI9+XCTNdM49rVkCPn2wUaR0XoVltKuYAJAoLNXVoVI52tLaOArSfALjn6I3LtLCbh/OOy5CAhUjI6BiHm3U26CK/MggqbXc4fDeldDboYE/N2FSUrrqsMM1l+j9qcQNFm+LJ7AjmjVM3E4fqh3Rmo1bOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPFqe9F+rCoO3WkMPy5xiZAq79F7uQHDhquXHSOBObI=;
 b=lqHTWQDdry6sMu2vYHGRE0Jb0agfzZsBtsILwfiUPxzhjfIygZDoJYwHKCmSpANgtti2Hl9KuZFmKF4NOFgez+vxpfsROPEcah/FmuPDKRV5jXLvNv7VLdSmGJzy0Ny8bBlgRYAACcfX9bBJ64Dd8Dvhk8n7DHQZpSBTi+w+ATA=
Received: from SA0PR11CA0012.namprd11.prod.outlook.com (2603:10b6:806:d3::17)
 by SJ2PR12MB8737.namprd12.prod.outlook.com (2603:10b6:a03:545::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 18:30:13 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:d3:cafe::c7) by SA0PR11CA0012.outlook.office365.com
 (2603:10b6:806:d3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Tue, 30 Jul 2024 18:30:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 18:30:12 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 13:30:09 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<avadhut.naik@amd.com>, <john.allen@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Borislav Petkov <bp@alien8.de>
Subject: [PATCH v3 1/3] x86/mce: Rename mce_setup() to mce_prep_record()
Date: Tue, 30 Jul 2024 13:29:56 -0500
Message-ID: <20240730182958.4117158-2-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730182958.4117158-1-yazen.ghannam@amd.com>
References: <20240730182958.4117158-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|SJ2PR12MB8737:EE_
X-MS-Office365-Filtering-Correlation-Id: 21e4d367-7d7e-492a-7cbb-08dcb0c5a6a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f7Uc7nAMEGhbo7MqFd5vhA9CwS5+q0fC69yiE9GSq0PZn7a8k43+odFRrQe1?=
 =?us-ascii?Q?oR8Nrwa+bT30FbLV/4Qfd3/G9hA30ThjTbASMN+pe09AK3fHn8bMnefvMK0m?=
 =?us-ascii?Q?LUm3pxFAZlfftEQR2Mvo6PHSSPk1C1dmzoMf2X64xBGni/DQ6A65gLxJvNwu?=
 =?us-ascii?Q?GvJ/1T+yS+hDX6Li9QKDStVIll9xkkCUxgrfxvJUz0hlTZO7AvWhT8DKI6Ok?=
 =?us-ascii?Q?MgWSLdNLcCGTOVy9bdktBzKayUcZtqQT+/agr1dc35lFkI0745loGUEC4Ine?=
 =?us-ascii?Q?FF7YI3auKiIK0sjQ7LCSTbmPGF+WaJm9qdcfi68an0gHrp2Rn3+5lzJyvISm?=
 =?us-ascii?Q?skI3oZGknwj/zinedrMcNIM+Rmx3M834zAgZyP8d8gVc7dYlrQGVkCUEeMoG?=
 =?us-ascii?Q?tcEA4gahiZi9LMknfnX1E1Y4YeSuW8l3VlmB4w50vNe+8FpbjpXsTM4IQeyT?=
 =?us-ascii?Q?tsXJoBHSYUgQ2Nop8qP3smYYPMcYLdNkhrosptZBogirP8uBO87Als/Xr+wo?=
 =?us-ascii?Q?NPdpmNNiGHC3d0BSgwrgs9UK8RjDHv3herv0m+t3vNjTmfQABEryK5P3arPA?=
 =?us-ascii?Q?8+wsnQVCp4/l0kN6v06XfJVljmZX9UgIJ177olhRV+wqMeSyUQ6sd+UJCtuR?=
 =?us-ascii?Q?i3TxxPWCC3fJGFdtyYmGgGn708fptZPjmbgcSwTog7kRbzcOxowB1lodiYBt?=
 =?us-ascii?Q?pEBQzzyyzP0G2NYojT0orc+QJr60A65aiYflXvs6RXbTjnncssyP37/47HPj?=
 =?us-ascii?Q?ga2Yjzw2oW3nB2ZwEpPBsvluI5IBmPkU5XX624KKKpgPGNLAOhcma9JL6wsg?=
 =?us-ascii?Q?g7HD0TAyKWAEUrmvKiNpigasJJngHpSq052UIZvVzsi9HWzNeWrIQU6SSwcF?=
 =?us-ascii?Q?YEoziSQPgqtYa4afFlvR5ec4jpdjMIoHAjVIdpvURCduLiXKc+4R2FNfa2jN?=
 =?us-ascii?Q?LgABed1BAHupLE4H/HIKy0ZQvbhmJRPwHkE4Q4wUxnEOY5wbo4nzSQ3CRuWH?=
 =?us-ascii?Q?1Z1TFkBH1iIWvtFHBBaLBRmYwZN4aWhh5PPtB67MArUSMAEwpL7IDuULd17h?=
 =?us-ascii?Q?fcXb3gk+3P5RvmXcC83oSEsNwCnVvk0pDSLIQwQabJY2dKQb+YWAVjHQFvP5?=
 =?us-ascii?Q?QLx6EszcDMSBIOuPXQRR2wd4YKNx1bTWQm6xzqgQQo7Ts0FzaTYsGcejNYo1?=
 =?us-ascii?Q?c3Z91Bv6Q61jhGKLiBQyA9rjfVtMADT2cfJ+yxtyH9oX4i7JGmz1wbZVS61h?=
 =?us-ascii?Q?x2Z1E4CTM5qDnQe7zw0BXBAyvaBUQKo8eLDoa3qjZKc4UId12y2VSui+IuxF?=
 =?us-ascii?Q?hZKiiEwrJx7MHv7J/VUa257UqebG7H3fCeYiiCak82H9TTP7IRrjNwZbxKAh?=
 =?us-ascii?Q?04UcawvXpIS9LWaDspzdosbBnV9r?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 18:30:12.9633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e4d367-7d7e-492a-7cbb-08dcb0c5a6a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8737

There is no MCE "setup" done in mce_setup(). Rather this function
initializes and prepares an MCE record.

Rename the function to highlight what it does.

No functional change is intended.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20240624212008.663832-4-yazen.ghannam@amd.com

v2->v3:
* No change.

v1->v2:
* No change.

 arch/x86/include/asm/mce.h     | 2 +-
 arch/x86/kernel/cpu/mce/amd.c  | 2 +-
 arch/x86/kernel/cpu/mce/apei.c | 4 ++--
 arch/x86/kernel/cpu/mce/core.c | 6 +++---
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 3ad29b128943..3b9970117a0f 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -221,7 +221,7 @@ static inline int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
 					     u64 lapic_id) { return -EINVAL; }
 #endif
 
-void mce_setup(struct mce *m);
+void mce_prep_record(struct mce *m);
 void mce_log(struct mce *m);
 DECLARE_PER_CPU(struct device *, mce_device);
 
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 9a0133ef7e20..14bf8c232e45 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -780,7 +780,7 @@ static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
 {
 	struct mce m;
 
-	mce_setup(&m);
+	mce_prep_record(&m);
 
 	m.status = status;
 	m.misc   = misc;
diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 7f7309ff67d0..8f509c8a4e98 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -44,7 +44,7 @@ void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
 	else
 		lsb = PAGE_SHIFT;
 
-	mce_setup(&m);
+	mce_prep_record(&m);
 	m.bank = -1;
 	/* Fake a memory read error with unknown channel */
 	m.status = MCI_STATUS_VAL | MCI_STATUS_EN | MCI_STATUS_ADDRV | MCI_STATUS_MISCV | 0x9f;
@@ -97,7 +97,7 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 	if (ctx_info->reg_arr_size < 48)
 		return -EINVAL;
 
-	mce_setup(&m);
+	mce_prep_record(&m);
 
 	m.extcpu = -1;
 	m.socketid = -1;
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index b85ec7a4ec9e..dd5192ef52e0 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -118,7 +118,7 @@ static struct irq_work mce_irq_work;
 BLOCKING_NOTIFIER_HEAD(x86_mce_decoder_chain);
 
 /* Do initial initialization of a struct mce */
-void mce_setup(struct mce *m)
+void mce_prep_record(struct mce *m)
 {
 	memset(m, 0, sizeof(struct mce));
 	m->cpu = m->extcpu = smp_processor_id();
@@ -436,11 +436,11 @@ static noinstr void mce_wrmsrl(u32 msr, u64 v)
 static noinstr void mce_gather_info(struct mce *m, struct pt_regs *regs)
 {
 	/*
-	 * Enable instrumentation around mce_setup() which calls external
+	 * Enable instrumentation around mce_prep_record() which calls external
 	 * facilities.
 	 */
 	instrumentation_begin();
-	mce_setup(m);
+	mce_prep_record(m);
 	instrumentation_end();
 
 	m->mcgstatus = mce_rdmsrl(MSR_IA32_MCG_STATUS);
-- 
2.34.1


