Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F8772E55B
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jun 2023 16:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242670AbjFMONI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 13 Jun 2023 10:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238289AbjFMONH (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 13 Jun 2023 10:13:07 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD39A1FC9;
        Tue, 13 Jun 2023 07:12:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uuk6g1TyX5YbZCBjFVdADOOT1/EMWUGpviAHtoGOrLyf9zx4CyRSt9j9QPxF3XUVeb+vAHgo3FhaFa2EzA3hZ3HvexgGBkSxHgWGzNDpAYVZtsV3Wj0AiUkwIaoCNISmI+jF0Rs0vW/QCXie/DJMqtaS9KiImzNhhDTQVDBq3gcsLeR3j53bNK7KSH8CpWIx8Sy1QiAQ2GzsBUfVfn6JEENFpftGg/oh/cGFY0klt7mfX5SY0fC8PXZVo4qk+WgTWu21Zhr09u3yycMYPCRtZSRne7jWoqlIpwv131Wibb1KQDV4xzkA7LSj4K+7tQS8sBBqm3x06swVUtsnbm2xFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojQqC0qddD8G5FXTR5qks1DdG7zqIt43NUW5+yr0/Mw=;
 b=KlqBBUuTQhTe5mTtxlZ0lbG7EVAlAB9nt23IOZb8zMz+gsV46iYWxA/7woKYwEj2bSdgy+l3UYyuBMMV3xIxTxF/Byen6mLG8ZHxIBXqTY295PoSM2I4bwO0cvtCgdW8SdpNx2JMpbY10XVekqzdULN/URAmaDtFrcRMbvmVIORnyMqV9LWIzChy6cRcvjhfdrh8SD/kMC3XMsxZ2F2DJ7toyiLqssGpV7Yf7RfX4sI45FkGwDTOSpsrZZKakYnrfEGQkGLdY4qn2tMLZVAlNec9L6qxe56xZvV2xBm1vpvHPUl3VLBJVBBz+LCSpQNfs0bIBrMmXN0yFhhuYXz3fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojQqC0qddD8G5FXTR5qks1DdG7zqIt43NUW5+yr0/Mw=;
 b=qgYGQNWeFZ1MrNpMAFnhvHmoNytNvtKyA7vj7NtztU9mPP3rVr2fip8xXtuCaq2bTUeGa+zHi5UPkrMSMOcbMB+UIxy/YHsC3SJYdE2qw2gdo8oPjK1Iqbod2AdWSoWx/5WVLa6WumsIv4SvvM2CLbxrhgrXE7xQOY/J5ocpTNY=
Received: from CY5PR15CA0254.namprd15.prod.outlook.com (2603:10b6:930:66::28)
 by PH7PR12MB8156.namprd12.prod.outlook.com (2603:10b6:510:2b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 13 Jun
 2023 14:12:38 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:930:66:cafe::b8) by CY5PR15CA0254.outlook.office365.com
 (2603:10b6:930:66::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Tue, 13 Jun 2023 14:12:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.23 via Frontend Transport; Tue, 13 Jun 2023 14:12:38 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 09:12:36 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, <muralidhara.mk@amd.com>,
        <joao.m.martins@oracle.com>, <william.roche@oracle.com>,
        <boris.ostrovsky@oracle.com>, <john.allen@amd.com>,
        <xueshuai@linux.alibaba.com>, <baolin.wang@linux.alibaba.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 2/3] x86/mce: Define amd_mce_usable_address()
Date:   Tue, 13 Jun 2023 09:11:41 -0500
Message-ID: <20230613141142.36801-3-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613141142.36801-1-yazen.ghannam@amd.com>
References: <20230613141142.36801-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|PH7PR12MB8156:EE_
X-MS-Office365-Filtering-Correlation-Id: d4097d72-9aac-47d9-b85b-08db6c183e8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fYpa3JzSgr4HAOSTtVq44TNA5cNBwje1LLqM/uvhe/jBPBA2Pxc4IMcToM/U3LsVdRjlXqLSV9x1QeC8j6+Qu059bAS9on4cAWyj7SVR2xKj7EehmBqRVxvdYKofEwDASXklHivZ94mNIinbpTK8Tv44gyK7WMQEunNW8yfak1JxB/JvEu+U+1Z/cAy4VHjHH5jBhSXevHed0dU7JYzfzgp7Ww0+MWavPu1/auD18LXnIGTINTU9iRuGNkXsDTOKzT7r4JhYxVpw3N6o2ggEiSSWr2huqyEiuqhaCwZ88QvNVq5uqzw8YoDrTBhOoopUAnIe+KjmTptC9O30U8BRI2DUfSsauoxJCzjO+a4T4k3aOKvGhmS+Di/VYcnWiYSUA1ozIzY+NaJ5vrArSh/+4ioKnkiAruJMyT+YHLMhiEeh0/lMYn+8CbWP6tndFx5Ya8mkJYmixVdR4I0i72BAvv8GuLLg5pnrn1HsASxy2z+GRAnyJ8NDrXILDotAeEl556q7bG9Mbx6aworipHTkzBUImdKkQ+uWAmldgVLV+h3UFGR3tv8yY/ZkvDOFxxKPCeMU3gP19OZ7EO6AzXi8URq4Tr8EMepZIzwbgTDLlM1/rFPwn4zo+kg7gXws/2mdy97H805/EBqbAXpsdwQICESjvc3BOKgmDjVLUauAnwPb+QwOuH9MWu1EEz3bGF9k4eUCf0LS0cEz3msj7GEboMpdLRupp5hmyjr74X1XUXZ2oEJ6FGkYQyoP7VfUrsVHFqnHLhjVllZ/BrMl9oHdXQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199021)(46966006)(40470700004)(36840700001)(7696005)(316002)(40460700003)(41300700001)(336012)(83380400001)(426003)(86362001)(82310400005)(36860700001)(2616005)(186003)(26005)(1076003)(44832011)(47076005)(2906002)(16526019)(82740400003)(81166007)(40480700001)(356005)(5660300002)(36756003)(8936002)(8676002)(70206006)(70586007)(478600001)(54906003)(6666004)(4326008)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 14:12:38.6100
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4097d72-9aac-47d9-b85b-08db6c183e8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8156
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Currently, all valid MCA_ADDR values are assumed to be usable on AMD
systems. However, this is not correct in most cases. Notifiers expecting
usable addresses may then operate on inappropriate values.

