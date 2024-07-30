Return-Path: <linux-edac+bounces-1594-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1BF942018
	for <lists+linux-edac@lfdr.de>; Tue, 30 Jul 2024 20:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E93C1F24C88
	for <lists+linux-edac@lfdr.de>; Tue, 30 Jul 2024 18:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891DB18C91D;
	Tue, 30 Jul 2024 18:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IkjBlqVs"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44CA18C90D;
	Tue, 30 Jul 2024 18:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722365682; cv=fail; b=se7vYBykYZl/woah6ABQa6mTNctHgpzVTLARzlKxKkP21GyHZa9WNn/KDPCI7tBgJJKb40kNxMQhaTIohKfOsOA4+2lYph6aMlIucok2yg59Va7U25x5NSqo1SjZtAj55/cDzGrORog2WK7uGIskfBQaXIA/LbVDFgLVHUk6NfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722365682; c=relaxed/simple;
	bh=/TGdEzfJG6fHGvfmyb0ol5L2Tf+4+bfmDz0nN4p/QgE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KfKrwG24nMFE6wGzVUdcYLtuXJS4cL4m3fiCLIINxvn8LR+DjrXyy8a6Dm/Oa/wMSn1m5+pCv80GNwiJQFbZ01ebjD8mONW88wSDrpkJ56M9Ev98PQG+dduMpngqGUB+LMF6tvghr2sMH+uVaG4HjxhVSTSd6ACYvVosLsrVsGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IkjBlqVs; arc=fail smtp.client-ip=40.107.244.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RkuIvM1fnzdb/Z439CWdVxhM0B1BFkvdYKlNBKnAXCx3e/yPPNF+SFDMQY5BHPNK9DC1DlsMvryn7nHcWgjWm00zgfAbmj8OwPCTQwhZlwpCopkHaSL9/OMhT6lgwH9XvgTuZAaMO9dGO0rxnoGWJampsu2uDP8G0kO0JD3NGoKzm9KOAuWqzaWkLn5r4vnSfugbuer1eZCB3NYrdeJQ2GWGJdWFqVyEKkVEaoq3bzgSqHoREm7EpAmESjoR9V8i6KeRXN2qNXwgHQFFfp0y9swwAuWkfGxCHRYrYh6jznLQ9cB/OOSWRY6JsLyZySxL7SjB6BayL+5fBGQAxzgWdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3n+Gagvt6fKsxtxxZUG9c7b7tjl2i85G9FN0gv9XLk=;
 b=wgLEssULPs4jBj4kjkUW8u+OiLMEQ6yXhUpuqHCuBEvyKKhPPTd/pOidc/vqTozm5GDPcoqrkklFD69F3TakC42XKwMddwpDaqMw+zW/0Ox49XSMpWcrdeHrYspLx1AgTJ2epm7FdXvtF5+xCdnmhFFOAb3S9JcB/tsisECYVS8hlxwqlNrZsrHEWcbaDYr4N+9D9FbLSVDpu34CRL08MC5U55HvEJClsVwYwhbWvWIrH+KgJZSTino0rn6WcXIYM3OB1xrvrZ3e2aWkkHe3eGG05PW/D/UvpfsihYmWFulpx6cX4fb+MpO9qy6dkRfrQ5jksVlqeAX43B83zY+rVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3n+Gagvt6fKsxtxxZUG9c7b7tjl2i85G9FN0gv9XLk=;
 b=IkjBlqVsJouO34Kx5DxMIKn4bfOpiksQpkJuuYghhS/dy01sJJlwgief7IZ63LTFu4OAbZoG//kzOoUdtWZBoXSeCbYWXrP49ANad1jIEfCKy/PUPnQtgTwPn5xqmqDIEl1MmUEJeZSgmHpACak961ObuMLr3qrVauxUzlqG6Lk=
