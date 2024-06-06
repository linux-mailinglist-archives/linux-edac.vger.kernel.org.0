Return-Path: <linux-edac+bounces-1221-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5E68FF25A
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 18:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90CA9B29E29
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 16:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0021219B3D3;
	Thu,  6 Jun 2024 16:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ftskJr1o"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2054.outbound.protection.outlook.com [40.107.212.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BC610E9;
	Thu,  6 Jun 2024 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717690408; cv=fail; b=kbGICGCqF4xNodYU+G3nDKCwp38jVUKZDQVVdk62HGAb1rNUMHCMwPjxEvh8QrYJyQk9kbSNaK+IXrd/6mox/7O4qKahziB3CSUzIa6At4wiSc2PpIKOLeEmPnOXcaZLp/LBN52ubaizP3rgDR2pnCLZVXQCFD++0I/3mhgYm9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717690408; c=relaxed/simple;
	bh=MUlGyB5iXHHTtsMSSIROW5lZNLnBx5a90QrI0AQfsS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=WCli9qDZLkO+fl4g8/RO7TUCuxzpBys/L9vy1H0YUlIzUlIRKehIMG7CjnvWzlKaz5/wgjXNrvX176Nlb3zY1H7a1nSlSOCkHEwRXl0jUiYBBBx2nAfaqxKvr4LVXn53zeydP7z8dShfX4BtfHIMnrdDz36E8ki0aJchIeesjAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ftskJr1o; arc=fail smtp.client-ip=40.107.212.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iW6NDOr4fLEU+XxjWf2L8w8T7fA0RcQAk+KVAhW0w9ll578zbKUKeoWqI0rvWNlbzOY56ws27tvUdF6BxaeaPqUW37BG36T/60agocFLF0/xM1xEkIdVNx5ajsuFWnEBJTjvifT7NSXCdrqiKzbcsxcO2nBAujJALBbAhECZOtzN+xoPdXSDF33J2FPhcTyBVPGQLDKat+q4323ahWBVjrIeV5AlmB7oJlG1SA5kQ+1G+Rv9qeQ8EOoM/edZyaWCkfBnbl2/UOaQhcG+M2SzDQU1zPHGjrz91wOyvx8NQLu1jzAxkAzcT17pvQqHm6klowIeIcMNzE2bvpWkN+rA5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5y6ygaRJmECniZ6MPfml9wCtAtf0WN9CsGo/8DeIIM=;
 b=DEuX/F8IA/IPjAbGifU5p9UQ4A7tY/dnA14VeHPtPMfBtIqPgR1b1uYcc1rCIb0UhFFFOd6vBAeouLc3fgsLv+itSqRkZ28sLdR1NMF1aamfysBdovJoBpxTb59FAkVHb5AL0aKJ0s/g9JS83+QvlhsBQyxLeZz6eRc2igJlhuRSCYbUCpDoHJYtQTLY9/PtaTDEejF0rOxpk+N+cch34A+x4WZ2qq1KvK3BG5hmBqa1con/ok4ObsfUXp+ocMDPurbFCqzNevNLpwZ1G1SDaiiYZLI8b67mX8pOw6fHcu/sfT0fc0mVtxxQV2pWp1sZeF5CAZZ4G66WdT8sibj9fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5y6ygaRJmECniZ6MPfml9wCtAtf0WN9CsGo/8DeIIM=;
 b=ftskJr1obDADFuH3HSBQ0LnXtkySq3j/WYJe94uStEa5qnAi/EF3zFIZQ+QBFSTLSJ0O5RTntwB1nwkhnWpYCavDdKEYCAH+1fUPJxJI7f85sxdq7AVwJSb0d38BLWRVy1kWttxTiWDZbR2minsiYAfP+mBau03olw4OW+e7vZU=
