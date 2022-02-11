Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6904B30B8
	for <lists+linux-edac@lfdr.de>; Fri, 11 Feb 2022 23:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354135AbiBKWgA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Feb 2022 17:36:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354235AbiBKWf1 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 11 Feb 2022 17:35:27 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D83EDC0;
        Fri, 11 Feb 2022 14:35:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aokwKTYtY/yhSajFZiEJQXvqlcYHKDuVhO2FtOKzDMJVJc8j5bKEroF7xanwG1cC+LiWyeWdfaK+w/XI3mrgtx32dGYIMrocku4rrKiQ3Cp01EBy2gLu2+w7lwbDn3d8MpC/Zk147OcBynbbKunL31Npni0WRGBwLPSmHQTi4WNt0x5z6CXXOnCVGXXVqnCFqavf9N2z49PW8brVKKfUkSAR2xyOi7uoNopYamnM+Xbnk/gpfxd5g2KjInKwjLB4+oI4/hUF/JcyXJv5zT8njXNRgXjHzuuH0Sa8xLXmlkIg+1OOiHzrHGSiSnInMhX2UYhOcceRMNVH05CLcZLjcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxFf9owAiOZuKbdX724nO10XnSDK9a45um+zCoiplUg=;
 b=j0yIVN0FtzgeXodbf4ETeYypsjxoIx945nSZ6kCZMzjqwq10VfLnkDI0baFvLsCwlLXFXpYJk8KOEvfv90hkUpyz03AmjtCSbys3BYVl4kM1m4rcr9vxyVCcKxZTLbDVegcYR6ZsxGRzl3nkP4MPbiqO2q5kRFLR9xTz4liAJo4wIiKR236NvWMBH89cstsGYziT3KpYI9iSfQNo399WrBYuH5PxnQrYgySv6U8TUNTh4EKOTAWlqaFBwmyQRPGlNdfj+tFeRQvVxn2DxIVLhlBbcjO1S/E2NAIyaTUGRXLA7hLI3OD/z4ZZwgTRAfShKdSYe4SsCOW61u+FH8T/1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxFf9owAiOZuKbdX724nO10XnSDK9a45um+zCoiplUg=;
 b=fle/cXxGj2R9s2huMNGBrn/VwIkzMHn0hbksZkdi8GEeP38NCczwmUGKlIrchjKruOYeuaxAAMEMZdVXyDqH73ucqqXiA8rhUzLzyUvyHRhk5V16ZrvdlITva1IR0nsEaHD/q+8rytT4J4N58H8nbh7UMcZ7m+zqgtyXLb9NOr0=
