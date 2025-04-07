Return-Path: <linux-edac+bounces-3475-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BFDA7E818
	for <lists+linux-edac@lfdr.de>; Mon,  7 Apr 2025 19:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FBC23ABBD6
	for <lists+linux-edac@lfdr.de>; Mon,  7 Apr 2025 17:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B72821660D;
	Mon,  7 Apr 2025 17:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jigutRlE"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2061.outbound.protection.outlook.com [40.107.102.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E33215F6E;
	Mon,  7 Apr 2025 17:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744046573; cv=fail; b=u+veY+MsredmaS9fAxeNyyE1TEdg56N0mmLK/SqfaIu88asy9K/B5br6t7dTY/FSSpeeJVVQQP6WtZfkbFG0iUYE4qkWyyvuQdFY/hN1axF1b0MLZ4SeW9xWWKQJkKWVd8jE6aRsKC6q88B0yfib1KJzPEKketJogM/VcpRe+pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744046573; c=relaxed/simple;
	bh=Iqm/e9RN6oVp7YI5MA8BLcN8oXBELvGQEaqPVJ97bfo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Dy1WbN1yqfByuoJh+IURxy030owfTsIsv7ddTTDuxWWrnJO/eUWycUS572vVpDXCyR4CPcu/nDNmnnKr/nRkg5bXhWqiRySP0hny15eEzAYh3d8rMsU/WebC1FSipsIiKJ/I1h9JfZyHxVPXD1Jr0hF0aQCc+0nj4mzRr5s5s0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jigutRlE; arc=fail smtp.client-ip=40.107.102.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UMPjCnXp6qjSJ6OiqXfa68kuDKJL/KuRpMY2+/QZvP/rDJvGJgxwzh7aimOE2/4UI5L3NdjqJ+51iBdRmTcjSvrDWYmg+wNHOh+Z+guP0NiKol52CS1/UVKad8/4xDltm9rm5+8YJqCtgwLfFf2y4bp1VHASJA5rpPD9mnO80Gl4iI5KJJMmr0LcPPGDr6OSaRu+aqHw2JEjRHxez0FJB4D/eiARt3d+c1G3cDZptbNMP4QjsCccfVYrDjjFGAPGSAdbHTV+rD9hEW1kMxVJ4rGgHiFTtvwo8IJY/X5cCCXr9W9nN4tyCw8HKxrV9FBdSmxQz6CUMmSZ1ZM4dDWMRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Z2ZKebUX8z2sDVkjVVGSWSA4rXhXdN9lNU7Ho93nn4=;
 b=LXBT/CgM7/yLoVxUzlu/gJrJ2QAzqCWWHp2nCyLGOh8kdp7KEaSOz1ij5MXm7r2vRHsdAyCDvX5UrQsWgyViNBv8YHFTTfkaeT994x5WJjsroRmq6LuFzBt0L3+VwF41yDkdCqYSFqFolj0hHpMbCfX65uGwwh6+SzTd7n48fdRaXBsRVAIqB9KgfyxrfDDivQCaphaoOCrs01YxZLMd8KcvdXaG31+HemPeSRUd/mGMXN/ZMllLz+22+4Mj/uRANKzje8OonvasISFov5P6ZEYFbFT7shIqPPkaXKrkI9IuvEjldkw6aXlv/DYlE/YOFZ2GJsNtSk9DDqI64wt4Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Z2ZKebUX8z2sDVkjVVGSWSA4rXhXdN9lNU7Ho93nn4=;
 b=jigutRlEnBItOZO5gmchpujcNCJlabXJvrFgtR42yRbzhsHRHoYBDmxAFYnGaHsjdIbQZR/miTiwWLuBM6ef/xtCYawgVdToCud6CXsVJElF2BAVBu+pVLugrJdoJ7uWFBhZYnPiNBDbYPIThBB3pPTu0TnUwgpYYzKIe4kFV2g=