Received: from CH0PR04CA0110.namprd04.prod.outlook.com (2603:10b6:610:75::25)
 by SJ2PR12MB7920.namprd12.prod.outlook.com (2603:10b6:a03:4c6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Thu, 6 Jun
 2024 16:13:22 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::3e) by CH0PR04CA0110.outlook.office365.com
 (2603:10b6:610:75::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Thu, 6 Jun 2024 16:13:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 16:13:22 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 11:13:20 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Thu, 6 Jun 2024 11:12:57 -0500
Subject: [PATCH v4 4/8] x86/amd_nb: Enhance SMN access error checking
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240606-fix-smn-bad-read-v4-4-ffde21931c3f@amd.com>
References: <20240606-fix-smn-bad-read-v4-0-ffde21931c3f@amd.com>
In-Reply-To: <20240606-fix-smn-bad-read-v4-0-ffde21931c3f@amd.com>
To: Guenter Roeck <linux@roeck-us.net>, <x86@kernel.org>, Yazen Ghannam
	<yazen.ghannam@amd.com>
CC: Mario Limonciello <mario.limonciello@amd.com>,
	<linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>, <babu.moger@amd.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|SJ2PR12MB7920:EE_
X-MS-Office365-Filtering-Correlation-Id: ec2cf8eb-2498-4adc-81de-08dc8643964c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eHhQNEVlS2RKeUFhU0xRb3M0d2s1T21GRDlJdFdJZlIxQmE5bmorNDBBcGFl?=
 =?utf-8?B?QzNRUVJHN05FdS9VM3cvbnkrNDdjS3JHK21mT1dEcDVzUXo2S1h6R0oybE1a?=
 =?utf-8?B?R2J2ZStqQWRLQml2bWJXSjZwOXd0SmJiaUwrSDBEb1EyQ3V3K3FnWjg5dUxY?=
 =?utf-8?B?MTlOL1ZvTzFsamZBYmxWaTBJcDRnOEE4TVdwNGJFRE5CL01ac2FyV1FCeWxx?=
 =?utf-8?B?d1h2cjlNVzRYTmV3N00zaEFKb1RVOVZ6NVU3eHRZNFF0aTFCTHNSZFl3Q1JR?=
 =?utf-8?B?dHJVc1ZSYW9QTmFqa2N6Y0czUWN6bXhUOHJaZTdzOHJjYWNNaUw2emxoSTV0?=
 =?utf-8?B?YnpMTlo1U1NFMm9yUDJoUjVscjcvZkdjUFBZMTZZOHdYMlFBVHhFZGE1UHhi?=
 =?utf-8?B?eVhSMGtPOVhmVGYySFlicmZSYTN0cGMwOWdpVSsyZHd1QS9GNWY2WjZkM0pU?=
 =?utf-8?B?Z0o2V1hRVjZiU0tuZ2pTVnJiWUQ5NFRnbWJOSVhQeGZ5bjZ0OXcyUFRZQkh6?=
 =?utf-8?B?dm85YUVuT0hsOEtGK1F3dXoxSGVzc3VuUHV1ei9QQjVlNWwrZlJQZkNsRGxL?=
 =?utf-8?B?NUs2NGRvOXhITFJQOTVsQnprMjJveTI3NE5OM1BULzZPZHNCdGNRM2Zzckow?=
 =?utf-8?B?cWM5di9keWpZc05hTGNndDlqMVNuVmxtUmtkMk05T2NueHlaNjZpUndVMmQ3?=
 =?utf-8?B?aVRCQWdGRGhEZjBXRmlxaXZxVFJyRUU5MVVrWGRXVnVLS050UUtGK0duMVZK?=
 =?utf-8?B?d1lBZnBGZmVEM0E5bHZrVFdQM1lJbFo5QWlXd0lQRkZJY25KYnByZWRPeWtU?=
 =?utf-8?B?OVQ3YXQzRU04d0hGNkNCY1VMbHpPZDdkOUxQbEo1djZRcmlrQzR4TWMxWmVu?=
 =?utf-8?B?eldNa2RWNTZxTk1ZZVFRcG1LalU4Qlp1TmFUZmQrWXZBakJiZVhyMllhcHJz?=
 =?utf-8?B?Z0FmRjZiQi8yQUFiZGUxbG92NjFQR3JkL3dFcGFpMjZPa1h0eDNrelE4SURC?=
 =?utf-8?B?RUJINEExa3d3anIwVVQzcFduNFhRVnErelFGb2dtZlJQVW5aZHp2bHpFOHBq?=
 =?utf-8?B?RnN3cnRpRVZIdmNNMWFUS09UejFiMkp6bWJtZXNhS2FMQ1d4bTR1Y1grWEhv?=
 =?utf-8?B?clZkUGppNGJtbnNvU0V3dkVLWFZPU0JnR3FEb2FSMzhMRVlFZXRKT3ZrbUlL?=
 =?utf-8?B?cHlOZGp2TSttT3czTXBYSWZKMmMrUkxxQnBZQXc4am96djdNR1E5alF5Ujhh?=
 =?utf-8?B?aytwQU5VRkVoRk9QZTMzbFVVVnBpZUFna3VWeW03a1BXaU1aem9RdVUyUzQ2?=
 =?utf-8?B?ZERLMThUMGxrUlBnMTI2VXNUUGREeHhFbk9xUGxvZGJ5TGVVbUhqZk1JS0o2?=
 =?utf-8?B?MXVOR1BFV2o1RjZ2RWoraE44T3dzaHRIVnJmRm5Ka1NXTEVYSHQ1SHZXaWpy?=
 =?utf-8?B?MGtoM1lPdjduWTRNL0lhVCsxdjBBOXdYUFlkWU93WU1YMWxkeHl0dGRhNVN6?=
 =?utf-8?B?Si9pTGdaRW1EaEcxRmxTQTRnU2xwTnRwS1k0cTVSdGdJcXFFckdVYXhMSXhz?=
 =?utf-8?B?Y2E3ZjBZb1FMQitCaXk2dUV6em11cVBINWZ4aThMMVdEY1NKYlplN0ZBS05a?=
 =?utf-8?B?RVlZMENJYmJibld1VXNTR3dTMXZxRTNzTnJnTTBvZWtwS2dxb2hQN3p6d0Fv?=
 =?utf-8?B?eTIzd1ZialFadVpZbU5MQklvNytpVW5qdEdNSnEveTZEZFF5TzgwTUpzblZi?=
 =?utf-8?B?Zm9xYnRwYXFpZUg5bkVHallqVmZXZTFqSXBCbXdWUmo3d1ZMaGljRGtlbTdu?=
 =?utf-8?B?VUQ1azNkRlRqQW1lcE80Y0cvRTNJODBHVFQzUksxRjZUN2Z2U1V3d0lPZE9m?=
 =?utf-8?B?VDNaL1Mzd0JLSUx1U0J1cHlFakJBZzhINlRIcFNpSU1ON1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 16:13:22.1513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec2cf8eb-2498-4adc-81de-08dc8643964c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7920

AMD Zen-based systems use a System Management Network (SMN) that
provides access to implementation-specific registers.

SMN accesses are done indirectly through an index/data pair in PCI
config space. The accesses can fail for a variety of reasons.

Include code comments to describe some possible scenarios.

Require error checking for callers of amd_smn_read() and amd_smn_write().
This is needed because many error conditions cannot be checked by these
functions.

Also, drop the extern keyword as it's not needed. And remove a warning
that will not be triggered in many cases.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/include/asm/amd_nb.h |  4 ++--
 arch/x86/kernel/amd_nb.c      | 39 ++++++++++++++++++++++++++++++++++-----
 2 files changed, 36 insertions(+), 7 deletions(-)

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
index 027a8c7a2c9e..0616a7727898 100644
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
@@ -213,7 +242,7 @@ static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
 	return err;
 }
 
-int amd_smn_read(u16 node, u32 address, u32 *value)
+int __must_check amd_smn_read(u16 node, u32 address, u32 *value)
 {
 	int err = __amd_smn_rw(node, address, value, false);
 
@@ -226,7 +255,7 @@ int amd_smn_read(u16 node, u32 address, u32 *value)
 }
 EXPORT_SYMBOL_GPL(amd_smn_read);
 
-int amd_smn_write(u16 node, u32 address, u32 value)
+int __must_check amd_smn_write(u16 node, u32 address, u32 value)
 {
 	return __amd_smn_rw(node, address, &value, true);
 }

-- 
2.34.1


