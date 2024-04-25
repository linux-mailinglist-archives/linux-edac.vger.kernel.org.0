Return-Path: <linux-edac+bounces-960-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1DB8B2184
	for <lists+linux-edac@lfdr.de>; Thu, 25 Apr 2024 14:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30259281EA7
	for <lists+linux-edac@lfdr.de>; Thu, 25 Apr 2024 12:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9778512BF21;
	Thu, 25 Apr 2024 12:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s6xoGj/p"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338AF12BF17
	for <linux-edac@vger.kernel.org>; Thu, 25 Apr 2024 12:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714047595; cv=fail; b=rjMV/s3OcK32Ay5vg1AceEVtVIQ2iikbkKicvE0BEgcga8/v+J4Ya7P7ZD6jZFoeTGSKKVlIiNqDtW0ejR5vJTQYWQGGcqlCf5ZKtzEb5IgqOPNbnIE4Giv1tB4yYCo3XDwyNlydamU43JG6oTDT3gF2bI6faLsfYvSSRgqJz+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714047595; c=relaxed/simple;
	bh=L4heLNz8VZ58BD8zCESbEgMIGAHfkXQfx3xmSNuMxV8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L5VBLBO9VpdweyX9XPMf1js+MlvVlD9j8gcI7PA/dwPndl9aFnRLKCrhYxVwF0Ju0gOaH5KU9o1dXTn4Z0OOten8XcYhVpNBSwq8GWT0dNaP2hCkjWAL+XHS9vQSrpxxkteWCiTL6zTachE6a+M3JeaQWjRVxcUispx7VFPMRIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s6xoGj/p; arc=fail smtp.client-ip=40.107.220.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFQ6jtT6DUFN1ii/gNlox8j8iKuiWDB6ugND/LeLXy2xOfRuSpxCyQxGGCvy+pY+USRG0UzI3wtCUn8LPPrqdXL0KncU1plR9n/2rfM1/DEWwMkmsxBOTJpBjXL3rgSu7f26WPciHpHbRmZzTWhNLQJRbcRxhGbkvhTV6jv4yx37M4Bh27PhVZnQIX6c6qt11InPeFyG5jUOKfWhXgPkGO7gapEfzvh2xglQe6870ZZsFifGI/c8aUoVWX96+VD0cXoVyd1pHjvkN8t9egqfoRYTuWxJb8JBaRO+ok4a2y5ztbexffHxDrKUFXiBp4a35mUT6hTcG7AU9nx1O1xxYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3ovqARuJHVzyOfwqV25psy0p+/hawmJgusINQa+1EE=;
 b=IXUrJCM5jANo0BeHK1nkt8CSpWx5EwKthzFkQQMqMuhw/6Fl+cPpY1hgB0pKixzhFIJwPzYwg77UaFTI+c6+eaBDnPFV95wzga6HH01ELgEY+eB3kpJ1BA9aEf6Ej3FRCOIeBUlgU7b/0M6277lOsMYAqUClDz6c3W/+GlV+B/Kir6Sm2S84zo4DRn/H/Ubn0ysk/eDbh4K+DrbGxx4nJPbf1XEAkvPP1khwo24XW8gAR+T/gwhaJzV0CJbivJWa13GQPX3krwo5373ZYAncCHea6wULoS3Uz/66OGrv88R1nLlC2qrRvjqe8q0g37BsA91sDr9+SvXkw6rcgPtOtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3ovqARuJHVzyOfwqV25psy0p+/hawmJgusINQa+1EE=;
 b=s6xoGj/pNd9XRuBeXz48UviYCNJZA5Et3uS8cPE2Oj64NPlprLhzjyHxreEsjlpe4MoohnEooYKpRGc6gBcvi+iTHxAqkO7HDoRzT3+OuXCgYJW3Doo+rjsFNrcesKvG2Cg8Jmav2jNytoQPn8TLw10ddumQ9dIOr/zmlKw4jIA=
