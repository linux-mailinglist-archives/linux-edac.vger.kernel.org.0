Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B2F43E7BB
	for <lists+linux-edac@lfdr.de>; Thu, 28 Oct 2021 19:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbhJ1SB0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Oct 2021 14:01:26 -0400
Received: from mail-mw2nam12on2068.outbound.protection.outlook.com ([40.107.244.68]:9091
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231384AbhJ1SAz (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Oct 2021 14:00:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lot8az09WkUN65+BR8GcKTfIUu9OWSFi+E3+sceXfxnyC5E6sioWq4VBFLdbWDuCrck4exRboDy5v8qp0ndvYTz9TXoTbXwNbEauPl4ElDiZ2+Zg1A3nd1wope2M+o0CP5yLjg20Xil0r1dFwRgEAVfFmsPbeJ9Pt+J+C+MkxCEGfFpHU525rCH2fk8DEyV/7S1MJHjeOmyOGawyb4Go/796y3Z1SnBq1q92h6EeICYUVIjP6obwgjan30z2XgkZcKN0Oerxia0P0iaLWMGsxLgcoYR5dYt8Pizfywojn2B7OESfGZ9qKtVPUb6mMfj8mV3lhxiuNNxbVDpN3ZdO2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpM+izJ1kKRwKaau+Yo/fWAMSBZvB4JB/vQ9CBy7DJc=;
 b=UZTeoeMZ8zMpYKQRkQEaIAvmEV3SHfhmD9ZadyUSKZyHhnflDObpoBR7DJAVGDWhj8DEOj+VBRnuiUbZju/lWAVl4VkJRGKFn3eOmvYo7OzOCJbL9M+urAvT8En8lyL/964ocjfiiyYdBH3CaCk66vLeRauszDHEroGB+ITFUDsFTTBUgpbVzC5FHw5oo3FgzR8g0fZ+3j398TS7Xr51tEeUhQeVjsf0pxCWvYTk+qAT/NZASswXSs3dSnj3A6PNgAS4KlLpxensq/nkesH4NQXUwh8T0ywJeGQLk4hbybzUvnQlq/lxn90AvI7Mv4kMlDXa1gJFu091XjL/jmqI/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpM+izJ1kKRwKaau+Yo/fWAMSBZvB4JB/vQ9CBy7DJc=;
 b=SKwQ7aghbnK716IDCnT/eU9d+GRZnu5g/l43wj2vkzo6+/Z33SynfBCcVwFJQ/PQBOvNoGR+uf198W2Jiwl15vxeEmpb0FTFE4YbynwW2oT7/dEl5Q+nBqPEIsJkWTLVxbHkLx5TEcnl7EGsoXHi8LUfrA6SvfHULY99+wrugCM=
Received: from CO1PR15CA0091.namprd15.prod.outlook.com (2603:10b6:101:21::11)
 by DM5PR12MB1419.namprd12.prod.outlook.com (2603:10b6:3:77::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Thu, 28 Oct
 2021 17:58:24 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::a0) by CO1PR15CA0091.outlook.office365.com
 (2603:10b6:101:21::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Thu, 28 Oct 2021 17:58:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 17:58:23 +0000
Received: from yaz-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 12:58:19 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <NaveenKrishna.Chatradhi@amd.com>, <Muralidhara.MK@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v3 14/33] EDAC/amd64: Simplify function parameters
Date:   Thu, 28 Oct 2021 17:57:09 +0000
Message-ID: <20211028175728.121452-15-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9d6c6620-1b57-42a0-7692-08d99a3c893a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1419:
X-Microsoft-Antispam-PRVS: <DM5PR12MB141906B25D00F615A2DC0A49F8869@DM5PR12MB1419.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HjIRrKScdtdvVT1aKxyH6AfdO4X7NMh8vg0aw3JSMvqqFSLKAY1hpovlXLU6cfzb1wXUm0B273LCBfJMyvru5hoGT+nEuKmotnRfW1Tvd9mFePeNg43yrcxlLNNtlcfWm5z856nY3gwJFC8w6l36YOXQptzF5nJ87Jb4bjYI024MsKzU7AruEEFsSRoYpteDDHKMqCBFeDclHEOhCIhEQvAreB+e59AR/j0n2k6sbxQI1BcIa0DdTk2s73zLSo9mqpQNX8aA/6AWMFheck3ZJTwmqydCK/WK/t+ww15GMnGVNfR8OvHpsz+4maqxpTGW6Pg9mZufeMoleldbch7bmsCMerQO/OrYMZ6+x6foUMvFVvAPz6ta7RVNYE4nPFxlu1MQ83M+tMwwPQ5fjLLLPBmAoEpA4UMiq4FNevr5BmojbfLWTDazlRykSvp9wSrsFVl1Dip9mXA5SgguG69u0xmUxWTsO5/oo8nOtR90ooH9ATdSXLo5E9B6TPeNhhZLv4DCysUJvG6yKxPxJYfMPTzvKOEsy23GsoE0jy28Ow65SCeuAxnFP3TUUiXy43gFkbePSozH7gQH6nbTRRwaa18JMw1tLvrv7BNBQKItKC+7zJnZTt4zV2ciKsC8bVeC2r7B7XSneRSIzYJW4MYt+2P8IvU50ypTRIv5LA6n+TIU68zPglK3qN1LRMwMZvnwZvis+BwqRuSJ8HFVzda0o9JezvuyUWy8Xz/Xl8PcQgEHx4iTTjAGh4E7Bb7ci93ZP6quaawlBHY42Jcag1RV6E6tnFZhKUAWKmWPWX/1JMM2gcP6iCW0SEbZ2lcinXo9
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(336012)(8676002)(316002)(86362001)(81166007)(4326008)(508600001)(6666004)(2906002)(83380400001)(7696005)(54906003)(5660300002)(47076005)(966005)(356005)(426003)(1076003)(82310400003)(2616005)(16526019)(186003)(36756003)(70586007)(8936002)(36860700001)(26005)(6916009)(70206006)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 17:58:23.9062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d6c6620-1b57-42a0-7692-08d99a3c893a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1419
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Use a single address parameter for input and result to reduce the number
of parameters.

Also, rename the "umc" parameter to "df_inst_id" to reflect what the
value represents.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210623192002.3671647-16-yazen.ghannam@amd.com

v2->v3:
* Was patch 15 in v2.
* Renamed the "umc" parameter.

v1->v2:
* Moved from arch/x86 to EDAC.

 drivers/edac/amd64_edac.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 2bacc8111f8e..f4074bc270ec 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1328,7 +1328,7 @@ static int addr_over_limit(struct addr_ctx *ctx)
 	return 0;
 }
 
-static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
+static int umc_normaddr_to_sysaddr(u64 *addr, u16 nid, u8 df_inst_id)
 {
 	struct addr_ctx ctx;
 
@@ -1338,10 +1338,10 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	memset(&ctx, 0, sizeof(ctx));
 
 	/* We start from the normalized address */
-	ctx.ret_addr = norm_addr;
+	ctx.ret_addr = *addr;
 
 	ctx.nid = nid;
-	ctx.inst_id = umc;
+	ctx.inst_id = df_inst_id;
 
 	if (remove_dram_offset(&ctx))
 		return -EINVAL;
@@ -1364,7 +1364,7 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	if (addr_over_limit(&ctx))
 		return -EINVAL;
 
-	*sys_addr = ctx.ret_addr;
+	*addr = ctx.ret_addr;
 	return 0;
 }
 
@@ -3475,10 +3475,10 @@ static void decode_umc_error(int node_id, struct mce *m)
 {
 	u8 ecc_type = (m->status >> 45) & 0x3;
 	struct mem_ctl_info *mci;
+	u64 sys_addr = m->addr;
 	struct amd64_pvt *pvt;
 	struct err_info err;
 	u8 df_inst_id;
-	u64 sys_addr;
 
 	mci = edac_mc_find(node_id);
 	if (!mci)
@@ -3517,7 +3517,7 @@ static void decode_umc_error(int node_id, struct mce *m)
 	else
 		df_inst_id = err.channel;
 
-	if (umc_normaddr_to_sysaddr(m->addr, pvt->mc_node_id, df_inst_id, &sys_addr)) {
+	if (umc_normaddr_to_sysaddr(&sys_addr, pvt->mc_node_id, df_inst_id)) {
 		err.err_code = ERR_NORM_ADDR;
 		goto log_error;
 	}
-- 
2.25.1

