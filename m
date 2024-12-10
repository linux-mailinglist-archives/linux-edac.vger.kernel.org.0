Return-Path: <linux-edac+bounces-2686-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B91839EBBBD
	for <lists+linux-edac@lfdr.de>; Tue, 10 Dec 2024 22:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E7E5188A1CD
	for <lists+linux-edac@lfdr.de>; Tue, 10 Dec 2024 21:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30866230272;
	Tue, 10 Dec 2024 21:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eOZ/+Fax"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2CC23ED4A;
	Tue, 10 Dec 2024 21:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733865666; cv=fail; b=O2WcHmPoNtLZJEmsCLH6K5vFE8DJwHBRhtECVVV93t5VAzF+AqI0v/Yz3u1UHNDKkdkqLEqm/lqLUqq42Opy/Y+T6kCv2ql4OqfdWsPBSpBHF/OhaTL1VbdKq7gA7Wr20qnfs2OZaNeynXH+perayGJKCxqlEk0R6BVpfquGOFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733865666; c=relaxed/simple;
	bh=KK46q87D2ss9hwnAizGe1YGRZVP6KD+gdbvfJebaWUg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RveddAFU2X0SOAFB8cGZYmbxd5MZpra03pL6JK3h8/hBwzT0vgTkRS43FjTdYE+56sbZ7x9mslr3QiJOPmRbeg+BBjKnyqqeOvDgqS2H6chey5UROC8urxh4rzB+gHtKByxmDgxVS1MSoOlmWnbtSUYLFps3sJRHD0Ge670GErU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eOZ/+Fax; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TC+cDlcQpMxqIQJ8USxkkiW/ExWWdSrlIJ2HvYN0/eTBY5SCZp2LIxJGAymfVB9YtlXnVdi4M1MVlP3vXc3EI7LS7bYWbzGDMVI/zxRxqYEUfzhQfw1w5MJ/I/0MLlh4qMcuUHfYIcGGwL92yacs45oG1h1CfHT8zP99S0K/exucq8YOXgw+7y9oStC/JcVqAHX99k2ZmO/yLDlkAhqqyMjRe+de4LrID1jP8hAB8t1GtZF1fwYOHG+PA+RrRD1YxHD1/PEZF+Do6wZWMoHp0h6gX4QCC2X0Wc+osEf6aJPIqg3tVERA21il5P5bRcS3srpngvDppOPvtSUZcA3JYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9U9pcpRyxMvHWHyy4oe4D3i2rH00rxEDypyzL6imoQ=;
 b=Z+3tUy7iIWLhPayp8GdgJ6Rku1zEKEUUBnjMhwFbwF+Ux7xcUW5ieI3eKyCJXNBDvSnqtiS8MtYKLZocDCBcTMmaRFWdEQ28akqjunb9kr3IGPhLYA31zKBXzDD4EKuxzh9/x+Hb9oRyoMRc0X+1PACDiYCzOG2h1CxVfpn7j7Qn6l9TOzWXrU/o1isX23z+iKGUUZbU1jSIqq7AIIe3zc2LS7vy32p0AZ0AT9gHcgmeUiS5NtACfWvcUfWiQCfLF5IOO6MYB5re10M8/ARV5WCifFPkQsAZ43RAWCjDm8oSwZ/08LYraVWJitCD2uXQXda1998chliozXyroS2RAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9U9pcpRyxMvHWHyy4oe4D3i2rH00rxEDypyzL6imoQ=;
 b=eOZ/+Fax4nfBQ30tGJ5cCNxsPI+KgsGqXpos5CrbuZYfb0frYM1yzKzsmBmIOWEe1wcYKgIpwIg8BTwlqdQHeT5wAKst+ucjwrH5szeySuYKWibKRbKysuog1djbQrNg0tf3KdVL6xiCwuGgXXVY+79Th9wwVzanp3cNyTRrtGU=
Received: from SA9PR13CA0149.namprd13.prod.outlook.com (2603:10b6:806:27::34)
 by CY8PR12MB8068.namprd12.prod.outlook.com (2603:10b6:930:75::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Tue, 10 Dec
 2024 21:21:01 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:27:cafe::6e) by SA9PR13CA0149.outlook.office365.com
 (2603:10b6:806:27::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.13 via Frontend Transport; Tue,
 10 Dec 2024 21:21:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Tue, 10 Dec 2024 21:21:00 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Dec 2024 15:20:59 -0600
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <yazen.ghannam@amd.com>,
	<avadhut.naik@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v2] EDAC/amd64: Fix possible module load failure on some UMC usage combinations
