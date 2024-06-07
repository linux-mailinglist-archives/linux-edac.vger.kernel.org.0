Return-Path: <linux-edac+bounces-1243-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAC1900D89
	for <lists+linux-edac@lfdr.de>; Fri,  7 Jun 2024 23:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC25E285A59
	for <lists+linux-edac@lfdr.de>; Fri,  7 Jun 2024 21:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7001552ED;
	Fri,  7 Jun 2024 21:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s1lmgsdF"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6C517BB7;
	Fri,  7 Jun 2024 21:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717796011; cv=fail; b=SAARsnDbwo5GhS8t93DflhS7cdaX7rhzN4asebNFd1mhyUIE45+QzjVUHnP62qPAVrgHbCa9qXedTv8dJVMjNwdvenFuWig30mJ2LjCeJ9PTFew4UzbLVx/BRuW5WS0nkTZ6Z57wZ3On58YHbP0rXUjfvcDzfEHYqprxfiWqRcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717796011; c=relaxed/simple;
	bh=rHjj1PVhZEqcOXDphIkhFX/joJ5uQvwvq84OD+kolLM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=EBbtty8v7v+4Y+LLgFtvjXbUTWeCukRRaCWCW7s5buCoya3uAPy64PsIvbDuFw2aAMAeOPphoXFFYe1jT8oC5Byx+zm6Hh6G1n4r2/nQ0VW4ZWZec0h1KOHTkzFiJvBMLZK/ORHkJK3DJS7ugZdJdtbfIc9hZgwam9BOJnKn13U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s1lmgsdF; arc=fail smtp.client-ip=40.107.236.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0tQHsBw1TY2Jii8dzJhwt8HZqQtiVPFRLcRfzNmGT14J6g5Hxy0x3D0rIC7tIGzpxFfxO9aINLjVplvP9I7s1fJ0ntt/rfsFbPsN67y7b534/EJJV8slGMaAi9w9c/BtwDvGfb5BRNHoNTIVSPmN9UR5mAStAzMu/o1htaeml9p7Xp9G0uDZZ2c/d9bGgqFfDA180gdfoFzy+3xkZUlU3iqzfs5tPm1b+E4mmCj+hqNlfdUNdGjBJw2E5q0w17PaewtKxtGwY/2yOD3nmErEKBroq4ueBGAheESO3WPeXCftdYxhL94IzEkjdD3hZ+SLOd8JS4B19qWeOls2Sz8RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVEowPcblSSBfo7DGzDRNbVmmjU4jWlyAbZ9WXxflgI=;
 b=Tj/Z9R0GgJ+eeY9G4sQc6gFpH7E+h020aa9o5W95wBMHyzEfwTWH7XUGy6OwuiGfpmcBTNHZ9fvJgg9xPtsMWMs7KYyIdeK4Mx2YQKk634qQ6XpFET9GVhTZkOcWofk3DCVk5nw+S+Ej6rI0wPky3QeSW2zI8HGyEeBQk44x7adx80upGq/V4WWRLIgFyRNbYZWzeym8BgsaQTJParHlmdFm0QkiZ82wvxKEGjaItvNEGWqAGj6+9Mf96ntLdkEG9o2JqMIRCndMSS06IZT2C6dK4zuF22RyFvPqb2r2v4aIFzzktA1l/GrgvsQ0geJ0bEbC4HWEfVicWdXH9YBtog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVEowPcblSSBfo7DGzDRNbVmmjU4jWlyAbZ9WXxflgI=;
 b=s1lmgsdFYIXPh75E5AmFQE/8FfEtK/xN3pQe/9p/nuRLBzqZsWZV6cOE/SvZOVe5PzPudd2J/YXGvYw5yWMUUBy7UMCfJv2mAr++LCPIdM6JF0zxRHRZE8NlvEobEVbBlktha22DVuPXKDsni5QK4/p7pnOUBsKuOYGWZ1PNdBw=