Received: from BN6PR13CA0016.namprd13.prod.outlook.com (2603:10b6:404:10a::26)
 by BY5PR12MB4163.namprd12.prod.outlook.com (2603:10b6:a03:202::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 22:35:14 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:10a:cafe::1a) by BN6PR13CA0016.outlook.office365.com
 (2603:10b6:404:10a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.8 via Frontend
 Transport; Fri, 11 Feb 2022 22:35:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 22:35:14 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 11 Feb
 2022 16:35:12 -0600
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
Subject: [PATCH v3 2/4] x86/mce: Add support for Extended Physical Address MCA changes
Date:   Fri, 11 Feb 2022 16:34:40 -0600
Message-ID: <20220211223442.254489-3-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 36c1cf68-b951-4810-b076-08d9edaec587
X-MS-TrafficTypeDiagnostic: BY5PR12MB4163:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB41630020BE60B19DBC1AD7E790309@BY5PR12MB4163.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vLXBmhIjw5UBGI4j4GETfuXt/4s9P422ciCiqWYn2aRycn+j9yUGaHRyBzhoy3SBJZve8jWN6x7YZcyTYH46ePhap67HkREwg4PfRkMVXyiX3qHDvNB0SXcHadGi5wHbV340zI6jT9Gjg4xEtqPyoG2aSymVTBdV3TQ8J1tyAuC1Dl32md/Z/nv4b6zxd3YsmBE3hJUASKQkGXUlNbNmnHfkUvOEQ1k2VQ0dFEtCCKdon26FD+Cd0XAS99WoHmruk2Yt5HunNvmg6HcA1KKlLijK687tBLU0NwCnU+hEZZo2NJe4p9qNXgvGPMrSuWQRTkL8e5ygBuJxLOOiSHncB46mEWj6wWT4x1ja2UervMD3h4+8Xilhff0zUEco0p8WVlAe3KJdHBRcOfV8CGOVTRqBSiuyvDbUPddBje7D36vu3WE0jfk2jReMYGFNlFnzU3z+TFBsKQ1baKdIYvMWZ+gt94uFiLVbOTMZ8wQ6twjC31nYMSilluw2MWBIvfa129DC+EXL/7WS+S2dhdmMdsv6suHzDCEoM+RRbwiHlIDzDaF+qcUgHZCeoolyN7Qp9ARYB7uA37tB0Q1XlbdfvnioEi5h5JHoPC0v7vsnG19DUm2OTjbja1KY9sMJ1s7K/KMONBSDmUl3TBO8qRrycgKnXx5WiEw0j9+b2jGyYHY4+Yq1ZtrHyuvICotQ0DxrBcJaVM7MF9PrX0s3fyUeAxTf0XgwGi6YebR8YMI182jFv1pzUEAjykTp9/bp6fHTd0BvTtuXCYCEcfoOQbu3FwAI8lQWlDDCvVnES/9C1aUmH/fX1f559htwli9bgQQzCLAtLja5Mj7EBezKkWbsPA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2616005)(8936002)(36756003)(36860700001)(7696005)(110136005)(40460700003)(47076005)(966005)(1076003)(6666004)(316002)(54906003)(508600001)(70206006)(83380400001)(86362001)(8676002)(426003)(336012)(82310400004)(26005)(4326008)(16526019)(70586007)(356005)(186003)(81166007)(2906002)(5660300002)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 22:35:14.2482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c1cf68-b951-4810-b076-08d9edaec587
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4163
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Newer AMD processors such as AMD 'Milan' support more physical address
bits.

That is the MCA_ADDR registers on Scalable MCA systems contain the
ErrorAddr in bits [56:0] instead of [55:0]. Hence the existing LSB field
from bits [61:56] in MCA_ADDR must be moved around to accommodate the
larger ErrorAddr size.

MCA_CONFIG[McaLsbInStatusSupported] indicates this change. If set, the
LSB field will be found in MCA_STATUS rather than MCA_ADDR.

Each logical CPU has unique MCA bank in hardware and is not shared with
other logical CPUs. Additionally on SMCA systems, each feature bit may be
different for each bank within same logical CPU.

Check for MCA_CONFIG[McaLsbInStatusSupported] for each MCA bank and for
each CPU.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210625013341.231442-2-Smita.KoralahalliChannabasappa@amd.com

v2:
	Declared lsb_in_status in existing mce_bank[] struct.
	Moved struct mce_bank[] declaration from core.c -> internal.h
v3:
	Rebased on the latest tip tree. No functional changes.
---
 arch/x86/include/asm/mce.h         |  2 ++
 arch/x86/kernel/cpu/mce/amd.c      | 25 +++++++++++++++++++------
 arch/x86/kernel/cpu/mce/core.c     | 13 ++++---------
 arch/x86/kernel/cpu/mce/internal.h | 14 ++++++++++++++
 4 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 99a4c32cbdfa..cc67c74e8b46 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -338,6 +338,7 @@ extern int mce_threshold_remove_device(unsigned int cpu);
 void mce_amd_feature_init(struct cpuinfo_x86 *c);
 enum smca_bank_types smca_get_bank_type(unsigned int cpu, unsigned int bank);
 void smca_extract_err_addr(struct mce *m);
+void smca_feature_init(void);
 #else
 
 static inline int mce_threshold_create_device(unsigned int cpu)		{ return 0; };
@@ -345,6 +346,7 @@ static inline int mce_threshold_remove_device(unsigned int cpu)		{ return 0; };
 static inline bool amd_mce_is_memory_error(struct mce *m)		{ return false; };
 static inline void mce_amd_feature_init(struct cpuinfo_x86 *c)		{ }
 static inline void smca_extract_err_addr(struct mce *m) { }
