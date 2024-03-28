Return-Path: <linux-edac+bounces-844-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D727A8907EC
	for <lists+linux-edac@lfdr.de>; Thu, 28 Mar 2024 19:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBF84B20932
	for <lists+linux-edac@lfdr.de>; Thu, 28 Mar 2024 18:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9191311BE;
	Thu, 28 Mar 2024 18:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kFdqSFVf"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2057.outbound.protection.outlook.com [40.107.101.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1DC12F391;
	Thu, 28 Mar 2024 18:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711649114; cv=fail; b=Dkxabl+BjApcmS4P42xFx4eadSkztdYnbPEwveCYEGe7x6Ldk688vC1vqiOpXpBxXK8RiILjj60r2RiIR1LdR2trI/ECztwN2w1TIYj/+2uy4EnlzfVIskAToVvulbYOXtT5fmcG7NAGYmR5E0xl1rNWLkmTkoOj7bm8TP7xoWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711649114; c=relaxed/simple;
	bh=Gua7hd0PKOqtmndmLeAr4YM/Zql2Sbh/dUvUNuhpz8w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QPgBAtWudYhzt/ukpkYi6JRKCpdXtYChVn1BtZ3cMmuhW4KA9Gm+T9o1RCYMS7xAqub/up/JLFwBy/r2XLT/jW/q+5GDz9vEGyxFUyLedmtF7y2u19S+420iswu+uVfG7I20KARaFvg30cT5BAxL5MOUmtUjbWuZmwBEUZUKemY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kFdqSFVf; arc=fail smtp.client-ip=40.107.101.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDOwigkKxdI+CsegMkZuHa6ES9eOASTYwNvvyTPYhYMrwCFcZlm68L6lBR1SsadT7/qg3tAtT3lMjLw/fEy2ighoCopUfVjcs5Ew6LGuvON+k9h05xFEzC+kgxV+kydOX1IfdqcI/u0bioHZQ+kuYYvDZqAY88BBErNDHcg0RMiddBx4W8uZ34u3MyfGH1MpFF84tpY+nT5HVQB+d+BuovTfIzKXdBlpy1u09TtfMPHjUlcWriNCx1HKTQPqtKEFTN+czdlXrBDnuyRwGxfnYP1RkV8Kx9gaR28mwchSHuVLSc/A+0bhfzi+CO2bcO++YGb7Zr10ufod7sNmCrgUDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8i/4pchHJNfrh5ln2ekkaxw5d7lPbqrkW/4irDCvtxg=;
 b=IAleIvbA60vQnWbne2fUJZlqQ1m5BoeN7qIVOcFBuzQFnjIFaU91QMrdwIiAfhW1nCjVNnMwwDfEQpKR8NFPOeHYhuSy1t9anL7HL9pfurM7BeG8BDCm8aSDrU1coq+ep092oLNA4nYCvGlEqVv00ko0vc9BBKxtJrwgLtpNN8KnN5F6Ii+NV7frcmHevbZj+K85K+FtEXcsOX5SkGRB+cylTj81k4KXRk0zGslZJkg8673M/ahXWx/Hf9G1A6AzC9bmim1fMVQKPvmeULCdMjluMZ1JACiFLMP4Z8uDOOWu4hXNyCcKJCEvPCuisUpN1KZOnP3rzY/P9+GEWfokPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8i/4pchHJNfrh5ln2ekkaxw5d7lPbqrkW/4irDCvtxg=;
 b=kFdqSFVfzGYTSplEjA3Oc4P7pb42WnrRAIOjEk6v8lOPVkjBy1ROAdL3PDlz3P7JYjRHgNl+NjpN22DVsYLyEjAeIjG3JcyXGta6UDwZRTdE5nbvf9yq/2UsIiw4iM6g6HpOUu42SodYPSfWkTPDZPEVdmp4n4eMFTNV/NliMRM=
