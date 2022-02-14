Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA764B5E52
	for <lists+linux-edac@lfdr.de>; Tue, 15 Feb 2022 00:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiBNXhG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 14 Feb 2022 18:37:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiBNXhG (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 14 Feb 2022 18:37:06 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283DC113AFE;
        Mon, 14 Feb 2022 15:36:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7pkjlV47eJ+8/gBvYre2g/8BJ7KUHELIWNqHehs4YzYx3nE/KSENdMjaNNaW+JUeMAg7rdCwRoZArPUJ7eOJmbGYhQBiDXHbzUHG1cZErUOfR5Vlg0XBJAF8QadMGcLw8ZSAztkbJDd0QXIQNPfxYeAkl3TCkF+9sk9BhJm8cQseXD+KcD8qOWXcAxpXnW3lC153SVPdrRSuDoZ5hxSZ9NhI58pgzpaYTxqnQGScJf5JiTI1M7k3Hg/v7GkgHA5mPt/wegBMY8rssLdHQbcLYt7bzJvbzT9IGD2FYvmH7ZO1lOx4/ARZ5ztpgGox6M+13u/9PqBdXF+lTdz2syKJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ceHDSfeXjqKbETz5i5+GYe7HrE8rzNltPqJlKB/Yu8g=;
 b=RfUsMgXM9oz9DyzibMkR9mZuOUt32Op7XqcIcEgcOi3YrycmxX5qjWKMFQ1ze5eyAPMR9Ur4htTa504wwLm+DNyMopi/mryPo7GTtopjlEfm3K6//e5TfIREImY6fhb7UfHIFWKdfLAD1JtGjRjxXT/SS58CI9V5XCc2m22f1rSZC+sjerNmo/rhzVvSUZUHxeHOXXfb8SX1zMX2oH/hWlyoMtxvUraODVfmYIRiuLYvYDHGax2yBLFdfQ+roaiav1nYr+0fQvAUMrVlSu2Ho6u1DPPZaVkCbTmFNDBsrhvwzkitjqiXt0UIRbTrismx4LuHZ/Pe02XTpuSIXdkJ4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ceHDSfeXjqKbETz5i5+GYe7HrE8rzNltPqJlKB/Yu8g=;
 b=DmR+LVTi+bVdSg0kiokJdmE5kHiu1yn+aDAm2gXXc1q0IZk4A5H367tTQ8HGsWQAQT1QchzAD0N5rXbQkg4QVZ4XY3WQLghiNuRacQa/W3sCiRKgcleqf99HQJL5nTiaOdxHNkYWGrUiTJTy1cPBIKAqZGF0x5o78vX13TCgToM=
Received: from MWHPR13CA0017.namprd13.prod.outlook.com (2603:10b6:300:16::27)
 by CH2PR12MB4970.namprd12.prod.outlook.com (2603:10b6:610:67::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Mon, 14 Feb
 2022 23:36:55 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:16:cafe::91) by MWHPR13CA0017.outlook.office365.com
 (2603:10b6:300:16::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.6 via Frontend
 Transport; Mon, 14 Feb 2022 23:36:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Mon, 14 Feb 2022 23:36:54 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 14 Feb
 2022 17:36:54 -0600
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Tony Luck <tony.luck@intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
        "Yazen Ghannam" <yazen.ghannam@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v4 1/2] x86/mce: Check for writes ignored in MCA_STATUS register
Date:   Mon, 14 Feb 2022 17:36:39 -0600
Message-ID: <20220214233640.70510-2-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220214233640.70510-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20220214233640.70510-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 692f7fd8-d758-407d-ef21-08d9f012e292
X-MS-TrafficTypeDiagnostic: CH2PR12MB4970:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4970C66E0E6FCA7A7868493990339@CH2PR12MB4970.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ct2XHt2Aqhtq7dYn/iKwtOEKzDdCb6UdZPF3ECUaIvmAhBomq50Ld5F44TQ4iu8eHHE+AZF7K5k1pMxPo5ybke+t9RnnIZiIrj/LlXcuavC+xujeKHPrpYX8C8X43GIADkK7+7BdjxE2yLcIIegAEBMmJwh8/HIeOZ3otGvIAEtFp1AQCzSGOM8n3jekUk/Gm6ZIfyiNrZAwKMmjmRo5ZuMaJMsWDL3hyDpobcI6G8B/pHWTjT2ucAlsdbqElwGiBQeL2rJigcyKK/f5N6LSvMBpQQLI/6KsAm3awaBL6qHh7GXpd3+txIa0byeOoga+iZwuIsujj2gin7p42cefdVo8skzqu6BtxC2Tq66L8HW9vVVei8Hx0KmB1TtX4QgZ/kOTMJ2pofnBM7uPS/XjACezVtRV64v3i1IB0PS76rRtRruBikCqPfwPo6ACF6QV+elt650rOPDcgSitbL52HHddM5rZ4jxFNXE6t2s6vyITZ3dkmEGi1dBudkp5yAxeSZozWBpvDP1/uQksi2eQF3pHvkK+IKSul9l+fXDUmOyaTr5JY2+5f3bfh4cDjGuBvE1T1J+SXvHpBCFuz6eHh1TIztSWIFKL1RD75WsWMX2I+aRCme6a9ku2i1roLAtGZW5d9BK9+aE5/ugaNIGyH7sQJCC4b7/TvRqTjHFBsqiUrMVahC5GbOg65JAOGvuSr5Z3MKjlSyt+eWX5kFPmIz62MBKm7D5i3d4aVzh8MdZ+kO74d7yKYzwkEYHFqZhMAc8yp4tDKCYChG2o6MKHeRS9s+MGJzp9/ov2xqafeIbyzBo7eor+HsIoFzlRPfUk1BBgZK96201awmNai4Tbcw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(40460700003)(86362001)(110136005)(8936002)(54906003)(966005)(316002)(4326008)(8676002)(70586007)(70206006)(36756003)(5660300002)(356005)(81166007)(6666004)(2906002)(83380400001)(7696005)(2616005)(508600001)(36860700001)(82310400004)(47076005)(1076003)(26005)(16526019)(186003)(426003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 23:36:54.8806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 692f7fd8-d758-407d-ef21-08d9f012e292
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4970
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

According to Section 2.1.16.3 under HWCR[McStatusWrEn] in "PPR for AMD
Family 19h, Model 01h, Revision B1 Processors - 55898 Rev 0.35 - Feb 5,
2021", the status register may sometimes enforce write ignored behavior
independent of the value of HWCR[McStatusWrEn] depending on the platform
settings.

Hence, evaluate for writes ignored for MCA_STATUS before doing error
injection. If true, return the appropriate error code to userspace.

Make mca_msr_reg exportable in order to be accessible from mce-inject
module.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20211104215846.254012-1-Smita.KoralahalliChannabasappa@amd.com

v2:
	msr_ops -> mca_msr_reg().
	simulation -> injection.
	pr_info() -> pr_err().
	Aligned on ",".
v3:
	Removed "x86/mce: Use mca_msr_reg() in prepare_msrs()" patch.
	and made changes on the existing MCx_{STATUS, ADDR, MISC} macros.
v4:
	Simplified the code by just checking for writes ignored behavior in
	MCA_STATUS register.
	Introduced prepare_mca_status() and performed writes ignored checks
	inside the function.
	Rephrased error message.
---
 arch/x86/kernel/cpu/mce/core.c   |  1 +
 arch/x86/kernel/cpu/mce/inject.c | 37 +++++++++++++++++++++++++++++---
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 4f1e825033ce..4ddad8082989 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -188,6 +188,7 @@ u32 mca_msr_reg(int bank, enum mca_msr reg)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mca_msr_reg);
 
 static void __print_mce(struct mce *m)
 {
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 5fbd7ffb3233..43ba63b7dc73 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -470,11 +470,36 @@ static void toggle_nb_mca_mst_cpu(u16 nid)
 		       __func__, PCI_FUNC(F3->devfn), NBCFG);
 }
 
