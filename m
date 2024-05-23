Return-Path: <linux-edac+bounces-1105-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD2F8CD9E8
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2024 20:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED9CA1C2088F
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2024 18:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3521784A56;
	Thu, 23 May 2024 18:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uRKAIZzH"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C7584047;
	Thu, 23 May 2024 18:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716488842; cv=fail; b=ekpvUGI3cG6WHlm+tmurZglGuIm3aQobiJF7eFIZ6huUTt7AhExHZn829nvzNJ51XqVQ3NVxwD8Fj/iz9T9aUjSDj5OpQDY8GjOfo0W80SXH35zNmd8UbbL3llOJwp6lso5mG7sNhufT9RDawEJUGpRkIfloItXdpV69pf/i0SA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716488842; c=relaxed/simple;
	bh=dDTTCEV+d0iopyDJ4xM95DCs80v4QTmTcDGLuro42kc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=OFGbBnFzXp9z5U2ePC0AXy2bRc1quZlMVHA0mvPfSKAU1WJOFOXSCa5BNfKFE9uKhZ3+1yQFkJ3YRAj6IXzeYZ3QKgzO5mV077YRSuU54UFQ7YvdTVftMokYuwGvRfeQ4SxDfzIlyw0jLZoLEERWPliBx+SmnrMykbhkFwYNfXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uRKAIZzH; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bi6BK3JeNxytLRiZPKQVOQa9cp7mZPhZRg0ebxz46spIVR8YkYnPfTuK4ZgBnffwlA7flrqKeA/eFpeerb6D8vIynvvXw+m1VYOekr/g0BdDo9lqnD7sFAyeZQ1ACNY95J3wWh5xWGwohP01cwGAeP/5RQFz1jl41RYETVann2jqQGt02hyv3KBajgkaW/CanS/tnOTQRNwetlK9T9KjOJGT1bOg3c4fEDslfKJbVX5JPe4ZabFdhBH9sDx4lg1pUL12GixnCDFfe2deqlngFmoLmS08VOnTAV4goWCH0uwgSFIUg2aJY6sh1kFabhvGutrOojYh+o/EZ/YMEJmi0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/prkzvhX7aBUAyFTQ1Ogj1nExfxmcCLbWoU+rIQGK8=;
 b=jTfEYKvUUByjq+GXRWTV41QOwFy5GYuNgSLQEYU37XQqolipykIraVEt8DQdOvEQRomwxjaE7gFuEKSQOQWIrhCO4T3zFRoSiUxzBwF1Xr6jFJqshnX5SkRCeRCFrzh6S87isi8wiJ8LwUfIAp2GgS4tWNEutFzSe5UUFc2XCgv9JXlJxeVyWA6horetTsdnRGi4e1YTCkDqy4g7D2jyoRIcvCXgYVTwLQpp1jb3RgxyjsSyDFbfDxCFDnKMVqvOGAZrJ3ytKRkI/FA8Hp5Om/2cN/HjsD2OoWItP4VUHyAQso1AU4uyRhBHYFSdfj5gnFL5Bw1zZFd8H9tMB2CaEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/prkzvhX7aBUAyFTQ1Ogj1nExfxmcCLbWoU+rIQGK8=;
 b=uRKAIZzHo74xhQaZmTGOHQ+vedJL53GYmtuyC+14tjPGNgceokADGGfz9L1X9MLSOnUeOayEDg3u7OQ1jEJhXmv8P6iX4kIBwiJmnbjF2PrqXlvjWCPnlHVg415B7utOo46mfW1hsV4z0VTSAvots9txRUi8Ay6Zf9kMbBINImM=
