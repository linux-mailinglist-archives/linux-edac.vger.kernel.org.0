Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B324C6CF310
	for <lists+linux-edac@lfdr.de>; Wed, 29 Mar 2023 21:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjC2TWP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 29 Mar 2023 15:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjC2TWO (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 29 Mar 2023 15:22:14 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02159F0;
        Wed, 29 Mar 2023 12:22:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eaNP5LunXBV2UYCKXtRDISZqkp9dcO/OtDWSdhZk4re2rH5NbT7w/1EP1iM7vd4VwOVNNIT4ZALb83y0uyUCw2/CBb4UxOidMTm47rZfkk/LyXeCERfy2qz0G7vJP1cPPAoWEUIKUy9bJWauQd7Qr9q25DHPjs7/nP3zGsK4cT0xiZum3ZNqOZfyb+4U9Swq8+prckI6SGKJrN9JMKCiDCfXqdrP3rwapkZZFrFHPuqZZRMWWwF46xlC9cRNQsrCX1Pi3Q12scEIZiqhw12LAu7cvAJh/aem5Vc0HyN4uCplhr9W3DvQHOdrYO8NThz6KeLQhsghmQZv7mYezx8Zdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Icv+0UWzPk1NtrCsyOwSlM+I2N7pyx/9kkzqrUot3o=;
 b=UoJrSm8612VR4OrzK6mtQKwC1gw2adsEUe2IBNlDHtTCAP/beetHQApEwZjGZ+8dWdLM7m3UWy12axPeaDsuCqh1FAHJLT8ZcD+BiliDGue1G5EypzP9GEgSbu/SQqq+UFeDLZsZ/Y+gXe2AW2XUSyNLhAFnSZr04SsMq1R/U0yVEg78UXDP2Hvab12SkcMP8RSUZVaXQcRoLPv45xa6/WXWMoxT3DmKXFOEC5DeCObliKMIhk0wo/bndhuak9R3AUJD6Vfp9BnpS5THxLlw7Y0HcRwBKXW2hC8DpLnUABbOc6ASIqkpjwviL+ziM32UiLPKfc8vOEPJPUbJR6JYNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Icv+0UWzPk1NtrCsyOwSlM+I2N7pyx/9kkzqrUot3o=;
 b=bh9InCCEL0gNxNjAxfdcYLlbyqx1hSVX9iLg84LyyXbwxBjvfv+dzSuLhVNuqXAB5myysKCHHw2T14xnLE6sdFtZ8F1KZOvpyCz2nMGJew1WlYJ6ElQ2nwiCJBBkQymICKkEXLthgAN92Vy995GStLebL90uPhdp7ul4Kma6kfw=
Received: from MW4PR03CA0325.namprd03.prod.outlook.com (2603:10b6:303:dd::30)
 by CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 19:22:09 +0000
Received: from CO1NAM11FT116.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::62) by MW4PR03CA0325.outlook.office365.com
 (2603:10b6:303:dd::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Wed, 29 Mar 2023 19:22:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT116.mail.protection.outlook.com (10.13.174.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 19:22:09 +0000
Received: from onyx-7400host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 14:22:07 -0500
From:   Avadhut Naik <avadnaik@amd.com>
To:     <linux-edac@vger.kernel.org>, <bp@alien8.de>
CC:     <avadnaik@amd.com>, <yazen.ghannam@amd.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] EDAC/mce_amd: Update SMCA bank error descriptions
Date:   Wed, 29 Mar 2023 19:22:00 +0000
Message-ID: <20230329192200.110813-1-avadnaik@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT116:EE_|CY8PR12MB7170:EE_
X-MS-Office365-Filtering-Correlation-Id: dd1bbe7d-3177-42a1-8d32-08db308ae3fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aYVpIEFRsnd1s0ePoaaFmldkjTEhbUJn6WlT4OPg0DVyuPmmvqWY5OqbB2cqQYvqvSNDS4WRJny0VzEHEjfAZ/nce0lBvRJ7dBhk5TbWPba1xEOD0p6klGBCC4PWaZQ6bd+8jMhXu1RgV8I9isB3POcKVUJxqzub90c8gaU9uDkM2S5nxmZZXAXIVIGjg82eP/HtHYdIs+QMWZPh0JmTJzQbbcFk3CybM7+MZparH+DRJlmz2BiZX1qFsxLtacBxnN15PaelvK74It5Les/8XVYtNey/lzvVkZsj7y42iPJ8ujRaxNOMpmwRdj5HpaF0oeG3pHHQwHmR9kgDmW1KUEKpMVy0duv7+c8y8DgMIBu3Z3iQTCzTiNFjwXlzQRuktTdgfgVAswjL/Sd2u0QZNzU5GGK1n8j1eK3eSKT2x6guKFM6eVnbBe4tPtgu4k1lvCdnSjESRzCEKJXUYhNNwPBcSYClLmaMduG3hlVEtTl4QjKOOZjGYrSJVtSYQ6g6wsQPVdfI/82lYTtv2dGk78/IXEyWkZ+UPFwlLCCBrSorrjoinbSKaDMu721Obkauel6BxPayVGx4yYUODsYaQ7kJPXAUmk5pis44GoATlcPoced0Y10oxQoioSjDb1eM8Ijte0c8SicQNAfmaApIDW1Qb3JlZww4NA4rAB7Mh9WvRwX4w92s1nYMnOCfbPu63jH7lyE11DDogbLyVLAPg0MroxJfLfWxwHUVKcaBQH0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(40470700004)(36840700001)(46966006)(5660300002)(40460700003)(81166007)(82740400003)(83380400001)(110136005)(8676002)(70206006)(316002)(8936002)(26005)(41300700001)(54906003)(356005)(16526019)(1076003)(70586007)(36860700001)(4326008)(186003)(7696005)(336012)(6666004)(426003)(2616005)(47076005)(36756003)(40480700001)(15650500001)(82310400005)(478600001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 19:22:09.0068
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1bbe7d-3177-42a1-8d32-08db308ae3fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT116.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7170
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
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

