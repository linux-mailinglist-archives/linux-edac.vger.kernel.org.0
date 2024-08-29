Return-Path: <linux-edac+bounces-1751-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A499652F1
	for <lists+linux-edac@lfdr.de>; Fri, 30 Aug 2024 00:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240E11F23FE3
	for <lists+linux-edac@lfdr.de>; Thu, 29 Aug 2024 22:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E1818E745;
	Thu, 29 Aug 2024 22:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vsWRTMj8"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0A218CC14;
	Thu, 29 Aug 2024 22:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724970765; cv=fail; b=pYt19cWxwe0eTVr4OKS+Bmwf73JKIg1UmCKCy5tnoVCZgMRxv+rkWtwQYHUdubk1KgG21ozVO3PpeVR5I4BLTH5yW4tmPHZyt3GEyDtAYxxXRoxU/5qbk1Ny4nGnMLYBCHTtLOeG/P5iiueIj/pugEk0l1pKdtyGZOtxkSofQ2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724970765; c=relaxed/simple;
	bh=IXY7k2ty+v9OVcAU8FA3DrVsGlqS7HCkBPRD9PNsHoQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SiooFNYlNpMGM9zgnGECaPxhBBcCtgDNptucaSKG586ej4avbb5hx4jS+gZM5xJXlz7YOMkV+6RMooHqQMMQ1SvAmcw53BmE8QNcbkKHIzJuYDhfixlS7j+Fwm1fzRpSo3nfFQ8NSPDFKhz21NCPzWWQkadZwyISGngxYhMFY6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vsWRTMj8; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wVBJ6QGelCzf5wljsRcLdKs+vrTj74TaYDKAfnwFH8i06wfgdgufINVAsLM2T06W+VebcIz/Y+PzLWVxGO0ytixYJW6my2LfXIEJX+AkFtwmN7YrBpkXss80pqPSJh2jfryN59z8kQtFjdIaYQkxVBzBLUt++SMUmVeBNmwFE6Ih3WOgdQem3h7yVWC4SxcWf4ZTPfVbHRFBLRCeSzW7CSwwDPEBCjVB/3uczE2DIKsXCA0h+ROgsirKhQ7gENshr2mb6gjNdlq83S+7LlMBUHqL/ye9L1yn0lwqNP9LfPzaNgQkQlOwgjlobonj0MdNxIK/a2TMRVFr7/yUk0sVwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfVJydh3scSWqfM/fwol+epsymyxIAST7bOrKrGi3hI=;
 b=ucd1COTVf7MQXBF2D0U1paOuEndFZGf21fV47u/IxBpjPbPY6NuINtBUaI++gSrg4gJR0Ns2jVQOm+SeryoTznpSzMVtUTYV8lQNwXqz9aeCzf8IuCOLYjnaeiQKoT+VH4EKSuxGtgRsyOyu+IAAax5lkM0CmdBAjeU4eiQbSuvrN/gmEF2xJrYfk1xfpyyosxynj2S+ybgpen7xlp7Wr7bczccYQUzUakGcLBLZJS2PGjmxnS1k5l62gGkvqB+wTGAlzmWYWopdQ6q/UdBLVVN9zn+6oRcgTs2M2EWoCHJ4zZ2SsWteShaoz6tAx/r/GMTJNEGwR2TI2SPFdZouGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfVJydh3scSWqfM/fwol+epsymyxIAST7bOrKrGi3hI=;
 b=vsWRTMj89ZKRyPrzLxRP39Sr6+8ikviaPsHEZdpZvj4ZICT9W8WYNeGJFi5Ajs6szb5szFC2+cGO4JqHKwmj0EXtSAfrsv63/2MLcKffaZOsYrUbG9nJDwHGTQDzrp+Yb3reOBCcOUzWPhZ+OZyqpOCPRC7aMyErTXB4Ag0jf/0=
