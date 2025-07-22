Return-Path: <linux-edac+bounces-4410-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA1BB0E441
	for <lists+linux-edac@lfdr.de>; Tue, 22 Jul 2025 21:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C79151892BDD
	for <lists+linux-edac@lfdr.de>; Tue, 22 Jul 2025 19:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DE4283FE6;
	Tue, 22 Jul 2025 19:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3vK3tkK+"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5847927FB31;
	Tue, 22 Jul 2025 19:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753212557; cv=fail; b=ItGfuLFHu3ogoqwKM/hgkUg2sHzIQNzFNsEXTV7eApdyjgVso+6/5knbYKGG3K6c13LUpgiANiVKl/9D7V9UFzHj6n7lwHnZEOlqRZbYoke5HspeHxLVvh7Cfxq4EI+aOU5EbrB44lK37c10iAAwmrVZ1VM3VjnJ1oJNt5LSC4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753212557; c=relaxed/simple;
	bh=i/U0YIyiHfe6M/axefkRduNQ7RpR9Yuer/wskQIeJCw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n3WrqwdB+x+nbN/vfBLQTlLIGE2406XWWvjf+A86cprlK0wqDyys5vZKSe2K3QWJW4CvgUG19bAPq4SeSMZW4esRDcztGZ3eeifcPXEm8fe4eyoFKZzEqXtpa/WVjtMq9GX+7nzwPOOyjCTyyWC9tKXrVQBe+qWDTMuqJPP6HeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3vK3tkK+; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+P2oyD5kUY8C2HhxBdkFnbElrrzkbVWwlf6mS/Qomik4xPc6j0k4L6n0HfX/M/tYnyoML4HMOa6Vl0mf/QNXUwx3OKXj8JGSkyAmKslGERgJteLeMK3mC+yu4EwA+Fc0DGmNaMP27dVnjST+F+HzwLA8hvBz6sGH2CJbkRmKPivl8rNzSKddbpNzRgdra+GMDeBP4DVI87DmWNQm3uuXa/2I83/i5QDuOny/m788o5ZyRXf3ifNJtzHQYxUf84yxBRlYExZcHv4JkWGPPqyFHKl1KDyJ5+5hMX3App35t4+RAIcVW/tBsOhVCPXIKiaNyg+55Q+w/aO4lcKM2Z+Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b77S+XvBE3UcdyMfp2HyJDwqeGZ6H40UJfg/Uwnyn9I=;
 b=w0R8GsYFNjsYxVE9/2ULlh3zqV5PjYnYCMGlkfY6ePn3oN4l7Ah+6UFT1wrLSKfDIsuO0uiPrWPa2XhoOHwyio1GqRGT1KG+Db7/0FjzB/eVaWONDP1zGk7swj4aJa9KZpze8bvQvcbH7N8WXpCzHBfb05KVuOZuWTde5xQXmQhzJ2xDSQdwLeNN/r4Xtiov2hSW9BvphNbZ9zERMTpXZ7YzZuf7LAMLHYSuGP+HlCdy1bCZT5oCDKLPGabkc7ARhU9iV6psBqG42KS0MAAkL3wPdvTWotCnktKMmJFPy87J15HgQdbLXDUt7gYKEgSjP+kPLF3rckn8Ocw7dOl3QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b77S+XvBE3UcdyMfp2HyJDwqeGZ6H40UJfg/Uwnyn9I=;
 b=3vK3tkK+psFux5bBMhgTmGAK48Hb+RBRBbBIbNLqtI4eqy/xD9KbRZgtjIT9MVVPl2eVgJuadj6V+Czh8iKQnq/JoFbxLmROOAC0Od94HSmORyAsbmX8HIfCPqSz5uAiowhKnj+AHvvYOE7iRDkMqHQz8007euVfcrheGbwJHUY=
