Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40EEB66CF62
	for <lists+linux-edac@lfdr.de>; Mon, 16 Jan 2023 20:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjAPTMC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 16 Jan 2023 14:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbjAPTLw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 16 Jan 2023 14:11:52 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC292B08F;
        Mon, 16 Jan 2023 11:11:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijwkPMUUJRfkuGpwTq/zQti241OMA8RO04nWJwA2tLmRmeDV0djQQZNt3i/7Tf83FK9ka4XiaWtn6/O7wXsiN+33DLPizwvQfopkSKj8aK7xP+K2N4LSeVcb8Edc4qAp0f700S9RcNZnGhvhTaaaEkxVRuhvBhk1SgfTWen9xkY9wB4R1hEkMJLmavjHLg56q120fd1aGvU4Yvx0w8nQf/z3B3aZXxmPFHkH2QG5+6/Sd06XDQhhJkFHjeFYBcGAyLAEQJhgRiHg87MrUItPj90nZJQ6wIAgeUqcICImxN4QaNbxjiCjkdm1jy2m425mysymnG7D9hEKddnW4zqoXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wxRz8sHq7ijnnOkiEcewtmI6TapHvQYCMRerm1IFTI=;
 b=XFPGq09e4VMR442dxGaCjeig4XsY5CAcvhKzYns9KQGQS8C+ztFzW3n//kzAv+e7f82gqULzbY/VyHwV7Y9bNNhYSvhGarQVHI5ICeWM3uwGdYOxexi6Fao3M+iTohu7KR+Nsfjb+JH0oV+iBnWo3GrGEpsikSyft3MDQUdQIhTbg3egWI2lDNb6Z8mPyXkwO+mFA/JFnZf45hnBX6ug0GU2VbSbh/1Wkk6Sd8bIoLhKirWTmPrJPaf4LzAkbBNu339LtZJb+/bqcjlPb1bZlXbaYLjnQ0mqOtjrG21hcOQ7zYTqDFqT6d6pcd7pjC3tlOaciCP8sfSflo47I2+tUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wxRz8sHq7ijnnOkiEcewtmI6TapHvQYCMRerm1IFTI=;
 b=MntIhpMoMod70ifwhhfcuoprb4diJx4namet+JJZga/OjadVpTqr7NDt7/6DAM+9/I7Ct7dkO19yCdt8XRNKnfJ6tLD5pgox62EQLZy9zH5NNEPo5Hoc8/kD5uuHbvChCnR3Djcyo5kRjgUBSOk6nfr4YB9l++PTorqgrGT40VQ=
