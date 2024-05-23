Return-Path: <linux-edac+bounces-1096-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A358CD7EF
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2024 17:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C94411C2149D
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2024 15:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222741CAA4;
	Thu, 23 May 2024 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EEiYzV4O"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3052120DC8;
	Thu, 23 May 2024 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479828; cv=fail; b=iTvibnCU8pHTMk4QsapabniL1NkCMyIDEcQms/rmV4TY7IqHZrehnMpPkGc5w6nv2k4K+40GYgRYAlRMxT7yMMcgpEepri7DPleb7eVoCYjQVQtzHMY+cOMztIwtkaoFaaqdBXjwDf/lup/PTWyrRDNHIT+3NIapMKl79ntS/Xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479828; c=relaxed/simple;
	bh=Y46PvPBAeKeyd+j5Pg6lkUg59+H40ai6m/sskr+CHJA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JcB7GWOZKjbkYVV4hr4zok9T9IGLTaxIIbY28BW8H+DQGIfF7OZKYz4nRyJh9XNw6OmUgr6NCK2+X5cfKw5m7di70Z9kWMuqFy7nfIWSOa/zMGfVQ9olhczaxuJ4JpLvmdL83S+6e8eitXQQOfkzHdVdq2bFeC4JexoDrhvZB7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EEiYzV4O; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJNjkZ+U2wLru1wjnNr10GV8C9Dsedm29VDAs1RncSrrdFNk95pb/WE9LWzlYObMT/w61pEPQ4qcTv6mcd6AxxJ5bzhyHyUfvrN76jiNsGGlANX08VFL5sI8Ug3ybdB8D3tQC1RmJ70AwbTJJITD9YYPqJNL06tq/wW/Paes9KbgtsER9atR/Chh/sSqN6k5ruZ+/Dh2+yCpO8UeuNikKZb9BUAvj/d3Dz5F6r6nWfjhTbps+GsRM7xzMjauwwLwRTHYfW1vXjWMRzbcPZHZ+73nzgIi68ikPCBAz8iL4XjNAbFtqjAscHmDbNRhiAHwvdgpmromYHSy/d5H9bytpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipF2H7CH7EYTR5ELUOnYyxDu3JJqY6yDqzlxvDlVW7g=;
 b=ZGK5vnGct5+4DRJ6VnUxuqCuXBhJgGN6qnzSZcSZNInUvgQIqpTv0oRB2i2zuPJ3C/adnXjuRpnmX2GgJPtYmwfbb0oXdOpd3ugXZwMpajWlCwRDsexpk3R8w0drzP0noxGGZTA3ClU3p6Z0kErshfpZe03pjneeqj6YBGc4y3Akt4vN6dlnTsVNhHxe0fZCry6JzUZv9vhuRnDW45GheRHf/he9t3qgVokCgtYG0zgk83hh9lnkSun1x6scGeFcVm9/36zIHqVrmetoV4ntpF+pwKJ0WxQEClm0Uq62rUHS3SWmP1hauwD8m/KMM9VceD/lA2eVP9vANqAFMIuoqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipF2H7CH7EYTR5ELUOnYyxDu3JJqY6yDqzlxvDlVW7g=;
 b=EEiYzV4OhSxeC3rVyfUeyPmbhOOGwO4E7T910omvtpv2V/NXzUu9wiDYoQxC2rY0gBHdXmwpAcmSxfcyIA+MwnOdgBFDYKEf3/dJ3LxhkJByaLTM6anblbOaLpUESC5llfX6Y4aQUKktJiHynZgQkc4ltQSqp2ueP2XbNWas8a0=
Received: from BN0PR08CA0007.namprd08.prod.outlook.com (2603:10b6:408:142::32)
 by CH3PR12MB8849.namprd12.prod.outlook.com (2603:10b6:610:178::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 15:57:03 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:142:cafe::eb) by BN0PR08CA0007.outlook.office365.com
 (2603:10b6:408:142::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36 via Frontend
 Transport; Thu, 23 May 2024 15:57:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 15:57:03 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 10:56:59 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<avadhut.naik@amd.com>, <john.allen@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH 8/9] x86/mce/amd: Enable interrupt vectors once per-CPU on SMCA systems
