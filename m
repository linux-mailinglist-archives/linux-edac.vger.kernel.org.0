Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F42A49ECAF
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jan 2022 21:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344135AbiA0Ul4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 27 Jan 2022 15:41:56 -0500
Received: from mail-co1nam11on2062.outbound.protection.outlook.com ([40.107.220.62]:58319
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344120AbiA0Ulv (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 27 Jan 2022 15:41:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+f8crMAKGBHT0Bdqkx6y1KQuIz8KXoda3l9WsWtgXrNCnQGN2+FB0wouBLUZRaOuekhAxoJfAP075hqbyfftWCEorhlU15EGFqACWwChdBqM8Io9HPw1Lq12QnSvkwXuZf8utu9keekhVDwhGIoFrSQbG79tLMknGm6ZOZCOheTHL/qqZ9AWQbyF5IMQZOwlx1kFn29/ltTSn8DFsZW333+OurOhSViHoTpHqCxJ3ogXm3LeF0i0TG+w8RJSmskypJMR66jDjSE5CrRqsMO12PiKuoxaXg+wRZm0DXz9sHuAvX6bWWlNNhopXHIMzTsYuyQ9KPGbJINnvtpYac5ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18USAuhqdwQEqtpE2BcndsWE6n6AOxUla4I5EsQvU/A=;
 b=c0uuNWjROXA20CfSp10T0SQPB9ePSgxkeNvphn/LExqkkGdK/Od8m4PgGa9+EQgufbcxf+6NufLHGyVLQo+BANHNMK6FzeCtkCUhJxdazdzM+2NI8fmZdFB5/s3qMS+yajBnK2MlPB6p/yua+nAZ2QjafFhO9UYuHZI8Bk2f7iSNTmk8XdLl6OMXUqH7Gbrb5NZCBCX4aXecXFawzYwhlW+Kh8iiztJyUNSEUqeSk/AyKGP652K9+TffgBTwu0WwHu6GNVJT6uTQKCCkNWLguVxxND17Etw+Sif6iRffn8yjfK90Xj4KhlWOCa6Uj9yfunpTu5etVFK3xL8kKlLXlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18USAuhqdwQEqtpE2BcndsWE6n6AOxUla4I5EsQvU/A=;
 b=D2CTwvxQ8S1Mlxj56jq/OBtBvfjXkc/0FjaUGwFWAX/lBhz0274d2GGF8Din94/tPnkFHgsQdBwAw2v0jjKnoUDwYzAFh2ua0kifW3buvgoFwXyp+Kdy2KJYSro+1Y/AlQqGMHAJErK5CVGfmJ3yhMFySa2+FH9wYDIoqMp469o=
Received: from MWHPR17CA0090.namprd17.prod.outlook.com (2603:10b6:300:c2::28)
 by DM5PR12MB2519.namprd12.prod.outlook.com (2603:10b6:4:b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 27 Jan
 2022 20:41:49 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2:cafe::aa) by MWHPR17CA0090.outlook.office365.com
 (2603:10b6:300:c2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Thu, 27 Jan 2022 20:41:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 20:41:49 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 27 Jan
 2022 14:41:43 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v4 16/24] EDAC/amd64: Define function to make space for CS ID
Date:   Thu, 27 Jan 2022 20:41:07 +0000
Message-ID: <20220127204115.384161-17-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7a0c4294-6e42-44a3-0497-08d9e1d57157
X-MS-TrafficTypeDiagnostic: DM5PR12MB2519:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2519EC55348C494E6FC49CF6F8219@DM5PR12MB2519.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5cYPoqNRTDuWKk1dNi1BQKWAS3cTWuylvGrkU+1xKEIJ0mlshi6KAv420pjsJTdv7K0DXpPnKzaoQXa/6MspZXJJGJNlR+nW5id6L/48YWA5//ybCfSgxbxgU0jh/40ZIqS8D8v7rqPd+dwryNm0Lr4f/wJm3P75XwUA7iVkUH5rD1lB54UOAuJiuEjBfSkZSGDhnearYDLaSTGWtsA9XAk1k70uO1CkG/XtGi48b85DZikT4nfk9sIKdwZqMqad7Itl13aoggDf4Z+O7/d69gn8JHrwdjT98HiAZVvxAkMF/7kZUYY+XvFO2qdxiez8SxbtZl4sluqSzAagUZAL1E8zKCcvLK4j4epnhQWubfXgC/QclG+5YJ7uCQGZ1BBPWkUyrVxQHWFMPfS5O0IKkMDOLxxASA/gSdFE38PowBnKjca9tmhh0sWV1QNVaqDbhec60YoFNos2iNcl9ZJtSc6wZGjzdHjLxbA2By3bXMnhnYYgSuhwk7BxwOlPfsSN9gv+I6JzDK89s7Qjaf68iZCWjP06i9PP9zKGVAUv46igV/nYRYCb1D6qv6VKUwKqQJeiYx0S65TMBK8rLQQii9RwqNtWPdBfmUEvg8u00xV3qA7q4REDQT30sGfaSskxvL440GNs+cC9fFQW3GbADL6rqmIntcbyb7FtGKpKc4KcaEabC0rCOK3tVq+iAGqb32XEZOAgKSrYhxMpwsrlYOk5i1HP8Z/WvFEELBzINFpOiCCu+vp1V3rcNKFUjfM/axaIhzPV0z/7pCP/h6DvWk5NfyZEldJEHnpABzq/xxE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(8676002)(8936002)(70206006)(4326008)(70586007)(36860700001)(86362001)(316002)(356005)(5660300002)(36756003)(81166007)(2906002)(44832011)(40460700003)(54906003)(426003)(336012)(6916009)(82310400004)(47076005)(26005)(966005)(7696005)(6666004)(2616005)(508600001)(186003)(1076003)(16526019)(83380400001)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 20:41:49.3416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a0c4294-6e42-44a3-0497-08d9e1d57157
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2519
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move code that makes a gap for the CS ID into a separate helper function.
The exact bits to use vary based on interleaving mode. New interleaving
modes in future DF versions will be added as new cases.

Also, introduce a helper function that does the bit manipulation to make
the gap. The current version of this function is "simple", and future
interleaving modes may reuse this or use a more advanced function.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20211028175728.121452-22-yazen.ghannam@amd.com

v3->v4:
* Added glossary entry.

v2->v3:
* Was patch 22 in v2.

v1->v2:
* Moved from arch/x86 to EDAC.
* Added new function pointer to ctx struct.

 drivers/edac/amd64_edac.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index c3342f0bec45..f5b1902e04ac 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -991,6 +991,7 @@ static int sys_addr_to_csrow(struct mem_ctl_info *mci, u64 sys_addr)
 /*
  * Glossary of acronyms used in address translation for Zen-based systems
  *
+ * CS          =       Coherent Slave
  * DF          =       Data Fabric
  */
 
@@ -1081,6 +1082,7 @@ struct addr_ctx {
 	u8 intlv_num_sockets;
 	u8 cs_id;
 	int (*dehash_addr)(struct addr_ctx *ctx);
+	void (*make_space_for_cs_id)(struct addr_ctx *ctx);
 };
 
 struct data_fabric_ops {
@@ -1090,6 +1092,29 @@ struct data_fabric_ops {
 	void	(*get_intlv_num_sockets)(struct addr_ctx *ctx);
 };
 
+static void expand_bits(u8 start_bit, u8 num_bits, u64 *value)
+{
+	u64 temp1, temp2;
+
+	if (start_bit == 0) {
+		*value <<= num_bits;
+		return;
+	}
+
+	temp1 = *value & GENMASK_ULL(start_bit - 1, 0);
+	temp2 = (*value & GENMASK_ULL(63, start_bit)) << num_bits;
+	*value = temp1 | temp2;
+}
+
+static void make_space_for_cs_id_simple(struct addr_ctx *ctx)
+{
+	u8 num_intlv_bits = ctx->intlv_num_chan;
+
+	num_intlv_bits += ctx->intlv_num_dies;
+	num_intlv_bits += ctx->intlv_num_sockets;
+	expand_bits(ctx->intlv_addr_bit, num_intlv_bits, &ctx->ret_addr);
+}
+
 static u64 get_hi_addr_offset_df2(struct addr_ctx *ctx)
 {
 	return (ctx->reg_dram_offset & GENMASK_ULL(31, 20)) << 8;
@@ -1120,6 +1145,8 @@ static int get_intlv_mode_df2(struct addr_ctx *ctx)
 		ctx->dehash_addr = dehash_addr_df2;
 	}
 
+	ctx->make_space_for_cs_id = make_space_for_cs_id_simple;
+
 	if (ctx->intlv_mode != NONE &&
 	    ctx->intlv_mode != NOHASH_2CH &&
 	    ctx->intlv_mode != DF2_HASH_2CH)
@@ -1247,13 +1274,11 @@ static int denormalize_addr(struct addr_ctx *ctx)
 	df_ops->get_intlv_num_dies(ctx);
 	df_ops->get_intlv_num_sockets(ctx);
 
-	num_intlv_bits = ctx->intlv_num_chan;
-	num_intlv_bits += ctx->intlv_num_dies;
-	num_intlv_bits += ctx->intlv_num_sockets;
+	ctx->make_space_for_cs_id(ctx);
 
 	if (num_intlv_bits > 0) {
-		u64 temp_addr_x, temp_addr_i, temp_addr_y;
 		u8 die_id_bit, sock_id_bit, cs_fabric_id;
+		u64 temp_addr_i;
 
 		/*
 		 * Read FabricBlockInstanceInformation3_CS[BlockFabricID].
@@ -1308,11 +1333,8 @@ static int denormalize_addr(struct addr_ctx *ctx)
 		 * bits there are. "intlv_addr_bit" tells us how many "Y" bits
 		 * there are (where "I" starts).
 		 */
-		temp_addr_y = ctx->ret_addr & GENMASK_ULL(ctx->intlv_addr_bit - 1, 0);
 		temp_addr_i = (ctx->cs_id << ctx->intlv_addr_bit);
-		temp_addr_x = (ctx->ret_addr & GENMASK_ULL(63, ctx->intlv_addr_bit))
-			       << num_intlv_bits;
-		ctx->ret_addr    = temp_addr_x | temp_addr_i | temp_addr_y;
+		ctx->ret_addr |= temp_addr_i;
 	}
 
 	return 0;
-- 
2.25.1

