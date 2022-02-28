Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607684C7168
	for <lists+linux-edac@lfdr.de>; Mon, 28 Feb 2022 17:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237837AbiB1QM5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Feb 2022 11:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237829AbiB1QM4 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 28 Feb 2022 11:12:56 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28D185661;
        Mon, 28 Feb 2022 08:12:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHZFMOFgrV/rSEJc9zqxSvRChIYeUfj7GbQZCWiIZMh22ZpnfpD+D2u8Cr4ZM+VHXw8Kb3Yc2q75CBhb+Jbjoj/YcKfFCuFlzOlhVyiG56M4jK8vbyHkp7j7HBaw4kitOieILeKYbyOf3en8DuMKiKKn2CXIdBJuXBAP+1O5cHRMjPZqiJTKwG108+iKapOGY0xhMsNR/MobY4Aj81HgXidmaMpf82WpI+eAjJDzc2EJ8nPEGgw2Vo7j8f7aykd8KpylMyIPdWjkNUFxEYOWgnAExuJtdb3HMIrKRftfOHpyLC1FFX1w3ATFU0d7oVQ+XmUiJY0/9I+H/hNvwmMDyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++on12dq13GgFFvnEU3hWWVBzDygCW859dcTbFuQyAk=;
 b=Sf++8HZVUP+RqscM7LuzsxAdf2D3SWkNMidUJ+bWW1fyEgy4tDsLe3c9VqoX2kyXe3NasNzliJHf159Q7NAmRROkUI/8e8anK0mDxvgj0qVfLz5OWnHn9DOqbl8R94EZOAUIWKPUPI0ZxseVzrX2aVJBZ9zOj/g8nyK6qucgCRLGt/1Me11r8Dl8zp+fm+YxPR0i30NqYXRobcRrvGN6nlfN0DFUyEHkf4m9PaboA6w5N3gKfTbCJJiQKbwvz9xmFRgB1jxM0ApDRlJkCCI/89rTtWnOh04gidDAbRITc8apG4BTYxNFOtBskpHvaovnQhYfzjTbAtu5xWbZ7SWPBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++on12dq13GgFFvnEU3hWWVBzDygCW859dcTbFuQyAk=;
 b=wb1AJ5C2pLmKFNzR/geFSJ4Us/NmRXOGqJ6GtUycz10sRRCeChLfyNlswNx2BWLJU+S0oKzrWKw3Ewv06ihUDyX+LySbP8ohSdl2nqcarhRuEfqnwUjME7cGGrqCLtEXGNPw7u/34S7RzkFicXDwvEeK8CnGEj4v3sgxYXVc90g=
Received: from BN0PR10CA0009.namprd10.prod.outlook.com (2603:10b6:408:143::6)
 by CY4PR12MB1926.namprd12.prod.outlook.com (2603:10b6:903:11b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Mon, 28 Feb
 2022 16:12:13 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::f9) by BN0PR10CA0009.outlook.office365.com
 (2603:10b6:408:143::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Mon, 28 Feb 2022 16:12:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Mon, 28 Feb 2022 16:12:13 +0000
Received: from milan-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 28 Feb
 2022 10:12:09 -0600
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-edac@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <airlied@linux.ie>,
        Muralidhara M K <muralimk@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>
Subject: [PATCH 1/1] x86/amd_nb: unexport amd_cache_northbridges()
Date:   Mon, 28 Feb 2022 21:41:54 +0530
Message-ID: <20220228161154.54539-1-nchatrad@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09b5e156-ed12-4d26-a9ee-08d9fad514aa
X-MS-TrafficTypeDiagnostic: CY4PR12MB1926:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB19269726C249B90C7DDBD2FAE8019@CY4PR12MB1926.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a9ZWBBpXMmZK9yjTxwr5fjhRke5xCMJZM0BNFIRskJj7mGNh8cLr4okB49zvlo3diykoALjwfpi+f7qM6EeE1bfcKbgYRHiD8HW5lNt0ypQi+cK4sGYzZPqkRlp0phv5N8ryNFDNCL74MHLZQrBgxnn025Wb4nHiJ8lavdzd4rvl4m5qOU7eyRVo7svmf6LLcrRjdWtHG3ZtoqEAZrbmjVPtVLAMgNutXfJds96CGMgSKkl59O3h7D9AQp3I/UhNFspLkHsKZ9n340SKSm2OoFFFuAtD5aDx+U5sYBDkGKbAFFFYFzhh02h2ujIRnqG/tYFNF0lZaJxVtduPbB8wJHAHDxWwxXf4ma4z7HCWDE3ydcBMYqyCINZqlMHRZ5fLJUk95iVmsBL/EaYnwcCJCz2VbjfQ3g1lLRezbJV6qXnhBVnIWqM3fO37YfeBlcCiCKaHlJzopbB93qaszZXHI6NvUlzxT4Igm/y1fUsVqBSM5FL3UoNFw+UpdXbozr2q6E59b1VADhgC6S6VMPTEarId9nqZufdJmz3zX3PWtimejGi/GKGoZ3mZvLi0kwGYWmNCASf6jEALpkBPeU2TP7T7mvQVZkYuVrbGl15O6uomHk+HrT+HrrX9xNvSQRmoPsNb0b6ZCbwBB7QyLu3RMJUN60M+Ed/+ynSKIszCcafGnQpwfmepwTxq1Ami/qsPJU6oZP6DGm+kbCcrtIpXMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(82310400004)(8676002)(4326008)(70206006)(7696005)(316002)(356005)(70586007)(83380400001)(6666004)(26005)(186003)(81166007)(54906003)(110136005)(426003)(508600001)(336012)(36860700001)(2906002)(1076003)(40460700003)(16526019)(2616005)(5660300002)(36756003)(47076005)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 16:12:13.0717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b5e156-ed12-4d26-a9ee-08d9fad514aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1926
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

amd_cache_northbridges() is called from init_amd_nbs(), during
fs_initcall() and need not be called explicitly. Kernel components
can directly call amd_nb_num() to get the initialized number of
north bridges.

unexport amd_cache_northbridges(), update dependent modules to
call amd_nb_num() instead. While at it, simplify the while checks
in amd_cache_northbridges().

Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc: David Airlie <airlied@linux.ie>
---
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
2.25.1