Date: Thu, 23 May 2024 10:56:40 -0500
Message-ID: <20240523155641.2805411-9-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523155641.2805411-1-yazen.ghannam@amd.com>
References: <20240523155641.2805411-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|CH3PR12MB8849:EE_
X-MS-Office365-Filtering-Correlation-Id: d6ce2a04-4caf-40d7-200c-08dc7b40fd55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|82310400017|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cH5cxJcj0mbjuhS2cx0GVFBAq535RqFuKcfJk9VoX8uSovTRoEZ/JjVMXBUB?=
 =?us-ascii?Q?8fWtu2I1xMXkSkkVxhbxEU5ILUpSMBEf3FWexr8RZ8jkEXjPE6MOy9F3V1DQ?=
 =?us-ascii?Q?ADyFmSvv6FXzMRscTK/IDMQtMV02fZCW4HXdFpt15oqiiluciHgVIFvNDqnx?=
 =?us-ascii?Q?I22WnGIeXoZgiV3/XWxcKDzqfWslDVeZqcppFXjUvrxEPbfPsbzqGdq+Kms0?=
 =?us-ascii?Q?bbB13WFMtdnappv0hrkUTYX4VOJMGDyXhqkLHIxp2fyFKppYxsiK68oQlxX0?=
 =?us-ascii?Q?FvlUoP9+1zqgu9dsHmzuUouDZC5ocRRUJ0Wu65/8Hl3h50/XZaJlaZ068/Et?=
 =?us-ascii?Q?cwy3BfWn5suivzXQrqq2qpHnrwhLQ+gk3Oe1D5MinqiJP3/gKXWS9680CqV3?=
 =?us-ascii?Q?JoyCat9u0vSn+p2X12Aya+RH6zkPX5EIPzuNynxZY3BxNsWwoIrGFKfaamzk?=
 =?us-ascii?Q?NfI6gLcJW3P9BO5SvCSMiJXhYNOxxckq9vmIv5DuiXGSlskzCnKk9Nk6juIM?=
 =?us-ascii?Q?oJ353nUbiVM3gw4fkPcQ4HCDSlsBH8littLTQm4451fN20cIc0Uo8NfDIb0j?=
 =?us-ascii?Q?HDuuEEhZ66wMNH0Gb6Fed2I1kNSZdwPZXqprpO4CXVWmV1ac/WE3NjspGTdu?=
 =?us-ascii?Q?OzhetR5rx+u371h086X/DwZhBsNwz2CkL10HTCHBBYlxChJ7mNhaIYk5J4vj?=
 =?us-ascii?Q?a4AGEVLXaYeYMhD38/T+xK8ABvmhJRPD3njdJGENGJDyxsacs/V7MicGlX1m?=
 =?us-ascii?Q?JEnCR8eTgJl55ANpCZvDUjaVo0Gy9ss3YXK+05uJGlCU1mfOBwb3oHcgJjqD?=
 =?us-ascii?Q?iLldtU1DO/yFry4unMe9RdwjiZh7y36f51jmfgZ7k/uYlKLhZo2J1oEmA6Kk?=
 =?us-ascii?Q?CkzE0TiY6e4+YRwoibZrBqz1VLjQECinz6D8DeApqnXWjOktJUKFvAbslZer?=
 =?us-ascii?Q?jaocrzxDRjZ/8haJ0O94TRmuoyfBk8JZWoLSYAEFLwyuI/qOyVE9Ur/ZlWVP?=
 =?us-ascii?Q?aHwQWQekT70C1xbjFPVZYRB+AKiV5/Q+DrZX6U2KnIilL2G9hRffWK5nQwzx?=
 =?us-ascii?Q?ATBaXRtbxUyo3/bC4Jj6zNTiDgHOxNsngTes7UrZH2aunKwRCTpkvXf1gxLc?=
 =?us-ascii?Q?T3vJISVBQF6G0geUWsX0YpEvgTAMtcYktvdq8Gd75GKxTkYIrOoVL1rotnWU?=
 =?us-ascii?Q?3uVuxloI/9dXARjEwK17Px8vMsYkaFcybEIzX3LdAM0z67NUk4ntd49FxJny?=
 =?us-ascii?Q?2pQxjHnfbBRD2DLexgB0KQtkOQwE6x7gtFcr9YavYmqIJT4fbPkBIW1fLOpj?=
 =?us-ascii?Q?pBBcx6saXwhPd5+v/14ILFAgNDdWbVDJ2NKFZSInO/oda2J06rDlfEHAyJc1?=
 =?us-ascii?Q?8GFBp3k3Wr4WKccDgNO6u884muaL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(82310400017)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 15:57:03.7636
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ce2a04-4caf-40d7-200c-08dc7b40fd55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8849

Scalable MCA systems have a per-CPU register that gives the APIC LVT
offset for the thresholding and deferred error interrupts.

Currently, this register is read once to set up the deferred error
interrupt and then read again for each thresholding block. Furthermore,
the APIC LVT registers are configured each time, but they only need to
be configured once per-CPU.

