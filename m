Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E30F18E407
	for <lists+linux-edac@lfdr.de>; Sat, 21 Mar 2020 20:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbgCUTiO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 21 Mar 2020 15:38:14 -0400
Received: from mail-mw2nam12on2052.outbound.protection.outlook.com ([40.107.244.52]:9056
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727658AbgCUTiN (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 21 Mar 2020 15:38:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQIfDDE7JgdZ/bRsxLt0uxFKBiBeBzG7UJ7Bi27Ws+QGHg0Y1YtGW4DTrrpPhlYCT3yO0B6AXf+x197YTkVnQslEHbnSAGyLiJQpbvuwPFkBN+NGzuK81W8rEIHg5uhoVmqWpH4duoSWm7HoVE5lFfrdpBJ6D3kOSAAimvaU/GustFTwaEnkrDekz1XgEblNGpv3eiMiRSGze6ifrSpJ+OgC7/L2GPJ/XkUfomE0BQ9TrH/Zrq/hxkc/nySYWn+lDGQx1MFXnWI5FMiT46IBqsis3N7OqkussX6CoL6bZSo4CEC4fhK1+YzYWLONeegrFP1JPi0i0HUBjfCSxhoEig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1f0tdTbFRLgaZIZOpLjzwfH3ytpHV0DWtWOoIWARBxg=;
 b=GPhJf5j+55h/z8KftlEr/mdZC9sVFgFp3ubvCpjkIK9x9B4HnhqsBzgvVjBhGo9QeMxGDi5CVHTJMtcQ3XYtmJQb9EL42MW22ciffjqmQNZgP9+Ytavx9NCFTgJahBDTtpd8QFTIGH/zM0feijry+wmWg5FoOtD3sKpXcXTrRCugEXvngj/UpQh67nQxVaZUT5JBC2CqsUWnzesu0M84GJB6oFiqpmQJk6JzemzJCMpDemHHn+CppSERNDMIhLHd9krh3B5IqZCSSolzt/T4WkX8oZ/qHHgmVubkjZO+ch6BIHCx20rFwPjfGFPcw3zMBs2Buj+5olfNwraP3PLYVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1f0tdTbFRLgaZIZOpLjzwfH3ytpHV0DWtWOoIWARBxg=;
 b=DudiyNGDdMjY8iFmh6qCWgcnOjPX3Y0l3NWDpt2oB/80Jn5cF6y/fCKpCGz350skIcdrZwopMAbeC/0TtIYAUSatAhxUzsEBQfHkUYgTejL+ROctdo+Fnp6L0RjxQZV3Z+XgyEKnMcmchJbA3zreFtlKgC6ps35AiDv5GrmA3Mo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Wei.Huang2@amd.com; 
Received: from CY4PR12MB1352.namprd12.prod.outlook.com (2603:10b6:903:3a::13)
 by CY4PR12MB1687.namprd12.prod.outlook.com (2603:10b6:910:3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Sat, 21 Mar
 2020 19:38:08 +0000
Received: from CY4PR12MB1352.namprd12.prod.outlook.com
 ([fe80::5cdb:285d:f962:c2a8]) by CY4PR12MB1352.namprd12.prod.outlook.com
 ([fe80::5cdb:285d:f962:c2a8%12]) with mapi id 15.20.2814.025; Sat, 21 Mar
 2020 19:38:07 +0000
From:   Wei Huang <wei.huang2@amd.com>
To:     linux-kernel@vger.kernel.org
Cc:     bp@suse.de, tony.luck@intel.com, yazen.ghannam@amd.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        linux-edac@vger.kernel.org, x86@kernel.org,
        smita.koralahallichannabasappa@amd.com, wei.huang2@amd.com
Subject: [PATCH V3 1/1] x86/mce/amd: Add PPIN support for AMD MCE
Date:   Sat, 21 Mar 2020 14:38:00 -0500
Message-Id: <20200321193800.3666964-1-wei.huang2@amd.com>
X-Mailer: git-send-email 2.24.1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR16CA0044.namprd16.prod.outlook.com
 (2603:10b6:805:ca::21) To CY4PR12MB1352.namprd12.prod.outlook.com
 (2603:10b6:903:3a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from weiserver.amd.com (165.204.77.1) by SN6PR16CA0044.namprd16.prod.outlook.com (2603:10b6:805:ca::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19 via Frontend Transport; Sat, 21 Mar 2020 19:38:06 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a94626e7-4102-44a8-ecba-08d7cdcf6198
X-MS-TrafficTypeDiagnostic: CY4PR12MB1687:|CY4PR12MB1687:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB168788A0EEFA9D3553BDD35FCFF20@CY4PR12MB1687.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 034902F5BC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(199004)(2906002)(6916009)(8936002)(1076003)(36756003)(8676002)(81166006)(81156014)(956004)(2616005)(5660300002)(66476007)(66556008)(66946007)(316002)(478600001)(6486002)(52116002)(4326008)(86362001)(16526019)(26005)(186003)(7696005)(6666004);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1687;H:CY4PR12MB1352.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:3;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: emksx+JJ2D9MO8UVAz78nI2YX1DZ2aLoPmsNr/k0BJZeTTGB6fd72ns20fjuh5TvPK9e64ULBzBD1ItK+MPSFNjhqdnLUSIKChEmOQyKWd4NbXGxBh68y88vKWRWYFHbXFs30+rUYoiWZx4nC+I4LWMpZ1ujiJtydvnMURhRxsZd3yZw3T61+iPkyFPYab7yUpNvqWt0pqvvH9+E3CbrsRYj4k0grinVDDrFbX5epp+6SLuLhYcmq3psL5wN+bojs3GMhKD+2/LcTc9CN/aBKMn7418p7M8pp6+rbjasVEhQRDgQCrc6FmPj7ZnOXJrVkEqowxq8FdciqPsYCFgCTKgF4y1dHlvis7ZALDpdQ/wPJwJk6dLBZfnqrMq6hWPr7TNhVv8f57DdgzozmmgOyhn7hj/yAkaqNzxgS4jDrEoMR6qofuERzC5xao3LJabU
X-MS-Exchange-AntiSpam-MessageData: nArbqazAQMim8lgCk9UMWKjkT89SUBAs55JTU0hQ8L5V+Sn8k2KxMwdbSvhR+K4YDv3G4SHbAm59K01tvlyHa5IVK02xoVaWDaJXpztNY2l7P2FRbYK9TO4gWilmWujy23nJume5ci2WI2Y3wUc7Nw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a94626e7-4102-44a8-ecba-08d7cdcf6198
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2020 19:38:07.8519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T+ewJtYXsa3cpVklMOCjjton+Ta+T9g4dWu/EjD1hUhvNH0f9TW5hdHtmQuwChX0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1687
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
 arch/x86/kernel/cpu/amd.c          | 30 ++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/mce/core.c     |  2 ++
 3 files changed, 33 insertions(+)

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
index 1f875fbe1384..aef06c37d338 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -394,6 +394,35 @@ static void amd_detect_cmp(struct cpuinfo_x86 *c)
 	per_cpu(cpu_llc_id, cpu) = c->phys_proc_id;
 }
 
+static void amd_detect_ppin(struct cpuinfo_x86 *c)
+{
+	unsigned long long val;
+
+	if (!cpu_has(c, X86_FEATURE_AMD_PPIN))
+		return;
+
+	/* When PPIN is defined in CPUID, still need to check PPIN_CTL MSR */
+	if (rdmsrl_safe(MSR_AMD_PPIN_CTL, &val))
+		goto clear_ppin;
+
+	/* PPIN is locked in disabled mode, clear feature bit */
+	if ((val & 3UL) == 1UL)
+		goto clear_ppin;
+
+	/* If PPIN is disabled, try to enable it */
+	if (!(val & 2UL)) {
+		wrmsrl_safe(MSR_AMD_PPIN_CTL,  val | 2UL);
+		rdmsrl_safe(MSR_AMD_PPIN_CTL, &val);
+	}
+
+	/* If PPIN_EN bit is 1, return from here; otherwise fall through */
+	if (val & 2UL)
+		return;
+
+clear_ppin:
+	clear_cpu_cap(c, X86_FEATURE_AMD_PPIN);
+}
+
 u16 amd_get_nb_id(int cpu)
 {
 	return per_cpu(cpu_llc_id, cpu);
@@ -941,6 +970,7 @@ static void init_amd(struct cpuinfo_x86 *c)
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

