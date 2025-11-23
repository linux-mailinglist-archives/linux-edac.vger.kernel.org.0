Return-Path: <linux-edac+bounces-5508-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6CFC7E1F5
	for <lists+linux-edac@lfdr.de>; Sun, 23 Nov 2025 15:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BA6F4E1056
	for <lists+linux-edac@lfdr.de>; Sun, 23 Nov 2025 14:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C69D2980A8;
	Sun, 23 Nov 2025 14:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j6MXKCiS"
X-Original-To: linux-edac@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012051.outbound.protection.outlook.com [52.101.53.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E721F1932;
	Sun, 23 Nov 2025 14:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763908094; cv=fail; b=MySQQWcClJifyjnXGnC/cPbV33sURbCNmVbCeibT7UNrv/e+3AsvosacY64I+il+PbWWjIk/XsJcFu26YJ/2QArNKZ0l4IcD/vpQJc/yFuSVoxRoovt+pt1X7/Spr6kdBmZ+66oYwvcDQkKwKxGoggCOQSlM5Qxw+VXoUjOQols=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763908094; c=relaxed/simple;
	bh=vpti6BNwHN/8CTf0Hz32B3BiHfUK4imtB3ZPy1wpHz0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bNj5Io+tpeVc4Y0JtZ8cn3cWy0/hX3Nrhl5vsSqh/IxufQTqtwukhYPKMYUTCVEVAT1tjfstTp12vlJPJ6wB5xDoqPmhbRwH6u3HWIGdZHOVg9wGIEQLUm8hN6XAfRdmclRJZafnWNTmqXoe6f05jElHP1Ex1NUiDQwWgNkwqnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j6MXKCiS; arc=fail smtp.client-ip=52.101.53.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LulkZPlb+nsKWf4bjPxbI+UnF7dL320k1c78+lhA6fXmI+jf5aA+ntbAhJBSdDbY/0RNUZykdY38Pgj5W/bLoUN4NJ1dB3E4DzTfO9d9Svr5tunPHqapy+NYbpQaX3a+z6/yw6DWGGihzwaVQp70U55bC4YgHDkhWJx03xsGQmMRQXzNaSHgpBg46Duppf29NqijGslvhDik7cue20x8mVE7rAKxIjpaP0tKv+ksrHC3pOaFDpzFFgS0us1X6el7CGGnj4qBw5R9E488hUiGJWv0WqW6Uu0FDQ1z1e0WzZoK6pDLNoI7woSDlnpYz015TRTGlnzPwx22WCE02nGRdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzszRxU4URmKwT095VDx9PBnfqeoijQNeDNed9eV5lA=;
 b=QutKI90zZUkqjTR0+04Xbwmf0sx4hV5Pv87pEtVMbbiL9DzhYDj7eiasz0HlujKpvMO/0xEmA1kLjqO3r28ssigL+1UO6hi4k56PmKwOvwHsfARMgA7o7jX+bt4EG1XjTsF5xF3FKjzfmVuyI5oa0LuF+UUUPO0YiAd096oBTucO8VqbI6c13nZq2Kr6J57hKeXvYjto7RM/YSGvkzAtvaREJh58jh3FU6uWuaNczhg8vNfujqNBiMNJ+2PMZHVZpIb6SUcglpPdEzhgRP1UtTc7O8Kb/sY6N9rWP9ymMA6OeMTWeSOv334I31X8XpzsdCcBuwZwG2uSqEeiUM1fZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzszRxU4URmKwT095VDx9PBnfqeoijQNeDNed9eV5lA=;
 b=j6MXKCiS2wJjDL/UgY8Pmu1i4mVB20Dq9+saYvUsWSGZb5Ig4FcqnR1kY27AITTZuKlnjqYEIIVd3QaVnJkrB8kih98pECFdlrFtUgHCVkjlPqa6V2K0R8xeY4GMC/wBKkNU5HGwzyDn5EaWTPNe+yJR4hQDSWtsk1iJEmfHKjE=
Received: from MW4PR04CA0040.namprd04.prod.outlook.com (2603:10b6:303:6a::15)
 by CH2PR12MB4151.namprd12.prod.outlook.com (2603:10b6:610:78::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Sun, 23 Nov
 2025 14:28:06 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:303:6a:cafe::8f) by MW4PR04CA0040.outlook.office365.com
 (2603:10b6:303:6a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.16 via Frontend Transport; Sun,
 23 Nov 2025 14:28:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Sun, 23 Nov 2025 14:28:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Sun, 23 Nov
 2025 08:28:03 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 23 Nov
 2025 08:28:03 -0600
Received: from yocto-build.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Sun, 23 Nov 2025 06:28:01 -0800
From: Devang Vyas <devangnayanbhai.vyas@amd.com>
To: <yazen.ghannam@amd.com>, <bp@alien8.de>, <tony.luck@intel.com>,
	<james.morse@arm.com>, <mchehab@kernel.org>, <rric@kernel.org>,
	<linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Devang Vyas <devangnayanbhai.vyas@amd.com>, Ramesh Garidapuri
	<ramesh.garidapuri@amd.com>
Subject: [PATCH] EDAC/amd64: Add support for family 19h, models 40h-4fh
Date: Sun, 23 Nov 2025 19:57:45 +0530
Message-ID: <20251123142746.1879744-1-devangnayanbhai.vyas@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: devangnayanbhai.vyas@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|CH2PR12MB4151:EE_
X-MS-Office365-Filtering-Correlation-Id: bad097a1-245c-4028-4e0f-08de2a9c8436
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E7EZDhWD9fccVz+zlerYr4SsGkmjQH+cfc5IAcadbp36KQUbIlAwtBAdxZDe?=
 =?us-ascii?Q?sFku0rZBwHdw9J4mS+9UKXa2GAlf6mQIMltkmpIx5N7Z4hGqweMcLz+4hsh7?=
 =?us-ascii?Q?qjmcq6mkjgcdJjEu8JCLGZyfW2cJ92kAuIwJ0Qc7DI25z4FZRISz37luaWNv?=
 =?us-ascii?Q?Bc4CLFQdt7AW+x83ah0x8uEtNVcK0+C6kdZnTtvA+2IBp06HLYfFm48G1e2q?=
 =?us-ascii?Q?zipNAqR5jlpfCDlW7/J4KJCDdRJds4LNM74vpKhCAXdvWDASfHGSTTPiVT8Q?=
 =?us-ascii?Q?8D6c5jRXoIQtiviuYhuDBUlsMsRZbIUEZ5loOPOlzZgIYGsEma0A/i8n/lpB?=
 =?us-ascii?Q?ZACkbwnSbkc3f46Fsh9qNDk47RB8b/nleOu3bJY53D0tCDgeuXTxWKHEGaS7?=
 =?us-ascii?Q?/V6yKvuKfaUvckRDSYs5qWUKGukTtXisW6B8p3lXlCS7Ce4oU6u7ZOVOV38U?=
 =?us-ascii?Q?PzRcD45RUAGPqVcr10kwws92lqyvooGjLVVNd+Ai+bdUgqE9Y7xIXLJeaN02?=
 =?us-ascii?Q?PplxsZPu6V2RmMzYjNLBd7j7hMEj+l72nPJ+AC3tRzJ2LOY8Hv90Na8bKYUB?=
 =?us-ascii?Q?d8k0SqMKKFpUUhwCdJh1XM4z7mL1pMbBAHvk2Z/u46XgJTVlQ72K5EPb6QoU?=
 =?us-ascii?Q?ki1e2gcDwr+l2kwCUQmenW4n8iw7g821i0rAkpfap7r9M5LTxlIFsbW84rOj?=
 =?us-ascii?Q?oFmMSwaBFXPTLBQUeDCf6SVPBhjaW73c202BfDOc2ZMZGS7Im8CUcgNgMxL6?=
 =?us-ascii?Q?SlO4kOf2iQRM9Zu6wWf3+1OBpq0HQS7fjL34jwSAMEY3CzZFr8w96qyLivYl?=
 =?us-ascii?Q?Np8iMyW4/S0AmG31QK65dVa1vjTFbnCW+bpJ2pB5sYEx/idoJ9Lf+D9L5RAB?=
 =?us-ascii?Q?BW3juURYc87qeDOethAev/kDFxvcxDZWj5OgRduX5tMA+tCa4JDzHFnav6EW?=
 =?us-ascii?Q?amAoD93UkNojwGBoe4gP6Jhj02uuMbgKjLSVEhNbHqa13HBKyVRDRlVBz3Sy?=
 =?us-ascii?Q?hLlktGc4hrQpEcq0GT2qIzIeblSQGFJ6555d0WlYjoCG1CTejdY7Jtyj//Wg?=
 =?us-ascii?Q?2uW2U1NTa354LHpbJbSJATYMXDF5V2dt9zsbwoJMD5kDgJlmS5clvNAuKiYy?=
 =?us-ascii?Q?PGA7czBUrNQwsADIB9JKq1eRNEJem/Pvvvru9MnvNhIfKlWmTr5dDoS4nsBV?=
 =?us-ascii?Q?KQRaAXYZXSUwfk91nxhPSauk4QRbigvPENH0O/zUJUHbkm13cJAY3DGaMgCN?=
 =?us-ascii?Q?yArmIT8c2pnFnyvhyt+QQRB+06a02NKRLgGkedLuVJE44lQ5UxhRUDrIU3nE?=
 =?us-ascii?Q?oBZltcR8muJPGNL/ogfCRBWygWlHyRQswUpF/Hp5uhTYMI/VFvbEGYv+92C6?=
 =?us-ascii?Q?um6/Sh+MQyYgtV/2MQ5jNl5Jr75Wms//2Nic/gOMfb/A3VMNs+jVGtr2HKVq?=
 =?us-ascii?Q?bTArQEDl0dqiSvud8Vkeoxyk6rwwwHzAJAXlHy6KAcViQxkV+Bl6uHGiapET?=
 =?us-ascii?Q?uKz8AC9xQbPy7gH+NvEOluYYODO35umBhWVkC3orxt8cKEfSOqXIW/CnECOo?=
 =?us-ascii?Q?pvKouORTaWXtbh+u7Xw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2025 14:28:05.3230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bad097a1-245c-4028-4e0f-08de2a9c8436
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4151

Co-developed-by: Ramesh Garidapuri <ramesh.garidapuri@amd.com>
Signed-off-by: Ramesh Garidapuri <ramesh.garidapuri@amd.com>
Signed-off-by: Devang Vyas <devangnayanbhai.vyas@amd.com>
---
 drivers/edac/amd64_edac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index a17f3c0cdfa6..2f6c3c4ed557 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3878,6 +3878,10 @@ static int per_family_init(struct amd64_pvt *pvt)
 				pvt->max_mcs		= 8;
 			}
 			break;
+		case 0x40 ... 0x4f:
+			pvt->ctl_name                   = "F19h_M40h";
+			pvt->max_mcs                    = 4;
+			break;
 		case 0x50 ... 0x5f:
 			pvt->ctl_name			= "F19h_M50h";
 			break;
-- 
2.25.1


