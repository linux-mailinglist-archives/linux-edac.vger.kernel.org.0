Return-Path: <linux-edac+bounces-1009-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0839D8BD40F
	for <lists+linux-edac@lfdr.de>; Mon,  6 May 2024 19:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E6481F22451
	for <lists+linux-edac@lfdr.de>; Mon,  6 May 2024 17:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C90B157E7A;
	Mon,  6 May 2024 17:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gBVUZBF/"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC071D52C;
	Mon,  6 May 2024 17:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715017708; cv=fail; b=DmO/D4M5KtdKLS4nhMa3Zgtjj/siNCOclVX2l3QNChkuPYAV+jQfXjIhCQcivTNajWAxJ0pyZDWGUlOgqHDrGfrNVAXkZ1xRWvWy71ZtSqkp9aYs5nuai3JDbz97KhWKSr+D/7WgMe85AJsOOFZ80Tkj1/aHxdMZK46l0ngUno0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715017708; c=relaxed/simple;
	bh=EwrFLBiSPrM67Vpa0lwvtZItbsUBhkdhUiA93kge5Vw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uW1+XXGYLhJmnLn0Lj0pLtfc6gIbZa3ogmqYS/eW54SfGUQMWViN/ceqTJil4jOcwvg7Ebp95Vj5DMcG9xZsUABHwyTfy1Md6cgYWhVr26tDBlmfWcG4IDjm6fg+OKDnvu81do1guzhXaATq2uMvn5I7/QtmJV+TllROKoHnAbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gBVUZBF/; arc=fail smtp.client-ip=40.107.102.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oty8nFBWSXjB61yC+kjfhX7Akuoqsx9JTU1WZOzgKiP/QT4UODBQqLxKIohjNulaN23IyRqUk6nrlFXUL6VGDOzKHlhWcYLXrWK4VGjv5xt2HLnoBOMMR2dibHIDFhftkP3bpw/sws8ypaqWcxiQvwaXamCKZsig5FPZwokA0mMeT0DaotihZODjOVTF4AvvSU8Q1KdSCJKqEX8PYzJUYLzaAiJMwaubraU7BfBdZcueF99wL5Sp2ACEr3wM8CA+dpw2FnKPqAUcQFHCGNTn1ZjptIIxK7vhsUStdNt0sVk9PEvjxYRhpRTr6vFnR/rHrwqYCZOvEKq5cPYEXEubtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNyfNyA5527mBK7SvNWKRnJ7pcMjXK7LACLlKH3nYZo=;
 b=S8O+tj5snkB5c8+XyHiifmLuTsPoxBbt6iNPjAWBc/k4Fs3IKrPhYZbp22pWmgTcwD+PgBmZz195mw1eRAaCyRjISgJa7/xjnlgqyDXRkBrhAo7KNeSoYaMNtOBcdjlo+7a2VVCig72R7RUbKaF67Og1vwbu7rgR5YE1v+9m8PcCUHXZG/W7x830K2YV8yl7Al92TxNFK/8Shf76KSWGgJ8F+esJw6HoZU87mgAUa8eY/rW/kjo+qwsG3qnrARjRJjDVHdKdthXmKXKrur0teXtJtQn/r5Lxj6f9SHcM1R41T4PcAfcwiK6Ax+AMQhMPXIxDgBqUAaAEDZCf0Db8Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNyfNyA5527mBK7SvNWKRnJ7pcMjXK7LACLlKH3nYZo=;
 b=gBVUZBF/jhSB64JNYqWgZqLeHzGQOA2y+Y2Edb4gdhwJOVDnIDSWwRvLDkr0wWFZHfzvi8qGPSGYO+jNYauGEgJN8BSVSNvFOMjt6QiZ/jtk/AFXNnzqQEtUCn2LuXkoLbzh4ga3Ah2g5bi6CwGEuu+Ichw3HIOjQbV+1qAaHOs=
