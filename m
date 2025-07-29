Return-Path: <linux-edac+bounces-4461-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 522E7B15468
	for <lists+linux-edac@lfdr.de>; Tue, 29 Jul 2025 22:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C90B3B1140
	for <lists+linux-edac@lfdr.de>; Tue, 29 Jul 2025 20:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685B326B74E;
	Tue, 29 Jul 2025 20:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QXTPLXnp"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B080C136348;
	Tue, 29 Jul 2025 20:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753822097; cv=fail; b=ajI8TJd1+Uef2E5b0SdZroL/1m8aN+HZ/NlMkiDQELr0icSLms+GuidCTt/N2Spv62mMRoZGa9qjII/PRTiQYUOst8zAk4ZExGhzpbqiCD0niycRRNpGKwoGMHrdjmZM3DRwM74QJfkcg+A62fAEHeJ/H0jEYlQKxG6FNPxHLlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753822097; c=relaxed/simple;
	bh=UNaOAE6n26Vd68kuSWSQN5BvdTKGS9dBIoyeEeZs7qo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KxUJtilhUZjoekKC8M35L6fZVVaU5qZbow0UUXeIBhOsfYGef80YLBtL9ITlXSxk+PY9nVw/JRfmw40E5UxYTZ+/IFa6Gnp1CM+ga9apts8ulGXywrQK0L4QEbivqU2xfW0jgG6+fePsnSVwZtZiuVYgsRDhLoaqiwuQh+CRjlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QXTPLXnp; arc=fail smtp.client-ip=40.107.244.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t0NBRs4Qsi7vJ9wZvav/95cX6ZdWnkCmDDGUlKZaZX+jfdVaKospnaQbFdYb0mQ7+CDf0VNNCBbcNeBS6Xj0H9YI2trPxd5PTsAA6QqXEu5LkUbyEELi4mnoxJQ7k2HHo5QaHkl8UvGibZRRAIvu9Jy3Kd7AoKz2E+nEPKaP0UBRhieDVcgXfCWwR2ZVWgFJo4W8UgRbypDBdhYQVgHqRUljqQkR80Jc4WcFkWC0lRj+lujEEqRTbMZY9e9t0KVaa+bMEhOYS129CRGNCjbhNcBpf8L5RTmeLig0y2Fp6OglwamI+Hrl73bMValfinA4ClpVzJ0tdDPoKq6AxQb4cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LD8kZRaU8G0eZ+7XEw4F7PlHHcoYWs5oYGA0aS/4yVs=;
 b=SpBRc+GW3s70iS9YspCEQMQWcq+9xxhgYHR5VcelQWI5lm3AKNsVLNYpqILaIW7DvtQ/Qdn6WfqC2OPZ3uHIEEFWYRj5Bf8ruasP9NF+zWRosmRu18OSMJm0XYEqod0LWO0nV2CUNcF4xaK+erWJ2dQBi7aPyzUFv1TOhB4t57Xwc9RwvXARsevEFF4+/tcMEDYNxCy8by9MsrYcDwTeTcLQ4Oghv3JA/yDRP6PCA8eQejrt5mGopPHGXzYC3TOI2FRn7XEiewLEyLV3sZgxlUuhVDkVhR+Hpk/K4GTsRwT6MVM2avABUX8eAX6DSrSzjVwczAE2V/Cn1y9TPCLhsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LD8kZRaU8G0eZ+7XEw4F7PlHHcoYWs5oYGA0aS/4yVs=;
 b=QXTPLXnp6rc2u6bnPMTP+/vpYJaX89BkAlXuESMxE7i8NcccQlUIfYjO9rnAME/ZT8MUNEVWSaE8G9GiRn0BazZV+MvxeAMA1LZppojca622f00iD6kNw2G7isc85V4N2W8fwKA5Bs4dEN2TyTgEFsJ0KDtNzwdzXVT9a3uZdrQ=
