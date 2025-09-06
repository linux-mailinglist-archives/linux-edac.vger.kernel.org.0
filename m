Return-Path: <linux-edac+bounces-4730-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0DAB471B7
	for <lists+linux-edac@lfdr.de>; Sat,  6 Sep 2025 17:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 951A8583474
	for <lists+linux-edac@lfdr.de>; Sat,  6 Sep 2025 15:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A14A1EFF9B;
	Sat,  6 Sep 2025 15:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dbF8kgxy"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CBF315D35;
	Sat,  6 Sep 2025 15:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757171009; cv=fail; b=hTvlMUUEthV47R8Y1BkeRv3YEOk11GZy+ra1414s9uQEBvxJ8FmiHDO9J4ajYRk1ceb5ugdpohPGcK7PTE1DSaI0lhjTlZb1gCUGLgkysTYIoUpYfzUZgo1Gj2cOU3R8iaIoqcI/wr8c8sSS0VN331Fd4ENeebtG7LUdsWRnyb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757171009; c=relaxed/simple;
	bh=iImvuTMXLA3k1EvK9tTJ6dMkywkegKgHif+pejqWxOc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EHylC/2ErnhMl+dzfAtIK6loGZ/mrYPkuPW+0xD0opCFEJ3PjWGtSSmiVumyft00fK83D6Z0DDsmqfjkrnthbPtfi5ZxHPFkShHAAOh4BHxECU8hpbZzmVgB9/LABun0AQiX/dqcnB3yyTKrQN94IKECgodkpUaSS1SZeQUJHNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dbF8kgxy; arc=fail smtp.client-ip=40.107.93.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYkMtCgxegEMcCyx8u4u8HZnU4Z7hClZgYY6sXpCyAS5YwwE0MEGCfGbf5FBCgbpyWBeDB5XAYTMPqe7cz/azoUkQr1zIRyWjs16QioL05JzP0dVA4xmmJ7WJGy64aM6e8ay8A7CkLUK57O+JW2WZBFOVr83cBGrUkUGWsf4bMVhvq3wL8bwUQBM7kMCyfgwLMvJuEBiA8LjZwtLeY1BTK0DwT/9hMItzyvpTV4GpsYHSeXRl2+EwEFvhWlIa8Y8SlqPGthZNerowc0F3ZLVW4CBKtg3H0VRzXD4n/Mfv/YdhRHKEmmbbL8eEyR3Vj48qbiu9WyC+ifEHSGPQAkMxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laCtqat2fdRv4KDFVxLu1nv/qjv+K+TccQI7pxA/Lk8=;
 b=UInGDLyOmEO3s0LiK//w4uzQy6NH2IL/xRq5K4KNyd+J1CmHQCL7hjkEjbRxpo4oHZqrV7n0V545sMAgge9+7GbQWTa+RxrapkfWIjRAyVoGoJbSqTls68ND9Xx9EyK1iMPGsZOBs4YSMT/76h7NiGXJTAsqeeX74jF1jFwUAKcWmF0XLzFqTT0U2vudLlUcSF0ThVE34ycYYRDFPlOZfV1Bj1/iNYDuq1+WY+oVzPWdUxLqQ6ripUH7p/kBCHAK2ApFAR/r+XsXdAJ8zsTZ6UGePnL4foQ/47ol8FmKoRhc5QmIyfnEiu+9dTrx+w2+4P73Gf/H/4xq97FUrv8fdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laCtqat2fdRv4KDFVxLu1nv/qjv+K+TccQI7pxA/Lk8=;
 b=dbF8kgxyXYXEhEJooyNEjbC13nSWDcWFeWyDXj3atT5NdiI5+gP2aKeZiuoHOPkL6om17Z4qFk5oeZRCfpAmKXWiKg6EW+xrpNcA54ZFFTrLtrZMkcl3jW+JbwwXSZ2+ZpVNpVkzkuFcwJqEweaEPOndKNqMU9eRFWDDY/sUY6M=
