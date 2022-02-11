Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42C74B30B7
	for <lists+linux-edac@lfdr.de>; Fri, 11 Feb 2022 23:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354087AbiBKWfg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Feb 2022 17:35:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354167AbiBKWf1 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 11 Feb 2022 17:35:27 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2061.outbound.protection.outlook.com [40.107.96.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AECDB0;
        Fri, 11 Feb 2022 14:35:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1DZ/7SRpe8FqZQgeGdi3xoNjvsNJK6J9uMWsZETfZE+WUZBuihtAtKDOpbkey3J3bS72aVmwl7kqKS1htltw7+weU3idb3T45xc4RysPErqDXSXtmP6CFxKGxNapexSI/TyeUBLgEsYoS7hg7SBx2ItqqPJwmvAODvq/SZXuZMLFaQriwzFv8JPR6LfH92Es5wE6S9PgTEh1HOH5zrbp9ib69ez62r6co5DBx1+GPWqdGqvGxH3NmGiSj0XVqJGQ1zrdzq970XpbZn/xxomdQtuMTP5aMj77KH3IYYPmzwOZD1OhritvPHbJcfftoU4XTm1gC9zFZu+9dvHPvYTRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWfSSRavvlOS3TkVybXUmz3pbwZeI24BBOAo1if2aWo=;
 b=i11ZXcbxZZVx2LWUaNp3N1sIrbklpO2lI2wQ9PJMdOv3icwSjBDripuB0gG1IVKlHvvdodcJ00uSKEERJhFwTvfTnIlccaioa4rdzTsFyCApzbIesDxBsPf9M2Dm/ZZ/GeLWIcLSnIhya9yDxLEX6MgM3FeaN37XrykIJEQRyvPyfARUHnp6WJ8jEla1Nzi6Bjj7foKXFjgzuNKz3qpPWMXCLeEhODbDqIZxqMYtAFanzaQPalwrmu2aUzE8/PQyAeZxIQc/7qtFMt14XNTuO8Vt9dVeWVnD2oesnOHyAPgjqEaJK7JDM8hfPRuVtoHtj7am7NEXeHUtbCNBRBC5FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWfSSRavvlOS3TkVybXUmz3pbwZeI24BBOAo1if2aWo=;
 b=F+kn2IR4pyWKHs5BPJCnUgZo2WOVIB0TdNGFQG0lEJwwLdbJArGJogSt/mYLgqLjcI8AAoZ7wsccsmhTpieoCxFwZC40n47MbhQaWwN9DNdGRjzLYdvCM6fW13lkNcrDTiNfwza6d0hzkQu2zo3B7TswtWp78adaa80s8sLwsMc=
Received: from BN6PR13CA0012.namprd13.prod.outlook.com (2603:10b6:404:10a::22)
 by BYAPR12MB4710.namprd12.prod.outlook.com (2603:10b6:a03:9f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Fri, 11 Feb
 2022 22:35:13 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:10a:cafe::f4) by BN6PR13CA0012.outlook.office365.com
 (2603:10b6:404:10a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.6 via Frontend
 Transport; Fri, 11 Feb 2022 22:35:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 22:35:12 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 11 Feb
 2022 16:35:10 -0600
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
Subject: [PATCH v3 1/4] x86/mce: Define function to extract ErrorAddr from MCA_ADDR
Date:   Fri, 11 Feb 2022 16:34:39 -0600
Message-ID: <20220211223442.254489-2-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3fb3b19a-3694-4475-bcbd-08d9edaec4cd
X-MS-TrafficTypeDiagnostic: BYAPR12MB4710:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB4710567B8D17EB4AD935359190309@BYAPR12MB4710.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XBtV9Ds8FUzK1dIOPeJ4aeAzWNKtdVd1QXhpjqNzwIhS+idffKBDC8rwEd413v1hXXbnwL2GmNVBrgbnfgddKyxW8G4ZEidOsEI3RzuGyX59u2Gm4eDV2b6zJn2sbb6YM1VQp+LwWNk3TaKzy5ou5CRp0gArLziICM4xFSZT+uP3ySrTZMdMI9hq5ZxdSF/5kxRDYNAMRJSHQkz1cOJLPlIQqdMTR6FfeuBY2/WDrM3zTW4Afi7RGyhGbhmBpiMXnHXnHt2DoSTzcXYQiEUJbXldJuXmFu2vpQ175Gx7XPXAKXDsX7P5gH8cTBMabvF+AJVhz3jWM4HAsy3PFeFZkzRfoG0ReFn8Mqy4KUMH3LYoJDAkvr4z+bcBb114kFcjH+LBjrD56Rd7O0TPvprlHaSQXsiI7QYPIdPKFtfovEpGE5fYfpaOWW7jl/44rjgguyADlI5M1CH5yF50EcBBdhtJLv6HwKAKibRPHkyy8qEW+pwHRYIerzlNgRPYcDqsbwXisfAa+Qs3g2HczQunCLGexVtPjX3siccjh3ZHCYY/vnz5MCTfRUCXkYtdrYFICsUOs6NwogzsV545vzhH6yfT9ZsGr7k7OBhJPQLKEz+nY6B8HAEuEbYmEcXXCDRraoP/eeouLDdKiOu3gtoOklwf9/YX93jcWm2B/XX+b+FxIBjqXrdOulJs3Sf8vX8w87cmV0KdoghcPuyoHUuhCCVKu79lNBCdHjL25wvIuFG9iDLNmNiwc0VTMogLMOSzzovCXoyVuz3kXujyQvcaTL1kmknzjLTZeajHMwvQ04c=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2906002)(16526019)(316002)(336012)(426003)(5660300002)(82310400004)(1076003)(70206006)(8676002)(8936002)(70586007)(4326008)(110136005)(54906003)(26005)(186003)(2616005)(81166007)(83380400001)(36860700001)(47076005)(356005)(40460700003)(86362001)(6666004)(966005)(36756003)(7696005)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 22:35:12.7327
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb3b19a-3694-4475-bcbd-08d9edaec4cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4710
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move MCA_ADDR[ErrorAddr] extraction into a separate helper function. This
will be further refactored in the next patch.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210625013341.231442-1-Smita.KoralahalliChannabasappa@amd.com

v2:
	No change.
v3:
	Rebased on the latest tip tree. No functional changes.
---
 arch/x86/include/asm/mce.h     |  2 ++
 arch/x86/kernel/cpu/mce/amd.c  | 14 +++++++++-----
 arch/x86/kernel/cpu/mce/core.c |  7 ++-----
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index cc73061e7255..99a4c32cbdfa 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -337,12 +337,14 @@ extern int mce_threshold_remove_device(unsigned int cpu);
 
 void mce_amd_feature_init(struct cpuinfo_x86 *c);
 enum smca_bank_types smca_get_bank_type(unsigned int cpu, unsigned int bank);
+void smca_extract_err_addr(struct mce *m);
 #else
 
 static inline int mce_threshold_create_device(unsigned int cpu)		{ return 0; };
 static inline int mce_threshold_remove_device(unsigned int cpu)		{ return 0; };
 static inline bool amd_mce_is_memory_error(struct mce *m)		{ return false; };
 static inline void mce_amd_feature_init(struct cpuinfo_x86 *c)		{ }
+static inline void smca_extract_err_addr(struct mce *m) { }
 #endif
 
 static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c)	{ return mce_amd_feature_init(c); }
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 1940d305db1c..981d718851a2 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -722,6 +722,13 @@ bool amd_mce_is_memory_error(struct mce *m)
 	return m->bank == 4 && xec == 0x8;
 }
 
