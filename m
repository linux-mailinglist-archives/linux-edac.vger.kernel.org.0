Return-Path: <linux-edac+bounces-2765-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E41AC9FFD03
	for <lists+linux-edac@lfdr.de>; Thu,  2 Jan 2025 18:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A4F3A31E3
	for <lists+linux-edac@lfdr.de>; Thu,  2 Jan 2025 17:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D492E1AF0C4;
	Thu,  2 Jan 2025 17:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qi4LIbLs"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2057.outbound.protection.outlook.com [40.107.101.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10E41885B8;
	Thu,  2 Jan 2025 17:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735839912; cv=fail; b=BNRIepGvjE70XLd4wVeyflKwnBirTghFke/SwNbHpqC1LYR3ThZWeCCznngaS8zqP+1em60IXHbqxowPoywYBwWoA81hImCp0kgWEWZ4AUgU1dx9HMMuKVqYuAVLQ/7FjwZbtHdEtEAijQUgQn5xLFECkzcn/yCSvXnB/2XIitM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735839912; c=relaxed/simple;
	bh=YV3HR6KuaaWBxk+E70wKothXhlkO0gnLlPp6Ui1efKU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ahPVQUkaH57A7sJil7gWLpB2v4wpXcQX1fuRReAt56wsTRq+n9nauttF9amFuVJ+JX+kxud8XQTu363luZG+KyIGTpcnsEZijA3U2OhUQp4fy4xc83PMeCdxaNtvBWry6FsN+UZ7QaC2KWJQ22qv28qREFCHYd/MnW7CHqF5R+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qi4LIbLs; arc=fail smtp.client-ip=40.107.101.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m84sbSb9Q2LMFyBvSUIFrk1UQbZmSUppQOrmyaVtzPavu0hdQ2BuWjNQQg5oHpI6brk6kckjB3rHEgS2h7m5Gqz2Eb8OmgEt1H1mWx0PJb0spyH83O9aTAmvGs6+BOcAydf/kxlsp7rYzrfpGegxyDBRzwmMZzrHLQhfbZu8/peF+wUqCATwWkjS/dIZNg5xN524yzWN5aUPNnvGhGzV75qE+lF3uDwkxWukqgqZJZELl8Sm4RF2Dnof9RjquJ7qiL9SxTV6nYmjdax6Viq4KO/Don+4n0qbBbVEgFKVlL2rhF+PDVn5dM98piebj8ZfV6wBOJhv8IxqtPpXAG1WKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jq3Xz8fmwKU5pyamx12DqEWdXPh13x5lzP25iyGiFOE=;
 b=MxK59go7S+pD5x28gA3QqF3ysQBVJADnJZesqJjSAvfBhzsKBiTOQtu6KrNlE/7/FRMZQWxDfcU+ZLwBI+U9GxtMOjSVeD3TFi0yv8SxrRINRYMzfn8gjeJ9pEa8au1iUdrr8TwJo6cXHd6sjsYnatEy60P9sG0q8eF1C3PB1wWGFyVTMR31I3UE7va0E2QFLQiglu2PkRtjQFdT+LvWDPhz/x9DU2ihLGe2FFFU/MHG9Vb5KFcdR1d99E2rQRF82XjGHBvFERXZjkbtF7sDPdeehjzpciRnLbKnX4Q4Pm0JsjVznfhYBiGrrjTzvX03DYqWEYtjaKtvIs11lGoEug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jq3Xz8fmwKU5pyamx12DqEWdXPh13x5lzP25iyGiFOE=;
 b=qi4LIbLsOEaV3+BCmV+zZAD8GZoG9AHGgOl7wd1EEzbQLXls7E6W8hR8AEJNSE1ySuyywitTT/gq32+9vsAHsOnDfmt2b/NXDHuIXQoXPAgfI7DLaEbAK8im4qcF6CSsX0hd7UvSZtBRscQ5iFUu1V6009gHP4udWHIser1Ndlo=