Received: from BY3PR03CA0011.namprd03.prod.outlook.com (2603:10b6:a03:39a::16)
 by CH1PR12MB9645.namprd12.prod.outlook.com (2603:10b6:610:2af::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Sat, 6 Sep
 2025 15:03:21 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::25) by BY3PR03CA0011.outlook.office365.com
 (2603:10b6:a03:39a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.18 via Frontend Transport; Sat,
 6 Sep 2025 15:03:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Sat, 6 Sep 2025 15:03:20 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 6 Sep
 2025 10:03:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 6 Sep
 2025 10:03:17 -0500
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sat, 6 Sep 2025 10:03:13 -0500
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <git@amd.com>, <shubhrajyoti.datta@gmail.com>, Rafael Wysocki
	<rafael@kernel.org>, Tony Luck <tony.luck@intel.com>, Borislav Petkov
	<bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown
	<lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] APEI: GHES: Replace log_non_standard_event with direct tracepoint call
Date: Sat, 6 Sep 2025 20:33:07 +0530
Message-ID: <20250906150307.13921-1-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: shubhrajyoti.datta@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|CH1PR12MB9645:EE_
X-MS-Office365-Filtering-Correlation-Id: 949ff642-68a7-4670-242b-08dded5684c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J7Dd7U3H2vzXUWQyIBj0KiYu9azHrEYC04aeXz7r6Dv0FFv4TUfvW1o0WNIP?=
 =?us-ascii?Q?1L1fBO40t0NuJYb++CIusBE1IpeuUaxnKaVsZZILTHJYaGxgeQQi4Z7shgLb?=
 =?us-ascii?Q?Spra45Z19DrmTDRM7cbV6pZaMIIHGO4SyYtDydFjlvlsHuMQm/29eiGTB0Xc?=
 =?us-ascii?Q?K4ixiA0Qnk0klF0b3kwl2pXorDLiJbkw75dPw1FoWol83OIb6xSRhtOQbx8s?=
 =?us-ascii?Q?aG3JSyZqROYi7ijs/4ufkr4KY235Vnph++Hk4LwVD+YLUf5TcGNRPDXm8u7u?=
 =?us-ascii?Q?edQpLkr0HWDKEJuxiCfyYRuU+pZ/U5UQ+FgyzbyyJTmWI+TlYAgTSFk9aVHd?=
 =?us-ascii?Q?xQJTX/1lokUR8yoI3D6+kN5/MMAgNHZZ5mmetxSirwF1YBfvRsAV7+EwfAR9?=
 =?us-ascii?Q?MwAZzbFhLWYo2D6DnhiwZABpc9XICdtv5b80olhMz3BAGGmT50Y3E0cFSN8d?=
 =?us-ascii?Q?oAF8jIAHYqQBVhse7ElsVCE6OupEeE5DVRnbXFB2hI+sbjuHjY29udv2J5qR?=
 =?us-ascii?Q?N/hfl/Oj0yx9ubmMyUwievRNZQ/Yr+mH2xpbRlhQ3vlRITrodfar3GxkLNqa?=
 =?us-ascii?Q?XU1axaOdUjDLVlxujQTU6S5Uw3wc4Y+w1G4+BcRu4/oLT9DzsXO7nrmiIEN0?=
 =?us-ascii?Q?dy+3KvTYQVvh5hb40PkprBz4GeJMzmTTeQD8eS7oQHpC8G9jGRNM1/Hf+E7K?=
 =?us-ascii?Q?Xo8NJ6PT3yaPs7eLKiITQIrVTY4xhvY5jisjk1mEU7u7haSXSPwurqHUL10z?=
 =?us-ascii?Q?urcBmfte7dQol0SZ140VINZGE1zagd5vZjcDiAL8bE+5asoKqNR+k4mlvlDa?=
 =?us-ascii?Q?o/SmcHcZ9tlaU6AAmixJqE7KhSLlCsNZVuGiEqVxnQH2reWFVoAl3gVAHezO?=
 =?us-ascii?Q?0UnrNbcqCi1nUK9LToczVC7O6O3EtruMz0kF6EobcbGgGAG2S8QjDYUoOx+Z?=
 =?us-ascii?Q?4onAQoC3SxWnYmiKHQ4S8RDs9XYkIfe1JJn4neZgAjmF/m6c8VZujjBtYyYW?=
 =?us-ascii?Q?Y9Rvp5OWd99uahDOwI1zH0ATsDhOyr1NWZLaOTgZRz0ntziS/mZevWgkjx9d?=
 =?us-ascii?Q?G7Lt6X0+6Oo1UpThsX3MYJbE+OZiC7J3khu8LqsFQN3SrdTJXmrzA1K5cGa8?=
 =?us-ascii?Q?dprvcO0InuW+empGXPGW8NOXEYl5XAr1im2xMiFY8pzeehu+wqSbAb3eY+e1?=
 =?us-ascii?Q?/ESqIEV0E56i9pzAQk30sjt2MWO6tX9UEqtjjdjDeDvcwVMDxY6Vrkg/nWEl?=
 =?us-ascii?Q?QOE2YTZkSPMDtGj7CmEOXAFS8fyENk9xt44slCP56FVhDY4e382/guGaDi7H?=
 =?us-ascii?Q?acRAQPLqwFLbH3RKu3LHICYI4Mz62kDDJNcis5bpnDaMjgNeHZH95bTv70qK?=
 =?us-ascii?Q?Un/bw+PCB34J8j3z4UUjC5/E6WzitBNTsJbmn0bN8rF3fehrFwihS9wKKCtw?=
 =?us-ascii?Q?jiAnwlYa0M8eEYvB8G1b1de28xgvENboX7OQUmJlJiO1lLV1MCGl5exxBEOj?=
 =?us-ascii?Q?RYOtM0YI4wv1h4H1+Te9ltX47oroW9EQ3SfiACRfSUCuiRgOdpzJ7vWdvw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2025 15:03:20.5675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 949ff642-68a7-4670-242b-08dded5684c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9645

