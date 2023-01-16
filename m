Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCF566CF5E
	for <lists+linux-edac@lfdr.de>; Mon, 16 Jan 2023 20:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbjAPTL3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 16 Jan 2023 14:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbjAPTLY (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 16 Jan 2023 14:11:24 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0287E1CAC2;
        Mon, 16 Jan 2023 11:11:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hX9NSOeNPSsQLnookRJrj4Zdr3+LqlvRNXCCfEUO4VnKZEO5GtAh+1QEoY+GvE7hETIWf4pEEM5lpnMErXv9wYDPLEJpGRP2KAcibDVDIvU4GZn8yoHgvZwb7ZOvwzHFW9yc+J6jeW8ZeazpSeqHmS6wS5aTqljpKz/T2Sb9B3Fu7x5PYTSjrkPJzJGcNXff8RU3g0dIsko33RrLi5bHsNBpXUsY++bTpU18+ZCKfvm0ipfZ/pMFyNU2rmeLJnJRueJQCts1D7y4evQ+1E3oi/AQSgmWYgF/N99lq6AArx+czA7Cbh/SgBYogVggtA+JtL/uOEEBisCuPZoLezTBTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Icv+0UWzPk1NtrCsyOwSlM+I2N7pyx/9kkzqrUot3o=;
 b=Tk2LkZ6/f3vxrpj+m3PBlmwraR+6It6dTWIrtSmNRtVRZk+Gr/7NHzQh5hrovTmDETn+lszwayW4H0wnm+OvAUsSc6MSvEJaD8u6YCHUbIPr2boiYhZTJBMKHvnaDfoo/aPIzHGuhsN9buO/ZKATP4g6laLHLZmiz7/3NvJToqLnB9XJBbTW8K6Vlzv3TMAK2w3zja6frdh/iKM3rm3O1Vt5Vuai8jgqezchUEMNxtyVyyOKqL0MNriAcntth+6O/Y6L/oBwmK/w+gk0rAZHj5kxK4spN03Jr2BuYhskqvoxBado1KgGhvAQc1TuVermsxNyke8ikODhGKBvv2FmLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Icv+0UWzPk1NtrCsyOwSlM+I2N7pyx/9kkzqrUot3o=;
 b=StLSUvZAO/n+rupXzpv8WkALafOvI0gSJ5+Qk2UufFRI6ciNqRVCOb/IIrTHX2bhEcT0L949m96BYpHGnY0Fyz+xpcfE0aesiAo/0mEBZFz4/4yVom4qdrFrlNx7t2NJ6Fzj6mSxk+9hRjtvGxoV/+llzuRz5U6xd1yNcAPHyx4=
Received: from MW4PR04CA0124.namprd04.prod.outlook.com (2603:10b6:303:84::9)
 by DS7PR12MB6096.namprd12.prod.outlook.com (2603:10b6:8:9b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.23; Mon, 16 Jan 2023 19:11:21 +0000
Received: from CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::3d) by MW4PR04CA0124.outlook.office365.com
 (2603:10b6:303:84::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Mon, 16 Jan 2023 19:11:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT070.mail.protection.outlook.com (10.13.175.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Mon, 16 Jan 2023 19:11:20 +0000
Received: from onyx-7400host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 16 Jan
 2023 13:11:19 -0600
From:   Avadhut Naik <avadnaik@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <tony.luck@intel.com>, <yazen.ghannam@amd.com>, <avadnaik@amd.com>
Subject: [PATCH v1 1/3] EDAC/mce_amd: Update SMCA bank error descriptions
Date:   Mon, 16 Jan 2023 19:11:00 +0000
Message-ID: <20230116191102.4226-2-avadnaik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230116191102.4226-1-avadnaik@amd.com>
References: <20230116191102.4226-1-avadnaik@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT070:EE_|DS7PR12MB6096:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c6a856a-789c-4649-221c-08daf7f573ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uj0EkGVj5Dr/lSsyQnjTGQt49MZbqZFPiNVlNFba40P6HIW0emovREIFW/eCxFAOLewfz0fIDtKya6RGFZFw4aiMpMlSWkFILTm3XNtbp0+EYLmsKCcd2/ck3e/w4wOQy9gsywwYXpL5ZP+yID57cNL1i+vv0ji+pl4BUBqaUhjqh9y30PkBtYH7NRvz+U2BWAfJqlAbbyp3al0s3lHa4Dz5I8k7DSo+wTOFK+0/AremHMA4P1ZSHzoeh+y2HxHOb+BQLxcxzFUWpB8SpUq3XVY7z9oqqxNk8tIOZSOY9LQ2dgHFhw7umQrLuWhAesSHuAbdWIxfDeSm+RKVRQo2sqfcszLrAynRUfnG1Nr8KwcrZImmZ0kOu9MEzsESKpADndDSO3k9OXhf3f+C7SOIKJ6Cc6qQ8UCcJMx/WJARue+nR/SEOPbZe0h42ZuQT7i4ST4m5VSX6jASoPhNAYaVtmU1a0lcc/HQ57vSIVoeVhjVFjrYLvdavLDytcmkTnRnVF9v7An1wUFLlrPU+7B2L1C0kHe7h/IfVIFYXqjXH2z01JWCyGVnQckdF9o3zHumUZedQpuImst2S18pNzKKvkLGYDLtoQWj3QfBfv+ehqn1NLifc8opGkeARCI+aHHLTx/hQP6F59j+9RxAorCLsVn22N1XZ6/ZWci6EONfqZM1uacVVD59QqhGHHDGMYTy7cj5UWT4t3JyQK6M3/8Re4xiU1sZgpFlX0FiuQiKg40=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(36756003)(82310400005)(16526019)(186003)(4326008)(8676002)(70206006)(426003)(70586007)(2616005)(47076005)(26005)(41300700001)(316002)(40480700001)(1076003)(83380400001)(7696005)(54906003)(110136005)(6666004)(478600001)(40460700003)(356005)(81166007)(15650500001)(2906002)(82740400003)(36860700001)(5660300002)(8936002)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 19:11:20.4402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6a856a-789c-4649-221c-08daf7f573ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6096
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Add new error descriptions to extend existing SMCA error decoding
functionality for modern AMD processors. Additionally, also reword
some existing error descriptions and remove the unused ones.

[avadnaik: Add error descriptions for MPDMA SMCA bank, rework the commit
message]

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Avadhut Naik <avadnaik@amd.com>
---
 drivers/edac/mce_amd.c | 53 ++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 22 deletions(-)

diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index cc5c63feb26a..869dcca5e2f4 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -192,24 +192,24 @@ static const char * const smca_ls2_mce_desc[] = {
 	"A SystemReadDataError error was reported on read data returned from L2 for an SCB store",
 	"A SystemReadDataError error was reported on read data returned from L2 for a WCB store",
 	"A hardware assertion error was reported",
-	"A parity error was detected in an STLF, SCB EMEM entry or SRB store data by any access",
+	"A parity error was detected in an STLF, SCB EMEM entry, store data mask or SRB store data by any access",
 };
 
 static const char * const smca_if_mce_desc[] = {
-	"Op Cache Microtag Probe Port Parity Error",
+	"Op Cache Microtag Parity Error",
 	"IC Microtag or Full Tag Multi-hit Error",
 	"IC Full Tag Parity Error",
 	"IC Data Array Parity Error",
-	"Decoupling Queue PhysAddr Parity Error",
+	"PRQ Parity Error",
 	"L0 ITLB Parity Error",
-	"L1 ITLB Parity Error",
-	"L2 ITLB Parity Error",
+	"L1-TLB Parity Error",
+	"L2-TLB Parity Error",
 	"BPQ Thread 0 Snoop Parity Error",
 	"BPQ Thread 1 Snoop Parity Error",
-	"L1 BTB Multi-Match Error",
-	"L2 BTB Multi-Match Error",
+	"BP L1-BTB Multi-Hit Error",
+	"BP L2-BTB Multi-Hit Error",
 	"L2 Cache Response Poison Error",
-	"System Read Data Error",
+	"L2 Cache Error Response",
 	"Hardware Assertion Error",
 	"L1-TLB Multi-Hit",
 	"L2-TLB Multi-Hit",
@@ -222,12 +222,13 @@ static const char * const smca_l2_mce_desc[] = {
 	"L2M Tag or State Array ECC Error",
 	"L2M Data Array ECC Error",
 	"Hardware Assert Error",
+	"SDP Read Response Parity Error",
 };
 
 static const char * const smca_de_mce_desc[] = {
-	"Micro-op cache tag parity error",
-	"Micro-op cache data parity error",
-	"Instruction buffer parity error",
+	"Micro-op cache tag array parity error",
+	"Micro-op cache data array parity error",
+	"IBB Register File parity error",
 	"Micro-op queue parity error",
 	"Instruction dispatch queue parity error",
 	"Fetch address FIFO parity error",
@@ -247,7 +248,7 @@ static const char * const smca_ex_mce_desc[] = {
 	"Checkpoint queue parity error",
 	"Retire dispatch queue parity error",
 	"Retire status queue parity error",
-	"Scheduling queue parity error",
+	"Scheduler queue parity error",
 	"Branch buffer queue parity error",
 	"Hardware Assertion error",
 	"Spec Map parity error",
@@ -262,6 +263,7 @@ static const char * const smca_fp_mce_desc[] = {
 	"Retire queue (RQ) parity error",
 	"Status register file (SRF) parity error",
 	"Hardware assertion",
+	"Physical K mask register file (KRF) parity error",
 };
 
 static const char * const smca_l3_mce_desc[] = {
@@ -270,9 +272,10 @@ static const char * const smca_l3_mce_desc[] = {
 	"L3M Tag ECC Error",
 	"L3M Tag Multi-way-hit Error",
 	"L3M Data ECC Error",
-	"SDP Parity Error or SystemReadDataError from XI",
-	"L3 Victim Queue Parity Error",
+	"SDP Parity Error from XI",
+	"L3 Victim Queue Data Fabric Error",
 	"L3 Hardware Assertion",
+	"XI WCB Parity Poison Creation Event",
 };
 
 static const char * const smca_cs_mce_desc[] = {
@@ -302,6 +305,10 @@ static const char * const smca_cs2_mce_desc[] = {
 	"SDP read response had an unexpected RETRY error",
 	"Counter overflow error",
 	"Counter underflow error",
+	"Illegal Request on the no data channel",
+	"Address Violation on the no data channel",
+	"Security Violation on the no data channel",
+	"Hardware Assert Error",
 };
 
 static const char * const smca_pie_mce_desc[] = {
@@ -309,7 +316,9 @@ static const char * const smca_pie_mce_desc[] = {
 	"Register security violation",
 	"Link Error",
 	"Poison data consumption",
-	"A deferred error was detected in the DF"
+	"A deferred error was detected in the DF",
+	"Watch Dog Timer",
+	"An SRAM ECC error was detected in the CNLI block",
 };
 
 static const char * const smca_umc_mce_desc[] = {
@@ -321,6 +330,10 @@ static const char * const smca_umc_mce_desc[] = {
 	"Write data CRC error",
 	"DCQ SRAM ECC error",
 	"AES SRAM ECC error",
+	"ECS Row Error",
+	"ECS Error",
+	"UMC Throttling Error",
+	"Read CRC Error",
 };
 
 static const char * const smca_umc2_mce_desc[] = {
@@ -443,17 +456,12 @@ static const char * const smca_mpdma_mce_desc[] = {
 	"MPDMA TVF SDP Master Memory 4 ECC or parity error",
 	"MPDMA TVF SDP Master Memory 5 ECC or parity error",
 	"MPDMA TVF SDP Master Memory 6 ECC or parity error",
+	"SDP Watchdog Timer expired",
 	"MPDMA PTE Command FIFO ECC or parity error",
 	"MPDMA PTE Hub Data FIFO ECC or parity error",
 	"MPDMA PTE Internal Data FIFO ECC or parity error",
 	"MPDMA PTE Command Memory DMA ECC or parity error",
 	"MPDMA PTE Command Memory Internal ECC or parity error",
-	"MPDMA PTE DMA Completion FIFO ECC or parity error",
-	"MPDMA PTE Tablewalk Completion FIFO ECC or parity error",
-	"MPDMA PTE Descriptor Completion FIFO ECC or parity error",
-	"MPDMA PTE ReadOnly Completion FIFO ECC or parity error",
-	"MPDMA PTE DirectWrite Completion FIFO ECC or parity error",
-	"SDP Watchdog Timer expired",
 };
 
 static const char * const smca_nbio_mce_desc[] = {
@@ -461,7 +469,8 @@ static const char * const smca_nbio_mce_desc[] = {
 	"PCIE error",
 	"SDP ErrEvent error",
 	"SDP Egress Poison Error",
-	"IOHC Internal Poison Error",
+	"Internal Poison Error",
+	"Internal system fatal error event",
 };
 
 static const char * const smca_pcie_mce_desc[] = {
-- 
2.34.1