Received: from CH0PR04CA0022.namprd04.prod.outlook.com (2603:10b6:610:76::27)
 by DM6PR12MB4315.namprd12.prod.outlook.com (2603:10b6:5:223::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38; Thu, 28 Mar
 2024 18:05:10 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::51) by CH0PR04CA0022.outlook.office365.com
 (2603:10b6:610:76::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 18:05:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 18:05:09 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 13:05:07 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-trace-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC: <rostedt@goodmis.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<x86@kernel.org>, <sohil.mehta@intel.com>, <yazen.ghannam@amd.com>,
	<avadnaik@amd.com>
Subject: [PATCH v5 2/2] tracing: Include Microcode Revision in mce_record tracepoint
Date: Thu, 28 Mar 2024 13:04:35 -0500
Message-ID: <20240328180435.435076-3-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328180435.435076-1-avadhut.naik@amd.com>
References: <20240328180435.435076-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|DM6PR12MB4315:EE_
X-MS-Office365-Filtering-Correlation-Id: 6398cbbb-890e-438f-55af-08dc4f519bb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GlUns7ttzfvu2QLJ4WxyOCIu12Bt+x/BaXZi7xbscFlbeChWuQKxeZldcvRfUIwKGYj639GDtsbOXlrlW2EuyZX7jZ4KdiN2Mcxasx18cF5q5DEnX6ZfQdxX/vbK4u+d+RXHa0UXI+I8KmcSgMbAv8xQzG7Y9qIQIqiVSPzEM5PNyhf8nbP8B2b5Z1U3YhF8VRluI18/9Opm8tr2kH6H/0z9BGHqObxsV6DggpszPd5g2GBA01bwKeqhZdMkr19QPSv6UFUdWAPSEQna5GzDZSScE0XmlLd4Un/1MqBRiO/1dEJrEbSb62jzK+UY+xKSFFWGFIo8dnaG9vuX/vqYLYOnS+ROWMsci7+7H9XxLxch+OpoOZVKAIs1mPOh9/ro8Z28zAt0YtmX3WUZhjQLQB18z17IQNBbjGM43foCgPScnO+wSBXgtqFuM2xdGydyi+JqncIYcn9T9INyw0BG3jgO0JHf3rfghejna/TWgpqwBKRh0TiBAIXElgWQwhE6hVmvNZI/VVZHTsN1+bUPV2DaCuHm7at6sBaEzzfJK3nzLIIO9SNCOEI55pGjjvhsGiXvbFvrOHDaFpUn+3oRXQYYbSINkq3iIpqGdIhkO1kv61WSWg7ZdkJVTBwdDRpErBl6Hjdm2SIL3SNGkHJSqaPTHa0a+FeJc5s2fyXPGOKR+kw16EEtGAYI7Qd94L1jFTHRbbX74HWQdX2NMGbo2SMX4QeWtrBxQNzxZ9aNNeVdSsSHly1SK4HTYtrJ5kGP
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 18:05:09.7868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6398cbbb-890e-438f-55af-08dc4f519bb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4315

Currently, the microcode field (Microcode Revision) of struct mce is not
exported to userspace through the mce_record tracepoint.

Knowing the microcode version on which the MCE was received is critical
information for debugging. If the version is not recorded, later attempts
to acquire the version might result in discrepancies since it can be
changed at runtime.

Export microcode version through the tracepoint to prevent ambiguity over
the active version on the system when the MCE was received.

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 include/trace/events/mce.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/mce.h b/include/trace/events/mce.h
index 2e339ac9d706..c7d0edc778c3 100644
--- a/include/trace/events/mce.h
+++ b/include/trace/events/mce.h
@@ -42,6 +42,7 @@ TRACE_EVENT(mce_record,
 		__field(	u8,		cs		)
 		__field(	u8,		bank		)
 		__field(	u8,		cpuvendor	)
+		__field(	u32,		microcode	)
 	),
 
 	TP_fast_assign(
@@ -63,9 +64,10 @@ TRACE_EVENT(mce_record,
 		__entry->cs		= m->cs;
 		__entry->bank		= m->bank;
 		__entry->cpuvendor	= m->cpuvendor;
+		__entry->microcode	= m->microcode;
 	),
 
-	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, processor: %u:%x, time: %llu, socket: %u, APIC: %x",
+	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, processor: %u:%x, time: %llu, socket: %u, APIC: %x, microcode: %x",
 		__entry->cpu,
 		__entry->mcgcap, __entry->mcgstatus,
 		__entry->bank, __entry->status,
@@ -77,7 +79,8 @@ TRACE_EVENT(mce_record,
 		__entry->cpuvendor, __entry->cpuid,
 		__entry->walltime,
 		__entry->socketid,
-		__entry->apicid)
+		__entry->apicid,
+		__entry->microcode)
 );
 
 #endif /* _TRACE_MCE_H */
-- 
2.34.1


