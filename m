Return-Path: <linux-edac+bounces-5464-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D8DC6B683
	for <lists+linux-edac@lfdr.de>; Tue, 18 Nov 2025 20:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id BCA712D839
	for <lists+linux-edac@lfdr.de>; Tue, 18 Nov 2025 19:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834D72C21C0;
	Tue, 18 Nov 2025 19:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VwnU8krh"
X-Original-To: linux-edac@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012057.outbound.protection.outlook.com [52.101.53.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17EC2D0C83;
	Tue, 18 Nov 2025 19:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763493468; cv=fail; b=A0aPSE+Jt48Lz3nS3MX1Iv1M96ZiQ5sP8f2ZEsCUE3Mdtf0ywpLOHIpkxy4tJkkgQ8wOIZdqfvPllRkvEWaMwLhSn8WHvQh+lEKrSv3Xx32ov5tafv4xH5m/bXHTvaKl1v8UO5pp7xm5EOKyhkA3Vg5CKRzkGhAJx18COWtvUqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763493468; c=relaxed/simple;
	bh=q+/9Oj1mHs8O+tqDryxyFfGtSbRceYWNshVvSpYE45s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qSFJoF5SCFyZlHmvWeJghB3HrsQb0B/cg6ZaX1/NIo8VgZRpVsxYPKut99vYpNHlOSYt03D2QXmC2rR8FIxF2i8WYYs/G/WtxJZDBIsMx23+AYU/qaoyNXaS2MGJJkMD/iKbZt2BXq86aHN/xYzhazP7tjuRsoVlMa0rnbrZ3EQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VwnU8krh; arc=fail smtp.client-ip=52.101.53.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cRSWRrtTUAipFevnPlxJDR5o9tI349HN7AdJG/4RlBxz+tZmGDWywkkx5zOHODVDJQlS7a9fDaDlYVGxCElHWVuVDRh29AXJ4DfDBf+WRtSMmecHo18holXQDPLfhYZtNg1y1BuFD0kePAAy6RuBltA3jdC3E+aMujDPoCRsfGSgMoEBYMF/R3GXZ7vtz/Jb2vtq1oULI3K8P0Ica+S9vdWxSH34rsHu9Dsq5GrZwl8bLJ0qHOyYcjiQLHoKwVnhA5fAD3OF31yhBeqqt313Vx1BYMaqo1L+W6yZsEHQDWsOYobtyZs9w810eyFE1I6citcTfkIhNzsWthgOOuDRaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TxB56I5b2gDDorAlnAiZA2RxnwBz51Uee/lWpD3gC8s=;
 b=JvgHaMVYDwODfnOaxfFgFchvHm3mGSi+/jO1X9Z4I/1tioQGd+Lfg1fD4/VztQhucJdjS4UBjo6xuwbiyuwkmWkru8/zgBHV+T9H/LmkPJsTsjDYWjCq9aCQFE8euEb6w3c76OCYLSrHrd/lCoBiNTzV27iinquzr1TA9B1nlfKrsYe+nqq1UJQMbFwG+5pr3mLnkjo/t2sSB2x2BKOU2WdjtgeOSyYm4EuPwIDviKk9T2Ls2odYzAtYAMna5VO45Xja7kVsr1R8+VAFVVC9AvdP0Q/6Op07+Nec08kxjmj3maRSCcnQZeqwjhnTKPTSVoF6zDH5OY2fdqP3DivVcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxB56I5b2gDDorAlnAiZA2RxnwBz51Uee/lWpD3gC8s=;
 b=VwnU8krhNpkyxt7iv2BQ8J0QSoH9jRPEMyewbFETA6vwDhY+yrpbKPE7+HiUFoFZNuy0LfQZ8Xa6J5L7GSpJWMMFqu0KxyYm6/wY+f6xfF4ilm4010QkauRl5LI3AkN+5SGlcGB1o1N82anwIxcVXT+RHo6Ec21PNiDDmZ5oYJw=
Received: from BL1PR13CA0401.namprd13.prod.outlook.com (2603:10b6:208:2c2::16)
 by CH3PR12MB9193.namprd12.prod.outlook.com (2603:10b6:610:195::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 19:17:38 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:2c2:cafe::51) by BL1PR13CA0401.outlook.office365.com
 (2603:10b6:208:2c2::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 19:17:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 19:17:38 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 18 Nov 2025 11:17:37 -0800
From: Avadhut Naik <avadhut.naik@amd.com>
To: <x86@kernel.org>, <linux-edac@vger.kernel.org>
CC: <bp@alien8.de>, <tony.luck@intel.com>, <yazen.ghannam@amd.com>,
	<linux-kernel@vger.kernel.org>, <avadnaik@amd.com>
Subject: [PATCH v3] x86/mce: Add support for PHYSADDRV and PHYSADDRVALIDSUPPORTED bits
Date: Tue, 18 Nov 2025 19:15:03 +0000
Message-ID: <20251118191731.181269-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|CH3PR12MB9193:EE_
X-MS-Office365-Filtering-Correlation-Id: b1b637c9-4de6-415f-3b93-08de26d72332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zyM5p3LApdigW5UzH5WyxYeh5FOjZs9d8D6IOpbTPzKMg2plbkk0zVEpai8x?=
 =?us-ascii?Q?ZhjnfTOwUU1xIamqevw5wBEeEOi3p9ETaKL47ZFnJLl/ZfLe/z8OMXHsYbhV?=
 =?us-ascii?Q?QG2D17ySgdsNRl8zbFk3ZnYEqY5CP1bYhILlSAC22+zRuj6iI0UXh6WcxgYA?=
 =?us-ascii?Q?lk4FOq3mwkr9ybQ8DMRIxOKkgRO/PCu/OW+HhFEL6bJkhqS/q2LYpBQvlQYO?=
 =?us-ascii?Q?nwKrSzdI7H034Uyjf9CKlbGeCWJq5s7i11XiKkZu6UjMMHYrunpDrJshQCii?=
 =?us-ascii?Q?GoERzesbl9TsvnmFG9DwN2aYcL6Xfa48vnkUzvhmxg6Kt7ob2ZO4p6N3ps0w?=
 =?us-ascii?Q?wVwLq031hd3ZX/e2EDJgHt3HOa+VLdS035t2W91eaj1KJ2CaAvTLrts2guh7?=
 =?us-ascii?Q?JnAD1hwBoByco1LbyYMoscWGlJ8yBvK5ZBragq+ciSfda8GnUdowpz1EVDd4?=
 =?us-ascii?Q?WsknP8pvXNJaICIau8Iiz5DMikYDuryLgkrwEdYQcaj2hbEZtcVgp8C/bgFF?=
 =?us-ascii?Q?njbBy/3G4jceVx2tIU+2kGqwobW29IMZ1qTxdAl4qRSjKV94UN/r02qNR1z5?=
 =?us-ascii?Q?T6B49DkZI716LCtDD2PWz5PRa6D703XDeXSQXtwtUUDxm8/LEIFlvdAAOYe2?=
 =?us-ascii?Q?krdTjNilJmEEuiZWj2VSX8+lH3A2/WnVzV4znj3UH6VP2HpxKIVuUPMYWW+R?=
 =?us-ascii?Q?M46scmT+uI6ShmP5m3WcnB0AOJwHRLsjvuCYrs82bOabLSj32C2Dg71TsEhv?=
 =?us-ascii?Q?5w9UdLRnjAc2uFZJNfY4AJxMmf/cOuXxG3toR5AAynjP4fZUqdlFu+svOFh5?=
 =?us-ascii?Q?X7pOWFhW9EfJza7ICzdQTRwWhkwkruyUV4NHzO0o0iLCmxH2Pya7w48dFq7p?=
 =?us-ascii?Q?QUmQgs++xq/T0wEHWgUpsM4HXnHZPQxM2H9KQBVTPiML6lymTpZEtI2CfPa+?=
 =?us-ascii?Q?za5rPL+je82Dk4DQpitI52nAxkzPw64X9rQTWZcfbOnd4nfkOUqp8l9x6o0Y?=
 =?us-ascii?Q?YoCgCAU/18S1gdDCioErZ/1H7NO+wjZIKdv4lESzn1PWB0KzTaunWNjA6iYX?=
 =?us-ascii?Q?Na2/wmPMuZw5hyiYH4mT9x21yAXD74zAJakjWL6a5dD9iNsQgGrrVq7GUvw8?=
 =?us-ascii?Q?sA8aDEHKjVBVbinsrYgg0NKU0J0MuHzZRbLFjYhgAf16+GCMsVHc+vDgDl4w?=
 =?us-ascii?Q?nKQB0nNsnQ50mPMsOZEQTx58Z6sn9D7j+YPfUpuIts+u+Clg8lDk3U+748LH?=
 =?us-ascii?Q?Zkc0WKOug6elCqLROJn39nZE0IL9CjWdxlVjMWp8avjHKf6Bp1Kam4f7r0LX?=
 =?us-ascii?Q?Shtr1NLWiED8/xs75ErFgsDLML3mTKBO6COpa7CwV9h5EKukZyb/YMTz9Hnv?=
 =?us-ascii?Q?cP3qxqjgZy1+hW+LKKH0kSG1q+tnDNDBDts7Q6yqRsVKmlDhCz3vWQDNQhKZ?=
 =?us-ascii?Q?KbVEaIe5yqcmJgASGtdOMBHNpy/4LahxRomMEqqm6KJPebyLmIqHxaKRO6Mx?=
 =?us-ascii?Q?YhfNdlGE+PrHTxrBIcZXaNNwsYWs6HZMuFwXlUkiwic7Y2/D50kV6pYorhSC?=
 =?us-ascii?Q?Q6xwHWu2e0GjpUe3B0PQObWDUc5FtfbHA2hgQktu?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 19:17:38.3070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b637c9-4de6-415f-3b93-08de26d72332
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9193

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

CHanges in v3:
1. Avoid reading MCA_CONFIG register everytime amd_mce_usable_address()
is called. Instead, just cache the value if PhysAddrValidSupported bit
is set.

Links:
v1: https://lore.kernel.org/all/20250729204801.1044100-1-avadhut.naik@amd.com/
v2: https://lore.kernel.org/all/20251015172452.3649720-1-avadhut.naik@amd.com/
---
 arch/x86/include/asm/mce.h    |  2 ++
 arch/x86/kernel/cpu/mce/amd.c | 16 +++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 1cfbfff0be3f..2d98886de09a 100644
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
index 53385e6aa230..3f1dda355307 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -87,6 +87,8 @@ struct smca_bank {
 	const struct smca_hwid *hwid;
 	u32 id;			/* Value of MCA_IPID[InstanceId]. */
 	u8 sysfs_id;		/* Value used for sysfs name. */
+	u64 paddrv	:1,	/* Physical Address Valid bit in MCA_CONFIG */
+	    __reserved	:63;
 };
 
 static DEFINE_PER_CPU_READ_MOSTLY(struct smca_bank[MAX_NR_BANKS], smca_banks);
@@ -327,6 +329,9 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 
 		this_cpu_ptr(mce_banks_array)[bank].lsb_in_status = !!(low & BIT(8));
 
+		if (low & MCI_CONFIG_PADDRV)
+			this_cpu_ptr(smca_banks)[bank].paddrv = 1;
+
 		wrmsr(smca_config, low, high);
 	}
 
@@ -790,9 +795,9 @@ bool amd_mce_is_memory_error(struct mce *m)
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
@@ -806,6 +811,8 @@ bool amd_mce_is_memory_error(struct mce *m)
  *	a) Reported in legacy bank 4 with extended error code (XEC) 8.
  *	b) MCA_STATUS[43] is *not* defined as poison in legacy bank 4. Therefore,
  *	   this bit should not be checked.
+ * 4) MCI_STATUS_PADDRVAL is set
+ *	a) Will provide a valid system physical address.
  *
  * NOTE: SMCA UMC memory errors fall into case #1.
  */
@@ -819,6 +826,9 @@ bool amd_mce_usable_address(struct mce *m)
 			return false;
 	}
 
+	if (this_cpu_ptr(smca_banks)[m->bank].paddrv)
+		return m->status & MCI_STATUS_PADDRV;
+
 	/* Check poison bit for all other bank types. */
 	if (m->status & MCI_STATUS_POISON)
 		return true;

base-commit: c2ef745151b21d4dcc4b29a1eabf1096f5ba544b
-- 
2.43.0


