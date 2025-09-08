Return-Path: <linux-edac+bounces-4743-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D526B48CAC
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 13:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F8947ACB8F
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 11:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FE22FB09F;
	Mon,  8 Sep 2025 11:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0beRxPkU"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2073.outbound.protection.outlook.com [40.107.100.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C70E2F3C1A;
	Mon,  8 Sep 2025 11:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757332661; cv=fail; b=pzpaiHisyYEflOcckuRn8tL5hP/fQX3FhfTZ6dqSz0JXL5isladabhFWaO4GgwdUiy4od8oTOwsmfPEmuPngI3E5Y7lMtv4ZI1l4XVwbJ3lCmqcEiaEg0ENLtOq3VRvGzcKKGiLea94wKX7walEUb7M/15xuKNHzAKhSCZcYUog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757332661; c=relaxed/simple;
	bh=ck10oqE7srpxd4J0VoJlVCpS9cRJYfdokKUZ/U7bL08=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K1LuvW2ealCCeur+THqZi49G5WafcY48EOwm5ytKahYOvmfrI1fvofK0m9cxM8RibuMfzbJA4Z+EzwSb18OkSLEqP5Jd2OxSdMPfnERYp3DT9zGmSzYPpU+jEwRkgKVjZPRy9sR6+A/btHP8wYjbGvDI/na7IXf/7viK4wZ37k0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0beRxPkU; arc=fail smtp.client-ip=40.107.100.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aFbs3pvlqzd8DPjldqiIOxtE5d6nyi7fCNKWfv4zvOtcqG6z7K30HU0JG31WMXKaA+orqtocqmZPXPAUGH6HAIkQC5IrDXj12m8ygIceNnGcCXpl2oq7IPqnTFenWooiwGZJfY8h/s8OteWnafSJcmP4be0CA4/geumE35FeeB/4t22HqCwS7JVNflDuGaBrEVvrZNuIXfyfrtuxqej6kn733MHt7iDNBLSMPktV1tuxXB2FzsdA1H2o7FgQTIQvE7J/KHAnc30OQXIHkFw5p9KLLnqbTFHqjUat2nOLFKHxna6Lc/sLdZPDI5Y99ibpTadvAN1D8XBcM8jDm8dJNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jiYhzUzWmU8Zt5MLF6GGPtwAyix2MaYsHYXcxj5LpPs=;
 b=gRvHOan/N561zTv6DIgGxok2bpE2R3koi1H8JHXofP+VVxoxiuaXQPv+pSTxpWQ72LaMB4TbgUaMHDeXIH+u16IwGSz2+2WLVhQQR5+3h7Cr0XTergTl+vCzEkYz18fdO6AUihLKxp1PQ2S5jdz2F6mggHXW134Wkf2B0rbYIBPF1GEAz9zDvpvfp5oVxvo+fG16sgIqgyjFoyBqzDVi0hc95jPGLpok12B7lC41Wv7XBev/88Z/Bfrh9h6KauadRVskRReBGnwYFnLrUHCy64wa0+5XSi9WhQRYmZ4UkhI7SzlzuO2A9ZPTGzI08QvZTaTl3Y8ApM6+CX4LOXuojA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiYhzUzWmU8Zt5MLF6GGPtwAyix2MaYsHYXcxj5LpPs=;
 b=0beRxPkU2xrQv6kEiNThr/ORdeDlKMk9znMkTcRilezRXzyxNMI/ax/7rr0ipHVwHlXLtmCU2AyZuXLb/KiJxcLDf3jLQUnPCXTHMNXuWXJLQQXxgn0brwgHXt/Ie1pxVtyCx5k/DLHFC4ovNCRsTdd2zFUEugzGWdUo633nFWw=
