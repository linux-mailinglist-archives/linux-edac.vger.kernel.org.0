Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E128E49ECBE
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jan 2022 21:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344308AbiA0UmJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 27 Jan 2022 15:42:09 -0500
Received: from mail-dm6nam10on2067.outbound.protection.outlook.com ([40.107.93.67]:15424
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344191AbiA0Uly (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 27 Jan 2022 15:41:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pl/0k5hyF/HfIkgjabrhIJnjQhuWk6O539Ez4xcPtIxjfluImKXPmYJO4XSV5FYZ6ncfkI8+UKUL/HhYrVFcu2NAXRsZYlIS9nG1pTR7wBPxRyEXprMlMKHV4z5IX8kf1cyJU0PMuTwOKBYO8m29D+7Thj4OExlYDNR0Oqhu4LTMQBvz7os0HaIhxy7b3Jrn7DGzglEHfqHQqu5nVEGDDVNbwZT6aCdPi9AdcfIWJbkDWhm4Hs+6lWDaJAXjdHuS4HBFF2rUHXAxw6ao0J62ChpMeVLtf0u5YuyszN9ddeUnhuvMXfeL7EHS/0VpjShQthPSLg52jpbse3PO/RqA5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJyUZOmrtiMZLoe6L4nVlVC3r0qZGISOQdFaiAqTHWs=;
 b=SWG+YndE4+B8iv/tURdjZXVOCMFyTTQNfotqSV/Ft5k2C6b60Tt8FGZD46/3+bnm0HNhMntAbgE8+hA7+VHrOJWJyK5TF93H1p10yvpfYeXhbn1WvCb+tBG7TfKPvh/mSBtZoQdVcECoG0AiLGkNdSQeYXX9p7k8U94qfk803hEePVF8mdGcGLYjx3449xEgFyjLApuR17UQTrib8IKA6E6N9cxDKExIosUHNtBqaLybTxeuoj1losBuBNxwaLAmCUfmAnXJWM6TYZ4EBexHdcdX7AD/+ihZU5lGrCWMlyRgDnQme1rf/YOEmnRo05QZCQJukQJ+0yLPt3G6Y3th9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJyUZOmrtiMZLoe6L4nVlVC3r0qZGISOQdFaiAqTHWs=;
 b=EvoLJ6LDEu7aw/sgi8RlY35NEPfubvRoHmqY7/UIXdgq2M6NlbudCa0LCF1BgxraCY3xC1hQvvFJBqAHY1ZicH/3JVBmTKvZmT+/u8XZg/1A8YdQXMj1nR64+ennBZkW1G/vjZB/yv2u/62FmAffX+OOP/DjSSYP1UsvpZFvINo=
Received: from MW4P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::8) by
 BL0PR12MB5507.namprd12.prod.outlook.com (2603:10b6:208:1c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 20:41:53 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::67) by MW4P221CA0003.outlook.office365.com
 (2603:10b6:303:8b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Thu, 27 Jan 2022 20:41:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 20:41:52 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 27 Jan
 2022 14:41:46 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v4 23/24] EDAC/amd64: Define function to get interleave address select bit
Date:   Thu, 27 Jan 2022 20:41:14 +0000
Message-ID: <20220127204115.384161-24-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220127204115.384161-1-yazen.ghannam@amd.com>
References: <20220127204115.384161-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c4e6769-8097-4c77-7596-08d9e1d5730b
X-MS-TrafficTypeDiagnostic: BL0PR12MB5507:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB5507E7048D8F4439F3F9070AF8219@BL0PR12MB5507.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9SnBt1hAGBwRVrvAvfYWcIf2A8hK839fUZryBpe4sRIE7LDR5YMc5zFtKQVL6NzK2LwGQnyxZygwrgjU5FCGS/R0ki+53ifKhTlxOGcBYXzVmYKv06GijYWtz9UCQSiFQR0se1+tFX539Z6CJgQDi2/O02qcYVVQ4biwcdfE34tx0Q9JS+Wx++U7qWN4KRjrJ62zzMBod+fzMndXzYSN5w8k9nqbQREzKkAXiGu1FQyosZWzwQgjrBMpexfqWboeFIlsDjqlCzp+b4UkY07T5HeqmPBSMt6Y96K9XoV1Nf9rFPCNtWxAz0H2JdXWPhka4L5Ev1hAZot/G50ImOg+qTLWgsypWu7N2RgarqX0kHXUQp7AJLZKo2gdn2kGlwEO48UJVEGc+czRd51I/Ekg9OL0KIwSl+1nofDulZ+Q3ipMqgonoAb+N3BL0XUdYaWkS+KVPJ4+hGd+y+pDd4p/pfOg1R9b1SJqADAaUtZJhkHjgPX1ZJ5aCsKCSv0gS95Cejjlg4OAbCRZ5OqBjfnZrvnwMXCOWOTaOyStTXGRbqvq7cr8plMKYSTd9y1kLPum/UO+bTN/hOKB8muQnTfAVt/5ja9/j7G0lc8xVeoyP3HqfWktQQVYm4lwdUIIZ/cq2tKz+CxgEFc74AdGKwMFscxlJx68zhaZCyQBip2hqvfoyYcCTGLYeZ/caGgBURwO32tbLYmZud3bx0+Xg/fKsPfsvriK/UxRsUmaVAh1CM0z5Qp00/6McJ/4NwplNj2hwme8A6yMRSWkEzqLxp1hAZBtUJ+wUaZTKKxeerJMhdo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(7696005)(6666004)(54906003)(47076005)(508600001)(82310400004)(83380400001)(86362001)(316002)(966005)(81166007)(6916009)(40460700003)(36756003)(4326008)(44832011)(1076003)(16526019)(336012)(426003)(186003)(26005)(36860700001)(2616005)(70586007)(356005)(8936002)(5660300002)(70206006)(2906002)(8676002)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 20:41:52.2019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c4e6769-8097-4c77-7596-08d9e1d5730b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5507
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

...this will be expanded for future Data Fabric versions.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20211028175728.121452-29-yazen.ghannam@amd.com

v3->v4:
* Remove leading whitespace in function pointer.

v2->v3:
* Was patch 29 in v2.

v1->v2:
* New in v2.

 drivers/edac/amd64_edac.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 601ececf5106..34405c8940fb 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1096,6 +1096,7 @@ struct data_fabric_ops {
 	u16	(*get_component_id_mask)(struct addr_ctx *ctx);
 	u8	(*get_die_id_shift)(struct addr_ctx *ctx);
 	u8	(*get_socket_id_shift)(struct addr_ctx *ctx);
+	u8	(*get_intlv_addr_sel)(struct addr_ctx *ctx);
 	int	(*get_intlv_mode)(struct addr_ctx *ctx);
 	int	(*get_cs_fabric_id)(struct addr_ctx *ctx);
 	int	(*get_masks)(struct addr_ctx *ctx);
@@ -1172,6 +1173,11 @@ static int get_intlv_mode_df2(struct addr_ctx *ctx)
 	return 0;
 }
 
+static u8 get_intlv_addr_sel_df2(struct addr_ctx *ctx)
+{
+	return (ctx->reg_base_addr >> 8) & 0x7;
+}
+
 static void get_intlv_num_dies_df2(struct addr_ctx *ctx)
 {
 	ctx->intlv_num_dies  = (ctx->reg_limit_addr >> 10) & 0x3;
@@ -1228,6 +1234,7 @@ static u16 get_component_id_mask_df2(struct addr_ctx *ctx)
 struct data_fabric_ops df2_ops = {
 	.get_hi_addr_offset		=	get_hi_addr_offset_df2,
 	.get_intlv_mode			=	get_intlv_mode_df2,
+	.get_intlv_addr_sel		=	get_intlv_addr_sel_df2,
 	.get_intlv_num_dies		=	get_intlv_num_dies_df2,
 	.get_intlv_num_sockets		=	get_intlv_num_sockets_df2,
 	.get_cs_fabric_id		=	get_cs_fabric_id_df2,
@@ -1294,7 +1301,7 @@ static int get_dram_addr_map(struct addr_ctx *ctx)
 
 static int get_intlv_addr_bit(struct addr_ctx *ctx)
 {
-	u8 intlv_addr_sel = (ctx->reg_base_addr >> 8) & 0x7;
+	u8 intlv_addr_sel = df_ops->get_intlv_addr_sel(ctx);
 
 	/* {0, 1, 2, 3} map to address bits {8, 9, 10, 11} respectively */
 	if (intlv_addr_sel > 3) {
-- 
2.25.1