Received: from BN9PR03CA0122.namprd03.prod.outlook.com (2603:10b6:408:fe::7)
 by DM4PR12MB7502.namprd12.prod.outlook.com (2603:10b6:8:112::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 19:29:08 +0000
Received: from BN2PEPF000055DD.namprd21.prod.outlook.com
 (2603:10b6:408:fe:cafe::61) by BN9PR03CA0122.outlook.office365.com
 (2603:10b6:408:fe::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 19:29:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DD.mail.protection.outlook.com (10.167.245.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.1 via Frontend Transport; Tue, 22 Jul 2025 19:29:08 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Jul 2025 14:29:05 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <bp@alien8.de>, <yazen.ghannam@amd.com>, <linux-kernel@vger.kernel.org>,
	<avadnaik@amd.com>
Subject: [PATCH] EDAC/amd64: Add support for AMD family 1Ah-based newer models
Date: Tue, 22 Jul 2025 19:27:31 +0000
Message-ID: <20250722192855.3108575-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DD:EE_|DM4PR12MB7502:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bf93955-66d9-46af-6172-08ddc9560742
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/6ShBrAgdxBMgXJOpVDj+LjrvRAhIfeIQ+pyen2xZqRBISSyv2HzBLRAJGTF?=
 =?us-ascii?Q?MtJXldIB+dspf90rZ/k8lOS3skg47ispk2ba+ojU049Rk/MJlAHJL+ib7Dar?=
 =?us-ascii?Q?Iyn/amEhmEFCaetjvrPg4ZIXa86tJeujcXurRZczlAFHRZdd7/lPbakUEKb6?=
 =?us-ascii?Q?BisO0u/rbJdD71Q+1/fyUO9AfanbUTz3KLEysnZV51N5kUOBv9FcbUu4ZIak?=
 =?us-ascii?Q?3iFBOZrwujgHfNI65lV6UHrRRywkuaMs4T8nSLCef0lXoakOI6qufmFEtLAu?=
 =?us-ascii?Q?qVcrazqGDIxbI92YuUUe+xizIkyMxxXt441mQakSOltQQtH8O5/h7LxhIIlV?=
 =?us-ascii?Q?INKtMKYGAv2NtwZ8cUF8MxEQNGyEXwtXuICAsya7s3mGd9GuzfJGBUtn6pA4?=
 =?us-ascii?Q?tPX1dLHCkfglXb8xJ94A3hrNkySix6rJ3G/nls0U9ku3ye49kYSz2N0RX1LZ?=
 =?us-ascii?Q?mjabQ9nxVkviArAJ+vb2G6VIEkvDQbjD8cGhwa06MTXTs28EojZBjVDW8g4V?=
 =?us-ascii?Q?Fbe0+8da5Cx/xXOKOdDBWqDtg97x3/vCIX+e+VljAJIqPj+bvBMXMiGYOWJo?=
 =?us-ascii?Q?BL82+Blj7tkzgR9AOiyRNALHaCxDwOnBOQ5DmCglXVXYAbM3jL5CoXLWiKho?=
 =?us-ascii?Q?Inx8Sr1Tw6it+yDugdCW1pG2Btxt+s1oA1ewHdFBeVtuhqOK9ZuVftWQWxZ4?=
 =?us-ascii?Q?jKzdgeeB+imz6g7cALC/5JMgPdFhZly62kKiPg/FpiHA6VfGY8OshO4nrR9C?=
 =?us-ascii?Q?yv35Cr447DedHeWttgJgYZbN42KiWY4NnhZbhxhsbgi0DoV8GtslSe0iBYhw?=
 =?us-ascii?Q?JVkajNhiEX0zy0YdiMBUFzDeBw5zCkl92rGcF1yEiF0echlBdOTOUvqCdLxt?=
 =?us-ascii?Q?2vaLiG7B2bNVyNXNF/KMjgkFOpXaY6otp84ocogY4lxcQdNdNKHtJ2ffUd7e?=
 =?us-ascii?Q?1WsoeqUe+Wlxu5TGk7xJZ5W10E8YQEaH0xOmmtBzmRFv4t247BrwmB+9+T/x?=
 =?us-ascii?Q?3yzO8nNt2mz7EyRBO/QiaZCqAW40YaMG+GjWB1XZlVwU5ixJBlU3yTIsZyWH?=
 =?us-ascii?Q?8u5t70ZqtNqf7Ep12M4kWeGn6gXUsZ+1sQMXDtuse+L5Jn1pgR8R5uq7uQ6s?=
 =?us-ascii?Q?ZqH3Dmrh+hhdL1IAZ5AW41RHWupfeSQ3Q7d9aCX9PZ/tcoPz157QteaF7gzv?=
 =?us-ascii?Q?dP5gBk7blA2uxAZVu5GpbZkPMAQTeN7426k9lgnyke8t+jEydo1atps59GpV?=
 =?us-ascii?Q?XentayCTDC5ea5fUxKAtLDVaMZZTowcyFO4GH5g6VBbAVAWb4dHx5jRjvf40?=
 =?us-ascii?Q?qof5oP2tfBhVe+v9WJ+rQddy6q34JucUNO6MU6Xwo5vB/w8JwFOe+hSiCpZA?=
 =?us-ascii?Q?kvFnBdN0wX3h5hVlEH6RTnKWWXPJ1LmfVOfLZFAqYSJDushzDRqKk6dpyfIt?=
 =?us-ascii?Q?o5Qkssz5bBduQzyxdYbh7El+fM4oAjNQEc0mqM7PmbdfIlBbv6AL/zHKLNPQ?=
 =?us-ascii?Q?K3FZ1RnsbXpEnvR5oZLsuz7DPPPljJSsKHZV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 19:29:08.2239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf93955-66d9-46af-6172-08ddc9560742
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7502

Add support for family 1Ah-based models 50h-57h, 90h-9Fh, A0h-AFh, and
C0h-C7h.

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
---
 drivers/edac/amd64_edac.c | 20 ++++++++++++++++++++
 drivers/edac/amd64_edac.h |  2 +-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 07f1e9dc1ca7..06ae6750ca14 100644
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
+			pvt->ctl_name			= "F1Ah_M90h";
+			pvt->max_mcs			= 8;
+			pvt->flags.zn_regs_v2	= 1;
+			break;
+		case 0xa0 ... 0xaf:
+			pvt->ctl_name			= "F1Ah_MA0h";
+			pvt->max_mcs			= 8;
+			pvt->flags.zn_regs_v2	= 1;
+			break;
+		case 0xc0 ... 0xc7:
+			pvt->ctl_name			= "F1Ah_MC0h";
+			pvt->max_mcs			= 16;
+			pvt->flags.zn_regs_v2	= 1;
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

base-commit: 1fb0ddddf5d139089675b86702933cbca992b4d4
-- 
2.43.0


