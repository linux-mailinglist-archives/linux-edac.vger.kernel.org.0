Return-Path: <linux-edac+bounces-2090-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C709A0190
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 08:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4F66B25068
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 06:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C498193409;
	Wed, 16 Oct 2024 06:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jj77hWuC"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C84D18C331;
	Wed, 16 Oct 2024 06:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729060874; cv=fail; b=cNODFuT8he5i+FAFXarpyPbxAhljDWlnnEa16XVf3S8actp3duHv30KaAwHqus9/DfNbqcT1QaPwqqWRCwF1Lf91ETi7TgpOjC6hM592Op6n8zcDBhES6frroRvrQqaWzoKMHH94FwDdabEVOa2CbNsTZcQOUsvda84qWZspOdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729060874; c=relaxed/simple;
	bh=m0vi3XABMpkmK2hmkI+O8i5F1yqgxr1OzGuLh0VYUsw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bA6b7CyhkYKLdUOkdm1qxpEkoEBaMcmAhprEfUdSUB4DpVO4oik3t0czNO7X0Hu7titMchO13iW6NIv1moF3ErxZut9evAq+1H2EGZPyfG8W5rGvhBgRbhNI7xAUNDTi667CLdMQTGUMSSFhxkbMmUp6BXD53duReLHgRWQPYTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jj77hWuC; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r/33ih1wCxNnPrLn9jNqdiyvH2xe28pFCoK3fq8d/txZzKXjB3MSu/2UfRZRd7bC1+HDMBLr0gWd8BNJ/4C/dXV2u3Y44x4Esq15TlGKX1NFOhJ50/kaN0G0Oektlp0N6YlcQnBkAiZR3prUyDm7tWq8mhkHohGlYPx/j5i/cLWCzewIGgeNyWprwhvswRV9ThjSNpLVph+vobdBCmL+nzHMOneZKPa9SSKLvkQIa4/fVp3Ov/xsOzQvks6Wym8KDVo9/13XKUEMPe0BNabJlaz9OMiCNbU6PAYMWm5/mQ+OPNNG8an2HzU8sOj7z95VsfRxeuiHt76Jk6nix1KxVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbtqsvwy/wsEF3vZfrn4pglzFSqeYg9OjiBFXWpPP40=;
 b=qqGTRuoDGE7kD9l/CZh/xULV5oZzh77ggejt5goRMOXl+q3uq0W27ulraYOrlVdjQOY4PLnfHQoFUmlaOC9OY0JdaCKsr8FzXC1Z0zfog+1YrNBrTMapq6PuXeHL4JApS4sJ7em8W6XbnQ0anIFXkhZAABvvV7jp06PTwrtG5J9l41xdKXG+9X+BRuTMJCs4ljj9+9lBtuxslHaAGhhf8YgtrdBtiLDYkQBlszgAD2nFOkImokaXSJMg9n/7Lwg8alOamGCJr/6dT4UFs5/Nu0SymF0U4nau5QAppgtWwmQg1pMyEwq7uLRoWrWD5iNpkZT3FgoSIAa5DIZjToMPxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbtqsvwy/wsEF3vZfrn4pglzFSqeYg9OjiBFXWpPP40=;
 b=Jj77hWuCQqzhXefgeLwD2x3JdRe4PiLVvMj9Tz3/VqB4UECRHSsR+LScBAlaAa6WuSaUbSxI/wYUySddfS/D276JTEnOV7tDw/c+ImznaDLFqIFdYjAlj+mWPhL7609Lvmyj14sfbk28CNOyNlo3Uo/E7QdgNrWCRGbZknano24=
