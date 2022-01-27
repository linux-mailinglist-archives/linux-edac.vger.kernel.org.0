Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251F649ECAC
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jan 2022 21:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344165AbiA0Ulz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 27 Jan 2022 15:41:55 -0500
Received: from mail-bn7nam10on2059.outbound.protection.outlook.com ([40.107.92.59]:47457
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344172AbiA0Ulu (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 27 Jan 2022 15:41:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktU5omiB/ILQTO9hn7AhCNh/9/FLvcPe8oQtVe7CPqNNOFJi/6XDfTF0ZzYcwJHDv1FCORlIZjnT5qZ3iI9t3PuV0/SNBnkA2MRe91E3bdhDEJz6kDjQdW1YoPj3g0bu43al/jKYmI+Bby+VbWRqMco/mKMppJ+B1MMSIaLXGTpGd147k+RAJcTcq/8gseKINXdkRa7wPaFUNO+IkFT2vRg+6AafvYnXsMnkW2g3d68m8vj4WVX899f9Kx4tae0eAMZ1hJgwL3Wd7Pte0Tm40sUk2K7Sgl6hvLS72syC4+W1RnMrfBTBNcIWhhlG2TJcyiVXF5BpH6r4RJp7g5giaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUj7BSkw/bLaqtZbyvLo1nKr+QEFPKOf9ud3q5dgwMA=;
 b=VyfJlheAkC/znfQCBi7wWToc1a9DqJBDx1vPLyNdlu63Rgxpt4L4uR/LrJL4bHv8Ml4V4xDxQf2brEP4nFGHpOLUEU6dqUPu1dLpkVPgBEhevaI+HJScrgjm0oyfPL6nvsRkp/CPvTM2HMKBwFUEu9rzVtyCa6LpSjZz2Uo3+/5B6OhP5CzYsOZ7nG2ezdJB5znelNLgtAPuLm638FE+fIYjdy4bAd8QQtuWHIxQgoUwof0kzIMBXrlnXDlmEtn2lB/ixEJz6vByFKTyp23eNdtiYBOR9gaEY5iQpdEbujGbRinPN3MsOOiP48bZjle4YblosgnQmGo2RNqA79YQoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUj7BSkw/bLaqtZbyvLo1nKr+QEFPKOf9ud3q5dgwMA=;
 b=CezQifB/xEky4nLJPTtcDJemqygE2UgtDa1hcsiVd1NoZrEMnOxtCtIS+FueKnKSZD0O+QrZRFIuCyO8O9+0om/gw31Ri50cx/XHkL3wjtsLmCytgKKz90yzqbU74BDpIbNncCNMA1TFG0iMq97qoAJOduMqsio0JvJE8Gyj9+o=
Received: from MW4P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::33)
 by MN2PR12MB3936.namprd12.prod.outlook.com (2603:10b6:208:16a::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 20:41:47 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::2a) by MW4P221CA0028.outlook.office365.com
 (2603:10b6:303:8b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17 via Frontend
 Transport; Thu, 27 Jan 2022 20:41:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 20:41:46 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 27 Jan
 2022 14:41:42 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v4 13/24] EDAC/amd64: Define function to get number of interleaved dies
Date:   Thu, 27 Jan 2022 20:41:04 +0000
Message-ID: <20220127204115.384161-14-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: da71b557-d95b-4f68-abb1-08d9e1d56fc6
X-MS-TrafficTypeDiagnostic: MN2PR12MB3936:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB39369B56E036F97D0720A04DF8219@MN2PR12MB3936.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0bCTEGBDDLpxyATMYEEuB/mGyMD/WahUe2wCYzMZdj5L21eZZH4kMPFDHnKe31QIpDmDi7BLsSaCpGEDkqXiNUDWqVdHnPaegyVqK/ygFaQiJ/qN+BwY3GhWcoF3OatbuYuwJte8WarLe/NW+uRuqXBW8g1N6wD067a3In4Tvt23sTQOs36Ot4mMjmNcs8bbPCv+O4u6GpG1dXnLlrqDznAEN8ydRGeJDJ5vHXui7iZlJyzxXG54BeJAoqJPtJh21lJPJ9uJFLXfHibBEF9JtRInFLTJ6WQmDRvzYUKrjdnAc0x8yj0ZRmLY7svlKRxt8gwiDzWfs50fx15SXu3ZMtYHH+fwcpth5GYcII1gz2HN/zIiBCKrOkCrg0S17zH2uq9ZxKkYgukruMBL+z+Rf6XZCBOszQdmrflAT8jwc5ppH7c1FeMa7LQCO0jLVIT0f6vySmB3AmHuEPc0pxioKBm7mePmWwVLjvWcVdsYK9PlvEHzk32CcFQfks5STjpIX+HfL14vN/n7G1ouGL0/HyK1LJosU+gq3YB6TOSFs9m6bh5MH+0b600xdkPUC6xQXLrhgpVl5oQkjlR2ETpWZHz0V1k+rfhChAdIjp9lWkN8rEaovXSYZloZvp11zEQGvt3/cSWRo583sv65oF65Mu/0wXb+HkB/Ym9bcHeNiFRbZXM1iUyQoTLclo2lIRCMf7MB2vIlvYgOjoB4zpV/Q8PE3qx4jUkyr8tjIUpxEyC7oUCMtcZSaYfKM7ZYQG/qNi/hqKeKMQCvJ7A1EPUIYuNqyP5TLgiM90Zhcz01eCg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(44832011)(2616005)(8676002)(36860700001)(81166007)(356005)(5660300002)(4326008)(70586007)(26005)(8936002)(70206006)(16526019)(83380400001)(186003)(1076003)(426003)(336012)(36756003)(508600001)(86362001)(966005)(82310400004)(2906002)(54906003)(316002)(6916009)(7696005)(6666004)(40460700003)(47076005)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 20:41:46.7335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da71b557-d95b-4f68-abb1-08d9e1d56fc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3936
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move parsing of the number of interleaved dies to a separate helper
function. This will be expanded for future DF versions. Also, drop an
unneeded assert to match the reference code.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20211028175728.121452-19-yazen.ghannam@amd.com

v3->v4:
* Remove leading whitespace in function pointer.

v2->v3:
* Was patch 19 in v2.

v1->v2:
* Moved from arch/x86 to EDAC.
* Add new function to data_fabric_ops.

 drivers/edac/amd64_edac.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 87439374a076..2973b7b5e8a2 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1077,6 +1077,7 @@ struct addr_ctx {
 	u8 map_num;
 	u8 intlv_addr_bit;
 	u8 intlv_num_chan;
+	u8 intlv_num_dies;
 	u8 cs_id;
 	int (*dehash_addr)(struct addr_ctx *ctx);
 };
@@ -1084,6 +1085,7 @@ struct addr_ctx {
 struct data_fabric_ops {
 	u64	(*get_hi_addr_offset)(struct addr_ctx *ctx);
 	int	(*get_intlv_mode)(struct addr_ctx *ctx);
+	void	(*get_intlv_num_dies)(struct addr_ctx *ctx);
 };
 
 static u64 get_hi_addr_offset_df2(struct addr_ctx *ctx)
@@ -1124,9 +1126,15 @@ static int get_intlv_mode_df2(struct addr_ctx *ctx)
 	return 0;
 }
 
+static void get_intlv_num_dies_df2(struct addr_ctx *ctx)
+{
+	ctx->intlv_num_dies  = (ctx->reg_limit_addr >> 10) & 0x3;
+}
+
 struct data_fabric_ops df2_ops = {
 	.get_hi_addr_offset		=	get_hi_addr_offset_df2,
 	.get_intlv_mode			=	get_intlv_mode_df2,
+	.get_intlv_num_dies		=	get_intlv_num_dies_df2,
 };
 
 struct data_fabric_ops *df_ops;
@@ -1218,7 +1226,7 @@ static void get_intlv_num_chan(struct addr_ctx *ctx)
 static int denormalize_addr(struct addr_ctx *ctx)
 {
 	u8 die_id_shift, die_id_mask, socket_id_shift, socket_id_mask;
-	u8 intlv_num_dies, intlv_num_sockets;
+	u8 intlv_num_sockets;
 	u8 num_intlv_bits, cs_mask = 0;
 
 	/* Return early if no interleaving. */
@@ -1229,19 +1237,12 @@ static int denormalize_addr(struct addr_ctx *ctx)
 		return -EINVAL;
 
 	intlv_num_sockets = (ctx->reg_limit_addr >> 8) & 0x1;
-	intlv_num_dies	  = (ctx->reg_limit_addr >> 10) & 0x3;
 
 	get_intlv_num_chan(ctx);
+	df_ops->get_intlv_num_dies(ctx);
 
 	num_intlv_bits = ctx->intlv_num_chan;
-
-	if (intlv_num_dies > 2) {
-		pr_err("%s: Invalid number of interleaved nodes/dies %d.\n",
-			__func__, intlv_num_dies);
-		return -EINVAL;
-	}
-
-	num_intlv_bits += intlv_num_dies;
+	num_intlv_bits += ctx->intlv_num_dies;
 
 	/* Add a bit if sockets are interleaved. */
 	num_intlv_bits += intlv_num_sockets;
@@ -1279,13 +1280,13 @@ static int denormalize_addr(struct addr_ctx *ctx)
 		sock_id_bit = die_id_bit;
 
 		/* Read D18F1x208 (SystemFabricIdMask). */
-		if (intlv_num_dies || intlv_num_sockets)
+		if (ctx->intlv_num_dies || intlv_num_sockets)
 			if (df_indirect_read_broadcast(ctx->nid, 1, 0x208, &ctx->tmp))
 				return -EINVAL;
 
 		/* If interleaved over more than 1 die. */
-		if (intlv_num_dies) {
-			sock_id_bit  = die_id_bit + intlv_num_dies;
+		if (ctx->intlv_num_dies) {
+			sock_id_bit  = die_id_bit + ctx->intlv_num_dies;
 			die_id_shift = (ctx->tmp >> 24) & 0xF;
 			die_id_mask  = (ctx->tmp >> 8) & 0xFF;
 
-- 
2.25.1

