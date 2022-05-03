Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC82E517C3B
	for <lists+linux-edac@lfdr.de>; Tue,  3 May 2022 05:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbiECDcK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 2 May 2022 23:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiECDcI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 2 May 2022 23:32:08 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA9B1CFD7;
        Mon,  2 May 2022 20:28:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVvCJW2gFG65A4MN8UPMQU9cg96M/FoWrZvKjhIm6Mtf/sHUnGr5J7RM8k1aqAdEVY56oiPF6sFIaJMT30ZQMYEOgcrX5RhQJ/4dJEp6b98a/AFvoQiIyAcwsb1ox9wIFg9JiCTTykHF2VX4mO7CZYKTJD5ShyRP45l8mOO9OKmOytit2I96l8gIuS7i/A+qWUDkiwWiohT5j2lHsxxTJBkNlscgjFkAMAUo5Khsai2v04cKioejyatCLwrAgaOG+rr6pRhoujqswqeXx/tQ9TfqlVyAMFnnRb6oL1R6gFwPlB2iWT0s9Ja347vKXfB8cRu30mY+JKC3GwbKlpU7gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zT4HzeWBGI6YFO6NLSfGq/SZUJuq/ln1Vfz1suCpPBU=;
 b=Jcda1mhiTvLxj/NRJlmGX5XgDR5OoykEIDD7bAV4uAyQn0gjntArpNVA9cFb9q6Rz2gINREWTvWIHFb0po3aUFHb5g5Rst/W1wu6q4XhLqMVaV8mfSW/+dxr/qBLxYGC969eXxUG9NN2+dCjRD9x3Hz7neJ6XfcZMjsSaHPUa0pa/fvSPFOfvtmDG1awYgIP7UVb5sC84/aVqB9jYf/Sjz6Cvu1kicAZIhMesYvfdfJFguoZD/rqj9tzN47lEJU5ygwyclPPd1FXyGEOFlodH8Glje70BVPmGRhFo73eLnWVO0KAegS6pLYAZw+oz5RBfqeyDk69ziMt3KH26+g2CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zT4HzeWBGI6YFO6NLSfGq/SZUJuq/ln1Vfz1suCpPBU=;
 b=HhH9wKLuM4PksbShU/qMXqpPkugzly3k1wmVPwvrFCEXBMaf4A8k6aQ2ecem/ziosG1T3jRkba62rrHOFg0drERbH8+EckRr74aJGX02YTGCN/2KVI6ieTPg9N/opW7FgU95MhuSGAfLnyoLzjda3b5MGJby4rcw+eukhg2PwrY=
