Return-Path: <linux-edac+bounces-4807-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 265FCB586A7
	for <lists+linux-edac@lfdr.de>; Mon, 15 Sep 2025 23:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DA321AA8225
	for <lists+linux-edac@lfdr.de>; Mon, 15 Sep 2025 21:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCB42C0F66;
	Mon, 15 Sep 2025 21:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QZruqhFN"
X-Original-To: linux-edac@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6CE2C08AA;
	Mon, 15 Sep 2025 21:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757971395; cv=fail; b=c622B4u1T4exOw/JKZ4P/4gdS5kha+txhoOW5s7VSPJxRL1tNT+i+5fyop+jvgAEiIMIyejO3IHaxiuZ/8NHtnX5BVVSpEzcGL1v7uVcNkTkvo+OlKoOvYlDVb/5jVWK6obRRTu+PqKUsiiJgJ64/o3t5b8AwqNs39rO8Kddgas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757971395; c=relaxed/simple;
	bh=3RHd+406tCEbzR2PXVs3D2fJ8HRkldskQizzoDUr46Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CfpKXrhCeMh30F6relZWq6ef4/j5N3jhgRW+EPLmDR136Gsi51io1olMQvrrdkk93G5ewN7KF0VdxE6ibpFw81Y58CAq52fIheMTuk/W/sDFZjTieif6iAeFdWETxPHJYP8GWkFWkYDwneMtTgQWHFTWQyBAWRrrXrJQLI4Itf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QZruqhFN; arc=fail smtp.client-ip=52.101.52.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfaohdBiQU6kTwvA0Upi0LhcViLAoi0hQAkcKJuy+WMQzE2bmW1qwpWHKDm1xrjjc9ixLzdTQBqWlkolvKb/SlofWaiMWpCQGWY3RAy517I6egiYads+6RqkP1GwAXWvRARySuD6qEPf251HJFvhF+d/8kqPdflkLdc4qCG+6GwRAM8e3KT+d+ryQwE73nTxfHGzlb9cRXUfSeBA0prsYURuUHW+tQk0b1vEynIg1XHcOAXpq7uJm1hBWJO1uK3saXIXk2B4NB28GBSTeeHzKlq2yjnp1MC8AJYYUt0kvmLbd15ala5XVm9Fmypexa/UeQVy+rJsk9G0/oNvrQNLeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bp2zhCwXExKslqdY2c4A1OSrAObQsn81dZbthX2MteE=;
 b=E07LBaHinJdmrs5xICTdCRSfstZYhE10pE84F7Yui25nkUWbZvbL+huLYc2/beSD1Sak44aKUAM545zt5aBWfmeSga5aw4uNBys/s35RmRRABMaqwhW+YV0MlVmbg2ePSYcDH5bUxVTo/45Vwt1QlH98wJArBChs85D7voAHi4Xtvi1av/QS7QUOyqjslYEBdWI/iVeMxFKjzITlWxLyRhex1BaqXQubNGttLAdZWG0kWc2TzdGS/qo46h7FrmW1hos4LLA3CH7ILd0bh3Ua+9jb0jJoqiOr5Vjy5qtx5jlXepsoMWtVMGB8i7EOrBheVNLpmWOBBXh6t3TYNYv5lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bp2zhCwXExKslqdY2c4A1OSrAObQsn81dZbthX2MteE=;
 b=QZruqhFNRyXpi28tCtCkxEs+L4Vh7UuvH7buXCdsT1CkG5mmDgANWbeuZgF9Et+pd9VSkUYF/4I4d9M694z6EV2Gk3AS9xtgTaaZjSp/8Sya7Vr03ehzpzANpvr30EIuSkuAsCCHVxpONbpQMGNh1HwCZWmnxo/KYzzu4Wte3zY=
