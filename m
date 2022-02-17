Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF144BA2B7
	for <lists+linux-edac@lfdr.de>; Thu, 17 Feb 2022 15:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237402AbiBQOQm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 17 Feb 2022 09:16:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241769AbiBQOQl (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 17 Feb 2022 09:16:41 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B931A8CEA;
        Thu, 17 Feb 2022 06:16:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3rDxcCusYuaJ5frNVG70LHPt/LF9SxOQQ21B8cJv+Nha2pscpOFn1vTeGdCwZlknjNHwB782oShJz2llcYcL1M56p9hKl9ewKjjl4p8FY8kb7BqnV2/G9zWSeenZ6hI+LZboLtc8tzaM5NUyBGC2H1RawaQmtDPdZwZ4NXBMRrrffjH8GZ91pfD4FV4EnxVQSYB3JSuisJZAgz5vcVzjQBs8VjFYq15V+qBTPEDyIlPuIUmMwPmj49qJt4TsK1qz70s1fmnCQJcDPycU0NyYDJrcmQivROxTTQrq6p47q88I2R0vUUi/zA88aMEY9/SMqC3blpWTPYwUxnDXQVezA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6QSA4YVfKQ3iiUe2h/NcTj5/dAMt9mPj+JyDcqS1Lk=;
 b=VlnipgBBVSSV8Os9694pjv9uQq/sGlcMJs7a2YSsSmM9D7pvmETaulHxtWpO++kVR4G9ZQrnJBppaqJv0W4dcBBVBB+JMZn4TWykZFIqgIgeJwL+MvIYBWNaOWHNctUUjY1Ce5vBjiO3Kv68SUqviA4qTBysPWiFKBeWaFg/5cnr7dd9seX+tKsZ3UqlRypceKQ4ksT+v4ufKUZO23vtd527xE5zr4mmapO11pnbcZwLWjdAswcqs3lHrJg9H/rGUwkVeRwH3DpbsnGk24HPqgEoZflgZMhEXLgqA37+s5WS7AHT4P3ka3Hl7KlRCLkSJa3F66s0ya6N2IwlbvESOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6QSA4YVfKQ3iiUe2h/NcTj5/dAMt9mPj+JyDcqS1Lk=;
 b=tHP2STJPeEp7nklxs8Rt5/egs8xc000aSveNycWNbaoPFrf1g/XdTtozWgZcqC3gv/jXnrezs4UHHPfumpoU0fuzAmn2LZcdBpyzoWIi4jx7i/bA3J68WfqYn1Xr9NIr3oaDA/dqICr/f/Rj76Ynr5RwPYPYL6pFdYvaJFefwXw=
Received: from BN9P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::27)
 by DM6PR12MB4107.namprd12.prod.outlook.com (2603:10b6:5:218::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Thu, 17 Feb
 2022 14:16:24 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::af) by BN9P222CA0022.outlook.office365.com
 (2603:10b6:408:10c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Thu, 17 Feb 2022 14:16:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Thu, 17 Feb 2022 14:16:24 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 17 Feb
 2022 08:16:23 -0600
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Tony Luck <tony.luck@intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: [RFC PATCH 1/2] x86/mce: Handle AMD threshold interrupt storms
Date:   Thu, 17 Feb 2022 08:16:08 -0600
Message-ID: <20220217141609.119453-2-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220217141609.119453-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20220217141609.119453-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58e181e6-6491-44fd-0b3e-08d9f2201445
X-MS-TrafficTypeDiagnostic: DM6PR12MB4107:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4107CCDEA81C055446861A7890369@DM6PR12MB4107.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kv0JumMZHB3LnY6Z4wDeQ5rbZmc95aUe4RvyIYJGCP6zF4oJa6zUxCb03MyDs8yyrQtNGwWaIlGzYBvaTeqdVMST88bxLMD+pBIyPJP60UKXoI5wnwf6vtVpadxaXtjY2CCYHUls+1wX0PWHTjaEul9yADX3/e13KpxHG+OV3B3IH/3144Je5qNzLFHl/6cua3N8/tFXFiPNzkAwqtW5nxoEaCHf4blmmVDVySDBy2ZZ+cxYtAIwvOgyNm1Iq+OJMP9Wd0cc0mHZiBk+7zV7748uhiGExvDvCQLWSMXP4480dxXyanrsVdxTJLm2gQsUvOkDPzm7XxfEKNZQRrlyMXwfNzX6tVZWeTV5yI9gDXrvh76uj49nVRpRrRtgRzLxWf1m8WSXrBFosGV6PObcqEGe2JhlQpHz014v2BEDpInfAR39QzhcRphzxHqVd6apRA1P3LMQuf+q01BagdyPJUuKJUyiZ7W1jUcevukHUSdzqFYrAZ2RfvpBzIrz0JBWooBMdbo82d0zsxeipKdmO8Td8jUSfBHXJDKLR1Pvs/pb+Ii4Khueq3hTGbKUd6a4Pxse4mw4sokj0fe1zTbwARiABHsUvExuutKOnh36xIKHY2nK7tJcrQqbR0tT4KqlgxTpoEda0DhfXd7I1lVenG8HyXdTHim7v7RBHzHoqrv/JUcnJkJjPucnvTW0mXzLnMe2csFE4MRofzJeuTDm41M3yIMcEhCXYN8oPXktXVTGpO4/c+rVWGQFg7lUBBA0
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(81166007)(356005)(110136005)(82310400004)(47076005)(8936002)(6666004)(7696005)(8676002)(4326008)(5660300002)(426003)(336012)(508600001)(54906003)(186003)(70586007)(16526019)(2616005)(26005)(40460700003)(83380400001)(36756003)(1076003)(86362001)(70206006)(2906002)(316002)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 14:16:24.1955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e181e6-6491-44fd-0b3e-08d9f2201445
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4107
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Extend the logic of handling CMCI storms to AMD threshold interrupts.

Similar to CMCI storm handling, keep track of the rate at which each
processor sees interrupts. If it exceeds threshold, disable interrupts
and switch to polling of machine check banks.

But unlike CMCI, re-enable threshold interrupts per CPU because MCA
exceptions and interrupts are directed to a single CPU on AMD systems.
As the threshold interrupts are per CPU, a global counter is not required
to keep the count of all CPUs in the storm.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
This patch mostly inherits existing Intel's CMCI storm logic and is not a
per bank based approach. Commit 7bee1ef01f38395 ("x86/mce: Add per-bank
CMCI storm mitigation") under Tony Luck's Linux Tree makes the existing
CMCI storm more fine grained and adds a hook into machine_check_poll()
to keep track of per-CPU, per-bank corrected error logs.
---
 arch/x86/kernel/cpu/mce/amd.c      | 126 +++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/mce/core.c     |  16 +++-
 arch/x86/kernel/cpu/mce/intel.c    |   2 +-
 arch/x86/kernel/cpu/mce/internal.h |   8 +-
 4 files changed, 147 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 1940d305db1c..53d9320d1470 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -478,6 +478,129 @@ static void mce_threshold_block_init(struct threshold_block *b, int offset)
 	threshold_restart_bank(&tr);
 };
 
+#define MCI_STORM_INTERVAL	(HZ)
+#define MCI_STORM_THRESHOLD	15
+
+enum {
+	MCI_STORM_NONE,
+	MCI_STORM_ACTIVE,
+};
+
+static DEFINE_PER_CPU(unsigned long, mci_time_stamp);
+static DEFINE_PER_CPU(unsigned int, mci_storm_cnt);
+static DEFINE_PER_CPU(unsigned int, mci_storm_state);
+
+static DEFINE_PER_CPU(int, mci_backoff_cnt);
+
+static void _reset_block(struct threshold_block *block)
+{
+	struct thresh_restart tr;
+
+	memset(&tr, 0, sizeof(tr));
+	tr.b = block;
+	threshold_restart_bank(&tr);
+}
+
+static void toggle_interrupt_reset_block(struct threshold_block *block, bool on)
+{
+	if (!block)
+		return;
+
+	block->interrupt_enable = !!on;
+	_reset_block(block);
+}
+
+static void mci_toggle_interrupt_mode(bool on)
+{
+	struct threshold_block *first_block = NULL, *block = NULL, *tmp = NULL;
+	struct threshold_bank **bp = this_cpu_read(threshold_banks);
+	unsigned long flags;
+	unsigned int bank;
+
+	if (!bp)
+		return;
+
+	local_irq_save(flags);
+
+	for (bank = 0; bank < this_cpu_read(mce_num_banks); bank++) {
+		if (!(this_cpu_read(bank_map) & (1 << bank)))
+			continue;
+
+		first_block = bp[bank]->blocks;
+		if (!first_block)
+			continue;
+
+		toggle_interrupt_reset_block(first_block, on);
+
+		list_for_each_entry_safe(block, tmp, &first_block->miscj, miscj)
+			toggle_interrupt_reset_block(block, on);
+	}
+
+	local_irq_restore(flags);
+}
+
+bool mce_amd_mci_poll(bool err_seen)
+{
+	if (__this_cpu_read(mci_storm_state) == MCI_STORM_NONE)
+		return false;
+
+	if (err_seen)
+		this_cpu_write(mci_backoff_cnt, INITIAL_CHECK_INTERVAL);
+	else
+		this_cpu_dec(mci_backoff_cnt);
+
+	return true;
+}
+
+unsigned long mci_amd_adjust_timer(unsigned long interval)
+{
+	if (__this_cpu_read(mci_storm_state) == MCI_STORM_ACTIVE) {
+		if (this_cpu_read(mci_backoff_cnt) > 0) {
+			mce_notify_irq();
+			return MCI_STORM_INTERVAL;
+		}
+
+		__this_cpu_write(mci_storm_state, MCI_STORM_NONE);
+		pr_notice("Storm subsided on CPU %d: switching to interrupt mode\n",
+			  smp_processor_id());
+		mci_toggle_interrupt_mode(true);
+	}
+
+	return interval;
+}
+
+static bool storm_detect(void)
+{
+	unsigned int cnt = this_cpu_read(mci_storm_cnt);
+	unsigned long ts = this_cpu_read(mci_time_stamp);
+	unsigned long now = jiffies;
+
+	if (__this_cpu_read(mci_storm_state) != MCI_STORM_NONE)
+		return true;
+
+	if (time_before_eq(now, ts + MCI_STORM_INTERVAL)) {
+		cnt++;
+	} else {
+		cnt = 1;
+		this_cpu_write(mci_time_stamp, now);
+	}
+
+	this_cpu_write(mci_storm_cnt, cnt);
+
+	if (cnt <= MCI_STORM_THRESHOLD)
+		return false;
+
+	mci_toggle_interrupt_mode(false);
+	__this_cpu_write(mci_storm_state, MCI_STORM_ACTIVE);
+	mce_timer_kick(MCI_STORM_INTERVAL);
+	this_cpu_write(mci_backoff_cnt, INITIAL_CHECK_INTERVAL);
+
+	pr_notice("Storm detected on CPU %d: switching to poll mode\n",
+		  smp_processor_id());
+
+	return true;
+}
+
 static int setup_APIC_mce_threshold(int reserved, int new)
 {
 	if (reserved < 0 && !setup_APIC_eilvt(new, THRESHOLD_APIC_VECTOR,
@@ -868,6 +991,9 @@ static void amd_threshold_interrupt(void)
 	struct threshold_bank **bp = this_cpu_read(threshold_banks);
 	unsigned int bank, cpu = smp_processor_id();
 
+	if (storm_detect())
+		return;
+
 	/*
 	 * Validate that the threshold bank has been initialized already. The
 	 * handler is installed at boot time, but on a hotplug event the
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 4c31656503bd..ec89b1115889 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1554,6 +1554,13 @@ static unsigned long mce_adjust_timer_default(unsigned long interval)
 
 static unsigned long (*mce_adjust_timer)(unsigned long interval) = mce_adjust_timer_default;
 
+static bool mce_mci_poll_default(bool err_seen)
+{
+	return false;
+}
+
+static bool (*mce_mci_poll)(bool err_seen) = mce_mci_poll_default;
+
 static void __start_timer(struct timer_list *t, unsigned long interval)
 {
 	unsigned long when = jiffies + interval;
@@ -1577,9 +1584,11 @@ static void mce_timer_fn(struct timer_list *t)
 	iv = __this_cpu_read(mce_next_interval);
 
 	if (mce_available(this_cpu_ptr(&cpu_info))) {
-		machine_check_poll(0, this_cpu_ptr(&mce_poll_banks));
+		bool err_seen;
+
+		err_seen = machine_check_poll(0, this_cpu_ptr(&mce_poll_banks));
 
-		if (mce_intel_cmci_poll()) {
+		if (mce_mci_poll(err_seen)) {
 			iv = mce_adjust_timer(iv);
 			goto done;
 		}
@@ -1938,10 +1947,13 @@ static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
 	case X86_VENDOR_INTEL:
 		mce_intel_feature_init(c);
 		mce_adjust_timer = cmci_intel_adjust_timer;
+		mce_mci_poll = mce_intel_cmci_poll;
 		break;
 
 	case X86_VENDOR_AMD: {
 		mce_amd_feature_init(c);
+		mce_adjust_timer = mci_amd_adjust_timer;
+		mce_mci_poll = mce_amd_mci_poll;
 		break;
 		}
 
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index 95275a5e57e0..6f8006d9620d 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -127,7 +127,7 @@ static bool lmce_supported(void)
 	return tmp & FEAT_CTL_LMCE_ENABLED;
 }
 
-bool mce_intel_cmci_poll(void)
+bool mce_intel_cmci_poll(bool err_seen)
 {
 	if (__this_cpu_read(cmci_storm_state) == CMCI_STORM_NONE)
 		return false;
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index a04b61e27827..aa03107a72b5 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -42,7 +42,7 @@ extern mce_banks_t mce_banks_ce_disabled;
 
 #ifdef CONFIG_X86_MCE_INTEL
 unsigned long cmci_intel_adjust_timer(unsigned long interval);
-bool mce_intel_cmci_poll(void);
+bool mce_intel_cmci_poll(bool err_seen);
 void mce_intel_hcpu_update(unsigned long cpu);
 void cmci_disable_bank(int bank);
 void intel_init_cmci(void);
@@ -51,7 +51,7 @@ void intel_clear_lmce(void);
 bool intel_filter_mce(struct mce *m);
 #else
 # define cmci_intel_adjust_timer mce_adjust_timer_default
-static inline bool mce_intel_cmci_poll(void) { return false; }
+# define mce_intel_cmci_poll mce_mci_poll_default
 static inline void mce_intel_hcpu_update(unsigned long cpu) { }
 static inline void cmci_disable_bank(int bank) { }
 static inline void intel_init_cmci(void) { }
@@ -186,8 +186,12 @@ enum mca_msr {
 extern bool filter_mce(struct mce *m);
 
 #ifdef CONFIG_X86_MCE_AMD
+unsigned long mci_amd_adjust_timer(unsigned long interval);
 extern bool amd_filter_mce(struct mce *m);
+bool mce_amd_mci_poll(bool err_seen);
 #else
+# define mci_amd_adjust_timer mce_adjust_timer_default
+# define mce_amd_mci_poll mce_mci_poll_default
 static inline bool amd_filter_mce(struct mce *m) { return false; }
 #endif
 
-- 
2.17.1

