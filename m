Return-Path: <linux-edac+bounces-4535-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC06B1DE30
	for <lists+linux-edac@lfdr.de>; Thu,  7 Aug 2025 22:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBA6417AEB3
	for <lists+linux-edac@lfdr.de>; Thu,  7 Aug 2025 20:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A3C22DA15;
	Thu,  7 Aug 2025 20:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pa6950IO"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1169B21ADAE;
	Thu,  7 Aug 2025 20:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754597950; cv=fail; b=S5gCYqduDY3vV3G2ud9T1FiuQLUmms/+Oo3IBRnSUbvDZctBwMLSF/43gvibBpG9YjIZJCYkkDPFgYR5roGK44RNK0Jf/HvrFqzG3Z60HfQ4b5ucLwnDFFU/KEGYsDDN6UqriGfqnzfJupAnU4593ksuEmClHNiuxU3BA4NHzVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754597950; c=relaxed/simple;
	bh=xf4bM9xFUsVR7SGQAl5hCUFnLeQLWG7Zxfc77Q03zMg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aXCAQsducBhdybvfUKLKUz7HO/TTa8BAjFP37ggnHSBknzi7qhp4iSVSt2yaeDlJo8OGugQsOskNrD25vU9la2bcriBt1eQuGBDoSTa1+IHmHZvJOa1ARqQ5+ZUuXwfEJXtBLNryK9GiRWkq2XMxKtX8ahjbTcD+LhZa51piReQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pa6950IO; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r7kLazvwvxUve7Fa5UiXEm4D8Lhp1f6UqlYw3jZOeyKAoZXfIIMqSjhMS3oEpvr9pneuBUGz2JJnaaftjfDJ0zW9DqX/KhFM/fPwg2KAHaFdeKgoWQ0f9DoHqw02IpmxAlMpeEnMM21oS0blB3izHSAlEQzxgD4Nz/7m5h3fTty0S+jx1jEgTDe78XqKEHe3s/lQmmUZ0jAZOvqnem976Qqzkb0QSoeVo6mefiCYc64CMHjQHxrXAaPdtmlC5or6ZphRS/AUoVkdk/VHuJOrFsiWggmJiJn0qW4b4IKSLNxOB0rJEyU3sCHt8FWtN7iI3qyLmWTmyWtVX0gHpg9uuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jy0ptpULIrIaQHkFmqz9EUUkQ6VNs3uETXiAjnVkFvU=;
 b=e0y4RivD/T+aktAD8A9FTuT/dvS0IpCENdO3BGiE3FDKksl50q9R6/tLidP+2ehJKJjHlWsKY4+uGqd6a9oTtXl0tww25uK4Nukpu1xkUAHr34L/bKvjl3vsSquHQH9H3TYaN7jH0lNONWx1842o+LXs/TTx44589bSFXG2L0Ja32uXgFfX+FguwAEHtgF/ixoFMCIdripREgOGsxXZZvHkb1KmnjawDcByePU4klBr5XhMD//Q8q1iFPahEHnOYsBpxVFOXWFbw7WP/PoInugdLEDM0Mo8x8v7iDYNZ9YDO+ZW9+oaOv5aS64J8JUOyr2162oWCP9Rv1lb/etoP9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jy0ptpULIrIaQHkFmqz9EUUkQ6VNs3uETXiAjnVkFvU=;
 b=pa6950IOtJS8safDRIfBD9GZpKPvPd/J0E/nkUVx/RkPmJNM10YAFgiJ9lv4D2mHjaDHy0CtW8O3Sxk9P3Z+aGIMRQsmbj4LyU44iRK79d7tjlpjrIqguof0na2yuX+dw3ONX44RulyZNa8Fkr24FI/PwRBUA6SQ2JQvw4+3FNY=
