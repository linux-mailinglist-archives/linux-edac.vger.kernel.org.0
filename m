Return-Path: <linux-edac+bounces-1091-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF578CD7E8
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2024 17:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 941161C215C2
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2024 15:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0FD2033E;
	Thu, 23 May 2024 15:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gHIYcku8"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2DD17C66;
	Thu, 23 May 2024 15:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479825; cv=fail; b=vAyS4AEFAFrfxluAL36j1pebDAb0cYwqTtJzB3RXkaHaj8f4XQwYPN3knPhccMv+k22GBhEVJr6rKTMzSlzLYuLJVvJ4Bg3LrI3VggvkVQPlsvQfsjzzN2nH1weiTh+OnOsv+B2xtrv0mTnhpss5ARsPIkb4x9O0Mcm9ml5N444=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479825; c=relaxed/simple;
	bh=fZJTFETbJOuWv9m9uMhYY/ldaCIUNPTn6fyBtgJ45KU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hnoo/glY0ztiOb8l6COhT70ADrif2DT1gVk2CJALyGWc+kaD4ZIGt4JPn+W3lNGP63pk0Y9IfonpcHy0cGzn/3+7Z53P8VvQ8hdX5VaFa60feq5xcSDs23kdi6oIH+0tfauKiSKCZyelGsXwN/IaUm4hGqwhC7vp4UdqXVrq2iI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gHIYcku8; arc=fail smtp.client-ip=40.107.244.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMvpJNfsnV6RycBBVLwK0cJm7SnUlBseWwBF8HP0kHWx3q8GK78VYNRXIxNOGRtxS19As3vek2sKnPh10OuZJlKNZ1cy/hzXuOA5kRtgYBDqBhKmgPz5QCPjnCBv+D+fLeKaYQSpZ/ETGOkiEZZg9upezaWc0zXZJC+jn/F7fawj+wjJsXMOV6j87qB10O0lTdKGFTxPz6+180SQOXKsaFLILS4DY4soD3iMHOk300n5EI86rSs1fR0BYyhgvdMv3Aa+39tHTc0zs/mZo5aPoxpoNFyxUhEGbZqKj+bsDfiRJqAuE2HOS47+FKfc3qOxM6p2fhCa9d48VRpyqFoz3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+N3NuxYqC83BqVwYbZfUfA7651siUQ3QjgeLEkE8r+U=;
 b=D8BiMzmRIyW8WnkGHAJv/1J746zrZLfTsffyybLxhI1tpPvb9v2hh9zWCTpY95EaOZ7l7hBU9YwN2sUL27vlyaEAiIbbfIVEN6RIoV7Vt+K2oTNpmYEFd6Vx0sb4v6Gi+JxJ2K6z74DTSmzV8Vj3QryISweYXJBRaypZxemOFE2WYLnGVqf+yKhUmFy6B8yq+Po0YtcRpSUAF+xZ+NPwd+n3gNavyRrrzh//kAYDDjk3BbKJvg3YPjpgr3cjbbaFtVjPjteheUF5uV6W4aUKORyCeVGXHcrP9mfvTyhLL0xwgJMRgUcWhrkarN66WYtJNZo6xzwlrYk5+g+vMXHplQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+N3NuxYqC83BqVwYbZfUfA7651siUQ3QjgeLEkE8r+U=;
 b=gHIYcku83Kqa7Ue2NPWWgxVQADwWhX7RyyqUfJZP8broSvJPL4wbNt9suvZDHVKIh+ASXtZhKu5H4/Yygb5UMm5L/DzD8fFHJw/R/PKiJyGpzj1mwi+xUJk4FBwHzBuXY0ly41sRf/AY0csBe456S6X4sNbk2kNlwfc3PHmJA2U=
Received: from BN0PR08CA0029.namprd08.prod.outlook.com (2603:10b6:408:142::15)
 by IA0PR12MB8302.namprd12.prod.outlook.com (2603:10b6:208:40f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 15:57:01 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:142:cafe::4) by BN0PR08CA0029.outlook.office365.com
 (2603:10b6:408:142::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Thu, 23 May 2024 15:57:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 15:57:01 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 10:56:57 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<avadhut.naik@amd.com>, <john.allen@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH 4/9] x86/mce: Move machine_check_poll() status checks to helper functions