+static inline void smca_feature_init(void) { }
 #endif
 
 static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c)	{ return mce_amd_feature_init(c); }
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 981d718851a2..ed75d4bd2aff 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -724,9 +724,26 @@ bool amd_mce_is_memory_error(struct mce *m)
 
 void smca_extract_err_addr(struct mce *m)
 {
-	u8 lsb = (m->addr >> 56) & 0x3f;
+	if (this_cpu_ptr(mce_banks_array)[m->bank].lsb_in_status) {
+		u8 lsb = (m->status >> 24) & 0x3f;
 
-	m->addr &= GENMASK_ULL(55, lsb);
+		m->addr &= GENMASK_ULL(56, lsb);
+	} else {
+		u8 lsb = (m->addr >> 56) & 0x3f;
+
+		m->addr &= GENMASK_ULL(55, lsb);
+	}
+}
+
+void smca_feature_init(void)
+{
+	unsigned int bank;
+	u64 mca_cfg;
+
+	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
+		rdmsrl(MSR_AMD64_SMCA_MCx_CONFIG(bank), mca_cfg);
+		this_cpu_ptr(mce_banks_array)[bank].lsb_in_status = !!(mca_cfg & BIT(8));
+	}
 }
 
 static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
@@ -743,10 +760,6 @@ static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
 	if (m.status & MCI_STATUS_ADDRV) {
 		m.addr = addr;
 
-		/*
-		 * Extract [55:<lsb>] where lsb is the least significant
-		 * *valid* bit of the address bits.
-		 */
 		if (mce_flags.smca)
 			smca_extract_err_addr(&m);
 	}
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index f031f2668523..92adce850488 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -67,11 +67,7 @@ DEFINE_PER_CPU(unsigned, mce_exception_count);
 
 DEFINE_PER_CPU_READ_MOSTLY(unsigned int, mce_num_banks);
 
-struct mce_bank {
-	u64			ctl;			/* subevents to enable */
-	bool			init;			/* initialise bank? */
-};
-static DEFINE_PER_CPU_READ_MOSTLY(struct mce_bank[MAX_NR_BANKS], mce_banks_array);
+DEFINE_PER_CPU_READ_MOSTLY(struct mce_bank[MAX_NR_BANKS], mce_banks_array);
 
 #define ATTR_LEN               16
 /* One object for each MCE bank, shared by all CPUs */
@@ -660,10 +656,6 @@ static noinstr void mce_read_aux(struct mce *m, int i)
 			m->addr <<= shift;
 		}
 
-		/*
-		 * Extract [55:<lsb>] where lsb is the least significant
-		 * *valid* bit of the address bits.
-		 */
 		if (mce_flags.smca)
 			smca_extract_err_addr(m);
 	}
@@ -1902,6 +1894,9 @@ static void __mcheck_cpu_init_early(struct cpuinfo_x86 *c)
 		mce_flags.succor	 = !!cpu_has(c, X86_FEATURE_SUCCOR);
 		mce_flags.smca		 = !!cpu_has(c, X86_FEATURE_SMCA);
 		mce_flags.amd_threshold	 = 1;
+
+		if (mce_flags.smca)
+			smca_feature_init();
 	}
 }
 
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 52c633950b38..39dc37052cb9 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -175,6 +175,20 @@ struct mce_vendor_flags {
 
 extern struct mce_vendor_flags mce_flags;
 
+struct mce_bank {
+	u64			ctl;			/* subevents to enable */
+	bool			init;			/* initialise bank? */
+
+	/*
+	 * (AMD) MCA_CONFIG[McaLsbInStatusSupported]: This bit indicates
+	 * the LSB field is found in MCA_STATUS, when set.
+	 */
+	__u64 lsb_in_status		: 1,
+	      __reserved_1		: 63;
+};
+
+DECLARE_PER_CPU_READ_MOSTLY(struct mce_bank[MAX_NR_BANKS], mce_banks_array);
+
 enum mca_msr {
 	MCA_CTL,
 	MCA_STATUS,
-- 
2.17.1

