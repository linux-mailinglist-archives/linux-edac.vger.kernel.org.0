Return-Path: <linux-edac+bounces-2766-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4BD9FFD06
	for <lists+linux-edac@lfdr.de>; Thu,  2 Jan 2025 18:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C81543A3287
	for <lists+linux-edac@lfdr.de>; Thu,  2 Jan 2025 17:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE624188917;
	Thu,  2 Jan 2025 17:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sN1RY6v7"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D721ADFEB;
	Thu,  2 Jan 2025 17:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735839923; cv=fail; b=JtD46HPbrPh3MULL59aeTHXoQLWzZVODNQUyzarehhK1nNcol1KfmYM8Qzid2lzAYoe1PMzLzGhhP8or99ArXkhRNjGW/44cKXjet+VjjnIi9XhNrWFirj9NWn9IVhxrN4LmLYsp7okeA0IFvhpjNZiLBmZqlxrtKskns6Bnmns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735839923; c=relaxed/simple;
	bh=wSNAaz/gMzeNKwKnm7nykcNykuZzRMf0AKWG/gluEVo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CgzpI60Bd7+QBuVOljv+RwLsB48Wmco9VQ6igF6QWRnxpLalDBPRYR5EyyI+IjHYL1zIZNpLnBD5hXLst373OGVt7eaKGY5F+OC6IVjisNjqRpx3OdKagbnFGsBGUZ3gRg5EjrR3MYpXt5xQ83hMPBMyZpx41tlTWqs4CtfV8/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sN1RY6v7; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2zvS6WwMxxHArKsnP0deg3T27NYHl/371BeAEQE/leChqljxSw6eBv5kiIyY+gFJCPShxG3pwZZMfMQ4b8fh9RQzOibTwBJzrh/r9YXuDQtjbtXULmvvmAmjb4V9d/AAya+/C50xd3U7jTC+XKE1MGxKbpdHPtYfohbClu9wQhDCiTdAwcJKA/Y6KCjUchYndgZnZFcdTqL1mrbyMy8jzNafZAKMJD4nYKJl5T5iDuL6aBM/HzIHexR8C2PQBb3ZSKHujxlOp8Q/SC9XsMV1V3KqvgAoHcaqTzYEXh+KhIZqLbdt5F0WuJNCDOGz3tnQW1JtKspZ12/Kny7I+AlCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYp2VX/JPPeV2Sy91YjxHMXY4R5oPcNDEZHlRI+V9nk=;
 b=Fm4e9DY8xeoZJjEVnqCKVy7W/RQN7J3E657uj6C766CDdN/xT3SVw6q6T4fWjHA9qaNZAwJJ8pRQx1/mXCZt1UIQH4P2tI5c5jLWCTdT/UMvugXLnRflj8Q9EDkVzvuTb8+2npJGSxgWJU4sk882Atgrv5dezeFrBKAQQqaY0SP+D7ulZe1n/JgkhIZ8CQ8X16KmrckoGnWe1vodhsEqH6P6aNJYfWQvRPqYJ/3C7DVrwtjhJuBDvEwiqBO2V8udUQ39EmFgphXAvzlOU5a61hu68qoDX2qttkGJIHLlestnFNsdtVEpAf8nGxJEnDYQpmtbb5Ydb0W1h0JIpHJgAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYp2VX/JPPeV2Sy91YjxHMXY4R5oPcNDEZHlRI+V9nk=;
 b=sN1RY6v7kpKoJiSIUmpY4Cqlc2Meb64gmmInmGwEd/KC2OuGC/kg/rbYO5uM4kTtvF+jmWEKS2qrOYrIhvNmrCH74NtQubhdkHVZuSSmCvvA0+UOwf/sSCBnba0gUdTWWBS3gAAJc4TMpOlIWukarM+744DD3FlRtT4cqUqmJf0=
