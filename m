Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9625A4E6359
	for <lists+linux-edac@lfdr.de>; Thu, 24 Mar 2022 13:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350165AbiCXM33 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 24 Mar 2022 08:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350145AbiCXM33 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 24 Mar 2022 08:29:29 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B15A66CB;
        Thu, 24 Mar 2022 05:27:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SodcfGB6A/6wDzphc4tgMOL8LloVazuepN0w9qsNlhA1KpiZLKSggQ8RqoaAAh6s/dXR3maYELzkQE+MTurTRKlDSw/oDNN+7GK2h11scZhlilBq6DSnzEqZo9fqauOE3TAADC76ZFuenrTMA3DWfKLrAiwtq4CyGmoVvwZx30qAMoLb/Nq4U5Il/dOlOWXg9GB4zZ2ka51qkNYCe87aZFIUcZM0F+bmAAsMp1DGsFaoWODtWQUOXfGWxYPeQjfJmswtY9JYkzbbv4vq+vw0HdfKsaNqVm3+6kxWeTJ0XFSpkGh29VDRQXTZfTkJ4617gonmVIfaR4fJ3p96sfnAkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MxPvW2WQ+FoquviUg/Z8nbcoTot0BT+PekEPVetpEKY=;
 b=EhzfWNuk+rUe5DruSAnzaSIKiPqSIfqXh9Hlde9NRwnkcv1c+dosm4YW/IcVLGrHloRQy1kXagTpY2BMqFvydsDZ9iMBfGADbla+DTEADcW2SrRJ97o1U1k65EjcuKIpWW/IN7WpynvikHjmDXYgkievlUR4hv0Sds56D+onOrnHIsG8fb9RG/HTzNkbkZlAAsTHmRsD2fzuUqTXM53fRISM5ukPHKJnwP3DpsHxss0DaizpQPLOK9AfRmO0b8lMC2sxEkXUBamYucZe61vc8RrK5OTcUhNWZhZACE3VBlBJvFD+BTcPdxmFmNb5jzbaw4IYnppXcjNeejcp3smhPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxPvW2WQ+FoquviUg/Z8nbcoTot0BT+PekEPVetpEKY=;
 b=iAFhkUiQdO72synitM6T/z+PcjZB2rEU0OUtF0GDo/MxsOtbR8WOBygaNJ2udi+CmCqPwrdvaB/69NnnrEEqL+KnpaVCbRXdRocOYbPnuTewkNXKZhN/xMAXn3/cYldX72a2jf2B69vCeXfBTcQ4Eg71FGQBPm6SXS5aZkJ/CFM=
Received: from MW4P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::32)
 by MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Thu, 24 Mar
 2022 12:27:54 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::d4) by MW4P220CA0027.outlook.office365.com
 (2603:10b6:303:115::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16 via Frontend
 Transport; Thu, 24 Mar 2022 12:27:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Thu, 24 Mar 2022 12:27:53 +0000
Received: from milan-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 24 Mar
 2022 07:27:50 -0500
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
        Muralidhara M K <muralimk@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>,
        David Airlie <airlied@linux.ie>
Subject: [PATCH v2] x86/amd_nb: unexport amd_cache_northbridges()
Date:   Thu, 24 Mar 2022 17:57:29 +0530
Message-ID: <20220324122729.221765-1-nchatrad@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ca447b9-e854-4243-ec15-08da0d91b83c
X-MS-TrafficTypeDiagnostic: MW3PR12MB4379:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB4379DE5958F013D4EE04A9BEE8199@MW3PR12MB4379.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E8WPrz+RJZy5a1JsFv0aiUD+Od1dTozGOzkp8hrRL8kiu2halaB3T7N1zarRTYzIOX9ndUW0edgqKVLHNuq22g6b9BCt+xQ9EGvYQFg1r9MzH2o83pepGdhhF0gfKNIz6EkM/9btfj4KAqFilo3E9hwBGHM28RJlBZ8qHL1jeyqvlVaMbgvmfX5RGQUlFl0HpJxsmVNzkQS9XY+Rqdfpj1WSqd7e4mW8c7DBZHKBMVslMg24DLaEJ4JQTHV2kmW+xAd51E4rFoWWZTE8OEGIo3TTpdLIoNlTlxRDV0MMxtLoAZVMKc48WLGHA0B1Bt+PtCpLhzciAbwfKqEZC3FynoniX1cx/TXyHGn7pU1aLIKxzwupWeRnfCDP7mkbQTWhwODrzIH+r/Q0524Fg1JjI2s/fiJGjloFJsGOTSyJqiPgkwDfzbzmcCiBal7jxDMsM7brJ1RlGtG9xd1jUimC56de9Gq4qsOuUmKATMiIJZS7UpOfzFrTHz/EAURsXlBZpUlNgtTIj5xO3gmPVgSidwl/fxQG94ols7F1vALrxQWksq7W6CUKbCfv55hv451hnEmr0G4DDlEyqh5i5Wy8qE4ATN4/0aKhdYAMg93I9gsFRxwazps45Wt+8zw2MllzMmOjzBCFKAh5pccX4T3zsqpjmE5TYZnKV5ksmLHmiXXeiBNFEkxQEIExt0CUQAW2B4ep5Er+iQFPr2A5u4T9iA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36860700001)(356005)(81166007)(5660300002)(2906002)(82310400004)(8936002)(36756003)(16526019)(54906003)(186003)(26005)(2616005)(110136005)(1076003)(508600001)(7696005)(6666004)(40460700003)(4326008)(70206006)(83380400001)(70586007)(316002)(336012)(426003)(8676002)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 12:27:53.6890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca447b9-e854-4243-ec15-08da0d91b83c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4379
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralimk@amd.com>