Received: from MW4PR04CA0241.namprd04.prod.outlook.com (2603:10b6:303:88::6)
 by IA1PR12MB7518.namprd12.prod.outlook.com (2603:10b6:208:419::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Thu, 7 Aug
 2025 20:19:07 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:303:88:cafe::b1) by MW4PR04CA0241.outlook.office365.com
 (2603:10b6:303:88::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.16 via Frontend Transport; Thu,
 7 Aug 2025 20:19:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.0 via Frontend Transport; Thu, 7 Aug 2025 20:19:06 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 7 Aug 2025 15:19:05 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <bp@alien8.de>, <yazen.ghannam@amd.com>, <linux-kernel@vger.kernel.org>,
	<avadhut.naik@amd.com>
Subject: [PATCH v2 1/2] EDAC/amd64: Add support for AMD family 1Ah-based newer models
Date: Thu, 7 Aug 2025 20:14:53 +0000
Message-ID: <20250807201843.4045761-2-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250807201843.4045761-1-avadhut.naik@amd.com>
References: <20250807201843.4045761-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|IA1PR12MB7518:EE_
X-MS-Office365-Filtering-Correlation-Id: 13ce5648-c420-4705-096f-08ddd5efa936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vUN1/ui4Qam6fqCM5PdthFDGsZSNNCwwJxMbyCmy3tpzULC1fnoaADrncMoP?=
 =?us-ascii?Q?1ojsnoBYaRneRCBjDEUXouuGf5XpcThnVf1Cur1+8WKKAvuy3/A92xpwFaTV?=
 =?us-ascii?Q?Hub8Y3cjf0BpgiUtxL3emY+5SvHqPzYVUjEim0He6nt+g5+zG4WGqwi0RwpQ?=
 =?us-ascii?Q?O/+u3+agIaAZZLyqTOxT/Z1Mc/zpJw/kyORvCEZ+wL0lDFSo0Oqpa6HObKZw?=
 =?us-ascii?Q?yGNw++yFQNBjG+nuubHJvhNYV/oKLe0lSKNRzoLXum0hkWFIRjnPrcslH1+S?=
 =?us-ascii?Q?3y4+nFifpxO4v9nwe50EFteXTwhe7PYU+ZJb5UiD8Kb6pYHMm5x3xprQ6zuR?=
 =?us-ascii?Q?VzddWIzzMAUB4VBHqZgEhYGDFC+tbOoyHwOEe8fUb6rHtKZIz6Pbm/xpT2fT?=
 =?us-ascii?Q?KUgGcUYQ9BM0wl6fsBa7cqv1WNwFzgsf8ZQsja5Lym+u3m6YpqurTag6pszo?=
 =?us-ascii?Q?0uNZUghJBPCehXthkrjvrb3816ovxru9RER6uw/VLVyk9SZAGnYIQ5uiZCpE?=
 =?us-ascii?Q?AD/UMP4Oq42dsD8TQSlaiTgjYKyrjWNK6S8trc3JLlJJ0/8ZaII12Qn7Bw6m?=
 =?us-ascii?Q?JwewTCWeJKx+h/D7Thms4a/6G+KCDfYRtxKLcRM5rGTqZs+SXdifxe1rtfw0?=
 =?us-ascii?Q?NLWzmzm32LRGoX9MlXuxLK5Qz3QTH4QUlmwshOfVd+VH/3vFpAF1tMopGEx5?=
 =?us-ascii?Q?J9grsENro8YlnxLzQ2AumlfIe4CbFPwOKrUK8ZL6WrYBQ8ZiH8bPnLLVRyF2?=
 =?us-ascii?Q?884X7dg0p6K+wVp3V6aat42Sl0CSldQ477C4lTAErSi0OqD1mTmf/WB11K4D?=
 =?us-ascii?Q?+iTk1CGrAGNxcYrI5MA5ZJvhqytkXCwGwGA8CrIYDPm+fbejXJK9tSvnEESy?=
 =?us-ascii?Q?QSF1D5tfFH9hy5N5RbqyYLH6LRDgJG9XtM67mK+y6PBenzVFgyuyo6cFRZ9S?=
 =?us-ascii?Q?qyqf//RZEXidXPY+Z+FNH75GSRfbHR6gBGBT7J6Az1oUbSkxbNEa/mRrX7ea?=
 =?us-ascii?Q?cQr6srWpIDD1yP6uN5jM+CymBExYhjsJBBa9SVgZm/Fo1ZV26+Kw3JNbCtFh?=
 =?us-ascii?Q?pkyqc2VH0faXmO4jFX5qfjRS7cA8vhDjUfULxHlqDtN/p/aL7X6KicquECOj?=
 =?us-ascii?Q?cjRSneFIUpwii6FLEwaZas9TaXW4/VSU4X1xm/ngsRD0XeAq1MYui7p4K8Qt?=
 =?us-ascii?Q?MYK6lgH4h8c1hTCBS88cqaFChIP8DSLAQHdNGV4QXGbQI58TcZri1TEI1hpU?=
 =?us-ascii?Q?Ux0TxWd87oiRtttXG+GlNsR7bkmNBrgIAx9+DMkpXSlT8rtaUJAh9UB3zf3F?=
 =?us-ascii?Q?3VZaCyOb9nXYVmCPTcWOyHNDOjFH2KILOELuCFQ0sa596mSfMCz9gVHZwgO+?=
 =?us-ascii?Q?uuz+jN830FejgVxpq/iB7TesaEOGUdec6Bny8ucYqgE8d6u3PuXXWtF1mBv9?=
 =?us-ascii?Q?0D6D2CsnTVMie2XL/hz6vKPut1hLgAaFdN0DKhMlf+xSk4jGT+BSa4R8isXc?=
 =?us-ascii?Q?q4zvns73AwQED1WKQlO7sRVdvsV28Qu3IlCx?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 20:19:06.7926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ce5648-c420-4705-096f-08ddd5efa936
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7518

Add support for family 1Ah-based models 50h-57h, 90h-9Fh, A0h-AFh, and
C0h-C7h.

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
---
 drivers/edac/amd64_edac.c | 20 ++++++++++++++++++++
 drivers/edac/amd64_edac.h |  2 +-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 07f1e9dc1ca7..2f6ab783bf20 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3923,6 +3923,26 @@ static int per_family_init(struct amd64_pvt *pvt)
 			pvt->ctl_name           = "F1Ah_M40h";
 			pvt->flags.zn_regs_v2   = 1;
 			break;
+		case 0x50 ... 0x57:
+			pvt->ctl_name           = "F1Ah_M50h";
+			pvt->max_mcs            = 16;
+			pvt->flags.zn_regs_v2   = 1;
+			break;
+		case 0x90 ... 0x9f:
+			pvt->ctl_name           = "F1Ah_M90h";
+			pvt->max_mcs            = 8;
+			pvt->flags.zn_regs_v2   = 1;
+			break;
+		case 0xa0 ... 0xaf:
+			pvt->ctl_name           = "F1Ah_MA0h";
+			pvt->max_mcs            = 8;
+			pvt->flags.zn_regs_v2   = 1;
+			break;
+		case 0xc0 ... 0xc7:
+			pvt->ctl_name           = "F1Ah_MC0h";
+			pvt->max_mcs            = 16;
+			pvt->flags.zn_regs_v2   = 1;
+			break;
 		}
 		break;
 
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 17228d07de4c..d70b8a8d0b09 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -96,7 +96,7 @@
 /* Hardware limit on ChipSelect rows per MC and processors per system */
 #define NUM_CHIPSELECTS			8
 #define DRAM_RANGES			8
-#define NUM_CONTROLLERS			12
+#define NUM_CONTROLLERS			16
 
 #define ON true
 #define OFF false
-- 
2.43.0