Received: from BN9PR03CA0375.namprd03.prod.outlook.com (2603:10b6:408:f7::20)
 by PH7PR12MB5877.namprd12.prod.outlook.com (2603:10b6:510:1d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 03:28:35 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::43) by BN9PR03CA0375.outlook.office365.com
 (2603:10b6:408:f7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Tue, 3 May 2022 03:28:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 03:28:34 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 2 May
 2022 22:28:33 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>
CC:     Tony Luck <tony.luck@intel.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        <hpa@zytor.com>, Yazen Ghannam <yazen.ghannam@amd.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Borislav Petkov" <bp@suse.de>
Subject: [PATCH v5 1/3] x86/mce/mce-inject: Replace struct i_mce with struct inject_desc
Date:   Mon, 2 May 2022 22:28:17 -0500
Message-ID: <20220503032820.61667-2-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220503032820.61667-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20220503032820.61667-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5250bd70-bf89-4648-10ed-08da2cb50141
X-MS-TrafficTypeDiagnostic: PH7PR12MB5877:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB5877DF2271A2D6881DBB9EEF90C09@PH7PR12MB5877.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Koc/9SFJaEUeXVoegiD0t6mn6KM/5KAeg42WZmqreAVdIdShz7srcJZ/yezADXNn8jX76X2KH1TwELJmDtmaIXM44a4cq7RCqg5U4vPm6AP7r/Ao+x8aaEZeRhFuS4gBVjBnvLKtOAXkrPRpo2AGn2L7N2cEeeFA2HWZiJORCg/3S2RoYKeJcAZYXp1bAIFzNZ/S3Tl7fXLCyaEwrFLNNzrAYoMwKulr1aeIltpqRXvewCmrJ4AYotCqJocSi/UGo/plYk5nrddk56+nnwf/Rk2GuK0nMnJYCRmpRzwGn1myFE0890BMAUHmQlpi/+Sxbf3Y0yiVnf8rWAmrxx+fSL/DzKZsNNPfHnT6jZnQpo+A6d4UPmY0zuXjQoxTOzhQuxQOZtEvr0Jxbfg1X+xv0HUxb3tgBiYdVNNdfKclE8c/G1Q6ZqhO2UyDu5HKQSrTJzO/U3rtF7EsIzNdtNRy2XEmlnu2hglrgFWNpcsdCV9eY/DGJSxAl8ZQ3XtNlu6Jq1ASWb/aGyT9AXpuWXREX+BdMvqh+rB+FDK87ZTaHSskYHd51lKbZRlU8kyT+tMVmK68QaU2L7kdbbo8NHCGbFcqdf6GfwCGwSS/cj6moZSxSddhh4mIdXy6/znjyvcJxRNjlkFHJz+JMK3zbQZegmE0uXgzSdWFj42hW0I2e6g3oPo/fCB6hXE+ajyFKqme+3moHHW3/LZIPAHR6MvWwqjuJt2hto6IaEgGc9awxC3zPkonUGBBnHt/O/4eW9DDr2a/1cPd3m7rtUmbwXiUKaFfsPi500Le1U4838BpaMHvbzU2YSV+lIzW4CUcdUCC
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(70206006)(316002)(8676002)(54906003)(82310400005)(36860700001)(70586007)(86362001)(4326008)(356005)(81166007)(966005)(336012)(186003)(426003)(1076003)(26005)(16526019)(2616005)(6666004)(7696005)(508600001)(40460700003)(83380400001)(47076005)(110136005)(2906002)(36756003)(8936002)(5660300002)(21314003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 03:28:34.7309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5250bd70-bf89-4648-10ed-08da2cb50141
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5877
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Replace the existing struct i_mce with struct inject_desc. Extend the
struct to include "error" field. This error field will be useful to
return error codes to userspace when error injection fails.

Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Link: https://lkml.kernel.org/r/Yk267A1MKOo2AlXQ@zn.tnic
---
 arch/x86/kernel/cpu/mce/inject.c | 94 ++++++++++++++++++--------------
 1 file changed, 52 insertions(+), 42 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 5fbd7ffb3233..05581b718529 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -33,10 +33,12 @@
 
 #include "internal.h"
 
-/*
- * Collect all the MCi_XXX settings
- */
-static struct mce i_mce;
+/* Collect all the MCi_XXX settings */
+static struct inject_desc {
+	struct mce m;
+	int err;
+} inj_desc;
+
 static struct dentry *dfs_inj;
 
 #define MAX_FLAG_OPT_SIZE	4
@@ -110,9 +112,11 @@ static int inj_ipid_set(void *data, u64 val)
 
 DEFINE_SIMPLE_ATTRIBUTE(ipid_fops, inj_ipid_get, inj_ipid_set, "%llx\n");
 
-static void setup_inj_struct(struct mce *m)
+static void setup_inj_struct(void)
 {
-	memset(m, 0, sizeof(struct mce));
+	struct mce *m = &inj_desc.m;
+
+	memset(&inj_desc, 0, sizeof(struct inject_desc));
 
 	m->cpuvendor = boot_cpu_data.x86_vendor;
 	m->time	     = ktime_get_real_seconds();
@@ -470,56 +474,57 @@ static void toggle_nb_mca_mst_cpu(u16 nid)
 		       __func__, PCI_FUNC(F3->devfn), NBCFG);
 }
 
-static void prepare_msrs(void *info)
+static void prepare_msrs(void *unused)
 {
-	struct mce m = *(struct mce *)info;
-	u8 b = m.bank;
+	struct mce *m = &inj_desc.m;
+	u8 b = inj_desc.m.bank;
 
-	wrmsrl(MSR_IA32_MCG_STATUS, m.mcgstatus);
+	wrmsrl(MSR_IA32_MCG_STATUS, m->mcgstatus);
 
 	if (boot_cpu_has(X86_FEATURE_SMCA)) {
-		if (m.inject_flags == DFR_INT_INJ) {
-			wrmsrl(MSR_AMD64_SMCA_MCx_DESTAT(b), m.status);
-			wrmsrl(MSR_AMD64_SMCA_MCx_DEADDR(b), m.addr);
+		if (m->inject_flags == DFR_INT_INJ) {
+			wrmsrl(MSR_AMD64_SMCA_MCx_DESTAT(b), m->status);
+			wrmsrl(MSR_AMD64_SMCA_MCx_DEADDR(b), m->addr);
 		} else {
-			wrmsrl(MSR_AMD64_SMCA_MCx_STATUS(b), m.status);
-			wrmsrl(MSR_AMD64_SMCA_MCx_ADDR(b), m.addr);
+			wrmsrl(MSR_AMD64_SMCA_MCx_STATUS(b), m->status);
+			wrmsrl(MSR_AMD64_SMCA_MCx_ADDR(b), m->addr);
 		}
 
-		wrmsrl(MSR_AMD64_SMCA_MCx_MISC(b), m.misc);
-		wrmsrl(MSR_AMD64_SMCA_MCx_SYND(b), m.synd);
+		wrmsrl(MSR_AMD64_SMCA_MCx_MISC(b), m->misc);
+		wrmsrl(MSR_AMD64_SMCA_MCx_SYND(b), m->synd);
 	} else {
-		wrmsrl(MSR_IA32_MCx_STATUS(b), m.status);
-		wrmsrl(MSR_IA32_MCx_ADDR(b), m.addr);
-		wrmsrl(MSR_IA32_MCx_MISC(b), m.misc);
+		wrmsrl(MSR_IA32_MCx_STATUS(b), m->status);
+		wrmsrl(MSR_IA32_MCx_ADDR(b), m->addr);
+		wrmsrl(MSR_IA32_MCx_MISC(b), m->misc);
 	}
 }
 
-static void do_inject(void)
+static int do_inject(void)
 {
+	struct mce *m = &inj_desc.m;
+	unsigned int cpu = m->extcpu;
 	u64 mcg_status = 0;
-	unsigned int cpu = i_mce.extcpu;
-	u8 b = i_mce.bank;
+	u8 b = m->bank;
 
-	i_mce.tsc = rdtsc_ordered();
+	m->tsc = rdtsc_ordered();
 
-	i_mce.status |= MCI_STATUS_VAL;
+	m->status |= MCI_STATUS_VAL;
 
-	if (i_mce.misc)
-		i_mce.status |= MCI_STATUS_MISCV;
+	if (m->misc)
+		m->status |= MCI_STATUS_MISCV;
 
-	if (i_mce.synd)
-		i_mce.status |= MCI_STATUS_SYNDV;
+	if (m->synd)
+		m->status |= MCI_STATUS_SYNDV;
 
 	if (inj_type == SW_INJ) {
-		mce_log(&i_mce);
-		return;
+		mce_log(m);
+		return 0;
 	}
 
 	/* prep MCE global settings for the injection */
 	mcg_status = MCG_STATUS_MCIP | MCG_STATUS_EIPV;
 
-	if (!(i_mce.status & MCI_STATUS_PCC))
+	if (!(m->status & MCI_STATUS_PCC))
 		mcg_status |= MCG_STATUS_RIPV;
 
 	/*
@@ -528,8 +533,8 @@ static void do_inject(void)
 	 * - MCx_STATUS[UC] cleared: deferred errors are _not_ UC
 	 */
 	if (inj_type == DFR_INT_INJ) {
-		i_mce.status |= MCI_STATUS_DEFERRED;
-		i_mce.status &= ~MCI_STATUS_UC;
+		m->status |= MCI_STATUS_DEFERRED;
+		m->status &= ~MCI_STATUS_UC;
 	}
 
 	/*
@@ -550,12 +555,15 @@ static void do_inject(void)
 
 	toggle_hw_mce_inject(cpu, true);
 
-	i_mce.mcgstatus = mcg_status;
-	i_mce.inject_flags = inj_type;
-	smp_call_function_single(cpu, prepare_msrs, &i_mce, 0);
+	m->mcgstatus = mcg_status;
+	m->inject_flags = inj_type;
+	smp_call_function_single(cpu, prepare_msrs, NULL, 0);
 
 	toggle_hw_mce_inject(cpu, false);
 
+	if (inj_desc.err)
+		goto err;
+
 	switch (inj_type) {
 	case DFR_INT_INJ:
 		smp_call_function_single(cpu, trigger_dfr_int, NULL, 0);
@@ -570,6 +578,7 @@ static void do_inject(void)
 err:
 	cpus_read_unlock();
 
+	return inj_desc.err;
 }
 
 /*
@@ -580,6 +589,7 @@ static int inj_bank_set(void *data, u64 val)
 {
 	struct mce *m = (struct mce *)data;
 	u8 n_banks;
+	int err;
 	u64 cap;
 
 	/* Get bank count on target CPU so we can handle non-uniform values. */
@@ -619,12 +629,12 @@ static int inj_bank_set(void *data, u64 val)
 	}
 
 inject:
-	do_inject();
+	err = do_inject();
 
 	/* Reset injection struct */
-	setup_inj_struct(&i_mce);
+	setup_inj_struct();
 
-	return 0;
+	return err;
 }
 
 MCE_INJECT_GET(bank);
@@ -714,7 +724,7 @@ static void __init debugfs_init(void)
 
 	for (i = 0; i < ARRAY_SIZE(dfs_fls); i++)
 		debugfs_create_file(dfs_fls[i].name, dfs_fls[i].perm, dfs_inj,
-				    &i_mce, dfs_fls[i].fops);
+				    &inj_desc.m, dfs_fls[i].fops);
 }
 
 static int __init inject_init(void)
@@ -727,7 +737,7 @@ static int __init inject_init(void)
 	register_nmi_handler(NMI_LOCAL, mce_raise_notify, 0, "mce_notify");
 	mce_register_injector_chain(&inject_nb);
 
-	setup_inj_struct(&i_mce);
+	setup_inj_struct();
 
 	pr_info("Machine check injector initialized\n");
 
-- 
2.17.1