+void smca_extract_err_addr(struct mce *m)
+{
+	u8 lsb = (m->addr >> 56) & 0x3f;
+
+	m->addr &= GENMASK_ULL(55, lsb);
+}
+
 static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
 {
 	struct mce m;
@@ -740,11 +747,8 @@ static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
 		 * Extract [55:<lsb>] where lsb is the least significant
 		 * *valid* bit of the address bits.
 		 */
-		if (mce_flags.smca) {
-			u8 lsb = (m.addr >> 56) & 0x3f;
-
-			m.addr &= GENMASK_ULL(55, lsb);
-		}
+		if (mce_flags.smca)
+			smca_extract_err_addr(&m);
 	}
 
 	if (mce_flags.smca) {
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 4f1e825033ce..f031f2668523 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -664,11 +664,8 @@ static noinstr void mce_read_aux(struct mce *m, int i)
 		 * Extract [55:<lsb>] where lsb is the least significant
 		 * *valid* bit of the address bits.
 		 */
-		if (mce_flags.smca) {
-			u8 lsb = (m->addr >> 56) & 0x3f;
-
-			m->addr &= GENMASK_ULL(55, lsb);
-		}
+		if (mce_flags.smca)
+			smca_extract_err_addr(m);
 	}
 
 	if (mce_flags.smca) {
-- 
2.17.1