Received: from CH2PR19CA0002.namprd19.prod.outlook.com (2603:10b6:610:4d::12)
 by CY8PR12MB8214.namprd12.prod.outlook.com (2603:10b6:930:76::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 18:27:14 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:4d:cafe::15) by CH2PR19CA0002.outlook.office365.com
 (2603:10b6:610:4d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20 via Frontend
 Transport; Thu, 23 May 2024 18:27:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.0 via Frontend Transport; Thu, 23 May 2024 18:27:13 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 13:27:10 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Thu, 23 May 2024 13:26:55 -0500
Subject: [PATCH v3 4/8] x86/amd_nb: Enhance SMN access error checking
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240523-fix-smn-bad-read-v3-4-aa44c622de39@amd.com>
References: <20240523-fix-smn-bad-read-v3-0-aa44c622de39@amd.com>
In-Reply-To: <20240523-fix-smn-bad-read-v3-0-aa44c622de39@amd.com>
To: Guenter Roeck <linux@roeck-us.net>, <x86@kernel.org>, Yazen Ghannam
	<yazen.ghannam@amd.com>
CC: Mario Limonciello <mario.limonciello@amd.com>,
	<linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|CY8PR12MB8214:EE_
X-MS-Office365-Filtering-Correlation-Id: 760bed3d-07e8-4154-5abd-08dc7b55f7ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXFOQXZsZ0FBUVZXOW4xejVmZHcyeVdmR3pRaTE0NnhEN0xjdEJLZ2VCMFY1?=
 =?utf-8?B?YUZoVEM3bDZ3ajNQbDVQdUsvTHMrSmxQUy9pcWRGbDNXQ1BLT1E1WkRsV3NI?=
 =?utf-8?B?RExZNnFzSkhmLzM1U0FzNGYrTEg3aGFhNTg1YVliVkVoZTQ2WFNaZHRnVS9p?=
 =?utf-8?B?blVNYnJDdDAxTzJ3MGV5NnBzL0VOSzdaYXVyUnRRWlhZbUxxdzZEeEdtNjgw?=
 =?utf-8?B?Y2ZjOW5GT3VpeUlVaG5zWkpyZ2hja25CTmZCMUcxL0tUUjFZa3NpRWFMWlVW?=
 =?utf-8?B?MktONTJVNS9vdnVpUW1sMUZiaXdVTUd0ajZXVHVhVWZ2YXg2NmJORnZzbWNY?=
 =?utf-8?B?SSs4Rk1EdU5aS3N3T0YwNk5LTGppVGlIR0p4cTBaSDJSOFFsMzNSUnVVMUdS?=
 =?utf-8?B?b3NiRXRkTVJZWW4wYmEwQWRxQitZeGxUa0xoVmw4SjVubnF1QW5Gc1NWWjdG?=
 =?utf-8?B?QjVSMHlYeWNmQ1c1SlBHWDg5V1Z4aFIwRUtsNDU0YWt0Y0NjK2ZVRW9GeDVC?=
 =?utf-8?B?TlRLNEtBK1psZkZFLzZuN3dITHNEMWFWNXVDSUt6ZjR5UWNNZXBHNXVoeVpW?=
 =?utf-8?B?MDZvTlhKTVhvYUtvV2Mwa3JLRCs3NGhZc0ZVL1lCN1dZU0xFNlFnVlV1Y2Zy?=
 =?utf-8?B?RFRrMlhUMUppbVJwTG8wR1lSTksrU1kvc1dwSzhQZENGMEpYNnJyVEFEOVI3?=
 =?utf-8?B?YWJ3dVFzWGpKODNuVEMxU2JxZlJ5RC96RlRoU2RVMkgxRm1oQjZTUDZ6blIz?=
 =?utf-8?B?SWdvdzB0dmpXajFQQ0w2eGxNREg5d0pEMDY1UFh0ZlFuakNXRk1hUHJYM0JK?=
 =?utf-8?B?bFJ2NmFOVzAyVEJ4NzlNajc4YmlWcll1Ump6eFgwN2VuNURkQWhhNjdRUm90?=
 =?utf-8?B?RU1rM0wwMUNCTDlrYWdmSDVFN1VFOWpYbWEyUlJ0SStmTjlzNW5ZaUptSENM?=
 =?utf-8?B?M1FXWXcwSS92NFZGTTNGYXZPYy9YdzcvNVBER0RqYklKYVBoTmJaY3NUZGZU?=
 =?utf-8?B?SndKNWpXREQ3eUhNUEtCV2N6MnBkelZaaENwOTF5aTVCUk42WmRWSWFYNlRa?=
 =?utf-8?B?dGxqdUpEazRkOWhxdk0xK1c5aGZwQyt0blp4T2QrbWJBQUE0Q3kyOGxrZU1v?=
 =?utf-8?B?RkhFelVsUHdmb3VFQkVRL0NnMmZSN3dZR0tMa2w5bEJxYmRGMHVMZy9PZHFj?=
 =?utf-8?B?VkVjRVhDS1A0ajJsRTZydVBvS0s4QUsvYkFNQ0R1SFNwdUg5RjlhczhNMUxT?=
 =?utf-8?B?V1BEZVN3NnZmQklUM2M1dVBxYlpDT0tMdkxObHNCZndnN0NWcUhxVEJpZ3NG?=
 =?utf-8?B?MDJiZGtZKzNKYmNBLy9VTGpTV3hTaXVjVzFKWUdPaHZBVnQxeDJKZ3VEZVU0?=
 =?utf-8?B?KzBIeVdRcFVaNUNvMlZnQlBhbDZJMWdrWGtKVmVSaEIwMDB3Q3RmSkpzdzZG?=
 =?utf-8?B?ays2dGJUVnZZVFl2SzNHbzBlREN5WmVra3ZWK1JJT2FOQmM3cnJ5TjNRSnFw?=
 =?utf-8?B?eG1RNFBIUHNLTi9JNGZtK1Q5dVJpekFDQi9SQ3Bna25hemI3cm9yckVKSmdo?=
 =?utf-8?B?eDIxNGxLNmI3aGhHMVBMa1V1OU9wU090QlVJNElkS2JvODNjMVB3a01ySC9h?=
 =?utf-8?B?NkptYWZVUTNaZklRcUZmbTlxaHM3eUlqTVRCSytmUmNXK1dTV2VJdGM2ZkRD?=
 =?utf-8?B?Y1pZWEZvRzZ3WWgrbU9Sd1dtTi9ycjY2REQ0VkVBN1JXTjltTk00Ump2aDB1?=
 =?utf-8?B?RTBtaW5qSXh5VXp6UlVtdThpTDF4cmp0eWlOZUlPQ29hVEw0RjBsVzZHbXF4?=
 =?utf-8?B?RncwWVBSZEc3N1N2NFljSEZQOFI0bGtxQzZ4MUtIUVlNYlRiV1kxUS8wVVNl?=
 =?utf-8?Q?qFwFPSF9lTuA8?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 18:27:13.6847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 760bed3d-07e8-4154-5abd-08dc7b55f7ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8214

AMD Zen-based systems use a System Management Network (SMN) that
provides access to implementation-specific registers.

SMN accesses are done indirectly through an index/data pair in PCI
config space. The PCI config access may fail and return an error code.
This would prevent the "read" value from being updated, and it would
give an indication to the caller that the read or write operation failed.

However for reads, the PCI config access may succeed, but the return
value may be invalid. This is in similar fashion to PCI bad reads, i.e.
return all bits set.

Most systems will return 0 for SMN addresses that are not accessible.
This is in line with AMD convention that unavailable registers are
Read-as-Zero/Writes-Ignored.

However, some systems will return a "PCI Error Response" instead. This
value, along with an error code of 0 from the PCI config access, will
confuse callers of the amd_smn_read() function.

Check for this condition and set a proper error code for SMN reads.

Furthermore, require error checking for callers of amd_smn_read() and
amd_smn_write(). This is needed because many error conditions cannot
be checked by these functions.

Also, drop the extern keyword as it's not needed. And remove a warning
that will not be trigger in many cases.

Fixes: ddfe43cdc0da ("x86/amd_nb: Add SMN and Indirect Data Fabric access for AMD Fam17h")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Cc: stable@vger.kernel.org
---
 arch/x86/include/asm/amd_nb.h |  4 ++--
 arch/x86/kernel/amd_nb.c      | 46 +++++++++++++++++++++++++++++++++++++------
 2 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index 5c37944c8a5e..6f3b6aef47ba 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -21,8 +21,8 @@ extern int amd_numa_init(void);
 extern int amd_get_subcaches(int);
 extern int amd_set_subcaches(int, unsigned long);
 
-extern int amd_smn_read(u16 node, u32 address, u32 *value);
-extern int amd_smn_write(u16 node, u32 address, u32 value);
+int __must_check amd_smn_read(u16 node, u32 address, u32 *value);
+int __must_check amd_smn_write(u16 node, u32 address, u32 value);
 
 struct amd_l3_cache {
 	unsigned indices;
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 3cf156f70859..d00c568e45b8 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -180,6 +180,38 @@ static struct pci_dev *next_northbridge(struct pci_dev *dev,
 	return dev;
 }
 
+/*
+ * SMN accesses may fail in ways that are difficult to detect here in the called
+ * functions smn_read() and smn_write(). Therefore, callers of these functions
+ * must do their own checking based on what behavior they expect.
+ *
+ * For SMN reads, the returned SMN value may be zero if the register is
+ * Read-as-Zero . Or it may be a "PCI Error Response", e.g. all 0xFFs. The "PCI
+ * Error Response" can be checked here, and a proper error code can be returned.
+ * But the Read-as-Zero response cannot be verified here. A value of 0 may be
+ * correct in some cases, so callers must check that this correct is for the
+ * register/fields they need.
+ *
+ * For SMN writes, success can be determined through a "write and read back"
+ * procedure. However, this is not robust when done here.
+ *
+ * Possible issues:
+ * 1) Bits that are "Write-1-to-Clear". In this case, the read value should
+ *    *not* match the write value.
+ * 2) Bits that are "Read-as-Zero"/"Writes-Ignored". This information cannot be
+ *    known here.
+ * 3) Bits that are "Reserved / Set to 1". Ditto above.
+ *
+ * Callers of amd_smn_write() should do the "write and read back" check themselves,
+ * if needed.
+ *
+ * For #1, they can see if their target bits got cleared.
+ *
+ * For #2 and #3, they can check if their target bits got set as intended.
+ *
+ * This matches what is done for rdmsr/wrmsr. As long as there's no #GP, then
+ * the operation is considered a success, and the caller does their own checking.
+ */
 static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
 {
 	struct pci_dev *root;
@@ -202,9 +234,6 @@ static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
 
 	err = (write ? pci_write_config_dword(root, 0x64, *value)
 		     : pci_read_config_dword(root, 0x64, value));
-	if (err)
-		pr_warn("Error %s SMN address 0x%x.\n",
-			(write ? "writing to" : "reading from"), address);
 
 out_unlock:
 	mutex_unlock(&smn_mutex);
@@ -213,13 +242,18 @@ static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
 	return err;
 }
 
-int amd_smn_read(u16 node, u32 address, u32 *value)
+int __must_check amd_smn_read(u16 node, u32 address, u32 *value)
 {
-	return __amd_smn_rw(node, address, value, false);
+	int err = __amd_smn_rw(node, address, value, false);
+
+	if (PCI_POSSIBLE_ERROR(*value))
+		err = -ENODEV;
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(amd_smn_read);
 
-int amd_smn_write(u16 node, u32 address, u32 value)
+int __must_check amd_smn_write(u16 node, u32 address, u32 value)
 {
 	return __amd_smn_rw(node, address, &value, true);
 }

-- 
2.34.1


