Return-Path: <linux-edac+bounces-5783-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPJCMWdTrGkOowEAu9opvQ
	(envelope-from <linux-edac+bounces-5783-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Sat, 07 Mar 2026 17:33:43 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF0522CAFF
	for <lists+linux-edac@lfdr.de>; Sat, 07 Mar 2026 17:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2D4F3019F33
	for <lists+linux-edac@lfdr.de>; Sat,  7 Mar 2026 16:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2933A5E8F;
	Sat,  7 Mar 2026 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LTxS9aOG"
X-Original-To: linux-edac@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010065.outbound.protection.outlook.com [52.101.56.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F6819AD8B;
	Sat,  7 Mar 2026 16:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772901220; cv=fail; b=Kkh1E3K20lY+HLVh2ZuSmkqL5oftJMrM/0NgadHGoHaZJpHvTeA8X69Y7uUyzcMV2QzjjVpqt/DWSoWpB+0xfumOITe+HEHyS9Iz+s3xsj7CuXnPhRFPZKp5WagdoY5jivloknPdvbixM6E3Rf3686dGO92bYIIQFtoD+XcGK9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772901220; c=relaxed/simple;
	bh=bnmzkWpT88iJo5bJLCjNvrPwZQKz1v3CjTS67tKm1Ao=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KmK2OW3tOeJcZj1g+/sm+3mKqjeBfMRVBc5JABF0uETZhbolAk5aa8I1QFmGs1IB5m7ptPBPbhV14tULPaxTxWjooKBgCTQ5mlV/Xwoj5s3j9iWavzQV/4yY2fpnV8AZLMWPw4GbxeOlX0jJ2bN0iqsmOsX3MPKZOMz4sHGLxOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LTxS9aOG; arc=fail smtp.client-ip=52.101.56.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DYJCTM/4cS8uaCC857anOj7NRdJwyaP9j1m6aDzJthAT7q2A6ibkvy1uoJzQEDudA8M2cFbmbg1XR9K5QEQbw/oVAsV74q+nKuFKVn0tmXmKW1dkHlmv/KzMNW33ebOP2wNVbMDHr28OJC85gB2M4wzKSXIUfOFaeIPwUUsvLtcZKnM2uJGkIdn8OsMDKfZ4Hh1jE8007j1lzrLx5lTTKlQlc9TYMLcoXPcBUO4wM5Hx1evDVhtFD6CPmSA+01zAjHYIefn0/+gMhuKeYZhM8DVCnbbD+RG7u4o4gENCiCyzs1eXr9PA9/Hp8Mbf+1yGbRYeUTeUpfCAdxks/zegpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4pIi+skCV7l8szM7tiaQ/HiU4IbG4IMMbs0hdUxPhrk=;
 b=PMFibvRJBy/w81jf/qnpt1G6HCCv7ovSDJ3ZQVCtfuppEKI+QSh41zliRtGEUrHpB7LwszuiQBH90hoXuZ3uIqwA8vGNx2Y8oTuilFVo4MptehVEM+44DMksFiX8Yr8nw5rTKc/mlp+onsnCvsp1T5lMOLeOv8GRuTYxDWbZ8VNtmsXMXOo04fHiKCNKfrLTCUT2FPaBxaNq31VD+rVc7S0K+HYv9B9OsozIV+iB+Pg41uG7EL4s1kCSYksDaYrd5S5jW4+0lzHWaRCdf6GyKK93pJjYxkROEY8AcKr8JRcK5je4avxQINtGAGdh8KRPKbCkEKQmtV1aGQQJINXgPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pIi+skCV7l8szM7tiaQ/HiU4IbG4IMMbs0hdUxPhrk=;
 b=LTxS9aOGqrgAgfHXdYKLopah0KsW/RWgB9WepTcMLRXol5ZnxxZqKAeSYFKYvIZWYjt2ghqi0ftgXdfP1wlCWaC85pYWOPDqSvphxJwT3oXmDsr3+7u7xRlFzDkENrhN1vdHQvSK43LHf//hQTW2zSm623AOvya7EnHwaDHE7BM=
Received: from SJ0PR03CA0155.namprd03.prod.outlook.com (2603:10b6:a03:338::10)
 by DM4PR12MB5819.namprd12.prod.outlook.com (2603:10b6:8:63::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Sat, 7 Mar
 2026 16:33:34 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::a5) by SJ0PR03CA0155.outlook.office365.com
 (2603:10b6:a03:338::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Sat,
 7 Mar 2026 16:33:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Sat, 7 Mar 2026 16:33:34 +0000
Received: from yaz-khff2.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 7 Mar
 2026 10:33:32 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 0/3]  New SMCA bank types
Date: Sat, 7 Mar 2026 11:33:13 -0500
Message-ID: <20260307163316.345923-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|DM4PR12MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: e07a8097-0592-49b6-3589-08de7c6746b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016;
X-Microsoft-Antispam-Message-Info:
	psN+Za15fxQxcXiVErAjf2R0eEa7dMgnt9D7L0bxiyIc3xxjaxuHofSfUv9ZaVP0KSdoPr1qA0b5pCI432TMCH8ce/KdSarbfXRfAVCCRzDvWl9fl9NvKE++UHQsiiDI/dSVRi33AXVDX1AJL9RK3tYtj7eW/aVSvZORlwQ/Fd7y+oTBgPMEwZlHO7boK81jJEvW/0f04/dnNSnU4aqifRSw+PxvLjKfN9CwibnvA979ZLWBCbhCQlujQHUmt7knNa/68nLhHkAYJCc/niWbe+3vn8FSdltZ6UmCit8JxtXsJ/yM+zu9jdmLqxvOSROiVxE4324N7K4Rw07n46kdvJyUFmkS4CUiLJy0y6XSqUoYYAHgSJSQTQtE4HQ114iyIzrVdBE0ju8zrY4h+9rcVisUUTaWKIOHUCIJ+Q1M9B1kaXIf2d3pvJF3zilK6VjL0IqrhlXOBQeubwEN5KJucuUeCelaKpynVUFYGNaPWYA9abKjtSWr90b1GEDj2CwJki34ej1hmB3py35a5AyMSa1ib8OTx1Nin417A9RizW6vf4G0PpK5tmS5Hif1UDmVKsn6ueTJ1UjUSh3YaEDaV5bn+E5SBIV1GordGCDvF0buMRPMDiMf2FanGWaxPNmVequ6MXUBAk8uTxLCPHUk55yGkZ2HOaXPnShDS2kHaPFpSt/s4/VbHrEvJFu9SiPyQ9pqFIHwJYFH2ecC3rQ32syUt7WE5RRGeYqgUKpZ66w=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qZxktI0jA7k/kGoOK86i0S4TFgC4GfJJShZXD1VWCnhp/Iquue+BbtXEHJV+DcrY55Kbgzyh0qDHp72Wq+V5y/rjIUHUyl71nkeZHvyxsEAax4Ur65NrB929v1vU9+EpZiTqqmyTwwYHKTj4N9AH61UjjJOVbqRwnF6Pw062WjLN1Aw3pxzggmLKKTQIX4ftNw6cNA/A+NGCBebDsJt2nSKpTk7NrN+JYs1V5zeIMDqdLOq2GDED3UEgGofwi59M1GeJoDXBpSe6jAPV1e164I4SxSkOkN5cggMb2WirpbFWyBGfktHoSMaAkbFM2vzWa2M3lO2cad6mIRZIq5t2GPBHIqkGcO0H1HULuZWaAQOmsU0+rXhElQizXqCeWHQZ+m9TRUkQjVVffbZfgbpfMpjaDwcv9iU0uwoT6OoB93yxvcm/ha1SzJ0hmsF00SCU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2026 16:33:34.1481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e07a8097-0592-49b6-3589-08de7c6746b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5819
X-Rspamd-Queue-Id: 1FF0522CAFF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5783-lists,linux-edac=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yazen.ghannam@amd.com,linux-edac@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:dkim,amd.com:mid];
	TAGGED_RCPT(0.00)[linux-edac];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Hi all,

This set does some minor refactoring before adding new SMCA bank types.

Thanks,
Yazen

Link:
https://lore.kernel.org/20260202172158.2455749-1-yazen.ghannam@amd.com

v1->v2:
* Rebase on v7.0-rc2.
* Add pre-patch to reorder the bank type enums.
* Add pre-patch to update "CS" bank type name.

Yazen Ghannam (3):
  x86/mce, EDAC/mce_amd: Reorder SMCA bank type enums
  x86/mce, EDAC/mce_amd: Update CS bank type naming
  x86/mce, EDAC/mce_amd: Add new SMCA bank types

 arch/x86/include/asm/mce.h    |  59 +++++++++------
 arch/x86/kernel/cpu/mce/amd.c | 134 ++++++++++++++++++++--------------
 drivers/edac/mce_amd.c        |  48 +++++++-----
 3 files changed, 147 insertions(+), 94 deletions(-)

-- 
2.53.0