Received: from DSZP220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::12) by
 PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 20:48:08 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:5:280:cafe::81) by DSZP220CA0005.outlook.office365.com
 (2603:10b6:5:280::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Tue,
 29 Jul 2025 20:48:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Tue, 29 Jul 2025 20:48:07 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Jul 2025 15:48:06 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <x86@kernel.org>, <linux-edac@vger.kernel.org>
CC: <bp@alien8.de>, <tony.luck@intel.com>, <yazen.ghannam@amd.com>,
	<linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>
Subject: [PATCH] x86/mce: Add support for PHYSADDRV and PHYSADDRVALIDSUPPORTED bits
Date: Tue, 29 Jul 2025 20:46:57 +0000
Message-ID: <20250729204801.1044100-1-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|PH8PR12MB6914:EE_
X-MS-Office365-Filtering-Correlation-Id: d615fda6-7a9b-436f-a4e4-08ddcee1393c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dl892H3yT7+wEX/ScgjuQ6GmQkiQZn8rJg/+hpc2X+hfIv75zoX4sWGrnt4M?=
 =?us-ascii?Q?3kpD9SaLjhJ2dsRnNNEJlvauX/+RMXUbqeOlyLdjGZOmTwMA0aRtdOmpBTuC?=
 =?us-ascii?Q?Srb+mQgBkVwq3d7jZ1D8WD7eSRmL/afuf91VE+f+R3Giq4Mjp3FZQIsaf8Wm?=
 =?us-ascii?Q?Z0nPLF5HWS4NHKvk49XRwJLQBDoNq2mlXrBP0q0iY70/8J/QHMUH78RmjVi5?=
 =?us-ascii?Q?zw9QSNe1ofMzokvZbNXkKgMsTKvBKyulrKEMukw5d8/p4/eruxDO9eGpWSo8?=
 =?us-ascii?Q?ezMg3sGW+F2XPCotFe5n8yWVZiZ+YZnDMRjKm0ycg9odBGkUorXZ4PhtgqjC?=
 =?us-ascii?Q?sZwStlPZZCHPYpmV0hQoI4FqBffcI2YzJ9zCR/VpQF8CEfx8BSbo5Sjgh8i5?=
 =?us-ascii?Q?he1R1vmXENKdD2fi9zx+mv4/iv+4EeaTb15os1K22Yx92KK9CuZyI70h+VtM?=
 =?us-ascii?Q?HBbPv2Po7HLezOEBFhUc20wpBHRqvmFCxURWCGxuB4pgSKH5ffOf83QQfSVL?=
 =?us-ascii?Q?FupOa2Sa/y+Q/8lvAmiOEhUE1zVPAIuk0/hRJPPK/FynStIz9bqWkHQWNjzc?=
 =?us-ascii?Q?mtXc4gVPVkeyDXtzqcG+HXW/k3R0D3/dvT9/Nzh9j63QfIuireQ+FxCTkpQT?=
 =?us-ascii?Q?ooorO3Fmv6oYaKrQo7ZbAZju7UP/F75/VtVGCP7EyD2dUdly0QiTGBRh7CWZ?=
 =?us-ascii?Q?HEo03kvmnkq2ismU1J8VK6lQCynYqCKRzLU4rcEABZqFqsbVfvIz9D5k4SML?=
 =?us-ascii?Q?YRvdwYPlx5aE7apd9lgzYXWhpSK3dLxCjOkIRiNUxSXIpsWw1uttNrLGn2YB?=
 =?us-ascii?Q?4Wc9Srwb5tLIPBEHv2MDVJ0yZkhBedIYF2W+miYDTaiXa1tR0p0PY4RxD4NG?=
 =?us-ascii?Q?9TbkJrGjJmtzvImVxlH6LPYVDwgUore64D2AhTNfR1yKQOZtmbKkWuQlRmzB?=
 =?us-ascii?Q?rI4LdSgmbz74D1RComheWgy5VJIUjzfAN/BAtULdd2OQ54BkT5CWul2XP8v3?=
 =?us-ascii?Q?w5JMuT0K9SDDtxwW7FvchCwbq5wEjIu1mizadtYFanNTMlAhv/dz8+i5xrbr?=
 =?us-ascii?Q?SC5Kk8BunYS6u1A8YnMpvg5Ho2gcChPg6g7Kp2TVLraFAW2OPzqx9txfBptf?=
 =?us-ascii?Q?l3H/+8OjRC7q+YleNYhZ+2SRWAe3K7Pfg3+aST5LiOuCRVUoBAxYLJrQOgLg?=
 =?us-ascii?Q?MvpgZuuR0bseHOEl8EgAV0CibMI5AdCIma3MSakuNV0Jvqky7/2z8QvSDSh3?=
 =?us-ascii?Q?3cHIh5YyROZiEA02jdBxMWk4xvvi3ENPqXJ9qoEiBpjR8Jzdvxdwr7Smm8Up?=
 =?us-ascii?Q?GfPA38Y9eWyoPJxGnMm3kpmR8ubPuvyHQoNhkfHiSeV1QxxiAbFql5gGkx5q?=
 =?us-ascii?Q?2FMwVME3ILi1HPRoK7ks5syhsR07gSz54WpwRWdVSkWTHW12PuEUZHXSOUnA?=
 =?us-ascii?Q?XBwFm4n7w0xUTPzrxjz9KRMulasT19rcs+9uuoM4NI/QhEf67ZuiS4WDk0y+?=
 =?us-ascii?Q?Z6/z4jbvVw10Kkonj6cHFVNZGvdQ/oypwIU/?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 20:48:07.8840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d615fda6-7a9b-436f-a4e4-08ddcee1393c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6914

Starting with Zen6, AMD's Scalable MCA systems will incorporate two new
bits in MCA_STATUS and MCA_CONFIG MSRs. These bits will indicate if a
valid System Physical Address (SPA) is present in MCA_ADDR.

PhysAddrValidSupported bit (MCA_CONFIG[11]) serves as the architectural
indicator and states if PhysAddrV bit (MCA_STATUS[54]) is Reserved or
if it indicates validity of SPA in MCA_ADDR.

PhysAddrV bit (MCA_STATUS[54]) advertises if MCA_ADDR contains valid
SPA or if it is implementation specific.

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
---
 arch/x86/include/asm/mce.h    |  2 ++
 arch/x86/kernel/cpu/mce/amd.c | 16 +++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 6c77c03139f7..387cf250525f 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -48,6 +48,7 @@
 
 /* AMD-specific bits */
 #define MCI_STATUS_TCC		BIT_ULL(55)  /* Task context corrupt */
+#define MCI_STATUS_PADDRVAL	BIT_ULL(54)  /* Valid System Physical Address */
 #define MCI_STATUS_SYNDV	BIT_ULL(53)  /* synd reg. valid */
 #define MCI_STATUS_DEFERRED	BIT_ULL(44)  /* uncorrected error, deferred exception */
 #define MCI_STATUS_POISON	BIT_ULL(43)  /* access poisonous data */
@@ -62,6 +63,7 @@
  */
 #define MCI_CONFIG_MCAX		0x1
 #define MCI_CONFIG_FRUTEXT	BIT_ULL(9)
+#define MCI_CONFIG_PAVALID	BIT_ULL(11)
 #define MCI_IPID_MCATYPE	0xFFFF0000
 #define MCI_IPID_HWID		0xFFF
 
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 5c4eb28c3ac9..6ac222aec28d 100644
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
@@ -764,11 +764,21 @@ bool amd_mce_is_memory_error(struct mce *m)
  *	a) Reported in legacy bank 4 with extended error code (XEC) 8.
  *	b) MCA_STATUS[43] is *not* defined as poison in legacy bank 4. Therefore,
  *	   this bit should not be checked.
+ * 4) MCI_STATUS_PADDRVAL is set
+ *	a)Will provide a valid system physical address.
  *
  * NOTE: SMCA UMC memory errors fall into case #1.
  */
 bool amd_mce_usable_address(struct mce *m)
 {
+	u64 smca_config;
+
+	rdmsrl(MSR_AMD64_SMCA_MCx_CONFIG(m->bank), smca_config);
+	if (smca_config & MCI_CONFIG_PAVALID) {
+		if(m->status & MCI_STATUS_PADDRVAL)
+			return true;
+		return false;
+	}
 	/* Check special northbridge case 3) first. */
 	if (!mce_flags.smca) {
 		if (legacy_mce_is_memory_error(m))

base-commit: d69139008b6dcd9c18483e956f61d187b0c214a2
-- 
2.43.0


