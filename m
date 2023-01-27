Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1AE67E935
	for <lists+linux-edac@lfdr.de>; Fri, 27 Jan 2023 16:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbjA0PQf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 27 Jan 2023 10:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbjA0PQc (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 27 Jan 2023 10:16:32 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A284C177;
        Fri, 27 Jan 2023 07:16:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acmWwh5IwbSMFUKNycEFgqw/JxlS33zXCbacmbjMofmcb18/xxLB+IUm55udWFICOsCmdikOr51l9Vf5dZ/b7JPCrFid5g6pS6TJsI8sjEoKfcs8ffNDTGrJcP7Vlugzv33ikr3mfM2ZpdBsc3+ctQ3LAkvuznK6DVl6AIALGIhCWpVvbAa0zvrO9WFINS0CHYn41N9wGNB+OHi3FNNdMj9dPWSE0JqcvRal7gsyLJvNykkEs8uDTjiGEiuDrGwmcsehffQHyi/+NtLFIbW8Tw6TnXi7HHewzofJUvqDTCW+TV9FhGJ1rv3Vbl2lBAQ8ZL4bhSx52bIW92CfMV+tIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9EKz+/ckiTPPf091LpfCM2WOIxk+PGnUNN8Vf61zSi0=;
 b=nymW0xHHsCIQDZOhiW5tvrPdaOWGQFlizJ2li9+nncOCtxzqaTRx1nM+g8/I36y1ILbfodQhDYrAYPb+Ccta6jq6kCuuLLSXnIdkNBxiw1bDOPo6NjqoJwL827Izr2t4erfKaRdyIcPv66HHU4uXneMkz9KDrwGYwpd8nIRLe9aDzxveLn5NDWYKYeAmBq+/Nw9zE+qrw08G3Y6emG+znk6MuNpHpWvO5B39029qayIKFbQgm5vQAt7QgrIwiLSARxiHdGqec65YQnxmNOFu3m0qBMpcIqoz2U6sFlFhPUzwbMgwA7EGmcKqI7hVsWU7VQVnBZXpbKh3nEoSvZ4VMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9EKz+/ckiTPPf091LpfCM2WOIxk+PGnUNN8Vf61zSi0=;
 b=gC2Dt0itC/3nMqQjkp0lRUyiD6c0a29/Rdr4KLe2bPemjf3q4zJjSydPdtVVpGMo3D+TdkCOjQWsLCA9as9/VIR04yOfq5NUo27KWPNxqhdRAiEbWOcLtVEsBtm0laZi09JIq5tMe0fJwIiMPfYaayuHI2S5RTbWNhxqNsiKPWs=
Received: from CY5PR15CA0118.namprd15.prod.outlook.com (2603:10b6:930:68::7)
 by IA1PR12MB8264.namprd12.prod.outlook.com (2603:10b6:208:3f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.23; Fri, 27 Jan
 2023 15:16:26 +0000
Received: from CY4PEPF0000B8E9.namprd05.prod.outlook.com
 (2603:10b6:930:68:cafe::4c) by CY5PR15CA0118.outlook.office365.com
 (2603:10b6:930:68::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.25 via Frontend
 Transport; Fri, 27 Jan 2023 15:16:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8E9.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.7 via Frontend Transport; Fri, 27 Jan 2023 15:16:25 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Jan
 2023 09:16:20 -0600
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <yazen.ghannam@amd.com>, <nchatrad@amd.com>,
        Muralidhara M K <muralimk@amd.com>
Subject: [PATCH] x86/MCE/AMD: avoid shift-out-of-bounds when decoding bank
Date:   Fri, 27 Jan 2023 15:16:01 +0000
Message-ID: <20230127151601.1068324-1-muralimk@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8E9:EE_|IA1PR12MB8264:EE_
X-MS-Office365-Filtering-Correlation-Id: ef174638-b198-4177-c6fc-08db007974fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JPSZ5rk+2YUvFiusg09cua/A0GQC3isi3pVPI7JT776iCMLBsTMVj3wuUAOoLNbD1rRxaHfnOU2THqFfv4s+EFQia60BiMgqra39Zy7gCsBlxxvygyxFzE76f/kHRT/aiFBFc9rs572s1MDdtQQ6i70gNTVgrgTX8od6TdU1PGEc1pRgcvN4q1BkRZuDMg/Lioe8rKV0Bw4TMPpto6xmyWP0JNx6vxP1z/41HGlYImFPp2N7N93KjVZIRJb2G1ZdkElP8kUjcMWjgyBI5EnE+zp+5/nTvGTN39xHfXqz4atB0h+8oZOM8zB89rsHrsmpQ4w10GDLPVrD53BF+bsTiKBiDzY7ZSWxgI5YLnNmLWW7caguY5pMJZnANk+FFEzsQcdjLYIqZeB62IsPPtwUhYE0GQt1TU94XSha6mwprFEaMW5LrUlup67b0TLulGSdXN0oS1G4hGGFhvJgk8c1IUFcdqQnubDbRHfMefL3p8dJbegh4kAORnMj363wu3IjjhG0pfbtOY0WILPJWL6QB8SGhr0zIBpZalCKFOzbLWoMRwOtSYYNZTnpv6lOKh/ynDu9Pjbceovq8dFvg68sUoRQ/XPzrG0/akO7IJ3azOLjjvPoEFZlZqIxjfVJjJZO1h1jAsDgBED3HmAQCz8FfVjVU+2umrxtOmxAbPbW919hL+x+PDBODgIwixI9qaA7C8++hu0SHO9OGFUMUEdT1TJ76KSFO91+fbfvIVOh29c=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199018)(40470700004)(46966006)(36840700001)(41300700001)(478600001)(6666004)(83380400001)(40460700003)(36756003)(40480700001)(7696005)(2616005)(82310400005)(47076005)(336012)(426003)(1076003)(186003)(26005)(16526019)(70586007)(8676002)(4326008)(70206006)(54906003)(110136005)(36860700001)(82740400003)(316002)(2906002)(356005)(15650500001)(8936002)(81166007)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 15:16:25.5794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef174638-b198-4177-c6fc-08db007974fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8264
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Fix dump stack due to shift-out-of-bounds in
arch/x86/kernel/cpu/mce/amd.c when UBSAN configs are enabled.

Maximum number of MCA banks is 64 (MAX_NR_BANKS) from commit
a0bc32b3cacf ("x86/mce: Increase maximum number of banks to 64").

But the driver uses 32 bit variable(bank_map and smca_misc_banks_map)
to manage the list of banks which causes out-of-bounds warnings.

So, fix would be to change the data types of bank_map and
smca_misc_banks_map in addition to switch the bit mask assignment to
use BIT_ULL() for 64-bit type.

Signed-off-by: Muralidhara M K <muralimk@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 10fb5b5c9efa..5518272061bf 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -235,10 +235,10 @@ static DEFINE_PER_CPU(struct threshold_bank **, threshold_banks);
  * A list of the banks enabled on each logical CPU. Controls which respective
  * descriptors to initialize later in mce_threshold_create_device().
  */
-static DEFINE_PER_CPU(unsigned int, bank_map);
+static DEFINE_PER_CPU(u64, bank_map);
 
 /* Map of banks that have more than MCA_MISC0 available. */
-static DEFINE_PER_CPU(u32, smca_misc_banks_map);
+static DEFINE_PER_CPU(u64, smca_misc_banks_map);
 
 static void amd_threshold_interrupt(void);
 static void amd_deferred_error_interrupt(void);
@@ -267,7 +267,7 @@ static void smca_set_misc_banks_map(unsigned int bank, unsigned int cpu)
 		return;
 
 	if (low & MASK_BLKPTR_LO)
-		per_cpu(smca_misc_banks_map, cpu) |= BIT(bank);
+		per_cpu(smca_misc_banks_map, cpu) |= BIT_ULL(bank);
 
 }
 
@@ -528,7 +528,7 @@ static u32 smca_get_block_address(unsigned int bank, unsigned int block,
 	if (!block)
 		return MSR_AMD64_SMCA_MCx_MISC(bank);
 
-	if (!(per_cpu(smca_misc_banks_map, cpu) & BIT(bank)))
+	if (!(per_cpu(smca_misc_banks_map, cpu) & BIT_ULL(bank)))
 		return 0;
 
 	return MSR_AMD64_SMCA_MCx_MISCy(bank, block - 1);
@@ -572,7 +572,7 @@ prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
 	int new;
 
 	if (!block)
-		per_cpu(bank_map, cpu) |= (1 << bank);
+		per_cpu(bank_map, cpu) |= BIT_ULL(bank);
 
 	memset(&b, 0, sizeof(b));
 	b.cpu			= cpu;
@@ -884,7 +884,7 @@ static void amd_threshold_interrupt(void)
 		return;
 
 	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
-		if (!(per_cpu(bank_map, cpu) & (1 << bank)))
+		if (!(per_cpu(bank_map, cpu) & BIT_ULL(bank)))
 			continue;
 
 		first_block = bp[bank]->blocks;
@@ -1362,7 +1362,7 @@ int mce_threshold_create_device(unsigned int cpu)
 		return -ENOMEM;
 
 	for (bank = 0; bank < numbanks; ++bank) {
-		if (!(this_cpu_read(bank_map) & (1 << bank)))
+		if (!(this_cpu_read(bank_map) & BIT_ULL(bank)))
 			continue;
 		err = threshold_create_bank(bp, cpu, bank);
 		if (err) {
-- 
2.25.1

