Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A74517C43
	for <lists+linux-edac@lfdr.de>; Tue,  3 May 2022 05:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbiECDcJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 2 May 2022 23:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiECDcI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 2 May 2022 23:32:08 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282401CFDD;
        Mon,  2 May 2022 20:28:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4oPObwVW4qxPHJQk1Iy3nfW0t/XdfzQ9ATFnkbm2765jkL5+fpOQOFuiJeQllYDbjp7CLv1CWrzsspk7GRlJCxObFV0aFCX6ylC+RRY3WgqtJ8sdBj4sUYp2GD9auD/RhdU9fvKBO08ey8cMx9NVGFHVdhOW3jr+d3n2lHn4ky3xfLwLreZjHAyhmXrGMOZhynj52iPf4uZ4PjZ3KpZ/MS6kRfX7nBUc1qS+2poUn16q9eOYd+3rA6vKzh4H5xKmYG0SZQwjv/r/YhUQ733OHX8twxstNLkkycESUxnXc/z/MVSfPL1k5y2FXTUx0IeYE11rrqLByc+V/xKOrJdow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VuXLU5yLJ0gmiIr00Sxe5RW0ouoQ0lTISqt4R9oYeoU=;
 b=Nh20awRRF0biyMrtxk1BVVCsePLitKI+nbSWoHK5eAtYViF7BVvkCbyCCe76F8F6iSxoj620bPJBfP2pGpMB0JYcPyxm/DVOQf0aW39hUHMkJOvoaDjXCWDQuYRq05L17Qrv2BxGxVKts1kwyLFFnpllNSytxtgm1Iowy4bWacAuQejkwlwI6b03pceY+SybrJmayzmw9JzvDebeC4bW0aZrspp1sp20bVeUN+Fv0z1wW9Q0dw2gDJN49kuoIO59Qv5QwAFF6gHiyHXixXlpVjtOcF+CAacS+UiL6doC35n+93zWBmlBw8xFzLHWzbiLFjXQzLmsgcwXh5YP+LhjDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuXLU5yLJ0gmiIr00Sxe5RW0ouoQ0lTISqt4R9oYeoU=;
 b=5XeFtRol6zkq6ucr6nc/RvV5cfIx5YTbsVn+CPXZ1/qOx7CqTzIlrG9HaVTEJQID14FZ7f7rRZ3wCtttF2X9lg5mUQoP5ljVWpD2DLqQGLwFTBWE4lB4Re7L3MVg5TCVjC0jEKJCAiafKVuQmyV14aXMeLmODhkRDDw2Lbn24x8=