Received: from CH2PR17CA0026.namprd17.prod.outlook.com (2603:10b6:610:53::36)
 by BY5PR12MB4049.namprd12.prod.outlook.com (2603:10b6:a03:201::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 18:54:37 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::61) by CH2PR17CA0026.outlook.office365.com
 (2603:10b6:610:53::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Tue, 30 Jul 2024 18:54:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 18:54:36 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 30 Jul 2024 13:54:35 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <x86@kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<rafael@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<rostedt@goodmis.org>, <lenb@kernel.org>, <mchehab@kernel.org>,
	<james.morse@arm.com>, <airlied@gmail.com>, <yazen.ghannam@amd.com>,
	<john.allen@amd.com>, <avadnaik@amd.com>
Subject: [PATCH v3 2/4] x86/mce, EDAC/mce_amd: Add support for new MCA_SYND{1,2} registers
Date: Tue, 30 Jul 2024 13:54:04 -0500
Message-ID: <20240730185406.3709876-3-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730185406.3709876-1-avadhut.naik@amd.com>
References: <20240730185406.3709876-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|BY5PR12MB4049:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f4d02e2-4c80-4852-4bb7-08dcb0c90f00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MtxmP5aqNwXu/HbvxG/xSoERFIO5IkV/fV2V11lt//oLeNh6Tc0aGgN8D0bS?=
 =?us-ascii?Q?YoR/2AxTPch3A2OEis6eEt2I7FPckbnSJdW6HPE+cs75tHWfMc6hXRt+5iaU?=
 =?us-ascii?Q?30j582ZDcIe7Wd8MPj0WwoO+LIuK2i4+0fk5/vEBe5/8+VLuM+c8Ba803kqL?=
 =?us-ascii?Q?32LzI+5rWu+gYx79k2u6LsvsWQXNtD2f0R9Pos93eGIVcIqXZmYMQoHieaYi?=
 =?us-ascii?Q?t/VJ5QtZFqNsOkgK7hL8VKFXsNPOasZKfdm0ltgB0wAnRshVbfHY1OuX6SNT?=
 =?us-ascii?Q?d4T5+Gju1/t34Lg/SOUUkN1WMX+PTV7AhdLopLsOrj0WgByiJ7gLAG641I6e?=
 =?us-ascii?Q?xt8DdjlOSWHBScjSii73TkdNrtzfsX3dM+aI2namUJqb8yYnXabwwhLaGbJo?=
 =?us-ascii?Q?w3LuUfvu8OjNu5kqKjLZubV1t7A4TV7uM1MP4Dw8d27gIXymsvGXoSYFBcuo?=
 =?us-ascii?Q?cE6+6A+eysS09wDL8REKz8pVZCWgN7M/mJAMcGxPlRieeiJSGtNfSQz4zuZ7?=
 =?us-ascii?Q?E/nvtXvIekmIngb4fN6xADdrtM05MHlPpuspWEVaFAXqHWn9opmzWjEDSlvi?=
 =?us-ascii?Q?LUaVCCqxeHDttLqgeHrRQvN6jStftoIeEpRAy31G6hAb4ITwXFPV9VU0DE7b?=
 =?us-ascii?Q?uoeE1+MGPbxxa1tSHsmTAcJxILg2kCZl8kGXg22oc7Y2nje3+SoOXpaJs21q?=
 =?us-ascii?Q?o+P/0TbiDVzFXuNIjvh+lOHE6vG4QqKTHinSxvxLwBfY0GcDbfqBuLbSHi5F?=
 =?us-ascii?Q?rVa9NOVsZC4Hd7PrlWs3BP+jVWXgseeBjX5ceyBxRxHL6C/PM47hp0lnfkOZ?=
 =?us-ascii?Q?OgERIWUl6geged3UzqT8kUbHS2Gl7TBzqjOPxJLshbtBTyhY5uuEE5sZkwLK?=
 =?us-ascii?Q?gFULl77kI+XFSvIfgB1k3yyLCfWEAEiaHuMV2BuZTrRBBBKgthzYHyrDn2qa?=
 =?us-ascii?Q?xlVpqOZo3JnQsWKBx9z8cQyukEpFDJwm2n+AUJwvPjL/mRoJHDm4NQO+Ug6f?=
 =?us-ascii?Q?REkPpL5bOUBitnJHTGGRpxawTI+sP+7lrNjSVySDqLJ3nD0mvJecLFtwrbps?=
 =?us-ascii?Q?u7SoX5UBP1vEDOTpS3bAbLkLf077ky5rfyLngMsAkP3iZkoIpAsbBS8UhQZC?=
 =?us-ascii?Q?pcbgaN89Kqb5V3KA2PWwpdSyoSkC20Mnay6Mv0q8x1opf1RGdsxAi15TdARf?=
 =?us-ascii?Q?tijvDpOKW+4eSKfHgSOvoWzM9I72e9s0g6wbSPv2XAa1pQlylvIYb9D+gACV?=
 =?us-ascii?Q?lsbh5GhasRwR94b23ih62aqDwiAiL+LL3IA4kBzE7GqzUih1rPa2uJouyWpI?=
 =?us-ascii?Q?KQORg3mKkqN91h0E67N68urQzTFcndQX6Ep5Onlx0jUtJrWYv0lwzqpCmUCM?=
 =?us-ascii?Q?vsNkAglkXruVC2QUhTF7UVvm4Gej9DkWDCqAqmv3FahgnZQAcQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 18:54:36.5422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4d02e2-4c80-4852-4bb7-08dcb0c90f00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4049

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
---
 arch/x86/include/asm/mce.h      | 22 ++++++++++++++++++++++
 arch/x86/include/uapi/asm/mce.h |  3 ++-
 arch/x86/kernel/cpu/mce/amd.c   |  5 ++++-
 arch/x86/kernel/cpu/mce/core.c  |  9 ++++++++-
 drivers/edac/mce_amd.c          | 10 +++++++---
 include/trace/events/mce.h      |  9 +++++++--
 6 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index ba2b3a5f999e..a5be7463c78a 100644
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
index cb7dc0b1aa50..a2a5fb940bb6 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -799,8 +799,11 @@ static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
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
index ab9f1d606438..c8089d7a8e9b 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -189,6 +189,10 @@ static void __print_mce(struct mce_hw_err *err)
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
@@ -664,8 +668,11 @@ static noinstr void mce_read_aux(struct mce_hw_err *err, int i)
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


