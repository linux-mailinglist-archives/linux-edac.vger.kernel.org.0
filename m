Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E23843E7CC
	for <lists+linux-edac@lfdr.de>; Thu, 28 Oct 2021 19:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhJ1SB4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Oct 2021 14:01:56 -0400
Received: from mail-mw2nam10on2053.outbound.protection.outlook.com ([40.107.94.53]:48160
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231501AbhJ1SBF (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Oct 2021 14:01:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmUvEj3yRUYLBqWHABcGEhCfKjVfUsg557/ysCJaNMZT02qs/yut9CkXR9bMVFFjzfd5b9214zMXEHdeGWlkrQwGZPsWkOCUOssJ15YXVX0oW50gZ4uddcJPPcR9XpBROEyHRJoJPRu5ivoMx9Oyi7p5UC+H5rgqbGkDsIvbx6vUth6S3FJCXY8ug88g3mYloutO1MVne/HEO0NoIPPGKlH7ejWs1Sfhehix44FyhIZFDiRl3w71ktC/BSrnE7rYVGPaQiKUqWXx+5mSNShY2CBAjdRHH8tft14SguYqh3auoLHiJxn17NhQAng3Zei8g/3anQe8y/TFrfX9MpIvQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPjw5LDOFo5tVmWe168cTmIb5nQOJavYVG9E/ZeRKRc=;
 b=FpS/cJ6F+Mc3c3u214gYPAD5f0HKMWeArqT11pYnkgtcSb6A5VNvKVj6/iZj4M6T7U421pqaiQwF4Ze3jS70+fUoHpoVIOG74S0dmk73ravmNuvbvfNxwvuIsXxsgwwjEY+XzkNg28ryWrU0sAAeZc/0wMhCKsumF2BHB5MT3D22m46s+HudwM1wC8TOp2ZnO88/Rjr+KDNf9/HnI7dbSwOWuri+GsDowObQybbO30doEftxg4vX5REdUXWeQ7LEZLo22bgdGaaAuCH6WakvPYRuDlSXpKjSqz6g/m3jdDgjFUVzVMyxDrQet/5zKdYrL2EI3IPBy9yQOxInQO2gwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPjw5LDOFo5tVmWe168cTmIb5nQOJavYVG9E/ZeRKRc=;
 b=IZYh6tzbayV33/Oyppm2b/BD3/6Y3kqFVgC3/wVsTTSqRUoIxup9XM4L5noEWu6wMAhWMtJnNeGnLO+NxyFjPCLx/IwFnU6YCa5+B8MDDQEQFfuWrBrWCtICQgoLi+XJTXp9XcWVLqdJszrNk8Zg5iBybcYKN8t63broy+nU50o=
Received: from CO1PR15CA0096.namprd15.prod.outlook.com (2603:10b6:101:21::16)
 by MW2PR12MB2491.namprd12.prod.outlook.com (2603:10b6:907:f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Thu, 28 Oct
 2021 17:58:35 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::9c) by CO1PR15CA0096.outlook.office365.com
 (2603:10b6:101:21::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Thu, 28 Oct 2021 17:58:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 17:58:35 +0000
Received: from yaz-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 12:58:32 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <NaveenKrishna.Chatradhi@amd.com>, <Muralidhara.MK@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v3 22/33] EDAC/amd64: Define function to calculate CS ID
Date:   Thu, 28 Oct 2021 17:57:17 +0000
Message-ID: <20211028175728.121452-23-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211028175728.121452-1-yazen.ghannam@amd.com>
References: <20211028175728.121452-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af940567-181c-40af-7ff5-08d99a3c900f
X-MS-TrafficTypeDiagnostic: MW2PR12MB2491:
X-Microsoft-Antispam-PRVS: <MW2PR12MB2491517028F67627356BE602F8869@MW2PR12MB2491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OkJEAKiXKLUXUh4cTbtq8t8p4t51WSY5PKSTr8dShH0zsF0TUAlcyAI68WS6qK+dU8SrKCa+XC1vSW6fhcYNuBa9TprEfEVm9cqPEhkEvKqjcbLmEjYYxzfcFlKO21cNs4e/uShpNStCGVwKUdubvL66h2xJ+d1O660AryB74sp7JksVYxhJ2kVFJk+MPUxfnyF1Np5EPfqdyNSVuO4FgUKrgJac/BtYUV/2BW808eDQ6J/AEO4+KiPTmqh62PH7C3ZL7Ws9Djf7AYYt+z1nEI4G3g57q3n5voiHEfrOcSzXL2wkgJWVuVV45Kyie2Ne2xUf7TFeJrgt9x3xS5IIznpQQz2iMZaRyE69LXXoDClklE2SzMVQ4QGPbpZbgOGjKqnRwCJyZU+jaGqLJgvYtm9g1Y8BWqBeordvpVoa/ztqpStv7Q9HD7UQQ4dqY+lMKWvxMYaljunnBYYdXP5vKkgkW+tCwILLM5r4y2V+PwUwGwMiSORMXdxDhjbr4xwM6GlS5v1HC7d+BvlExXFLRvDCxiAu7uHpUBi5H44E/u0xKTKqTYkdD5Iu2g2vkTVP1v9mFPCnHOYgTQjAHL7eNfdIdxOxdX2FFt2o9p++4F7aZIz405Wc9H4UVOAfK9Ps+bRqSwD99SqaxGZCn5rNYQ5j7GoJi8BwlkcpNAhyJ9TscxRGdCoAFluUcB6jRXuZXloqRy9uuVuT2qzLxRgq5LYDqZojQ/1nM/p+lDGT69mhZBPADloUfwcyy8diIACN+ppkSU3HR2Qh+IOgugjUyz6s5+yzzRiy8JX3tXrz/sFyrm0zqpbVCp5F0aYzymNA
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(8936002)(26005)(44832011)(36860700001)(16526019)(47076005)(86362001)(2906002)(6666004)(81166007)(70206006)(356005)(36756003)(4326008)(54906003)(186003)(316002)(5660300002)(70586007)(7696005)(966005)(8676002)(426003)(83380400001)(82310400003)(6916009)(2616005)(1076003)(508600001)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 17:58:35.3676
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af940567-181c-40af-7ff5-08d99a3c900f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2491
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move code used to calculate the CS ID into a separate helper function.

Drop redundant code comment about reading DF register.

The "num_intlv_bits" variable is left uninitialized as it will be removed
in a later patch.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210623192002.3671647-24-yazen.ghannam@amd.com

v2->v3:
* Was patch 23 in v2.

v1->v2:
* Moved from arch/x86 to EDAC.

 drivers/edac/amd64_edac.c | 98 ++++++++++++++++++++-------------------
 1 file changed, 50 insertions(+), 48 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 9ca822c1ea9c..2da0170f6d84 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1247,10 +1247,55 @@ static void get_intlv_num_chan(struct addr_ctx *ctx)
 	}
 }
 
