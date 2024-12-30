Return-Path: <linux-edac+bounces-2753-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1D79FE2C7
	for <lists+linux-edac@lfdr.de>; Mon, 30 Dec 2024 07:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9969C7A10E3
	for <lists+linux-edac@lfdr.de>; Mon, 30 Dec 2024 06:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D937717E900;
	Mon, 30 Dec 2024 06:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LsxihZAh"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4580C259483;
	Mon, 30 Dec 2024 06:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735538601; cv=fail; b=FsxDx8gVUH0CoEjB9V0ykzdD7WVhw1CrTigbc4azfCJ3utJs4jtPt6zf66d7enaNf0RR6G00nWk2fQo09xjpv0ytVC6gRwZEYUXPCa8XQmxlFxknC4ilbPk9Ja8rJP4QYv0NYUidh0AsSypnxygrjNnHLVvrIY2locymmR8yT6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735538601; c=relaxed/simple;
	bh=nfNNHQfnVgSqbeMKux8bAYJHFaQ5AENgZQH7GZZywIk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D2JV9DEz9S8fUZe48rfRvLqhv/2tGa5M9pVDBR0netcdFEiSBMOui9nZPIpYd8xhrHVaKP/Hqw4Vd15Pe29W+ha44Yuyx3YUdYEGX4V4f9UZGTOw4aRmfW65436onMkiFxI1HNbFqvN4ao5XrT1ohIf3y3+7AevCOAyI+d5kmIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LsxihZAh; arc=fail smtp.client-ip=40.107.92.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WowU3gODoMkyrEtERIftTLbZXfBxjlZbDlCMhwp+HBOckpS1j7I8Tn/65ERIaHKrjBhCfHoKN2PE5SoZZhUOiJjRMQG27UR6jo2I02CCneP9yutDrkfs9NAHV5+8dg3xHYDGVtT9p/K3CrVDdzh4k2UTEldU87xchDruGUCmWO2PA24LhpxipM7KutICWigX0RxljTB687879jC+UJpaGD2HpADSQrS+nzxq7G6yJf83fcIr7uKs9JNG61rzzS/FGa63pCbPheLvP7EdVCEQYDCye9zKgtteWBAvEapQr/Ex2anF1IauIj3WZ5RFDIaZreVPM3/LFYitUrm2zikrsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCdyxDigcTPL6qCdsgvbbkkpM0NIaw+UR7W747UQRZ4=;
 b=gjcEAOlSUZRnyZr+qNmudUot7gmlq+RboiXIrNuavwfKxIQP+q7FHkIOcU6+d1NOqCfpTUWervsad2m6R2c1abzn0r337g3ls0x1aZ4Sl3ljV2hK7fozPcm9cUBX9ksZdnKadMBXqhCirlv0vCIGrESdo+eG3JQyBGBNFXgcSLuVBX6Po/bYI2UoFsxFVfyDMuN+4pHbJSX9hCl4M7GjtKWpPRqjtSpg5w6nSuKUEre/CprvimT0aRDPWCWPI4HjZ7f1tl9lIWdLejXkIKz44LSNpt5unLBkAGZY9zsy4NnURdHTDtxOvkfKXzhviH3t0MIC2YLYY9moxk1EtkLVCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCdyxDigcTPL6qCdsgvbbkkpM0NIaw+UR7W747UQRZ4=;
 b=LsxihZAhihZ+2PTQWKOAPJ70r7JNJ+0Lbcg6wYW3IFEpXMcSgzGR+o4+/x+GY7gTBF9zOLcpHTp5Y0ZOd1pB1Onn59+g+E+HpfR9fQ8/aGpyj+6nCXyrYXW88UH3MgMr7qY+8bpx/839FOAXgP01d4pChUS05G3PjbGB8cxsWJc=