amd_cache_northbridges() is exported by amd_nb.c and is used by
amd64-agp.c and amd64_edac.c modules.

init_amd_nbs() already calls amd_cache_northbridges() unconditionally,
during fs_initcall() phase, which happens before the device_initcall().

Hence, dependent modules can safely call amd_nb_num() for number of
initialized north bridges.

Unexport amd_cache_northbridges(), update dependent modules to
call amd_nb_num() instead. While at it, simplify the while checks
in amd_cache_northbridges().

Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc: David Airlie <airlied@linux.ie>
---
Changes since v1:
Modified the commit message.

 arch/x86/include/asm/amd_nb.h | 1 -
 arch/x86/kernel/amd_nb.c      | 7 +++----
 drivers/char/agp/amd64-agp.c  | 2 +-
 drivers/edac/amd64_edac.c     | 2 +-
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index 00d1a400b7a1..ed0eaf65c437 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -16,7 +16,6 @@ extern const struct amd_nb_bus_dev_range amd_nb_bus_dev_ranges[];
 
 extern bool early_is_amd_nb(u32 value);
 extern struct resource *amd_get_mmconfig_range(struct resource *res);
-extern int amd_cache_northbridges(void);
 extern void amd_flush_garts(void);
 extern int amd_numa_init(void);
 extern int amd_get_subcaches(int);
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 020c906f7934..190e0f763375 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -188,7 +188,7 @@ int amd_smn_write(u16 node, u32 address, u32 value)
 EXPORT_SYMBOL_GPL(amd_smn_write);
 
 
-int amd_cache_northbridges(void)
+static int amd_cache_northbridges(void)
 {
 	const struct pci_device_id *misc_ids = amd_nb_misc_ids;
 	const struct pci_device_id *link_ids = amd_nb_link_ids;
@@ -210,14 +210,14 @@ int amd_cache_northbridges(void)
 	}
 
 	misc = NULL;
-	while ((misc = next_northbridge(misc, misc_ids)) != NULL)
+	while ((misc = next_northbridge(misc, misc_ids)))
 		misc_count++;
 
 	if (!misc_count)
 		return -ENODEV;
 
 	root = NULL;
-	while ((root = next_northbridge(root, root_ids)) != NULL)
+	while ((root = next_northbridge(root, root_ids)))
 		root_count++;
 
 	if (root_count) {
@@ -290,7 +290,6 @@ int amd_cache_northbridges(void)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(amd_cache_northbridges);
 
 /*
  * Ignores subdevice/subvendor but as far as I can figure out
diff --git a/drivers/char/agp/amd64-agp.c b/drivers/char/agp/amd64-agp.c
index dc78a4fb879e..84a4aa9312cf 100644
--- a/drivers/char/agp/amd64-agp.c
+++ b/drivers/char/agp/amd64-agp.c
@@ -327,7 +327,7 @@ static int cache_nbs(struct pci_dev *pdev, u32 cap_ptr)
 {
 	int i;
 
-	if (amd_cache_northbridges() < 0)
+	if (!amd_nb_num())
 		return -ENODEV;
 
 	if (!amd_nb_has_feature(AMD_NB_GART))
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index fba609ada0e6..af2c578f8ab3 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -4269,7 +4269,7 @@ static int __init amd64_edac_init(void)
 	if (!x86_match_cpu(amd64_cpuids))
 		return -ENODEV;
 
-	if (amd_cache_northbridges() < 0)
+	if (!amd_nb_num())
 		return -ENODEV;
 
 	opstate_init();
-- 
2.17.1