Received: from CH2PR20CA0016.namprd20.prod.outlook.com (2603:10b6:610:58::26)
 by PH7PR12MB8040.namprd12.prod.outlook.com (2603:10b6:510:26b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 06:41:07 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::a5) by CH2PR20CA0016.outlook.office365.com
 (2603:10b6:610:58::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.28 via Frontend
 Transport; Wed, 16 Oct 2024 06:41:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 06:41:07 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 01:41:06 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <x86@kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<qiuxu.zhuo@intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<rostedt@goodmis.org>, <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
	<john.allen@amd.com>, <avadhut.naik@amd.com>
Subject: [PATCH v6 3/5] x86/mce, EDAC/mce_amd: Add support for new MCA_SYND{1,2} registers
Date: Wed, 16 Oct 2024 06:36:29 +0000
Message-ID: <20241016064021.2773618-4-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016064021.2773618-1-avadhut.naik@amd.com>
References: <20241016064021.2773618-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|PH7PR12MB8040:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ac8e3cb-b975-40d9-54c4-08dcedad83a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eE3Gv3coGaT4oTKK7KNvJ1a/R4MeVGX09oHVBTsSLCbiJdJ7xmU53zfhd07h?=
 =?us-ascii?Q?6HcpKpkbb2LygXyx7jR6c3T69blz++vFuYOS/LLUHR0j89oOAGHbPgetf0dg?=
 =?us-ascii?Q?R1bEJYGYrnl2tPwr4NFHvajAqyFIo+mWlIH0nodzreIpnlxfAEczlN2qqowD?=
 =?us-ascii?Q?crDRBifO6ceZmtkQXjsv34K8TJd4kfY57Jz7PVW8BNaAS4FFBiUWXG6gR0Gg?=
 =?us-ascii?Q?LEOAkuCSLAzj4JGlKbYoFkyRZyS2DjAXV+/s4qkVdxnIuUUgdzuw0XpEryIX?=
 =?us-ascii?Q?RVeDMGst6NOhYM4VQt2VJAU05CKB8lVt1ajTX10YxwtrW88wyJkcvpM5jW4K?=
 =?us-ascii?Q?VGB1NfERpe376ULcoPKcsnusMk3Ev24buWLVNlwZL/Ovebnx40CAfJCrCsLs?=
 =?us-ascii?Q?IhpXLWTKsjl8tAesdhlxNtuxyatEh0Uh4Ko5teHtCvhilO7AQnIdbblCBegO?=
 =?us-ascii?Q?ksYdZTcSGiwayGb4lUW7ddVzfKYR7gyYUHlyFaxrvhaeQrFYQmnygBGZeX2I?=
 =?us-ascii?Q?a/Eu87jK4gDJZdzkK2TPVc/qo8TZb2tzgRTtreI3m5Wjvetcm62WnkI7+Kl8?=
 =?us-ascii?Q?fYWJf68iMgTEcyV4x8TK6bwrMVgVs0NLqUcaZOrPrdKkfjF13RxKpF15vnku?=
 =?us-ascii?Q?nGRHP6muyX1gcuLQjwWkdO0dVMeaLcymgD4Ow7vgSuZ71BXGOPXHQIEkZTch?=
 =?us-ascii?Q?M9O/8m7FQFENMYG3CcYaCQi53DQH+1j3vu7PRwKuJDLx3OxEJEWpZdEm4FZu?=
 =?us-ascii?Q?3htcOesIERjGAcg9msU8Ai6vE8ex8WqEjJ8AUCLNw8db6g2xFzbfKUnWYFaH?=
 =?us-ascii?Q?JFyNFGvLL5rYVq18baCFVdOUOg0JSmvgY7dn8thUjsdfnueE/Sb/+I3uJjrl?=
 =?us-ascii?Q?+IRFaiq58LvCTUesFzbt7nm4HYmqbJ3VX0UAh5lsS8UAO2t24wkFWhLGi0Bj?=
 =?us-ascii?Q?/dkpwNd9j4EYwz+/9npsFFEN1fcu0xFbYA5HR/34ydko2dgf93CPT3BnAtsj?=
 =?us-ascii?Q?JfcQ8kv4KGC7HolIHhSkeggsX5mSX6RLZYlNaH4qlUmZnfm3B6VeUWqYU5Xb?=
 =?us-ascii?Q?II9epH+Knr8ICXB70XYeKfKGZ1vPifr4DVVJfLYEbDZap3ENyhJNCZpzCylg?=
 =?us-ascii?Q?TLeTS8OvJCUaeTl/evx2L4cuIcyL0ceKNsCzrsSM3KDLQhsjZB9usg5+6LOD?=
 =?us-ascii?Q?RGkgHxTxq6xQN1MG/mrqGYLxW4uo5kzMtmlhFfFQ6SL/ocftQ9Ir1owPiKQZ?=
 =?us-ascii?Q?ob7aw94WpGpz33qEfWQF/PMzl1AahROEc1DNB5Zk1KYXE0po6c5lQfdu1CT6?=
 =?us-ascii?Q?ozsN2y0kfc8RTFyYkirBvIZ8kn4Tvr6cy3b5nnDZKhXk42JI0DCBwOxFIuNe?=
 =?us-ascii?Q?G4OwFYKJIwzGQRTVRTvZ325cbA5l?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 06:41:07.2540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac8e3cb-b975-40d9-54c4-08dcedad83a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8040

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

Changes in v6:
1. Rebase on top of tip/master.
2. Use the newly introduced to_mce_hw_err macro in amd_decode_mce().
---
 arch/x86/include/asm/mce.h      | 22 ++++++++++++++++++++++
 arch/x86/include/uapi/asm/mce.h |  3 ++-
 arch/x86/kernel/cpu/mce/amd.c   |  5 ++++-
 arch/x86/kernel/cpu/mce/core.c  |  9 ++++++++-
 drivers/edac/mce_amd.c          |  8 ++++++--
 include/trace/events/mce.h      |  7 +++++--
 6 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 4e45f45673a3..c2466b20fe79 100644
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
 
 #define	to_mce_hw_err(mce) container_of(mce, struct mce_hw_err, m)
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
index d3ac1a738b2e..b7f4a49a1053 100644
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
@@ -678,8 +682,11 @@ static noinstr void mce_read_aux(struct mce_hw_err *err, int i)
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
index 8130c3dc64da..194d9fd47d20 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -793,6 +793,7 @@ static int
 amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 {
 	struct mce *m = (struct mce *)data;
+	struct mce_hw_err *err = to_mce_hw_err(m);
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