Simplify non-standard RAS event logging by replacing
log_non_standard_event() with a direct call to trace_non_standard_event()
in the GHES error handler. Remove the redundant wrapper from the RAS
subsystem to reduce indirection.

Suggested-by: Borislav Petkov  <bp@alien8.de>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---
discurssion link
https://lore.kernel.org/all/20250901151658.GBaLW46ibJuf4kGgnl@fat_crate.local/

 drivers/acpi/apei/ghes.c | 7 ++++---
 drivers/ras/ras.c        | 7 -------
 include/linux/ras.h      | 8 --------
 3 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index a0d54993edb3..43896a476fd7 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -921,9 +921,10 @@ static void ghes_do_proc(struct ghes *ghes,
 			void *err = acpi_hest_get_payload(gdata);
 
 			ghes_defer_non_standard_event(gdata, sev);
-			log_non_standard_event(sec_type, fru_id, fru_text,
-					       sec_sev, err,
-					       gdata->error_data_length);
+			if (IS_ENABLED(CONFIG_RAS))
+				trace_non_standard_event(sec_type, fru_id, fru_text,
+							 sec_sev, err,
+							 gdata->error_data_length);
 		}
 	}
 
diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index a6e4792a1b2e..d51c546c2606 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -45,13 +45,6 @@ EXPORT_SYMBOL_GPL(amd_convert_umc_mca_addr_to_sys_addr);
 #define TRACE_INCLUDE_PATH ../../include/ras
 #include <ras/ras_event.h>
 
-void log_non_standard_event(const guid_t *sec_type, const guid_t *fru_id,
-			    const char *fru_text, const u8 sev, const u8 *err,
-			    const u32 len)
-{
-	trace_non_standard_event(sec_type, fru_id, fru_text, sev, err, len);
-}
-
 void log_arm_hw_error(struct cper_sec_proc_arm *err)
 {
 	trace_arm_event(err);
diff --git a/include/linux/ras.h b/include/linux/ras.h
index a64182bc72ad..4bd3ef7ca6d8 100644
--- a/include/linux/ras.h
+++ b/include/linux/ras.h
@@ -21,18 +21,10 @@ int __init parse_cec_param(char *str);
 #endif
 
 #ifdef CONFIG_RAS
-void log_non_standard_event(const guid_t *sec_type,
-			    const guid_t *fru_id, const char *fru_text,
-			    const u8 sev, const u8 *err, const u32 len);
 void log_arm_hw_error(struct cper_sec_proc_arm *err);
 
 #else
 static inline void
-log_non_standard_event(const guid_t *sec_type,
-		       const guid_t *fru_id, const char *fru_text,
-		       const u8 sev, const u8 *err, const u32 len)
-{ return; }
-static inline void
 log_arm_hw_error(struct cper_sec_proc_arm *err) { return; }
 #endif
 
-- 
2.17.1


