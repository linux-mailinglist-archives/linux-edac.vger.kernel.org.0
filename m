Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5C70180EFB
	for <lists+linux-edac@lfdr.de>; Wed, 11 Mar 2020 05:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgCKEoW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 11 Mar 2020 00:44:22 -0400
Received: from mail-eopbgr680075.outbound.protection.outlook.com ([40.107.68.75]:61948
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725976AbgCKEoV (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 11 Mar 2020 00:44:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKooU2VpbD0yVvjNDARG0YpjXJj+o/r+zsKu12VJbGMX3MZ0sWbiWK6QzFEKZ7VqyizHSXJUeYnPX6ViWcVvobBnEwnrYyGsytVVnv0TDfkksBs24FfPXV6jo5enwESevzHfz3jszBlyzR9rbv8gpSkaV1lhcrextYrORkJnYUdEC82xUciMatrSjmw2K8v/5kv7mMDJYIyS52TwhB8KaYoB9G54cmnqamPlllBq3dIyZEV5A7FpqLQtosOmD5/Gl9C5vWeE7RLEohZqQnyIstjeCQeRr+RnZSO7lY2t51MXm7kHHEtOV+r1eHtXFBUVdNhItCY9hklvaaVdlRSnBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gzc7yKMuwKDbgZkU/d47QeE6UIGaMME7W6+498CC7Q=;
 b=k2/7XUEkfSRsJqYCy6TsJVn36PbSkDLzrin/kYoqU6qqIGGPlPENIrjAsAJcw2n/4mSHFuoGvQrZfaezyjBe1FeZgu05RbTUDS5lJ3cqj3WbsaASUMcQhIAWci4/kmLxQ0Trtx3/QF+QZr8U1oKdBpNy6lFzRDDm5ov+fx1iA7Fo0izk+m2Sl6f5KDtB9LqVoeE4hpeYTu0XkV8MgNDeKXno0V+eNeq8VuuxxP+SEP3/ZvLzfzjq1oGuh80f5rX/2fxXl7Chwt9pdyr9na6xPs4XxBNZ2t7RUVo1FAZsFETfLsbIwpttGRKKXRq68kyNJjgci9WGF7YZxbSfMCyd6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gzc7yKMuwKDbgZkU/d47QeE6UIGaMME7W6+498CC7Q=;
 b=gjuvS91R+c3R7qOOkjS9+9aWtqjF7V4waXjmbxjI9orW0DDKoWkAkRmaFJS0Eu97xtFvWWYM+xKOIrFHl05+Iujm2INbtaos6WFMMmhpvUNIo8vrcuZY3GpH13CJ+sp9GYWdFI45Xte6lmCDIu6IdBpKTaEFEumZNTAiyCUXIA8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Wei.Huang2@amd.com; 
Received: from MN2PR12MB3999.namprd12.prod.outlook.com (2603:10b6:208:158::27)
 by MN2PR12MB3247.namprd12.prod.outlook.com (2603:10b6:208:ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Wed, 11 Mar
 2020 04:44:17 +0000
Received: from MN2PR12MB3999.namprd12.prod.outlook.com
 ([fe80::54b3:f596:c0d9:7409]) by MN2PR12MB3999.namprd12.prod.outlook.com
 ([fe80::54b3:f596:c0d9:7409%4]) with mapi id 15.20.2793.018; Wed, 11 Mar 2020
 04:44:17 +0000
From:   Wei Huang <wei.huang2@amd.com>
To:     linux-kernel@vger.kernel.org
Cc:     tony.luck@intel.com, bp@suse.de, yazen.ghannam@amd.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        linux-edac@vger.kernel.org, x86@kernel.org,
        smita.koralahallichannabasappa@amd.com
Subject: [PATCH 1/1] x86/mce/amd: Add PPIN support for AMD MCE
Date:   Tue, 10 Mar 2020 23:44:09 -0500
Message-Id: <20200311044409.2717587-1-wei.huang2@amd.com>
X-Mailer: git-send-email 2.24.1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: DM5PR1101CA0020.namprd11.prod.outlook.com
 (2603:10b6:4:4c::30) To MN2PR12MB3999.namprd12.prod.outlook.com
 (2603:10b6:208:158::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from weiserver.amd.com (165.204.77.1) by DM5PR1101CA0020.namprd11.prod.outlook.com (2603:10b6:4:4c::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.11 via Frontend Transport; Wed, 11 Mar 2020 04:44:16 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1908cb04-0ba9-4195-633d-08d7c576db1f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3247:|MN2PR12MB3247:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB32474B950538298C366D6459CFFC0@MN2PR12MB3247.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(199004)(956004)(7696005)(52116002)(6486002)(26005)(6916009)(16526019)(36756003)(1076003)(316002)(2616005)(186003)(6666004)(4326008)(8936002)(66946007)(66556008)(66476007)(81156014)(8676002)(86362001)(478600001)(5660300002)(2906002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3247;H:MN2PR12MB3999.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: atSUSbK8T9gy2oofp5m3OJ6z0POYkFdymkMXID+wkzkBImj5nt7fcQY7KtpIb+RzwoysX179NuPv1PcvpiiBZyiVxCbF8CLaUae2r2wtb7LknC8gzVj49GPbaAJfO3v/x7+Jwhn+5oawpzdWO9YGPmSDPbRU33zuOD4JnZHNl2RiQNDYjlqx+7wgvbRnYwyyDVKZYM/tp0i5Ll7ybVRPoIRE4RfE7Ai4UEm9v4mPGdu66c6oR0iGfJ1kyT4Sv+B8dB9/OHlV8BxLzzhjDHBm69YwtpWCL1x32t753f6ds5uSJQES6wzVj/w/IU6FACvjhq2wsZHv+sq2o2QFsFQ6oK7hPVUCTAwQh4eAax3bjxwkRwhBDaMqMFvM5565IBSDbxFq/xEagotnqyahVfEwqC9BqyuNLyxi223OhVA97kqJpdRAdJh4ncbBvGdjp7Me
X-MS-Exchange-AntiSpam-MessageData: 99iYS0gQyClEt3kvIa81b/QlavASzwrAHRpv/DWJ1kITxwuObfwyeok9tQ1y+7v+p5FcSyHqWZg0YCa5TUwAS+d/9tiTTZ2VE1RoY/aNveTo8mQLluKl243v1cXJzDrJvs6MzgQPx7KwnNpWeBf1EA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1908cb04-0ba9-4195-633d-08d7c576db1f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 04:44:17.1593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PSE7WIC4FNAfx5G11L3cpYcSZJDKamNUDy25qRTFP+UTRzDvzrQeAM6IGvVWLyQw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3247
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Newer AMD CPUs support the feature of protected processor identification
number (PPIN). This patch detects and enables PPIN support on AMD platforms
and includes PPIN info in MCE records if available. Because this feature is
almost identical on both Intel and AMD, it re-uses X86_FEATURE_INTEL_PPIN
feature bit and renames it to X86_FEATURE_PPIN.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Smita Koralahalli Channabasappa <smita.koralahallichannabasappa@amd.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: x86-ml <x86@kernel.org>
---
 arch/x86/include/asm/cpufeatures.h |  2 +-
 arch/x86/kernel/cpu/mce/amd.c      | 23 +++++++++++++++++++++++
 arch/x86/kernel/cpu/mce/core.c     |  8 ++++++--
 arch/x86/kernel/cpu/mce/intel.c    |  2 +-
 4 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index f3327cb56edf..c040ceb44b68 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -203,7 +203,7 @@
 #define X86_FEATURE_PTI			( 7*32+11) /* Kernel Page Table Isolation enabled */
 #define X86_FEATURE_RETPOLINE		( 7*32+12) /* "" Generic Retpoline mitigation for Spectre variant 2 */
 #define X86_FEATURE_RETPOLINE_AMD	( 7*32+13) /* "" AMD Retpoline mitigation for Spectre variant 2 */
-#define X86_FEATURE_INTEL_PPIN		( 7*32+14) /* Intel Processor Inventory Number */
+#define X86_FEATURE_PPIN		( 7*32+14) /* Protected Processor Inventory Number */
 #define X86_FEATURE_CDP_L2		( 7*32+15) /* Code and Data Prioritization L2 */
 #define X86_FEATURE_MSR_SPEC_CTRL	( 7*32+16) /* "" MSR SPEC_CTRL is implemented */
 #define X86_FEATURE_SSBD		( 7*32+17) /* Speculative Store Bypass Disable */
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 52de616a8065..013c50ba4812 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -624,6 +624,27 @@ static void disable_err_thresholding(struct cpuinfo_x86 *c, unsigned int bank)
 		wrmsrl(MSR_K7_HWCR, hwcr);
 }
 
+static void mce_amd_ppin_init(struct cpuinfo_x86 *c)
+{
+	unsigned long long val;
+
+	if (c->extended_cpuid_level < 0x80000008)
+		return;
+
+	if (cpuid_ebx(0x80000008) & BIT(23)) {
+		if (rdmsrl_safe(MSR_AMD_PPIN_CTL, &val))
+			return;
+
+		if (!(val & 3UL)) {
+			wrmsrl_safe(MSR_AMD_PPIN_CTL,  val | 2UL);
+			rdmsrl_safe(MSR_AMD_PPIN_CTL, &val);
+		}
+
+		if ((val & 3UL) == 2UL)
+			set_cpu_cap(c, X86_FEATURE_PPIN);
+	}
+}
+
 /* cpu init entry point, called from mce.c with preempt off */
 void mce_amd_feature_init(struct cpuinfo_x86 *c)
 {
@@ -659,6 +680,8 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 
 	if (mce_flags.succor)
 		deferred_error_interrupt_enable(c);
+
+	mce_amd_ppin_init(c);
 }
 
 int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 2c4f949611e4..7aab162c0a00 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -140,8 +140,12 @@ void mce_setup(struct mce *m)
 	m->apicid = cpu_data(m->extcpu).initial_apicid;
 	rdmsrl(MSR_IA32_MCG_CAP, m->mcgcap);
 
-	if (this_cpu_has(X86_FEATURE_INTEL_PPIN))
-		rdmsrl(MSR_PPIN, m->ppin);
+	if (this_cpu_has(X86_FEATURE_PPIN)) {
+		if (m->cpuvendor == X86_VENDOR_INTEL)
+			rdmsrl(MSR_PPIN, m->ppin);
+		else if (m->cpuvendor == X86_VENDOR_AMD)
+			rdmsrl(MSR_AMD_PPIN, m->ppin);
+	}
 
 	m->microcode = boot_cpu_data.microcode;
 }
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index 5627b1091b85..424fe1661085 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -504,7 +504,7 @@ static void intel_ppin_init(struct cpuinfo_x86 *c)
 		}
 
 		if ((val & 3UL) == 2UL)
-			set_cpu_cap(c, X86_FEATURE_INTEL_PPIN);
+			set_cpu_cap(c, X86_FEATURE_PPIN);
 	}
 }
 
-- 
2.24.1