Received: from PH0P220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::17)
 by BL3PR12MB6452.namprd12.prod.outlook.com (2603:10b6:208:3bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 7 Jun
 2024 21:33:26 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::72) by PH0P220CA0028.outlook.office365.com
 (2603:10b6:510:d3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Fri, 7 Jun 2024 21:33:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 7 Jun 2024 21:33:26 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 7 Jun
 2024 16:33:24 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Fri, 7 Jun 2024 16:32:59 -0500
Subject: [PATCH 1/2] RAS/AMD/ATL: Fix MI300 bank hash
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240607-mi300-dram-xl-fix-v1-1-2f11547a178c@amd.com>
References: <20240607-mi300-dram-xl-fix-v1-0-2f11547a178c@amd.com>
In-Reply-To: <20240607-mi300-dram-xl-fix-v1-0-2f11547a178c@amd.com>
To: Yazen Ghannam <Yazen.Ghannam@amd.com>, Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>, Muralidhara M K <muralidhara.mk@amd.com>
CC: <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Yazen
 Ghannam" <yazen.ghannam@amd.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|BL3PR12MB6452:EE_
X-MS-Office365-Filtering-Correlation-Id: c3d8bac9-ec9b-4cf1-f62c-08dc87397736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2RGVmpVTTlxN0MvRUFHWS9MMXZ2K3dOMkhDZUMxSlkxZjBUdjI4bkhjSW1G?=
 =?utf-8?B?U2x4akFtWjk5cHd5aDZYY2NWMUxUeDI2SnBoaDVQR2JNZ0M5QlZKMTVreHFQ?=
 =?utf-8?B?bHUxOGZUQVRVMmJjM20zbHZWOUZ6TE5MbGp3UU1EOWpkRUZyNTIvRktrd1M1?=
 =?utf-8?B?ZitydnJSRjZTMjRXbFFjRDk1d2RIQVNMRzRjMmNCdVNrSUxCT2g4UEpWcHVM?=
 =?utf-8?B?TDkyUUI4dGU1UUt3TEk1NXJJTzFrY2JPRVV2bXNzUG1Kd08wMHA2ckhvckt1?=
 =?utf-8?B?akc5ajRxYWU5aGFJckM2ektEL09VN2tld1pLa1k1d25YcUYyZ3RNMGtrRExY?=
 =?utf-8?B?MU1BMVVkK2RIM0V1TVZialVZZGVpeTRJbXV5cmtUbjkxanRnM2lRK2pPUWZD?=
 =?utf-8?B?OERhVFVTbGQvVDZ4TXdqclZab3JPZU1sdjN2bU1RSEN0dkxEU0lTb1hwTUgz?=
 =?utf-8?B?Yk15RWFZRjNWd2d6NXREc3lSS1FHS3pJU053Vk5xcGZGVzltOHFlWDdzQ29h?=
 =?utf-8?B?cmpIYUFaMjRSdkUxem1FODBqWEdUVG5JRkNZSW9vRTFUc3hWSTNGS1dlNHV5?=
 =?utf-8?B?eGxCVm5BRWlUcHdmVUtZMFN6TkR5akV3NnhwT3o4LzlSYU9EK25pYTBxeVVa?=
 =?utf-8?B?UTZpSUxBcWVhbnNIRENMdnh2OFp6Q20rTENPU0l5dnVBMXZKdlhJOEk2c1Iw?=
 =?utf-8?B?MlNjVTVWQ3BlSmVUam1hSDVOZzRrckhIVnc3WGxrc3ZWYzBkWnk1UXZPcTVo?=
 =?utf-8?B?MUdVRlk2Qm91azQ2cmtKckZqK2NLWFR4T2FuSTdQQUlLeXM1RUxtMjF2ZWkz?=
 =?utf-8?B?ditEY1QzSDdoNldzTlNvV2VoRmQ1OXU0VkRUQ05TN252eFovVHVGTXpUdURT?=
 =?utf-8?B?b2I0TXJYbWRWUGczNjFVRm1aM1pnaGdsNzFpOXZNT2NRRVdvK2dmRkZUMVR6?=
 =?utf-8?B?eG0vejVCYS9SVXhXdU5udDlXMkJZdEdRZmdSVHNucE9uaFArL29pUmRKU0p0?=
 =?utf-8?B?dElnQmhZZldVUURxUFpVUEVaSVdXWFgvQnlabitrU0xiUG8wVnVlaFFmUlZG?=
 =?utf-8?B?MGY2dEtHRlpSTkg0TkJSbGpXaW9wNFo5UGk2eFEzb0RKaSt5OVQ1NDVHSU5k?=
 =?utf-8?B?WTlmYUNyRTZRallQeU9FSTh1aE5kNThpcTdvYjhwc2hGTVc4UTJjbWZjVG05?=
 =?utf-8?B?SDRJZG45VERWSlpBYmZXL1lQWHVoMTRhaSswT3c2bGFhcUh0Vm83MExscnB2?=
 =?utf-8?B?QmdEVmlkRXByaUFKU1Bzb0V6bXBmVXJkWGNHSTRtWlpIVkgrdlNPak5IaVNl?=
 =?utf-8?B?MEFvTmIvd1BSaFZEZzd2TDJZOExBMXhxQ2JSamhXQmxlUTZheFJKazFTUFRP?=
 =?utf-8?B?RXg4LzlHY2lxekhkbFhZUTdmem9xRjdlRWtVaWFUK0Q2ajlkcXJpRlZ3YlRp?=
 =?utf-8?B?K09GZlVaQ2N6TUl6OEp5a0RrMGNyRkh3cnlIcytLSXlSY3Zoa0RxWThEVTNS?=
 =?utf-8?B?MGtGV0FNYWtrdG1vcU94NElsWE1tWmFLNkR2eTgwOUsraVA2RTZnSS9CQ3VN?=
 =?utf-8?B?S091dVJCTjkrMWxoVkRYdU1aYVNmK3g5OTRLSGNHa1oyYTU5VGV5ZG4zY0dY?=
 =?utf-8?B?dDZaR2FUNU9qQVNLcnVRM21OWThDcTRPTndDbHJNU1JRRkdhbEJaRGJpNWQy?=
 =?utf-8?B?enZyay9STWlvcmJYVkMrTnZMeFFZNEJEWlIxUnROS3hoUVUvUStXKzVhcmY2?=
 =?utf-8?B?YmFSclhqRGd6K0Jycks2a1ZsYnFwZmpOeTIvdFAvZ0tUK0NrRzBGWldaMzlO?=
 =?utf-8?B?b2krTHowV3MwRkxmZndTRlNmMkk4ODZJODdvNzlKMG4vdEU4OHdvdWhwaFRY?=
 =?utf-8?B?MG1HOVpEQm12d0V4bUFYUnpSY3R1UTNXOENNUmFhaStqd0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 21:33:26.1025
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d8bac9-ec9b-4cf1-f62c-08dc87397736
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6452

Apply the SID bits to the correct offset in the Bank value. Do this in
the temporary value so they don't need to be masked off later.

Fixes: 87a612375307 ("RAS/AMD/ATL: Add MI300 DRAM to normalized address translation support")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/ras/amd/atl/umc.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
index 59b6169093f7..5cb92330dc67 100644
--- a/drivers/ras/amd/atl/umc.c
+++ b/drivers/ras/amd/atl/umc.c
@@ -189,16 +189,11 @@ static unsigned long convert_dram_to_norm_addr_mi300(unsigned long addr)
 
 	/* Calculate hash for PC bit. */
 	if (addr_hash.pc.xor_enable) {
-		/* Bits SID[1:0] act as Bank[6:5] for PC hash, so apply them here. */
-		bank |= sid << 5;
-
 		temp  = bitwise_xor_bits(col  & addr_hash.pc.col_xor);
 		temp ^= bitwise_xor_bits(row  & addr_hash.pc.row_xor);
-		temp ^= bitwise_xor_bits(bank & addr_hash.bank_xor);
+		/* Bits SID[1:0] act as Bank[5:4] for PC hash, so apply them here. */
+		temp ^= bitwise_xor_bits((bank | sid << NUM_BANK_BITS) & addr_hash.bank_xor);
 		pc   ^= temp;
-
-		/* Drop SID bits for the sake of debug printing later. */
-		bank &= 0x1F;
 	}
 
 	/* Reconstruct the normalized address starting with NA[4:0] = 0 */

-- 
2.34.1


