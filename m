Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC89445BE6
	for <lists+linux-edac@lfdr.de>; Thu,  4 Nov 2021 22:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbhKDWBt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 4 Nov 2021 18:01:49 -0400
Received: from mail-bn8nam11on2042.outbound.protection.outlook.com ([40.107.236.42]:51168
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232119AbhKDWBr (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 4 Nov 2021 18:01:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahdx4TRtLQu25R+gj2UiGFBbWy91Wl4PHgW4wyNvrT+gWCpJi7FduKfqevbnaE0RTyc2gZcnIGgOrQexJLL0mByO3d6BYJLoxmxoPrAg3efZUR0eKl75BQSSCRCqnbpi7X4Wj6YYFLMMT4d1ZwNH1uneASJx9rLpwtimthZYxFb304yoS81BNfbnnsWHhTuEPk2GwXqauW4b+nRC6cZVvNFRwrJ33vcO4kOwpkTTE2IaW3OFz1hYE3be7WhP43moavSEIIZzhdR4DyaIGUirMRq33tzEobx6ugfA7sst0LXrtDjw/ISdYG8Up7NY7p4v6r657Cj89UAZmS2mroWJIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrVUwWf7iSSQ0AL7DA2jrOfRLAuP9Tntf2y7eUSS7D0=;
 b=lCzmAIagFbpFX7H9MFl/JEU2K85xQIhJLK4Sr8DeC1KpWL/VWaW+65xoCUkG5Ia4Hb1O1/1QY/Tn2z57xJCF1M4mbsVE/aG6+syZJDD33JxSnhLnlb6M48G2wMe7NzCaN8UkNhNSIeCx54okMBYcLDQleUy7m5aLjNfmyNiFHcnhsH9lCcq3AADkthu8ozjDkAMm0WSZbfqFX6BWNNU+e8QK89gULGXQAZyTgIxTFcmbUMwSWz4KEG3NxdMGT5eSgYxKSruWwa/fvu4WDffeiUg2e2BZBcrpK93IlpXG0Qj6gSMVOm+8GpoOb2dqdxgQHBABjES3gKJFQ/MNNm54Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrVUwWf7iSSQ0AL7DA2jrOfRLAuP9Tntf2y7eUSS7D0=;
 b=g7V9hYB9PKfQijhMd8m3M5PSO9+D4M+fPRE/CW5nNLjUXj4yG9WCFsNTdqqSTtKaawe5O5S3E+zGkdOl0CjJ+LB+DbKSOLiPp9shPIlgiDHTHJAlZ3YTWwMAJOA/AL1ZbIj4vi6i5NTWdjrR4buwJf/rA6mmd7vI1LBrfgOmIYM=
Received: from MWHPR17CA0050.namprd17.prod.outlook.com (2603:10b6:300:93::12)
 by MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Thu, 4 Nov
 2021 21:59:06 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:93:cafe::88) by MWHPR17CA0050.outlook.office365.com
 (2603:10b6:300:93::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Thu, 4 Nov 2021 21:59:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 21:59:06 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 16:59:04 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Tony Luck <tony.luck@intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
        <yazen.ghannam@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
        "Borislav Petkov" <bp@suse.de>
Subject: [PATCH v3 1/6] x86/mce/inject: Check if a bank is unpopulated before error injection
Date:   Thu, 4 Nov 2021 16:58:41 -0500
Message-ID: <20211104215846.254012-2-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1e098f2d-97c2-4c17-9871-08d99fde525a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:
X-Microsoft-Antispam-PRVS: <MN2PR12MB437366772DB6D8EC64B72367908D9@MN2PR12MB4373.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BJ+bJ18SusNsPK6PdOeXVosyCChq1ejaVzJm+7jfCHe16qo29DDtRqRrPDwGBBliwXmye/MWBRlfUmlB9b2oMy6JEAjEBWSonAhVL8IcdLn82FjB/1Lvac99xj0u/4Jliw18X1hT6o94S+MPqZCQ8tBzxA+JQ636NJTXRhYcPxX8ddTC+hZWLs/vvvoehbm/TM7mO3NfoEBEGXGXGW6/6jG2ARUn/ujaJqa/9htNw+T0JkqyG9vxrTrRZMn3avAbGoaz8V0kmCO8lVz1zCnkVL0we8DyYZ8jrhMm7BlWQJFLruzrl78ZompNwWIbMB5rIp/O4P+k+f99VdVffTMgn/+0MtPlg63YT4BRogMSfazdpK+NK58xhQRzaa+KTmmbsMz4lr8qWzGiflnklPz/8+OLSoX6wLg/hB7ka/TgeZc/moqaoxhUm70nAcZykZPsKBdRLR6TTLFxKvgL0kX64s3POFwsRSDTElzZUPCvRaQWBAijMG7+A7goXTSK6+S+EFDhbVugV8OxKidcADmnkgMnb+q/NSdTxk9NJYPN4tqsnQ23vv9tNtdSVC9a0eTYbuH7Pv1TRbdzpc8hNXWXS55TP4bFVPfQkXG8MkVSx+bEiHB7ngiutrW8bUIfFNpwPYEy3XSEWgvAy2vv/0xhiwI8xid+a1UPnWLaHvRj/39CkFX0G46IXxiSSzX2KUoHorPjbAyKsMI194XGoSQLfe++gVpbITaKoQXYfSootd5hsz7pprNj2jXqYACVe/BwRgjLKzTnMZv/xaWYJYdMHCKPk8cmV1QhT0lsNAIEsg452qpstYP5A/mT9+bJSj6k
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(336012)(8676002)(86362001)(26005)(426003)(8936002)(2616005)(54906003)(36860700001)(110136005)(316002)(16526019)(186003)(7696005)(47076005)(82310400003)(5660300002)(508600001)(356005)(81166007)(70586007)(6666004)(83380400001)(36756003)(70206006)(4326008)(1076003)(2906002)(15650500001)(966005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 21:59:06.0982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e098f2d-97c2-4c17-9871-08d99fde525a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4373
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The MCA_IPID register uniquely identifies a bank's type on Scalable MCA
(SMCA) systems. When an MCA bank is not populated, the MCA_IPID register
will read as zero and writes to it will be ignored.

On a hw-type error injection (injection which writes the actual MCA
registers in an attempt to cause a real MCE) check the value of this
register before trying to inject the error.

Do not impose any limitations on a sw injection and allow the user to
test out all the decoding paths without relying on the available hardware,
as its purpose is to just test the code.

 [ bp: Heavily massage. ]

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211019233641.140275-2-Smita.KoralahalliChannabasappa@amd.com
---
v2:
	simulate -> inject.
	Corrected according to kernel commenting style.
	boot_cpu_has() -> cpu_feature_enabled().
	Error simulation not possible: Bank %llu unpopulated ->
	Cannot set IPID - bank %llu unpopulated.
	Used user provided IPID value on sw injection without checking
	underlying hardware and defined it under inj_ipid_set().
v3:
	Restructure and simplify the code. For !sw injection fail the
	injection if IPID is zero and do otherwise.
---
 arch/x86/kernel/cpu/mce/inject.c | 44 +++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 0bfc14041bbb..fcec99e6c5d1 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -74,7 +74,6 @@ MCE_INJECT_SET(status);
 MCE_INJECT_SET(misc);
 MCE_INJECT_SET(addr);
 MCE_INJECT_SET(synd);
-MCE_INJECT_SET(ipid);
 
 #define MCE_INJECT_GET(reg)						\
 static int inj_##reg##_get(void *data, u64 *val)			\
@@ -95,6 +94,20 @@ DEFINE_SIMPLE_ATTRIBUTE(status_fops, inj_status_get, inj_status_set, "%llx\n");
 DEFINE_SIMPLE_ATTRIBUTE(misc_fops, inj_misc_get, inj_misc_set, "%llx\n");
 DEFINE_SIMPLE_ATTRIBUTE(addr_fops, inj_addr_get, inj_addr_set, "%llx\n");
 DEFINE_SIMPLE_ATTRIBUTE(synd_fops, inj_synd_get, inj_synd_set, "%llx\n");
+
+/* Use the user provided IPID value on a sw injection. */
+static int inj_ipid_set(void *data, u64 val)
+{
+	struct mce *m = (struct mce *)data;
+
+	if (cpu_feature_enabled(X86_FEATURE_SMCA)) {
+		if (inj_type == SW_INJ)
+			m->ipid = val;
+	}
+
+	return 0;
+}
+
 DEFINE_SIMPLE_ATTRIBUTE(ipid_fops, inj_ipid_get, inj_ipid_set, "%llx\n");
 
 static void setup_inj_struct(struct mce *m)
@@ -577,6 +590,35 @@ static int inj_bank_set(void *data, u64 val)
 	}
 
 	m->bank = val;
+
+	/*
+	 * sw-only injection allows to write arbitrary values into the MCA
+	 * registers because it tests only the decoding paths.
+	 */
+	if (inj_type == SW_INJ)
+		goto inject;
+
+	/*
+	 * Read IPID value to determine if a bank is populated on the target
+	 * CPU.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_SMCA)) {
+		u64 ipid;
+
+		if (rdmsrl_on_cpu(m->extcpu, MSR_AMD64_SMCA_MCx_IPID(val),
+				  &ipid)) {
+			pr_err("Error reading IPID on CPU%d\n", m->extcpu);
+			return -EINVAL;
+		}
+
+		if (!ipid) {
+			pr_err("Cannot inject into bank %llu - it is unpopulated\n",
+				val);
+			return -ENODEV;
+		}
+	}
+
+inject:
 	do_inject();
 
 	/* Reset injection struct */
-- 
2.17.1