Received: from BL0PR0102CA0020.prod.exchangelabs.com (2603:10b6:207:18::33) by
 SJ0PR12MB5610.namprd12.prod.outlook.com (2603:10b6:a03:423::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Thu, 25 Apr 2024 12:19:51 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:207:18:cafe::49) by BL0PR0102CA0020.outlook.office365.com
 (2603:10b6:207:18::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.33 via Frontend
 Transport; Thu, 25 Apr 2024 12:19:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Thu, 25 Apr 2024 12:19:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 07:19:50 -0500
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 25 Apr 2024 07:19:48 -0500
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <git@amd.com>, <rric@kernel.org>, <mchehab@kernel.org>,
	<james.morse@arm.com>, <tony.luck@intel.com>, <bp@alien8.de>,
	<sai.krishna.potthuri@amd.com>
Subject: [RESEND PATCH 2/3] EDAC/versal: Add a NULL check for the user passed values
Date: Thu, 25 Apr 2024 17:49:41 +0530
Message-ID: <20240425121942.26378-3-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240425121942.26378-1-shubhrajyoti.datta@amd.com>
References: <20240425121942.26378-1-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: shubhrajyoti.datta@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|SJ0PR12MB5610:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f3418cb-9c19-4679-8c86-08dc652201f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G2OTyQh7dZoSIveqW7Xb6TyFIP7lU9z3UYuoc3Vb8bKO3Sr0YVcdFwaBY3QP?=
 =?us-ascii?Q?iNW466nFDC+5aWl5OhZvJgk5WPHZhgio3RPCfYi1cDVTLKiQz4sQHXojUbmZ?=
 =?us-ascii?Q?uO+KqE5ruSVkJRMe0fuw+QGslxMA7U79hnZ+ICqI08HwvPiS5rVnUMWVNlHu?=
 =?us-ascii?Q?DrKToYJ+SJIzv9qIdfominaIGfcoMZFoufcmD5bi2s4Cs/RrU8ByR8T9Bjlg?=
 =?us-ascii?Q?h1hENs+/c8miQk0MK1m00rfKJ811paW2XhSydHfoCyBceYpDwGUP0dzHyD8Z?=
 =?us-ascii?Q?BmOH/ZZGY+A92N0sZ496JsvXeNj8+dB+XRXwoWTOCzbfT7DrFy55Auvec2U/?=
 =?us-ascii?Q?SfHfChwqsgaMY9StFplEEdPKsjyu9TG/gi0C0naKVhrrTom7l1wtp+r3VwX8?=
 =?us-ascii?Q?qA+LchZ9oeQKccnAaDYjkQiAMwWAqOlt/7Qati+YW7S6bc6I95tVFahwsakR?=
 =?us-ascii?Q?9aYpju32ulL/FuFtGgTm0CiCKTSGVV94OnPR5MIMAXR3pHuXIi0YRqoIaYW8?=
 =?us-ascii?Q?7f/GQg9DqnCzXekICp3fum3HT8Q/g92xhRQKKtfdwliG/C6uH1T/bHlYDCwb?=
 =?us-ascii?Q?OFgIZ9xl5HACfAzKdtHudT1XD4Ciup61hPmMA5oL02qXC08ml5/ijZQ8WaN7?=
 =?us-ascii?Q?auA9lcO2dw0czTzm3ior5pywaUjam0ZI+XxUkeyofCYW9pUvWgMvE42GBQn/?=
 =?us-ascii?Q?mxXjqHBoHJ9JF2NXTtORtM/daqJE5zWio7X5kGMVirfmt03Dv05mVz3d65f4?=
 =?us-ascii?Q?Is0cd4Q0C8u6EaJNa9tCWIy/FzODs4cb9NNr8XBONcVVyhPwJ9dLJEluGwWh?=
 =?us-ascii?Q?pqFniVBib7UnJs60kilyTxIZWWSn1oPOxIcDW2dhPpkQq3z8fBvQT37TNMKc?=
 =?us-ascii?Q?f7M7mDR+1Enjx76IFg5pHQze8XmwYnMYh9MGmSCROzvbuMXiJr0mHCJAQwD7?=
 =?us-ascii?Q?vyib1+zXusM7PaEQf6lWgZAWb9Lf3nlBeFBDKKCk0duaBm/RfKPFqDYarH8r?=
 =?us-ascii?Q?UnwAkcG3A5ODCyPBW9tSGPMbSL2rC0yfZObsRfA4XUPuGvaMtCoL++vFX8PQ?=
 =?us-ascii?Q?f0YyTu1SDHBSIzYGLyvswf4RKmjKcw0bBScgbT/kX5PIkNEdpz2lPAQiA9Uk?=
 =?us-ascii?Q?+fq257joQYYVxNhx3pU0HvG5MMsjxKC58skWb5STzApKkknjtM2z/7hTWX0x?=
 =?us-ascii?Q?jauW6St1xM1I5QcIC7MKuCjh3SEzrn6MoZv55ZO6Dr5gZ3uBqy+AkSIAT8ui?=
 =?us-ascii?Q?sxNQCA31d9oLoEWbg4RvTOOqxdqHcFDDZSg2Bkd7Sy2V3humSYlnsuK3PYML?=
 =?us-ascii?Q?rZhRdl5JPTyQNns8VzOrrHuIceLfbki48G2sewS+4I838A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 12:19:51.5421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3418cb-9c19-4679-8c86-08dc652201f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5610

The function inject_data_ue_store() lacks a NULL check for the
user passed values. To prevent below kernel crash include a NULL check.

Call trace:

kstrtoull+0xc/0x28
kstrtou8+0x2c/0x7c
inject_data_ue_store+0x10c/0x24c
full_proxy_write+0x60/0xb4
vfs_write+0xb0/0x374
ksys_write+0x6c/0x100
__arm64_sys_write+0x1c/0x28
invoke_syscall+0x54/0x124
el0_svc_common.constprop.0+0xc0/0xe0
do_el0_svc+0x1c/0x28
el0_svc+0x34/0xb8
el0t_64_sync_handler+0x100/0x12c
el0t_64_sync+0x190/0x194

Fixes: 83bf24051a60 ("EDAC/versal: Make the bit position of injected errors configurable")
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

 drivers/edac/versal_edac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/edac/versal_edac.c b/drivers/edac/versal_edac.c
index 710325381d5d..a1407a399ed9 100644
--- a/drivers/edac/versal_edac.c
+++ b/drivers/edac/versal_edac.c
@@ -975,6 +975,9 @@ static ssize_t inject_data_ue_store(struct file *file, const char __user *data,
 	for (i = 0; i < NUM_UE_BITPOS; i++)
 		token[i] = strsep(&pbuf, ",");
 
+	if (!token[0] || !token[1])
+		return -EFAULT;
+
 	ret = kstrtou8(token[0], 0, &ue0);
 	if (ret)
 		return ret;
-- 
2.17.1


