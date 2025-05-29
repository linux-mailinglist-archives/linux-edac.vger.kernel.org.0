Return-Path: <linux-edac+bounces-4036-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16589AC795A
	for <lists+linux-edac@lfdr.de>; Thu, 29 May 2025 09:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39C779E79F2
	for <lists+linux-edac@lfdr.de>; Thu, 29 May 2025 07:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D02258CCE;
	Thu, 29 May 2025 07:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IMJs8JTL"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7DB256C88;
	Thu, 29 May 2025 07:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748502047; cv=fail; b=MowoEbV+KmtJKEPfZIDKcEO1Bz+uBHpoA2kv+aElhHVLuZeLJHy52lg6CkWgmwyrl+l0cNXEAS6eS5GYXw2JrQC/izlkFRjtyjpbSpYav8pByv65/d8SON96STy/kds4tvpxtr6WZjG70oGpm7VjQp6YiZEs68iRGI459iFKUQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748502047; c=relaxed/simple;
	bh=Vez8BzG1oP9sCigc5wncTG4q6hxQm+ACqOBwO7N4lIc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NaODfhBb/bLpLwCZ8eb2QJhbPVJ0OuVwKbfl2pTatBPJrPx7kX8cHhMrrgupMOUJil+ulCIBPeGnCRuRjo5a4Zsf+qyy6yLwMVmkz26/V+HhiWM4fwGK6B0656MQPxCBVTngF/81+gCrdhhP0CsauQJalTJBBRycgPpRKD75mVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IMJs8JTL; arc=fail smtp.client-ip=40.107.101.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nnL+rbbYSoF+V1x9p5fdJhLiihJpCOdAjDpdITIUf2FMFCyWNl1GbfKCLYB834ESJu0CKMaACGeZM4MZRrzpLhZIztSDga1BG+vFbfnlL/7ghnuAeL9OLyLtVyHJuc7GC6y3V3gTxQbVhpAYOtr09D/GOkf02w2zz8R/s0r5GZj3xnfqtzZ79kAL99AflTjz8ekV9Xp/5/jfUyT0qMlGKrvjGmi0xzuQbGjHLhjNFzOr3HW8j93vU1svvmeouS4y+bPK+DI/JIHLGmti7F1CachWRXoZMf1s6h7fvVOEoeGahHgXg4PX49PRsox1mhbtdhSFbbytHsLC/4loG5j+dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HD9kjndkPJXMA57cjkQvMqJYkvfQRX1CyhBx8CDcBIM=;
 b=X9UNxwc8OBJb2AjnKJfjAdCXP5FKbGtm7j4JH8PWoLYl0AQONWxEziG1Qew1iyaJpw6rPXk+BYa0+EQfVjVWWjQiNNWoygyf/4kf8QtKXITIeknSRRmBwxd6UX21kDCjYxvlINl+2D7CuBEcn011LjUtAkujZQDNvIoRv3DXjtTV1axhtHkveHy7CsDYqCiB/BeXkiyusjzfUbSlLXj4aCg8rIwWeGZem5wNwgt+Lh9Pvg5ziOs0tdeJNDdDEXOPnBCuHMiI51aDq85N0F0RasUZ8dz2P8R+jXhbKLEr/GIt6rEmT0zttA50bPmzd4+6OKYVn6879aWvmyN0Z/F5AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HD9kjndkPJXMA57cjkQvMqJYkvfQRX1CyhBx8CDcBIM=;
 b=IMJs8JTLGJ+rCehoSgwWE28oGZnYZrue0l3qxxf8/c9lnJSqwyzLuj3BO6dOfdjNtHOizDZRbkGCmQSLDRKtgNjVI1x4s5zLoJQk4k9uk94G31EDz2g1haNbUJBkPbg8/ekGgCnix9RHFJmU3vuuuWp7lwqxBtaAL7Ce/2U42y8=