Define a helper function to do AMD-specific checks for a usable memory
address. List out all known cases.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c      | 38 ++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/mce/core.c     |  3 +++
 arch/x86/kernel/cpu/mce/internal.h |  2 ++
 3 files changed, 43 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 1ccfb0c9257f..ca79fa10b844 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -746,6 +746,44 @@ bool amd_mce_is_memory_error(struct mce *m)
 	return legacy_mce_is_memory_error(m);
 }
 
+/*
+ * AMD systems do not have an explicit indicator that the value in MCA_ADDR is
+ * a system physical address. Therefore individual cases need to be detected.
+ * Future cases and checks will be added as needed.
+ *
+ * 1) General case
+ *	a) Assume address is not usable.
+ * 2) "Poison" errors
+ *	a) Indicated by MCA_STATUS[43]: POISON. Defined for all banks except legacy
+ *	   Northbridge (bank 4).
+ *	b) Refers to poison consumption in the Core. Does not include "no action",
+ *	   "action optional", or "deferred" error severities.
+ *	c) Will include a usuable address so that immediate action can be taken.
+ * 3) Northbridge DRAM ECC errors
+ *	a) Reported in legacy bank 4 with XEC 8.
+ *	b) MCA_STATUS[43] is *not* defined as POISON in legacy bank 4. Therefore,
+ *	   this bit should not be checked.
+ *
+ * NOTE: SMCA UMC memory errors fall into case #1.
+ */
+bool amd_mce_usable_address(struct mce *m)
+{
+	/* Check special Northbridge case first. */
+	if (!mce_flags.smca) {
+		if (legacy_mce_is_memory_error(m))
+			return true;
+		else if (m->bank == 4)
+			return false;
+	}
+
+	/* Check Poison bit for all other bank types. */
+	if (m->status & MCI_STATUS_POISON)
+		return true;
+
+	/* Assume address is not usable for all others. */
+	return false;
+}
+
 static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
 {
 	struct mce m;
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 89e2aab5d34d..859ce20dd730 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -464,6 +464,9 @@ int mce_usable_address(struct mce *m)
 	if (!(m->status & MCI_STATUS_ADDRV))
 		return 0;
 
+	if (m->cpuvendor == X86_VENDOR_AMD)
+		return amd_mce_usable_address(m);
+
 	/* Checks after this one are Intel/Zhaoxin-specific: */
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL &&
 	    boot_cpu_data.x86_vendor != X86_VENDOR_ZHAOXIN)
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index d2412ce2d312..0d4c5b83ed93 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -207,6 +207,7 @@ extern bool filter_mce(struct mce *m);
 
 #ifdef CONFIG_X86_MCE_AMD
 extern bool amd_filter_mce(struct mce *m);
+bool amd_mce_usable_address(struct mce *m);
 
 /*
  * If MCA_CONFIG[McaLsbInStatusSupported] is set, extract ErrAddr in bits
@@ -234,6 +235,7 @@ static __always_inline void smca_extract_err_addr(struct mce *m)
 
 #else
 static inline bool amd_filter_mce(struct mce *m) { return false; }
+static inline bool amd_mce_usable_address(struct mce *m) { return false; }
 static inline void smca_extract_err_addr(struct mce *m) { }
 #endif
 
-- 
2.34.1

