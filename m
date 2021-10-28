Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8753C43E7DA
	for <lists+linux-edac@lfdr.de>; Thu, 28 Oct 2021 20:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhJ1SCZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Oct 2021 14:02:25 -0400
Received: from mail-mw2nam12on2082.outbound.protection.outlook.com ([40.107.244.82]:49467
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231573AbhJ1SBN (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Oct 2021 14:01:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qw/zqJNpr7TZTMg9V3BTFqaaTAgl+ee1mUciMgH107uby7VUSNGaBL5lEICDS84v3SvXWYeL5jT6gaVenejEKVZf9bcsU+ELA4h4SxWbT5rM9hkXejnC82HuzWaz7ZC0Cli7g4XgNXB9x18cUfGVDqSFDj91KJ8YIZub+Upk+33ZtYwCCaqWg3d17IldmtPPf+lI/0UqQEbfs/V6tq4AbCqhcp4TzkOTBVhAMmv9YsWnuvhW7PiPXS7fpmqQg0dbhoktlAxnFRgMU3E969aDn+SBG4wmT6opK6qWr0EsoC2aaWE3uV4JT/cGQQBahRD/AocgOBnsro/xMvn72giOFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5mNPu3A4dYDZ59K2RdXqU2t4NYRe3wORVuLmGrRdb9Q=;
 b=fKzbUpHZLJEEUiQ+sPgqD+92gMmbhG/57Jj/p/F6nyeNLpAkFfpW9x0dGusvEEyjmgiqQslb7YjTGT/d0fiZNbzvpzWosc1uTFidAwnRtZN6F7V0f/AYgTLkh2xSo74zovgt1KvvdVMgMZQ/ujrIBgEOHwZj7D4psrmovkKHAZi+ymhcqzUogv1g68TwHySim+v7T2NUZSf6Yw/RBen3OSm0sgXtp46d2lO1tYW5otg4AChwucj1FYg8vZZgGqXLH9lP+ZJkrFn3NSIbZ6pYl7qkrNgPwB5MS91hVzCRXSPvQy/v7LwuGK4S7X/9qV45emCyfUeux1I100MMCE2nWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mNPu3A4dYDZ59K2RdXqU2t4NYRe3wORVuLmGrRdb9Q=;
 b=ijbtUl7KROA/DpktGNH5/Ci/B8QuBhD29pba1POQdKvD5N20ibWMVGaqR026a+oeMvHa17IO1HDJSZZZSeoEHPOvqrGbLSslvv8UUR2Ip1RoExIXjVnTAxDkD2pG1h6fz5o08LI375Kg6x9DjdeOsDw7iHdGZeEEKs6zLbSUlic=
Received: from MW4PR03CA0265.namprd03.prod.outlook.com (2603:10b6:303:b4::30)
 by CY4PR1201MB2548.namprd12.prod.outlook.com (2603:10b6:903:d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13; Thu, 28 Oct
 2021 17:58:44 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::27) by MW4PR03CA0265.outlook.office365.com
 (2603:10b6:303:b4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Thu, 28 Oct 2021 17:58:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 17:58:43 +0000
Received: from yaz-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 12:58:41 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <NaveenKrishna.Chatradhi@amd.com>, <Muralidhara.MK@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v3 28/33] EDAC/amd64: Define function to get interleave address select bit
Date:   Thu, 28 Oct 2021 17:57:23 +0000
Message-ID: <20211028175728.121452-29-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8b68256d-c501-43b2-1f29-08d99a3c94f1
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2548:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2548A96E9F43A70640A79D56F8869@CY4PR1201MB2548.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SZ4nWJHbT2sUESgwWQTOuwIJvbZ1Q3PAVFSZiDtW+p2jyfNYzjA/SG7HekxZhthRdE8wg8283SS1tTXPZP8mlhGHYYbsymA4o4hlcQCrtShQ4heOj+nfDYGBKwDIKXefqguR0FBlc1SvxYd6JmyGf9mduYujcpbpiDa1qG3wJLAj3BAc8zTBYf3W1/DKQZuqLHgumcc2z352hIBI5pmBICFZHrqHYJ+2BPlBAjjdf37GA89+nnfsvPloN+9wUlM92OkJ/YQt2pFkJ7gXu88T18S2e35HEEhqbUu1nSgYjvS3MkhCdMV/Wfd957MAQ8qFJLaXPsjbZ2huH6AThZ6nNCjaOXkWNpN3JVFl2CoSYzkQg3GVXhgcX6J1k+Ldzi7IgjR6wjO2uQjkadWHjTdevYCXtYLSqMaP+t0iciEISzELSWZI02spm4XGKZpdFv5XslszPpBT+0lBRzmYOVBFhUeOklBEckNW9ucqtCHv9ZS/wQutBi26Iine/YZk4ZX5IVDKxaDXqaL5zlN2Sn3ew7hMoLpGRp+g5hTTHKMZipxcFEaMO1S/2r1KmzYjMMdNmh8iqdjwc6fPu0G+NbhJ4sidu4niaZnH2YIJS134AfCo/doO02xFL3GlCsq6+MCAzeRxxjgtSdC6jUUNRDbeXO/fEOdy/3rbeoLkaEO4m9YPqVgWY1Gy2SCsOOIC5JP74Ev3KcoEhVLOGJFKnjhrfFdNgiVvFKFYrZDZ6ybG9QO+7DxnXlmbEr6BY/AMP3+heaJC8/Y8OTqsPEGHZLt35U1HnLrJ76YQYFrtxNtr5LVJl5snl73Uu/mYlc5u4TuT
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(82310400003)(54906003)(83380400001)(316002)(47076005)(81166007)(356005)(6666004)(70206006)(44832011)(70586007)(966005)(336012)(508600001)(6916009)(2616005)(2906002)(36756003)(4326008)(5660300002)(8676002)(86362001)(1076003)(7696005)(426003)(16526019)(36860700001)(8936002)(26005)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 17:58:43.5602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b68256d-c501-43b2-1f29-08d99a3c94f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2548
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

...this will be expanded for future Data Fabric versions.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210623192002.3671647-30-yazen.ghannam@amd.com

v2->v3:
* Was patch 29 in v2.

v1->v2:
* New in v2.

 drivers/edac/amd64_edac.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index c6fd813f596f..cf5849a9a969 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1087,6 +1087,7 @@ struct data_fabric_ops {
 	u16	(*get_component_id_mask)	(struct addr_ctx *ctx);
 	u8	(*get_die_id_shift)		(struct addr_ctx *ctx);
 	u8	(*get_socket_id_shift)		(struct addr_ctx *ctx);
+	u8	(*get_intlv_addr_sel)		(struct addr_ctx *ctx);
 	int	(*get_intlv_mode)		(struct addr_ctx *ctx);
 	int	(*get_cs_fabric_id)		(struct addr_ctx *ctx);
 	int	(*get_masks)			(struct addr_ctx *ctx);
@@ -1163,6 +1164,11 @@ static int get_intlv_mode_df2(struct addr_ctx *ctx)
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
@@ -1219,6 +1225,7 @@ static u16 get_component_id_mask_df2(struct addr_ctx *ctx)
 struct data_fabric_ops df2_ops = {
 	.get_hi_addr_offset		=	get_hi_addr_offset_df2,
 	.get_intlv_mode			=	get_intlv_mode_df2,
+	.get_intlv_addr_sel		=	get_intlv_addr_sel_df2,
 	.get_intlv_num_dies		=	get_intlv_num_dies_df2,
 	.get_intlv_num_sockets		=	get_intlv_num_sockets_df2,
 	.get_cs_fabric_id		=	get_cs_fabric_id_df2,
@@ -1283,7 +1290,7 @@ static int get_dram_addr_map(struct addr_ctx *ctx)
 
 static int get_intlv_addr_bit(struct addr_ctx *ctx)
 {
-	u8 intlv_addr_sel = (ctx->reg_base_addr >> 8) & 0x7;
+	u8 intlv_addr_sel = df_ops->get_intlv_addr_sel(ctx);
 
 	/* {0, 1, 2, 3} map to address bits {8, 9, 10, 11} respectively */
 	if (intlv_addr_sel > 3) {
-- 
2.25.1

