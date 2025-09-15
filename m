Return-Path: <linux-edac+bounces-4808-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 726C3B586A9
	for <lists+linux-edac@lfdr.de>; Mon, 15 Sep 2025 23:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3DB71AA8184
	for <lists+linux-edac@lfdr.de>; Mon, 15 Sep 2025 21:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C284D2C0F91;
	Mon, 15 Sep 2025 21:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dr9EMyj3"
X-Original-To: linux-edac@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010020.outbound.protection.outlook.com [40.93.198.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291BC2C0F79;
	Mon, 15 Sep 2025 21:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757971398; cv=fail; b=DWdI4N0YkUzlPHDTErGtrk4XOAvT8El80evZplUQtUGJnBwJqpX93FbZEtThlIu7jo8CwBbScnl1jG+V+la3n9DjQNizRe2/KB6WHRZ9BI8Zu5gLPmYJuh+7Jp+ptkTDYq3OESZu231QnkivFGX48zLHqHLiuMzrXBIJrgcVDnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757971398; c=relaxed/simple;
	bh=zfpueJRaT7jCiTCdqIznwDHfX2Vn3Nz2BZMTriKz1/o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jRjuOg8LqwwZtmG+h/Uldt3/flXzNLKlt/szJhwUrfeouIW5QyN1x1EAsGstgO3064JjzZ2M1ydr4OAVCV58z8rgfbatp2Bg5nOFh+RFrTaDCWnADDZKObhSB5Xck95lVDH63P+SRokbDx2TJ90diZKisXRdIzKnfThyIUjeDTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dr9EMyj3; arc=fail smtp.client-ip=40.93.198.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUlsKvOeVNsSY44W+2QJtaXW5zbV6ffKr2VcdnVVUWXY41FPTpRtqg1c0W1l5giJaDsGliQ6nQoUwOiT//PAkSZd6vLMEkkQZdQ06V9m0PesXKBlI+8x5TBQMwt4u/QMvV6klNn6JWZsdnXizk0G0r3Y05NfbK+TW9E2u433PwLVq15n18Id58wc8cerKOI58HO9y6ODjITCfOle1qoewmOKO+sj5VgVJoPQVQ9czXQQfF5N+HRH7bFR8SOSlKzN74D2Hmm7N+t2ZqKv7temz5VqCLFi1cp79XUfAc9GpQxrTo/0l/6F1Xh9NFoGyr6cmnkhBKcdyz8+rLt8090iXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRwAHgDVZA6toPneKjpwjN1NcfzinG+28H11Wj1WhKc=;
 b=ur1ac2JDVSS2ThZF0gJNIMK7Bjk0rTfuBKp92MWN9l80OFoTw+mNXRkvTbY318c70Fe3kQt6toTIYI+edf6ZxmO4PDgbyrH81WwemIrEgI5SXFEqHHiTxhlOyMAkYfIMM+2UAbCM9NAW8EX95u3QZGSAoLrAo+sgzIoeHUZ/F0I0YIzTwiWOJsGBZbjjdv4zQjAynMNICOvn1gTlVL98DFaDR0XHExTrClSpgoQYObJt2LX7sFt0aV6dZAHseKgdMmtVRZp+2knKvIiHn2OAcwUGvdlMAN2mOrXOVL5b4B2guz1aA2aXZ/RqTSJX1AONTKCgq+ImFL6KUr+/6p7EDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRwAHgDVZA6toPneKjpwjN1NcfzinG+28H11Wj1WhKc=;
 b=dr9EMyj3qiCeS4xwcSMHJKkP5VaHifGTZE7NpaYvcByZ61+nEqtyfk8xSy/H8f9bSoYtaB6anbcqxn+/sI7rZ7FSIfxvTdj4GJjZ7JOJArRsZ68OC7YlZ8DCaZZItAqbp9fV5egwcUCLssPLyED41T2ubltQKuwvBWg+BioQ21s=
Received: from BN9P222CA0027.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::32)
 by SN7PR12MB7105.namprd12.prod.outlook.com (2603:10b6:806:2a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 21:23:13 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:408:10c:cafe::72) by BN9P222CA0027.outlook.office365.com
 (2603:10b6:408:10c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.20 via Frontend Transport; Mon,
 15 Sep 2025 21:23:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 21:23:13 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 15 Sep 2025 14:23:12 -0700
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <bp@alien8.de>, <yazen.ghannam@amd.com>, <john.allen@amd.com>,
	<linux-kernel@vger.kernel.org>, <avadnaik@amd.com>
Subject: [PATCH v2 2/2] EDAC/amd64: Incorporate DRAM Address in EDAC message
Date: Mon, 15 Sep 2025 21:20:23 +0000
Message-ID: <20250915212244.886668-3-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|SN7PR12MB7105:EE_
X-MS-Office365-Filtering-Correlation-Id: bc4b01db-9f97-4759-fe4e-08ddf49e1421
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wFKtWpyYs2xIGkSyrsbyZtDOAbeHQiJ5Nw89cYlBQWkokIVWsVWGTZGIQNSw?=
 =?us-ascii?Q?5qf+AkuH0GSpcjXBaSUptIpa4VM6IqzEYjy/OsAvuGK85jXS7ckENAtf3ttk?=
 =?us-ascii?Q?baYhC4spS4JhdfcgptO/LOydQW4SlsRmP9j+t8BOcAwbFZ/+KqWrGSJH/j51?=
 =?us-ascii?Q?GzGWaggmJnvbTWWaqaKc0gk1lD0EI3Nd5PMR7mOfmj90pFDy8rTpKcKr5Oqd?=
 =?us-ascii?Q?Hm9Uk7uQr86FucU5KegTM98RWOEuClRJl6KQ8t79xQyuXwP1OoggrPt99la1?=
 =?us-ascii?Q?YxIYKiUHzN9U3kQXhrktEGueoLnvX7CjM5qp8GBOuntLv4vlfyKJtRbIO5vF?=
 =?us-ascii?Q?oJlOpZ08TgzIeLPPYRgtg3OuxbpTfni6acj9SPcPZDLgwXuEGioe8kCJO2mK?=
 =?us-ascii?Q?xASFB9BSjov+PRJq0EOTHPt7bZILzsBzdDPFe3lbFAIo3+BfnJiN4Tc23YUS?=
 =?us-ascii?Q?laaG5LR9qoMuwah5Lf6oJCWz4QHnhYKHJG1jh1O+toAw+zOmVDxjE4AcRM6h?=
 =?us-ascii?Q?4B+wpS/izCPt6c3NZWOO3esWkjUmVy1MsVZAJzeExaNcQwTzZToFtOtSv3Uz?=
 =?us-ascii?Q?6ELOBVQtl0IV/7ToXyoGiGFXsqMWNP2R3E/virj74lZvxi4h9IiYdayBm7+a?=
 =?us-ascii?Q?lmZpzYJt4bbMpD4zNWQbE12R3X+awD4lH9ThfjJNxgKmCIkLMXBUttdU6ojR?=
 =?us-ascii?Q?YlG6cWTsdXhm3/AqpbJO/4x1wDHaoJiDzkNH+zT1WnfojuLX0fp+FA5V6vPL?=
 =?us-ascii?Q?ZjUIi1NmSOn0+F++XwefGcHT6+r1m3gbm+MdfzzGBfxGdaAR0fSFWtuRozjL?=
 =?us-ascii?Q?fVvlWx26re2dX3ryhY5TEwZdkr5fUFjHXoZ008CM7VdQJjhkA7cnHMh3UeLU?=
 =?us-ascii?Q?DulhfF/tGpmqzy8kgn5Is6YNVGkKQs0e5jD6j1U7lh0oTMgptthNlbP18UVc?=
 =?us-ascii?Q?aHZ+1cUO7sKe0yHodBpuDZfr0krMYcGF1dv4g06TwS1WWFHxQJqhyjoWngCe?=
 =?us-ascii?Q?r+X55FPVcYe94RuX2QCXZtr7Y1TVsyveA/gTpJeU4ZzEIdEEngmhrYY4evAv?=
 =?us-ascii?Q?9X5WydU9JIMN5qQRx9Gi3njwhj3C155ZCm/xDREp4d8vNB80w+XlOOIiQ8pQ?=
 =?us-ascii?Q?sV44SMoexZznd3rZqz/Sh828wyzOW7Mn5wbMx8ce50y0xywcot8UabcBvcXc?=
 =?us-ascii?Q?nqyueJfn96OemQaxzm6nrlCuuwJsKJi8ed0ZfJkFmwqU1ePE1UMnlPb/0qCb?=
 =?us-ascii?Q?2499TLKTlwK8/Z+AWOweTijPbVdlVYEQA9xj7K/TeRZCWe4R7PV5AxuhgIgE?=
 =?us-ascii?Q?VK/lV7PU2aCO/rlJXsGGRK/Uy6LkjU26NLNY4OWH3cZ7PrkcJirNxPaBhu3f?=
 =?us-ascii?Q?4qXFuxLDYip3LyzmojTx1jdeaNpwtT3poZenM/rfkjoQoKTAqc7KjGtcsvzJ?=
 =?us-ascii?Q?Xwpsp2xeg4CWiiMU2cXOxPL9lqBop0AHiON+Ol883MSj9O6tqR2thkJLV3Dh?=
 =?us-ascii?Q?4Bb9pY+UTdg7w3Dqp+AUtMEfDdVeCEVQuqBq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 21:23:13.5825
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc4b01db-9f97-4759-fe4e-08ddf49e1421
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7105

Currently, the amd64_edac module provides decoded error data to the EDAC
interface. This data involves the system physical address (PFN + offset).
Furthermore, the UMC normalized address, gathered from MCA error decoding,
is also provided. The DRAM Address on which the error has occurred,
however, is not provided.

Use the new PRM call in the AMD Address Translation Library to gather the
DRAM address of an error. Include this data in the EDAC 'string' so it
is available in the kernel messages and the RAS tracepoint.

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
---
Changes in v2:
1. Modify commit message per feedback received.
2. Pass the DRAM Address to edac_mc_handle_error() through "other_detail"
parameter instead of "msg".
3. Replace sprintf call with scnprintf in __log_ecc_error().
---
 drivers/edac/amd64_edac.c | 23 ++++++++++++++++++++++-
 drivers/edac/amd64_edac.h |  1 +
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 07f1e9dc1ca7..a10a6134eb04 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2709,6 +2709,9 @@ static void __log_ecc_error(struct mem_ctl_info *mci, struct err_info *err,
 {
 	enum hw_event_mc_err_type err_type;
 	const char *string;
+	char s[100];
+
+	memset(s, 0, sizeof(s));
 
 	if (ecc_type == 2)
 		err_type = HW_EVENT_ERR_CORRECTED;
@@ -2724,6 +2727,17 @@ static void __log_ecc_error(struct mem_ctl_info *mci, struct err_info *err,
 	switch (err->err_code) {
 	case DECODE_OK:
 		string = "";
+
+		if (err->dram_addr) {
+			scnprintf(s, sizeof(s), "Cs: 0x%x Bank Grp: 0x%x Bank Addr: 0x%x Row: 0x%x Column: 0x%x RankMul: 0x%x SubChannel: 0x%x",
+				  err->dram_addr->chip_select,
+				  err->dram_addr->bank_group,
+				  err->dram_addr->bank_addr,
+				  err->dram_addr->row_addr,
+				  err->dram_addr->col_addr,
+				  err->dram_addr->rank_mul,
+				  err->dram_addr->sub_ch);
+		}
 		break;
 	case ERR_NODE:
 		string = "Failed to map error addr to a node";
@@ -2748,7 +2762,7 @@ static void __log_ecc_error(struct mem_ctl_info *mci, struct err_info *err,
 	edac_mc_handle_error(err_type, mci, 1,
 			     err->page, err->offset, err->syndrome,
 			     err->csrow, err->channel, -1,
-			     string, "");
+			     string, s);
 }
 
 static inline void decode_bus_error(int node_id, struct mce *m)
@@ -2808,11 +2822,13 @@ static void umc_get_err_info(struct mce *m, struct err_info *err)
 static void decode_umc_error(int node_id, struct mce *m)
 {
 	u8 ecc_type = (m->status >> 45) & 0x3;
+	struct atl_dram_addr dram_addr;
 	struct mem_ctl_info *mci;
 	unsigned long sys_addr;
 	struct amd64_pvt *pvt;
 	struct atl_err a_err;
 	struct err_info err;
+	int ret;
 
 	node_id = fixup_node_id(node_id, m);
 
@@ -2822,6 +2838,7 @@ static void decode_umc_error(int node_id, struct mce *m)
 
 	pvt = mci->pvt_info;
 
+	memset(&dram_addr, 0, sizeof(dram_addr));
 	memset(&err, 0, sizeof(err));
 
 	if (m->status & MCI_STATUS_DEFERRED)
@@ -2853,6 +2870,10 @@ static void decode_umc_error(int node_id, struct mce *m)
 		goto log_error;
 	}
 
+	ret = amd_convert_umc_mca_addr_to_dram_addr(&a_err, &dram_addr);
+	if (!ret)
+		err.dram_addr = &dram_addr;
+
 	error_address_to_page_and_offset(sys_addr, &err);
 
 log_error:
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 17228d07de4c..56de2857369a 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -399,6 +399,7 @@ struct err_info {
 	u16 syndrome;
 	u32 page;
 	u32 offset;
+	struct atl_dram_addr *dram_addr;
 };
 
 static inline u32 get_umc_base(u8 channel)
-- 
2.43.0


