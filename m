Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43924F5B59
	for <lists+linux-edac@lfdr.de>; Wed,  6 Apr 2022 12:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351428AbiDFKIW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Apr 2022 06:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343622AbiDFKHG (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 6 Apr 2022 06:07:06 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E9FC6F3F;
        Tue,  5 Apr 2022 23:36:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEZE5j7+MS2yk5fYrCB6nVtVVjGk9MqnF3spTgrvct3mnIaYSY2ERWsY3n5pDw3AgaCOczWDdwhkMatnDzufFITlFk/s4xK/JkfYZ6U3+YldQltaJA85IWhdNQL8+3VY2YbWwBc256+a0U2oJlapoG88SXb0TuvaZuFmO0D+MMTjgqLO2n3en80D4Rnva2NnaqhmUqqFU5FB+Xkl7FASzkTGBMjeATk4Jj1frmrtXoL3RnYhfCXb4T3Ap7LrHmf/Zhf2kfipfXSj/zRUuF6zq0wpDNDiMSBLJkeSZUOJnPgUHXtYUjf90NiMUqQE2Npcj6JxY2TVTCFHaTcIWmljqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VlTqkxDIxDU73UZf91V0PrK0Txhqggj600+WuSGKkc=;
 b=cuDVU0aV+LLA89R5aIz8O4bt02p+E+blIe6gr2/O5HqIW+fWFFIjbI3D7k5SsXD5PhDoM0Z7zU264IdZR/BSo7GNcDcxVbUGAPDqOV9LJ6ohS6xMmT2G/Pk85fRv4BKrU8pp26ohLNW/HJs3rvIJ5inXO4rg5PKiinwvzDslbLecwCQbvxf93mckjB2F3wwE53nnb8ggCmpSpSKddWK2tEG0rsiflvNpR/6vf5xxq2IWGq/+60KB6wLHT7AorRjM+fhjFPP9RhuxTqNMnQ0DoaU7tFlRQ/aJjK5op7jUgDOxyw+W7Qg0PpGKoJsWH9yOMGaOf2CqtWZKSUmg3fnJvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VlTqkxDIxDU73UZf91V0PrK0Txhqggj600+WuSGKkc=;
 b=d0iD5kLE1/IxoMA2/4F6jm4o7ZfQR2Rl8R6pJsfMMfOAOjsX14QPkOMPMnZSHcu+Wunh6XP57y876R2Ya1tk+COR9p7WzGF8X+PIiXoRw+645IGopbI9yIiGtD/ffNO4djnUM9T47+8yd9KTVNmcud3xUC1Q5sgKdWc7YvE+we4=
Received: from DM5PR07CA0057.namprd07.prod.outlook.com (2603:10b6:4:ad::22) by
 MW3PR12MB4345.namprd12.prod.outlook.com (2603:10b6:303:59::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.31; Wed, 6 Apr 2022 06:36:06 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::8c) by DM5PR07CA0057.outlook.office365.com
 (2603:10b6:4:ad::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Wed, 6 Apr 2022 06:36:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Wed, 6 Apr 2022 06:36:06 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 6 Apr
 2022 01:36:05 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
CC:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        <hpa@zytor.com>, Yazen Ghannam <yazen.ghannam@amd.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>
Subject: [RFC PATCH 5/5] x86/mce: Handle AMD threshold interrupt storms
Date:   Wed, 6 Apr 2022 01:35:42 -0500
Message-ID: <20220406063542.183946-6-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2c33f646-9fd2-4919-193d-08da1797ba70
X-MS-TrafficTypeDiagnostic: MW3PR12MB4345:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB434563C50E115ABBA64FAAA990E79@MW3PR12MB4345.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U5eqYI9TvSqvX01gPSu7Gf5LoawKuDeD6ZptWyevlh20WixwT0oVKp6MnztEJaQYdq/bP3L5A7eAaBEoKgtZ+gcZ4BpSyu6GnDxoWOnCfPL6e5JfmNJidBruiVUYLZuGgDd1Sp0DHmGiITav39vr/ffVFpPkvPrDiYFzogU5flkaWaK3ZV0x4cKrMLmIuhs5ZQzmv7PH+MNmv5sbLjWvY7ZMz5PaWFl+FJSj+v39VVIvZkeKI7jl/wsYNhZiOXRiYcHy81bFEHmf44UQq2NbOzyYmKL4RGbVfF9bRmCH7H7IU5nrgfrjsBwguQvFjxMC234dKUKepHFV+E34GvGMP84uXFkDVy3KPUL2D2TZ4Ni5u89GwbLZU1TVSI5cQYZc1uNdNrU8821/L/6z7GqNBTw9QhaHhMY4ZINAQ0dPxZqikwIeHtJWx6vuRCAej2Vh8rZTXFET5aL+GXEH2UqKaBSpFakISbT94lsOy7NYV4iyX3ELAVyGoER/Ygt7v1c6uYcYTCrGV7nXdFcKmpqkGgVFVqIQQVfOQTk8UlEP0IqbotlVC3BRh8tbka+cw6M8ixZQAvgu28VEd7KUWmz9s4NtTMg0nRFsP1gqydvpBY5IWALiDVSK0RjlV7ggKN5+DSzv6KeF0c+/5fRVRdML/2SyVv4D960Kfo2xJrN9nGlvn9xEp3E5SLLBlBS4WDjbU84bGFYv+v4g8zjpP6ovqHCVfunUf7AIgpEGvDPzhZo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(6666004)(2616005)(83380400001)(7696005)(81166007)(40460700003)(47076005)(86362001)(186003)(26005)(54906003)(70206006)(336012)(82310400005)(316002)(16526019)(8676002)(36756003)(2906002)(110136005)(4326008)(70586007)(1076003)(426003)(356005)(508600001)(5660300002)(36860700001)(8936002)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 06:36:06.0818
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c33f646-9fd2-4919-193d-08da1797ba70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4345
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Extend the logic of handling CMCI storms to AMD threshold interrupts.

Rely on the similar approach as of Intel's CMCI to mitigate storms per
CPU and per bank. But, unlike CMCI, do not set thresholds and reduce
interrupt rate on a storm. Rather, disable the interrupt on the
corresponding CPU and bank. Re-enable back the interrupts if enough
consecutive polls of the bank show no corrected errors (30, as
programmed by Intel).

Turning off the threshold interrupts would be a better solution on AMD
systems as other error severities will still be handled even if the
threshold interrupts are disabled.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c      | 49 ++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/mce/core.c     |  1 +
 arch/x86/kernel/cpu/mce/internal.h |  4 +++
 3 files changed, 54 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 1940d305db1c..941b09f4dac5 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -466,6 +466,47 @@ static void threshold_restart_bank(void *_tr)
 	wrmsr(tr->b->address, lo, hi);
 }
 
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
+void mce_amd_handle_storm(int bank, bool on)
+{
+	struct threshold_block *first_block = NULL, *block = NULL, *tmp = NULL;
+	struct threshold_bank **bp = this_cpu_read(threshold_banks);
+	unsigned long flags;
+
+	if (!bp)
+		return;
+
+	local_irq_save(flags);
+
+	first_block = bp[bank]->blocks;
+	if (!first_block)
+		goto end;
+
+	toggle_interrupt_reset_block(first_block, on);
+
+	list_for_each_entry_safe(block, tmp, &first_block->miscj, miscj)
+		toggle_interrupt_reset_block(block, on);
+end:
+	local_irq_restore(flags);
+}
+
 static void mce_threshold_block_init(struct threshold_block *b, int offset)
 {
 	struct thresh_restart tr = {
@@ -867,6 +908,7 @@ static void amd_threshold_interrupt(void)
 	struct threshold_block *first_block = NULL, *block = NULL, *tmp = NULL;
 	struct threshold_bank **bp = this_cpu_read(threshold_banks);
 	unsigned int bank, cpu = smp_processor_id();
+	u64 status;
 
 	/*
 	 * Validate that the threshold bank has been initialized already. The
@@ -880,6 +922,13 @@ static void amd_threshold_interrupt(void)
 		if (!(per_cpu(bank_map, cpu) & (1 << bank)))
 			continue;
 
+		rdmsrl(mca_msr_reg(bank, MCA_STATUS), status);
+		track_cmci_storm(bank, status);
+
+		/* Return early on an interrupt storm */
+		if (this_cpu_read(bank_storm[bank]))
+			return;
+
 		first_block = bp[bank]->blocks;
 		if (!first_block)
 			continue;
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 6caee488bf7d..c510dd17f2c5 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2078,6 +2078,7 @@ static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
 
 	case X86_VENDOR_AMD: {
 		mce_amd_feature_init(c);
+		mce_handle_storm = mce_amd_handle_storm;
 		break;
 		}
 
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 49907cadf9ad..b9e8c8155c66 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -213,7 +213,11 @@ extern bool filter_mce(struct mce *m);
 
 #ifdef CONFIG_X86_MCE_AMD
 extern bool amd_filter_mce(struct mce *m);
+void track_cmci_storm(int bank, u64 status);
+void mce_amd_handle_storm(int bank, bool on);
 #else
+static inline void track_cmci_storm(int bank, u64 status) { }
+# define mce_amd_handle_storm mce_handle_storm_default
 static inline bool amd_filter_mce(struct mce *m) { return false; }
 #endif
 
-- 
2.17.1