Date: Thu, 23 May 2024 10:56:36 -0500
Message-ID: <20240523155641.2805411-5-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523155641.2805411-1-yazen.ghannam@amd.com>
References: <20240523155641.2805411-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|IA0PR12MB8302:EE_
X-MS-Office365-Filtering-Correlation-Id: 7950d509-007b-451e-2cc3-08dc7b40fc1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A2HdZ8sxEh9MKFbNGSuU/SCQFb50NECrPzjd1bw+KnZTY7WH7MywgegSQvkT?=
 =?us-ascii?Q?dokLRS+MJmEq2VzfFdY5fJzeonjJaRmjmxB01o9xpJjObCOIH4TYTF8OE2Id?=
 =?us-ascii?Q?zas1nGUiAmbyBKI3giQlbru887ZdDPSa0kgrNXnIgfSQcZ7NgbDC4ltlKcqm?=
 =?us-ascii?Q?tf3qPfvRtFPb4Z1RQjYxKphvMqggpLBwLpq+XoEz97LNGiYjSfplZ71UjbCW?=
 =?us-ascii?Q?oZOEoMrsX0v+iRMReKL5bE/0iNpchaVjs5hlJ9YWnHByenElLH+3+1JDcjVo?=
 =?us-ascii?Q?D/Z4ibbkiNXe7uZbQJ7vsqhW/hCzYyH/1qxRYZfNZ6OnDHUhso1ByG3LG0xE?=
 =?us-ascii?Q?QUIJxt6nmDUAbNU2nnl/40yFj6N6Z5ZfBlnm54SWhEuMVJCK85FCFl/dmc+f?=
 =?us-ascii?Q?x26ra08gdMQ6a0QGn3BLkvbKufoOMo4/An3rSr8ihsRMox4zUstU3Heyh0sX?=
 =?us-ascii?Q?/K6NQXiy8y8DfR8jrc2mzJmc67ZNWQu1lEvv3+hMIV/vAw3CFBQr5BIuRwz/?=
 =?us-ascii?Q?EK3kqhL4XdpV8n6E+bjyJPRss2iTpNcmRpDA/lMMqGSRHBApvsue13nEq0Ky?=
 =?us-ascii?Q?yaDlSV8PUmn0s0Pdkko8j39J4x+99WcSnodsTOkeEEX12mLwq8PAtv9/KQ6A?=
 =?us-ascii?Q?EUOM5uW5xabmeuu69b77xIMoGOK7PPnQni6rusVJZYV1pMDCRkKfCiUdZlC3?=
 =?us-ascii?Q?rKSmjvafs8w7EhNBpumSqB3TtT4gaWGJbDPU1d/hfqXClB8K8WmQ3kW9S6Qz?=
 =?us-ascii?Q?Dg3zB/MxkO2sh9NXeQcj5d/LVf7+Hv5n77E5DPG5xt4CKcTalmLdYmCmUDSh?=
 =?us-ascii?Q?5xWnVgkJh0FrNenBwPJOwufph2eKf08a5nNITmkEEKr/JkMHeZJd31UPyRHS?=
 =?us-ascii?Q?XLqRayY0ZgV7AmKX/SJIG69BCJB0Dekl1WY7ERQBc8TByz4fcEjx+eONsRnV?=
 =?us-ascii?Q?UrWcrIF/4hsUPDpP8chU64uT0SP9zYd5YfDo/Qm70gaF/zvZLvzi5zlGmKkx?=
 =?us-ascii?Q?vjVN1Cak9SeAmkSx2v19KLfwtfTXt1T9Jvt6KvKwvhcgNYlE3M1RVlPStW9k?=
 =?us-ascii?Q?MfpKgkxwe2UdiN4nY1sJA5mRiQHeNv2vv2qD21lUWKFy2YT6ZTJLTZKwVxez?=
 =?us-ascii?Q?q1tjaeNQ7Yz9XtIiAqfxVa5S9Ju8Og01niZJp1lckwKNynFZ93FdEJTTZz4X?=
 =?us-ascii?Q?3OVsaobo/lIHBNH6X5pXBBm1Y6I+75h31xc38qiSmujayt4e8Oz51pnyexk9?=
 =?us-ascii?Q?cWVJRCl9fDrrEzFGNTkjyzoNEJg+d5wgLG0rDMLerv9MGjB5mJGgOEyCPlsM?=
 =?us-ascii?Q?EsOepcygdqo7fPEbcBMb9YQk5ASXP7ATLh+NsTNcFAQlmrASOXaNOOpIoJ7D?=
 =?us-ascii?Q?UHRUmpKs0tgOP5Qs5v/SBhGmqoVy?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 15:57:01.7323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7950d509-007b-451e-2cc3-08dc7b40fc1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8302

