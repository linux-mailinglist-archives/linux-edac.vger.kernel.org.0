Return-Path: <linux-edac+bounces-1652-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 253D1953C79
	for <lists+linux-edac@lfdr.de>; Thu, 15 Aug 2024 23:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A47FD1F25408
	for <lists+linux-edac@lfdr.de>; Thu, 15 Aug 2024 21:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAB715098F;
	Thu, 15 Aug 2024 21:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iBS7vNCg"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CD914F9D6;
	Thu, 15 Aug 2024 21:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723756629; cv=fail; b=SDLG/DncIcWe/Atvaa/s1B4Ulpf/0CSZCEcr98jFXeANIIH5DuDELcraqFkvEarn8h3mnAYJHSlrQ/tD7OulJPCu4j5Yq2HmIGPhAmqcKJ9qTO72IrE+42WK+WUhJCwMLCLy1jie3616eL67NK3S+J9uNAQCSkJg/zpBsAHrsgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723756629; c=relaxed/simple;
	bh=uxfDlzVwTxK1Mi9W1OsRQ6qMjOpDZW16yxpVrkqdqGo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ImTTn7qQLHLjAzywxd+d6Ecm6WXrWMQDKG6nlt/2e2u3VAeR9QD8SuxQ/C7lXE04NA9EzaRKIba5ebmb06h9e44FjuWGW9V9nK2GeLXkgFx3ymZpCGjzSlkH9Lt9C1dhi5Wm/LAJjeob3jUCTJbAcqfj+z718voNL5e+CJ7sOGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iBS7vNCg; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KPYb1JA0JsVDfCUvd720sK0s4gY1UM0PrxKais5KPGEQL0nI2T/E/dg86GQU5pqTwDg3Sx8HzdnSCLf1na+ZOMX7rKdA240cuS8naBuKEGn7ZcqjXVIznJQDprb89yLIPNCwuSot8/MfKoFt78Ef66eArMw74fyz+H/dBxl1w+5pZq+bVR9ug+rgT+dkstjLVnITTdOCZEr6Fy1oxHFe0UljqpFsgQSqkveF/aGsWu6HlcY7OJArO96qbJ89eMdVDgETfdPCIz35hXGDdgWquRWv/XctVQWvuqyAr2/3GYIacpQ39Mlmq67UMJl2KNx0fGj4D4m1h57iQeiYcIHFJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOCYn6pobE4VbgLOy1ZnZ9c+SYyITz/SW9D4W17eJi8=;
 b=o8U3gi7DKiEiM4K7lQILrTeVgA+FSXvJrtl7rS8ajEZwXcJGacaNv0q9CNR1NCo0U3C9WAFGbt7/vXdzYOKs3/RAXozXAXTP1T8sW5IbCijlT5niVYyCSxvRx7TaN3qvN2ANkdGZfQJPLQwRp5ig7V/1FrmIzrv9B4k5ahC7/MNi/NrlqZNDdGhTxonV0mep70xZ453SU4QTB5/z0iGI7PThBMPRhbfvxWlODpO2vLkQCrvf/hlhSohSkJrb25qMj/PcBrpoCPKpMMcYHMrKxoQuV33l82rWaDmmMm/vdrwSfPa4uXFZL2Eg3ZRwWxBVbuIev9xk/n4pfm1MV4O7Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOCYn6pobE4VbgLOy1ZnZ9c+SYyITz/SW9D4W17eJi8=;
 b=iBS7vNCgiBaf/dOnigPo1VOh7Ky5ygRlIBJ/hsZUCdwqIVf5Se0Rx8rf4orxp23i38QiloPVLgncABZJXcpg0JTIzvoc3UVed2lc98GWA0Cxe7YTXDTeRDCBco+q4hSGGDEqMiCzBFWQ3Ebv1seEqbTe186vq4D6JclLaUwP05s=
