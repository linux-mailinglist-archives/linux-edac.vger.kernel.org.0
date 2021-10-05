Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3DF6422CE1
	for <lists+linux-edac@lfdr.de>; Tue,  5 Oct 2021 17:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235894AbhJEPrv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 5 Oct 2021 11:47:51 -0400
Received: from mail-mw2nam10on2077.outbound.protection.outlook.com ([40.107.94.77]:33920
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235588AbhJEPru (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 5 Oct 2021 11:47:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/s3To2ZCGtA1J0Q7sm0ck4A0hjwgeLC8kvIZnVe4q8R7fJqAB3a61+05VgUufE86yOT+RoqW7gCk4JcjXDIfYM5LypXfFINQMRwBmXLT7QLNHOoxnbh45dvgvVpD5K62zx9By7kutM+a7xoCgfJU2HCFneGOmjsUxypF9Nok7J4I4reosgDw2DAXJ8b2pxxSIfGWiFRteVDcrcWIxNnx3Kfp0LFmsIKI3CbIu5V3ezk0NxiTsrl6Igb9+ltHRlkmhkmomXgmWKEOQTH/KcXy5Sfs284r3HLRn4xYxMQXNA0bWlIffqo9hmwHwtKccyJls5CABuKOY+KN4/CNlNb4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06RkNGu1oQkrHp9A2p5NMvkevqttSLQFjKWYj0X9ZWI=;
 b=VyGBdm+lc879v2fFGsC2MTo6bZ8m+3Icfwi1Q8NL4nlKoV/OeEnGNCOYVKlkaua9jzjkoBiH7iellrHYEJdiC4tHEbgqBW0tSuPYra1tgRNinI1Ysgu9X881lWSO1FnO2h9TUMcvTIJJy8fCm00QdhKXPKRfvV6oiVUaqbK/exz2Pkuam5zzisORY4Ui/T48diZgYcJTsvmJ2AQ6byesJh8Uvd/ungYOyDFgBG/65EzS0gSWhdhgmY7BlFwbMWshM6xXp9P2Nmx30yQaY9VAJZUzj/G95Wbd5ja81lu8ThXPc/cs0f/waEo3jCl89C8fKodtWqAjH9qfT0f7XxPxSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06RkNGu1oQkrHp9A2p5NMvkevqttSLQFjKWYj0X9ZWI=;
 b=wpq9s51CHIyc+6UwWQlbI9YTCi3POfwqdZEo/iN0AVuyn+AMZoaXkcCF4K4/c6RMSuijagj/EdHicVXpW3i6rYDxY70XbhZtumwfsRXIzZ8NbuevTrgvsgV42JCxpQlnpUdAA57aOmX5BzN45Dj2zyYKtFfYf1IOOE8dUvhxMWs=
Received: from MW2PR2101CA0009.namprd21.prod.outlook.com (2603:10b6:302:1::22)
 by DM6PR12MB3977.namprd12.prod.outlook.com (2603:10b6:5:1ce::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.21; Tue, 5 Oct
 2021 15:45:57 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::9b) by MW2PR2101CA0009.outlook.office365.com
 (2603:10b6:302:1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.1 via Frontend
 Transport; Tue, 5 Oct 2021 15:45:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Tue, 5 Oct 2021 15:45:57 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 5 Oct 2021
 10:45:56 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH] EDAC/amd64: Handle three rank interleaving mode
Date:   Tue, 5 Oct 2021 15:44:19 +0000
Message-ID: <20211005154419.2060504-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e0620ff-b09a-4f56-7da1-08d988173949
X-MS-TrafficTypeDiagnostic: DM6PR12MB3977:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3977D2F7977FA27CD110D29EF8AF9@DM6PR12MB3977.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gUWt+Te/UwPnPQaOR4suNNxKpl2LxM868Bu+VpyCk/ce+7unWw6kAUbpXwksQRQ5Pp0VqLbHovlzbP+h0EVevGu7e4ROobsRXa9nYWy0iIhuhHGXCS9M6/PxNAVCCHMbcMyDjlbNGHuOavcNTG78PSwGQkxCG9PuADHe6GTQFFwctv+6580zcBVyI4WPqHsGjNZkcA9fI6m2ETECzSFKtCqhC6V4FkntWtzoOWKQ8vpizNPrXIS8REMmkRQjVvUBML0Pk1xUpk4rq6A/qrespIA9X7pDJ5vM1rQ/cz2ndBSROJBN+IefLb6ZSO2WoZL4yB9joq1QjyAPHM4YPOyXLsVeLh4jRmS2ItcLFIEukspCmO8esCMldt68X9RASYo+A7BDijcUgIO0qYxjnX9HZ1VQXQ3z1KgH3Gv6VdXPnCPWVr5p+Nxp77qF2Fj6XvbVl7OwdxZcUTxHQQD5YaT2lRTmh9GQPABBNHOj5mMb3Q/eUBcKUEJDb2inqvqifR93dfqdRflZ5xpYjjC5mP7uWH1W0Aw6/Kyvqfl9CWiNR+4yItZDESNvWJaqdPqOHRdARIAFhtSVy0nS2pogs7xRKGZFE1x2jLk0oZmByd9XwEprmcdmjrH+SOf+nBbD6BFYM0gh5lI4YcUUnejwdjnjamj5UVxb0Hl/cMIT4xnrTPrMNb/AXL6LlcKNfFv6NC3aQwvisupsgfmABRpQ9eur80qeZ9vzwd02uTEDLauyVXA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(7696005)(508600001)(86362001)(186003)(16526019)(26005)(6916009)(82310400003)(2906002)(6666004)(36756003)(36860700001)(336012)(8936002)(4326008)(70586007)(70206006)(54906003)(316002)(47076005)(83380400001)(81166007)(44832011)(5660300002)(356005)(426003)(1076003)(2616005)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 15:45:57.4851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0620ff-b09a-4f56-7da1-08d988173949
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3977
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

AMD Rome systems and later support interleaving between three identical
ranks within a channel.

Check for this mode by counting the number of enabled chip selects and
comparing their masks. If there are exactly three enabled chip selects
and their masks are identical, then three rank interleaving is enabled.

The size of a rank is determined from its mask value. However, three
rank interleaving doesn't follow the method of swapping an interleave
bit with the most significant bit. Rather, the interleave bit is flipped
and the most significant bit remains the same. There is only a single
interleave bit in this case.

Account for this when determining the chip select size by keeping the
most significant bit at its original value and ignoring any zero bits.
This will return a full bitmask in [MSB:1].

Fixes: e53a3b267fb0 ("EDAC/amd64: Find Chip Select memory size using Address Mask")

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/amd64_edac.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 99b06a3e8fb1..4fce75013674 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1065,12 +1065,14 @@ static void debug_dump_dramcfg_low(struct amd64_pvt *pvt, u32 dclr, int chan)
 #define CS_ODD_PRIMARY		BIT(1)
 #define CS_EVEN_SECONDARY	BIT(2)
 #define CS_ODD_SECONDARY	BIT(3)
+#define CS_3R_INTERLEAVE	BIT(4)
 
 #define CS_EVEN			(CS_EVEN_PRIMARY | CS_EVEN_SECONDARY)
 #define CS_ODD			(CS_ODD_PRIMARY | CS_ODD_SECONDARY)
 
 static int f17_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
 {
+	u8 base, count = 0;
 	int cs_mode = 0;
 
 	if (csrow_enabled(2 * dimm, ctrl, pvt))
@@ -1083,6 +1085,20 @@ static int f17_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
 	if (csrow_sec_enabled(2 * dimm + 1, ctrl, pvt))
 		cs_mode |= CS_ODD_SECONDARY;
 
+	/*
+	 * 3 Rank inteleaving support.
+	 * There should be only three bases enabled and their two masks should
+	 * be equal.
+	 */
+	for_each_chip_select(base, ctrl, pvt)
+		count += csrow_enabled(base, ctrl, pvt);
+
+	if (count == 3 &&
+	    pvt->csels[ctrl].csmasks[0] == pvt->csels[ctrl].csmasks[1]) {
+		edac_dbg(1, "3R interleaving in use.\n");
+		cs_mode |= CS_3R_INTERLEAVE;
+	}
+
 	return cs_mode;
 }
 
@@ -1891,10 +1907,14 @@ static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
 	 *
 	 * The MSB is the number of bits in the full mask because BIT[0] is
 	 * always 0.
+	 *
+	 * In the special 3 Rank interleaving case, a single bit is flipped
+	 * without swapping with the most significant bit. This can be handled
+	 * by keeping the MSB where it is and ignoring the single zero bit.
 	 */
 	msb = fls(addr_mask_orig) - 1;
 	weight = hweight_long(addr_mask_orig);
-	num_zero_bits = msb - weight;
+	num_zero_bits = msb - weight - !!(cs_mode & CS_3R_INTERLEAVE);
 
 	/* Take the number of zero bits off from the top of the mask. */
 	addr_mask_deinterleaved = GENMASK_ULL(msb - num_zero_bits, 1);
-- 
2.25.1

