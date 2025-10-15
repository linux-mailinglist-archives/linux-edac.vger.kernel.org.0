Return-Path: <linux-edac+bounces-5057-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D32D1BDFD63
	for <lists+linux-edac@lfdr.de>; Wed, 15 Oct 2025 19:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E3C419C36A4
	for <lists+linux-edac@lfdr.de>; Wed, 15 Oct 2025 17:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42C72D5957;
	Wed, 15 Oct 2025 17:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q6F1q4ub"
X-Original-To: linux-edac@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013026.outbound.protection.outlook.com [40.93.201.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6A921B9F5;
	Wed, 15 Oct 2025 17:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760549103; cv=fail; b=RPQjyGlBnZnHxnUSqnNrWOMSgxslRBXGrF4EsTPRB26+YBvrsuF34P3J/3HyCqI0tYP+gajnW7olMy5PJzOgKsy4/9cbfsxN1J6h4I2A4lcxZMQTRDm63psqkodefbMjahHqDIrgb1A0NfvfdGTl+7KPjZaTah53N+2k8dvOvsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760549103; c=relaxed/simple;
	bh=JNmWS/cF4Epfj0orvAZTdpBaPBOeeBvAHtL1CB3Mk94=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Eo9tm7vnGUEvnBFk6TnGr/mZ6g2+DNc9u1crbmQJe8V8lJ1t2ePULlOpm43OwC6S5kuySSLLE4bvihGRl6aQ+H98h2SLsgc/POZ+mmrPlAiGSnAizqoSTgHN83fiKcS5iiBbs5D4mcPdQZNWe4aV6jrOh+wCUH0D4sU7sHj4Ytg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q6F1q4ub; arc=fail smtp.client-ip=40.93.201.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQib8CgoI5zb2gNYe6EyQHXcZOi+Ux8b+LvzdhD+nm7zsRyVj9uV2icZrokozA8HuVzf+8+UX+QAqYMfVJGOO+IJUDYHwdq8gUkLFUS2kkU3XoaQlkZs4zgN5vlSGbkQ1hUz22O930W6zn0A4GBnHzG0OzTBMri7INMbFtNBQ9PWI0TLbDr7NK6tfNOVg9WFDY09KBJFNsdczTJ27jzHc0d2nneRcWvbZypWFSZA87qOVYhxoou/kTAB3Frh48HP/h5GAoMTk0EaeOuC3k4p210n7XQdQNTt6jbcoIwK2Vcsue2wV4JAAaitjmYhajFj+VA4gmCsVgAjjH7o6Ju0gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzutFU5Smwq9TL4Bo045gi6cDzQnHpo1gPVu0wyQG+Y=;
 b=EVFv1Wqvq5pHQ/1oplvME39qQQ/82wIc6ypTpTpD67PMLjbaLXAdUib/cftyUYGS2OOfrKZnu9ikmC/cDDOnjjhprBmQujCeKO1eNXa3oIIHy0h7GE1EYTGkM6fWBQPdVQsH79h1KrzcOXGuzP/jR30vZrxpHHcIMRrhiq7mBxejALzy/Rke3Ba5cnsy56ZharUYZqLFE3Nd7RFn0xVoFT2C813P1EZTiBSwwZaCVBIaxDH+rbCBluK0BMnWKM93QbWLSoMEZsh07knBuv+3bmVkKVAlRNX1ySZYhLeqe0us/Ge9dWHj6WoM98wmwGe5nAeABpy363Bb/ZHDZMBijw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzutFU5Smwq9TL4Bo045gi6cDzQnHpo1gPVu0wyQG+Y=;
 b=q6F1q4ubkeCl2DJVZMKcHIhiVfUwo+uzaTPm3o2eYbnM6xjEFdNcMXiXCTePMCWeWw5/VGT1hZT1gWh+ecDH+Src59eDgu82TK3xjzriW8VQo9dD3I8R14t0UtsW/cTb4cASQSQXIjliglRDejIgWbgoZfNtj4b2nexm+H4PVXA=
Received: from BYAPR04CA0034.namprd04.prod.outlook.com (2603:10b6:a03:40::47)
 by DM6PR12MB4217.namprd12.prod.outlook.com (2603:10b6:5:219::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 17:24:59 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:40:cafe::79) by BYAPR04CA0034.outlook.office365.com
 (2603:10b6:a03:40::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Wed,
 15 Oct 2025 17:24:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Wed, 15 Oct 2025 17:24:59 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 15 Oct 2025 10:24:58 -0700
From: Avadhut Naik <avadhut.naik@amd.com>
To: <x86@kernel.org>, <linux-edac@vger.kernel.org>
CC: <bp@alien8.de>, <tony.luck@intel.com>, <yazen.ghannam@amd.com>,
	<linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>
Subject: [PATCH v2] x86/mce: Add support for PHYSADDRV and PHYSADDRVALIDSUPPORTED bits
Date: Wed, 15 Oct 2025 17:22:25 +0000
Message-ID: <20251015172452.3649720-1-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|DM6PR12MB4217:EE_
X-MS-Office365-Filtering-Correlation-Id: 198bd3f0-4fff-40da-738b-08de0c0fc478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qkk1fF8LrV+ncokiW2x7WNPWTgev1iKNd9yE2lLrqYsOkQPy3jDLvSr+9Pgz?=
 =?us-ascii?Q?1uddJEqK/LKriuCrq+lktSWqDBW7AwWQA7SdzyyEnFS0cPhcfJAHQKmca8Pq?=
 =?us-ascii?Q?BpRd2O5XQlajpTLZJyBW0/imQqavNjiqQR5ebKP6CC1VdAI+/m45R8ZbpBhx?=
 =?us-ascii?Q?G7wZwxgZNKoFlnHvYVN2WspvLppcmEHNyb1DddmtnA3pl6PSMzKPa3aByXc6?=
 =?us-ascii?Q?iTnLrNSK7U36NOmlFZMk/RlxfUWlf2PP+KtLkYjOUatClO2CdIsfgFiAZkzS?=
 =?us-ascii?Q?1DMtTc/7romZE5Uput1XneKgy40klUWORK2jFs2Td496Y8Jfd5T3OIY0I0cu?=
 =?us-ascii?Q?NCmXvsdXpeRWAdgRGfBRHB6KCmtpZ+OAf+vq84bnzdWGFMzHQfhl50rfZqv7?=
 =?us-ascii?Q?HWYkqaPKBZMLIqWldOmsDPZgzS9lQIWMv30VetkoKH03koW9UkzCMyZ+Fotu?=
 =?us-ascii?Q?Kg6qp3IVJXt1xKmCf7Flk0PRJDQLkj7cUMFhR4EDF4hgQvyJCYhY9PmlTZxs?=
 =?us-ascii?Q?SPeRnKEyPRSEbpaKvB1C+pJ0I0PYoM3cPbJVPQ5BCKQesfuE1WYkM6ynd5Vo?=
 =?us-ascii?Q?iYN5dS/4EhWVdUNhIGpJksoxyM9lDjBjUlD67RAGaG0j2aE7Wn8evnHWn9ZY?=
 =?us-ascii?Q?zN3oYlJ20YXBHyvyXxCFUV1EMR8MY0dUekEhLAppyYTR3X0BgFUpEiVUsgy+?=
 =?us-ascii?Q?KelPuyHGjyIU28Wj+uwpvgvpsyfuUNF/u+gG2zK/7TzmySkxPJWAU618qA6v?=
 =?us-ascii?Q?pUpFM+7Vdlgt7HzfHkO6JjQS6wmJwQ+I+GifWQBcEhGw4ekoNxTAKtDVSGmO?=
 =?us-ascii?Q?N0/kcVDQPCJ6iDtp46WCZHxd1f+j5bxo1uXZHQOp8ehNfjMUbLrXHjy+u3q+?=
 =?us-ascii?Q?176TPOmrpYhXCCCbUrp3PxerRDYbEZVb9m9jnbzw2u7OU26kfHoh92/0B4md?=
 =?us-ascii?Q?2fCLuHiwzRpefM2fZnpSGblWopL7ajPLPWK81SQKBf9cbadOfNCPI5wezhLU?=
 =?us-ascii?Q?nCH29M9uTAzKoLnK250kkuEGB+jQyKxtzgJXSOwcn8+fY32goom5w2dV4w4y?=
 =?us-ascii?Q?jQiExG7uihmvKDam+xlVpB+UJOS6egvhqKD1d+rjVfTr0mDKCPFxRErLsjPD?=
 =?us-ascii?Q?dlURAzz/hLzmwBJRihzrdLQF7yp05mip3hItJYiZYx5k9aA3ZZUWUJ84zRV9?=
 =?us-ascii?Q?PaD/seZWNowNNK+xAbqyCeyVoUeFj18+O6xIgUoRAKKdxG0PGyQyUfZhh2LC?=
 =?us-ascii?Q?4wvyWCzftSB8eWCe7uM0Vodz4egiZVt3L202dCIzmwtvmc2gneGVsU6c7Ni1?=
 =?us-ascii?Q?N3PGUP2KilUo8q/k3gpOPY+yfJbBm2p2ynS23gyftIw1cTW4fWH09WOC3h6j?=
 =?us-ascii?Q?dfXHyjgmw9KpvGLuZVa6eJ2ftELy8UDpPmH3BVfaV33Jz4NZ3LWa2+lmB4h3?=
 =?us-ascii?Q?Aiu91HOyBJDNKsIAFbA5Wba4FGEgkM1dThsC2LKuxpUYaQdjkHePLFsR09lY?=
 =?us-ascii?Q?hJwQjL+Rf3fKla9J2Caq9Tfli1doMeidAZzAxoNoa1dNqvWzOmU13aweWGzw?=
 =?us-ascii?Q?PfpbuA67ohPPooP9p0E=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 17:24:59.2125
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 198bd3f0-4fff-40da-738b-08de0c0fc478
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4217

Starting with Zen6, AMD's Scalable MCA systems will incorporate two new
bits in MCA_STATUS and MCA_CONFIG MSRs. These bits will indicate if a
valid System Physical Address (SPA) is present in MCA_ADDR.

PhysAddrValidSupported bit (MCA_CONFIG[11]) serves as the architectural
indicator and states if PhysAddrV bit (MCA_STATUS[54]) is Reserved or
if it indicates validity of SPA in MCA_ADDR.

PhysAddrV bit (MCA_STATUS[54]) advertises if MCA_ADDR contains valid
SPA or if it is implementation specific.

Use and prefer MCA_STATUS[PhysAddrV] when checking for a usable address.

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
---
Changes in v2:
1. Modified commit message per feedback received.
2. Refactored and simplified per feedback received.

Links:
v1: https://lore.kernel.org/all/20250729204801.1044100-1-avadhut.naik@amd.com/
---
 arch/x86/include/asm/mce.h    |  2 ++
 arch/x86/kernel/cpu/mce/amd.c | 15 ++++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 31e3cb550fb3..09d04cedf175 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -48,6 +48,7 @@
 
 /* AMD-specific bits */
 #define MCI_STATUS_TCC		BIT_ULL(55)  /* Task context corrupt */
+#define MCI_STATUS_PADDRV	BIT_ULL(54)  /* Valid System Physical Address */
 #define MCI_STATUS_SYNDV	BIT_ULL(53)  /* synd reg. valid */
 #define MCI_STATUS_DEFERRED	BIT_ULL(44)  /* uncorrected error, deferred exception */
 #define MCI_STATUS_POISON	BIT_ULL(43)  /* access poisonous data */
@@ -62,6 +63,7 @@
  */
 #define MCI_CONFIG_MCAX		0x1
 #define MCI_CONFIG_FRUTEXT	BIT_ULL(9)
+#define MCI_CONFIG_PADDRV	BIT_ULL(11)
 #define MCI_IPID_MCATYPE	0xFFFF0000
 #define MCI_IPID_HWID		0xFFF
 
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index d6906442f49b..e92829a423b1 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -748,9 +748,9 @@ bool amd_mce_is_memory_error(struct mce *m)
 }
 
 /*
- * AMD systems do not have an explicit indicator that the value in MCA_ADDR is
- * a system physical address. Therefore, individual cases need to be detected.
- * Future cases and checks will be added as needed.
+ * Some AMD systems have an explicit indicator that the value in MCA_ADDR is a
+ * system physical address. Individual cases though, need to be detected for
+ * other systems. Future cases will be added as needed.
  *
  * 1) General case
  *	a) Assume address is not usable.
@@ -764,11 +764,15 @@ bool amd_mce_is_memory_error(struct mce *m)
  *	a) Reported in legacy bank 4 with extended error code (XEC) 8.
  *	b) MCA_STATUS[43] is *not* defined as poison in legacy bank 4. Therefore,
  *	   this bit should not be checked.
+ * 4) MCI_STATUS_PADDRVAL is set
+ *	a) Will provide a valid system physical address.
  *
  * NOTE: SMCA UMC memory errors fall into case #1.
  */
 bool amd_mce_usable_address(struct mce *m)
 {
+	u64 smca_config;
+
 	/* Check special northbridge case 3) first. */
 	if (!mce_flags.smca) {
 		if (legacy_mce_is_memory_error(m))
@@ -777,6 +781,11 @@ bool amd_mce_usable_address(struct mce *m)
 			return false;
 	}
 
+	rdmsrl(MSR_AMD64_SMCA_MCx_CONFIG(m->bank), smca_config);
+
+	if (smca_config & MCI_CONFIG_PADDRV)
+		return m->status & MCI_STATUS_PADDRV;
+
 	/* Check poison bit for all other bank types. */
 	if (m->status & MCI_STATUS_POISON)
 		return true;

base-commit: 0292ef418ce08aad597fc0bba65b6dbb841808ba
-- 
2.43.0


