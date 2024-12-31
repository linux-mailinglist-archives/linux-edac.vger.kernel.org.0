Return-Path: <linux-edac+bounces-2759-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 710FF9FED44
	for <lists+linux-edac@lfdr.de>; Tue, 31 Dec 2024 07:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A40A53A2B52
	for <lists+linux-edac@lfdr.de>; Tue, 31 Dec 2024 06:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E4C17BEC5;
	Tue, 31 Dec 2024 06:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cRfcsSQP"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C340A17B425;
	Tue, 31 Dec 2024 06:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735626911; cv=fail; b=EQbMX6VJD88AsXnpEdaupfx5PXHXkatZqdDv/L3Gin43rTGBFyHEAzqmdfOYRKVbMK3V3MhVH+g22IT6p7/rnYj19jXigP45f9th/LFabGiUT8Y4wtihmqrQ6CZ23xCRi+m3oKw72UfHjiCF1P6NSt5AUrMbFr+uWMbvFWyAm3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735626911; c=relaxed/simple;
	bh=wSNAaz/gMzeNKwKnm7nykcNykuZzRMf0AKWG/gluEVo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MfAWx4ZsDfNwuXiB5zNUHmuB7kD85KCcYsiJg3dgMFkgGdnqv1Lpvfrh0LHPaJTRjnIsXgutDFCffjiO8byQGFUq4Z+CT5VtCAqoW8fGbRJP1FCSOvqGU6RIA68np9eyVZuJs0tB1Fu9zhecuSVYA6qzcNFOoqFiVgqDYtK8s2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cRfcsSQP; arc=fail smtp.client-ip=40.107.223.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jzIJ5Z2j+4Nr14HQg81+WS7ynfnmZdyJ4GdnPuE0G07JjPRwNzthw4JL1bGAFY9rcifGmRWcu0mIeAjXrSa9ynYT0maMeonDqpEqifCzyw7ewlKcjdqZKL0Xc82yCrb5Iqj9KMERaghr9rTMmVHKjz1ctOPnbDbwurJuftO/qi1MlCbH7Cj2GQDH9tARirAytLq9I1CNfDWaysLwmTBFVaEBegi+qA0b4ciOGDCngRzRlKe/Q2r0i8C6R6L9zHfzglyj8UVdbrVWRVsbv3rA8MHzZOf77Stg0ojZFHDxoHJAi6/A93icZqZ5a20G/DQ5/+bmVHjQ38SxLFEw74pj8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYp2VX/JPPeV2Sy91YjxHMXY4R5oPcNDEZHlRI+V9nk=;
 b=A0vbcP88wMsSGCcmmBIStEamGcmoC2r0fN0fWbG4Bl/C1S5MRcpEeuT1S6bVbvNVwOMiMSsb07Rgc193BNHoYSJ82pZPlAyYXIgCte6quRaqXj39sfTwicPDlZBGTKYwk0KVUOsVC9mCKc7hRADc5n9Wcks9bmhgIrkDlN90tqqgM+VPBFC37x/seQYTrjg3oDAriRsCVA6cILLJGXcophpRg2hZR4R+DEZJMf8iv1WnoQNXr4hB9PdnhVeVSQDOohdn3gdN9DssxMlSRzL7/OsqBrthIp4zjicKn4ELqrTKEmkCHksL0inmkRTovhWC4UjkRMNV27piyJCBrPis9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYp2VX/JPPeV2Sy91YjxHMXY4R5oPcNDEZHlRI+V9nk=;
 b=cRfcsSQPIZp6QuKQ7DSaN18yeWWGX7WuQyJwEbM9+F41TRnTS8gm1MT5dl41rerMQx35dwb5VW6t+F6lpa1SMEtCEbSif9Drchf9NY2Zk7DVY+oB+J5qXLGhCA7p/AWZCiJEDxdLkKUGBv4YFELoH9605G5MJ4gQ9f6gF7ugZSE=