Received: from BN0PR02CA0002.namprd02.prod.outlook.com (2603:10b6:408:e4::7)
 by BL3PR12MB6402.namprd12.prod.outlook.com (2603:10b6:208:3b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 22:32:39 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:e4:cafe::f8) by BN0PR02CA0002.outlook.office365.com
 (2603:10b6:408:e4::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28 via Frontend
 Transport; Thu, 29 Aug 2024 22:32:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 29 Aug 2024 22:32:39 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 Aug
 2024 17:32:37 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<avadhut.naik@amd.com>, <john.allen@amd.com>, <boris.ostrovsky@oracle.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [RFC PATCH v2 1/2] x86/mce: Set a more accurate value for mce_num_banks
Date: Thu, 29 Aug 2024 17:32:24 -0500
Message-ID: <20240829223225.223639-2-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829223225.223639-1-yazen.ghannam@amd.com>
References: <20240829223225.223639-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|BL3PR12MB6402:EE_
X-MS-Office365-Filtering-Correlation-Id: e6599003-d6cd-4d48-1d96-08dcc87a7d53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wedm+p8uNWZXzjqdQjB0fiRczaZHWbdYiT56vytNePiQ8o+RxVOOwuWlxFrd?=
 =?us-ascii?Q?xtjtsdk/c44FgtsPD/cvzHB2IymR4JaOtImbILNd1AO6y/DLZJwNCHOFGC59?=
 =?us-ascii?Q?Ktt4qeVG4pIaGMX6B8r+l+teI4RfmnLe5NzsEK82tMIrUXeAbm0h+1qdhktx?=
 =?us-ascii?Q?ugYfsRF+K14Qfx0ytV3vs342c2aH6pVnLw15BP34DQtxhj+7k+Me+79s01LT?=
 =?us-ascii?Q?F5jGuqrq2lLiT5/Obq1E7TTI7CuxgdgPsXWNGNBuhQ+mfyckYl4yI7LMKJeq?=
 =?us-ascii?Q?h62RPTlg4frM3Izaj1jBysVEUSrmREhZdVkNiKnBsojj7fZkaatiFO14xD2t?=
 =?us-ascii?Q?O/ua1w9VwqWADXgBp5IL/NVNOzQyfncLE6ltdZVjrBbyvVMWhwhn28VLfjDM?=
 =?us-ascii?Q?S/qDQwyDK6p0TRmIFlfI01N0JIEdKf7KnVMeSNVVRt1qZo/f+bRYU7aHJZrW?=
 =?us-ascii?Q?csZLjbYWrSOG2xg3KXSxysmC4lezLnyT5IEBbQfr+XFdHMb2AQQzrrKEorHz?=
 =?us-ascii?Q?DFNT0FLQJgIAwr2HbzBqowrvt4pCJdJZfdTAEPfDU5VucgbQ9kgb51qG6TkL?=
 =?us-ascii?Q?an6vONWWZZlmBYhjn3xNFLguV8nUmHj4XNwDsDsyYHsxubv/UHywGqAznlk3?=
 =?us-ascii?Q?aZAA4QuDUHZ360ROD2jyqJMMEwWBlsqItl58uYJV4FX6fU2DJWkRxDpJqOUx?=
 =?us-ascii?Q?FhPkgWcYNac1Z6bz8VqYcG97+uqm6iW4lMW6ne6UrptX1o5ONy3rsAie5E7y?=
 =?us-ascii?Q?0DTmNASj/f3UUYgVmvefEwcTilbngsejiUntboLuvuNovUr0KvypkJfc+DGQ?=
 =?us-ascii?Q?o4LhIgCqMU4onf7LFwz3IF6lqwVNlsRqxpC2NCwLFXHYuidCRrrsaQ6Jt53N?=
 =?us-ascii?Q?3J+b1+4TbEdFwKJVjTAhtMT/56tfR/mtFCehuWVzzdbkmkKhGDrimLNEnwIL?=
 =?us-ascii?Q?y2CeM+gcKHcXjoE44dbLtqask8yOEBpwAhnesRZ64LTVS4Tdp0kh0aYdMpfc?=
 =?us-ascii?Q?nKhMUZ6pBNVtP61K1zGOrzejPj68HlLwd5f5xSnq98fTyr7z4Tc2ORMdKRcc?=
 =?us-ascii?Q?YtqD1t1Tg+cnWlpNOObL17kEA6FBsw2k3hztuHflxC3uk140pt1EeYtonz94?=
 =?us-ascii?Q?Us8JNb8qb7D77aoHbnnSwNJrlDvJettzegdn2jksite0p3JYUefETa8qpDEV?=
 =?us-ascii?Q?G/JOewKXYMaPfAd0H0/D9VZi305V1qF3w9QdKc4pLUJMO1hhw9wJfQIwUrHg?=
 =?us-ascii?Q?doBlA0Pz335FM6dRGXDmFRZVMrrl8Pld+VkuyKPHMlaYmTn/kEvhA4FaUg2R?=
 =?us-ascii?Q?GFji4Ta6ctJb1Ls16kPsQWGPjGEaKeINSKImYnTsSbLfYiyMYgKfzAAlbq2/?=
 =?us-ascii?Q?51naJf8jBGNN9X2pmawIL6yskCQAgHhYH4cHrZsscHxXW12rrDK5uekA6SMG?=
 =?us-ascii?Q?IZ0rhtvui7Y5AjmJFSdCgxwa4rt0S17P?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 22:32:39.1744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6599003-d6cd-4d48-1d96-08dcc87a7d53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6402

Some systems advertise more MCA banks than are actually used. For
example, MCG_CAP[Count] gives 64 banks, but banks 32-63 are not used,
i.e. Read-as-Zero/Writes-Ignored.

This causes more time spent checking, or trying to setup, banks that are
not used.

Currently, valid banks are already checked for during initialization.
Extend this to keep track of the last valid bank found and update
mce_num_banks to reflect this.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 2a938f429c4d..33893b5c8b0c 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1866,8 +1866,8 @@ static void __mcheck_cpu_init_clear_banks(void)
 static void __mcheck_cpu_check_banks(void)
 {
 	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
+	int i, last_bank;
 	u64 msrval;
-	int i;
 
 	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
 		struct mce_bank *b = &mce_banks[i];
@@ -1877,7 +1877,12 @@ static void __mcheck_cpu_check_banks(void)
 
 		rdmsrl(mca_msr_reg(i, MCA_CTL), msrval);
 		b->init = !!msrval;
+
+		if (b->init)
+			last_bank = i;
 	}
+
+	this_cpu_write(mce_num_banks, last_bank + 1);
 }
 
 /* Add per CPU specific workarounds here */
-- 
2.34.1