Move the APIC LVT setup to the early part of CPU init, so that the
registers are set up once. Also, this ensures that the kernel is ready
to service the interrupts before the individual error sources (each MCA
bank) are enabled.

Apply this change only to SMCA systems to avoid breaking any legacy
behavior. The deferred error interrupt is technically advertised by the
SUCCOR feature. However, this was first made available on SMCA systems.
Therefore, only set up the deferred error interrupt on SMCA systems and
simplify the code.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 116 +++++++++++++++-------------------
 1 file changed, 52 insertions(+), 64 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index c6594da95340..7acaa21e11e1 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -46,9 +46,6 @@
 /* Deferred error settings */
 #define MSR_CU_DEF_ERR		0xC0000410
 #define MASK_DEF_LVTOFF		0x000000F0
-#define MASK_DEF_INT_TYPE	0x00000006
-#define DEF_LVT_OFF		0x2
-#define DEF_INT_TYPE_APIC	0x2
 
 /* Scalable MCA: */
 
@@ -58,6 +55,8 @@
 static bool thresholding_irq_en;
 static DEFINE_PER_CPU_READ_MOSTLY(mce_banks_t, mce_thr_intr_banks);
 static DEFINE_PER_CPU_READ_MOSTLY(mce_banks_t, mce_dfr_intr_banks);
