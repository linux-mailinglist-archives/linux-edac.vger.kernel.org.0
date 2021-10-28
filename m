Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09F643E7CD
	for <lists+linux-edac@lfdr.de>; Thu, 28 Oct 2021 19:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbhJ1SB5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Oct 2021 14:01:57 -0400
Received: from mail-mw2nam12on2066.outbound.protection.outlook.com ([40.107.244.66]:16033
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231508AbhJ1SBF (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Oct 2021 14:01:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIGypAgEuCzTs52k/vBNUySOTuXRE5P1f2Pe4BJbFX3RbIzE+PkyF6cgvs7KpK1UEhVfWGZDMJaubvKfrcPxFA2WF5Z9c6ynNkE42pWVAmzEwnM84BxbpMm/djh05hds4vhjdu0MbpZ2tXyAuoLoxuDY8VGRuNLQgnN7BDoZXYDcv5asSvQGL1+GDab8NpZE1BH7eAT/VKQKK5hqEFc6TDkgpW/ScmaWruRytYImFEW8Ocw7PHjRSznUvO8hA9EQ+7NeXbAeDla0vZ3jlOmoUZ+0zsaMeLDgMy7Dn/r/9fUDspzPRSha8Wv5AacbfnTt/eFfnfm/lChYfVwwOb+XZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qiTflZ3kzPXc4cnJg53mbQUtcCOoT22I3NuEPWG4IMo=;
 b=Z+U/Rlw0a0kL1977Nc/OyWNaMSMJmG9CQvt3bfmqu6tnuVXkmTrJUj5de1ozjjrWdbrz8xLX6slKpthknVJv4zctkQQBYEJ3uaC/8DiBFSGppNVymWcum/e5+UDUseeQMcT3yg50b7tcb3eezt1wWrx3xVbJslZsmynKRQeELn8zS0ad53WUKW775XfxJ1RoILr2sLKNEb6/VW+v0fFRBvqAvKYEGdZtnt/UYiaNhgQSQ2lU4a3bXK7mi4fYxqd/ojaJp8LHi/h+1b9rAgIFTrw4B5NF+iG+iEuE6GA+thgeGojVwctJ8Gz0zJMJzTsyj6s8KS/rfJDfjzppBFdbOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qiTflZ3kzPXc4cnJg53mbQUtcCOoT22I3NuEPWG4IMo=;
 b=LhO+PnvNYHU1uSBO0S322wn7xcSZg+QObypd3vdMTNTrAzHpUuhBGAjJMvKd1nFesRQJifcUnp9FH976vLByFguAizrM4S8r+TTHZpdOn77CWXou8pEEhiPM/unLDKulvfnKrIhPqRV6DBwS8buZBuFKjUFnM/j0/JmX9qE5z3M=
Received: from CO1PR15CA0099.namprd15.prod.outlook.com (2603:10b6:101:21::19)
 by DM5PR12MB1179.namprd12.prod.outlook.com (2603:10b6:3:6f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.20; Thu, 28 Oct 2021 17:58:36 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::4f) by CO1PR15CA0099.outlook.office365.com
 (2603:10b6:101:21::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Thu, 28 Oct 2021 17:58:36 +0000
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
 2021 12:58:34 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <NaveenKrishna.Chatradhi@amd.com>, <Muralidhara.MK@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v3 23/33] EDAC/amd64: Define function to insert CS ID into address
Date:   Thu, 28 Oct 2021 17:57:18 +0000
Message-ID: <20211028175728.121452-24-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 091f0e0a-30b1-46c5-49bf-08d99a3c906d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1179:
X-Microsoft-Antispam-PRVS: <DM5PR12MB11795A1183C6236F9C675EC9F8869@DM5PR12MB1179.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wjpKcTDrL3W1+nW612izdqYLjoifb1M7FRwRTtvwFeG18gJriSBkXWknwloADBg44xQw73hzRFE0Vi12tNtiofQQu/MqkGrzrf9gkvRgYXwMOruKVxLPtR4ZTiM8XiOS7O900tkE1m3zFFl+/JRB5eRI/8raqrgm5I19NjAmXMJLesXUXriMMUNrA3McCKpbqF6vXwGQ7yGgLJ67Gc5EDA4uKiMkJEkrS4GMJ7rx6ZLOlJDTbOK+SxLhy81k3WuFBvs2WXfrVynYoHj91KC559KghhJYAFtKiInmfnYiuHagoT4nLfizZ4zkEf7WtdksvRQ2sHN0YdeJfsJXfgJaPa/6BUnY+koyqcY5icbAX8gj1iVeEMinRivu1ZYtF2c1zdsSyYoCfpyVbGj7tXj7lxBbHt5Q6/zQko59ze9Dr1rZvgMc6nUQsK8E/YIOS13yfeOwAHmDTBzY120VuXZWMqJpAKoZa9onZ12H9GeFE0RG/EQ/Eb8NU0I123HQKjjgILSS8SuZDD9LrOm25rHpN9NsoC6GwfExUJBl5bsUQmJGp7JHkqqAxMyoKcUMXatuQVNruR8pTF0LPnHHGbmRGvveOTE7cgNcOO7HXxBXDt9jaf5/wgbqvDhPNvqXJkfTL9Ix4r01iyShgas3UC3P1AYfM0kbC6nBXDyhT3LjqaVByo4n8hXIIyN+Na6t2FirJeNFnvZHwlQtf+klzGkmpD8HPOOQ1BM2vmAPLAYNUFAr4H3q0DtyCfs+XpabfKYPVdtPpYUTT9dSGBJxuVwyyyvRVeZqsfEdypE/tjm25Z7BkLR7ojnvSudmtUJgSRSO
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(356005)(16526019)(426003)(70586007)(2906002)(70206006)(54906003)(36756003)(44832011)(7696005)(83380400001)(508600001)(36860700001)(81166007)(1076003)(966005)(186003)(86362001)(47076005)(26005)(8676002)(6916009)(316002)(8936002)(4326008)(82310400003)(336012)(2616005)(5660300002)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 17:58:35.9843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 091f0e0a-30b1-46c5-49bf-08d99a3c906d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1179
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move the code that inserts the CS ID into the address into a separate
helper function.

Save the function pointer in the context struct. It will be set based on
interleaving mode rather than Data Fabric version. This will be expanded
for new interleaving modes added in future Data Fabric versions.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210623192002.3671647-25-yazen.ghannam@amd.com

v2->v3:
* Was patch 24 in v2.

v1->v2:
* Moved from arch/x86 to EDAC.
* Added function pointer to ctx struct.

 drivers/edac/amd64_edac.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 2da0170f6d84..a36df70910aa 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1074,6 +1074,7 @@ struct addr_ctx {
 	u8 cs_id;
 	int (*dehash_addr)(struct addr_ctx *ctx);
 	void (*make_space_for_cs_id)(struct addr_ctx *ctx);
+	void (*insert_cs_id)(struct addr_ctx *ctx);
 };
 
 struct data_fabric_ops {
@@ -1106,6 +1107,11 @@ static void make_space_for_cs_id_simple(struct addr_ctx *ctx)
 	expand_bits(ctx->intlv_addr_bit, num_intlv_bits, &ctx->ret_addr);
 }
 
+static void insert_cs_id_simple(struct addr_ctx *ctx)
+{
+	ctx->ret_addr |= (ctx->cs_id << ctx->intlv_addr_bit);
+}
+
 static u64 get_hi_addr_offset_df2(struct addr_ctx *ctx)
 {
 	return (ctx->reg_dram_offset & GENMASK_ULL(31, 20)) << 8;
@@ -1137,6 +1143,7 @@ static int get_intlv_mode_df2(struct addr_ctx *ctx)
 	}
 
 	ctx->make_space_for_cs_id = make_space_for_cs_id_simple;
+	ctx->insert_cs_id = insert_cs_id_simple;
 
 	if (ctx->intlv_mode != NONE &&
 	    ctx->intlv_mode != NOHASH_2CH &&
@@ -1295,8 +1302,6 @@ static int calculate_cs_id(struct addr_ctx *ctx)
 
 static int denormalize_addr(struct addr_ctx *ctx)
 {
-	u8 num_intlv_bits;
-
 	/* Return early if no interleaving. */
 	if (ctx->intlv_mode == NONE)
 		return 0;
@@ -1313,20 +1318,7 @@ static int denormalize_addr(struct addr_ctx *ctx)
 	if (calculate_cs_id(ctx))
 		return -EINVAL;
 
-	if (num_intlv_bits > 0) {
-		u64 temp_addr_i;
-
-		/*
-		 * The pre-interleaved address consists of XXXXXXIIIYYYYY
-		 * where III is the ID for this CS, and XXXXXXYYYYY are the
-		 * address bits from the post-interleaved address.
-		 * "num_intlv_bits" has been calculated to tell us how many "I"
-		 * bits there are. "intlv_addr_bit" tells us how many "Y" bits
-		 * there are (where "I" starts).
-		 */
-		temp_addr_i = (ctx->cs_id << ctx->intlv_addr_bit);
-		ctx->ret_addr |= temp_addr_i;
-	}
+	ctx->insert_cs_id(ctx);
 
 	return 0;
 }
-- 
2.25.1