Received: from SA1P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::29)
 by DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Mon, 7 Apr
 2025 17:22:49 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:22c:cafe::43) by SA1P222CA0013.outlook.office365.com
 (2603:10b6:806:22c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.32 via Frontend Transport; Mon,
 7 Apr 2025 17:22:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 7 Apr 2025 17:22:48 +0000
Received: from yaz-khff2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Apr
 2025 12:22:47 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Mon, 7 Apr 2025 13:22:41 -0400
Subject: [PATCH v2] RAS/AMD/{ATL,FMPM}: Get masked address
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250407-fix-fmpm-extra-records-v2-1-3859e5d7bb95@amd.com>
X-B4-Tracking: v=1; b=H4sIAOAJ9GcC/3WOQQ6CMBBFr2K6drRAUXDlPQyLoZ1KF23JlBAM4
 e4WXLt8ybz3ZxWJ2FESj9MqmGaXXAwZyvNJ6AHDm8CZzKKUZS0r2YB1C1g/eqBlYgQmHdkkMKS
 Uqdr6Zlojsjwy5csj/Ooy95gIesaghz3HmK5kUIONDCGndmdwaYr8OX6Zi938zSpZ/JudC5DQK
 Nlre8cGdf1Eby46etFt2/YFZpKoO94AAAA=
X-Change-ID: 20250308-fix-fmpm-extra-records-de44d3956d9d
To: Yazen Ghannam <Yazen.Ghannam@amd.com>, Borislav Petkov <bp@alien8.de>,
	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>, Muralidhara M K
	<muralidhara.mk@amd.com>
CC: <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.15-dev-26263
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|DM4PR12MB6280:EE_
X-MS-Office365-Filtering-Correlation-Id: e07adf0b-6bf1-4807-4baf-08dd75f8d17a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDVzV2d0VFdmeCtrTTdzWHAvdFlUK3A3eC9XMkhqYWN1SldOb3I3dTNDNCts?=
 =?utf-8?B?cnN1VW9tK0Q4ZFVMb1hMakUwNmZpd2tORjQyUmhNNkMzYkJ4clRUZ1FsMkxr?=
 =?utf-8?B?OTN0MzJNYkVaSzZVd3o1dytuTExVdkgzS1ZRNk1pTE8zOUlqemV6eVpNWHRa?=
 =?utf-8?B?bW1yOE16dXE3ZmdERTY5eUtxdW1Ja2l3bEludTFVWWtsMENGTG92Szk2VGJN?=
 =?utf-8?B?V3p6SVFqeVczaFVEUEE4ZDBrQVdyZXQ5ekk1aFg1MndvM0t6bHBZKzdGTzFu?=
 =?utf-8?B?YVMyYlZNUElRS21GakZnV1BZelRpekJ0Z3pVTnkzY2NUQVhUY256U2R1SHBN?=
 =?utf-8?B?a2dYd3JFQnltR2tIV015aCtIdmR5Qkp2dVFJVldiMGFhRm5SRGlVaW9KQk11?=
 =?utf-8?B?VEUyVnMyb0pLNjZRKytlVFU5Z0VDSkY3ZnpnZTJVT0txWjRRZGJnd2xab1dC?=
 =?utf-8?B?RlhJdFhZUDN5ZkZaUXVkY3dQV21pZHNMR05jclh4MDBJT3JmYzJ4TUlBSTJl?=
 =?utf-8?B?THp3N2FNYTYvUGI4ZXdzbVVqTjlnMTFJcmVaNEVXdXFZbEZGejBObFFuYndG?=
 =?utf-8?B?QjlJckx3MktRU2xDUVZuWGZTSDJOd1NUWStDaVJocWZtV2twcFRKZndzK0RX?=
 =?utf-8?B?NmZwbUhRTDVubEFZdzJHSU9kY0hZYlRVbFdlNGlZVXVkMG5oMlN0SVNSRjMr?=
 =?utf-8?B?QTB1dExSR24xK0FIV1hWblNKbWsyTFhjY3lzUnVpUndLSDZUOWg5MXIydkdM?=
 =?utf-8?B?aU5GNThYaEFlRU0vbitMV1FWRDZ6RWsyZlNGb0R2MThWK3poaXNVelpRaUdR?=
 =?utf-8?B?MU5IaUZ6enBLNHRrK0JuQ0l3WS9PL0VZaEdraXdNdGpZS1N5OEVEWThkMnky?=
 =?utf-8?B?NkZ1b3BqUHNreVRocnRLNjB0aE9wcnVBZ0UxTlZST2FURUpwY3ZiTHl1QTZt?=
 =?utf-8?B?R2NrbXk5ajBhVkE1ZDJIQ1hmQjVrakhhWlE4M2dnd00rNFNuT1dnZ3lHays2?=
 =?utf-8?B?RStybTM2RlV4Zk1nbmgvUDNpbldFSFpKQ3BiUUtvMDJxNlpBOWlvNFRpMUx3?=
 =?utf-8?B?d2VGZDdQSlU5a3dBTzlZWkRSMHVodVhyZlYzU1VJMHU3OTlxa0NVZUI1ODVK?=
 =?utf-8?B?eGxRZjVLUDI5M3V0MUZUZWl0N0JIZW1JNmpWVTVDVmNUSzdaRnhKUzNpMlpn?=
 =?utf-8?B?dVlXK2E2WTlRVWFQODk3QmsrSVdsbzhiS3JYWjQwcmJxT1ZidDRmYUt3dWtz?=
 =?utf-8?B?SlBPVHZMVHRHNG5Bc3dwNUdOa1dmWUx0am96RkZ4cVJKUXpqQUltcUZqWFVV?=
 =?utf-8?B?VGwzZ05KcjhkaE03OFB2cWtsRFdOcDNkdzlYOFp1anUzclRJQlRyMlJuMU03?=
 =?utf-8?B?RHJwUmowMXNPOCsrRmd5R21xSTZBS1QwTkkwUVpqREZ6MU1Sd1dNM2NqVXVj?=
 =?utf-8?B?QllnK0pELzNTTEtabWVEdTAzZHV0aHh0VWFZWnVvMDh1alhIMUlLVE1tL3RX?=
 =?utf-8?B?YWFZRHFaTE9vNmNrL0RMOFMySldLQU4wekM5UlQzeElRbFFDclVhK0Qxa0w2?=
 =?utf-8?B?NjI3RUlzVGRqWWJzdjR2cm5CUllDdDlVWHRaeVRTSGl2QTNhVkJJTE1hMWRU?=
 =?utf-8?B?SmExYmhNdXdLNys3TjBPeTlKaDVqVnR0aCtvTUx0enFlc0pLdWwxSGdBNVVo?=
 =?utf-8?B?MFAvbWtxeC8zTklIUkFPeFBTQVlvU2dtTU1OOTFQSHVxeTFSUDBaWGpERkZ1?=
 =?utf-8?B?ZkJlTkVodno0a1BTZ0xUK2R0VFZycDJoVFdrMlJNMzd0STdCYUk1UDNURnZs?=
 =?utf-8?B?M1lYNWpaRzlNdEc0U3NyWTl0cVA5WXBTdEtqV0NQa1c5bWlacDAycWxnVGhi?=
 =?utf-8?B?T0lVNkZteXhNL1VsOHNPZDAxMnkxVG95MWJtcGpLazNsQjJ3c1cvQTNWQSsx?=
 =?utf-8?B?ZEFiNy9pRFd2akYyZ1BHTDAwMHNNOWVHSlIxMWE0aXNvNnJmODVLOG9BZ2tK?=
 =?utf-8?Q?qxxhhNWFI0bwqWadsA84n1MVbajtzo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 17:22:48.2645
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e07adf0b-6bf1-4807-4baf-08dd75f8d17a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6280

Some operations require checking, or ignoring, specific bits in an
address value. For example, this can be comparing address values to
identify unique structures.

Currently, the full address value is compared when filtering for
duplicates. This results in over counting and creation of extra records.
This gives the impression that more unique events occurred than did in
reality.

Introduce a helper to return a masked address. Do this in the AMD
Address Translation Library, since the bits depend on particular
structures and are implementation-specific.

Start with the case for physical rows on MI300.

Fixes: 6f15e617cc99 ("RAS: Introduce a FRU memory poison manager")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: stable@vger.kernel.org
---
Changes in v2:
- Dropped patch 1 since it is in ras tree.
- Moved helper function to internal header file.
- Link to v1: https://lore.kernel.org/r/20250401-fix-fmpm-extra-records-v1-0-840bcf7a8ac5@amd.com
---
 drivers/ras/amd/atl/internal.h | 15 +++++++++++++++
 drivers/ras/amd/atl/umc.c      |  2 --
 drivers/ras/amd/fmpm.c         |  2 +-
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
index f9be26d25348..cf42d216f491 100644
--- a/drivers/ras/amd/atl/internal.h
+++ b/drivers/ras/amd/atl/internal.h
@@ -362,4 +362,19 @@ static inline void atl_debug_on_bad_intlv_mode(struct addr_ctx *ctx)
 	atl_debug(ctx, "Unrecognized interleave mode: %u", ctx->map.intlv_mode);
 }
 
