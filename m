Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1635445BE9
	for <lists+linux-edac@lfdr.de>; Thu,  4 Nov 2021 22:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbhKDWBu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 4 Nov 2021 18:01:50 -0400
Received: from mail-dm6nam08on2071.outbound.protection.outlook.com ([40.107.102.71]:23520
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232262AbhKDWBt (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 4 Nov 2021 18:01:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+5h+M/ALpbAu6GBS5SYn7ckOEzucwZNn1Nsr2L81Gjn/F49GaI2cdJdmp0SFiIiig/qDwx02ZfTcUHTjEv2Qd4OgKJjpHW68i+gt8WTb25fbh79tIPFpsqUWDv8pKIDf8MsoTAnhDan0ojunGpeXbqLdnH2GnSB+c1vFnI0ltxICwLU5TjplCjJTykb2s3Ul06vLe7wAFM5HqFeJx0jbRiaZJsDzNGdmbSoa3EzhAr9d+k3QxvbKtSALD8looYXdOkwkWwFpkheonS7IBkQOsc5+oPYXMlGCo7R2Z0G6fHZuaEx15Q1YOiAmdzS6gPglB8MoBOM+1BytfIulEJYYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3aKDAV7C+ovHsWguDHQL6RVvGC54umTbqtqlKja3u9g=;
 b=AKkVMOT1pF9x0vEquFXXFjYuf+vUo3hXQlYcFps41V80Dh/hL02SsDVMOwg1s8JnS+TQXenWFDSPONJwWzMw3UaW1uM+9E9lunnsQJxiwXLQMR5YXHpjbuN816MBBaYeFBtIi+l1GN/FPIUFNbAtVULQf5S7VLkgL6qcW898+IEjstHO1vQcXzgMZ1q47aSDzxoLLciD/COXcMKM3lrc0SATdW7623Wdi09tw4Rf3biTxudrxOe0eEThh+Fe7s1RS1xUose4CMdGGu/fSAZY4MnZBmnna48LzG7E37tb+2nDm2K6Gr6PzKmkK+tphr0FF/OVdv+S/CyntHGernMw/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3aKDAV7C+ovHsWguDHQL6RVvGC54umTbqtqlKja3u9g=;
 b=4Jg4U+7esP9/k/LSebIJWdgQmcKwc/RfUhKtxn05Ttw4GwmuX5/gxdYQk2/dATOizSmZq4ZDYdjvhF+nOTxP0ffHiNK0vn1W9SZLRoRCJ0xarXP/IqwB/e61mBRcVqNycpjvcHOnlxfZn1K5o4F2+2HmkCIVdVJxyOzJ+SpTZtQ=
Received: from MW4PR04CA0190.namprd04.prod.outlook.com (2603:10b6:303:86::15)
 by DM6PR12MB4563.namprd12.prod.outlook.com (2603:10b6:5:28e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Thu, 4 Nov
 2021 21:59:09 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::e8) by MW4PR04CA0190.outlook.office365.com
 (2603:10b6:303:86::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Thu, 4 Nov 2021 21:59:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 21:59:09 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 16:59:07 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Tony Luck <tony.luck@intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
        <yazen.ghannam@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v3 3/6] x86/mce/inject: Check for writes ignored in status registers
Date:   Thu, 4 Nov 2021 16:58:43 -0500
Message-ID: <20211104215846.254012-4-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211104215846.254012-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20211104215846.254012-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e2aa9e4-1b83-4989-ca83-08d99fde5438
X-MS-TrafficTypeDiagnostic: DM6PR12MB4563:
X-Microsoft-Antispam-PRVS: <DM6PR12MB45635EBC414A3AC34B72BAF1908D9@DM6PR12MB4563.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U6jlnduAVINh/bXjicUGuuq7QkYwyrazjmIb4Dn+Vpbs97KyQ1XClAewPktrndVNtnAQ+aQoP1g5JF/HLxqMnXbSRjh08xb4ar8X3TnJaapZSubur7r/aad1lNltX/qwvmwpxoCtG6LWUi+RdBAsI3NJCV3DUMDcEaE3m/YDoVGvioMUiVOQpIw/hR9KIqix4t3tNIK/3OceKVTYuVz9tNBzmrq0Y6H1IrmAdlANYoxG5dcs+npAhSgBA+YAR7iWusiYCE2ZjlJpTePhtyYevE17ghw9YnTeSVhmziOPOul0Sna3DjidSpEznI2aFnNMRbmr1bLnG9fygoVCSCI9GxKDXe++bYSQY+/zN9/RkzyQoLoHjBmYqon58VsQD2uC7XTcYfn70UGbp4kYM50cSVlcKjp4FGUQftn2+fC4bPPmZsJR4+Y9+KRNuL8yCHeHeSWnYi0UKtq5WfbxmYtZ5VvltnsQDuqvVtWRH9ACs9Ywce+Et+ns2TGBoNUUFmCpzpsjrzBOUcL2ZxicqGWKO76z3CSzdBCAuqmeLz7g8R+yvZ9lRXyD/7wDk4s6M146m+gIa5O/lvO4Wi2TOgwObONUSrYy/X8IVzo4QR/4XecDmgE4DsemQpihJaQCWcke0Yf4bALoID5H3UL4OiM3BUSSy9kmpekTTbMhC8xMNKR/Shi0kTPFjzb8icIzEvdTR/B5ETQDP5rZ0szjslQsKC81/D+4eRTq4ICWUprz8HUuAnSp+0loL8xx+MxQEI44CBZLPihMsUmib083DfoaspQgV38Qk1casyB8nezfT1gtyHjb7oJdNaMxIMsW+tFjpI6J/n9K1kkamAmq3SNkY0bj1chBZwVFj+hA9i0GJdI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(5660300002)(356005)(186003)(8936002)(110136005)(83380400001)(426003)(81166007)(2616005)(16526019)(26005)(82310400003)(966005)(36756003)(316002)(508600001)(1076003)(54906003)(70206006)(4326008)(8676002)(36860700001)(336012)(2906002)(47076005)(6666004)(7696005)(86362001)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 21:59:09.2310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e2aa9e4-1b83-4989-ca83-08d99fde5438
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4563
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

According to Section 2.1.16.3 under HWCR[McStatusWrEn] in "PPR for AMD
Family 19h, Model 01h, Revision B1 Processors - 55898 Rev 0.35 - Feb 5,
2021", the status register may sometimes enforce write ignored behavior
independent of the value of HWCR[McStatusWrEn] depending on the platform
settings.

Hence, evaluate for writes ignored for MCA_STATUS and MCA_DESTAT
separately, before doing error injection. If true, return with an error
code.

Deferred errors on an SMCA platform use different MSR for MCA_DESTAT.
Hence, evaluate MCA_DESTAT instead of MCA_STATUS on deferred errors, and
do not modify the existing value in MCA_STATUS by writing and reading from
it.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Link: https://lkml.kernel.org/r/20211019233641.140275-5-Smita.KoralahalliChannabasappa@amd.com
---
v2:
	msr_ops -> mca_msr_reg().
	simulation -> injection.
	pr_info() -> pr_err().
	Aligned on ",".
v3:
	Removed "x86/mce: Use mca_msr_reg() in prepare_msrs()" patch
	and made changes on the existing MCx_{STATUS, ADDR, MISC} macros.
---
 arch/x86/kernel/cpu/mce/inject.c | 35 ++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 5e83a1ce7ac8..4d5689342384 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -470,9 +470,17 @@ static void toggle_nb_mca_mst_cpu(u16 nid)
 		       __func__, PCI_FUNC(F3->devfn), NBCFG);
 }
 
