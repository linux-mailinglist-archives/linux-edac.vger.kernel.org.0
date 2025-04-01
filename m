Return-Path: <linux-edac+bounces-3454-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A605A783A1
	for <lists+linux-edac@lfdr.de>; Tue,  1 Apr 2025 22:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99AD93AFF7F
	for <lists+linux-edac@lfdr.de>; Tue,  1 Apr 2025 20:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B9121CC52;
	Tue,  1 Apr 2025 20:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Vk8SjCYW"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B84421C9FF;
	Tue,  1 Apr 2025 20:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743540574; cv=fail; b=egn6e5k2otqqKSKrOJxPlxkjc1RE+LB3aVn+/LeMipUwz/ZbEg4p9ilhR4SBzEsFmLkW9MY/J6pNQxCsrqESocTvX9vUepCCmkxm1MKIiP0S5kmzbihB55iH7cqfd34a9ABzjkzvvWmw90QMNkdZTQDKuL5ovo/9GF3QESDGJn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743540574; c=relaxed/simple;
	bh=F5ffxRU2kE7SwLQTZdZilW7kwu5VjlZnSoO2enukTpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=q3dC7CYWqz3jbf9UySPm0TfqrCdvE65QNyK+pdBSNLEAve1DfNzLLrjLBtpHOzq6r4yBrVTTovkl8W6og9yH53jkoMwVKKO50vqW+stuhCxqH1OUY63Wfkivw2Howh+6XSbVvfqEwt/NREV31PTNwMQBMbAqz/eV7k9DIrMpBv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Vk8SjCYW; arc=fail smtp.client-ip=40.107.92.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvFi1gywzetGLxUeuz+dKd1nWQ68fL2y17fQdZcvu6sZ4URZjALFx+LyLO34mY72LfT5cZ21CnYkghd15EVi7ZE2QmNP+X9HFa1Zwm2HyJ8IZoX/cqLWQLGCElEx291Kc6zyOBNpyxnSFVQwt1+K/8yH6vmdYRVmNTLM5+tNBKb7tJRBDDdRI3ev/5e1wEQvo0g8PQDW5ozmOcqvLCiPT8V7SjPyZmpCUlD73tSoULzhUCYiU0uoWpA6Aa0tiPnXOu3vqernmlBo5mF+VHXGbDi26oKXdma5TW3Ly5y5l7wwE7TfVKyCwkTL99e6x2eCUf9VNxoFKxfJHCt0grrabQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEZfTvpn42pALj6pVes8ogdtV3txOlNWjYQYhAJyugE=;
 b=nt1hSVjLww9K+xgiyJ6SueNuIjNLKGidWTijX6IYTaNQJyMJKcemxpbtSgj48vspiXHwhjZ5ULCFYNAJA5lXondO/A3B06nRZVhqXthsZLpIJvGeZ40R3Krhzir0qeSldb/HBWO0tHUKw4l1/+56+WA+z+VO5OlvtUG+JHqJh5KsPG2JNlQq9/f8t9VJEOgicl6KZcwNBKWxKClVwY4n0/z3kExkdrEZfi3N29CBS9iTvcHx/LLZJmvVR8c57tuqtbj89HmzwNJUfFevY6T4IXCc0RE18LpHADxqYMnms3qx/NddT3cINU+xTC9vYAjG6gXx7Ra0J4glR3TUPOx3vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEZfTvpn42pALj6pVes8ogdtV3txOlNWjYQYhAJyugE=;
 b=Vk8SjCYWk+weGemNs9rp51IRn7san2FSV1FFEpzJOIToas9gOVg7KENg1ZeltQbrymQI4B/tXU3Am4ADA1gvSSRY/0lJNjBPBO/0XLpGTz9mITy8V6hzWNzMRN2EHBDTzcJ1WX44LrfnG22GATcv6FqnKjZIVxRl7eP8ymq4vJ0=
