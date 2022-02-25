Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C764C4EDE
	for <lists+linux-edac@lfdr.de>; Fri, 25 Feb 2022 20:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235013AbiBYTef (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 25 Feb 2022 14:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbiBYTee (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 25 Feb 2022 14:34:34 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2861AAFEE;
        Fri, 25 Feb 2022 11:34:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/w5SZCq8a2sDj6/yL+y4lH0tQr7E3BOvVKFKN+fn9oiRAr7MphHvMzxax2ixphzvfM09HT57WpXiihFoDYFx181Qp6WlR6b/o78j0+zJ6BmIdeD0ZSu91XTtpGnhkZVViYkE7W8dDJlt0ntIgN/4V2T+jio4aQoIwnnIdgTZHuzE9h+JO8mVanRa4rCgojy0KacPaw5SCwpcdCekyFfh57C67VUKFZsGrMA11X5UTX5H1P0hhPJyutYVvpl+HnBEkBSe5jMfQFR6Z0swK1AQeciB/bzmJNGhAZFWPuaIQCusYJ/4i8IaDLfrHRa3jUsCDno1clePLMTvgf50n29kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpplOZOinUZiVjzUtMlYZm4gl8NZcWb/7iBpF+NKq8w=;
 b=I3BGN/YtFQ49nkBBxXzsXDPu1xAUCa8ltI218P+APRjGE02ONEP6HvJ8MtvQgghpuFv0fwciBi9Kqx1snPAH4/jBX4imcdJe/MIpXAs40zIy74i509F9DshwBE9tjGKMQsav9MP/tUMXSf7DP/ukK7j2PEJ7IHXnaDSMRgd7i+3GQq2AVhgrULH1+Q2fwYmMbrmp0iXaXOde6UbwIRBz58nvjXILCadEBxI2kDb3dqAagroYyoRG6ITQ5FgEq365gALrHt7m41YfrxsLb8s5QQdkzCGOFXN7sVUM9aUkXOA+EZZ3D4OU9l3GYm/FijOuTcGEMYcNv+OVlYcriIdXrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpplOZOinUZiVjzUtMlYZm4gl8NZcWb/7iBpF+NKq8w=;
 b=U+4ztKJgArCOaePYVaMUVZbBGe1Febgp6SqzjQ2wcmGCqpTUOXF4GgUurQDRsAbk+AVfL2fqd2TCIosDGxk+yDi7WjplRODseOusWWCUIPo0vHf9/T578PnvMgCsWvE8Imvf95wz9GsZYjK2zXaUM/59i4z3o86g8i4SdjyEF3E=
Received: from MWHPR13CA0028.namprd13.prod.outlook.com (2603:10b6:300:95::14)
 by BYAPR12MB3112.namprd12.prod.outlook.com (2603:10b6:a03:ae::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Fri, 25 Feb
 2022 19:34:00 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:95:cafe::93) by MWHPR13CA0028.outlook.office365.com
 (2603:10b6:300:95::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.9 via Frontend
 Transport; Fri, 25 Feb 2022 19:34:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Fri, 25 Feb 2022 19:33:59 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 25 Feb
 2022 13:33:57 -0600
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Tony Luck <tony.luck@intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v4 1/3] x86/mce: Avoid unnecessary padding in struct mce_bank
Date:   Fri, 25 Feb 2022 13:33:40 -0600
Message-ID: <20220225193342.215780-2-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220225193342.215780-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20220225193342.215780-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39cd18af-4f65-4c3f-e307-08d9f895c595
X-MS-TrafficTypeDiagnostic: BYAPR12MB3112:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3112FFC0FF10562D7B347099903E9@BYAPR12MB3112.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qQTsDZmLowhe2ZaSMalU9kyNB1fB7Uav/I3K5D9PpGjks5Y39kGo7XIpHT0eahROWpc94xFOnRSryVjsFe3ss/X6UOs9RCLkYd7qDxTVptw1KMR2naJJMgu3EbYmYHjTNxrCKnndsUyVF3XXdf2CCEJs12RGk8nQrv68LR98aqAnAbC7U1VqvTOt13MqqnCHFzDoP568Eh+Z7l6WLluEVVbxLRhn6534H6T11pRKJUDeAkkbovf3K+7UaFye8acuR0xkbF3TLdfw78/2ywIQB6tdaaF/AAULWzCFxI/UdsiqEVHjRgoQB5VdV935k1U0r62GzhTmqRySvXlqSqJbv36IxbexPkhtUzr/AEXjbRp4zb3oBAD3GNUDnWOj4FEYutHm6dOB/q+YPA4HYMnQQS2MzFIiXoQDbuISxozsreOEzvif+39QA2SH3qSOXftBX6jSch6Iy+bU+IZRrNO0bN/OKJ6x5tgTAOQFS5gsDL341RYfzbnD4H6BASL+7zwgKq9zhe+G+dNbLyMpJmRqDVwXcEAPjEfrZuKbgVGjXP7Me1fo8qqytgSaHcsYIAxfqzakFhAPkQ7UlnRkr2Lpp6+ki+R5uIgxAP9pquI+OraJogS9UxS+kUfR/VX78TuWr/cxM1u0VtsWcW8q52uERgUW92yXzWhsN9rzeG0vssr2OkKDYRu1lKkswnLpY+lqwJF4+/gXj8euobAFHQAerexAk9RP7keP+wq45TVmS92vox54twK0DWbL7g4ZgYF3WRXEgO4G00qoVYJJ2KtvDvL/mpRBCRg3VeMrK9Rlto0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2616005)(4326008)(336012)(16526019)(8676002)(83380400001)(6666004)(86362001)(7696005)(426003)(508600001)(70586007)(110136005)(1076003)(356005)(186003)(54906003)(316002)(82310400004)(70206006)(81166007)(966005)(26005)(2906002)(36756003)(40460700003)(47076005)(5660300002)(8936002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 19:33:59.6511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39cd18af-4f65-4c3f-e307-08d9f895c595
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3112
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Convert struct mce_bank member "init" from bool to a bitfield to get rid
of unnecessary padding.

Outputs collected before and after the change.

$ pahole -C mce_bank arch/x86/kernel/cpu/mce/core.o

before:

	/* size: 16, cachelines: 1, members: 2 */
	/* padding: 7 */
	/* last cacheline: 16 bytes */

after:

	/* size: 16, cachelines: 1, members: 3 */
	/* last cacheline: 16 bytes */

No functional changes.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
Link:
https://lkml.kernel.org/r/20220211223442.254489-5-Smita.KoralahalliChannabasappa@amd.com

v4:
	Moved this patch to the first in the series.
---
 arch/x86/kernel/cpu/mce/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 728f3b36ce2d..c0e9aa9c8749 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -69,7 +69,9 @@ DEFINE_PER_CPU_READ_MOSTLY(unsigned int, mce_num_banks);
 
 struct mce_bank {
 	u64			ctl;			/* subevents to enable */
-	bool			init;			/* initialise bank? */
+
+	__u64 init			: 1,		/* initialise bank? */
+	      __reserved_1		: 63;
 };
 static DEFINE_PER_CPU_READ_MOSTLY(struct mce_bank[MAX_NR_BANKS], mce_banks_array);
 
-- 
2.17.1