+struct mce_err_handler {
+	struct mce *mce;
+	int err;
+};
+
+static struct mce_err_handler mce_err;
+
 static void prepare_msrs(void *info)
 {
-	struct mce m = *(struct mce *)info;
+	struct mce_err_handler *i_mce_err = ((struct mce_err_handler *)info);
+	struct mce m = *i_mce_err->mce;
 	u8 b = m.bank;
 
 	wrmsrl(MSR_IA32_MCG_STATUS, m.mcgstatus);
@@ -480,9 +488,17 @@ static void prepare_msrs(void *info)
 	if (boot_cpu_has(X86_FEATURE_SMCA)) {
 		if (m.inject_flags == DFR_INT_INJ) {
 			wrmsrl(MSR_AMD64_SMCA_MCx_DESTAT(b), m.status);
+			rdmsrl(MSR_AMD64_SMCA_MCx_DESTAT(b), m.status);
+			if (!m.status)
+				goto out;
+
 			wrmsrl(MSR_AMD64_SMCA_MCx_DEADDR(b), m.addr);
 		} else {
 			wrmsrl(MSR_AMD64_SMCA_MCx_STATUS(b), m.status);
+			rdmsrl(MSR_AMD64_SMCA_MCx_STATUS(b), m.status);
+			if (!m.status)
+				goto out;
+
 			wrmsrl(MSR_AMD64_SMCA_MCx_ADDR(b), m.addr);
 		}
 
@@ -490,9 +506,18 @@ static void prepare_msrs(void *info)
 		wrmsrl(MSR_AMD64_SMCA_MCx_SYND(b), m.synd);
 	} else {
 		wrmsrl(MSR_IA32_MCx_STATUS(b), m.status);
+		rdmsrl(MSR_IA32_MCx_STATUS(b), m.status);
+		if (!m.status)
+			goto out;
+
 		wrmsrl(MSR_IA32_MCx_ADDR(b), m.addr);
 		wrmsrl(MSR_IA32_MCx_MISC(b), m.misc);
 	}
+
+out:
+	pr_err("Error injection is not available\n");
+	i_mce_err->err = -EINVAL;
+	return;
 }
 
 static void do_inject(void)
@@ -501,6 +526,9 @@ static void do_inject(void)
 	unsigned int cpu = i_mce.extcpu;
 	u8 b = i_mce.bank;
 
+	mce_err.mce = &i_mce;
+	mce_err.err = 0;
+
 	i_mce.tsc = rdtsc_ordered();
 
 	i_mce.status |= MCI_STATUS_VAL;
@@ -552,10 +580,13 @@ static void do_inject(void)
 
 	i_mce.mcgstatus = mcg_status;
 	i_mce.inject_flags = inj_type;
-	smp_call_function_single(cpu, prepare_msrs, &i_mce, 0);
+	smp_call_function_single(cpu, prepare_msrs, &mce_err, 0);
 
 	toggle_hw_mce_inject(cpu, false);
 
+	if (mce_err.err)
+		goto err;
+
 	switch (inj_type) {
 	case DFR_INT_INJ:
 		smp_call_function_single(cpu, trigger_dfr_int, NULL, 0);
-- 
2.17.1

