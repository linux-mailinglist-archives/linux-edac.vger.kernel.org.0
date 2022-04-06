Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28434F5BAC
	for <lists+linux-edac@lfdr.de>; Wed,  6 Apr 2022 12:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347195AbiDFKIS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Apr 2022 06:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243705AbiDFKHF (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 6 Apr 2022 06:07:05 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A65C6F3D;
        Tue,  5 Apr 2022 23:36:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2oRt+UAxDfImnM5bw3YdGGgF+rk0X0WLkS3iS0YzRswhJyRtjX124rBgwqY/vhoF70e3dDjjG5vq+7CIy0FI4F5mB38PNzcBvuQ6IF/8KJiPnijH0YkJtQ90hagZ3F62l6fX5A1OyUPx2fT75r+4d+8UEWxrWA4LVaqVBWQchTXxZMUdeVFM5egLZht++Mzmyd46gDhTfPEuVgtwKVLPMcD9Xt/3GlkdRtCYbwH0ojxil/8Ul2Jj+BZlkgXjMjKLiHutB8K+oj1ObLMdVXp70+QvXEoV3oeDEoUyuZ7+PvM471h6NDHaBlLho2HelquOSyZbSGJyY6iXYisLzf38A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0yf452qIEJ6Q93bJAfgj+qC2g7vcm5Nw9CkGPLij6Q=;
 b=kOBetQrFyzZ+e/mm8KoJMZIOa0R5JRq0Cr7Tw5uya8kzxMYB5sjmQZJpK1QuicfgGRa7ral8wQ3kSGJntpl+NFxc4e+MQLzSzgS0nuir5oySRWmdr62JokOysnSeRnEQrS0S7TFbitN2OorohxZ6kAK8upkZga051mWrnxfCaqloCI8gJrucyDILK8W4KSjzkqOaARW+4jfwNzEV/T54lq8+X8bcQUQ+EF8lQwxgf6aScxIbee4X9VelbGqaIDZi277gWn162LdZCKI9YSWhrxq1P4GoPUqH8p43Rct8T21ichtmnDqDARo7nIaEQlJMZO+Wo8Us106H4tGvd3LrBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0yf452qIEJ6Q93bJAfgj+qC2g7vcm5Nw9CkGPLij6Q=;
 b=JUZjhIBCzI2EtgmrEJzTZOaiNLEax+Sk3v4PmAHm2QKRA2TyuIrK6PcLplUz/DbqVKggBTJBAG9n6Pq6dozGiNANUh2W1GlvR2wFu0hy44Qcd1PK+cnfwjRMRrMIvi8exr6D6BMgl1ZTiRBFOAHi24ylY9RonsxsApy6ozXD6+g=
Received: from DM5PR07CA0076.namprd07.prod.outlook.com (2603:10b6:4:ad::41) by
 DM6PR12MB3804.namprd12.prod.outlook.com (2603:10b6:5:1cd::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.31; Wed, 6 Apr 2022 06:36:02 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::68) by DM5PR07CA0076.outlook.office365.com
 (2603:10b6:4:ad::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Wed, 6 Apr 2022 06:36:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Wed, 6 Apr 2022 06:36:02 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 6 Apr
 2022 01:36:01 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
CC:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        <hpa@zytor.com>, Yazen Ghannam <yazen.ghannam@amd.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>
Subject: [RFC PATCH 3/5] x86/mce: Introduce a function pointer mce_handle_storm
Date:   Wed, 6 Apr 2022 01:35:40 -0500
Message-ID: <20220406063542.183946-4-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220406063542.183946-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20220406063542.183946-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a305999-60e4-4f7b-16d5-08da1797b81c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3804:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB380401F8EC52BD4D409DDF5590E79@DM6PR12MB3804.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aLkG0MSC/E2EX+Lj80B37HJnx8ylt2wlaH0hbWU6gjm/f40RPAqCDMKQO9FKmkW+FNTqhNIk8x95PU20bO9jxQsjdH0lIQ7cZa/xcsqZpfMvppRaMNNRLdBVn2kgezZ9Wil2Q029iztO8dRH6LpRM2P0pcF0IlDzZeLdVwO/CIWNF3Cr0ToToi1wNvCaavstr3QhUHFgkqZhYzybRaEE5LRbJIpqbYMXnsnxZVOXdaiCy38rNU0WC9wSgnXVoVcPyYrXQt3KHvD5BvB+sG0uhSXzRIWlJrAR8r/jg7qz1W848L3eclk8w7Xr5v7OAbzFyltyebWLNSSLxFndU9Gl/EnvVF0i0GHqYrt9Vic7UnqlteBoj6wKZuxConuu9oH+56kuNu2ULPU40U2mBmbTesdJD/Lg8NdCGkIr3wiin6jl1yudLUv0tr1adIbjFdInqwmO/xEAtG/aQikuiz6hGvkhz0/SxCd1E/DPRXcjnqQAJ5ewZ2tQjRDhxjZ4thP8m47NY/W02JJsAgzj/5bwIdK2gj/9CpWfHDWze5dzR2rRCYUU2N+AnsEBgEDZ0yo0RMQoO8yNVXLa31jzAEB3L3Ir4VZStsW8Cgm6E6A0FsTQpXs9mcEz9VUGpyY4LKN2yTehH/cesoiKSRA75PMO5yg04q0rw2u/gqSp60ln+OCLMqdO8RtPCUiW8Kdk+I2yuUr3dZ7toNXE8l6rLGKH0A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(8676002)(4326008)(36860700001)(70586007)(356005)(5660300002)(70206006)(83380400001)(82310400005)(2616005)(186003)(26005)(336012)(16526019)(426003)(6666004)(81166007)(508600001)(1076003)(40460700003)(8936002)(36756003)(2906002)(110136005)(7696005)(54906003)(316002)(47076005)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 06:36:02.1601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a305999-60e4-4f7b-16d5-08da1797b81c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3804
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Introduce a function pointer "mce_handle_storm". This function pointer
does the vendor specific storm handling. In Intel it points to a routine
to set different thresholds in IA32_MCi_CTL2.

No functional changes.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
The intention of keeping this patch separate was just to not make any
changes in Tony's initial code as it can get confusing. These changes
could be merged in Tony's new CMCI storm mitigation patch.
---
 arch/x86/kernel/cpu/mce/core.c     |  5 +++++
 arch/x86/kernel/cpu/mce/intel.c    | 12 ++++++++++--
 arch/x86/kernel/cpu/mce/internal.h |  3 +++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 13844a38aa2c..db6d60825e77 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1599,6 +1599,10 @@ static DEFINE_PER_CPU(unsigned long, mce_next_interval); /* in jiffies */
 static DEFINE_PER_CPU(struct timer_list, mce_timer);
 static DEFINE_PER_CPU(bool, storm_poll_mode);
 
+void mce_handle_storm_default(int bank, bool on) { }
+
+void (*mce_handle_storm)(int bank, bool on) = mce_handle_storm_default;
+
 static void __start_timer(struct timer_list *t, unsigned long interval)
 {
 	unsigned long when = jiffies + interval;
@@ -1988,6 +1992,7 @@ static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
 	switch (c->x86_vendor) {
 	case X86_VENDOR_INTEL:
 		mce_intel_feature_init(c);
+		mce_handle_storm = mce_intel_handle_storm;
 		break;
 
 	case X86_VENDOR_AMD: {
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index 59cad4061e5a..7edc31742fe0 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -159,6 +159,14 @@ static void cmci_set_threshold(int bank, int thresh)
 	raw_spin_unlock_irqrestore(&cmci_discover_lock, flags);
 }
 
+void mce_intel_handle_storm(int bank, bool on)
+{
+	if (on)
+		cmci_set_threshold(bank, cmci_threshold[bank]);
+	else
+		cmci_set_threshold(bank, CMCI_STORM_THRESHOLD);
+}
+
 static void cmci_storm_begin(int bank)
 {
 	__set_bit(bank, this_cpu_ptr(mce_poll_banks));
@@ -218,13 +226,13 @@ void track_cmci_storm(int bank, u64 status)
 		if (history & GENMASK_ULL(STORM_END_POLL_THRESHOLD - 1, 0))
 			return;
 		pr_notice("CPU%d BANK%d CMCI storm subsided\n", smp_processor_id(), bank);
-		cmci_set_threshold(bank, cmci_threshold[bank]);
+		mce_handle_storm(bank, true);
 		cmci_storm_end(bank);
 	} else {
 		if (hweight64(history) < STORM_BEGIN_THRESHOLD)
 			return;
 		pr_notice("CPU%d BANK%d CMCI storm detected\n", smp_processor_id(), bank);
-		cmci_set_threshold(bank, CMCI_STORM_THRESHOLD);
+		mce_handle_storm(bank, false);
 		cmci_storm_begin(bank);
 	}
 }
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 1ee8fc0d97fe..c95802db9535 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -42,6 +42,7 @@ extern mce_banks_t mce_banks_ce_disabled;
 
 #ifdef CONFIG_X86_MCE_INTEL
 void track_cmci_storm(int bank, u64 status);
+void mce_intel_handle_storm(int bank, bool on);
 void cmci_disable_bank(int bank);
 void intel_init_cmci(void);
 void intel_init_lmce(void);
@@ -49,6 +50,7 @@ void intel_clear_lmce(void);
 bool intel_filter_mce(struct mce *m);
 #else
 static inline void track_cmci_storm(int bank, u64 status) { }
+# define mce_intel_handle_storm mce_handle_storm_default
 static inline void cmci_disable_bank(int bank) { }
 static inline void intel_init_cmci(void) { }
 static inline void intel_init_lmce(void) { }
@@ -57,6 +59,7 @@ static inline bool intel_filter_mce(struct mce *m) { return false; }
 #endif
 
 void mce_timer_kick(bool storm);
+extern void (*mce_handle_storm)(int bank, bool on);
 
 #ifdef CONFIG_ACPI_APEI
 int apei_write_mce(struct mce *m);
-- 
2.17.1

