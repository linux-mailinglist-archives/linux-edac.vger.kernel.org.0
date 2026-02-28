Return-Path: <linux-edac+bounces-5756-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKXjBQP3omm48QQAu9opvQ
	(envelope-from <linux-edac+bounces-5756-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Sat, 28 Feb 2026 15:09:07 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E141C3742
	for <lists+linux-edac@lfdr.de>; Sat, 28 Feb 2026 15:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91E36303BB15
	for <lists+linux-edac@lfdr.de>; Sat, 28 Feb 2026 14:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4F72FD7C3;
	Sat, 28 Feb 2026 14:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="osgogWPo"
X-Original-To: linux-edac@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010042.outbound.protection.outlook.com [52.101.85.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326F61F0991;
	Sat, 28 Feb 2026 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772287724; cv=fail; b=RGFoPiyl6E9h/E2Roiv05n3XqKuwJrzjeX74XGjA48aYyb3RbvJOelIb7hTI5H4cX7W9mMLXOXiiwz55I/7Sauv+0FN5YVfAEg11S3rCFX5oU42sPMKCNsom/GVfIWYnNKIouSAH3d1eE8sZmTggOjNXbzmb9HzczhFM+Ms7GWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772287724; c=relaxed/simple;
	bh=wdSyxoXWurH8vKkavgeU/QnPvJUBa3sr2RZJvts38GM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oXUCSzojaom1b3q5X+IZ5RaDoUgIvlL5WmotZBt/uXJdz2fgg4ZvK5PLCSdp9ZoqvGYtZC+8GeZRRDbCbSw4jdSVKoa7Em6M1RkgB0+SsafmxcyjWm5maYjy2w5/IGOSpyqh/n4+adbArQA/tkQTcJPlVTzHye4bql5kbfwLtgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=osgogWPo; arc=fail smtp.client-ip=52.101.85.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWsfiAh8XQedOjJSfkFwL+Xca9sBg1uhaa/plH8FKP2H2HRbA/EdY20e17JxwbYSWGJ9YUHe/TbVqA9neX1WyMR6MNjy0Ws+qJ28MccRO6hYNoxq3ILvshtbOfs4zz7WGbrCcwOWemOCbY0qUxjS7QMPfqheK0kHXeqHcERiLnJe2LI2Z1tLT74+D8YPY8LG+orVVyNTfMcksdafi14EraM1sLhsv12s4sw4wxSWAfY/A+kgzsXgMJnCO2sHy0borR4Uf9Vo9qIe/wQVZeo/Kdq7uM7MsRK1LWNwZ7oaluHuiyyq1Quf6a40aT2FKYhld65Mz2rhnpPyS2Xuy56/4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVOgclfrRcUaKT4GpsYyjm7YvngH0pvaNxZ4myi1olA=;
 b=I5KDpR+zr18TqlOaks9tDcHyhlhn8bXst9kuzojU753UTfvoLT4dEem1xg9Cx5nH3zUKPgwnFNNH/tQSmoApAzfaV8/u1xQ5540XMa4Eufe5Pkp4FBVuIZtyolqaXU4j5rMAhVLXHEcrnCM1YuUCRxyYmq2wEHxCzmV2cSOXzuWefrHnXRYBk271qifmaN+sFpy3rS3cQ24VqZj7kg/mwr71bzQTDb0AS2xj5iH9hUVPx4f5BiOMe1Okt/7QQxKTWmKm9YxG67vN9kVhIMyelgdNwNL7PGDuHx0zf9nQGQDPnOpTusIQSmaEVjcgKbUG/TEJoRmI4WWOsH9kYWTL1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVOgclfrRcUaKT4GpsYyjm7YvngH0pvaNxZ4myi1olA=;
 b=osgogWPohL1LKqgE9F5l3nwpndCDl8HnzagqXGvg0G+LkRQ72beiu25X7O83bPjkF3d71t5jcI1mTAsUkKZ4GhDubVE2+EI53h8HYe1N5wISwy9sruiyJ4+b/fp15aPSFahRUzWKphuBvqbJ5DhvkXzd0WqnGutdzQCdCOEOZJ0=
Received: from DM6PR01CA0023.prod.exchangelabs.com (2603:10b6:5:296::28) by
 DS0PR12MB8456.namprd12.prod.outlook.com (2603:10b6:8:161::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.18; Sat, 28 Feb 2026 14:08:38 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:296:cafe::e9) by DM6PR01CA0023.outlook.office365.com
 (2603:10b6:5:296::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.28 via Frontend Transport; Sat,
 28 Feb 2026 14:08:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Sat, 28 Feb 2026 14:08:38 +0000
Received: from yaz-khff3.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 28 Feb
 2026 08:08:37 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	Yazen Ghannam <yazen.ghannam@amd.com>, Bert Karwatzki <spasswolf@web.de>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] x86/mce/amd: Filter bogus L3 deferred errors on CZN A0
Date: Sat, 28 Feb 2026 09:08:14 -0500
Message-ID: <20260228140814.76375-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|DS0PR12MB8456:EE_
X-MS-Office365-Filtering-Correlation-Id: 12af8aee-01d3-436c-5c6e-08de76d2decc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	hsapjUbjOFhYEJ0E0uGF3wrDvcFzRQP7ntBS5xfxP+9QyrkUVMMCYb4ziNkP4ywCiPY8PZlgQHtlmGTl2p+hE/Egg65hlJBjpxXHzNLFX77BUcFMj+bUDEKZYWovWFTGhgOjMG9ZeqW5KqnNRGWgNFPT/ioiRBNefXwyxrt31Z4ZMq/mJJwSi5PHsiYtwIVTLV/qwY2hVdgOA7AHN/nXCTxDtuErNpHyfgauiZAWYuwWjsaoXCbVAjs/k2rD85Ls3Hy8aOsHwS+wBCbMKajwXWlhE5SvusjZyLPMYNzuRssfePtQcgtbZn2vErCQCToTglxYYvs7tmMfLVCoc296I1HsLInHlgu+hty5sVgDbI5npmuxpP5oSvctU+7+SriutxW9ADaI6+fRfcq1YM2fmb2/pNuXLrJrWO6aIH/sX85g+qzhiRcCa1bFe7AKkbRxVUvBRDiYVxJMxEmmdemP30uNo+B7jHIlLeTa6JmZkj2B3ADYi4NYM4KvBJmHOwPZGQIDeOhiwcGC22mQnZKmExA3FK5Rdk0t84MVbgxaYGQGZsyxJSZtIrkrX9iGRwkuS45REYetD8APc2n64RYHzvqye4PqBQLCz3X2uDBjZju5p3kuw17ubjjJ83b50NmMgSQA4cFmbmYz3r6qB0Dd/1FeWJXr4+V1HNJxxv1EGleaLdGoDUVf222rr/67hr20b+ixiwSsWHDGXD4AniuLfGYdYumxu12Xqeafo/iGcO240p5jlVc5QS3lQHwggVItdMGTZJ9hpmrNbwgegILr8qYubDLbJzr/hu+VG/RzX+o=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZooBItUQkFTeAp+KVrXh9RlQkLzMlq8VQE22NTWd89v0/URN5ntYSRaHV2iRHRUPReQEZIJwlwIeXGI9o9gO7sNKEsapg+z5eVDNyBRqbBeBk2C4zzMvwHadXu7fHfJTICglmi5+mfebXFNCuz4oJY/yTm/y1awvDhJEd5RHtX0HhuNlIJpeADnlCf9Z752EwNg9jdyJIMOI9/M3DWGweP5FJhZqraJ8vSpdpMbJ1qziE8NUlJmVhVzVWSitHhiZh+RJt60tlSJbMnvDRAJAEUUoVcC+KxHj/BkmcDHfa7X6vNd0wbYb9lkWqS02n1WqMYUHgIwLNt3hlksQZGq6L528+i979Aq3q390r0HqSdhvLV523HZKLfAFIsZL5opc6A/j77AnaZ+ZuH3Du/hxYzDF81ZCMf55Ust7Faj1lnyVuCmcFRmRkxsSqSpfV/Pv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 14:08:38.5758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12af8aee-01d3-436c-5c6e-08de76d2decc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8456
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,kernel.org,amd.com,web.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5756-lists,linux-edac=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yazen.ghannam@amd.com,linux-edac@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-edac];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 74E141C3742
X-Rspamd-Action: no action

User has observed multiple L3 cache deferred errors logs after recent
kernel rework of deferred error handling. [1]

Upon inspection, the errors are determined to be bogus due to
inconsistent status values. Also, user verified that bogus MCA_DESTAT
values are present on the system even with an older kernel. [2] The
errors seem to be garbage values present in the MCA_DESTAT of some L3
cache banks. These were implicitly ignored before the recent kernel
rework because these do not generate a deferred error interrupt.

A later revision of the rework patch was merged for v6.19. This
naturally filtered out most of the bogus error logs. However, a few
signatures still remain. [3]

Add the remaining bogus signatures to the MCE filter function. Minimize
the scope of the filter to the reported CPU family/model/stepping so
that similar issues are not implicitly masked on other systems.

Fixes: 7cb735d7c0cb ("x86/mce: Unify AMD DFR handler with MCA Polling")
Reported-by: Bert Karwatzki <spasswolf@web.de>
Closes: https://lore.kernel.org/20250915010010.3547-1-spasswolf@web.de
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/20250915010010.3547-1-spasswolf@web.de                # [1]
Link: https://lore.kernel.org/6e1eda7dd55f6fa30405edf7b0f75695cf55b237.camel@web.de # [2]
Link: https://lore.kernel.org/21ba47fa8893b33b94370c2a42e5084cf0d2e975.camel@web.de # [3]
---
 arch/x86/kernel/cpu/mce/amd.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index da13c1e37f87..7a94492aa50f 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -604,6 +604,18 @@ bool amd_filter_mce(struct mce *m)
 	enum smca_bank_types bank_type = smca_get_bank_type(m->extcpu, m->bank);
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 
+	/*
+	 * Bogus L3 cache deferred errors on Cezanne A0.
+	 *
+	 * Case #1: PCC bit set. This is not valid for deferred errors.
+	 * Case #2: XEC 29. This is not a valid error code.
+	 */
+	if (c->x86 == 0x19 && c->x86_model == 0x50 && c->x86_stepping == 0x0 &&
+	    bank_type == SMCA_L3_CACHE && (m->status & MCI_STATUS_DEFERRED)) {
+		if ((m->status & MCI_STATUS_PCC) || XEC(m->status, 0x3f) == 29)
+			return true;
+	}
+
 	/* See Family 17h Models 10h-2Fh Erratum #1114. */
 	if (c->x86 == 0x17 &&
 	    c->x86_model >= 0x10 && c->x86_model <= 0x2F &&
-- 
2.53.0