Received: from MW2PR16CA0071.namprd16.prod.outlook.com (2603:10b6:907:1::48)
 by SA0PR12MB4478.namprd12.prod.outlook.com (2603:10b6:806:9c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Thu, 2 Jan
 2025 17:45:12 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:907:1:cafe::7e) by MW2PR16CA0071.outlook.office365.com
 (2603:10b6:907:1::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8093.19 via Frontend Transport; Thu,
 2 Jan 2025 17:45:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.0 via Frontend Transport; Thu, 2 Jan 2025 17:45:11 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 Jan
 2025 11:45:09 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 Jan
 2025 11:45:08 -0600
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 2 Jan 2025 11:45:05 -0600
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Borislav Petkov <bp@alien8.de>, Tony Luck
	<tony.luck@intel.com>, James Morse <james.morse@arm.com>, "Mauro Carvalho
 Chehab" <mchehab@kernel.org>, Robert Richter <rric@kernel.org>, "Shubhrajyoti
 Datta" <shubhrajyoti.datta@amd.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC: <git@amd.com>
Subject: [PATCH v4 2/5] ras: export the log_non_standard_event
Date: Thu, 2 Jan 2025 23:14:31 +0530
Message-ID: <20250102174434.17677-3-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250102174434.17677-1-shubhrajyoti.datta@amd.com>
References: <20250102174434.17677-1-shubhrajyoti.datta@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|SA0PR12MB4478:EE_
X-MS-Office365-Filtering-Correlation-Id: dbb04bf7-369b-460b-2377-08dd2b553520
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YefYklSTmPOl+JuT0+ZXO8+iBNHhAOAV7zBB0EygURJuSl3UlNgxqdGTjuw1?=
 =?us-ascii?Q?YJjb1qXfVMwgvHEe0xtyqRX6FAYEkdzkr6d8XBxxbtq28JMAN7U/rGaMM2ux?=
 =?us-ascii?Q?24fOXaMIyTwpDMpykPklweX1m3MCb1q0XVcenKwxzS2CrQW+YrImKiWAwglJ?=
 =?us-ascii?Q?QV8eSQljYdhqDKhZP5P2Z3Hl292Og9Oup+acMzPVjrQNQs+AeDsh+VHlkgaG?=
 =?us-ascii?Q?ntaGDs9Puxc/RaAd4915OH7eBEbA4tNrZfllHHSmq24gD0IsCQ+j3qD96LOj?=
 =?us-ascii?Q?HC/gOjv26l5KleIGx8mkOR195WNqW1o70Bcu1uR5zlurUS8Uh3bYWUba40ZY?=
 =?us-ascii?Q?I6WQiBtqOfxo5JlCMeV6VvjmJXs7Y8RN5fq2AJ1i0sx91BGvjFic9Q/jplHA?=
 =?us-ascii?Q?dD2xbMwl5GQPQhfXglyKISEpjl9EZX2fNMW1BwO8gWwogODLF0umViXkm03D?=
 =?us-ascii?Q?tvkEAvmYef/WV3FZHDyxMRJrMb2nslPMm4g9hrFgngwitLzwePnWyRGoLCbl?=
 =?us-ascii?Q?aWga6f51g+Veq7QiT3EsSvdGFb0z7gAbUy98cGcHtpuUNHrrky3VUeqp+fUO?=
 =?us-ascii?Q?mELT4COejusJauDfOFcRdzqElomDsaFe54+YgccZtOrhIOgiwf13N6JO6crD?=
 =?us-ascii?Q?k2Tfq8Pmtv70Nu7HBg7rOXyL6BdnKuxGhRUDDIkfslkaI7QZFGo95eTJbp6L?=
 =?us-ascii?Q?eBxOxUMY7V9fZzclXxnB/oSq1rLAwUDNu+LjOW6b7/i12h0dt1PjYxKcasdD?=
 =?us-ascii?Q?aaSLap/s38SEWbDDFiFgeTHlGlAKyFqmDx8TrmC5vaHlJExyQT81vPDUAij8?=
 =?us-ascii?Q?1feCDuMNGgfQrb9sSp4ZlR360Yiafu9YGcztvlHtb7ovbxEt3MTnHw/+gNNI?=
 =?us-ascii?Q?qfKHa2r6wdRubLz5u93W5M4JHsRID1YnKDkgDi/aIViKQlV2vLEuoFpdistK?=
 =?us-ascii?Q?S0k9N6IC1RrLFOOPO4GO0wfXY+0qDp9H0uQytUG+CaCQtiwom926lGcctC5Q?=
 =?us-ascii?Q?uAIxRUkPderRPjNC3PU6vyYWrRZnE87E+dk1u6zVndVZVFBRWqz4FuQLwCpx?=
 =?us-ascii?Q?FZi4J1Z/OIit5nWTUptkBnCkrpOhmUnr8gP2HvsQ7s9O+1avNHFwB/MMibQB?=
 =?us-ascii?Q?/fv7cLSXOXJqEnJeJOIO0HM9qtIN4hvJpdErenzYLjXwlk6K0cPS0s0VtD4X?=
 =?us-ascii?Q?pg/uDHupZOex3F5PUjXvJoclm0pwREXK1PBpUTnc62AKK+Y4zF/9HIaFLv7c?=
 =?us-ascii?Q?m/9dCYUTlK8p/XBwkr5aQ5sHz8GfNA29+S+Dg92IXDcpP58+UBsEdapypTBw?=
 =?us-ascii?Q?fg4PglO/L3qqYCAc+TXZdVkLEaPmYBCvUxX5NP2zrWXY71dxEwTms9z8WoG/?=
 =?us-ascii?Q?EpVf+UsFHOYusKiToEQB68H/fIaakwBJhylnE9s5abV4/qNWLTIvYJfnDtNY?=
 =?us-ascii?Q?sp4fERMDETRgP60x/GHKyDIsXvCPZBa/Coh2dtenCrK0qmffrqvKTNrojrok?=
 =?us-ascii?Q?OOdqwxH1ZgXp+Soku7y6uY2/uPDD9nybSLj3?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 17:45:11.8429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb04bf7-369b-460b-2377-08dd2b553520
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4478

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


