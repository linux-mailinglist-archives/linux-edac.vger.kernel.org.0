Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F40B49ECAD
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jan 2022 21:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344195AbiA0Ulz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 27 Jan 2022 15:41:55 -0500
Received: from mail-sn1anam02on2075.outbound.protection.outlook.com ([40.107.96.75]:47424
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344174AbiA0Ulu (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 27 Jan 2022 15:41:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIYZF4ppMGke1Sn+GaAZ+Z9/fcZ73uaTF4IAyclEhHkB/eIJOOek2gEPfh8rlE51fNCDp2diu7xmBxlDa6nWl2v+VpKap65W6W6I1/HfNXm24PNRdZREpgF8rtd80L/YfLkNclzLXzpfAAbxi42D4oKoyMElvr3sFBh5wPI78aWabRk0lmvB6EfUI1QTwkT/grD2G7OruG0UajRw3bDa58rsMRcyfB+RoiosRyLKdv1m2339scwEBsGDBDioyGY4E0rS68+bqSJl6HKfDw5RlhHIiCQDcG3EUKaPTQGroKdGgTGs0DMGJDoGKP0/6YcqrlYdk+B0QiBN/8nx5WB1XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ty7K66SnbulvwJdWXbojI73+6GHrFwB4r+/UzNU9yA=;
 b=Qj9Fc3L8tsY2pQk239p+z7+XIt69wFS6gdwEt5ke3dFrQRtJYMXNfeg1Hk9VCWgxzIQhT3lHvxXGOagpgTX6N1Z2jNSahjCE8/glvPBDRmWIT+eWqP1+gsjus6nixnsxs06dPgk/uuNZcPHIf57YhZFJfy6E0xlsatIoiwAN4aI6XRQLunOUjUVXckNyhS6NXmIxUM3tJGuL+MkHeV1QuONld160IqEjX15Zbo+2IvEN6+aw+vsQD54JAvibYjpc07hzZ7jLI/39DfO5CTNZV+EwchDD0ZWI6EtUtYK+woaN3nakbjg0xO7BLtJoHoX38a/Oj4JYDd/XF6Lt5tpoQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ty7K66SnbulvwJdWXbojI73+6GHrFwB4r+/UzNU9yA=;
 b=Ul+CJoQceYrCe+NXcT8+iElmF43AlFK2HYA55JBM74PLg0n60otw7ypHGC5w/1GQNN+cPtLiycYnyCBsBAsPJeh7SQpec4tfUWiUma8gMH31K1XECKaHrm/VOLJHYYuBqS98YKHqBSjgk8hg9k9O+0rcaMShZGvEXovJi4fl1AU=
Received: from MWHPR17CA0077.namprd17.prod.outlook.com (2603:10b6:300:c2::15)
 by CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 20:41:45 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2:cafe::ea) by MWHPR17CA0077.outlook.office365.com
 (2603:10b6:300:c2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18 via Frontend
 Transport; Thu, 27 Jan 2022 20:41:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 20:41:45 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 27 Jan
 2022 14:41:40 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v4 09/24] EDAC/amd64: Remove goto statements
Date:   Thu, 27 Jan 2022 20:41:00 +0000
Message-ID: <20220127204115.384161-10-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: ce1eca47-221d-4cc8-3e38-08d9e1d56efe
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB5427086462F7CB55B90CE03FF8219@CO6PR12MB5427.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VovFsceUefgWjuB4T9TGM9xPrXOV99xMsHls58zFKIZjCW2cpgvk9R1W9BsHFvSejNqzWLDxHnOoVkgK/52TUo3xXesKkXFe6uwqmCTif71E+Agc3X1wiNWezNQkOA+RlXthx2j/oqfczs5yk6ecDeVzzUrWXJV5ddYUCqQuNjFc62UhrimrM2A51N23rLK/i4k3daYUmNDEwjaiPQFQOGZovQ6XIpqIvIimbKLZgI9vHgImh89j/KRMcNq0TvhdF0LyJBDlOtemK3Ztx527xqIXNoa8LGW5/9cw7NraiC9hdmqPmljJmFQ9ch61MQOfMUMWqybiJaxVL2hCCivyvV1/jInRS8vgygpSBcJhPql69RdsQP4jXZsDMSBW+mj2ijrUCTJNC60XVZtzGeD9bjFu71faonnhhS/J3SMV1S86qZSW/x+c9eqQ8lcVkUf+Yl7o156hm3aFO01z0xXia5T4tuRuBj26fL+/STruiRp9flubcHrP3vi131ns4Alpk6lZvX7oevybwqB/El9ctwOWM0ye5s5pA6aga7ataFS6Z4o1OLowQwywyN6p1sS0GOXiPlYmFsRkjToT/nlBppc0a2ZdHB9Ufmt/OrIQArHsLViwhe7bZfHpVL1ZVfcPV/NvIRZRWbAjugpH2UfP9RBgM5vfHnzW8dEpbndzifHCdjVd4+nE8Fb7/EhXlCfrtUkSUJtv1EihvOTJ2Do3pi3B6mEOkvNwid9DOCjAtDuRqp73kJlQVeVzgSz1NHh2OoPsPGKq1FxJYqqlUk+E+5a0IlKDOQe+2JHo97gig6s=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(86362001)(6916009)(316002)(508600001)(47076005)(6666004)(70206006)(70586007)(4326008)(44832011)(5660300002)(8936002)(8676002)(7696005)(36860700001)(356005)(36756003)(26005)(40460700003)(966005)(81166007)(82310400004)(2906002)(2616005)(1076003)(54906003)(16526019)(426003)(186003)(336012)(83380400001)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 20:41:45.4044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce1eca47-221d-4cc8-3e38-08d9e1d56efe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5427
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

...and just return error codes directly.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20211028175728.121452-14-yazen.ghannam@amd.com

v3->v4:
* No change.

v2->v3:
* Was patch 14 in v2.

v1->v2:
* Moved from arch/x86 to EDAC.

 drivers/edac/amd64_edac.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 139dca3a3ba4..d568ad886d35 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1357,44 +1357,41 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 
 	if (remove_dram_offset(&ctx)) {
 		pr_debug("Failed to remove DRAM offset");
-		goto out_err;
+		return -EINVAL;
 	}
 
 	if (get_dram_addr_map(&ctx)) {
 		pr_debug("Failed to get DRAM address map");
-		goto out_err;
+		return -EINVAL;
 	}
 
 	if (df_ops->get_intlv_mode(&ctx)) {
 		pr_debug("Failed to get interleave mode");
-		goto out_err;
+		return -EINVAL;
 	}
 
 	if (denormalize_addr(&ctx)) {
 		pr_debug("Failed to denormalize address");
-		goto out_err;
+		return -EINVAL;
 	}
 
 	if (add_base_and_hole(&ctx)) {
 		pr_debug("Failed to add DRAM base address and hole");
-		goto out_err;
+		return -EINVAL;
 	}
 
 	if (ctx.dehash_addr && ctx.dehash_addr(&ctx)) {
 		pr_debug("Failed to dehash address");
-		goto out_err;
+		return -EINVAL;
 	}
 
 	if (addr_over_limit(&ctx)) {
 		pr_debug("Calculated address is over limit");
-		goto out_err;
+		return -EINVAL;
 	}
 
 	*sys_addr = ctx.ret_addr;
 	return 0;
-
-out_err:
-	return -EINVAL;
 }
 
 static int get_channel_from_ecc_syndrome(struct mem_ctl_info *, u16);
-- 
2.25.1