Received: from BN9PR03CA0657.namprd03.prod.outlook.com (2603:10b6:408:13b::32)
 by CY8PR12MB7516.namprd12.prod.outlook.com (2603:10b6:930:94::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 21:23:03 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:408:13b:cafe::63) by BN9PR03CA0657.outlook.office365.com
 (2603:10b6:408:13b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Mon,
 15 Sep 2025 21:23:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 21:23:02 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 15 Sep 2025 14:23:01 -0700
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <bp@alien8.de>, <yazen.ghannam@amd.com>, <john.allen@amd.com>,
	<linux-kernel@vger.kernel.org>, <avadnaik@amd.com>
Subject: [PATCH v2 1/2] RAS/AMD/ATL: Translate UMC normalized address to DRAM address using PRM
Date: Mon, 15 Sep 2025 21:20:22 +0000
Message-ID: <20250915212244.886668-2-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250915212244.886668-1-avadhut.naik@amd.com>
References: <20250915212244.886668-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|CY8PR12MB7516:EE_
X-MS-Office365-Filtering-Correlation-Id: ca4be648-1c0f-4102-ff2b-08ddf49e0da2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UJhbp99ACJrYNXHjK88EMM5uVRzEJqlKrnu7oYGRlSOiRoB8HL+7xyn0PL/l?=
 =?us-ascii?Q?HpmrNdOPhnN+vtKf+VKbjQxuYCbNNcc+8eOAdnma1kXRGuFtpxuLoSLMtkWu?=
 =?us-ascii?Q?VIIXrVsQKr99jGCmbjjNIU/swmMptVu/wXqeRyyqkh06ox7+1r65icjNvU7a?=
 =?us-ascii?Q?Oo+e3Dv5qcjGPhDmKuJUCBp9nSbDDxufwBhpZviz9oKfGoC1jW2BQk4N0LWM?=
 =?us-ascii?Q?L5Y9YcIXp5Is6Bn4XWE7I0kqfxKQRhhlfFS3IB6zdkrfsO6YcTKvBaFPf3E0?=
 =?us-ascii?Q?mXHoCtuuERfikL4wvO7SKrzIl7w+cIa7QMkNbfHsN/89xpti27wBgEDP14Vi?=
 =?us-ascii?Q?rMtZHn8pa+NiswKsyNFPVQ+8AiwFuBmqtH+cBW9L+Z2anX3Z1VX8csHdoWn2?=
 =?us-ascii?Q?OtVmA4EBGPOanQGBQGoEQj1LnhARLy2NQDSgEWtYSWN4J8ZMcDr8P/3C3zmW?=
 =?us-ascii?Q?2X1v3e9OChG0KNly6jECaiViiEy+oVFlUZ11NqpqIUEDGnERzOmL2SAUeXXV?=
 =?us-ascii?Q?OixXEnZ7d+5haMBkqMsgY4GWeBopdhqjoJs0UHOxPxzoSHGq0E/wpsU8yOzv?=
 =?us-ascii?Q?A0PMU56m3dJ/2P3pdW5BgvH1peWe/1xbm/aaaiDCZ9ZYjOV7baLpVi046OCH?=
 =?us-ascii?Q?QZp9Aq0I3ExDRaFrnY9pQmo8yz0ACSjzLO1MKm6c9Fu++GAl4WSJ9ozasXjc?=
 =?us-ascii?Q?IRXMrvo72zKouTsOvAtmiiaziSAYztHZSOkWIBRTcC8bA+madCWYb0uTxMEj?=
 =?us-ascii?Q?1lgg+LuIBzC/f8TRR9IBImudYSgYWxGg4wjRpeOkLv/lhx7UgXkqLFJlaSAm?=
 =?us-ascii?Q?/Om8mrnGv4JxM8NlJwpYZjbSKZfMFPNDfHsp4G6eC0Wl3Monizhjupf8FV6x?=
 =?us-ascii?Q?b09b+eOAd7T88vsKe5nDxZOyHdRGTLpxOLIxx3uOwK4p4VDgPTaPesYISwP/?=
 =?us-ascii?Q?Inby6d0r6K20LzscgXpvxSE3lqF6nhC1DmL2O3NATp/74aU7Guv7+mQXown1?=
 =?us-ascii?Q?pTgHTxktXcD+mZypt2qXt7lj8kmB/c9n2O5rh7vIj+e8Ui7MvUU+0S2F9ChB?=
 =?us-ascii?Q?pA22e5twhXELTfemjWcNLCoYo1gCD/ZjpdrcDM5PNcwHZDem4QcYQkAon+NJ?=
 =?us-ascii?Q?jgsfoTCmnnJV02ffvhZXOXb7r18lAotZ05HiPThfQfqb1ZoYsu6rwmOv6JyU?=
 =?us-ascii?Q?hSJQ4Oe1qYfgsY8vLe9CFQfHuhrolyOAL5IFkxIjAzze6wxSCeyBKZCDlOoC?=
 =?us-ascii?Q?BhZQtv+16Q+oSH/wA/BVhsVQ9lrHCqKxhh5CjMp8JPQSME7XQe5t45b9jEwq?=
 =?us-ascii?Q?WYy+ENmMcOM3pi5kyvRGtL/AW7pv8fV0/HR4ieG1y+wKdn9myYGYIKLRiDPr?=
 =?us-ascii?Q?dsRDNP4CnHCphvw7ewqAiIIjZIDrtmAWJISfGXbJHYPuLnhJGYmC5+kxNfx6?=
 =?us-ascii?Q?Lr9Ie+2l9yrWhHPaROyRf9I9dJWqkc0XwM1exEp7grtmDBwj6wRzAg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 21:23:02.6851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca4be648-1c0f-4102-ff2b-08ddf49e0da2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7516

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
---
Changes in v2:
1. Modified the commit message and linked kernel bugzilla as reference.
2. Removed unnecessary variables.
3. Renamed struct dram_addr to atl_dram_addr.
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
index a6e4792a1b2e..829ca8ccf1e1 100644
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


