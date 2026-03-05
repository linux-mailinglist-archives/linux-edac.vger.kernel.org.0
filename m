Return-Path: <linux-edac+bounces-5770-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gClrDlSnqWlSBwEAu9opvQ
	(envelope-from <linux-edac+bounces-5770-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Thu, 05 Mar 2026 16:55:00 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92612214EC6
	for <lists+linux-edac@lfdr.de>; Thu, 05 Mar 2026 16:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5471303677D
	for <lists+linux-edac@lfdr.de>; Thu,  5 Mar 2026 15:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5893B894A;
	Thu,  5 Mar 2026 15:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VpGRYaUi"
X-Original-To: linux-edac@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013030.outbound.protection.outlook.com [40.93.196.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5EE3806AA
	for <linux-edac@vger.kernel.org>; Thu,  5 Mar 2026 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772725637; cv=fail; b=RxtbfFdFfu/yFsVdLZle8656qTj9r8zSSEcHVz6b0JTqtckeS7xY6UMfzbWVlML6Jvha3sqmCjAuIsF9EwEqeZOuNjX4NmQde2sQiyr01cdW8759CUEAAZiy5iwfrFm7Pa7qxc+4vxMj2OKH2fyxVVL/O/QNUCRcBqGqSNFavrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772725637; c=relaxed/simple;
	bh=hmAE0zPZ86609/M8m0iCTCLkOmGxmLN3NF4hnGKvmD4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LPxnx4bRjhim63qpV1jnjwHrKlOfuWBCNAC4AuclZs/HbDEl6NlWUQYzlAg24F7E8Gwl9Tdwoc70Sa1cJHbBNv9bqJgipVxI9/BBURa9e+7yU+s/v4iN0qS9ldkcvHYsYCek53RPDeRQdfaVsuoJNZgsy+s1qT+I2gzpmR0j1js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VpGRYaUi; arc=fail smtp.client-ip=40.93.196.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f9oX9t8NlHPsqDoF14dZvCA3uMfZp8mccN26GDhg3a2zxVMqnufQFq6D4UQfgQAuGt3jpnpNuX4/aZddzMLsJRkx088/nBZ5/0QgQHI89Bt9x5ZNgOyRcu8RNW5EYqVRxy8MAc5k0QqUHFUJHj6lgENtPjEJi0+x2mBDfZS9M8HHvNFSTpRq9MQM+9+dXeNXrbfQdKt2hw7Gli3dsnDUT/cwKik7KDaZsEqzR1OxrX4JSV5Ui5qGP+OKDWZW2MmS19segJcQEomI5oaul24lxei6BooQoEFUMQ6WfS/Sshj61J4qkZWLx1sCL4GSfs8MJRzlhPc9m2in2UPGMIOnvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZFljh6RBrhMRhAW+1dI1oWOPLy5EM6ZgbVrhi3sS48=;
 b=wzagFm2CyfGGTzGfMUbt2jXfKXbkumsWBkM95kTntT6r6mSZ+hUqbiWtBPthKYhItSIe/jMgyv2fchTCgHu2XGgh+L6liwnIi5VxzZzMb1sme13pQ72ts4oJpumPS6OAQAfWbEsDvcHkb3+sn+omAF+9rEZEkq/j1Nhb7FZxfTupHtbytMNZofADh0wXNlWCVv4Te/h7fA8sKVB5LOqmy5M1wx9b7NVGPlU1Yjo8nRCGfD+GfyBoP/quH+IpYsqlQeCBYdhFzTGDcY4ylKUazAbpKDezefeUkMT+cFhhLi2g33AV4W38I0N/U8SkQLKXuknsb/lc9ULdfIzHZLEQBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZFljh6RBrhMRhAW+1dI1oWOPLy5EM6ZgbVrhi3sS48=;
 b=VpGRYaUinhQPCsr1BI4dnqTeaPIjq39h8vzS81+1RUuo23E9MaBn1oY1K/lUAgWgaN5WRHnap9B3uTPh2cm8x5KhgKR8ivu7p7fJmeNBHcmB8enNjzz6ETiRt+6XX7piVjwoTXeq6AOeGIQjKXlQE+RrJbWNTftxRSDCyu9LyGE=
Received: from PH8P223CA0012.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::17)
 by MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 15:45:59 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:510:2db:cafe::1f) by PH8P223CA0012.outlook.office365.com
 (2603:10b6:510:2db::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Thu,
 5 Mar 2026 15:45:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 15:45:57 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 5 Mar 2026 09:45:54 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <Yazen.Ghannam@amd.com>, Tony Luck
	<tony.luck@intel.com>, <bp@alien8.de>, <superm1@kernel.org>
CC: <yazen.ghannam@amd.com>, <linux-edac@vger.kernel.org>
Subject: [PATCH] RAS/AMD/ATL: Decrease message about unknown DF revision to debug
Date: Thu, 5 Mar 2026 09:45:27 -0600
Message-ID: <20260305154528.1171999-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|MN2PR12MB4223:EE_
X-MS-Office365-Filtering-Correlation-Id: f7f6e858-24c8-4661-e2db-08de7ace4b35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024;
X-Microsoft-Antispam-Message-Info:
	LTnIoFV+BRYhlXuLkRgvSz30UHSdKjmcZy8FYKAV+aeY2be+cqzd67+hpRmgkXUJTfUsVzTyd4rNU7JgQ4RvaZJzxceuN4aKhvt0HTdEINTTlwfwoxXlH8d85g6Utk6E5y3jAmdFsNbIOhr8cFwmfrYGEGmUNmOHV/noirVS5NbbcSD50dUxes4NloqbO33uRHhC0hr7JzysFD+7K3fsGOeyHgw6Yhj+OrlEZUsGbpdvdH7wEpW9FA3Wu9PVAvBz8QofpHrkdL2uTjW/swbiQSX600veJGYHjm+desb0hj5YIUlLje6VzZzk3Ysd37CPDDU+C9dtDLhKk7SN9cA3/Go5IN2my5AVVe41MXxBqg+yPGBuYwzbb8cBS7GifJLGE6hB0kLY9PVS8YOSxVSRwMBmFDFaOctdn3pPdxizveBiVO4ALjUV5qlBEuUNQCDvcmaysk2Nxe2QybHhAdGzlWxE2BlmK9ePx8ZPIKBFNQhqsS8p+Txtwwpvbfy+cftvilo6HNH1wgW5ngVKLwCMoVMPdWpOm+j0yOVD/AUdWto8dYuu7KqQovjGK7vwRwc1tk0pLn2B/YNYGqrVV2GUYL+46cioX8nV6W+p5s5YW7knwiRO+PCkHG01mxwK7/ba9gJrOegXBqQxzrZCbWkkqkhk+5EMsw4+st5u7vvt4QnxLYzkdEuuBLYl1F1sc/IBTP0DPH+53gi5ucUXEHBYPM+6uAS5Itfx5DKRADneDI8jyxwMLVFLaPen/cRrjQ5iA9kvR89H9QTlx2HOhkyzzw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	M3u4I/5iutD40o3NFriiw1Vg5eIdDGocazbWVVQtVeYCILj5ZduR58pti64i+fUFPIZ4P7sAvR8GLrOt1+pLOlmFhimekEZGYsHSDHqWwmKmk0DyMGPhMTPE2X7lqy727TNGqk93X3wiY8oH7VWFI0TnHg7QH2xW/RMo3xQ2TJ/94yQJZ1lS4VjYVlTlQqaCax1v+74HmI3rZlyxOd5Dhh+d2G81jXRM5qzeQo9QDZg2tQZ/u6l7rOGnOdxQjqBOMzprzVdHOnUOVvOGUmp4oFx9TKjjNGYrTtUNOmm47gaqqB8z4L2bgu9Mcy8aToxwwqlE9TkMnqUjYIeT1qOD2JN+YfBcTVIjV0PkbCfK/CKYnW4GfbhtkhFrUhOrhfxiIibjSe5a1HHfr3FBFRV+ErNrzRsMzn6cBew679F5F8Tti67SNOXCSGfaB0oAV7xA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 15:45:57.5994
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f6e858-24c8-4661-e2db-08de7ace4b35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4223
X-Rspamd-Queue-Id: 92612214EC6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5770-lists,linux-edac=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mario.limonciello@amd.com,linux-edac@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-edac];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

commit 187d1b27a1e43 ("RAS/AMD/ATL: Require PRM support for future
systems") made PRM mandatory for future systems; but this is only a
datacenter centric point of view.  PRM is implemented on a case by
case basis on other products and thus it will be expected that the
DF revision can't be detected on some systems.

Decrease the applicable messaging to debug.

Fixes: 187d1b27a1e43 ("RAS/AMD/ATL: Require PRM support for future systems")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/ras/amd/atl/system.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ras/amd/atl/system.c b/drivers/ras/amd/atl/system.c
index 812a30e21d3ad..a9bf05be5c3fc 100644
--- a/drivers/ras/amd/atl/system.c
+++ b/drivers/ras/amd/atl/system.c
@@ -300,7 +300,7 @@ int get_df_system_info(void)
 
 	ret = determine_df_rev();
 	if (ret) {
-		pr_warn("Failed to determine DF Revision");
+		pr_debug("Failed to determine DF Revision");
 		df_cfg.rev = UNKNOWN;
 		return ret;
 	}
-- 
2.53.0