Received: from BN9PR03CA0369.namprd03.prod.outlook.com (2603:10b6:408:f7::14)
 by DM4PR12MB6012.namprd12.prod.outlook.com (2603:10b6:8:6c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Tue, 3 May 2022 03:28:35 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::a4) by BN9PR03CA0369.outlook.office365.com
 (2603:10b6:408:f7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12 via Frontend
 Transport; Tue, 3 May 2022 03:28:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 03:28:35 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 2 May
 2022 22:28:34 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>
CC:     Tony Luck <tony.luck@intel.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        <hpa@zytor.com>, Yazen Ghannam <yazen.ghannam@amd.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v5 2/3] x86/mce: Check for writes ignored in MCA_STATUS register
Date:   Mon, 2 May 2022 22:28:18 -0500
Message-ID: <20220503032820.61667-3-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 61088f95-61e0-4d10-4443-08da2cb501b8
X-MS-TrafficTypeDiagnostic: DM4PR12MB6012:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB60121F40E1914933CA499FD990C09@DM4PR12MB6012.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nzNCCIS9IDLFYoXyCnnIAC6EDC5UcPmCfKwGoK7/eYnmYGOC/Va0Ov10cPyazZibVHWaIcZtHbDPbT123ioRluTdx1Gh4BtlZc6puU9HM/aoBJH2onK+2cbWCrJKfioeEUgO+NcS57/VyBi0x+BiZGbthddQlMMYbqqstC+aikciiVLZq26RRGOY+NpWFqouHjcwNb4Na0FEJ4RAQyVn3Mp2UhXomGa5Mtr9F3a6XyOqQ4+o6SPHh0ZUqaUuDgcjHnStSQY5z99zceXgthddegJ4OhtQd4AYf6X5eNzEk2CiAb656t7KFa6rMym9TCzgimZvznNbusaV8XHgXZtUamQpaylYWL+JEGiCAOz/V/L3yBM7x4XVu2rK7OK9RYUu3P7jfAphCx42S/kDeDT0kk15I0Z+W6tnjYSsRZYlh3lzVo5xGOgA5JfULlki+v9OACdhWvPXKuGRy3cIoNxKC3FEGK2B64eTrW7VcfIqZuQdy8o964t/APXxxxOHxg/klwwJAPIrSXR3tGVJRaQRLYccj6w3ZY+kL4Q4dKJTwi6WAdrMNwWYsY7EVWkuZ0sdRoPq0FrOT+JgTItGCKt3nMAuFIei89LtVRej35ghUdsPxvbVe1+wfIMd3qIrYRGDGR+uTcSZjNbHXLgwoNy1ur4aQl4+PWxOQmEpJ8SRRpVF7j1retsytzt+dhBztF8ET3fbhg+sQ1fwmLdjAvosPLqSMgBKoHMzJ615bOc770vsU1B71FSKl8Nhb2LvDomjewCgwM6al2KS0KNFRRniZHXOGAMb+4h0h5nQbE/qOyj8BL4kIXND3daZNKhdEg/bzJwTyuyvsjEX+p2kDzpgwnehpuPha9wsJFJK4mVrFtQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(47076005)(186003)(16526019)(316002)(1076003)(6666004)(508600001)(36860700001)(966005)(426003)(36756003)(8936002)(86362001)(336012)(110136005)(54906003)(82310400005)(7696005)(356005)(81166007)(40460700003)(83380400001)(5660300002)(26005)(70586007)(8676002)(2906002)(4326008)(70206006)(2616005)(21314003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 03:28:35.5121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61088f95-61e0-4d10-4443-08da2cb501b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6012
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

Hence, evaluate for writes ignored for MCA_STATUS before doing hw error
injection. If true, return the appropriate error code to userspace.

Introduce "hw_injection_possible" flag to return early on subsequent
hw error injections.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
Link:
https://lkml.kernel.org/r/20220214233640.70510-2-Smita.KoralahalliChannabasappa@amd.com

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
v5:
	Replaced i_mce with inject_desc.
	Introduction of hw_injection_possible flag to return early if HW
	error injections are not possible.
---
 arch/x86/kernel/cpu/mce/inject.c   | 25 +++++++++++++++++++++++++
 arch/x86/kernel/cpu/mce/internal.h |  2 +-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 05581b718529..cce068a4478c 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -33,6 +33,8 @@
 
 #include "internal.h"
 
+static bool hw_injection_possible = true;
+
 /* Collect all the MCi_XXX settings */
 static struct inject_desc {
 	struct mce m;
@@ -474,11 +476,29 @@ static void toggle_nb_mca_mst_cpu(u16 nid)
 		       __func__, PCI_FUNC(F3->devfn), NBCFG);
 }
 
+static bool prepare_mca_status(void)
+{
+	u32 status_reg = mca_msr_reg(inj_desc.m.bank, MCA_STATUS);
+	u64 status_val = inj_desc.m.status;
+
+	wrmsrl(status_reg, status_val);
+	rdmsrl(status_reg, status_val);
+
+	return status_val == inj_desc.m.status;
+}
+
 static void prepare_msrs(void *unused)
 {
 	struct mce *m = &inj_desc.m;
 	u8 b = inj_desc.m.bank;
 
+	if (!prepare_mca_status()) {
+		pr_err("Platform does not allow error injection, try using APEI EINJ instead.\n");
+		inj_desc.err = -EINVAL;
+		hw_injection_possible = false;
+		return;
+	}
+
 	wrmsrl(MSR_IA32_MCG_STATUS, m->mcgstatus);
 
 	if (boot_cpu_has(X86_FEATURE_SMCA)) {
@@ -521,6 +541,11 @@ static int do_inject(void)
 		return 0;
 	}
 
+	if (!hw_injection_possible) {
+		pr_err("SW-only injection possible on this platform");
+		return -EINVAL;
+	}
+
 	/* prep MCE global settings for the injection */
 	mcg_status = MCG_STATUS_MCIP | MCG_STATUS_EIPV;
 
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 4ae0e603f7fa..7e03f5b7f6bd 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -211,7 +211,7 @@ noinstr u64 mce_rdmsrl(u32 msr);
 
 static __always_inline u32 mca_msr_reg(int bank, enum mca_msr reg)
 {
-	if (mce_flags.smca) {
+	if (cpu_feature_enabled(X86_FEATURE_SMCA)) {
 		switch (reg) {
 		case MCA_CTL:	 return MSR_AMD64_SMCA_MCx_CTL(bank);
 		case MCA_ADDR:	 return MSR_AMD64_SMCA_MCx_ADDR(bank);
-- 
2.17.1