Received: from SN7P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::26)
 by MN0PR12MB6004.namprd12.prod.outlook.com (2603:10b6:208:380::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.54; Tue, 1 Apr
 2025 20:49:26 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:124:cafe::65) by SN7P222CA0012.outlook.office365.com
 (2603:10b6:806:124::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.41 via Frontend Transport; Tue,
 1 Apr 2025 20:49:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Tue, 1 Apr 2025 20:49:26 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Apr
 2025 15:49:22 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 1 Apr 2025 20:49:01 +0000
Subject: [PATCH 2/2] RAS/AMD/{ATL,FMPM}: Get masked address
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250401-fix-fmpm-extra-records-v1-2-840bcf7a8ac5@amd.com>
References: <20250401-fix-fmpm-extra-records-v1-0-840bcf7a8ac5@amd.com>
In-Reply-To: <20250401-fix-fmpm-extra-records-v1-0-840bcf7a8ac5@amd.com>
To: Yazen Ghannam <Yazen.Ghannam@amd.com>, Borislav Petkov <bp@alien8.de>,
	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>, Muralidhara M K
	<muralidhara.mk@amd.com>
CC: <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Yazen
 Ghannam" <yazen.ghannam@amd.com>
X-Mailer: b4 0.15-dev-419e3
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|MN0PR12MB6004:EE_
X-MS-Office365-Filtering-Correlation-Id: 43e7169d-8356-4e38-ff20-08dd715eb0df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OW4wTzlvZTdYRE0rNHdJNXErZHIzTnNiaXVvNE5UQWZPWmVJV1Q3aW5mVFRn?=
 =?utf-8?B?UnN5aVZhN0Fha0U0L2NXOFN0amM3YWZWb05XUk1Yb29iZFJSSFR0R1Fxa1dr?=
 =?utf-8?B?ZE9qZDJ1NStCVnhySFJzcWFJTHhhUzY4U0RRRzJBSEgxTFR5Nm9tb29iS3JZ?=
 =?utf-8?B?bVNkR3BoVStmN0lnNjF0MTVGZFRkWXZmZ1B1ZVYvWGFrTU82cStsSjZ6VXRy?=
 =?utf-8?B?RW5tUitXalVuYU9PK3M5dXdPdDVNQnAxUFNKZnZmUGpvZkY5ZHRta3VUV3Rw?=
 =?utf-8?B?L3lHN0MwYWV4NHJpWWpQWmY1aEhTa01teVRDTzNUc0VFa1dmSDBwdDZPL1ZX?=
 =?utf-8?B?ZVU1c2VKMkJRdEdUeGx5SGhXTHZsZXJHTHZXOTJ1dmNseDFMMEdWWlZqUzFT?=
 =?utf-8?B?dk45dnV6UWc0TllSc1Y4VE1PUlpYc1Zsd2EvbFVjeXJvZ3AwOVY4WXY0NmJZ?=
 =?utf-8?B?UEFvaUlXc0lxYVRlWmRoQ2ZwaHppc0czN3ZNWjArZkI2R1V0d2NQNENaSC8z?=
 =?utf-8?B?eDhjUlQ0Y2dSb0ZsYmhLZHNOcEM1ZmFzN241anJxUHVnMSszYWNUOGsyeWo0?=
 =?utf-8?B?Z2JnTkpxd08zSFozQkNaVnk4QjZ0RkJDdGdRV0pTZitKWEJ2ckFnaTR1Rlg4?=
 =?utf-8?B?M1hBT0NncHNKdmp5S0grWGRpdm5vbjVqczU5bXBSNXhuaFNaTDRDNzNJZ3Ru?=
 =?utf-8?B?a1NYelFETm5pWjVmYmpHaUJlQno1MDBmMG16bFl2NTFaMlJzemNQMXgyYnlk?=
 =?utf-8?B?Sys5RHZvaXhUU0lvMFpBdE5mbi8zYXdCQ3ZDNDh2WVNzR3VGcVY1ckJzV2l2?=
 =?utf-8?B?OCtkTkRsNDI4MExTWnZyK2xudUpzZVU0aG1PWXF3UFdGUG1yVHNlWUN6dWNG?=
 =?utf-8?B?NS9ZdVpNdnVya0Rjcml4ZklZYUt1ZWh4ZzRDYVZLU3VBaGxQNnZIaHJLNVZO?=
 =?utf-8?B?WU1UZWl5QW5ET3JRNnZmdWJ3dUg5QnRobE5NSXZMUEpKdnBiNVRibEw2Q3Z2?=
 =?utf-8?B?OVJOL29qd2RSU2lLQndteXBkWFRTTTlKU0l6aFJLbzB6ZENCRFkxZGNnMmg4?=
 =?utf-8?B?OGtIMWlRRGtwZUVKbDlQY1RBSlJxalg2TytQZzFmZ05Jc212bkU3UFh1UVgx?=
 =?utf-8?B?Wlh0T0ZoMnY1ampyNjk1amVCY1kwSGRYbXI1Vzhva2s0WGV3emZxalVqdEhN?=
 =?utf-8?B?UUxWUlhLeXdYa0lJM3FVZTg3dTAvdnkwcjI2WkxveExZaExSRXc4V3psQmQ5?=
 =?utf-8?B?OUYzSWhtQk9Fdi84akNYNFFDTEEydmdHYVdlN3BKK3lJSDFrK0xMVjNWOUo1?=
 =?utf-8?B?dCtUcjVZUTlNSUZ4VEhXZWMvOG1hZlMxdWN5REpPd05DSklDazM4Z1hCclpX?=
 =?utf-8?B?TWZFNkNaMXc2L2ZCckJqWXZKUXIwbjFCdmpsU2xKS1VxcHdFNzZ1VWFNK0x5?=
 =?utf-8?B?OU5KQ3VzUUpteXoya3I1cE0zQzVXbm1lWHhiQ0psZHJmVTBsN3BZaksvV2xj?=
 =?utf-8?B?bS8xaEl2a1dkK2RMWld2MVY0UGorNndTYWR6ck91SDJ2azJTK2NqREk0TlF5?=
 =?utf-8?B?Nzk4S1NBUFp2ZkZqdm5jWUxUL0FKVHdWRkFtOUlQZXQzZVIvbmw0ODFBTTRq?=
 =?utf-8?B?TGEyTzlLcTFBdytlT1JmeWY1ZUlhQUJYR0lsUFpCUFNORkNaNjhDSy9oUkFW?=
 =?utf-8?B?ME0vMEJ6d2lJSTFZQWxmRlluWHdZcWZzaE1VRkUyZXpkeEg2eEFKTDVoOUlY?=
 =?utf-8?B?Rnd0UWFlUjNydkRzMkk5SHR5YWRTaURPcTNpcXEvUEpOcG5pNFdEbGdsbzND?=
 =?utf-8?B?UlJGQjEzUTdNS2srZGJmaDIzTUZreWRTY25yRm5rVURqMitzWUdaRHNHcmpl?=
 =?utf-8?B?M0VxMkhZQjBFZnFLbWY5NFdlajRndGRNUEZYSGNTT1h6Zm5wV3NkN2pvUnBq?=
 =?utf-8?B?TmNuekZUd2JoVGd3QXVVNFJ1UHEyUkYwUllFWkZYS1oxMlRmaGI0Y0ZnaUZr?=
 =?utf-8?Q?bq2qFiG8BE+NPuRm7VG+p+/U3yG3Mg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 20:49:26.4187
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e7169d-8356-4e38-ff20-08dd715eb0df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6004

Some operations require checking, or ignoring, specific bits in an
address value. For example, this can be comparing address values to
identify unique structures.

Currently, the full address value is compared when filtering for
duplicates. This results in over counting and creation of extra records.
This gives the impression that more unique events occurred than did in
reality.

Introduce a helper to return a masked address. Do this in the AMD
Address Translation Library, since the bits depend on particular
structures and are implementation-specific.

Start with the case for physical rows on MI300.

Fixes: 6f15e617cc99 ("RAS: Introduce a FRU memory poison manager")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/ras/amd/atl/umc.c | 14 ++++++++++++++
 drivers/ras/amd/fmpm.c    |  2 +-
 include/linux/ras.h       |  2 ++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
index cb8ace3d4e42..0b6e5305ea83 100644
--- a/drivers/ras/amd/atl/umc.c
+++ b/drivers/ras/amd/atl/umc.c
@@ -375,6 +375,20 @@ void amd_retire_dram_row(struct atl_err *a_err)
 }
 EXPORT_SYMBOL_GPL(amd_retire_dram_row);
 