Received: from PH0PR07CA0052.namprd07.prod.outlook.com (2603:10b6:510:e::27)
 by SJ1PR12MB6219.namprd12.prod.outlook.com (2603:10b6:a03:456::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Mon, 30 Dec
 2024 06:03:10 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:510:e:cafe::be) by PH0PR07CA0052.outlook.office365.com
 (2603:10b6:510:e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.19 via Frontend Transport; Mon,
 30 Dec 2024 06:03:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Mon, 30 Dec 2024 06:03:09 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 00:03:00 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 00:02:27 -0600
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 30 Dec 2024 00:02:24 -0600
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Borislav Petkov <bp@alien8.de>, Tony Luck
	<tony.luck@intel.com>, James Morse <james.morse@arm.com>, "Mauro Carvalho
 Chehab" <mchehab@kernel.org>, Robert Richter <rric@kernel.org>, "Shubhrajyoti
 Datta" <shubhrajyoti.datta@amd.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC: <git@amd.com>
Subject: [PATCH v2 2/5] ras: export the log_non_standard_event
Date: Mon, 30 Dec 2024 11:28:46 +0530
Message-ID: <20241230055849.11183-3-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241230055849.11183-1-shubhrajyoti.datta@amd.com>
References: <20241230055849.11183-1-shubhrajyoti.datta@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|SJ1PR12MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: dbab6e2e-126c-417e-fa3f-08dd2897a30c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BASUDjuLnzxLQsE8CkC+MbV2xENjYgp9i6fq8ra255p5hS2YO0x6JHhdduA6?=
 =?us-ascii?Q?ZZq2Wp9eypClT9Uofzjzv2NFd3AdWqeKHZPqbTN4eau96YlqAJSFggRWzSo2?=
 =?us-ascii?Q?Z5gaKaP7outLXJmpVVQIXLuDOAaEb1wedT3WczyPMob0c62dAjIVnc+dvHd5?=
 =?us-ascii?Q?pwewVMsF+vECLaPKpRkCufBKlpJl8H4FL4Ii3TggFp6SjigMc8hEeeeUpeIe?=
 =?us-ascii?Q?/T3jqPcmQIqBXtd/L1HKxCrbsoWhUNB7AWjpRoG+qCMP7AsyDG9f0Xn6+hF9?=
 =?us-ascii?Q?4LDd3waXT1nE840BnP5aqUH5qzc5L/773pqoaQyq6u8gNSNg+eMyf6nZP7BN?=
 =?us-ascii?Q?CgjpFqm60ODID6TdRGRDwJvdFsS1cxwFz2KyVPMRxlAWj+aLCcPXiq2lomX2?=
 =?us-ascii?Q?Na4ckIjCCCtRux2oqj3fcBLikaZoYof41T3J3VhAA49ZAcYLYD++CKHeh5Sd?=
 =?us-ascii?Q?XlFBUru+qEYb6kpJobNyrcumVjKRHGng3yXnaPNN9Mlzh3uRexDHu5TEa5Fm?=
 =?us-ascii?Q?sSTtNyW3GWHDzAHAPCGzhj8vbfhW6+ihToswrI4ILZrrMqy+obtkJ3x1zA/R?=
 =?us-ascii?Q?fxDTaIbXVxIk+c+aIo/UFriQ2Q/nCbwJl/uIWAqOJk9btCEo6ZGbytakMhkl?=
 =?us-ascii?Q?LUTnmmgOlEQRduxOolkuSkvjrB3opiYjBOICVs9EpNBjaXBfo/dPByF9PyLw?=
 =?us-ascii?Q?EjQYzxCSSaWSqi0sHxE7qJe56j7o1l9LL3Iv7p+fhze2H8cNT52WbZc+Rvka?=
 =?us-ascii?Q?V6Pbhycmxr7XWydOeSmBt6xhAm71jtsFj4KB1T4Ov/2jkC7oUIZFVBrGsxLZ?=
 =?us-ascii?Q?uUJ0ze4wGuTtkLeREs+ClFAK34PfC1QhJDt/nChkWDPW+y0HykKlzHfdEYPW?=
 =?us-ascii?Q?mTCzOPB7srp4vnfVUSxTz1FKsXmAizhliGDDEPMBR3yxbKaZySQ+N/qoOmE6?=
 =?us-ascii?Q?1FbnhkTQ3iKjIN6yrqS/ZHfX9uAij4z3JSj+A5kgQQ8wVUGcZgQXm7GDmHQL?=
 =?us-ascii?Q?fM3PktZ/TohoIpKOZHsue4UqCd7VKoIUKfpYZccm4gsqjYTemlQ5VmUHxfD1?=
 =?us-ascii?Q?96ZmWeLISei2X+okNxmMDLkMtrL5cu1V5JkTKG4crps91fQKFVAZV8o6Z2yI?=
 =?us-ascii?Q?bfQlZMyDxxPCqILW5P+9BuIioldF4otoXlXliR+7StvOrMtqsNU8D2MqLvdn?=
 =?us-ascii?Q?tvGc/hgDVfAo5QxA9RABwUUW1I/QXJ+GYsGUNY1Hf3IUxr0X+47d9JDrXYAS?=
 =?us-ascii?Q?gJ1YWfvabFsDZK7FsIzO7ZbUIy06k3feUhkBLumvf0g56f7xvGgeR294W9du?=
 =?us-ascii?Q?Bule3VK1TI3K/hLNolGAlQpQFJb3WEOg2KGUgT8NOJG3wpwdO4sa7Uztq36e?=
 =?us-ascii?Q?QpLPXdujXMy+TWiAczgn3JLt6XGxGv3Tn7qXfhWRHEOS1EuME15lARy2UM3G?=
 =?us-ascii?Q?LTV4CTsJWhQILj7suZl9jMNUezf0Kr79GQNX/qC5QR3CB21N5T2CqDpFBI4I?=
 =?us-ascii?Q?9Pr1gQOsBqKo/RewFYTt5X0w7ne2z5+0iXwh?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 06:03:09.5469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbab6e2e-126c-417e-fa3f-08dd2897a30c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6219

export log_non_standard_event.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

Changes in v2:
- New patch addition

 drivers/ras/ras.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index a6e4792a1b2e..ac0e132ccc3e 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -51,6 +51,7 @@ void log_non_standard_event(const guid_t *sec_type, const guid_t *fru_id,
 {
 	trace_non_standard_event(sec_type, fru_id, fru_text, sev, err, len);
 }
+EXPORT_SYMBOL_GPL(log_non_standard_event);
 
 void log_arm_hw_error(struct cper_sec_proc_arm *err)
 {
-- 
2.17.1


