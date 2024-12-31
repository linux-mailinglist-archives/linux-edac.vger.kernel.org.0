Return-Path: <linux-edac+bounces-2758-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 778819FED41
	for <lists+linux-edac@lfdr.de>; Tue, 31 Dec 2024 07:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B17A1883004
	for <lists+linux-edac@lfdr.de>; Tue, 31 Dec 2024 06:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864BE17332C;
	Tue, 31 Dec 2024 06:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i3ENochH"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D075315573F;
	Tue, 31 Dec 2024 06:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735626902; cv=fail; b=ShcJR9N6TPyL79Ip9Oa6Ct8+I37tsRjRmMc3ST9CIEGbRQRP+gNs3HcuynGA/hXBsxxAIpBSN31H3Sn1M0G5KGZaY4NCsNyV7+nl1pxcN9wK+bw22+j1mhW6Rri3iQh6oVEdmFsIVPXRDLS9FWfpDpRAuJggvqAgqwHYlp8JHIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735626902; c=relaxed/simple;
	bh=YV3HR6KuaaWBxk+E70wKothXhlkO0gnLlPp6Ui1efKU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VFe8D8dD5zier5Ur2KeDQi1PqCXK1liWSVdJxTwT0wMweHRH2g36AxFVbE4iz8GgTWIuWQV3XYWRj2szB27zVsQ1lMeyFkI/TXBqHVgPTGUcJ/i2+Q7xeY1Fb1KzA0r41P9ibx2NfpncZFUxzPld13fFGiqBujbDQDJ2Ban+CTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i3ENochH; arc=fail smtp.client-ip=40.107.94.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9jsYB36j0rDiQIcJE2LUNf8olmxnzjUwc/paosn6iOAkYQuhUYoCvAteHNFsM0bfuSoj4t/t3hRS6o/jfh3p2mtxZXvjdh2bP0vAb3s0j+VK2mGw81jtANloDVZFcwank8/UM23i/Yy0KlHk2wWafTV18naBQ5Njo76elY3zxBc790rI240j4AlurCb73SI09qrndLl9eUvGU6mkZ6uJizg/stZjPL63HWwi+d64M+NeCkEoUIWbHI48itppLh7GBz8guEht83fp84Cy50/fB++PVR/5Oi+1zgGjuwws3cntwSScxUXTVU87/A4fXTMwWyNocdderkZAhZ2yZ5+sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jq3Xz8fmwKU5pyamx12DqEWdXPh13x5lzP25iyGiFOE=;
 b=R7eYWrmvNwlDpeoqeeN65pk0Vns39AtpqHwr9m8iWTSGJD0Ks8LsvwdYHGTtKVRkTjG5f3aJenvrSa+mde4TKF//4bkKb+XKJ7W2mLCZUIo02uUGmLHOATbDLwypW8thnZKTACcYkSjcepmAXmKM3DgFlipWG1fA8HP7gogWzRh/lD5pUD0be6rIDXriNFJQl18B3XAFiWajVryqCyQneMyH0acH0TB4pC6xUelCudrLc8bXgSfQ7V+xONuHfWApR7davWhiUUEpRWdfZrooXXFVRG6Vhi9y22VcLd6fNQgxAvX4d0EgrIr7HGb7CAHo4/g5b2A6sQLQV/W1qnwtmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jq3Xz8fmwKU5pyamx12DqEWdXPh13x5lzP25iyGiFOE=;
 b=i3ENochHNAf32DG/u2fl0JvqojS+HSl1eg3L8U9b+CkkU/rJK0LMgwISLbUMFh0+GMEDmIy/9rg7pjUswkSzOvYjxUKKUjNoWc/jO617NSjzeaMVLOFgTFHw+KIjvm8b8qSVJaIeZ2rFXsmZkC0SuoUQSGqAuMLWUrBFCDq/5B0=
