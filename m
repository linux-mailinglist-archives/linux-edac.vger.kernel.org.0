Return-Path: <linux-edac+bounces-5036-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E49D9BD5F84
	for <lists+linux-edac@lfdr.de>; Mon, 13 Oct 2025 21:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB2DE4F4046
	for <lists+linux-edac@lfdr.de>; Mon, 13 Oct 2025 19:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035AB285C84;
	Mon, 13 Oct 2025 19:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b0ypWHC3"
X-Original-To: linux-edac@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011043.outbound.protection.outlook.com [52.101.62.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F336429E0E1;
	Mon, 13 Oct 2025 19:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760384269; cv=fail; b=JdyHZVs48CvN98Wq+VA7FSme/ceFKcQaTA1yQf8AP77pvGGhGA2oT9wMWwIrOZ7qFiZOop6WaMTJvpj+dJjZj3P3nX8ZHvbHzSECW0tWimgC8MpxUxbfve+oboIjXr0tWvS43dS9goRo/wMkU/Ci6QcbHAyC6HQ5ePnbY4GmR4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760384269; c=relaxed/simple;
	bh=fmHe6bfL64nDGNj0u3+1fSiK+mmoYEv/EVwOj/WW5mo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eqtBMVue/stKwDmpaega75Jdt+W9bkr/7EpzFXdfInqkDmWRXP+l5gk3FYaz5fKUQIphKuD0tQUdVhhET+njbwgar/KYAnLFtCnLV++j5Wt3epsr2Qlqj8omJ7O4XDFim7meDaI4vRAnmS369mA7D3SXmWI/d5+HC/Hy4yEJnA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b0ypWHC3; arc=fail smtp.client-ip=52.101.62.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwmeN5+QNBAntib+e1ijbjV8Fk7dW8hVhZKbXNXeLJ5G/tO2ITVvZp8L4xvSMrYGJgw6XN7aXDeNOHshFDXkeEWsa2jHPC7vsGj3xSA06GZVDL/WgyXpj/oJ64E2dzpkxcrZTUuQ3WC8RSBSpb1asuUsJG7aG0MztxKMJpbmRbiPXYEBLauQkQ4rOF808xdg991hnYu0KyimuKGqO29IoFawB28TsEPt94eZ54thuTGxVQ094A0dPKgzwc2CbdsA/EpFhP6Cia1X1boGO9EPOO3GoHLBgm4tXkZ1+I6KogoIYl88Adg2sU1iXTXWBqBAhLNjLmb+Lbei9KLkeUl+Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyl0VD4Csmoz1eDpjo1nZwY3eOSxSZRl2lmZQRdRIMk=;
 b=ZG1XgdL1W71qhs4Lxi4VzxYPFZjQxoVDeDxwWfjbfwiwFVI6+lzt/aY0xNvjw45EVv2P71wizCXhYVGlw47rRw4Lvrf2vb7z3jJgD9EaqgrNA5niPk2V0TeXbH1BgGmC8RixbK7UsEIk9oARp694DJN9cdldU26e4Hdu2yrACiCFwl55Nt9AQAC4eEDwU1uPzCf6mcooE1LwXSXRTaIR+4VdHakHmVqgTfPVy27bXZTuDnPU4OuwEnz90RQKi2e/kt7zqIbVUhvnHdptqPgvmi8IBAyYxUMCmBj4V4Fe46lHTV/cIBd+8G9z/JYgOfgClMffBlbuRfW02Xw5tmFbhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyl0VD4Csmoz1eDpjo1nZwY3eOSxSZRl2lmZQRdRIMk=;
 b=b0ypWHC3d2400JiWOG9q195k4+qj6PzXupS9HTPkNaTfoFocTQlT+ChtTK+D47Kojnz7rLPKqLHvsj2EWFKDlDMsdQdC0gltRmaESw7gLnL6jKW3CLcLCN5mKIPkVgFHFKcKwl8bzwLG2kh3dzVSxa6IcpJ4OcWLOIKu3JfyltY=
Received: from MN2PR05CA0020.namprd05.prod.outlook.com (2603:10b6:208:c0::33)
 by IA1PR12MB8223.namprd12.prod.outlook.com (2603:10b6:208:3f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 19:37:45 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:c0:cafe::8d) by MN2PR05CA0020.outlook.office365.com
 (2603:10b6:208:c0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.8 via Frontend Transport; Mon,
 13 Oct 2025 19:37:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 19:37:44 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 13 Oct 2025 12:37:43 -0700
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <bp@alien8.de>, <yazen.ghannam@amd.com>, <john.allen@amd.com>,
	<linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>
Subject: [PATCH v3 1/2] RAS/AMD/ATL: Translate UMC normalized address to DRAM address using PRM
Date: Mon, 13 Oct 2025 19:34:48 +0000
Message-ID: <20251013193726.2221539-2-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251013193726.2221539-1-avadhut.naik@amd.com>
References: <20251013193726.2221539-1-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|IA1PR12MB8223:EE_
X-MS-Office365-Filtering-Correlation-Id: eecdc0fe-7d2e-4344-8be9-08de0a8ffb7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9J+wm5lpU1yOIGlZ3Bp5aqvy+WDjmTds/oEJew9OVJR50mBPNNGej68HeYhQ?=
 =?us-ascii?Q?cBWcIM7GdALZhI2bLEGWPpdOGJJPeWFQDqvY1a+CFCYzmCtArnI+wthW9/K+?=
 =?us-ascii?Q?eDvQLyToDEnP4KcJPlMBHB0nggMf12q9FLS7QZY8APJwKPIntuC/+CKWvAWI?=
 =?us-ascii?Q?XGNuCCFot+fu9RwH5hj3Ge0532Kg9TywR6QSvCce4kK8q3MvAhYorBkazBvN?=
 =?us-ascii?Q?imXBxC+R2YdD0pbiXl7VFI3nwhrSD8jPXRAnAnyVC454xJQE6fclLTffD2oh?=
 =?us-ascii?Q?mgiKhfMNktkdiRHArXUIvilNZ2F9agZZ+eTjvqyKqC345zX9awxBJjeJpyCO?=
 =?us-ascii?Q?vcOjrIICT+aSZhvnVSDJcYa25JGcgWLMS95tBB+pVdXGspLmhYwd26kn8XLP?=
 =?us-ascii?Q?ToqdrNq5mos2HE5FfmqOc1JWWtc0yA9jc+DLrEBM7p1vM3kRJc1jazdyRato?=
 =?us-ascii?Q?nBoP6GdlXVF7hFcH0Jhc0tPCnH7rJcKgEfQupdaAOhU35MSQdkmdIw4DcKs1?=
 =?us-ascii?Q?Gf2jgikyVDXZdBeW+addwXvWPdWKKcYovp3QhXYC6FFhsql1y6++7FgMDWI/?=
 =?us-ascii?Q?ZYeUt2Ot5PIrXVmcXfDPlMJEpLVXVECuje37MSyvXyQBMiWdWmfc8Pb4CPrX?=
 =?us-ascii?Q?yCFYZKn0rmw/IFYYUs277NzhuimsXSykr/KLXfJNBFnIAC7+ME509OvExg4p?=
 =?us-ascii?Q?MAv4tBhWHA/VpG5yQCIRfe9wklyy2ikwK6AvGEhQqcLUjT46bZwzpiIa+Y5Y?=
 =?us-ascii?Q?ImiKjbDvlE0mvqFTIYwnuyJhRvefGAZkSm7x5HkECZ9RfwhnB0k76M4rTCfU?=
 =?us-ascii?Q?Wm9OoTUma0YOcfSpNfW13pNSosWRCB0vxr/vx945s0q6ZhoNhMkVV+PgtZAI?=
 =?us-ascii?Q?xUtB8XhSzH/9UjnulNSrXt7ahO8pCynX+LI607MKBgcXLh9eL+mStsdfAkLz?=
 =?us-ascii?Q?E60Eg12tO5e9WB+vi84QxqSbewWvcU4FN4Kn2/o7YEmteUYtLDiUolm2cWHF?=
 =?us-ascii?Q?iOZ5WwUBNv+QYbWfy3E7O1FlBtJeF1iERfNsVea6WEi4uFMnwjM4EQloYXI5?=
 =?us-ascii?Q?/eV1+TD1FCdbKG3/CI1iJiDjqAt3dNcHeJ8UCakFDUZvXSdrnZKkPmjtji9q?=
 =?us-ascii?Q?gO9l84Fc5JsbgAkf3C5uCxxKghyI3eDfzor8GXWK2KGlYkJGEnXXdK/qWq0H?=
 =?us-ascii?Q?FSjM3IUixoHS+RPrPVAFbWmq681JWzbOyoGOh1wwmhUU+LVtXBrOhlkN46Q/?=
 =?us-ascii?Q?UVIzmM2rFWDz16gfO6FOnxnV8EWeTI43jf7anTpLMoPXWlGo1Q4FGK7faGT7?=
 =?us-ascii?Q?h+bbDXq8JJKZoWoA/K313ldv65ExZi3mnRI8Vf2dmLo5U387D9R8VwhC2631?=
 =?us-ascii?Q?Vihj5IQ53I7P6Ek9AdXN5d718PtN7a9RlzGfMUtvuIoo01oaFI/9YEgTBfMw?=
 =?us-ascii?Q?zbWPoewR7wwNoDgiDHFCgV6th2T2ayXBGjarpRRkpy8KxdvsRAzgq53Nl32Z?=
 =?us-ascii?Q?FpAQ8cpuNF3CdXPiRvw6uHsbirL8cGxvJXZ2Dhtomk81FCTnjPRbyOsMzHw7?=
 =?us-ascii?Q?Kq51Y5bdlEt5zHr++fA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 19:37:44.8599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eecdc0fe-7d2e-4344-8be9-08de0a8ffb7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8223

Modern AMD SOCs provide UEFI PRM module that implements various address
translation PRM handlers.[1] These handlers can be invoked by the OS or
hypervisor at runtime to perform address translations.

On AMD's Zen-based SOCs, Unified Memory Controller (UMC) relative
"normalized" address is reported through MCA_ADDR of UMC SMCA bank type
on occurrence of a DRAM ECC error. This address must be converted into
system physical address and DRAM address to export additional information
about the error.

Add support to convert normalized address into DRAM address through the
appropriate PRM handler. Instead of logging the translated DRAM address
locally, register the translating function when the Address Translation
library is initialized. Modules like amd64_edac can then invoke the PRM
handler to add the DRAM address to their error records. Additionally, it
can also be exported through the RAS tracepont.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=220577

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Changes in v2:
1. Modified the commit message and linked kernel bugzilla as reference.
2. Removed unnecessary variables.
3. Renamed struct dram_addr to atl_dram_addr.

Changes in v3:
1. Rebase on top of edac-for-next.
2. Add Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/ras/amd/atl/core.c     |  3 ++-
 drivers/ras/amd/atl/internal.h |  9 +++++++++
 drivers/ras/amd/atl/prm.c      | 36 ++++++++++++++++++++++++++++++----
 drivers/ras/amd/atl/umc.c      |  9 +++++++++
 drivers/ras/ras.c              | 18 +++++++++++++++--
 include/linux/ras.h            | 19 +++++++++++++++++-
 6 files changed, 86 insertions(+), 8 deletions(-)

diff --git a/drivers/ras/amd/atl/core.c b/drivers/ras/amd/atl/core.c
index 4197e10993ac..ca1646d030ca 100644
--- a/drivers/ras/amd/atl/core.c
+++ b/drivers/ras/amd/atl/core.c
@@ -207,7 +207,8 @@ static int __init amd_atl_init(void)
 
 	/* Increment this module's recount so that it can't be easily unloaded. */
 	__module_get(THIS_MODULE);
-	amd_atl_register_decoder(convert_umc_mca_addr_to_sys_addr);
+	amd_atl_register_decoder(convert_umc_mca_addr_to_sys_addr,
+				 convert_umc_mca_addr_to_dram_addr);
 
 	pr_info("AMD Address Translation Library initialized\n");
 	return 0;
diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
index 2b6279d32774..3dad1a5860d6 100644
--- a/drivers/ras/amd/atl/internal.h
+++ b/drivers/ras/amd/atl/internal.h
@@ -279,18 +279,27 @@ int dehash_address(struct addr_ctx *ctx);
 
 unsigned long norm_to_sys_addr(u8 socket_id, u8 die_id, u8 coh_st_inst_id, unsigned long addr);
 unsigned long convert_umc_mca_addr_to_sys_addr(struct atl_err *err);
+int convert_umc_mca_addr_to_dram_addr(struct atl_err *err, struct atl_dram_addr *dram_addr);
 
 u64 add_base_and_hole(struct addr_ctx *ctx, u64 addr);
 u64 remove_base_and_hole(struct addr_ctx *ctx, u64 addr);
 
 #ifdef CONFIG_AMD_ATL_PRM
 unsigned long prm_umc_norm_to_sys_addr(u8 socket_id, u64 umc_bank_inst_id, unsigned long addr);
+int prm_umc_norm_to_dram_addr(u8 socket_id, u64 bank_id,
+			      unsigned long addr, struct atl_dram_addr *dram_addr);
 #else
 static inline unsigned long prm_umc_norm_to_sys_addr(u8 socket_id, u64 umc_bank_inst_id,
 						     unsigned long addr)
 {
        return -ENODEV;
 }
+
+static inline int prm_umc_norm_to_dram_addr(u8 socket_id, u64 bank_id,
+					    unsigned long addr, struct atl_dram_addr *dram_addr)
+{
+	return -ENODEV;
+}
 #endif
 
 /*
diff --git a/drivers/ras/amd/atl/prm.c b/drivers/ras/amd/atl/prm.c
index 0931a20d213b..02c47c27690b 100644
--- a/drivers/ras/amd/atl/prm.c
+++ b/drivers/ras/amd/atl/prm.c
@@ -19,10 +19,11 @@
 #include <linux/prmt.h>
 
 /*
- * PRM parameter buffer - normalized to system physical address, as described
- * in the "PRM Parameter Buffer" section of the AMD ACPI Porting Guide.
+ * PRM parameter buffer - normalized to system physical address and normalized
+ * to DRAM address, as described in the "PRM Parameter Buffer" section of the
+ * AMD ACPI Porting Guide.
  */
-struct norm_to_sys_param_buf {
+struct prm_parameter_buffer {
 	u64 norm_addr;
 	u8 socket;
 	u64 bank_id;
@@ -33,9 +34,13 @@ static const guid_t norm_to_sys_guid = GUID_INIT(0xE7180659, 0xA65D, 0x451D,
 						 0x92, 0xCD, 0x2B, 0x56, 0xF1,
 						 0x2B, 0xEB, 0xA6);
 
+static const guid_t norm_to_dram_guid = GUID_INIT(0x7626C6AE, 0xF973, 0x429C,
+						 0xA9, 0x1C, 0x10, 0x7D, 0x7B,
+						 0xE2, 0x98, 0xB0);
+
 unsigned long prm_umc_norm_to_sys_addr(u8 socket_id, u64 bank_id, unsigned long addr)
 {
-	struct norm_to_sys_param_buf p_buf;
+	struct prm_parameter_buffer p_buf;
 	unsigned long ret_addr;
 	int ret;
 
@@ -55,3 +60,26 @@ unsigned long prm_umc_norm_to_sys_addr(u8 socket_id, u64 bank_id, unsigned long
 
 	return ret;
 }
+
+int prm_umc_norm_to_dram_addr(u8 socket_id, u64 bank_id,
+			      unsigned long addr, struct atl_dram_addr *dram_addr)
+{
+	struct prm_parameter_buffer p_buf;
+	int ret;
+
+	p_buf.norm_addr	= addr;
+	p_buf.socket	= socket_id;
+	p_buf.bank_id	= bank_id;
+	p_buf.out_buf	= dram_addr;
+
+	ret = acpi_call_prm_handler(norm_to_dram_guid, &p_buf);
+	if (!ret)
+		return ret;
+
+	if (ret == -ENODEV)
+		pr_debug("PRM module/handler not available.\n");
+	else
+		pr_notice_once("PRM DRAM Address Translation failed.\n");
+
+	return ret;
+}
diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
index 6e072b7667e9..3f53f90dadc0 100644
--- a/drivers/ras/amd/atl/umc.c
+++ b/drivers/ras/amd/atl/umc.c
@@ -427,3 +427,12 @@ unsigned long convert_umc_mca_addr_to_sys_addr(struct atl_err *err)
 
 	return norm_to_sys_addr(socket_id, die_id, coh_st_inst_id, addr);
 }
+
+int convert_umc_mca_addr_to_dram_addr(struct atl_err *err, struct atl_dram_addr *dram_addr)
+{
+	u8 socket_id = topology_physical_package_id(err->cpu);
+	unsigned long addr = get_addr(err->addr);
+	u64 bank_id = err->ipid;
+
+	return prm_umc_norm_to_dram_addr(socket_id, bank_id, addr, dram_addr);
+}
diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index ac0e132ccc3e..94f767be08ee 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -19,15 +19,20 @@
  */
 static unsigned long (*amd_atl_umc_na_to_spa)(struct atl_err *err);
 
-void amd_atl_register_decoder(unsigned long (*f)(struct atl_err *))
+static int (*amd_atl_umc_na_to_dram_addr)(struct atl_err *err, struct atl_dram_addr *dram_addr);
+
+void amd_atl_register_decoder(unsigned long (*f1)(struct atl_err *),
+			      int (*f2)(struct atl_err *, struct atl_dram_addr *))
 {
-	amd_atl_umc_na_to_spa = f;
+	amd_atl_umc_na_to_spa = f1;
+	amd_atl_umc_na_to_dram_addr = f2;
 }
 EXPORT_SYMBOL_GPL(amd_atl_register_decoder);
 
 void amd_atl_unregister_decoder(void)
 {
 	amd_atl_umc_na_to_spa = NULL;
+	amd_atl_umc_na_to_dram_addr = NULL;
 }
 EXPORT_SYMBOL_GPL(amd_atl_unregister_decoder);
 
@@ -39,6 +44,15 @@ unsigned long amd_convert_umc_mca_addr_to_sys_addr(struct atl_err *err)
 	return amd_atl_umc_na_to_spa(err);
 }
 EXPORT_SYMBOL_GPL(amd_convert_umc_mca_addr_to_sys_addr);
+
+int amd_convert_umc_mca_addr_to_dram_addr(struct atl_err *err, struct atl_dram_addr *dram_addr)
+{
+	if (!amd_atl_umc_na_to_dram_addr)
+		return -EINVAL;
+
+	return amd_atl_umc_na_to_dram_addr(err, dram_addr);
+}
+EXPORT_SYMBOL_GPL(amd_convert_umc_mca_addr_to_dram_addr);
 #endif /* CONFIG_AMD_ATL */
 
 #define CREATE_TRACE_POINTS
diff --git a/include/linux/ras.h b/include/linux/ras.h
index a64182bc72ad..f489da8b4722 100644
--- a/include/linux/ras.h
+++ b/include/linux/ras.h
@@ -42,15 +42,32 @@ struct atl_err {
 	u32 cpu;
 };
 
+struct atl_dram_addr {
+	u8 chip_select;
+	u8 bank_group;
+	u8 bank_addr;
+	u32 row_addr;
+	u16 col_addr;
+	u8 rank_mul;
+	u8 sub_ch;
+} __packed;
+
 #if IS_ENABLED(CONFIG_AMD_ATL)
-void amd_atl_register_decoder(unsigned long (*f)(struct atl_err *));
+void amd_atl_register_decoder(unsigned long (*f1)(struct atl_err *),
+			      int (*f2)(struct atl_err *, struct atl_dram_addr *));
 void amd_atl_unregister_decoder(void);
 void amd_retire_dram_row(struct atl_err *err);
 unsigned long amd_convert_umc_mca_addr_to_sys_addr(struct atl_err *err);
+int amd_convert_umc_mca_addr_to_dram_addr(struct atl_err *err, struct atl_dram_addr *dram_addr);
 #else
 static inline void amd_retire_dram_row(struct atl_err *err) { }
 static inline unsigned long
 amd_convert_umc_mca_addr_to_sys_addr(struct atl_err *err) { return -EINVAL; }
+static inline int amd_convert_umc_mca_addr_to_dram_addr(struct atl_err *err,
+							struct atl_dram_addr *dram_addr)
+{
+	return -EINVAL;
+}
 #endif /* CONFIG_AMD_ATL */
 
 #endif /* __RAS_H__ */
-- 
2.43.0