Received: from SJ0PR03CA0355.namprd03.prod.outlook.com (2603:10b6:a03:39c::30)
 by SJ2PR12MB8689.namprd12.prod.outlook.com (2603:10b6:a03:53d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Tue, 31 Dec
 2024 06:35:01 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::4) by SJ0PR03CA0355.outlook.office365.com
 (2603:10b6:a03:39c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.20 via Frontend Transport; Tue,
 31 Dec 2024 06:35:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Tue, 31 Dec 2024 06:35:00 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 31 Dec
 2024 00:34:59 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 31 Dec
 2024 00:34:58 -0600
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 31 Dec 2024 00:34:55 -0600
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Borislav Petkov <bp@alien8.de>, Tony Luck
	<tony.luck@intel.com>, James Morse <james.morse@arm.com>, "Mauro Carvalho
 Chehab" <mchehab@kernel.org>, Robert Richter <rric@kernel.org>, "Shubhrajyoti
 Datta" <shubhrajyoti.datta@amd.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC: <git@amd.com>
Subject: [PATCH v3 2/5] ras: export the log_non_standard_event
Date: Tue, 31 Dec 2024 12:04:31 +0530
Message-ID: <20241231063434.26998-3-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241231063434.26998-1-shubhrajyoti.datta@amd.com>
References: <20241231063434.26998-1-shubhrajyoti.datta@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|SJ2PR12MB8689:EE_
X-MS-Office365-Filtering-Correlation-Id: c3e6518e-3579-43dc-5bb8-08dd296540a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6JSeJFBzKcFudtCuAIO8KBcKy6sjuI6R0ywcYmMXmEMqHbWDCtqZHuTBc9AB?=
 =?us-ascii?Q?ynkxHzw5oVd9H25r9TTeUNZU8p+7TW5fbTNZ3wFjUZzyacUAhvMfDZapQNoy?=
 =?us-ascii?Q?SEagpKrb9mHcyjKTGzjnU0uS+zI0rtpbJ8sXxic1Qp/5xUzrSVH2NYxVUwlI?=
 =?us-ascii?Q?4Ne+C65TsG/2iCRsJ6mA9nnlNiomlMD2ABatEc1jpW02M37XIqFKBw1egROa?=
 =?us-ascii?Q?M+fiRyzvhRX5uikL6M/XxT8mFv6+Tqf+XErfmGAFI1cPtwqNivkh7/CvJ1Uq?=
 =?us-ascii?Q?owiizECc9t6ZEK5BZnu8OlfQOLF0XXiBaVA7zcnnadAZfB4CaC0U16qVC1cd?=
 =?us-ascii?Q?kRuXZXY6Eioq0ovu226A+wbxGmFLwUNVU3/ilrealod9z7hRKG7o2rPsZSLh?=
 =?us-ascii?Q?6qpFeGb5d2rV5KIvwo/7TqtZ/ju4fgTuTJj1r6DN08JR0ehTJwemFIxmRGfv?=
 =?us-ascii?Q?/OCak6mNIvSinUBohUhAx9YerUBAH2tlFB7OnncKialK2GtzdS+WFcs/RzW7?=
 =?us-ascii?Q?ULZrvG/t47sqfC4FpbTjVHjeJyHpAHs79C8kGp0amoZjXv21eCspUKEJ0jOP?=
 =?us-ascii?Q?yzF3cfyRbtaToOlVQLsbjpEbhDGscLx5VNBzfYatNiKHgpXrWGgnKvd19zOj?=
 =?us-ascii?Q?auxLjCL5Lm0QWpIHd/wjFEIygBb1aP8EehQ+a2p3iO8SDEhiSA0T9JTUuiVE?=
 =?us-ascii?Q?ZzCYJEmDtZmuLPR6ABq9CZeFrZAV3n60jYHE75yC8lenV/dax9jwW2VmWSjq?=
 =?us-ascii?Q?sC9Q/i6eXlbTo698cvVWYONH57bnGhTbPq2UrjGXck4bI34r26IR6gHi9GvU?=
 =?us-ascii?Q?z8+1/3Bk505URXNRnPXtLzMCPpsh5kRj01AEfGsys/69fKW/FJ+Ki5106KTQ?=
 =?us-ascii?Q?S2UNzNg4S1HLXqwcUTGw+GN7C2AqSKf0tkZizGtlE0n7Yrh+f1zgR3CxaZYq?=
 =?us-ascii?Q?C7UZYh/m3CtMq+KxkYROdEOh4SJniH75ExjAy1MzHN4L35TNQ33Z1qdGKMla?=
 =?us-ascii?Q?ZsbmnybQF5p29Gm81xi21YUO5wAKKF3tDi0JOKlh/II9gVW6mKwwtOEgZkna?=
 =?us-ascii?Q?7jJgQ1ym/zYHztfMoq7aKw1eGQQnaj7VQLMwshRvaFplgXOXLzg/DLa3jq1Q?=
 =?us-ascii?Q?Zq520iBgbstIgHYTPxGMDhAPl7FQEJxGbOI9FkXIfCUvywUPsAs7ni4KqdjK?=
 =?us-ascii?Q?P54cb8sgZUyvXI3nqNRpZgDev0A0ymK034QU/8FCMy7sjeFO5oQb7fxW4G/K?=
 =?us-ascii?Q?zuMJd21S1J7RED3qSmzmFeyOr3VX7UNDPBO59abWqXxA6fuhuIJm1mZfZD3T?=
 =?us-ascii?Q?lTLNM2YYdDTPYpZnyPGDewpGsrv2pm3n1FyQEDcb6VH/6CfKpGVt2fVLeJEF?=
 =?us-ascii?Q?+ZFkBdCB15GEltOmxR3NREtpV/XdXAgdB7jgkTLKl85eBB/+nZMxPpxZieQW?=
 =?us-ascii?Q?wRW7mFleFy096hRGPlDFEZF3JZPqyVWf41sCGedxWJlpYTfhKsj4ut9p55+L?=
 =?us-ascii?Q?gB/lozkFsdtI5o+9po1WDME9VuhKUEVvmBXq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2024 06:35:00.7668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e6518e-3579-43dc-5bb8-08dd296540a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8689

export log_non_standard_event.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

(no changes since v2)

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