Received: from SA0PR11CA0175.namprd11.prod.outlook.com (2603:10b6:806:1bb::30)
 by DM4PR12MB6279.namprd12.prod.outlook.com (2603:10b6:8:a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Thu, 2 Jan
 2025 17:45:03 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:1bb:cafe::a) by SA0PR11CA0175.outlook.office365.com
 (2603:10b6:806:1bb::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.14 via Frontend Transport; Thu,
 2 Jan 2025 17:45:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Thu, 2 Jan 2025 17:45:02 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 Jan
 2025 11:45:01 -0600
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 2 Jan 2025 11:44:57 -0600
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Borislav Petkov <bp@alien8.de>, Tony Luck
	<tony.luck@intel.com>, James Morse <james.morse@arm.com>, "Mauro Carvalho
 Chehab" <mchehab@kernel.org>, Robert Richter <rric@kernel.org>, "Shubhrajyoti
 Datta" <shubhrajyoti.datta@amd.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC: <git@amd.com>
Subject: [PATCH v4 1/5] cdx: export the symbols
Date: Thu, 2 Jan 2025 23:14:30 +0530
Message-ID: <20250102174434.17677-2-shubhrajyoti.datta@amd.com>
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
Received-SPF: None (SATLEXMB03.amd.com: shubhrajyoti.datta@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|DM4PR12MB6279:EE_
X-MS-Office365-Filtering-Correlation-Id: a4645d43-8cbd-440f-57a4-08dd2b552fb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ERFZA/pN9aKzGOzIjtp2ZThKLZpd8e021s+Pli8tagIDoFYtWYWKWOgYVqBB?=
 =?us-ascii?Q?LCZbcz3ECjC1ujgEaM1NuMGWB3OraDKhZoEkYMG/maobicRMZ3zFsdDNMQ5L?=
 =?us-ascii?Q?D+L6JUoxpnwz1Pjk2I8MEhAJJOLQWkJE8ocUtbamZvkLeci+9Rz7iSzi36M9?=
 =?us-ascii?Q?C5UUwUq3BIU66X26F8c6mEnuMutMHgZrnniNjkihleyzHiZjBSSx9v965BzQ?=
 =?us-ascii?Q?phrZKaEyruSwDXPXRv0vPNnQuX4VqWg/fvWU32G5VuXYzBSsdnJPY7Ss0OsY?=
 =?us-ascii?Q?0z4qGhp81MLPCzyUO6drvfGwxicvVfqTg14Lma22f1WwZQPpDmB7N6YUhDXk?=
 =?us-ascii?Q?cdsL3ZtWAeY+fI7gV4E1S7YP5/uj/NkTVjiB/DQ3zOxFe6cLhGo8UFAjCNWU?=
 =?us-ascii?Q?8zHJsVCnunup32gVRqLM8uS9zQtaoVMv6lAr1WCvggEVWR7K4oiCPQ7kYse7?=
 =?us-ascii?Q?NMJEAGoCY+RU9LuJ6IOXA0RdVbNTByhG+d8BwC2aeqS/mj9ZfXxvR797FJA1?=
 =?us-ascii?Q?Xq7eE2mIVxjd3zChHkphura6s6oLfz6A8PkkL4hjzi1X+lEXqWxPxkhdI/+2?=
 =?us-ascii?Q?6PwesMDM7SurNBYWwqka5nVB+X/lK9fb/QPoJlAeIwFWvRzgYKLW3Ha04M2I?=
 =?us-ascii?Q?Xpc0LtXErqwrC7QpzfxyI8lHPQyb+4yUmCKx7h8IJuIHJw2GCXjSxlZFnAP4?=
 =?us-ascii?Q?6B90gehn5vWzul69JqV1GiKHBuIfrNqfGVWqX5AGI3emy2JuMatw8/dxuhs6?=
 =?us-ascii?Q?0o9YhEL6mAdQPE1qdAE1/X+fydfPq1Opus/tNW9CucTQaeX2+aXv7Go1Qtt7?=
 =?us-ascii?Q?Aq7q9srZFFSIPgFi32ssOwKwMz8FjwTrpFf3rVWoG/RZByvdzuKKwP7VpAoJ?=
 =?us-ascii?Q?DxZrclKjIR9FJUUpCt1azPzuO3uNya9r7WVhJMMwUXbB4yNLu70Mp0CXNJ7N?=
 =?us-ascii?Q?3Wu6ZerRotqPeR4nK1AwXgxBA00d8IOpy7qJjwY0z3OFAC9bgbDRK9XDNESn?=
 =?us-ascii?Q?qboVpKhXdplG+yxNyHVt099sdl82gVFhrnRyZeLoYI+hzK6bRgUhQLIKVHkU?=
 =?us-ascii?Q?UH0gQBB305Rd9V4X0Lt8MhQYtpTKQKaHQFuMs53BY4NyMX+gkaY38MNccl9+?=
 =?us-ascii?Q?viej6amYtJkYKZDf7CzF4inyuB+Pq+Plb/Mi8aQfxqA9qAXfV1DMjxyPy180?=
 =?us-ascii?Q?K27aDTM3I9yeanehxnAOMHxWetUiEFoQwoMcv7OtvbnSaneTrwA/Y0IDjMGc?=
 =?us-ascii?Q?xJBODkfYNHlJC2T5Kq+o7GODrf2WCJLIOsIYs73MnTKwLh/X5VB0FZa5Bv6I?=
 =?us-ascii?Q?TjbWq91X/FwDrEWRt09fy7llgsC0SIUspY6Q8GvxvPy2CIdB0Lu2V3dpD2TU?=
 =?us-ascii?Q?yzQJm4nSn6daoWUJOHSO0QYuW4UpZosY2mjrSg4efdE8pCEAN9ssji59E1rr?=
 =?us-ascii?Q?uHq3gGvQV2kwm5NvNfqH2vY7L2GzKfiDbqT378qjm4fiRqxtwsTXjZq4cvm8?=
 =?us-ascii?Q?w5x92K5Ee+avMAb67I+JrbftThePMquc5EJ/?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 17:45:02.7831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4645d43-8cbd-440f-57a4-08dd2b552fb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6279

export the symbols for modules.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

(no changes since v2)

Changes in v2:
- Export the symbols for module compilation

 drivers/cdx/controller/mcdi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cdx/controller/mcdi.c b/drivers/cdx/controller/mcdi.c
index e760f8d347cc..e819049df659 100644
--- a/drivers/cdx/controller/mcdi.c
+++ b/drivers/cdx/controller/mcdi.c
@@ -128,6 +128,7 @@ int cdx_mcdi_init(struct cdx_mcdi *cdx)
 fail:
 	return rc;
 }
+EXPORT_SYMBOL_GPL(cdx_mcdi_init);
 
 void cdx_mcdi_finish(struct cdx_mcdi *cdx)
 {
@@ -590,6 +591,7 @@ void cdx_mcdi_process_cmd(struct cdx_mcdi *cdx, struct cdx_dword *outbuf, int le
 
 	cdx_mcdi_process_cleanup_list(mcdi->cdx, &cleanup_list);
 }
+EXPORT_SYMBOL_GPL(cdx_mcdi_process_cmd);
 
 static void cdx_mcdi_cmd_work(struct work_struct *context)
 {
@@ -757,6 +759,7 @@ int cdx_mcdi_rpc(struct cdx_mcdi *cdx, unsigned int cmd,
 	return cdx_mcdi_rpc_sync(cdx, cmd, inbuf, inlen, outbuf, outlen,
 				 outlen_actual, false);
 }
+EXPORT_SYMBOL_GPL(cdx_mcdi_rpc);
 
 /**
  * cdx_mcdi_rpc_async - Schedule an MCDI command to run asynchronously
-- 
2.17.1