Received: from BN9PR03CA0937.namprd03.prod.outlook.com (2603:10b6:408:108::12)
 by CH1PR12MB9647.namprd12.prod.outlook.com (2603:10b6:610:2b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Thu, 29 May
 2025 07:00:37 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::b1) by BN9PR03CA0937.outlook.office365.com
 (2603:10b6:408:108::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.27 via Frontend Transport; Thu,
 29 May 2025 07:00:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 07:00:36 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 02:00:36 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 02:00:34 -0500
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 29 May 2025 02:00:30 -0500
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-edac@vger.kernel.org>
CC: <git@amd.com>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring
	<robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Borislav Petkov
	<bp@alien8.de>, Tony Luck <tony.luck@intel.com>, James Morse
	<james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "Robert
 Richter" <rric@kernel.org>, Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal
	<nikhil.agarwal@amd.com>, Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Subject: [PATCH v7 3/5] ras: Export log_non_standard_event for External Usage
Date: Thu, 29 May 2025 12:30:15 +0530
Message-ID: <20250529070017.7288-4-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250529070017.7288-1-shubhrajyoti.datta@amd.com>
References: <20250529070017.7288-1-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: shubhrajyoti.datta@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|CH1PR12MB9647:EE_
X-MS-Office365-Filtering-Correlation-Id: c1fc6485-1c3b-44e0-0884-08dd9e7e83bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ulS9vSEmupb86u5IcEFCOymNc5ShciiKu72u/EvYUWI5ZMw4EKoUpdCg+UHw?=
 =?us-ascii?Q?wOXJfHBLeDz3uU+nFfa+Mr+mHeD03YKrah+aEr+HrBsJRTcjvBjk1MZrfovq?=
 =?us-ascii?Q?f0H5dey0UX4PtTSk2qzeDoX/WQ08SPagePs2zryOltZLtAJNA3H+XHfdkiR9?=
 =?us-ascii?Q?JfALDX1KzdruZVlLtX9OyvzGEhV5gwbSF5ONvwc1iSQCjE2ohMqgiAtV/p73?=
 =?us-ascii?Q?eppuxyU8UpQJ1WD4OZDXpjJNWBBitSRPJB6w7fhQT6RtspQ3h2hs3mNXFnwd?=
 =?us-ascii?Q?6Ici2Mb20OuGhtzNg6qb4E07AEGVHS3RcK7P0J588lNI5fU1k+dbRbH4vROk?=
 =?us-ascii?Q?EAtggd0eD+TDama4KwVmTo7u1RB/eU5ChmBUstL83aH0HEfJkDn+07adrAMt?=
 =?us-ascii?Q?HElvZb09MfcGSakrWTBwvIwpr0KBHw+TDBn60rYtPz/7Fk9ATQfvrSr+Tgap?=
 =?us-ascii?Q?yjToI25FK4j/ArePfuz7Ovb01unqMid5yk8EiAD9Ek/92RtxQvTuVawGd6y+?=
 =?us-ascii?Q?pGZsv0jjfBB84rsw7uAckRPHXDAUVcHn3fFZujvjUNu6F99Yl00LYcGsvSK4?=
 =?us-ascii?Q?mllP67jcpjV2QSswYo29OLrq1QbBbTZEGYrAT6fXkFgQ4WzLKcebHV57q7PS?=
 =?us-ascii?Q?iev5Arp9zzb84Red23TvvSZq9uWMPQnKVotQi4ykjo3swIsWvDM5qABoYhRk?=
 =?us-ascii?Q?hHAeWJmsUf9i+v1n/vaBoLh8SSQG/HBZCy5LJhH7II/6osS1+a0GiVqE27XF?=
 =?us-ascii?Q?6xLZKNHuAqNhsJq5c2QK0cK4f77ci21D3qdO2HBoMp9TyAw1Z77r90c6PK+V?=
 =?us-ascii?Q?9yWwcdFjs+mU2320iFw9RSGokwCt7P8rm6Bpy4OohQg8Q3Vksbyij3pBiC8x?=
 =?us-ascii?Q?NLs0NtPs2CUn4Ng4Ng+BedD7YJsjPAaWejECmHmApozpCajZLn7Cshma6Sth?=
 =?us-ascii?Q?AQ34A2cKQPN2EeTTDmKUv55hOcYVMkj5nEnThccuhfm1Lm0AF4DnCjNnacuh?=
 =?us-ascii?Q?u3/NfDhDuTH0OW6XQvQERCLYm4JCph++B7SzSntFr/hr8PVHcjRsv7Ms0tpS?=
 =?us-ascii?Q?+U/3W0puk6U3MgDIM76YQp8GxMO/6/a/jtZk4PD1SitG7vCE6AaE6FXa3yV4?=
 =?us-ascii?Q?EQaig1gINgb8CiCF0ny0njbXs2kkXcLuKGo7HfjsLOYr64gv7XtgfrV3Po+z?=
 =?us-ascii?Q?9rDleur8/E4PCYxqdYtY3xzNaXubgMDmv7Hd0KcZrUfdypV81qvDe4vxZeAz?=
 =?us-ascii?Q?7ErpKWYR+UQPwNaJG8USu5V/iBB/o6Eosjq7ZRLCz3Xn7hdWQgecq5nPNV1Y?=
 =?us-ascii?Q?QdMaPot16AtRRw5KSoAvHNJAFmNdI30uO5NJYVIFKRwWrMzPJp3Sf99ywm5Z?=
 =?us-ascii?Q?jmaSQHnlG8D5IlWgKjXW0Hr/j0dfAfd69Pn5AszqYn6FNWew8wOtIUvdbceJ?=
 =?us-ascii?Q?n+KRQ28+FO/woAl+Up6VpxncdekS/91YJY27ba0xHJNc9DANTyLV7yNpHVQu?=
 =?us-ascii?Q?VANSFRMiORXzd41T2bsCN5EwEEJeUqiNxuHj?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 07:00:36.9301
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1fc6485-1c3b-44e0-0884-08dd9e7e83bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9647

The function log_non_standard_event is responsible for logging
platform-specific or vendor-defined RAS (Reliability, Availability,
and Serviceability) events. Currently, this function is only available
within the RAS subsystem, preventing external modules from
leveraging its capabilities.

log_non_standard_event is exported so that external drivers like VersalNet
EDAC can log non-standard RAS events.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

(no changes since v6)

Changes in v6:
- Update the commit message.

Changes in v2:
- New patch addition

 drivers/ras/ras.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index a6e4792a1b2e..ac0e132ccc3e 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -51,6 +51,7 @@ void log_non_standard_event(const guid_t *sec_type, const guid_t *fru_id,
 {
 	trace_non_standard_event(sec_type, fru_id, fru_text, sev, err, len);
 }
+EXPORT_SYMBOL_GPL(log_non_standard_event);
 
 void log_arm_hw_error(struct cper_sec_proc_arm *err)
 {
-- 
2.34.1


