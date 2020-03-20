Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF93E18D88E
	for <lists+linux-edac@lfdr.de>; Fri, 20 Mar 2020 20:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgCTTnS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 20 Mar 2020 15:43:18 -0400
Received: from mail-bn7nam10on2066.outbound.protection.outlook.com ([40.107.92.66]:25359
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727224AbgCTTnQ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 20 Mar 2020 15:43:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlyKYOY4cNtXoI0WiP5arGoLz5htHDnyKr6gRx91YIaHo0Is4CQ3X//XYH0YqgpCDCfVrqicSBXo79lSSAwk5+RBJPzmaRBttvU9b9mvWD+Wk/48yfTSkSmcYV+ry0So6AkzLwN+ip62PzTXDkO8m74jSAv8Tc28Quy5TolK8nis+UOLeb0h5m03Qx80lkzgg1AjjfC1tW2N/1Gqvc7NzwneR4Dph9oW/KCVEmB4URUfFeuUqmUgetRi/efoyW8daJcoOVlxR0cKbtJum6w9JxXQKs84yPCNcuhuUAKD04999TVkTW4V89CsvDcNNv+sxPtXzWe8AinIDaVLM7BPbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iflgak9kldelJq3W7o0DF/yoynHfDIYLUA2CoYAVIVY=;
 b=IXDpRwxs3ND4sG9DRWM2qMk8599C0mMafQ5svj11hf3VeDIUbSms+BigughBg8MhFfo0Do4eZ7RqCa0smfJ/PF4vSIuy3yEnr6ThreQUkfQ7nuVpl2OIQ530jLNuZF3C/FxsG7BD+KF2e11ZgINO0gD9BJwH4f0I+PFVgwFPbaFGTMOgBsfKbKkzMPgcKbCv+VM+gCcst7FtRYqMvMy8uRP9kWObgJBQM+5h+NE0do0i4IHhX58BvwDZTDlk+NMsrzwUDTYE0dRnQfbgYx1+JIjL02HE6VcagKB0WpaFuqeF4rwMaEjyuVQhFgEbf2MMPlMRdV8Yv982qgLKjUWMhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iflgak9kldelJq3W7o0DF/yoynHfDIYLUA2CoYAVIVY=;
 b=3wAqClGqWVie+h8IjCnrfdPU3x0+lxDdomeszbYKV4p3MXIPXihu+bkaVlQI8v9rXwB0x4vCe+ayXA2GSEWjGjECgwEvYLTPcXoFoCjjTeOCGkE1E656MEvkOtG6kPlfcloKz/QsiccLuoVwg/fOfcJlbycdL6q4XCNfd+Ef8ZY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Wei.Huang2@amd.com; 
Received: from CY4PR12MB1352.namprd12.prod.outlook.com (2603:10b6:903:3a::13)
 by CY4PR12MB1430.namprd12.prod.outlook.com (2603:10b6:903:3e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.21; Fri, 20 Mar
 2020 19:43:12 +0000
Received: from CY4PR12MB1352.namprd12.prod.outlook.com
 ([fe80::5cdb:285d:f962:c2a8]) by CY4PR12MB1352.namprd12.prod.outlook.com
 ([fe80::5cdb:285d:f962:c2a8%12]) with mapi id 15.20.2814.025; Fri, 20 Mar
 2020 19:43:12 +0000
From:   Wei Huang <wei.huang2@amd.com>
To:     linux-kernel@vger.kernel.org
Cc:     bp@suse.de, tony.luck@intel.com, yazen.ghannam@amd.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        linux-edac@vger.kernel.org, x86@kernel.org,
        smita.koralahallichannabasappa@amd.com, wei.huang2@amd.com
Subject: [PATCH V2 1/1] x86/mce/amd: Add PPIN support for AMD MCE
Date:   Fri, 20 Mar 2020 14:43:05 -0500
Message-Id: <20200320194305.3532606-1-wei.huang2@amd.com>
X-Mailer: git-send-email 2.24.1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: DM5PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:3:23::12) To CY4PR12MB1352.namprd12.prod.outlook.com
 (2603:10b6:903:3a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from weiserver.amd.com (165.204.77.1) by DM5PR13CA0002.namprd13.prod.outlook.com (2603:10b6:3:23::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.11 via Frontend Transport; Fri, 20 Mar 2020 19:43:11 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8e94939a-d523-4a27-fc69-08d7cd06ec99
X-MS-TrafficTypeDiagnostic: CY4PR12MB1430:|CY4PR12MB1430:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB14309F7D1EDDA4873183358FCFF50@CY4PR12MB1430.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03484C0ABF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(199004)(478600001)(316002)(6916009)(16526019)(6666004)(66556008)(26005)(2616005)(5660300002)(36756003)(186003)(4326008)(956004)(66946007)(66476007)(8676002)(6486002)(81156014)(81166006)(8936002)(7696005)(1076003)(86362001)(2906002)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1430;H:CY4PR12MB1352.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QWonNj4brPEtTInC5i7T6ziCd6/rKLS4hG26nMZ1eHUNVUZb7rS9ExjkK3jlUBLw7H/Pp6jHwLXb+HtaYDUmjux1V7FTb7BSxvqkTF3TBTE9PVGoKMiiJac6h9Iql3AZTUIF4eUUEvbNRaPJ8z+NXbJHsFv9EqDH6KV5RrqqXy6HbJAMwuVNN1Lhb9KYoiMdN6EfMBMYjzbdWMflNhxxjtaXPfeWFbLLsUBd8vDwRsUPCTZIlbJu6to0DK2Nqsf4FQegjRKbmmyHK6VAYjlEr2oFV9T499CU37Aa8YwihsijP58g0fwxOPChp41kbcADGXysTS2CNGFPYJP3m3qtUCeQICaR693fO9VE5q1SZYUBAeJiuI/CuNRQ2HOymgrCQDhkPpJEOU8f/wTp1sDbiClC5MCCedh8QXEq1hh2aF8Fsh10A/ok8EV3zWE6HYoa
X-MS-Exchange-AntiSpam-MessageData: b+s32NQhNEoYio4LFsL7X5c6RPHwOiag7rHbWJRICpRXskWmv0EA3K4tbsDPRC3MBaN9lHhFVz2cCbrM+DOoHp03aKjSN4QoU3GolP8xzsAs5nbrhCUc5a2d4V1l4gA5k1TRzoMT0OT1ItbAWGdJgg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e94939a-d523-4a27-fc69-08d7cd06ec99
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2020 19:43:12.2115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mSkmgfLZZVaqHMoa1QIVICaQPZ4byo3CceJbkICQjFgEPVCM6lNAUKYNAO9ZQBP6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1430
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Newer AMD CPUs support a feature called protected processor identification
number (PPIN). This feature can be detected via CPUID_Fn80000008_EBX[23].
However CPUID alone is not enough to read the processor serial number.
MSR_AMD_PPIN_CTL also needs to be configured properly. If for any reason
X86_FEATURE_AMD_PPIN[PPIN_EN] can not be turned on, such as disabled in
BIOS, we have to clear the CPU capability bit of X86_FEATURE_AMD_PPIN.

When the X86_FEATURE_AMD_PPIN capability is available, MCE can read the
serial number to keep track the source of MCE errors.

Co-developed-by: Smita Koralahalli Channabasappa <smita.koralahallichannabasappa@amd.com>
Signed-off-by: Smita Koralahalli Channabasappa <smita.koralahallichannabasappa@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Acked-by: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: x86-ml <x86@kernel.org>
---
 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/kernel/cpu/amd.c          | 26 ++++++++++++++++++++++++++
 arch/x86/kernel/cpu/mce/core.c     |  2 ++
 3 files changed, 29 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index f3327cb56edf..4b263ffb793b 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -299,6 +299,7 @@
 #define X86_FEATURE_AMD_IBRS		(13*32+14) /* "" Indirect Branch Restricted Speculation */
 #define X86_FEATURE_AMD_STIBP		(13*32+15) /* "" Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_AMD_STIBP_ALWAYS_ON	(13*32+17) /* "" Single Thread Indirect Branch Predictors always-on preferred */
+#define X86_FEATURE_AMD_PPIN		(13*32+23) /* Protected Processor Inventory Number */
 #define X86_FEATURE_AMD_SSBD		(13*32+24) /* "" Speculative Store Bypass Disable */
 #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
 #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 1f875fbe1384..9176db4be69b 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -394,6 +394,31 @@ static void amd_detect_cmp(struct cpuinfo_x86 *c)
 	per_cpu(cpu_llc_id, cpu) = c->phys_proc_id;
 }
 
+static void amd_detect_ppin(struct cpuinfo_x86 *c)
+{
+	unsigned long long val;
+
+	if (cpu_has(c, X86_FEATURE_AMD_PPIN)) {
+		/* Turn off now until MSR is properly configured */
+		clear_cpu_cap(c, X86_FEATURE_AMD_PPIN);
+
+		if (rdmsrl_safe(MSR_AMD_PPIN_CTL, &val))
+			return;
+
+		if ((val & 3UL) == 1UL)
+			return;
+
+		if (!(val & 2UL)) {
+			wrmsrl_safe(MSR_AMD_PPIN_CTL,  val | 2UL);
+			rdmsrl_safe(MSR_AMD_PPIN_CTL, &val);
+		}
+
+		/* MSR_AMD_PPIN_CTL[PPIN_EN] bit is 1, turn feature back on */
+		if (val & 2UL)
+			set_cpu_cap(c, X86_FEATURE_AMD_PPIN);
+	}
+}
+
 u16 amd_get_nb_id(int cpu)
 {
 	return per_cpu(cpu_llc_id, cpu);
@@ -941,6 +966,7 @@ static void init_amd(struct cpuinfo_x86 *c)
 	amd_detect_cmp(c);
 	amd_get_topology(c);
 	srat_detect_node(c);
+	amd_detect_ppin(c);
 
 	init_amd_cacheinfo(c);
 
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 2c4f949611e4..57347e899575 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -142,6 +142,8 @@ void mce_setup(struct mce *m)
 
 	if (this_cpu_has(X86_FEATURE_INTEL_PPIN))
 		rdmsrl(MSR_PPIN, m->ppin);
+	else if (this_cpu_has(X86_FEATURE_AMD_PPIN))
+		rdmsrl(MSR_AMD_PPIN, m->ppin);
 
 	m->microcode = boot_cpu_data.microcode;
 }
-- 
2.24.1