Received: from CH2PR11CA0008.namprd11.prod.outlook.com (2603:10b6:610:54::18)
 by SJ1PR12MB6147.namprd12.prod.outlook.com (2603:10b6:a03:45a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Tue, 31 Dec
 2024 06:34:54 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:54:cafe::b7) by CH2PR11CA0008.outlook.office365.com
 (2603:10b6:610:54::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.16 via Frontend Transport; Tue,
 31 Dec 2024 06:34:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Tue, 31 Dec 2024 06:34:53 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 31 Dec
 2024 00:34:52 -0600
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 31 Dec 2024 00:34:48 -0600
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Borislav Petkov <bp@alien8.de>, Tony Luck
	<tony.luck@intel.com>, James Morse <james.morse@arm.com>, "Mauro Carvalho
 Chehab" <mchehab@kernel.org>, Robert Richter <rric@kernel.org>, "Shubhrajyoti
 Datta" <shubhrajyoti.datta@amd.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC: <git@amd.com>
Subject: [PATCH v3 1/5] cdx: export the symbols
Date: Tue, 31 Dec 2024 12:04:30 +0530
Message-ID: <20241231063434.26998-2-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241231063434.26998-1-shubhrajyoti.datta@amd.com>
References: <20241231063434.26998-1-shubhrajyoti.datta@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|SJ1PR12MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: 32ee1692-643c-4c73-419d-08dd29653c54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|36860700013|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BvMGt44f58iyErapvWp1jBDn2cPfUQClIBZTMCW5Ay7c6wrb4lXX3sOTIJDl?=
 =?us-ascii?Q?d7b4nwTYnn6dPp99EMNoVbhGF9Nrb6PgE1foYMqQlXoOAC73wElLwcxbhy0J?=
 =?us-ascii?Q?QMyXzz3aPflnD1QKrJ67C1UC0fHjZVE6lqTAOEYCH+8Yeko0Kvq4NUcBRs+X?=
 =?us-ascii?Q?UMimWLTbytw2JmkIJdaZ6KeMPE1rERzcFy5wJGw52smdO5CLtPsxJ9sBqAeY?=
 =?us-ascii?Q?g4NvOh/nnsqV2zV+5mNv7+oKBbk6xAvhfsoOOseBIgpvJ7TDgwQK13gt1JaU?=
 =?us-ascii?Q?1rhFnse1VvQkY6uJY40RAVbPOn53Azjo7JsBeOX6t43qn8XSFDCt+rBRuX7r?=
 =?us-ascii?Q?wd1zV4cRx+nNdNpFu95TlO7gYT9zOn6FFp57SQjSF/JtTsHOmUyenT9Vb7NE?=
 =?us-ascii?Q?LNT/oDfj2WpE7KmaWJUy9DdMiaY7GQkgK/Onl6GFcUsQGCDpnsN4L1TY5VKq?=
 =?us-ascii?Q?owmexN6Nhru/1Gc5voM1wdJa/LWIfZ2UKK24/AjtiEmiSCC94Ve4xjr9zTFS?=
 =?us-ascii?Q?zLuZErbAAwKcp0p8TpzwZ9N9PIpmCdYEqBDcRUv8AWvZwgzzvA9MRtmEJGUZ?=
 =?us-ascii?Q?5kjOYRforjLj6ZeD4X1pFfGJ7YxPCXfiQpI4KxFqosgO//7xlHd17jEw126V?=
 =?us-ascii?Q?qhdiMtBezcQLe0c8GAmAT8seGAyZKecH+RbgABmfnytZzGumAVu//g4DW8wM?=
 =?us-ascii?Q?UpnPFOyUeyGzAoLb2vwQoW4BvzU4VpzkobQZ8s/uvOco55p/rcTYGijJNagY?=
 =?us-ascii?Q?BmMZ+R6c4/LjrAXeW9SRgOw7Hg5qeoW+cgbVYmGBlJp/tK7wk/bYphoBDHG3?=
 =?us-ascii?Q?9rLIayJYC2tP9jD7/tQoGIfshY4YBzTukd7o5ojst/j5sQDUuKFw8ePyHh9h?=
 =?us-ascii?Q?WUoCLuGir5PFaAIYJ3FVlchv4vw3ThGSQa9X2bZCsMa0pFJU3aQAuFPwtOp4?=
 =?us-ascii?Q?fYdVdaRjhb4MZvAqWT7bL1rTdeQaSuyC5VVNM2mHd3BAGUCCSqS+TwFdR94z?=
 =?us-ascii?Q?iS3/06Q9nD9EPywM6KaoGCyv54rG1W7pYlqe4xhipH2ZwMzMwiPtae83Asy1?=
 =?us-ascii?Q?DjIz9162BxfnFZIqKlUxeGTGuGzaDYLr/d0YnpU6th5xgoKHdsbUgzNff36Y?=
 =?us-ascii?Q?uTEU/P8XaJDkdkuGamis1Plko3KUscJVJgPIp6u0j+qPMTqtNNYA+RskxjqM?=
 =?us-ascii?Q?MZDpJ1wFxYkO9WOFvVpvAlW1Lf4BPraL7ptnp0g9URLjDja9msQFbjCTwtJO?=
 =?us-ascii?Q?rL3yhgUMe0MADQTmGy87o2gJSlqyMdta1+2mr4md8D53KMtJYAU56GHelp+b?=
 =?us-ascii?Q?ovvkV3A+m1fCZ1kMzhashxikyc75sAeKTrQEiPVfy1vW+nJZIwul3EFbCHQa?=
 =?us-ascii?Q?MjkgDRpvUE9SexJYWdaCVz8Ht8kHOtDjalF8Ng1LsHo2hxRMJ0+F7ROZd/qS?=
 =?us-ascii?Q?PPsEffwxgjtqami7VqrwIQhZDEuFiITxxEDkUghfDkSboP04GSS35YFbMstR?=
 =?us-ascii?Q?rJg2L1fU9Gv/dYcBwDlvVSx9WwD9fXLaxlJq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(36860700013)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2024 06:34:53.6287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ee1692-643c-4c73-419d-08dd29653c54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6147

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


