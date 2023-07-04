Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81910746F43
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jul 2023 12:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjGDK66 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 4 Jul 2023 06:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjGDK6y (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 4 Jul 2023 06:58:54 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20613.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::613])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2863BE6E;
        Tue,  4 Jul 2023 03:58:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LoTRPllpyFYMttczMyk3oRfDLv+P//6KCGROJhJJsh1rygCEx5oInhW8vY07eoz/ysC9NR74nRHYR+/xVIPQ5lNYa9m6faxZzrj5QPeNsbSYGWAyAXP2SfL18MxgHtUYTx+7OK/YehRl4MbRfCBTHdTmGO+VAkXZ8IoAmCv5hKx0RPG8d1TKFJ7x399H/jcO92WTlFW+mXehT5xfwRQBDTdB6h5ajUaO99yEn8I8VBLWIapz1zuYg63eUj1Sb1ad0WvJY1mbowp7VieY2Wr/HDBsrfK5W7aSHwrCMwWl1Rz53c+7mvwKdBII/NSXjQ6/UYe5SLP3sTxZH+Hg836LiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3HCAVlQsLdm4FHNrsTvnYLFJJmPruqWR5+lolMEAmo=;
 b=i81Jr6pMJovj1SccXmPsPS4bugKj+0W7zesdabiTeuM4s6XssVyRB2kqGKx8axelcy2yu3L+/eJhOi5tvKK5/4WzQY5x+WVRkceA9Xzp2yV1ZxVl/rhEU6RuMml/7L7UkaNlbhWWu+msTmR9skW0bJ5Q3ppyjyVfc/D6xCKd+4H2A3WXOLdABEnrYk0JjoiEtrEMKJUTJeYfej1u1qfMhmlic6/amDXRgmpphTSJrQLVu8jL/qJodFQW8nd6hXbNFJaryBMJTU4Lk6qX/NMZB8EuNmLjOHkLLHSnUHaFe7WfpwGruWndQFQogc9WCQ3RQHsDjjJGd37MRcxc5ibPZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3HCAVlQsLdm4FHNrsTvnYLFJJmPruqWR5+lolMEAmo=;
 b=Sf9uBP84jb8nMQm0C0YryeVb9y1A72/gL65wWdGzdLrOJZXhOtrHjHjsNeHu+8VDTW9B/V+ve5Jao2Nh+FFb5CgWxujrs4/Km240XLYV4JjSFES2tussMmcuF5w+HkBSviw/FbmFRBArhwOMPzgE23NhzbpMeVzp2EPVMtQs3Tk=
Received: from DS7PR05CA0020.namprd05.prod.outlook.com (2603:10b6:5:3b9::25)
 by CYYPR12MB8924.namprd12.prod.outlook.com (2603:10b6:930:bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 10:58:50 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::e2) by DS7PR05CA0020.outlook.office365.com
 (2603:10b6:5:3b9::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Tue, 4 Jul 2023 10:58:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.44 via Frontend Transport; Tue, 4 Jul 2023 10:58:49 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 4 Jul
 2023 05:58:48 -0500
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mchehab@kernel.org>,
        <bp@alien8.de>, Muralidhara M K <muralidhara.mk@amd.com>
Subject: [PATCH 3/3] rasdaemon: Handle reassigned bit definitions for UMC bank
Date:   Tue, 4 Jul 2023 10:58:23 +0000
Message-ID: <20230704105823.3516889-4-muralimk@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT037:EE_|CYYPR12MB8924:EE_
X-MS-Office365-Filtering-Correlation-Id: e98c731b-eef7-4d80-371f-08db7c7da5f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u0s/MAQgvQGg/DiNrIQp/s+UpxSMAs+C5mxxIJ9JJkBneWI0UaTAws+8lpjSpb4+yieG6gplVPsjH5JzCNiZjdPre/1mRJj7X5Tk7lTCEZ63s6MrzzdvnqduGKdVIEUQLFXR2WbsAk6is1xa+01XtTXH6SVbhypzTLEENandEhzAc0Bl+v5m1rU4/ZlCBTUeRr/lbo7sScYRVl9ONC+1ScXyuC3Plq7gkQ416/wbRu27IgQdJ0eOZZL576xOFDbp00ef/ffiNFFdzq97Qcphx1eAIRsfsVz3y/jmECelmVw72mevPRwl9S3q+H/XGMuoVaEBRKAf2LxKS76GwUHzojV7S4JEbqB+cqpcyYEFAfCwpdwIlU4FREyvqPIyBTjqxpjkJCOaPnxeul8JvDE36y7wlnbRZDTu3EUvi8h2BwhyvYly0KqYGJUJ2pQxwbj+vsBcCMhU6AuxA6CaCUQxJHeHft3mBPU5xFfLsJyTZ3bWNf2Ef7RgFryJDqKYennmdS8puS0YN44qRQzr/bTAkGwJDwTOFLgJnjfXX4zivQ03lWPj9+7wdIORmHClFvcreqpiHXSEWTZj14Ae8Sc14ZAvJu0ODXuiXaCdBahs+ztgTRqyeSZ47E8iaURHrOVNJIOhe9fQB5aYafHTvpKxr2Eqr+RYxMKPqVnQgMDbLH2WTgK3jO1Kw5iCwLSNknZv4tAYY+h7GGcyBEsavDXKEsINEdcSjd5MECVcpHXVQrpQes+020Gf+5Gefu7iAT9bYlyD6H/CYcuLvpWq6bEq7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199021)(40470700004)(36840700001)(46966006)(2906002)(5660300002)(54906003)(316002)(26005)(1076003)(478600001)(4326008)(8676002)(15650500001)(8936002)(70206006)(70586007)(41300700001)(36860700001)(6916009)(6666004)(7696005)(40460700003)(47076005)(83380400001)(81166007)(336012)(356005)(82740400003)(40480700001)(16526019)(82310400005)(2616005)(426003)(36756003)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 10:58:49.9343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e98c731b-eef7-4d80-371f-08db7c7da5f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8924
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

