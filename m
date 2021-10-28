Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E9243E7B7
	for <lists+linux-edac@lfdr.de>; Thu, 28 Oct 2021 19:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhJ1SBS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Oct 2021 14:01:18 -0400
Received: from mail-dm6nam10on2046.outbound.protection.outlook.com ([40.107.93.46]:46625
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231332AbhJ1SAu (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Oct 2021 14:00:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngmwO5xashDpcmUs+/5u+HX3zZ+fWOGNuwnKyYLXEAElwExV3GfvuD3sieuQGuMSvlIiNr+85wkKrNztRm5cw+aEspxVD4Plfs9KQi0+TFyHLSOMxCBIyx2HjpNvAD+SoFzJLVhFCvLMe9fgChOM2UGxRRVq5ckvYyTxd6LHIpIens8gHJCSfkZ6dgy+bxApDWnAW6iDATPPXc5QUg6B+NT58CuS5mGCnKTehBob2MgW1MKrRNzWtygolXcKNWrTIyDmTrxZCuQgjHXijJylZfXXBslZiGquanahuWPqLZg8V7RESAlx4TkRFk/psSbJnf44NweZuwnKlrraY/Pdvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xCBdx6IpQJ2WFQZyZX1mwGlgb2qK01VFMSUjGSbuLo=;
 b=k7yqm3cfDA5qNDRbhmuktxFFp00msyhaCm9nh9VVFYzSFpuvkYfmvgd+KA0BnQwcSYuVaveiJHXfp4RL1vcYWELp21m2T5IjVGewePPZmn6SDCu437eoWkzF3RSrITdGNahcBYaKMRzOW7X4d/gwUzRibmE+bL6qRPVOmYXbcM1y4JAYTpRyuZht639Ft9Om3SZjx3A5U3xgBZgM9vhQm2jPmkFqnozmpfWje2o2GjsYq6ptcSVFFTnroQcvcxpTEa1GE6g5rVHFdggFEK83gUNuIzUYdh/3bZDTM7hMcEmoOpXs6bei2PEEOv2BaFh4gms27wWsEt7Rt9DwVsyikQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xCBdx6IpQJ2WFQZyZX1mwGlgb2qK01VFMSUjGSbuLo=;
 b=4/wyp+RbGCYrveKsixiAcbQq/tAzC0wfnIsAK7PuXAP80wywT6XHfKjPCy+WinAEpmzmHFJjxDZYpdjZZy7xAk5oBlJ6ibEnLPwQomJds0KQijNbINcRVxH4zt1sYjoO43dlgk265Kx90RwQDlz1l0NnGftUpmdGl+eXVDdPJBo=
Received: from CO1PR15CA0095.namprd15.prod.outlook.com (2603:10b6:101:21::15)
 by BYAPR12MB3383.namprd12.prod.outlook.com (2603:10b6:a03:dc::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Thu, 28 Oct
 2021 17:58:21 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::18) by CO1PR15CA0095.outlook.office365.com
 (2603:10b6:101:21::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Thu, 28 Oct 2021 17:58:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 17:58:20 +0000
Received: from yaz-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 12:58:18 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <NaveenKrishna.Chatradhi@amd.com>, <Muralidhara.MK@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v3 13/33] EDAC/amd64: Remove goto statements
Date:   Thu, 28 Oct 2021 17:57:08 +0000
Message-ID: <20211028175728.121452-14-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: e6a42df0-2d10-4af8-f23b-08d99a3c8723
X-MS-TrafficTypeDiagnostic: BYAPR12MB3383:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3383BFF76E16A542FFAC4569F8869@BYAPR12MB3383.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oVFGPu9rHezwJUOrLW0OA+Ud3ePNiP4IBk8D19WGiHz5oUaj6AZmBcHObobskHYVHu84Km3/EIsO54ss+ytLYq8ukUsF/2wpQwBkQGLy3K1EenkemRpKVt+CfHmoaw2G5bcx25DyEyn/1L3crRyjX1b56DQLU3udbrne6K+MQ9DvL4oRiB/LCU00GvPurcu+qpeu/sYgsdr22+GVNiWZrCBG0v2dX2dF4TY7oIMj4M+mwSDsxSMhEjpE7Iv7dj8J7fj+KSr5DYdKvUTr2OBD9rYC4RrrXAJ+y+PH9hdri4wAfWp+yVAyL+ZLfnfr57azXCuTbKK/M/guBKHTqWs85r/UvmE4i2c4w0bVk8HT6SLdHupe+2U7jamb9UEVQEsmRGKgK2GGLOkKb9noNWSZrIoLuQvHKgW7JM3wwjPY1ufFwUfuZtChwFoGN7w5xMoBI5rGMalampIiHKZhpYloh/zenyEL+7IEo/TJHGZOoGzzCIbKQWZOm06oBMdbHw8jiOHXm0mCBFhuN2209aXA44n/YK4LpQLjLA2i/MBd1NDtg7em0ekwx4ZF0/QDcE9cRslSMimEij8hcyXN1Hr26C1A3tZXDsWFDRTwQE3Enfumo4xjqrHDd8G1w/e1+lKGl0Du1xAkDL56MXMCOjC6cgLRkX8PLjVG0aojfTIJjJ6PNy2tZJ74VwYa0LT2uFgDZjvR+ByBpqxtg+5RrvidDIA6yUoMrG1fgOyVqLGAch+MAS+KDR31xsILoLTlyUcBSGOu6jacoODsc6PdGa09LWTG6Xz4N6IQhQtIHjDHcEeDl1xtZH/LXomsiollZ2UC
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(86362001)(6666004)(356005)(508600001)(83380400001)(36756003)(82310400003)(966005)(26005)(2616005)(70586007)(186003)(2906002)(16526019)(8676002)(47076005)(316002)(54906003)(4326008)(5660300002)(81166007)(426003)(36860700001)(8936002)(336012)(1076003)(70206006)(44832011)(7696005)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 17:58:20.3812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a42df0-2d10-4af8-f23b-08d99a3c8723
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3383
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

...and just return error codes directly.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210623192002.3671647-15-yazen.ghannam@amd.com

v2->v3:
* Was patch 14 in v2.

v1->v2:
* Moved from arch/x86 to EDAC.

 drivers/edac/amd64_edac.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index b0bf9dd0ba34..2bacc8111f8e 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1347,28 +1347,25 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 		return -EINVAL;
 
 	if (get_dram_addr_map(&ctx))
-		goto out_err;
+		return -EINVAL;
 
 	if (df_ops->get_intlv_mode(&ctx))
-		goto out_err;
+		return -EINVAL;
 
 	if (denormalize_addr(&ctx))
-		goto out_err;
+		return -EINVAL;
 
 	if (add_base_and_hole(&ctx))
-		goto out_err;
+		return -EINVAL;
 
 	if (ctx.dehash_addr && ctx.dehash_addr(&ctx))
-		goto out_err;
+		return -EINVAL;
 
 	if (addr_over_limit(&ctx))
-		goto out_err;
+		return -EINVAL;
 
 	*sys_addr = ctx.ret_addr;
 	return 0;
-
-out_err:
-	return -EINVAL;
 }
 
 static int get_channel_from_ecc_syndrome(struct mem_ctl_info *, u16);
-- 
2.25.1

