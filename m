Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87411423D80
	for <lists+linux-edac@lfdr.de>; Wed,  6 Oct 2021 14:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238211AbhJFMQ0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Oct 2021 08:16:26 -0400
Received: from mail-eopbgr00115.outbound.protection.outlook.com ([40.107.0.115]:63111
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238105AbhJFMQ0 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 6 Oct 2021 08:16:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAaG2Xo0kbdAf8eOp9OJe+9UDgP/lSGKxXmlAOHZqqR2RQUpueMxgSoW4i3cB18UTxagKrf51qcA9pyVk7LMrZOJK7MTNBZ6jQ0N5XDazzH/ab72IvRwcleiqyBdlluxwOco+I9o5HolVoAArekMjnNu2CnVvboJC0rw2WGuU93Ko1KEOKcZ+79SFjC4GdenWfnhbEDgCctjP4DTIyTCONDiTr4R8VwVT+PHofhjfQBcjVSpI4EHatsdsUt4ufKUuVW3rZxPNQ40rPQfJivqJ2V31Bm0/zi5V9ZdMQdBwhYP8y5AgdKeMPuaUSR7U83Am5DbcUEtXR3vD8m+1eWuhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IA8I46ZCuwk/e/lYk3EWSHho0wkW97bbogV1yEIaZrA=;
 b=DP6L30ruByN19qsv+k5BGquvQ4yCz+ikxRVGE9JxL0eXthkIteJ0EI1c5CHoDU1HfqY8WoAGzg0oEOqBTkIYy0BjHSM9EZ/TIsKSrmeH1stQglGHxpSFoaO0IhQCkyPbAZjytwrpBh5rVYVPU6hlMRykQZ72lHQsmWK5V/91pEdfQIx6DWfNfppgPMrLCPRvGTJ9OO7ljbeU1DbEy64MlbGnwdW77mt4QJQrBHcAonzzndvWc5Ajhk8ptb740qTHWzkoWDgXfDFeRTWDwJCOVnLb/G7BQjhSaNCA2FYbPjJFotGusDIjr5KsxnoomW0ShlQtzihJ9U9ns0CzCov0dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IA8I46ZCuwk/e/lYk3EWSHho0wkW97bbogV1yEIaZrA=;
 b=aDi65Xopb/eIb+zRHLpJFHJaOU1BS3pADASrtYqojdlNv7i/wXJZ9MgeDy4O9M6OkCbg8xenEA2hZSe1VYKpc5ky30gHxYML3Nq1FFP7IWVYijcZTEtGn2S88BhEpF9r3osZbM7yfDMeQOlZgGDmPvWCUFzcmJCsqkwesZ52WRI=
Received: from AS9PR06CA0017.eurprd06.prod.outlook.com (2603:10a6:20b:462::13)
 by VI1PR07MB5327.eurprd07.prod.outlook.com (2603:10a6:803:a5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.13; Wed, 6 Oct
 2021 12:14:32 +0000
Received: from VE1EUR03FT029.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:462:cafe::77) by AS9PR06CA0017.outlook.office365.com
 (2603:10a6:20b:462::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend
 Transport; Wed, 6 Oct 2021 12:14:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.17)
 smtp.mailfrom=nokia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.17; helo=fihe3nok0735.emea.nsn-net.net;
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.17) by
 VE1EUR03FT029.mail.protection.outlook.com (10.152.18.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.14 via Frontend Transport; Wed, 6 Oct 2021 12:14:32 +0000
Received: from stgt-stealth-prod-web1.de.alcatel-lucent.com ([149.204.9.2])
        by fihe3nok0735.emea.nsn-net.net (GMO) with ESMTP id 196CESOm004040
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 6 Oct 2021 12:14:28 GMT
Received: from stgt-optics-platform1.de.nokia.net (stgt-optics-platform1.de.nokia.net [149.204.14.11])
        by stgt-stealth-prod-web1.de.alcatel-lucent.com (Postfix) with ESMTP id CAD1C2AE909;
        Wed,  6 Oct 2021 14:14:21 +0200 (CEST)
Received: by stgt-optics-platform1.de.nokia.net (Postfix, from userid 69057206)
        id B4BFE2CC0333; Wed,  6 Oct 2021 14:14:21 +0200 (CEST)
From:   Hans Potsch <hans.potsch@nokia.com>
To:     jlu@pengutronix.de, linux-edac@vger.kernel.org
Cc:     harald.glock@nokia.com, Hans Potsch <hans.potsch@nokia.com>
Subject: [PATCH] EDAC/armada-xp: Fix output of uncorrectable error counter
Date:   Wed,  6 Oct 2021 14:13:32 +0200
Message-Id: <20211006121332.58788-1-hans.potsch@nokia.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <AM8PR07MB81725DB8E29F93C960A0B1C8FEB09@AM8PR07MB8172.eurprd07.prod.outlook.com>
References: <AM8PR07MB81725DB8E29F93C960A0B1C8FEB09@AM8PR07MB8172.eurprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d7ed8a61-52c2-4a5a-5b4d-08d988c2dac5
X-MS-TrafficTypeDiagnostic: VI1PR07MB5327:
X-Microsoft-Antispam-PRVS: <VI1PR07MB5327BE79BAC456CBC892ADA0FEB09@VI1PR07MB5327.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cy0JAFToHphawr09Zjv+u7sep3hok9ygjmJFC/RCNlz4hHkWc3GXigUcl/sFUHkn+PcUz3xsrwzJ0r77IBfbqNtksM6ELRVqixTQJNBDERTYKxtOawTBv1DX+O9CRhIY49z/hl0UW5w8N4gUy3X1/cfZgPl70nEET1Z2j2frsPlOVu7v1usuYUQZqdtpb6gVglC2THSGHL6mDQs1Q0oDVRozV/BhqiRdjGLHogxg3/o2sGDl6mg0UX/z/4SjZTZ7A/0lBewo/09tSdyxHkkTPzEFfB7TFFgAZ2p5MahzYz7KMJR8snEJcikstk2JqZnogQsrjq6Ql2B6ZHOOxYOaemRTm2WfKsWgR/jp8q524nLmASV5RzSF4tO69x4by6fisRy31NUHj4fkHcxoL51nkptRiPFTVPqKRf33vZQpHqBxu1hTjWAQlcbRgsfIpuvMbFTBub2sZ0FbeBCKBVRNlP1+fMkAkDs7309Ym0o2x6HT7SKM+gMnlPptNPiyoOS2QzU8yFXC7DkYLPw4MMt0qYDE2Jc7i+8H5++qxb+mZP1CprDoxcPFitYHUggz9/egRjvmg7DZIffdznWWiDXuhAmgL9EqDrgv/OKRKBAnaEKR8OpTmak9gLEb9SFEb5i3akh6/a+7jECRo3PQvHev++bYepApv3QVSh1CaT1dDE1RtySRoF2v4jnvR6RD1cNWFsYKgHpQsq97puCH7LPJQBZdOH/kNesfV5OheQYurYE=
X-Forefront-Antispam-Report: CIP:131.228.2.17;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(83380400001)(316002)(42186006)(6666004)(82310400003)(81166007)(47076005)(8676002)(356005)(8936002)(86362001)(36860700001)(44832011)(26005)(508600001)(6266002)(2616005)(5660300002)(336012)(4326008)(36756003)(186003)(107886003)(70586007)(70206006)(2906002)(4744005)(1076003)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 12:14:32.4296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ed8a61-52c2-4a5a-5b4d-08d988c2dac5
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.17];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT029.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB5327
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Incorrect parameter is passed to the edac_mc_handle_error() function.
Therefore number of correctable errors is displayed as uncorrectable
errors. Changed to correct parameter.

Signed-off-by: Hans Potsch <hans.potsch@nokia.com>
---
 drivers/edac/armada_xp_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/armada_xp_edac.c b/drivers/edac/armada_xp_edac.c
index e3e757513d1b..b1f46a974b9e 100644
--- a/drivers/edac/armada_xp_edac.c
+++ b/drivers/edac/armada_xp_edac.c
@@ -178,7 +178,7 @@ static void axp_mc_check(struct mem_ctl_info *mci)
 				     "details unavailable (multiple errors)");
 	if (cnt_dbe)
 		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
-				     cnt_sbe, /* error count */
+				     cnt_dbe, /* error count */
 				     0, 0, 0, /* pfn, offset, syndrome */
 				     -1, -1, -1, /* top, mid, low layer */
 				     mci->ctl_name,
-- 
2.32.0