On some AMD systems some of the existing bit definitions in the
CTL register of SMCA bank type are reassigned without defining
new HWID and McaType. Consequently, the errors whose bit
definitions have been reassigned in the CTL register are being
erroneously decoded.

Add new error description structure to compensate for the
reassigned bit definitions, by new software defined SMCA bank
type by utilizing  the hardware-reserved values for HWID.
The new SMCA bank type will only be employed for UMC error
decoding on affected models and the existing error description
structure for UMC bank type is still valid.

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
---
 mce-amd-smca.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/mce-amd-smca.c b/mce-amd-smca.c
index 61f05c5..3a17d9a 100644
--- a/mce-amd-smca.c
+++ b/mce-amd-smca.c
@@ -60,6 +60,7 @@ enum smca_bank_types {
 	SMCA_CS_V2_QUIRK,
 	SMCA_PIE,       /* Power, Interrupts, etc. */
 	SMCA_UMC,       /* Unified Memory Controller */
+	SMCA_UMC_QUIRK,
 	SMCA_UMC_V2,
 	SMCA_MA_LLC,	/* Memory Attached Last Level Cache */
 	SMCA_PB,        /* Parameter Block */
@@ -313,6 +314,25 @@ static const char * const smca_umc_mce_desc[] = {
 	"Read CRC Error",
 };
 
+static const char * const smca_umc_quirk_mce_desc[] = {
+	"DRAM On Die ECC error",
+	"Data poison error",
+	"SDP parity error",
+	"Reserved",
+	"Address/Command parity error",
+	"HBM Write data parity error",
+	"Consolidated SRAM ECC error",
+	"Reserved",
+	"Reserved",
+	"Rdb SRAM ECC error",
+	"Thermal throttling",
+	"HBM Read Data Parity error",
+	"Reserved",
+	"UMC FW Error",
+	"SRAM Parity Error",
+	"HBM CRC Error",
+};
+
 static const char * const smca_umc2_mce_desc[] = {
 	"DRAM ECC error",
 	"Data poison error",
@@ -642,6 +662,7 @@ static struct smca_mce_desc smca_mce_descs[] = {
 	[SMCA_CS_V2_QUIRK] = { smca_cs2_quirk_mce_desc, ARRAY_SIZE(smca_cs2_quirk_mce_desc)},
 	[SMCA_PIE]      = { smca_pie_mce_desc,  ARRAY_SIZE(smca_pie_mce_desc) },
 	[SMCA_UMC]      = { smca_umc_mce_desc,  ARRAY_SIZE(smca_umc_mce_desc) },
+	[SMCA_UMC_QUIRK] = { smca_umc_quirk_mce_desc,  ARRAY_SIZE(smca_umc_quirk_mce_desc) },
 	[SMCA_UMC_V2]	= { smca_umc2_mce_desc,	ARRAY_SIZE(smca_umc2_mce_desc)	},
 	[SMCA_MA_LLC]	= { smca_mall_mce_desc, ARRAY_SIZE(smca_mall_mce_desc)	},
 	[SMCA_PB]       = { smca_pb_mce_desc,   ARRAY_SIZE(smca_pb_mce_desc)  },
@@ -696,6 +717,7 @@ static struct smca_hwid smca_hwid_mcatypes[] = {
 
 	/* Unified Memory Controller MCA type */
 	{ SMCA_UMC,      0x00000096 },
+	{ SMCA_UMC_QUIRK, 0x00002000 },
 	/* Heterogeneous systems may have both UMC and UMC_v2 types on the same node. */
 	{ SMCA_UMC_V2,   0x00010096 },
 	/* Memory Attached Last Level Cache */
@@ -764,7 +786,7 @@ static struct smca_bank_name smca_names[] = {
 	[SMCA_L3_CACHE]			= { "L3 Cache" },
 	[SMCA_CS ... SMCA_CS_V2_QUIRK]	= { "Coherent Slave" },
 	[SMCA_PIE]			= { "Power, Interrupts, etc." },
-	[SMCA_UMC]			= { "Unified Memory Controller" },
+	[SMCA_UMC ... SMCA_UMC_QUIRK]	= { "Unified Memory Controller" },
 	[SMCA_UMC_V2]			= { "Unified Memory Controller V2" },
 	[SMCA_MA_LLC]			= { "Memory Attached Last Level Cache" },
 	[SMCA_PB]			= { "Parameter Block" },
@@ -843,6 +865,10 @@ static inline void fixup_hwid(struct mce_priv* m, uint32_t *hwid_mcatype)
 			if (*hwid_mcatype == 0x0002002E)
 				*hwid_mcatype = 0x00010000;
 			break;
+		case 0x90 ... 0x9F:
+			if (*hwid_mcatype == 0x00000096)
+				*hwid_mcatype = 0x00020000;
+			break;
 		default:
 			break;
 		}
-- 
2.25.1