Date: Tue, 10 Dec 2024 21:20:00 +0000
Message-ID: <20241210212054.3895697-1-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|CY8PR12MB8068:EE_
X-MS-Office365-Filtering-Correlation-Id: 2acd5618-3937-4198-25f5-08dd19608bbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BYuI7I3kVzprLfvUUSz3RhUddpgQhEacIv/9NxtVD8G6vHc+kL03EJSZui0c?=
 =?us-ascii?Q?o7t+kIhGT6QqYPzwJD4URD9Wb+xTEhJFh/hlmnPbjCLyPYRobUc5Bu2Z9v8L?=
 =?us-ascii?Q?asllTsZmdfSmLG0TaQOUc9wDYLauK5wJfxrmk0MOCEFRqSavZN88dgInAtSS?=
 =?us-ascii?Q?cKnqDNaffTmWQYSOqsK7U19zilsfAi67IlEe5A4h7a2GF28QQJ8gwlHXaHYi?=
 =?us-ascii?Q?niwk4VDl7NzvoHsUSAKGduB25XPUkRYvJNEXCY2QnHdQjVOj+UlTsB2/SUMS?=
 =?us-ascii?Q?vO14cDB6QkTXZ8xT9Z7Y4ZkrAnpaKfik9Ipvj5QmJSjloLMZA034YC/1E1YE?=
 =?us-ascii?Q?rnYcQye3pvwzjg2u78K4XTQaglsE63wwwRdnwS+nW955E/jbyE48lj598qdZ?=
 =?us-ascii?Q?lGSHJPp2ofx5WbNibupUrcdH804faKbJD6zcZu5qTwItUFXsFwfQemIJQJZF?=
 =?us-ascii?Q?YUCvkapsv1m/QPHsCHry9j/6E8WGsko5vb3g8tbXwbGJxVB9GubSZEh4/Epb?=
 =?us-ascii?Q?umpN0EyV8axNqEKzl+VL2uLc2j2e5VIIy7JNUh9xg91f7Tpip+Xx4jqSm7eP?=
 =?us-ascii?Q?MpDfvA3Nn/pVtmLGl4NFUzDccvWuJpNvmcQrVKTZ1HkAu0kTSlx1xuL08s6D?=
 =?us-ascii?Q?S+UpktvxYIJ3wQgQCDifZWko4wIcypJcs04yBusJo6ida7KhPsgdA7gdrnOs?=
 =?us-ascii?Q?Nf4t3IRGm1ATCD/GQan1Xz2hcvy2beDoud5tSpe2wh7aS0LR5kCL3i1XvqzP?=
 =?us-ascii?Q?QNyYjZbh9Aijhn5rqH9DKabN0caINVmjD+e4HKMhHv8KdcEga3ChaBNmwO8k?=
 =?us-ascii?Q?Mbt4ZxjBG6E5ObUvHFBmjch4FxH683qu0hw060YmKXFjo8MOTVANN0DYleld?=
 =?us-ascii?Q?G0e/bpurK1Q7pRcV60l0aJQ14xAuaZxilcWIgJPqLzME10YV56JzEQEAI5ov?=
 =?us-ascii?Q?PDICPeDuRcrwhcD28wNDDcwkrVkimn17/rHNoo2tzieYx2TJv4mByu0evFqb?=
 =?us-ascii?Q?pf17shKpmbLCZa44konkNOhnnsm/oAwVKMuH+X2FRwetn2exdwkuYk603JqA?=
 =?us-ascii?Q?u1cDcZLLcsFqtGhWMCQZOLsJnXC5D+n0tJMVH/oHwLplAwu49YFV2DBOgIjd?=
 =?us-ascii?Q?xJEuQDsi/JeRiGpOOdaKoSKdoHJCMj8J2p/0SR50x7dpy+aUrC015keAyBrE?=
 =?us-ascii?Q?cGyurwXnGVWoUmI9OWmbxPtX9EnEoYyn201vXm/ZA17SlOGamc8pxoucYEZ8?=
 =?us-ascii?Q?ffzfZ17K0RnqIWWhMOjwfBgCreGoNQBPxhUeHKqnlCISk4KZj7yeC8PKtN1G?=
 =?us-ascii?Q?E5XyWiTOIEQ7mEj/37K/IY2UdwZXTD/51Wy0KTa2QCxPUd6ef34ElB2r2cHZ?=
 =?us-ascii?Q?5krXm1r3iCpeyw3F5ADGKG03gxtQOe6vBTBpMu8dAq0YTKgPNVmuwN6H6RGd?=
 =?us-ascii?Q?ZA2dT2ax7apJxHk4u99PK3h3dvByJenJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 21:21:00.7746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2acd5618-3937-4198-25f5-08dd19608bbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8068

Starting Zen4, AMD SOCs have 12 Unified Memory Controllers (UMCs) per
socket.

When the amd64_edac module is being loaded, these UMCs are traversed to
determine if they have SdpInit (SdpCtrl[31]) and EccEnabled (UmcCapHi[30])
bits set and create masks in umc_en_mask and ecc_en_mask respectively.

However, the current data type of these variables is u8. As a result, if
only the last 4 UMCs (UMC8 - UMC11) of the system have been utilized,
umc_ecc_enabled() will return false. Consequently, the module may fail to
load on these systems.

Fixes: e2be5955a886 ("EDAC/amd64: Add support for AMD Family 19h Models 10h-1Fh and A0h-AFh")
Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Cc: stable@vger.kernel.org
---
Changes in v2:
1. Change data type of variables from u16 to int. (Boris)
2. Modify commit message per feedback. (Boris)
3. Add Fixes: and CC:stable tags. (Boris)
---
 drivers/edac/amd64_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index ddfbdb66b794..b1c034214a8d 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3362,7 +3362,7 @@ static bool dct_ecc_enabled(struct amd64_pvt *pvt)
 
 static bool umc_ecc_enabled(struct amd64_pvt *pvt)
 {
-	u8 umc_en_mask = 0, ecc_en_mask = 0;
+	int umc_en_mask = 0, ecc_en_mask = 0;
 	u16 nid = pvt->mc_node_id;
 	struct amd64_umc *umc;
 	u8 ecc_en = 0, i;

base-commit: f84722cbed6c2b2094ad8bbe48be2c5900752935
-- 
2.43.0


