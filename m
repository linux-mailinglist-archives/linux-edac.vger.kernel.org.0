Return-Path: <linux-edac+bounces-1948-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5279E98C52E
	for <lists+linux-edac@lfdr.de>; Tue,  1 Oct 2024 20:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE0851F24389
	for <lists+linux-edac@lfdr.de>; Tue,  1 Oct 2024 18:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AA01CCB31;
	Tue,  1 Oct 2024 18:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Z5dNTwGo"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2086.outbound.protection.outlook.com [40.107.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BD51CC16D;
	Tue,  1 Oct 2024 18:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727806627; cv=fail; b=oJq6S7acGNFEditrgblv7+Al5c3k5ygrCO67KnIXtMBCpRN64C+jHMqv0HUk+Ip2incnIP5G0iksrrRtwLThPkjn+5TL2jBxNYgrOWsUYck7qAX4n0OfirIb097GmH84JItvunYI1vYATtHqJWC5L3nPkGlowOM6IjHDEQ0JSyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727806627; c=relaxed/simple;
	bh=p8Y2lUQluTYCq32EpuXnEHXUaqW2A3Za/YealbqGoZ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eNGW6AxmlBtgxiFZ0LiOCd1DNFSLayfIavUrV2zzmLz8aO0KeTLSIGgAGDdSQp6W0LVHbizSgyRLKQluLhNs29jPLhn9YuzEGUQOuwL4AkHgg+7TPdyS/ORJygXRY+Ht+IltsHR3NnAXR4Eu6DCCW3rY72tHv+Gg/V7+w02u7C4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Z5dNTwGo; arc=fail smtp.client-ip=40.107.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/Tagl0YxEuLrjyjW5EWJi6igTwGU9JO8XY2HFJUqDfcu6VWKDImFDanFjCQhDyjf6F39Qe/mMbc47+Utn1EfcEltFM0NtMbv4fV9m6yt2kppyFQEAjsRX0Ipo84dFbnmafVD175uv6IwZdbz7R64q7W+TN1Bjg/3x/vqpUO6ZHTwuD2PgGc/XXz1k3C9ZYpVujjRZ+7/6XmAqKo1y/ac1Yb6k4x/RmQtm5Kp8SgfVnV2wiKGKYKjynxfUqoXrL7EcaQGjp7Djvo4JqsX6UXqo88/eK1pvsn1kbazurAFEQowN5zMTz4Uh8oLreFpatjFm6WBgG5Xo1n1IQzOhLzWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dV16vScQkhfobR40HJz00N7w49/by+jhDMHYO6YGt6k=;
 b=J+GLDIoXyDmqZkbm864oTW8Z8PeDfLqJtXqvMvt1hW7xhhciEzluTh0hpNwsaVg+p/7GiF6LEg5mhZHJ545eTu7wTf1T9bwdnoE1/3bfOaL9uC/WvqvM1hX+f+ORFVXKPnKIKIjphfhh9bIFUPCRy1FeMmwhpORdUY9AdCGuf+zUWLmbOfN5FSGWYVbslaFFzrYFDxYHizsDsB6SRN/gGbGV7Ig/PSFE0nj0WcoryykDYhUrSDR8drPIbmWhV8jTpzSZtfHHY6ncYD/rRxoDF9chSa1MBGNMcFn/UjXur9eznvdmPgNs9uxlp3zzUwd25t3Ey75YaORGqJLAwFcKEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dV16vScQkhfobR40HJz00N7w49/by+jhDMHYO6YGt6k=;
 b=Z5dNTwGoWdsjTH6IM0oFf0ijJYF9dk/rtbW8IToVuwRoHz2vtbigtyVkM39+Aw4uhE/mTAKlF8W3oe9r/Ewy8+mnjgX8Hhz+4GlbE4wNwMlM0kFeyS5FzZ67KUeSwgfSVSe+N5I7CImKV3dP5Cpy3/8F9rtjMLwTPLPu13B6oSs=