+u64 amd_atl_masked_addr(u64 addr)
+{
+	/*
+	 * Row retirement is done on MI300 systems, and some bits are 'don't care'
+	 * for comparing addresses with unique physical rows.
+	 * This includes all column bits and the row[13] bit.
+	 */
+	if (df_cfg.rev == DF4p5 && df_cfg.flags.heterogeneous)
+		return addr & ~(MI300_UMC_MCA_ROW13 | MI300_UMC_MCA_COL);
+
+	return addr;
+}
+EXPORT_SYMBOL_GPL(amd_atl_masked_addr);
+
 static unsigned long get_addr(unsigned long addr)
 {
 	if (df_cfg.rev == DF4p5 && df_cfg.flags.heterogeneous)
diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
index 90de737fbc90..2ca789d7c8ec 100644
--- a/drivers/ras/amd/fmpm.c
+++ b/drivers/ras/amd/fmpm.c
@@ -258,7 +258,7 @@ static bool fpds_equal(struct cper_fru_poison_desc *old, struct cper_fru_poison_
 	 *
 	 * Also, order the checks from most->least likely to fail to shortcut the code.
 	 */
-	if (old->addr != new->addr)
+	if (amd_atl_masked_addr(old->addr) != amd_atl_masked_addr(new->addr))
 		return false;
 
 	if (old->hw_id != new->hw_id)
diff --git a/include/linux/ras.h b/include/linux/ras.h
index a64182bc72ad..e822275bed6a 100644
--- a/include/linux/ras.h
+++ b/include/linux/ras.h
@@ -46,9 +46,11 @@ struct atl_err {
 void amd_atl_register_decoder(unsigned long (*f)(struct atl_err *));
 void amd_atl_unregister_decoder(void);
 void amd_retire_dram_row(struct atl_err *err);
+u64 amd_atl_masked_addr(u64 addr);
 unsigned long amd_convert_umc_mca_addr_to_sys_addr(struct atl_err *err);
 #else
 static inline void amd_retire_dram_row(struct atl_err *err) { }
+static inline u64 amd_atl_masked_addr(u64 addr) { return addr; }
 static inline unsigned long
 amd_convert_umc_mca_addr_to_sys_addr(struct atl_err *err) { return -EINVAL; }
 #endif /* CONFIG_AMD_ATL */

-- 
2.49.0