Received: from BN9PR03CA0187.namprd03.prod.outlook.com (2603:10b6:408:f9::12)
 by DM3PR12MB9392.namprd12.prod.outlook.com (2603:10b6:0:44::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.41; Mon, 6 May 2024 17:48:18 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:f9:cafe::79) by BN9PR03CA0187.outlook.office365.com
 (2603:10b6:408:f9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39 via Frontend
 Transport; Mon, 6 May 2024 17:48:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 17:48:18 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 12:48:17 -0500
From: John Allen <john.allen@amd.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <bp@alien8.de>,
	<yazen.ghannam@amd.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, John Allen <john.allen@amd.com>
Subject: [PATCH v2 0/2] PRM handler direct call interface
Date: Mon, 6 May 2024 17:47:19 +0000
Message-ID: <20240506174721.72018-1-john.allen@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|DM3PR12MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e0a319f-0f62-4608-2f2e-08dc6df4b67c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTVBSGROSEQxZlpTWGRqaU0yd2UwSmdzMGx6K2ttVUk4dWo0MFlGcXVTOXVN?=
 =?utf-8?B?UHpXbW1PTW9wdUVFcVh3T3dxay9TYysxOGZUOWxLalJVSXppem5XWmtDSy9s?=
 =?utf-8?B?OGR2clV1L2ZDTEJNYjN3RjlRMExkZjJtOUlEMzN0ZURLbTRVVVZuQ1JqSDNl?=
 =?utf-8?B?bzhLRXhDVG5xWHp1UlVxMmZ0NFNra2ZXQlZTSVo0QWpGdXY2eXRUM0dsMG1y?=
 =?utf-8?B?RWtKSEF3MWtqbVc0M3oycGJVS0dOWk9GNWs2b05qOTZCa3BpcTBoQTlsaDlt?=
 =?utf-8?B?Qmw3Z1JDSDN1VFRMZVprME5SU1pBU1dJU1AzMXRDZnYwYzkwSk5JbzhJZmI3?=
 =?utf-8?B?ZTlrbnhEckVuVTFDaGtka0JDYTJHa2dmSWtHNXI3VjIvU0lNbE5PQ1VUNUJv?=
 =?utf-8?B?QVlOclNPcU5iNCs2MWxjZ1UraWl5V1FBSlR5LzhieU5mL0dFZWZ0eWxGbFRo?=
 =?utf-8?B?RExzZ0MvS1JNd2Vtb0FIbldnU2x1a0NJd1ZXWEpibkcxcVU1VkRNcnEzMG5U?=
 =?utf-8?B?S2o4N1FKZEdkdzRMMkIzc0h6eEI0MUc2UmFEYlFaa0gwV2k4eVJrckd1Y3Vq?=
 =?utf-8?B?OUszMjV6YnQ5SFZaZ0tlVFhvcWQ3dWtpUGo3RHdHQkc2dDBlR3Z1WWF2b3ZT?=
 =?utf-8?B?TFl3eENGYWVrQmJ1QnlCdjU2SWc5dFVYT0pHdDRMT1RPdjBhZ0d2MVVjUlZn?=
 =?utf-8?B?czc5YjA0S3hLa2FWYm40bTE0elNPY25nVFlNQTdzY3duVmRVMDlnRVVkNVRq?=
 =?utf-8?B?WTlESTJoQ3JGUUZQZnBuU3Y4RWl2aS9DYzVkOGZ6ZzJaYW8rQmtZc1FRQW90?=
 =?utf-8?B?SUdXRzUyZG85QXJ6UFJ2NzJXc0JaMFJWMW1YU3ZjeUNmUkcxSGZyYWhId1VG?=
 =?utf-8?B?L0lCQWxZR3crMFJ6bWhTSzBOMEdWSE9Fb1ZQYVdIQ0R3ZjEyL3phemtRS1pS?=
 =?utf-8?B?ZDJCZ0R1SU1NK0ZGYTVqZ2ZaREhVb25ZUUY4cEM2Yi9MSHZCbU5JMTJVeUpK?=
 =?utf-8?B?TTFrVDI5M0tlRDJua0lWWGdYcTNTY3lFb1M3RVBPYUZvY3UrWVdVTm1odnpF?=
 =?utf-8?B?aVFVWVZIeG1ESUJQMjFFRTgwOWZQc0RwTTBSU25UaHRZUXZOZDJIRDhycldk?=
 =?utf-8?B?TEIrYVFtSWpRMG45V2YxWFhUTUFVWkFnVjVqVzZ0cmhrWi9CR1BRSVZOM2Rl?=
 =?utf-8?B?U0xkZERVdk4zMkpRUTBWcGpwQnJ6b3pRT1EyWW9lNWxzc3BYWVZ0VG5Mamp4?=
 =?utf-8?B?amMvQ3dqd2FBMjBuZzlwMWhZR2FxbTRFd3NXQ2tTVzBvY2t1eUZKY0lTcmFF?=
 =?utf-8?B?bEc2Tkk5cEZYUWFNeDFXQTc5WmNhSGI3U0RaNDhSNGpyMjY2OFFzLzJFZ2Np?=
 =?utf-8?B?VGlYZ3hxK3JmSy9NQ1hwVzJPQlp4RkZvczZwamFIZEdtRkN4c1VEN3dZSUdN?=
 =?utf-8?B?VGhHQ2l3cjBrYnhubWo0V0p2MjhlRzlqZUd4M2RUUVFWeUdYK3FZcXdEanFl?=
 =?utf-8?B?SlA4ajJ0WU9nOTE1c3pWT2VPZWhRWnJrNFVUNERSS1VqcUxhNFAzWTZWSllY?=
 =?utf-8?B?Y0dsZGVNdmxUd0ZpUjVPRk5aOGM1WEtkUS9WWGN1ZHhQZUt4cyt4VzVJNnVk?=
 =?utf-8?B?LzF4enB1ZnkxY1JuVXBPaHk5eGR2cjNnUWx2VUMzWmp5cFdPdEtaZ3dPaWFL?=
 =?utf-8?B?VnFVVTNHdkRHYlVteTNuTGdSL2l2NHRuTXA5bm9kclh2MzRmR3FmY2lvQ2ty?=
 =?utf-8?Q?hb6XWHqIEtuuv78JuQq6Azry/ci1nKxj0EVJfVQ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 17:48:18.0182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e0a319f-0f62-4608-2f2e-08dc6df4b67c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9392

Platform Runtime Mechanism (PRM) introduces a means for the AML
interpreter and OS drivers to invoke runtime handlers from platform
firmware in order to remove the need for certain classes of SMIs.
Further details can be seen in the PRM specification[1].

Future AMD platforms will implement a PRM module in firmware that will
include handlers for performing various types of address translation.
The address translation PRM module is documented in chapter 22 of the
publicly available "AMD Family 1Ah Models 00h–0Fh and Models 10h–1Fh
ACPI v6.5 Porting Guide"[2].

While the kernel currently has support for calling PRM handlers from the
AML interpreter, it does not support calling PRM handlers directly from
OS drivers. This series implements the direct call interface and uses it
for translating normalized addresses to system physical addresses.

Thanks,
John

[1]:
https://uefi.org/sites/default/files/resources/Platform%20Runtime%20Mechanism%20-%20with%20legal%20notice.pdf
[2]:
https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/programmer-references/58088-0.75-pub.pdf

Tree: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
Base commit: 4cece764965020c22cff7665b18a012006359095

John Allen (2):
  ACPI: PRM: Add PRM handler direct call support
  RAS/AMD/ATL: Translate normalized to system physical addresses using
    PRM

 drivers/acpi/prmt.c            | 24 +++++++++++++
 drivers/ras/amd/atl/Makefile   |  1 +
 drivers/ras/amd/atl/internal.h |  2 ++
 drivers/ras/amd/atl/prm.c      | 61 ++++++++++++++++++++++++++++++++++
 drivers/ras/amd/atl/umc.c      |  5 +++
 include/linux/prmt.h           |  5 +++
 6 files changed, 98 insertions(+)
 create mode 100644 drivers/ras/amd/atl/prm.c

-- 
2.34.1