Received: from BN9PR03CA0224.namprd03.prod.outlook.com (2603:10b6:408:f8::19)
 by CH3PR12MB8482.namprd12.prod.outlook.com (2603:10b6:610:15b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 18:17:00 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:f8:cafe::15) by BN9PR03CA0224.outlook.office365.com
 (2603:10b6:408:f8::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15 via Frontend
 Transport; Tue, 1 Oct 2024 18:16:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 18:16:59 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 13:16:58 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <x86@kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<rafael@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<rostedt@goodmis.org>, <lenb@kernel.org>, <mchehab@kernel.org>,
	<james.morse@arm.com>, <airlied@gmail.com>, <yazen.ghannam@amd.com>,
	<john.allen@amd.com>, <avadnaik@amd.com>
Subject: [PATCH v5 3/5] x86/mce, EDAC/mce_amd: Add support for new MCA_SYND{1,2} registers
Date: Tue, 1 Oct 2024 18:12:27 +0000
Message-ID: <20241001181617.604573-4-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241001181617.604573-1-avadhut.naik@amd.com>
References: <20241001181617.604573-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|CH3PR12MB8482:EE_
X-MS-Office365-Filtering-Correlation-Id: de868780-674c-4dfa-33eb-08dce2453db8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2TnREwyBOTc+SY7gP9R2maYUA4lDsDlZDPQdejZP2GiPIJ7yBibx011fhWgb?=
 =?us-ascii?Q?Kcuca5juzzJK6PfiMlyyx5PW4lNQJI30hbU198ogi0kiSGFKiZdcwW1nz3DL?=
 =?us-ascii?Q?eueZ8OUsZ2k8mB93xfRRXDHgtur9U4xCjkVsUVRF9gi2CF6k/A7Q+KKKnYjk?=
 =?us-ascii?Q?wiSYU9WukN3Chq+aU6vNbzOT7HqeQY1W05/KEGSg1p51B9U+RSRGnRGZLuqG?=
 =?us-ascii?Q?8pU0XAdn69/vNuMs/49tjTnBEBRvQYypXXXbpZdQsLwRsJ+ViyjNuUJ1h/7r?=
 =?us-ascii?Q?V4ShoGcBk3eEbChxgiszkZ0k/S/7xByas6AOuD64vZcLds3PHBwAedU8/7dd?=
 =?us-ascii?Q?ZlfskiEUOGWOybudCFqdqEWqmgm66PFvGD3Ab9MbhiwJc8uV3nqy9vowqRzg?=
 =?us-ascii?Q?FGUqJJWbfpX+fCMP1As/dzwfW7DbqBB7hFDoTba4haX34rfH4qGbkt7Jn+ia?=
 =?us-ascii?Q?YADJjEnU4kMo4umslvlCuWFg9WHzz3uabs+3ovpBMmhTkM6AoLN/N7NAQZg0?=
 =?us-ascii?Q?6QUlMs4SKVEQS1/rvGBxpKTgsDEgEUYkFJGSqhiUGiXo/aiGtIK2CKl9CafD?=
 =?us-ascii?Q?7rDTDK3CQw4Cdbjl8dqElHswcHZ4nokcPKJYrQk7s7EdJpGRPT3KGgEV/Dxl?=
 =?us-ascii?Q?T9aTZEwIOqkki3ld92tIYs0uUkX4sWZNuOIyXBHa8keG31HGRQueCt1NGTz1?=
 =?us-ascii?Q?vEfsGs2zrUcdBBCI+y4q366Tw2jVQihIAnF0OoiMthW/EL0h9izLpow/3qHS?=
 =?us-ascii?Q?ibqnzmHW+FXu7uyZY47jrtTYONQk4bnQ2lvCPBGfUvqTnP8o+H1iiueJEP3n?=
 =?us-ascii?Q?CRjLENYHr+cclcTamJr1q5jjKI8JUGpAIQr6YAwEACU07gFT7ycz6EDLyQgu?=
 =?us-ascii?Q?55Jlseqts07pvD53eqhuNJj9GH9bn2dxK1vpQIZoRTzM759VRNdXEQwYClYH?=
 =?us-ascii?Q?MeWUq/2ZkgIeekjXaJeNpN5u9WG4BOETtQL6gD8xRe4DBCi30hPZM4IXr3BD?=
 =?us-ascii?Q?zh8gwVoMeLfdm8JleWVJFBCg30s998GAqd0BQyfiCszDSoV2266zRwa/Ih8r?=
 =?us-ascii?Q?AKZiLQ3bKT9le9d7ZZ4vnLL7IWgUu8gYaoWDq/fs8apQxU9AyfarATFhpgGJ?=
 =?us-ascii?Q?xXn82Vw3226MHBtH36gSpsuCXz2QiDrZwFyLn7973FkdJL4gk3h7RxcOTH9F?=
 =?us-ascii?Q?H8cCn25/+Wk0Lc7/Mb4/0pNABisJHHYDNzCL4WtBE2jFcwKP/5Mt9J85rfju?=
 =?us-ascii?Q?Ewru51O69H696mZ/ZLWJ8YLaWgJ0zW2s0pp+pE9/PSOYqEpgJD8G0RL67HFb?=
 =?us-ascii?Q?zXjVFTQ7lEtZCAb5ZTtwOeeZXBSzoqEqlObZMb9lZvNchpXL3XjCO/arvTGS?=
 =?us-ascii?Q?vj3erk/n58Q+WP9U6WqcvGfyw7/A?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 18:16:59.5245
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de868780-674c-4dfa-33eb-08dce2453db8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8482

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

Changes in v5:
1. Remove "len" field since the length of a dynamic array can be fetched
from its metadata.
2. Substitute __print_array() with __print_dynamic_array().
---
 arch/x86/include/asm/mce.h      | 22 ++++++++++++++++++++++
 arch/x86/include/uapi/asm/mce.h |  3 ++-
 arch/x86/kernel/cpu/mce/amd.c   |  5 ++++-
 arch/x86/kernel/cpu/mce/core.c  |  9 ++++++++-
 drivers/edac/mce_amd.c          | 10 +++++++---
 include/trace/events/mce.h      |  7 +++++--
 6 files changed, 48 insertions(+), 8 deletions(-)

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
index 65aba1afcd07..ca6fa01791f2 100644
--- a/include/trace/events/mce.h
+++ b/include/trace/events/mce.h
@@ -43,6 +43,7 @@ TRACE_EVENT(mce_record,
 		__field(	u8,		bank		)
 		__field(	u8,		cpuvendor	)
 		__field(	u32,		microcode	)
+		__dynamic_array(u8, v_data, sizeof(err->vendor))
 	),
 
 	TP_fast_assign(
@@ -65,9 +66,10 @@ TRACE_EVENT(mce_record,
 		__entry->bank		= err->m.bank;
 		__entry->cpuvendor	= err->m.cpuvendor;
 		__entry->microcode	= err->m.microcode;
+		memcpy(__get_dynamic_array(v_data), &err->vendor, sizeof(err->vendor));
 	),
 
-	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR: %016Lx, MISC: %016Lx, SYND: %016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, vendor: %u, CPUID: %x, time: %llu, socket: %u, APIC: %x, microcode: %x",
+	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016llx, IPID: %016llx, ADDR: %016llx, MISC: %016llx, SYND: %016llx, RIP: %02x:<%016llx>, TSC: %llx, PPIN: %llx, vendor: %u, CPUID: %x, time: %llu, socket: %u, APIC: %x, microcode: %x, vendor data: %s",
 		__entry->cpu,
 		__entry->mcgcap, __entry->mcgstatus,
 		__entry->bank, __entry->status,
@@ -83,7 +85,8 @@ TRACE_EVENT(mce_record,
 		__entry->walltime,
 		__entry->socketid,
 		__entry->apicid,
-		__entry->microcode)
+		__entry->microcode,
+		__print_dynamic_array(v_data, 8))
 );
 
 #endif /* _TRACE_MCE_H */
-- 
2.43.0