Received: from BY5PR17CA0069.namprd17.prod.outlook.com (2603:10b6:a03:167::46)
 by DS0PR12MB7876.namprd12.prod.outlook.com (2603:10b6:8:148::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Mon, 8 Sep
 2025 11:57:35 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:a03:167:cafe::c) by BY5PR17CA0069.outlook.office365.com
 (2603:10b6:a03:167::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.19 via Frontend Transport; Mon,
 8 Sep 2025 11:57:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 11:57:34 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 04:57:14 -0700
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 8 Sep 2025 04:57:09 -0700
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>
CC: <git@amd.com>, <ptsm@linux.microsoft.com>, <srivatsa@csail.mit.edu>,
	<shubhrajyoti.datta@gmail.com>, Shubhrajyoti Datta
	<shubhrajyoti.datta@amd.com>, Krzysztof Kozlowski <krzk@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Borislav
 Petkov" <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, James Morse
	<james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "Robert
 Richter" <rric@kernel.org>, Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal
	<nikhil.agarwal@amd.com>
Subject: [PATCH v9 3/5] ras: Export log_non_standard_event for External Usage
Date: Mon, 8 Sep 2025 17:26:47 +0530
Message-ID: <20250908115649.22903-4-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250908115649.22903-1-shubhrajyoti.datta@amd.com>
References: <20250908115649.22903-1-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|DS0PR12MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a7a2604-dfec-42bb-bb75-08ddeecee61a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6uDD5Ub5oVfX2Ea3kwl+umzTXWCRX9wfq9SmRZpHvfG9v2kUG6rX75GfDuPQ?=
 =?us-ascii?Q?75at1If2bp9Kukv+6PZN/79NGfB09L50JxBoqIxfgtsPTNOCgAIANM8FUKBt?=
 =?us-ascii?Q?V6T/vnlqV3XLRxO3v393f5btQJTKudOBVndxbgSh+EEB75q30aYNqq3o4IRO?=
 =?us-ascii?Q?1SziMm6qmLr5Ni2H6oE3+BQM8WH5xIjPSggPZPySKv2BTwn09Il2ydI6N3bg?=
 =?us-ascii?Q?Pq0VaDwVdOXrv4jO7qYDYPvB2G9GfXC6CyjzYyPAx6HkMPMK4hzH2EV3VxaB?=
 =?us-ascii?Q?/HTBOKnC83L/LYzdgAwKwBR1ZIEmhXsFfKR24syiE7c4OSdJo5CaHRwtT004?=
 =?us-ascii?Q?6D63wcEGIAHyH08fIz6oyh1B3q9ZVtHkUW1ejH7tWTiK77tc/mXPkhiaFVMf?=
 =?us-ascii?Q?As1TwmFyXGb+GfYJ0UYU1PULCdDqQIOXvmmTjs0wQLLicUWUCUC9CNRIoBoh?=
 =?us-ascii?Q?mEvMQzQcsjEX3sNMer7AZRBab/PgGYVED4rMyHZkoRrc8fA3jhVtFlvBaOFD?=
 =?us-ascii?Q?LjdcWgEsZ5fiPk/xWZG/POMCARPC/t/PCnns5DjV0FmmDJu/0vE/+rn2AcBH?=
 =?us-ascii?Q?cUyiRzJxk6PHRvGO+cRtb9sxlz59MPY5yssO9Dk+sypC0JwwOFcopklB4aH2?=
 =?us-ascii?Q?QuQzuOo/pQ9R6L1zTDr9inHL1y8eTHkkzJ8f1eZBIeDUyXPHlf7GUcXVnUUj?=
 =?us-ascii?Q?h6bVpSJGNC3NAmF4KnnvQEGftmoj2VHAF6i0+QPB4ocXpbn3fHfzGRJaZDUw?=
 =?us-ascii?Q?VwG/HoVdBsRvLPn18DuIGb2j3FmcSF2psHmAybj9zRuCA5Qfp8wBE7Aldk9o?=
 =?us-ascii?Q?q5YhrwsvjHxL+L0ufyS07dw2SkoATDqdJSeoxcZUQ/moHwalNz4nIfjrS0Pl?=
 =?us-ascii?Q?5WlmTNgvnbSKgodlG7yHQi0dlZpP2KJCeO8t8nnMLG7G4+GlmuBbnZ3zSNnA?=
 =?us-ascii?Q?xFgAH5FuPIQd5wyFI/9VSbkbxiteSK5Drh+oZHXRXe1StHObj+IvNIAAW8wr?=
 =?us-ascii?Q?jS9lbb9HQXq/vG3UmhV4uoZOUttDOvnylwim04I4B74fd+RFTKMJOGoqjE0j?=
 =?us-ascii?Q?K6CsrkNcRtuRyOWuYUoK7NrAc+ejXcZn7EY7JrMXDb4anSMHeftGlKqhxAS9?=
 =?us-ascii?Q?eX3GfS+vUJTOGUglHwQCYJg7pU0pPdDfVPQ57DUzS1Cp7ISsQ2h6lRs2tDoy?=
 =?us-ascii?Q?EnX6HhgvuDKJrU5D8Hxm5s2hXNTvLAXXaX1JM4J05wQ7G+a/+zjWoaA49YHQ?=
 =?us-ascii?Q?sEhC9V7JR5XpeCnfawvsS7GPf+51q5nRfgaFvpSIw9dZ4swFrYsm3TJAVep+?=
 =?us-ascii?Q?33JcDB90P/whqmn0sU+guxgiW9CIMbyIziM0E19mPiJyP4tHcrqXMqle6GVA?=
 =?us-ascii?Q?XFPJiKjajA+mv3C/0XRayl8rc4tH9vsjuJYhBuW9zA+vHOXkgiAriY5fxBCt?=
 =?us-ascii?Q?ghzULsfVIGBsgWasy0nFe1cJ/rHTpsBuBQhBI/z7BxlxkEBbF76lJZgseYIA?=
 =?us-ascii?Q?OW30s3aL8Y9RPx2Z6EOTRljCbSHottkH4B1y?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 11:57:34.6322
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7a2604-dfec-42bb-bb75-08ddeecee61a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7876

The function log_non_standard_event is responsible for logging
platform-specific or vendor-defined RAS (Reliability, Availability,
and Serviceability) events. Currently, this function is only available
within the RAS subsystem, preventing external modules from
leveraging its capabilities.

Export log_non_standard_event to enable external drivers
to log non-standard RAS events via EDAC.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

Changes in v9:
Change the export log_non_standard_event wording

Changes in v6:
- Update the commit message.

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
2.34.1


