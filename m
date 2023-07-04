Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D8C746F41
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jul 2023 12:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjGDK6x (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 4 Jul 2023 06:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjGDK6w (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 4 Jul 2023 06:58:52 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54A9E72;
        Tue,  4 Jul 2023 03:58:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LhL+8czMWNjucB8PiN1CjJRR10Lf+M9uZ429DXTexdSNKCFr2cqRrsY9WMM0dgeQravIjG/Qhj0GT0MRWayjE5avEf4imjVltajBVM748jpFAkdQS0sigDbdAGKYgM/8L2EHrbh8PRX+dTuXmymUQCVZgU5finL1BoHJIDbdsUW1vZJkPABylCGeFVz1uCzhEV3ud/3vdn4wgiD1PvzTxZhYAEzxPeJyIvf2OYT2FZW/thUWiEltdnpASK9fCwtdvwbdyFO73lAtxYzp6Ll2nVgBEi0mvtSZDNbEk+yg0AfU4uVkZ371O0K+wrI7q2CyzAr6lzxZwNS/c4sPM3M83w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Jr6fYDSqBKtYWygGzmtFI0xaERplsQNjr5cyphfOso=;
 b=PsgTJOqRjhedcJ3o7nDB3DSEL1bwgRpGH6KTr3/rMuw2ScV+HGjTHj7yPPjZlmHCm35rufKwq0prWd2ToA/bIYUqbk9obXcG/QQ23drTFQvSaYUVmm59t5pjf4RZYRS/O0+cJOZnn6yviQp3WSe+ZRDzx72LetJ6E2xpkp86sPPvg3A7a697BPH6E5iGla5T4EiQn3bGeBjl33Jd9omi/3OgOghAfjNs7qYJluFmjQ1FMLXF14po6+QMRMEQTd5Tu2ilJ3LjgRm42lJrhbsuxKrZHISuRGnMKqlYlPMEWM/ClJ9mVKU1KY55c1WwLiPRPCICwajELmkRDqW7l8t+4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Jr6fYDSqBKtYWygGzmtFI0xaERplsQNjr5cyphfOso=;
 b=e5bU4ZfFHuv6m4SLGCl0giCuXD2I1knA4r7890q+OYcisS+eCjLqzYSE8XpAK+fNXu21kGMVI+bUOmVbF+x88811ieVyKxoX097vnSFHcNKnMMAtASIFdWEhaQASQlgdQHLnmxCpuVqIrL9VLQpJs36EvM6ZwP0aPEVEilRC/gA=
Received: from SJ0PR03CA0029.namprd03.prod.outlook.com (2603:10b6:a03:33a::34)
 by CYXPR12MB9443.namprd12.prod.outlook.com (2603:10b6:930:db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Tue, 4 Jul
 2023 10:58:48 +0000
Received: from DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:33a:cafe::ad) by SJ0PR03CA0029.outlook.office365.com
 (2603:10b6:a03:33a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.30 via Frontend
 Transport; Tue, 4 Jul 2023 10:58:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT069.mail.protection.outlook.com (10.13.173.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.44 via Frontend Transport; Tue, 4 Jul 2023 10:58:48 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 4 Jul
 2023 05:58:45 -0500
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mchehab@kernel.org>,
        <bp@alien8.de>, Muralidhara M K <muralidhara.mk@amd.com>
Subject: [PATCH 2/3] rasdaemon: Add new MA_LLC, USR_DP, and USR_CP bank types.
Date:   Tue, 4 Jul 2023 10:58:22 +0000
Message-ID: <20230704105823.3516889-3-muralimk@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230704105823.3516889-1-muralimk@amd.com>
References: <20230704105823.3516889-1-muralimk@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT069:EE_|CYXPR12MB9443:EE_
X-MS-Office365-Filtering-Correlation-Id: 74d55e38-2d36-40f2-1455-08db7c7da4f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BLej0Nfv3zjcbhYekxQnazR2DV2cZDcqkW2FWEVoxxtX2cq+AxSGRTKcJHNIVXw62VQiIjSIy3vObVGr28aCo9hQCXdhgBDJc2BOz7KOvZloqMX8WNl+cBRQHS4m6rRMhg1VZ6HPT58SODJB3+dre+POCRzep5OXivOl/xVs7Jvvy7mBUDWv3gYaD/jlhHPreKpjg/XJ3mCRsd8AryEKgDAqrSzrWDdk44rEswTif11Le1AzVhkoVpYMqAKTHWTCnGAMUHf6AX2WqUk+UC01wMMLltQls7AQ75K1FZqqKP12R7bixiz193DqahbISACsfxoRsQJ9qPe0mouU5p1/oSU0nKqddwWG+wh31CIpnjx9gHgdj4Ubpemm56ARjfBPpjKsJzBRNXzD4SkVKouH2o/rn+DNp/6z9+YVbkcv4iY4HQSkWUAe+ntRbbpQMrpWu1QfeO1O7dxq/e5bbab/OTHvqktKieYy5D7gP4AOhJkZU2xhLRYOtFdwPh9A60AH2GQ0cHrxCUeHCZFLeA0sgMPfka21iEZhkjC2ubyWHm4BrWdzrN5wb87RKlt5KaPRq33kEYs9vKHj/L8eCDkLiE8of/mEq58LBLu9XE5mfwkRKtBAwEh5wKMZqd+Q8BwoAuHftzbfaJKbLncWZEc/aV0H8WO+4HXmG+FnEs4w0rWTxOTgkURRFUhUpn/6oBrYerdacSPEjy93Cj43XdJ1pRH8SEfh5/pjDzF2D+WxMpFwRTyaffSXy/iPY8ErSfaDRDv+cGV635T6uN4HDqLOhw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199021)(40470700004)(36840700001)(46966006)(41300700001)(5660300002)(54906003)(40480700001)(36756003)(7696005)(15650500001)(2906002)(316002)(8676002)(8936002)(4326008)(6916009)(70586007)(70206006)(40460700003)(426003)(336012)(82740400003)(6666004)(478600001)(82310400005)(186003)(2616005)(356005)(81166007)(47076005)(83380400001)(26005)(16526019)(1076003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 10:58:48.2360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d55e38-2d36-40f2-1455-08db7c7da4f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9443
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

Add HWID and McaType values for new SMCA bank types
and error decoding for those new SMCA banks.

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
---
 mce-amd-smca.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/mce-amd-smca.c b/mce-amd-smca.c
index 4a2e645..61f05c5 100644
--- a/mce-amd-smca.c
+++ b/mce-amd-smca.c
@@ -61,6 +61,7 @@ enum smca_bank_types {
 	SMCA_PIE,       /* Power, Interrupts, etc. */
 	SMCA_UMC,       /* Unified Memory Controller */
 	SMCA_UMC_V2,
+	SMCA_MA_LLC,	/* Memory Attached Last Level Cache */
 	SMCA_PB,        /* Parameter Block */
 	SMCA_PSP,       /* Platform Security Processor */
 	SMCA_PSP_V2,
@@ -76,6 +77,8 @@ enum smca_bank_types {
 	SMCA_SHUB,		/* System Hub Unit */
 	SMCA_SATA,		/* SATA Unit */
 	SMCA_USB,		/* USB Unit */
+	SMCA_USR_DP,	/* Ultra Short Reach Data Plane Controller */
+	SMCA_USR_CP,	/* Ultra Short Reach Control Plane Controller */
 	SMCA_GMI_PCS,	/* GMI PCS Unit */
 	SMCA_XGMI_PHY,	/* xGMI PHY Unit */
 	SMCA_WAFL_PHY,	/* WAFL PHY Unit */
@@ -325,6 +328,16 @@ static const char * const smca_umc2_mce_desc[] = {
 	"LM32 MP errors",
 };
 
+static const char * const smca_mall_mce_desc[] = {
+	"Counter overflow error",
+	"Counter underflow error",
+	"Write Data Parity Error",
+	"Read Response Parity Error",
+	"Cache Tag ECC Error Macro 0",
+	"Cache Tag ECC Error Macro 1",
+	"Cache Data ECC Error"
+};
+
 static const char * const smca_pb_mce_desc[] = {
 	"An ECC error in the Parameter Block RAM array"
 };
@@ -524,6 +537,57 @@ static const char * const smca_usb_mce_desc[] = {
 	"AXI Slave Response error",
 };
 
+static const char * const smca_usrdp_mce_desc[] = {
+	"Mst CMD Error",
+	"Mst Rx FIFO Error",
+	"Mst Deskew Error",
+	"Mst Detect Timeout Error",
+	"Mst FlowControl Error",
+	"Mst DataValid FIFO Error",
+	"Mac LinkState Error",
+	"Deskew Error",
+	"Init Timeout Error",
+	"Init Attempt Error",
+	"Recovery Timeout Error",
+	"Recovery Attempt Error",
+	"Eye Training Timeout Error",
+	"Data Startup Limit Error",
+	"LS0 Exit Error",
+	"PLL powerState Update Timeout Error",
+	"Rx FIFO Error",
+	"Lcu Error",
+	"Conv CECC Error",
+	"Conv UECC Error",
+	"Reserved",
+	"Rx DataLoss Error",
+	"Replay CECC Error",
+	"Replay UECC Error",
+	"CRC Error",
+	"BER Exceeded Error",
+	"FC Init Timeout Error",
+	"FC Init Attempt Error",
+	"Replay Timeout Error",
+	"Replay Attempt Error",
+	"Replay Underflow Error",
+	"Replay Overflow Error",
+};
+
+static const char * const smca_usrcp_mce_desc[] = {
+	"Packet Type Error",
+	"Rx FIFO Error",
+	"Deskew Error",
+	"Rx Detect Timeout Error",
+	"Data Parity Error",
+	"Data Loss Error",
+	"Lcu Error",
+	"HB1 Handshake Timeout Error",
+	"HB2 Handshake Timeout Error",
+	"Clk Sleep Rsp Timeout Error",
+	"Clk Wake Rsp Timeout Error",
+	"Reset Attack Error",
+	"Remote Link Fatal Error",
+};
+
 static const char * const smca_gmipcs_mce_desc[] = {
 	"Data Loss Error",
 	"Training Error",
@@ -579,6 +643,7 @@ static struct smca_mce_desc smca_mce_descs[] = {
 	[SMCA_PIE]      = { smca_pie_mce_desc,  ARRAY_SIZE(smca_pie_mce_desc) },
 	[SMCA_UMC]      = { smca_umc_mce_desc,  ARRAY_SIZE(smca_umc_mce_desc) },
 	[SMCA_UMC_V2]	= { smca_umc2_mce_desc,	ARRAY_SIZE(smca_umc2_mce_desc)	},
+	[SMCA_MA_LLC]	= { smca_mall_mce_desc, ARRAY_SIZE(smca_mall_mce_desc)	},
 	[SMCA_PB]       = { smca_pb_mce_desc,   ARRAY_SIZE(smca_pb_mce_desc)  },
 	[SMCA_PSP]      = { smca_psp_mce_desc,  ARRAY_SIZE(smca_psp_mce_desc) },
 	[SMCA_PSP_V2]   = { smca_psp2_mce_desc, ARRAY_SIZE(smca_psp2_mce_desc)},
@@ -595,6 +660,8 @@ static struct smca_mce_desc smca_mce_descs[] = {
 	[SMCA_SHUB] = { smca_nbif_mce_desc, ARRAY_SIZE(smca_nbif_mce_desc)  },
 	[SMCA_SATA] = { smca_sata_mce_desc, ARRAY_SIZE(smca_sata_mce_desc)  },
 	[SMCA_USB]  = { smca_usb_mce_desc,  ARRAY_SIZE(smca_usb_mce_desc)   },
+	[SMCA_USR_DP]	= { smca_usrdp_mce_desc,  ARRAY_SIZE(smca_usrdp_mce_desc)   },
+	[SMCA_USR_CP]	= { smca_usrcp_mce_desc,  ARRAY_SIZE(smca_usrcp_mce_desc)   },
 	[SMCA_GMI_PCS]  = { smca_gmipcs_mce_desc,  ARRAY_SIZE(smca_gmipcs_mce_desc) },
 	/* All the PHY bank types have the same error descriptions, for now. */
 	[SMCA_XGMI_PHY]	= { smca_xgmiphy_mce_desc, ARRAY_SIZE(smca_xgmiphy_mce_desc)	},
@@ -631,6 +698,8 @@ static struct smca_hwid smca_hwid_mcatypes[] = {
 	{ SMCA_UMC,      0x00000096 },
 	/* Heterogeneous systems may have both UMC and UMC_v2 types on the same node. */
 	{ SMCA_UMC_V2,   0x00010096 },
+	/* Memory Attached Last Level Cache */
+	{ SMCA_MA_LLC,   0x0004002E },
 
 	/* Parameter Block MCA type */
 	{ SMCA_PB,       0x00000005 },
@@ -664,6 +733,11 @@ static struct smca_hwid smca_hwid_mcatypes[] = {
 	{ SMCA_SHUB,	 0x00000080 },
 	{ SMCA_SATA,     0x000000A8 },
 	{ SMCA_USB,		 0x000000AA },
+
+	/* Ultra Short Reach Data and Control Plane Controller */
+	{ SMCA_USR_DP,  0x00000170 },
+	{ SMCA_USR_CP,  0x00000180 },
+
 	{ SMCA_GMI_PCS,  0x00000241 },
 
 	/* Ext Global Memory Interconnect PHY MCA type */
@@ -692,6 +766,7 @@ static struct smca_bank_name smca_names[] = {
 	[SMCA_PIE]			= { "Power, Interrupts, etc." },
 	[SMCA_UMC]			= { "Unified Memory Controller" },
 	[SMCA_UMC_V2]			= { "Unified Memory Controller V2" },
+	[SMCA_MA_LLC]			= { "Memory Attached Last Level Cache" },
 	[SMCA_PB]			= { "Parameter Block" },
 	[SMCA_PSP ... SMCA_PSP_V2]	= { "Platform Security Processor" },
 	[SMCA_SMU ... SMCA_SMU_V2]	= { "System Management Unit" },
@@ -704,6 +779,8 @@ static struct smca_bank_name smca_names[] = {
 	[SMCA_SHUB]         = { "System Hub Unit" },
 	[SMCA_SATA]         = { "SATA Unit" },
 	[SMCA_USB]          = { "USB Unit" },
+	[SMCA_USR_DP]			= { "Ultra Short Reach Data Plane Controller" },
+	[SMCA_USR_CP]			= { "Ultra Short Reach Control Plane Controller" },
 	[SMCA_GMI_PCS]          = { "Global Memory Interconnect PCS Unit" },
 	[SMCA_XGMI_PHY]			= { "Ext Global Memory Interconnect PHY Unit" },
 	[SMCA_WAFL_PHY]			= { "WAFL PHY Unit" },
-- 
2.25.1