+#define MI300_UMC_MCA_COL	GENMASK(5, 1)
+#define MI300_UMC_MCA_ROW13	BIT(23)
+static inline u64 atl_mask_address(u64 addr)
+{
+	/*
+	 * Row retirement is done on MI300 systems, and some bits are 'don't care'
+	 * for comparing addresses with unique physical rows.
+	 * This includes all column bits and the row[13] bit.
+	 */
+	if (df_cfg.rev == DF4p5 && df_cfg.flags.heterogeneous)
+		return addr & ~(MI300_UMC_MCA_ROW13 | MI300_UMC_MCA_COL);
+
+	return addr;
+}
+
 #endif /* __AMD_ATL_INTERNAL_H__ */
diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
index cb8ace3d4e42..6e072b7667e9 100644
--- a/drivers/ras/amd/atl/umc.c
+++ b/drivers/ras/amd/atl/umc.c
@@ -229,7 +229,6 @@ int get_umc_info_mi300(void)
  * Additionally, the PC and Bank bits may be hashed. This must be accounted for before
  * reconstructing the normalized address.
  */
-#define MI300_UMC_MCA_COL	GENMASK(5, 1)
 #define MI300_UMC_MCA_BANK	GENMASK(9, 6)
 #define MI300_UMC_MCA_ROW	GENMASK(24, 10)
 #define MI300_UMC_MCA_PC	BIT(25)
@@ -360,7 +359,6 @@ static void _retire_row_mi300(struct atl_err *a_err)
  *
  * See MI300_UMC_MCA_ROW for the row bits in MCA_ADDR_UMC value.
  */
-#define MI300_UMC_MCA_ROW13	BIT(23)
 static void retire_row_mi300(struct atl_err *a_err)
 {
 	_retire_row_mi300(a_err);
diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
index 90de737fbc90..bbbc10b86cfa 100644
--- a/drivers/ras/amd/fmpm.c
+++ b/drivers/ras/amd/fmpm.c
@@ -258,7 +258,7 @@ static bool fpds_equal(struct cper_fru_poison_desc *old, struct cper_fru_poison_
 	 *
 	 * Also, order the checks from most->least likely to fail to shortcut the code.
 	 */
-	if (old->addr != new->addr)
+	if (atl_mask_address(old->addr) != atl_mask_address(new->addr))
 		return false;
 
 	if (old->hw_id != new->hw_id)

---
base-commit: 6c44e5354d4d16d9d891a419ca3f57abfe18ce7a
change-id: 20250308-fix-fmpm-extra-records-de44d3956d9d