-static int denormalize_addr(struct addr_ctx *ctx)
+static int calculate_cs_id(struct addr_ctx *ctx)
 {
 	u8 die_id_shift, die_id_mask, socket_id_shift, socket_id_mask;
-	u8 num_intlv_bits, cs_mask = 0;
+	u8 die_id_bit, sock_id_bit, cs_fabric_id, cs_mask = 0;
+
+	/* Read D18F0x50 (FabricBlockInstanceInformation3). */
+	if (df_indirect_read_instance(ctx->nid, 0, 0x50, ctx->inst_id, &ctx->tmp))
+		return -EINVAL;
+
+	cs_fabric_id = (ctx->tmp >> 8) & 0xFF;
+	die_id_bit   = 0;
+
+	/* If interleaved over more than 1 channel: */
+	if (ctx->intlv_num_chan) {
+		die_id_bit = ctx->intlv_num_chan;
+		cs_mask	   = (1 << die_id_bit) - 1;
+		ctx->cs_id = cs_fabric_id & cs_mask;
+	}
+
+	sock_id_bit = die_id_bit;
+
+	/* Read D18F1x208 (SystemFabricIdMask). */
+	if (ctx->intlv_num_dies || ctx->intlv_num_sockets)
+		if (df_indirect_read_broadcast(ctx->nid, 1, 0x208, &ctx->tmp))
+			return -EINVAL;
+
+	/* If interleaved over more than 1 die: */
+	if (ctx->intlv_num_dies) {
+		sock_id_bit  = die_id_bit + ctx->intlv_num_dies;
+		die_id_shift = (ctx->tmp >> 24) & 0xF;
+		die_id_mask  = (ctx->tmp >> 8) & 0xFF;
+
+		ctx->cs_id |= ((cs_fabric_id & die_id_mask) >> die_id_shift) << die_id_bit;
+	}
+
+	/* If interleaved over more than 1 socket: */
+	if (ctx->intlv_num_sockets) {
+		socket_id_shift	= (ctx->tmp >> 28) & 0xF;
+		socket_id_mask	= (ctx->tmp >> 16) & 0xFF;
+
+		ctx->cs_id |= ((cs_fabric_id & socket_id_mask) >> socket_id_shift) << sock_id_bit;
+	}
+
+	return 0;
+}
+
+static int denormalize_addr(struct addr_ctx *ctx)
+{
+	u8 num_intlv_bits;
 
 	/* Return early if no interleaving. */
 	if (ctx->intlv_mode == NONE)
@@ -1265,55 +1310,12 @@ static int denormalize_addr(struct addr_ctx *ctx)
 
 	ctx->make_space_for_cs_id(ctx);
 
+	if (calculate_cs_id(ctx))
+		return -EINVAL;
+
 	if (num_intlv_bits > 0) {
-		u8 die_id_bit, sock_id_bit, cs_fabric_id;
 		u64 temp_addr_i;
 
-		/*
-		 * Read FabricBlockInstanceInformation3_CS[BlockFabricID].
-		 * This is the fabric id for this coherent slave. Use
-		 * umc/channel# as instance id of the coherent slave
-		 * for FICAA.
-		 */
-		if (df_indirect_read_instance(ctx->nid, 0, 0x50, ctx->inst_id, &ctx->tmp))
-			return -EINVAL;
-
-		cs_fabric_id = (ctx->tmp >> 8) & 0xFF;
-		die_id_bit   = 0;
-
-		/* If interleaved over more than 1 channel: */
-		if (ctx->intlv_num_chan) {
-			die_id_bit = ctx->intlv_num_chan;
-			cs_mask	   = (1 << die_id_bit) - 1;
-			ctx->cs_id = cs_fabric_id & cs_mask;
-		}
-
-		sock_id_bit = die_id_bit;
-
-		/* Read D18F1x208 (SystemFabricIdMask). */
-		if (ctx->intlv_num_dies || ctx->intlv_num_sockets)
-			if (df_indirect_read_broadcast(ctx->nid, 1, 0x208, &ctx->tmp))
-				return -EINVAL;
-
-		/* If interleaved over more than 1 die. */
-		if (ctx->intlv_num_dies) {
-			sock_id_bit  = die_id_bit + ctx->intlv_num_dies;
-			die_id_shift = (ctx->tmp >> 24) & 0xF;
-			die_id_mask  = (ctx->tmp >> 8) & 0xFF;
-
-			ctx->cs_id |= ((cs_fabric_id & die_id_mask)
-					>> die_id_shift) << die_id_bit;
-		}
-
-		/* If interleaved over more than 1 socket. */
-		if (ctx->intlv_num_sockets) {
-			socket_id_shift	= (ctx->tmp >> 28) & 0xF;
-			socket_id_mask	= (ctx->tmp >> 16) & 0xFF;
-
-			ctx->cs_id |= ((cs_fabric_id & socket_id_mask)
-					>> socket_id_shift) << sock_id_bit;
-		}
-
 		/*
 		 * The pre-interleaved address consists of XXXXXXIIIYYYYY
 		 * where III is the ID for this CS, and XXXXXXYYYYY are the
-- 
2.25.1