Received: from BL1PR13CA0434.namprd13.prod.outlook.com (2603:10b6:208:2c3::19)
 by PH7PR12MB7354.namprd12.prod.outlook.com (2603:10b6:510:20d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Thu, 15 Aug
 2024 21:17:05 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:2c3:cafe::d8) by BL1PR13CA0434.outlook.office365.com
 (2603:10b6:208:2c3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22 via Frontend
 Transport; Thu, 15 Aug 2024 21:17:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 21:17:04 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 16:17:03 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <x86@kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<rafael@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<rostedt@goodmis.org>, <lenb@kernel.org>, <mchehab@kernel.org>,
	<james.morse@arm.com>, <airlied@gmail.com>, <yazen.ghannam@amd.com>,
	<john.allen@amd.com>, <avadnaik@amd.com>
Subject: [PATCH v4 2/4] x86/mce, EDAC/mce_amd: Add support for new MCA_SYND{1,2} registers
Date: Thu, 15 Aug 2024 16:16:33 -0500
Message-ID: <20240815211635.1336721-3-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815211635.1336721-1-avadhut.naik@amd.com>
References: <20240815211635.1336721-1-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|PH7PR12MB7354:EE_
X-MS-Office365-Filtering-Correlation-Id: f1505a9d-803b-4f22-665f-08dcbd6f9ca9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pjaIWNS56saeranCyLcYxrzaQ0jLEruQQvmLGCnUPn0duk3XyJrHYolc7A7S?=
 =?us-ascii?Q?Twsj8cg65JIqzSZ1esRfB9fUCTZK0cr4/fUqh/Wi9hY5kF0yFJFcbqFpgDLG?=
 =?us-ascii?Q?ffQloqAQbrnyKpv+SYMY1O+kCKz8WIbiGezEgh5u8aye3b/ETzLD94G45PvC?=
 =?us-ascii?Q?8NkpPDHI1BGYKIW4F+wnpbvz3AMJsAQj6pbGOVOlfmtsesJjh9SrYxroiTzc?=
 =?us-ascii?Q?OjQqJD7G3kVITHNCT8ds96gChTRZU49DTTln2x342mkk3sAvU8p3N3z+a0/j?=
 =?us-ascii?Q?qYB4yUqA7JnOSUSI1oGq64KhKuHcKnQ0wYc2m7DY37gWNOvr7x0sYgUna0ho?=
 =?us-ascii?Q?xNs5kNvdVk8Pl4a1rk6ibsBpnt8ridoHtWgN8VW8rbNSJXnth8CX0uNJDodn?=
 =?us-ascii?Q?CWYehANUxSF/1ONmv1l9CpcCLkT0T5Jx4Uh5TDUPbJj3Pd+/RRxQgO8XlLsk?=
 =?us-ascii?Q?ZMrafKxIx5T/192g+fy9Et3xlDUVBPpKn3gXrGeGOP+Ro1VZ4F+hOXn3cGzv?=
 =?us-ascii?Q?cCvCQpOs+wIRUK3yZ7WKE+YHY/r5AoeM/thmkFBC2COLPdlT7EHq0E0qQ/iG?=
 =?us-ascii?Q?uax4nqqixb69AWPbmtVMTGyfOy9wS1qSxjUoMGMPLCD04A5NPFjvbcdSqYPN?=
 =?us-ascii?Q?3nLKlIKgTXEKnCLx41lK7bzYAhZFnqykuusp2m63Qv4+CfZr0fSytZ06knWO?=
 =?us-ascii?Q?tiqI4IzvnY05FYRRQYQAapiCkXL31ePfDp9+53nWrKZvYu+m8LLzzp5f5ejY?=
 =?us-ascii?Q?VOzYGH56+Hlo4h3JW3K+198B5Ao/SSuK8paK8fAaR9YSisjUXzEO/5DQDkSe?=
 =?us-ascii?Q?sLhVenH6KrtqDLaEILOGxxqD0ekQdDUQ4ohcZeXD6YeXcVDuRqA282/a2cHT?=
 =?us-ascii?Q?SZdH9f/LoAcZINe0F9a6gXBaeG/hks+QOdRUUaGC/9bb3xWi91mkMvGxHPqi?=
 =?us-ascii?Q?7WaDzuTIgcbG4trwdDbiw1V+M1NkXm5sT2FbbLDgF8bgpXAqApzY/7QHwSOH?=
 =?us-ascii?Q?ego8hNbUa/H3LKenCgeRPl+wtjbMFxM4nwGy+l0jSOb7PXURde9j41Tt3kxS?=
 =?us-ascii?Q?foGe7cQxjYtinr/YnvtKdIwmdBno81G49pXGHHASGzyXtwrdHJpgo/DyeTZM?=
 =?us-ascii?Q?vooP+Gvwb7j53bfhikBgh9VITF5oGtwycdSgSIaPP+4dWiOH7/XiKTuDyM32?=
 =?us-ascii?Q?GX3RnvXQotQdYHRiJWm2RI9YqICQniml9tGUZE8swiyCltCsry2p/FHKJRLY?=
 =?us-ascii?Q?MPTRSMoEpJrVSZ9+qiba1MJbLsnUmVkIJhQkVMMGm3V8EDduakd58VO/0x0q?=
 =?us-ascii?Q?mNpsjSHwCIkBitWwudpbQSs9+KxDegUaILGLGxwU65BtjbxUM2mhMZywbPMB?=
 =?us-ascii?Q?ESBBlhOCM+3PmfegkGmxAgIZF4rm4uZeyalJulGHK5szMePxOtI/8FRQ6RlT?=
 =?us-ascii?Q?NG2P2pptMyZu9eejZmuNoVawKqJFm50FQoRDDIaC8zviW9kJY46vZA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 21:17:04.6353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1505a9d-803b-4f22-665f-08dcbd6f9ca9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7354

Starting with Zen4, AMD's Scalable MCA systems incorporate two new
registers: MCA_SYND1 and MCA_SYND2.

These registers will include supplemental error information in addition
to the existing MCA_SYND register. The data within these registers is
considered valid if MCA_STATUS[SyndV] is set.

Userspace error decoding tools like the rasdaemon gather related hardware
error information through the tracepoints. As such, these two registers
should be exported through the mce_record tracepoint so that tools like
rasdaemon can parse them and output the supplemental error information
like FRU Text contained in them.

[Yazen: Drop Yazen's Co-developed-by tag and moved SoB tag.]

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
---
Changes in v2:
[1] https://lore.kernel.org/linux-edac/20240521125434.1555845-1-yazen.ghannam@amd.com/
[2] https://lore.kernel.org/linux-edac/20240523155641.2805411-1-yazen.ghannam@amd.com/

1. Drop dependencies on sets [1] and [2] above and rebase on top of
tip/master.

Changes in v3:
1. Move wrapper changes required in mce_read_aux() and mce_no_way_out()
from this patch to the first patch.
2. Add comments to explain the new wrapper's purpose.
3. Modify commit message per feedback received.
4. Fix SoB chain to properly reflect the patch path.

Changes in v4:
1. Rebase on top of tip/master to avoid merge conflicts.
---
 arch/x86/include/asm/mce.h      | 22 ++++++++++++++++++++++
 arch/x86/include/uapi/asm/mce.h |  3 ++-
 arch/x86/kernel/cpu/mce/amd.c   |  5 ++++-
 arch/x86/kernel/cpu/mce/core.c  |  9 ++++++++-
 drivers/edac/mce_amd.c          | 10 +++++++---
 include/trace/events/mce.h      |  9 +++++++--
 6 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 3c86b838b541..a977c10875a0 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -122,6 +122,9 @@
 #define MSR_AMD64_SMCA_MC0_DESTAT	0xc0002008
 #define MSR_AMD64_SMCA_MC0_DEADDR	0xc0002009
 #define MSR_AMD64_SMCA_MC0_MISC1	0xc000200a
+/* Registers MISC2 to MISC4 are at offsets B to D. */
+#define MSR_AMD64_SMCA_MC0_SYND1	0xc000200e
+#define MSR_AMD64_SMCA_MC0_SYND2	0xc000200f
 #define MSR_AMD64_SMCA_MCx_CTL(x)	(MSR_AMD64_SMCA_MC0_CTL + 0x10*(x))
 #define MSR_AMD64_SMCA_MCx_STATUS(x)	(MSR_AMD64_SMCA_MC0_STATUS + 0x10*(x))
 #define MSR_AMD64_SMCA_MCx_ADDR(x)	(MSR_AMD64_SMCA_MC0_ADDR + 0x10*(x))
@@ -132,6 +135,8 @@
 #define MSR_AMD64_SMCA_MCx_DESTAT(x)	(MSR_AMD64_SMCA_MC0_DESTAT + 0x10*(x))
 #define MSR_AMD64_SMCA_MCx_DEADDR(x)	(MSR_AMD64_SMCA_MC0_DEADDR + 0x10*(x))
 #define MSR_AMD64_SMCA_MCx_MISCy(x, y)	((MSR_AMD64_SMCA_MC0_MISC1 + y) + (0x10*(x)))
+#define MSR_AMD64_SMCA_MCx_SYND1(x)	(MSR_AMD64_SMCA_MC0_SYND1 + 0x10*(x))
+#define MSR_AMD64_SMCA_MCx_SYND2(x)	(MSR_AMD64_SMCA_MC0_SYND2 + 0x10*(x))
 
 #define XEC(x, mask)			(((x) >> 16) & mask)
 
@@ -190,9 +195,26 @@ enum mce_notifier_prios {
 /**
  * struct mce_hw_err - Hardware Error Record.
  * @m:		Machine Check record.
+ * @vendor:	Vendor-specific error information.
+ *
+ * Vendor-specific fields should not be added to struct mce.
+ * Instead, vendors should export their vendor-specific data
+ * through their structure in the vendor union below.
+ *
+ * AMD's vendor data is parsed by error decoding tools for
+ * supplemental error information. Thus, current offsets of
+ * existing fields must be maintained.
+ * Only add new fields at the end of AMD's vendor structure.
  */
 struct mce_hw_err {
 	struct mce m;
+
+	union vendor_info {
+		struct {
+			u64 synd1;		/* MCA_SYND1 MSR */
+			u64 synd2;		/* MCA_SYND2 MSR */
+		} amd;
+	} vendor;
 };
 
 struct notifier_block;
diff --git a/arch/x86/include/uapi/asm/mce.h b/arch/x86/include/uapi/asm/mce.h
index db9adc081c5a..cb6b48a7c22b 100644
--- a/arch/x86/include/uapi/asm/mce.h
+++ b/arch/x86/include/uapi/asm/mce.h
@@ -8,7 +8,8 @@
 /*
  * Fields are zero when not available. Also, this struct is shared with
  * userspace mcelog and thus must keep existing fields at current offsets.
- * Only add new fields to the end of the structure
+ * Only add new, shared fields to the end of the structure.
+ * Do not add vendor-specific fields.
  */
 struct mce {
 	__u64 status;		/* Bank's MCi_STATUS MSR */
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 5b4d266500b2..6ca80fff1fea 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -797,8 +797,11 @@ static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
 	if (mce_flags.smca) {
 		rdmsrl(MSR_AMD64_SMCA_MCx_IPID(bank), m->ipid);
 
-		if (m->status & MCI_STATUS_SYNDV)
+		if (m->status & MCI_STATUS_SYNDV) {
 			rdmsrl(MSR_AMD64_SMCA_MCx_SYND(bank), m->synd);
+			rdmsrl(MSR_AMD64_SMCA_MCx_SYND1(bank), err.vendor.amd.synd1);
+			rdmsrl(MSR_AMD64_SMCA_MCx_SYND2(bank), err.vendor.amd.synd2);
+		}
 	}
 
 	mce_log(&err);
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index d9d1af7227ce..280d538dc13b 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -202,6 +202,10 @@ static void __print_mce(struct mce_hw_err *err)
 	if (mce_flags.smca) {
 		if (m->synd)
 			pr_cont("SYND %llx ", m->synd);
+		if (err->vendor.amd.synd1)
+			pr_cont("SYND1 %llx ", err->vendor.amd.synd1);
+		if (err->vendor.amd.synd2)
+			pr_cont("SYND2 %llx ", err->vendor.amd.synd2);
 		if (m->ipid)
 			pr_cont("IPID %llx ", m->ipid);
 	}
@@ -679,8 +683,11 @@ static noinstr void mce_read_aux(struct mce_hw_err *err, int i)
 	if (mce_flags.smca) {
 		m->ipid = mce_rdmsrl(MSR_AMD64_SMCA_MCx_IPID(i));
 
-		if (m->status & MCI_STATUS_SYNDV)
+		if (m->status & MCI_STATUS_SYNDV) {
 			m->synd = mce_rdmsrl(MSR_AMD64_SMCA_MCx_SYND(i));
+			err->vendor.amd.synd1 = mce_rdmsrl(MSR_AMD64_SMCA_MCx_SYND1(i));
+			err->vendor.amd.synd2 = mce_rdmsrl(MSR_AMD64_SMCA_MCx_SYND2(i));
+		}
 	}
 }
 
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index c5fae99de781..aea68999c849 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -792,7 +792,8 @@ static const char *decode_error_status(struct mce *m)
 static int
 amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 {
-	struct mce *m = &((struct mce_hw_err *)data)->m;
+	struct mce_hw_err *err = (struct mce_hw_err *)data;
+	struct mce *m = &err->m;
 	unsigned int fam = x86_family(m->cpuid);
 	int ecc;
 
@@ -850,8 +851,11 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 	if (boot_cpu_has(X86_FEATURE_SMCA)) {
 		pr_emerg(HW_ERR "IPID: 0x%016llx", m->ipid);
 
-		if (m->status & MCI_STATUS_SYNDV)
-			pr_cont(", Syndrome: 0x%016llx", m->synd);
+		if (m->status & MCI_STATUS_SYNDV) {
+			pr_cont(", Syndrome: 0x%016llx\n", m->synd);
+			pr_emerg(HW_ERR "Syndrome1: 0x%016llx, Syndrome2: 0x%016llx",
+				 err->vendor.amd.synd1, err->vendor.amd.synd2);
+		}
 
 		pr_cont("\n");
 
diff --git a/include/trace/events/mce.h b/include/trace/events/mce.h
index 65aba1afcd07..1e7d5696b3ba 100644
--- a/include/trace/events/mce.h
+++ b/include/trace/events/mce.h
@@ -43,6 +43,8 @@ TRACE_EVENT(mce_record,
 		__field(	u8,		bank		)
 		__field(	u8,		cpuvendor	)
 		__field(	u32,		microcode	)
+		__field(	u8,		len	)
+		__dynamic_array(u8, v_data, sizeof(err->vendor))
 	),
 
 	TP_fast_assign(
@@ -65,9 +67,11 @@ TRACE_EVENT(mce_record,
 		__entry->bank		= err->m.bank;
 		__entry->cpuvendor	= err->m.cpuvendor;
 		__entry->microcode	= err->m.microcode;
+		__entry->len		= sizeof(err->vendor);
+		memcpy(__get_dynamic_array(v_data), &err->vendor, sizeof(err->vendor));
 	),
 
-	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR: %016Lx, MISC: %016Lx, SYND: %016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, vendor: %u, CPUID: %x, time: %llu, socket: %u, APIC: %x, microcode: %x",
+	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016llx, IPID: %016llx, ADDR: %016llx, MISC: %016llx, SYND: %016llx, RIP: %02x:<%016llx>, TSC: %llx, PPIN: %llx, vendor: %u, CPUID: %x, time: %llu, socket: %u, APIC: %x, microcode: %x, vendor data: %s",
 		__entry->cpu,
 		__entry->mcgcap, __entry->mcgstatus,
 		__entry->bank, __entry->status,
@@ -83,7 +87,8 @@ TRACE_EVENT(mce_record,
 		__entry->walltime,
 		__entry->socketid,
 		__entry->apicid,
-		__entry->microcode)
+		__entry->microcode,
+		__print_array(__get_dynamic_array(v_data), __entry->len / 8, 8))
 );
 
 #endif /* _TRACE_MCE_H */
-- 
2.34.1


