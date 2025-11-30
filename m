Return-Path: <linux-edac+bounces-5541-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E449C94D91
	for <lists+linux-edac@lfdr.de>; Sun, 30 Nov 2025 11:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C4F314E06EC
	for <lists+linux-edac@lfdr.de>; Sun, 30 Nov 2025 10:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DA9233D9C;
	Sun, 30 Nov 2025 10:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2ZTVLphB"
X-Original-To: linux-edac@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012042.outbound.protection.outlook.com [52.101.48.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016CF1373;
	Sun, 30 Nov 2025 10:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764498084; cv=fail; b=ThY+vs3tnqteiS9g354CQ5ntsO9eTdQPl9IQqcKJGshICqn2UzanRlw/sTCFHTHcPK+rSEV20HLbr2bXRaZItOs86l+3aS4uMhkubsSLx88no/0KBN/cZL6BLIMpiiTatocnNTIl6y+RrJTBPAF5zOeMndK+u1B9v6k3EWeVTag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764498084; c=relaxed/simple;
	bh=sCy5QVihljFm6VEmr4sl4kr5dMXR0mkuAIJnD8e1Xt4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DTYrtdUApwbL8MLtKbxIpFcN6uT/NesCd+nlc0L5oGDk93cEvgY0G7CLrWQ+DYrilJV2yke5mH0/SfbSX1AlE4CxpQu46o1vUXx5FAM3eGRkVVcMtjS2Rza8gBHmgqwJDlP94105l/dxo00XhE4pk3aRI1bTDjw1X2iSqH0MVh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2ZTVLphB; arc=fail smtp.client-ip=52.101.48.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mxUr42YLmyA1uMZpZGvKDfZBBm0qdBB+YV/9HWQaoBifygIAkGWGYkFR+6lCga23L53zbVL5RndMBB/vrgBXc5yGxvoGYehEgaDSPNHlJfSiPdTtVYqU8qj3GS4zhXKEA3GkgeLawFuVVV0cFZBRMMzUGqP0uIyNTdwOVSBxbM8ZkWEH3d6XRd1+NyCiPWfVpokz3Ja5xmix37OBFrEx1Nt2e4y/gMjehxSboRA9rzBxs3IMylngRGoZc4dCtQxssLPZUJZRvNNiyWqUl2jw9R3syOWZMoRa0IRJGjE9vM6tCZRKkIR5j0XijbbATDKaaJADiSboUXISK4kkTd8oZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QkismcIxKWwdd0jxpM3/o3OKrZGya+QSfnaiD80V9oQ=;
 b=WvYfJGkIpcz3heiFjL/CwCTtUJBcR7bbxq0ETAlW23FKQqJ5YXd0pANJ4Et4GGnVXEWxtA0U/QgdfrsbbCBqE4F6HiDwO/x5BhQru0na8VFwu1ws+Vm8/kOExCEnvMcdvr4Ifx0XjjoU7sf1lnkOa7e4NuX54ugzXjstLdtaLLrL0/eqDZhx02j7k1x2lVc84mjrcr4r0p2gsNKCd4l2hFdodb0syZpQpiZVnGmzP/wke4hpyCXrIKuI8iABdVK5cVvI3OZGUa63qp75WUf4GeAJLe7KOgN0v5YbBfWzC2lYzVrlJUHP8hTpcKkbTucLlxxvDX7qd0vmMhQlQDxhig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkismcIxKWwdd0jxpM3/o3OKrZGya+QSfnaiD80V9oQ=;
 b=2ZTVLphBanhuuCLhd8H45rzWc4NjbEhN0JKki9ym0Otz34dUzS1/2H5yUt1W6hOmnni/6nlScH8ckIOmws2SS5QNZXnclzQsGes0X8eFYeN6LoUS18s5vzZ2GX3cKt3nwpJyhG0/xTR/fUatLecw5NFlEmXdQ0FbpCYvVAwKXe0=
Received: from BN9PR03CA0673.namprd03.prod.outlook.com (2603:10b6:408:10e::18)
 by SJ2PR12MB9243.namprd12.prod.outlook.com (2603:10b6:a03:578::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 10:21:19 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:10e:cafe::5) by BN9PR03CA0673.outlook.office365.com
 (2603:10b6:408:10e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Sun,
 30 Nov 2025 10:21:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Sun, 30 Nov 2025 10:21:18 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 30 Nov
 2025 04:21:17 -0600
Received: from yocto-build.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Sun, 30 Nov 2025 02:21:16 -0800
From: Devang Vyas <devangnayanbhai.vyas@amd.com>
To: <yazen.ghannam@amd.com>, <bp@alien8.de>, <tony.luck@intel.com>,
	<linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Devang Vyas <devangnayanbhai.vyas@amd.com>, Ramesh Garidapuri
	<ramesh.garidapuri@amd.com>
Subject: [PATCH v2] EDAC/amd64: Add support for family 19h, models 40h-4fh
Date: Sun, 30 Nov 2025 15:51:11 +0530
Message-ID: <20251130102111.1180875-1-devangnayanbhai.vyas@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|SJ2PR12MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: 917c1c83-88d1-49d2-41f7-08de2ffa336d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c2pDBdaATSiuGfnapfThNp+EUMWtwjY2VlpIBWJIwd+gIx2aKoxRm/DRkp0Y?=
 =?us-ascii?Q?AfkBUcw/S32Kc/6yrpsRXtbe9GmBBcSQv8y7+ZOOZOvL+DHmntSEElacUPIN?=
 =?us-ascii?Q?QfaurNQxehS1CeahQEwpKHSGAtGJTp2belnKCg6RdIDSSVBNQffPDOc5xEVs?=
 =?us-ascii?Q?6nSChVitOHSg0AuFEkXBzeTSS8ajHlLGf8Qs3p54VSphOnZOY2aySkD1i+hp?=
 =?us-ascii?Q?S1IIIEHfkrymlW3jHhlIYR/wgIy+YuoEpbRP4RJfVlpc37N6XbPNh4+kW4it?=
 =?us-ascii?Q?Q2WrnarD17erY76U3qrmDdxSog9/8nYnS5bwCIBmuuByL6kE1qru0be3MXQ7?=
 =?us-ascii?Q?7IkSw9w1mr3VDUn9XB5tJmgM5XsNZUa5YpgR3BgUQy319hom+lzJIp6rwJDU?=
 =?us-ascii?Q?YZ0mhheNDv/YnOBzgu6LaEYGU34O1os0FIDlS+Oa+V5Jo51uK3dl7ZBBym01?=
 =?us-ascii?Q?zM3Gdc584taTuOXV5sdth5iZ6TFxcM6fTcOSzRGSg29e5HX0li3+YvRZb4j/?=
 =?us-ascii?Q?YKKdGpSVRTW92VZQ7zI9u9n11Z2PhH9Ol3oRI1U8Gd7kcfKi9Hm5RUWpii3u?=
 =?us-ascii?Q?llPT0DYnD6+1YHxMhDDewKUoq0Ibn4VTs9Fv6Jhkk/cjtQ4kbq7/UZrs0vj0?=
 =?us-ascii?Q?bkgJbwZMEa7J8WIr6s8qsOsCAlnVs4XlxHqL3cA83wn32JOFChzvfGKb9uUH?=
 =?us-ascii?Q?I+Fp5TZnQ18gFtxpkFeK1CwhiCchOgRu5Z8JmmVQe58cPL+XgUw0dPlq3CI2?=
 =?us-ascii?Q?UAGYBjTmaOE8TIQQz24jBP7PCIYG/DTh94MNT4d7nyBQE7B4hOg1eqvdjSXw?=
 =?us-ascii?Q?Jj1blHvVaY5No1vj6L67e02k8lNkvDMC5dQWr6eo4IhK1ndytaNUqn7gHT64?=
 =?us-ascii?Q?efVOrVlrYR223/q4SM5uyauZayO5ctVPWbP60SRgNt7YtsjPY4U99t8iM9f3?=
 =?us-ascii?Q?4RCb/2gpkiSv1zXgtsxiUjeNF3kCcWbWi1B6lEQE413x3bAmSYOs6NIax4sU?=
 =?us-ascii?Q?x1Pm3h67AL1cl8zbkP5cZ6ZPbJ5HOiErav7LoYYlM9YN2a1FP6RoPo6j10YL?=
 =?us-ascii?Q?CzgGr8N0F5zqsnnwn//jDz+akjZhApWdU2YCtLRGCRca6KXwpHp9A8saDiT6?=
 =?us-ascii?Q?Div7GofiIWu65vJCJY5UBJr4hBbqX1aF6WNXX6M6gtyQzOhjq2eLc3TIZgzb?=
 =?us-ascii?Q?G4+ra7RyUSK5c3bjcluasCqHv/DMSyQB2OfSBIFMSnI78cH0qNy3F8Z0XmoT?=
 =?us-ascii?Q?TDSbVnEgzj4bGdsht+cYNPuvQZprEiIGy1T6+ZpxDXp1+wJ2FtAHndf1mIR/?=
 =?us-ascii?Q?Sn8RLI5h+vskHgmmDlEU9A98+2JCIAI4pfhz3oPI50BWTw59yIniWG22ZRXy?=
 =?us-ascii?Q?kbuJWMWBKDYvDZ8aOFhCriSgBHNCapmlv7fjKDl9Vo81INLU+fNiTjoa4hH9?=
 =?us-ascii?Q?CQBUJ/Q5IL2lRJ+5J+/T9XdisRavl87YCeatpGU3tz2LCu7H6JPjygePGTT1?=
 =?us-ascii?Q?KPL/kjYttgKfiRTnaaoZa/MTlMxx2PZZxD/ajwGsLsjhapD6YRT1nXELbNI0?=
 =?us-ascii?Q?F529RhkLMYAJrBJBoDk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 10:21:18.3928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 917c1c83-88d1-49d2-41f7-08de2ffa336d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9243

Enable AMD EDAC driver for AMD SoC family 19h with
models 40h-4fh to support Ryzen 6000 CPUs/APUs
("Rembrandt"), which provides kernel-level
infrastructure needed for RAS (Reliability, Availability
and Serviceability) features.

Added changes enhance the ability to detect and
report memory errors on systems that utilize AMD SoCs
from the specified family. There are 4 memory controllers
supported by Rembrandt which enables proper error reporting
and RAS testing on specified AMD SoCs.

AMD EDAC linux driver interfaces directly with the hardware-
error reporting mechanism present in AMD platform, otherwise
these errors would not be surfaced through the standard Linux
EDAC framework and RAS validation workflows would be
incomplete.

Co-developed-by: Ramesh Garidapuri <ramesh.garidapuri@amd.com>
Signed-off-by: Ramesh Garidapuri <ramesh.garidapuri@amd.com>
Signed-off-by: Devang Vyas <devangnayanbhai.vyas@amd.com>
---

Changes since v1:
- Addressed review comment related to commit message which
  adds detailed information on why AMD EDAC driver is essential
  to load on AMD SoC.

 drivers/edac/amd64_edac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 2391f3469961..6cf0b6d7b5ec 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3863,6 +3863,9 @@ static int per_family_init(struct amd64_pvt *pvt)
 				pvt->max_mcs		= 8;
 			}
 			break;
+		case 0x40 ... 0x4f:
+			pvt->max_mcs			= 4;
+			break;
 		case 0x60 ... 0x6f:
 			pvt->flags.zn_regs_v2		= 1;
 			break;
-- 
2.25.1


