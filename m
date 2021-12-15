Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F1B475C4C
	for <lists+linux-edac@lfdr.de>; Wed, 15 Dec 2021 16:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244196AbhLOPx4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 15 Dec 2021 10:53:56 -0500
Received: from mail-dm6nam11on2041.outbound.protection.outlook.com ([40.107.223.41]:35201
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244199AbhLOPxw (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 15 Dec 2021 10:53:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2mfdsc4NmPgSKcTLNNDXeVBs9KkPX5o7Sb2oNrTBTCwd4TCDQBEB6wnbzGvpgFDN9H89KcIdo4QdwvTgWpXbOxvCb59Wj7yE2L+xuGZ4eNehVUKYxc0oiVl0GSsCBi885yavwD8Mu9nl8F282BX/2npTkWAE6qX+oYCHz6KJLclbfUbK52WjHX/jx2og2hOhysMmO6Oi4B+s1H8zxjYQk6GdvPFcptplynFTfk/6aKtTVfYlpJveRhukNeisgLFVE2wSpmCqJ9ITg/W8dyfEBLPvnqHMLmKctuqZSwSJUWQZWA5tvDuWAI7NXphfiw2JgbUj+9sQH9CRoFbGa9Ofw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XjERzzGg4II9o1sCB2wnyQ38HwXzl+CI1MR2b6ze54A=;
 b=fLWXO0gaSB4j66OA/hASOfwLqTqSSxNzlvbxQ5I8vjKzvJg8fy41ODWVrd3JqEzJw+/kr1mptSleZTPNrzcDCOrZCcR64JWaC4FlwS9eCoF6AcvZUxj1zt4Jw9EsoDWpcBHtY/wUYG7BN01nEc+Aw26kIT5pzkwF2BHh1hD/2t+KlvM48Rq7bS57xySg1f+iuZ0CY/YcfIKvyYym0ZxRuWXrOk+SahmqzLQaUzY1tG43k/icm/wS0n2w98XJAvMWCYIU+/vOqe45yrJFLiZJUlzziva4VKr+2pokVuerKHxQYZmOTogqNlQvZScLPXOTuPVfQBB65ZbLq84LlE7D0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjERzzGg4II9o1sCB2wnyQ38HwXzl+CI1MR2b6ze54A=;
 b=dyZG7I7fhXtpmsuDmV/1m3uKCYvtJIABcXNdbVH4dSpYTlrPwhi0IGqvIlGxp+y/XOxj18XFek7j3Y2L+srm0K19Y3No020q3rSHcsLA6p1gGl5lFFVlOimn0SEbY3u9JdO3Mjmi67OMXQcaf083m4mqof6M0u4W/JlELl4VSd4=
Received: from BN0PR04CA0167.namprd04.prod.outlook.com (2603:10b6:408:eb::22)
 by BY5PR12MB4856.namprd12.prod.outlook.com (2603:10b6:a03:1d5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Wed, 15 Dec
 2021 15:53:49 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::77) by BN0PR04CA0167.outlook.office365.com
 (2603:10b6:408:eb::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Wed, 15 Dec 2021 15:53:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Wed, 15 Dec 2021 15:53:49 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 15 Dec
 2021 09:53:48 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <william.roche@oracle.com>, "Yazen Ghannam" <yazen.ghannam@amd.com>
Subject: [PATCH v2 1/2] EDAC/amd64: Check register values from all UMCs
Date:   Wed, 15 Dec 2021 15:53:08 +0000
Message-ID: <20211215155309.2711917-2-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215155309.2711917-1-yazen.ghannam@amd.com>
References: <20211215155309.2711917-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4eab623-f3c0-40ec-dc4c-08d9bfe315df
X-MS-TrafficTypeDiagnostic: BY5PR12MB4856:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4856D0062E7926B85579A342F8769@BY5PR12MB4856.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MVPxljwVZLv7o069yWSA1dCjK7Esi2bYjsaSxwbCyZDk7SDAFWmST/iGpVLxHdDVKCjMV3e7kBkSkfZZkzvLGeMs9fgvTXl2RblXeUOf5ivOD3OP0XcAaqLBqa+Mneot9pUoXwA3+t86fjpBuzZZ124+m3rwYcntgyL0+t6wDGNjsp2JUVwD7v2/w1MaaZHFATTvCNeUaj5HxnB0cpRJAvvMFuaApHlNUpQSYm/t424xeqAoMSI+sL9Pyd24vQzYRBCf4MnMbw7VBj4NXTPM0H7CV8MdxHpuOZ2/WZJQlrt6cXnLqs871Mx3v33F5EOYWtUVnbNyvfu/2bE7dMkTBbOSo1eLB+kc9Ai9YqAGFSY0wtDwhsqbZ2G+kLY5/fFm/InR8GCm/XRM7L45kJNVej0o1UOTgheN8GKEm/MB1lZhnHeWWKGWKwPRSarz8pdJuu0yv8gktWWBL9Y1/EhjlD6GojQbG6Hjb9kkEaAG8sU0UYtVyzduXyyK8BR3L+ZpbpTOdnWbqJC4jmoa7Qypb5S3xbcuwZyIERjQlj09pgxqXr2PcsDeQUo9Z+0UWKA2uYY/Arj5vxiJTgjVk+hWaVUC5PmF6PueM+k0toMi5xwxVmBaeTXcmeaT+SKQepUNHqAowS5RN3s65nnUTw0unvI573eE086elc4fATJI9RsUCurqSMqvntKSZiC58cLd053sq2ZYlo+uRcAzzt7yIoSFpDJQ3DC183y1YmRJDW/LLNzA7BYcBTlmfqVQguBJ7QBa1gzaz8UnYVT/NyrPjnk8FWt20XM9dKzFTrof0RC/b2Rl304l09dYokgXadFHF8dbB6JI7z8FO61NsSeGT+dWuI2QnPsheoY7SLxmpauVxNXzW6k6aDLgOBwDv2u4
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(6916009)(6666004)(40460700001)(70206006)(1076003)(966005)(5660300002)(82310400004)(508600001)(36860700001)(186003)(7696005)(16526019)(86362001)(26005)(83380400001)(4326008)(2906002)(8936002)(356005)(316002)(54906003)(70586007)(8676002)(426003)(336012)(44832011)(2616005)(81166007)(36756003)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 15:53:49.4641
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4eab623-f3c0-40ec-dc4c-08d9bfe315df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4856
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The initial support for Unified Memory Controllers (UMCs) was added to
AMD64 EDAC for the first generation of Zen systems. These systems have
two UMCs per Die, and the code originally assumed two UMCs in various
places.

Later systems have more than two UMCs, and this assumption was fixed in
the following commits.

commit bdcee7747f5c ("EDAC/amd64: Support more than two Unified Memory Controllers")
commit d971e28e2ce4 ("EDAC/amd64: Support more than two controllers for chip selects handling")

However, the determine_memory_type() function was missed in these
changes, and two UMCs are still assumed.

Update determine_memory_type() to account for all UMCs when checking the
register values.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20211208174356.1997855-4-yazen.ghannam@amd.com

v1->v2:
* Was patch 3 in v1.
* Update commit message.

 drivers/edac/amd64_edac.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index ff29267e46a6..1df763128483 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1621,9 +1621,16 @@ static void determine_memory_type(struct amd64_pvt *pvt)
 	u32 dram_ctrl, dcsm;
 
 	if (pvt->umc) {
-		if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(5))
+		u32 umc_cfg = 0, dimm_cfg = 0, i = 0;
+
+		for_each_umc(i) {
+			umc_cfg  |= pvt->umc[i].umc_cfg;
+			dimm_cfg |= pvt->umc[i].dimm_cfg;
+		}
+
+		if (dimm_cfg & BIT(5))
 			pvt->dram_type = MEM_LRDDR4;
-		else if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(4))
+		else if (dimm_cfg & BIT(4))
 			pvt->dram_type = MEM_RDDR4;
 		else
 			pvt->dram_type = MEM_DDR4;
-- 
2.25.1