+static DEFINE_PER_CPU_READ_MOSTLY(bool, smca_thr_intr_enabled);
+static DEFINE_PER_CPU_READ_MOSTLY(bool, smca_dfr_intr_enabled);
 
 static const char * const th_names[] = {
 	"load_store",
@@ -297,7 +296,8 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 		 * APIC based interrupt. First, check that no interrupt has been
 		 * set.
 		 */
-		if ((low & BIT(5)) && !((high >> 5) & 0x3)) {
+		if ((low & BIT(5)) && !((high >> 5) & 0x3) &&
+		    this_cpu_read(smca_dfr_intr_enabled)) {
 			__set_bit(bank, this_cpu_ptr(mce_dfr_intr_banks));
 			high |= BIT(5);
 		}
@@ -389,6 +389,14 @@ static int lvt_off_valid(struct threshold_block *b, int apic, u32 lo, u32 hi)
 {
 	int msr = (hi & MASK_LVTOFF_HI) >> 20;
 
+	/*
+	 * On SMCA CPUs, LVT offset is programmed at a different MSR, and
+	 * the BIOS provides the value. The original field where LVT offset
+	 * was set is reserved. Return early here:
+	 */
+	if (mce_flags.smca)
+		return 0;
+
 	if (apic < 0) {
 		pr_err(FW_BUG "cpu %d, failed to setup threshold interrupt "
 		       "for bank %d, block %d (MSR%08X=0x%x%08x)\n", b->cpu,
@@ -397,14 +405,6 @@ static int lvt_off_valid(struct threshold_block *b, int apic, u32 lo, u32 hi)
 	}
 
 	if (apic != msr) {
-		/*
-		 * On SMCA CPUs, LVT offset is programmed at a different MSR, and
-		 * the BIOS provides the value. The original field where LVT offset
-		 * was set is reserved. Return early here:
-		 */
-		if (mce_flags.smca)
-			return 0;
-
 		pr_err(FW_BUG "cpu %d, invalid threshold interrupt offset %d "
 		       "for bank %d, block %d (MSR%08X=0x%x%08x)\n",
 		       b->cpu, apic, b->bank, b->block, b->address, hi, lo);
@@ -485,41 +485,6 @@ static int setup_APIC_mce_threshold(int reserved, int new)
 	return reserved;
 }
 
-static int setup_APIC_deferred_error(int reserved, int new)
-{
-	if (reserved < 0 && !setup_APIC_eilvt(new, DEFERRED_ERROR_VECTOR,
-					      APIC_EILVT_MSG_FIX, 0))
-		return new;
-
-	return reserved;
-}
-
-static void deferred_error_interrupt_enable(struct cpuinfo_x86 *c)
-{
-	u32 low = 0, high = 0;
-	int def_offset = -1, def_new;
-
-	if (rdmsr_safe(MSR_CU_DEF_ERR, &low, &high))
-		return;
-
-	def_new = (low & MASK_DEF_LVTOFF) >> 4;
-	if (!(low & MASK_DEF_LVTOFF)) {
-		pr_err(FW_BUG "Your BIOS is not setting up LVT offset 0x2 for deferred error IRQs correctly.\n");
-		def_new = DEF_LVT_OFF;
-		low = (low & ~MASK_DEF_LVTOFF) | (DEF_LVT_OFF << 4);
-	}
-
-	def_offset = setup_APIC_deferred_error(def_offset, def_new);
-	if ((def_offset == def_new) &&
-	    (deferred_error_int_vector != amd_deferred_error_interrupt))
-		deferred_error_int_vector = amd_deferred_error_interrupt;
-
-	if (!mce_flags.smca)
-		low = (low & ~MASK_DEF_INT_TYPE) | DEF_INT_TYPE_APIC;
-
-	wrmsr(MSR_CU_DEF_ERR, low, high);
-}
-
 static u32 smca_get_block_address(unsigned int bank, unsigned int block,
 				  unsigned int cpu)
 {
@@ -565,7 +530,6 @@ prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
 			int offset, u32 misc_high)
 {
 	unsigned int cpu = smp_processor_id();
-	u32 smca_low, smca_high;
 	struct threshold_block b;
 	int new;
 
@@ -585,18 +549,10 @@ prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
 	__set_bit(bank, this_cpu_ptr(mce_thr_intr_banks));
 	b.interrupt_enable = 1;
 
-	if (!mce_flags.smca) {
-		new = (misc_high & MASK_LVTOFF_HI) >> 20;
-		goto set_offset;
-	}
-
-	/* Gather LVT offset for thresholding: */
-	if (rdmsr_safe(MSR_CU_DEF_ERR, &smca_low, &smca_high))
-		goto out;
-
-	new = (smca_low & SMCA_THR_LVT_OFF) >> 12;
+	if (mce_flags.smca)
+		goto done;
 
-set_offset:
+	new = (misc_high & MASK_LVTOFF_HI) >> 20;
 	offset = setup_APIC_mce_threshold(offset, new);
 	if (offset == new)
 		thresholding_irq_en = true;
@@ -604,7 +560,6 @@ prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
 done:
 	mce_threshold_block_init(&b, offset);
 
-out:
 	return offset;
 }
 
@@ -673,6 +628,37 @@ static void disable_err_thresholding(struct cpuinfo_x86 *c, unsigned int bank)
 		wrmsrl(MSR_K7_HWCR, hwcr);
 }
 
+/*
+ * Enable the APIC LVT interrupt vectors once per-CPU. This should be done before hardware is
+ * ready to send interrupts.
+ *
+ * Individual error sources are enabled later during per-bank init.
+ */
+static void smca_enable_interrupt_vectors(struct cpuinfo_x86 *c)
+{
+	u8 thr_offset, dfr_offset;
+	u64 mca_intr_cfg;
+
+	if (!mce_flags.smca || !mce_flags.succor)
+		return;
+
+	if (c == &boot_cpu_data) {
+		mce_threshold_vector		= amd_threshold_interrupt;
+		deferred_error_int_vector	= amd_deferred_error_interrupt;
+	}
+
+	if (rdmsrl_safe(MSR_CU_DEF_ERR, &mca_intr_cfg))
+		return;
+
+	thr_offset = (mca_intr_cfg & SMCA_THR_LVT_OFF) >> 12;
+	if (!setup_APIC_eilvt(thr_offset, THRESHOLD_APIC_VECTOR, APIC_EILVT_MSG_FIX, 0))
+		this_cpu_write(smca_thr_intr_enabled, true);
+
+	dfr_offset = (mca_intr_cfg & MASK_DEF_LVTOFF) >> 4;
+	if (!setup_APIC_eilvt(dfr_offset, DEFERRED_ERROR_VECTOR, APIC_EILVT_MSG_FIX, 0))
+		this_cpu_write(smca_dfr_intr_enabled, true);
+}
+
 /* cpu init entry point, called from mce.c with preempt off */
 void mce_amd_feature_init(struct cpuinfo_x86 *c)
 {
@@ -680,11 +666,16 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 	u32 low = 0, high = 0, address = 0;
 	int offset = -1;
 
+	smca_enable_interrupt_vectors(c);
 
 	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
-		if (mce_flags.smca)
+		if (mce_flags.smca) {
 			smca_configure(bank, cpu);
 
+			if (!this_cpu_read(smca_thr_intr_enabled))
+				continue;
+		}
+
 		disable_err_thresholding(c, bank);
 
 		for (block = 0; block < NR_BLOCKS; ++block) {
@@ -705,9 +696,6 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 			offset = prepare_threshold_block(bank, block, address, offset, high);
 		}
 	}
-
-	if (mce_flags.succor)
-		deferred_error_interrupt_enable(c);
 }
 
 /*
-- 
2.34.1


