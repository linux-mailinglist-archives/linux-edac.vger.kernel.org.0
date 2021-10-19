Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE2743422C
	for <lists+linux-edac@lfdr.de>; Wed, 20 Oct 2021 01:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhJSXjh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 19 Oct 2021 19:39:37 -0400
Received: from mail-mw2nam10on2040.outbound.protection.outlook.com ([40.107.94.40]:2017
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230070AbhJSXjd (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 19 Oct 2021 19:39:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERaYm6Raps88EPvAwZSeTrfBGdF6VOzg8yA1ONKHoRPqbNQkckK31+bbC2fMYMrOxihkSHh6Zb+XlFd1qjZTGB7SF3BTvwb7Y8Qi+4oELJUOR2F1mse/3dsLk+EiotX18Lkhq5/tjFTOZw3lM5N1lLbmyca2Q3ZsB/K3PR4iHM6FnrSmojn1IQrKqkbcOts8Rvl2XpJsTbc8xmFKq2uRb0f2BXKU8FjNzOdAA3TXnfF5u8EGvibEQ39HEApI/7AKLDtXa6Fn6Ipx7BNX8Z6cF1HHeibnZciR4jX3DNgoafb4wfa+aEEPywXI3i2gFWyCX1fx9pNvDGHRO4JPkGnqig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXphWJ19pEMHM3URayZ3YAvOqjE1u2Nobu3UpGIv9/c=;
 b=mRjNUY/Q1NDe2qSvfZlpXA49UzjHpk/zOi41O/ZhjJBLNZlV5rMd+JFnVX9t383YFZ9wnlYKirjwRoyFZrFcaO8vUN5exSrMF+NftePCS623Fk8P5TIdsRxVx/EDoiQ1l6ldrguNaqgnNncfYsTw604AN8yOtgqKYieM867x5T40kj3OLIbrLV27HXrXEFZAa1hAbNsJD9DPeDe07pBy18UVcCbuEXHtxa7P5Yx/JQ24+Ejsfa2dK865ktiV4atvnuNYQjsgyii4eWXsDB+pj3DqbRGm90b6FFZraqwGOombpxnF7oZuTXlVfWiGrWJF5ZVo2zhgksM6vNSkej+rVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXphWJ19pEMHM3URayZ3YAvOqjE1u2Nobu3UpGIv9/c=;
 b=ykZ6OyNwAUdjQ0DQHS52kuP9X3aC4ZTWJG1hZxkzciQ4DLiEzmweYMgMBu5kGAAauLddQ/KyH5NxgtzJqbf91KQFgrXgxYz0+CKu3keNgmVoeCoUhmEHoVIEPM91Owetd5ZMeQUnTgCJLHHkQqImo2bc5Sx1XHU6iKYIyfoaDJg=
Received: from DM6PR04CA0027.namprd04.prod.outlook.com (2603:10b6:5:334::32)
 by MWHPR1201MB0160.namprd12.prod.outlook.com (2603:10b6:301:50::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 23:37:10 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::35) by DM6PR04CA0027.outlook.office365.com
 (2603:10b6:5:334::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Tue, 19 Oct 2021 23:37:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Tue, 19 Oct 2021 23:37:10 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 19 Oct
 2021 18:37:08 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Tony Luck <tony.luck@intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
        <yazen.ghannam@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v2 4/5] x86/mce/inject: Check for writes ignored in status registers
Date:   Tue, 19 Oct 2021 18:36:40 -0500
Message-ID: <20211019233641.140275-5-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211019233641.140275-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20211019233641.140275-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c85b104-b289-40ed-1b98-08d993595ed2
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0160:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0160EA30489819FB30F1B06690BD9@MWHPR1201MB0160.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9BzVFaeSoJol0hs4t8toKfUPklINJ5UXZvZJCe6zyv0qRuhHTr75kN3Go6mGoUPceWl1MfF4ODpJOX94xgLnfMXQBUjt0DKeZ1LGOt5v91rOYnaBORhZu3xa1jt2Ikf+3bL77ioSs4e5fi0aR3WrcnCaiVgF6EzhyfeeDpjsjIk0qLj5LPO1xWq242Dol1UbpgZv930v15ccXbS2C1ynJWCjjHGGqTldnwzH/p+xDShIpDIK8PcqYSiAmnPQL73/HRIHauOrhG4lJo8iX0S3/XBidGQvKwHYPr5n6gWrnOR4pz34NLz1M75kZPoaOHOLyKlMi/TDwsME7bkq0nnpIlzyTt31QtYnLagGca/v6ExNV2MDid2YX5jTUS5DLZFH3Lk7IUqXIdxVtVR6szbZtgSvRd8fHHZnNQseP7MNI1qID+vhpmnMuOFppgzvT0v3ilQaR1n8KUp7SVrOaoWDh9EzFI/7mgH9N1rnkmq3jZRO/XiYkIsKNi2Ao5MESQofdAaWbIXeguo4L3DYDhMhHLrLWZhEDbyRnUIKhn6g0b7FcbNiJlsWmnrfm1VQP1BtL6YE96+q+QgIjecdNCo7pKdIxm7rH9+QqGUte215B9XmGvns8XP93B/7fqNIff3sS5mgBAFw+sRhY+m3UjhTsHpdm6FhD5w6ModCgtWJgASKilY/m2ODq4qkI1N6m4B/8vy180xKyCRf7fJRVMKWSxJgz0uHHt6/AFq/p9c2akHJkmg7awR1fB70cZ7VozTBCKGKVCreWBtt9RJ/hKuwJfigH8w/yxtFO7+CbaJhH5wIRhT99BcgPbk7IAC5b/YV
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(36860700001)(26005)(82310400003)(6666004)(186003)(16526019)(7696005)(70206006)(5660300002)(70586007)(110136005)(86362001)(4326008)(316002)(54906003)(2906002)(508600001)(426003)(8676002)(81166007)(2616005)(83380400001)(8936002)(47076005)(356005)(1076003)(336012)(966005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 23:37:10.0716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c85b104-b289-40ed-1b98-08d993595ed2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0160
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

Rearrange the calls and write to registers MCx_{ADDR, MISC, SYND} and
MCG_STATUS only if error injection is available.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
v2:
	msr_ops -> mca_msr_reg().
	simulation -> injection.
	pr_info() -> pr_err().
	Aligned on "=".
---
 arch/x86/kernel/cpu/mce/inject.c | 39 ++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 40d0bebe0cd2..72d29d26e033 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -454,24 +454,39 @@ static void toggle_nb_mca_mst_cpu(u16 nid)
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
 
-	wrmsrl(MSR_IA32_MCG_STATUS, m.mcgstatus);
+	u32 status_reg = mca_msr_reg(b, MCA_STATUS);
+	u32 addr_reg   = mca_msr_reg(b, MCA_ADDR);
 
 	if (boot_cpu_has(X86_FEATURE_SMCA) &&
 	    m.inject_flags == DFR_INT_INJ) {
-		wrmsrl(MSR_AMD64_SMCA_MCx_DESTAT(b), m.status);
-		wrmsrl(MSR_AMD64_SMCA_MCx_DEADDR(b), m.addr);
-		goto out;
+		status_reg = MSR_AMD64_SMCA_MCx_DESTAT(b);
+		addr_reg   = MSR_AMD64_SMCA_MCx_DEADDR(b);
 	}
 
-	wrmsrl(mca_msr_reg(b, MCA_STATUS), m.status);
-	wrmsrl(mca_msr_reg(b, MCA_ADDR), m.addr);
+	wrmsrl(status_reg, m.status);
+	rdmsrl(status_reg, m.status);
+
+	if (!m.status) {
+		pr_err("Error injection is not available\n");
+		i_mce_err->err = -EINVAL;
+		return;
+	}
 
-out:
+	wrmsrl(MSR_IA32_MCG_STATUS, m.mcgstatus);
+	wrmsrl(addr_reg, m.addr);
 	wrmsrl(mca_msr_reg(b, MCA_MISC), m.misc);
 
 	if (boot_cpu_has(X86_FEATURE_SMCA))
@@ -484,6 +499,9 @@ static void do_inject(void)
 	unsigned int cpu = i_mce.extcpu;
 	u8 b = i_mce.bank;
 
+	mce_err.mce = &i_mce;
+	mce_err.err = 0;
+
 	i_mce.tsc = rdtsc_ordered();
 
 	if (!(i_mce.status & MCI_STATUS_VAL))
@@ -536,10 +554,13 @@ static void do_inject(void)
 
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