There are a number of generic and vendor-specific status checks in
machine_check_poll(). These are used to determine if an error should be
skipped.

Move these into helper functions. Future vendor-specific checks will be
added to the helpers.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/core.c | 79 +++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 40 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 70c8df1a766a..704e651203b4 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -662,6 +662,44 @@ static noinstr void mce_read_aux(struct mce *m, int i)
 
 DEFINE_PER_CPU(unsigned, mce_poll_count);
 
+static bool ser_log_poll_error(struct mce *m)
+{
+	/* Log "not enabled" (speculative) errors */
+	if (!(m->status & MCI_STATUS_EN))
+		return true;
+
+	/*
+	 * Log UCNA (SDM: 15.6.3 "UCR Error Classification")
+	 * UC == 1 && PCC == 0 && S == 0
+	 */
+	if (!(m->status & MCI_STATUS_PCC) && !(m->status & MCI_STATUS_S))
+		return true;
+
+	return false;
+}
+
+static bool log_poll_error(enum mcp_flags flags, struct mce *m)
+{
+	/* If this entry is not valid, ignore it. */
+	if (!(m->status & MCI_STATUS_VAL))
+		return false;
+
+	/*
+	 * If we are logging everything (at CPU online) or this
+	 * is a corrected error, then we must log it.
+	 */
+	if ((flags & MCP_UC) || !(m->status & MCI_STATUS_UC))
+		return true;
+
+	if (mca_cfg.ser)
+		return ser_log_poll_error(m);
+
+	if (m->status & MCI_STATUS_UC)
+		return false;
+
+	return true;
+}
+
 /*
  * Poll for corrected events or events that happened before reset.
  * Those are just logged through /dev/mcelog.
@@ -709,48 +747,9 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		if (!mca_cfg.cmci_disabled)
 			mce_track_storm(&m);
 
-		/* If this entry is not valid, ignore it */
-		if (!(m.status & MCI_STATUS_VAL))
+		if (!log_poll_error(flags, &m))
 			continue;
 
-		/*
-		 * If we are logging everything (at CPU online) or this
-		 * is a corrected error, then we must log it.
-		 */
-		if ((flags & MCP_UC) || !(m.status & MCI_STATUS_UC))
-			goto log_it;
-
-		/*
-		 * Newer Intel systems that support software error
-		 * recovery need to make additional checks. Other
-		 * CPUs should skip over uncorrected errors, but log
-		 * everything else.
-		 */
-		if (!mca_cfg.ser) {
-			if (m.status & MCI_STATUS_UC)
-				continue;
-			goto log_it;
-		}
-
-		/* Log "not enabled" (speculative) errors */
-		if (!(m.status & MCI_STATUS_EN))
-			goto log_it;
-
-		/*
-		 * Log UCNA (SDM: 15.6.3 "UCR Error Classification")
-		 * UC == 1 && PCC == 0 && S == 0
-		 */
-		if (!(m.status & MCI_STATUS_PCC) && !(m.status & MCI_STATUS_S))
-			goto log_it;
-
-		/*
-		 * Skip anything else. Presumption is that our read of this
-		 * bank is racing with a machine check. Leave the log alone
-		 * for do_machine_check() to deal with it.
-		 */
-		continue;
-
-log_it:
 		if (flags & MCP_DONTLOG)
 			goto clear_it;
 
-- 
2.34.1