Received: from MW4PR04CA0220.namprd04.prod.outlook.com (2603:10b6:303:87::15)
 by DM8PR12MB5447.namprd12.prod.outlook.com (2603:10b6:8:36::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.23; Mon, 16 Jan 2023 19:11:48 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::42) by MW4PR04CA0220.outlook.office365.com
 (2603:10b6:303:87::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Mon, 16 Jan 2023 19:11:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Mon, 16 Jan 2023 19:11:47 +0000
Received: from onyx-7400host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 16 Jan
 2023 13:11:46 -0600
From:   Avadhut Naik <avadnaik@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <tony.luck@intel.com>, <yazen.ghannam@amd.com>, <avadnaik@amd.com>
Subject: [PATCH v1 3/3] x86/MCE/AMD: Handle reassigned bit definitions for CS SMCA
Date:   Mon, 16 Jan 2023 19:11:02 +0000
Message-ID: <20230116191102.4226-4-avadnaik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT044:EE_|DM8PR12MB5447:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d542fdc-aaf7-4323-92c5-08daf7f5843f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ot6Ll6CSWD9DQ9FzQk1JpCsnDObNQDv9zxFpdeIDjvTUaFzLh4vf+La0B+WI12KZTmlEsateRTwYl8SNXDPHqnUygxZglNvlfxOSEg5Ypq8mdGcm+/be2ToVo/IeLpGWGoBpUUEZoeJDzlwxT9RxzHJHKSIZCYf+vYfHW0HzSI2iUCnGlG9xJWQlvc9XwnUyD+k0Rn1SW8LSYvWD/ps7bfsJFhLMKoSTyr9rccog3KXjZ0SmRhCw6NNDBpNLJhtDt5UIec2kDml5BjanDUpP86Aj7haNETG3fuqXKgtae09lLiQji3Jd9j4f8xZmorI6LXboPN6hvB7+hZZ8YTxD3ujDK+aVSgnHrePSlwysmIUesdiEKjGNvFgb9La2rCzbUXJFuZRsqgJjSCvdskD7ZQaMwD8LlOQ5yuhl6mfjF/TljH2j8Ckn3ZO2rCF7A8BfBp46vmb8oHeUAQ58eMAuAV5G/uTRxHr8K0yXc4AcwO9R3sa0/4zbgdDM6VzZgzeptLsS72GQfOe6vRXsHNcPj1+Ho5e/qaULs09ZR+xpf1dMwg3g9tonbOWz40Jczh4TY1x+ecwFtYa7mTePO+YP9ZTt/yhqPXnhshay9cYGEIPdnNK9ZzQIVLtxpXXEk+Kq66e0WyhSfE/ZixwfujpCCx5FT01RGFpyXnrTUlbDU8MRBgM9/gCXH8NwFyZDyTihzWgeZFMYXdpyhEsW8DXV4YG5YPuPcU1Bo+9rPrxpJ9U=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(36756003)(8936002)(356005)(70206006)(4326008)(70586007)(8676002)(5660300002)(2906002)(81166007)(83380400001)(82740400003)(36860700001)(478600001)(316002)(40460700003)(7696005)(6666004)(110136005)(54906003)(40480700001)(82310400005)(41300700001)(47076005)(1076003)(426003)(336012)(26005)(2616005)(16526019)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 19:11:47.9778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d542fdc-aaf7-4323-92c5-08daf7f5843f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5447
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Currently, on AMD systems with Scalable MCA (SMCA), each machine check
error of a SMCA bank type has an associated bit position in the bank's
control (CTL) register used for enabling / disabling reporting of the
very error. An error's bit position in the CTL register is also used
during error decoding for offsetting into the corresponding bank's error
description structure. As new errors are being added in newer AMD systems
for existing SMCA bank types, the underlying SMCA architecture guarantees
that the bit positions of existing errors are not altered.

However, on some AMD systems viz. Genoa, some of the existing bit
definitions in the CTL register of the Coherent Slave (CS) SMCA bank type
are reassigned without defining new HWID and McaType. Consequently, the
very errors whose bit definitions have been reassigned in the CTL register
are being erroneously decoded.

As a solution, create a new software defined SMCA bank type by utilizing
one of the hardware-reserved values for HWID. The new SMCA bank type will
only be employed for CS error decoding on affected CPU models.

Additionally, since the existing error description structure for the CS
SMCA bank type is still valid, add new error description structure to
compensate for the reassigned bit definitions.

Signed-off-by: Avadhut Naik <avadnaik@amd.com>
---
 arch/x86/include/asm/mce.h    |  1 +
 arch/x86/kernel/cpu/mce/amd.c | 24 +++++++++++++++++++++++-
 drivers/edac/mce_amd.c        | 26 ++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 9646ed6e8c0b..d0442b4147b5 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -308,6 +308,7 @@ enum smca_bank_types {
 	SMCA_L3_CACHE,	/* L3 Cache */
 	SMCA_CS,	/* Coherent Slave */
 	SMCA_CS_V2,
+	SMCA_CS_V2_QUIRK,
 	SMCA_PIE,	/* Power, Interrupts, etc. */
 	SMCA_UMC,	/* Unified Memory Controller */
 	SMCA_UMC_V2,
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index b0cce0ce056c..317307772048 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -101,7 +101,7 @@ static struct smca_bank_name smca_names[] = {
 	[SMCA_EX]			= { "execution_unit",	"Execution Unit" },
 	[SMCA_FP]			= { "floating_point",	"Floating Point Unit" },
 	[SMCA_L3_CACHE]			= { "l3_cache",		"L3 Cache" },
-	[SMCA_CS ... SMCA_CS_V2]	= { "coherent_slave",	"Coherent Slave" },
+	[SMCA_CS ... SMCA_CS_V2_QUIRK]	= { "coherent_slave",	"Coherent Slave" },
 	[SMCA_PIE]			= { "pie",		"Power, Interrupts, etc." },
 
 	/* UMC v2 is separate because both of them can exist in a single system. */
@@ -178,6 +178,8 @@ static const struct smca_hwid smca_hwid_mcatypes[] = {
 	{ SMCA_CS,	 HWID_MCATYPE(0x2E, 0x0)	},
 	{ SMCA_PIE,	 HWID_MCATYPE(0x2E, 0x1)	},
 	{ SMCA_CS_V2,	 HWID_MCATYPE(0x2E, 0x2)	},
+	/* Software defined SMCA bank type to handle erratum 1384*/
+	{ SMCA_CS_V2_QUIRK, HWID_MCATYPE(0x0, 0x1)  },
 
 	/* Unified Memory Controller MCA type */
 	{ SMCA_UMC,	 HWID_MCATYPE(0x96, 0x0)	},
@@ -259,6 +261,17 @@ static inline void fixup_hwid(unsigned int *hwid_mcatype)
 
 	if (c->x86 == 0x19) {
 		switch (c->x86_model) {
+		/*
+		 * Per Genoa's revision guide, erratum 1384, some SMCA Extended
+		 * Error Codes and SMCA Control bits are incorrect for SMCA CS
+		 * bank type.
+		 */
+		case 0x10 ... 0x1F:
+		case 0x60 ... 0x7B:
+		case 0xA0 ... 0xAF:
+			if (*hwid_mcatype == HWID_MCATYPE(0x2E, 0x2))
+				*hwid_mcatype = HWID_MCATYPE(0x0, 0x1);
+			break;
 		/*
 		 * Handle discrepancy in HWID of kernel and MCA_IPID register
 		 * for XGMI Controller SMCA bank type
@@ -270,6 +283,15 @@ static inline void fixup_hwid(unsigned int *hwid_mcatype)
 		default:
 			break;
 		}
+	} else if (c->x86 == 0x1A) {
+		switch (c->x86_model) {
+		case 0x40 ... 0x4F:
+			if (*hwid_mcatype == HWID_MCATYPE(0x2E, 0x2))
+				*hwid_mcatype = HWID_MCATYPE(0x0, 0x1);
+			break;
+		default:
+			break;
+		}
 	}
 }
 
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 869dcca5e2f4..0586356475fd 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -311,6 +311,31 @@ static const char * const smca_cs2_mce_desc[] = {
 	"Hardware Assert Error",
 };
 
+/*
+ * Per Genoa's revision guide, erratum 1384, existing bit definitions
+ * are reassigned for SMCA CS bank type.
+ */
+static const char * const smca_cs2_quirk_mce_desc[] = {
+	"Illegal Request",
+	"Address Violation",
+	"Security Violation",
+	"Illegal Response",
+	"Unexpected Response",
+	"Request or Probe Parity Error",
+	"Read Response Parity Error",
+	"Atomic Request Parity Error",
+	"SDP read response had no match in the CS queue",
+	"SDP read response had an unexpected RETRY error",
+	"Counter overflow error",
+	"Counter underflow error",
+	"Probe Filter Protocol Error",
+	"Probe Filter ECC Error",
+	"Illegal Request on the no data channel",
+	"Address Violation on the no data channel",
+	"Security Violation on the no data channel",
+	"Hardware Assert Error",
+};
+
 static const char * const smca_pie_mce_desc[] = {
 	"Hardware Assert",
 	"Register security violation",
@@ -602,6 +627,7 @@ static struct smca_mce_desc smca_mce_descs[] = {
 	[SMCA_L3_CACHE]	= { smca_l3_mce_desc,	ARRAY_SIZE(smca_l3_mce_desc)	},
 	[SMCA_CS]	= { smca_cs_mce_desc,	ARRAY_SIZE(smca_cs_mce_desc)	},
 	[SMCA_CS_V2]	= { smca_cs2_mce_desc,	ARRAY_SIZE(smca_cs2_mce_desc)	},
+	[SMCA_CS_V2_QUIRK] = { smca_cs2_quirk_mce_desc, ARRAY_SIZE(smca_cs2_quirk_mce_desc)},
 	[SMCA_PIE]	= { smca_pie_mce_desc,	ARRAY_SIZE(smca_pie_mce_desc)	},
 	[SMCA_UMC]	= { smca_umc_mce_desc,	ARRAY_SIZE(smca_umc_mce_desc)	},
 	[SMCA_UMC_V2]	= { smca_umc2_mce_desc,	ARRAY_SIZE(smca_umc2_mce_desc)	},
-- 
2.34.1

