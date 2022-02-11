Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364E64B30BE
	for <lists+linux-edac@lfdr.de>; Fri, 11 Feb 2022 23:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354203AbiBKWfi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Feb 2022 17:35:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354234AbiBKWf1 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 11 Feb 2022 17:35:27 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2652D7B;
        Fri, 11 Feb 2022 14:35:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zcy3KZabVrFN4KnKLvgyaVlfc//90CBKzRfCddv+pFEtvzICuVnPLqWfh5kRLeOFa6bxYg7ClrhMPV0nC0nxy4iM/FQR6ctyY1Q9XT6rhgetxpf/qkLtIfuzh1Y22g0X0gqp8/eEHAg4HdWOCupI/RIEvN5Y+oKOTAkw1K7zABT5q/DhOTPq3gGnJHk5M0nddhG5hQdRC5SBk4gFcuYsWK2MymLZ4OvL4E9JUdpdpwhL2q/G/4al6Fswo/mawmBQzOiCZEI9yO8H2Zi2GFXUWYozi+JaU2xITXcxUAx0XSGOq47gmBr0+8cjIgfmL9zBfe8FxpOvsx16VP8bLAO36g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ViN9B2QZsrd7Hbtz4+Q3gd2c6hkntt0tI470NZce6A=;
 b=I+OhQZ/y3eSqEnOHhrFyr6PpgROmNO/s4rqqc1mS+iAvhT8v/1PCc8s+r30OayHojwPpziKcm4Mh75PjsWwflNPnGYUOXcZlBHYVSos7yFKC2ol1RSouxr7iOB/rLfbIlKZhIwjkURCBII9fuYvfkg3F86M5deKoZSbu201GSSB1yBcdfwqnlrOXttxyGWGZKMfed1jySOnKJNCnBR4LCMntzl0yqdDtlKk64XuYUSc5eJJw2iZCqKnZrCgX3cMVRDS1DEn8XB9ztWgVRQkRQF9iIehDouyb5TyKexbVK++zCAGQaiynlAtDFJvFvUjcRHgGNsgDeWzS1Y9POIxXlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ViN9B2QZsrd7Hbtz4+Q3gd2c6hkntt0tI470NZce6A=;
 b=MYgHs+cAyR/LofQ894gyZCgIfCfT0f/EKQv7KSvfYeHDU3x5zlqm7yl99UMLhUh1NHINo3qF1CUDThD60pGSQfORyE53nDGWEtQP1lREqQTZqgAu6STA+QjO6bbQ5QK4mRhP0Z2bHsvjWXBYgGclXDP2NcdxUyNCHcD9VZ/or3A=
Received: from DM6PR10CA0018.namprd10.prod.outlook.com (2603:10b6:5:60::31) by
 CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.11; Fri, 11 Feb 2022 22:35:18 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60::4) by DM6PR10CA0018.outlook.office365.com
 (2603:10b6:5:60::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12 via Frontend
 Transport; Fri, 11 Feb 2022 22:35:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 22:35:17 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 11 Feb
 2022 16:35:15 -0600
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v3 4/4] x86/mce: Avoid unnecessary padding in struct mce_bank
Date:   Fri, 11 Feb 2022 16:34:42 -0600
Message-ID: <20220211223442.254489-5-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220211223442.254489-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20220211223442.254489-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f100913-e4a5-4dce-7efa-08d9edaec7a3
X-MS-TrafficTypeDiagnostic: CO6PR12MB5473:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB547345268F7794C405CDB0AC90309@CO6PR12MB5473.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eImNijFTLtn83nCLus8mFv/Wtg+Fibh/y+nKrc6tPX09FgmbuO0PKqvSyxXIF9+sX6QXiygPycnVM31KnGzUDatUgJ8q6ZILYh4qd3MLXEc4dlhg0ilC39wtJET46jvRogGlbU9fl4/fY8ozGUk2geMre2XeXWrBABwfrA4TXfxgc/Os8cWjbItbiuAqaKo6gRx1G/JvYQ9J09SFFT7yoUSmjhVCxOE0rkIoZEr4wynrAZ+YsBOKkK1oLIg/R+IqQpsGPApOgycmjO1QldUVQXr6gtlLFyQOlg5MpvHNF/8Wqc+CgBq0b2Pg2Gkk5P9MGuf+pMTokHuw7Fu9ta7QGdo/NB8OEWchqoXLWHrGN+Q3AOCJ6IYG/zC5vQnjjdhYBfy511BftjD2mnrusK0WTCT2w40p5kg6mQ6EEjwTGypWdvTMtvpBPHeTPAUpF5wuk4xM5Ym4TyqYQfa+rJQZrZVT7wpnn2A2V61XyPLcH6Y3H041DaOeNSACqA0ar/AlWlf5JSs2Vd1n8YJ2rjG0tD90zYBBaz6R1O+eY7edRLo+AGHq+2An36zRy0hRrz+etlkSmZZxEsjYUpkaQcz3Y/PopAhUVt1Wbt4UpFTI4r7/t/uNcYbYZAJR946X/CYjonbMMRjSVUxBmglzRSlm2CLLCcLHxHtOG/jSCIku9C06uJZMwkP+2XY7S2YQ21tTnXIikZJHxd7Ee1iiAXm9UA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(316002)(81166007)(8676002)(186003)(54906003)(26005)(16526019)(110136005)(8936002)(70206006)(82310400004)(5660300002)(2906002)(356005)(4326008)(70586007)(86362001)(47076005)(508600001)(40460700003)(36756003)(83380400001)(1076003)(426003)(336012)(7696005)(6666004)(2616005)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 22:35:17.8015
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f100913-e4a5-4dce-7efa-08d9edaec7a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5473
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Include struct mce_bank member "init" in the bitfield by changing its type
from bool to get rid of unnecessary padding and to reduce the overall
struct size.

Outputs collected before and after the change.

$ pahole -C mce_bank arch/x86/kernel/cpu/mce/core.o

before:

	/* size: 24, cachelines: 1, members: 5 */
	/* bit holes: 1, sum bit holes: 62 bits */
	/* bit_padding: 2 bits */
	/* last cacheline: 24 bytes */

after:

	/* size: 16, cachelines: 1, members: 5 */
	/* last cacheline: 16 bytes */

No functional changes.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/internal.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 422387f8699d..0b0f55f0c585 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -177,13 +177,14 @@ extern struct mce_vendor_flags mce_flags;
 
 struct mce_bank {
 	u64			ctl;			/* subevents to enable */
-	bool			init;			/* initialise bank? */
+
+	__u64 init			: 1,		/* initialise bank? */
 
 	/*
 	 * (AMD) MCA_CONFIG[McaLsbInStatusSupported]: This bit indicates
 	 * the LSB field is found in MCA_STATUS, when set.
 	 */
-	__u64 lsb_in_status		: 1,
+	      lsb_in_status		: 1,
 
 	/*
 	 * (AMD) MCA_CONFIG[McaX]: This bit when set indicates a given
@@ -195,7 +196,7 @@ struct mce_bank {
 	 */
 	      mcax			: 1,
 
-	      __reserved_1		: 62;
+	      __reserved_1		: 61;
 };
 
 DECLARE_PER_CPU_READ_MOSTLY(struct mce_bank[MAX_NR_BANKS], mce_banks_array);
-- 
2.17.1