+struct mce_err_handler {
+	struct mce *mce;
+	int err;
+};
+
+static struct mce_err_handler mce_err;
+
+static bool prepare_mca_status(struct mce *m)
+{
+	u32 status_reg = mca_msr_reg(m->bank, MCA_STATUS);
+	u64 status_val = m->status;
+
+	wrmsrl(status_reg, status_val);
+	rdmsrl(status_reg, status_val);
+
+	return status_val;
+}
+
 static void prepare_msrs(void *info)
 {
-	struct mce m = *(struct mce *)info;
+	struct mce_err_handler *i_mce_err = ((struct mce_err_handler *)info);
+	struct mce m = *i_mce_err->mce;
 	u8 b = m.bank;
 
+	if (!prepare_mca_status(&m)) {
+		pr_err("Platform does not allow error injection, try using APEI EINJ instead.\n");
+		i_mce_err->err = -EINVAL;
+		return;
+	}
+
 	wrmsrl(MSR_IA32_MCG_STATUS, m.mcgstatus);
 
 	if (boot_cpu_has(X86_FEATURE_SMCA)) {
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
@@ -624,7 +655,7 @@ static int inj_bank_set(void *data, u64 val)
 	/* Reset injection struct */
 	setup_inj_struct(&i_mce);
 
-	return 0;
+	return mce_err.err;
 }
 
 MCE_INJECT_GET(bank);
-- 
2.17.1

