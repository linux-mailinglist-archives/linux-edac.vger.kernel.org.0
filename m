Return-Path: <linux-edac+bounces-1233-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 564D88FF5FA
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 22:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DE041C22D2C
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 20:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EA319B3CA;
	Thu,  6 Jun 2024 20:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qrKGiktd"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D96719ADB8;
	Thu,  6 Jun 2024 20:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717706049; cv=fail; b=f6pBaG4xyEezKR54a5qTAyaOUfwgYvgwmSkVfdotcfXvg6s5zic5hVs+y/VQQNAfYZSi1Utjlq54HCUwzRTWtsPz0MgKHaEdRDSqMHPj0px/iqm4DaTqvhgzTSJVqKACgX+dg60aszELJ5Xh+skaGjDEVky0ZOU/LHzs8iaq7OU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717706049; c=relaxed/simple;
	bh=AeMMhQtlrucptAm1uHkX5q7loCFVcJ4EkJJ+fsjwe/A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LvbTcDWDrdzL/z7gG68T2RCVmCPPb997EfcBuiznczG/Yd55n7L5BXzq3MTzEye6DzyM2dR3KDrOK0mATeeobwz+ixEyG2+jenrXhDTg9vmOsxJDvWCBR26JJbWO3QKdNtbeVrwiWRSKUZv/hQjDM5lC9lWVRXiajzaNkcBQeW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qrKGiktd; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PaLTyjjYUwU+Thi2KTDpmGxxbB5XRDiBK7nJo6j+bPoo/+D9iDRxZfholoPyJZnIYugBuER1H0ti7PRTX/5LbWrYBEKJZaKqeqnPX5Cdl3beB1BOYd3ThAjQl7MtxwOXxsGzRAHrLyipSMHQR9PYljJMRYL5TbjVRvmWxxumem02qdDCmrMZUGsJoZgm/oxBKWiPsAgFceZv5e/S+ZeY6md1Tsnvvyvdl+/c6s3Lvgi1ZVmt4DY3JYBGPG8Sm4o4ik4OMEZ0jh5IRPhPlLc+4Ov+M0EM0iwQUFrBiO9ki/91wD+0AJP5DLmfi1ogHr4THbCCWmA8HRmQpO3IT8jPcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhENGeqn+Zn4TRwsxGj7qi01/XO7JTSoaeshs0+elDs=;
 b=jswjdye12dFS6gAJVlT/EzaZDi0pvmMtleJRchePr+nRylUyOKFN2xD+9v693Ztsrqu93Ym2A8wgPPA603rlT55d8WjlpEFBR+9N61hANSlO2w7wUw19szEn3DXG1kaXhsYKsGZi81lh/8RodRjIKeTvFOfFDqYAv/t+uVnVX31vzQAesxpopZ0PaQ9dMQn83kBYDhJl2KH+gDa6FQZOWswkzkbYaIAQiJGycbluoCEFZNY6hl7+CRywue/bXPHrPEZmV3Mx1wNww34rIeCxuSMOGCXIeqHNK30EMmC2qvIzwYxnwT67n1J7LOtQjFJaDislB18WhWSuRqIxVrShVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhENGeqn+Zn4TRwsxGj7qi01/XO7JTSoaeshs0+elDs=;
 b=qrKGiktd9Tr9TvBIIZ6TXdmggSAlQiDPX9FE132GVWBDI+SLs/HGRLkpUgLKthoFfP/ocCCh8hQQ5lsy6iQ6SCq8g2Hf/pYVrVzlj7TXNUtATxwQYgvjfSP2dgPYizf0Memrn97OG6+a8Gb2oXwP+dE4ifb2PqybIG36QtOYW6U=
Received: from CH2PR19CA0010.namprd19.prod.outlook.com (2603:10b6:610:4d::20)
 by IA1PR12MB6138.namprd12.prod.outlook.com (2603:10b6:208:3ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Thu, 6 Jun
 2024 20:34:04 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::f9) by CH2PR19CA0010.outlook.office365.com
 (2603:10b6:610:4d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31 via Frontend
 Transport; Thu, 6 Jun 2024 20:34:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 20:34:04 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 15:34:03 -0500
From: John Allen <john.allen@amd.com>
To: <bp@alien8.de>, <linux-edac@vger.kernel.org>, <tony.luck@intel.com>,
	<yazen.ghannam@amd.com>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<muralidhara.mk@amd.com>, John Allen <john.allen@amd.com>
Subject: [PATCH v5 6/6] RAS/AMD/FMPM: Use atl internal.h for INVALID_SPA
Date: Thu, 6 Jun 2024 20:33:13 +0000
Message-ID: <20240606203313.51197-7-john.allen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606203313.51197-1-john.allen@amd.com>
References: <20240606203313.51197-1-john.allen@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|IA1PR12MB6138:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ed1f8f6-fa67-4e38-a57b-08dc866801c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|82310400017|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1Cge47+Lv2j3ZV8qHJa+z2TJOBGoz/aMXzjdRnTpt47pmZ1FFGioRqgIcAmQ?=
 =?us-ascii?Q?shcZyUaK4wIibaM6PD/Dj/VaRwMch9uyozlWMIg2xm3UOuMt2Fbbi9uiYwwf?=
 =?us-ascii?Q?SOhWWDGctFwBpzZ+rO0IaVhzeZwI10VI80LpiYNWKO2darX4QcdJygRR+d/T?=
 =?us-ascii?Q?OqFBYwjbuiugVjJXp4RuFe53WaLDcKPuyHWiZhyAUUc/JKBmoc6t318QkfcT?=
 =?us-ascii?Q?g+JOXMRf70cvrb/z9Xf7IACH6XBxaqccQKcDvPszf8Mv6ePcVS1XhbQr/0Rd?=
 =?us-ascii?Q?pd4mgOu8dXFtw/Xk6xAydA88/Oa3qv9rmMOT6/dOHrS8TUJFUixhp5SgL+Z3?=
 =?us-ascii?Q?2QYA7qmD8j7C1BT2PquVrFTpwjfjq9kTRKd5ydS0vK7+KQwjMKZeOA5sogkW?=
 =?us-ascii?Q?3z57pNwsoRDgJOpD6P3p3YnlUGwfuNKMcb/oxtmBorTKaSWD3nlWiUEHofaP?=
 =?us-ascii?Q?drdtpCVvu334ZpZrO1x5XHKTvUq9cBbb2iKPzbJruo+R6GeHjBB3l3WlRn19?=
 =?us-ascii?Q?QmKq8Ea2lmjS/vegxNWMAMiFqIj79U1ytAQ+iw9yLE8ET2dp0ycmymQGMRBj?=
 =?us-ascii?Q?w+sWblZhaBfanvl7G1Nt4STc0sR/bn4tpiCjQi6D3J7Q70FqthFIJlsF7+oE?=
 =?us-ascii?Q?wSX/tUsyrw+nyjCRCzCRRLBlWNriGub80TgJXS1iipCoY3Jul5OkGeOl7eEV?=
 =?us-ascii?Q?z+ga1PNNDdSqS6kTx3vyVy0FRodY5uVURHydnm8oBhal80VYsz97MG9Vw/L/?=
 =?us-ascii?Q?On8YUKb6PgneQ4icjzA/fEDwoysdbVhhIys3sytw+ngApC1WaRVDs+zXhUxG?=
 =?us-ascii?Q?GejHUo0fkG3IiXfOZlQigzngzv6zS8wYQ9rkzRVrSORNG5J6kXls7LLoEsto?=
 =?us-ascii?Q?SFXj7yNUIjeHL6ExihfIg/eG5ok05KgZ2ICeW1JaZcUAL2az13WbUPmrGoTZ?=
 =?us-ascii?Q?ZH0XfJJUS6oZiVCKlgTEv8mTpY88Il0UrRBgRcmjBhY2IhPdP9EK5Rf16zU+?=
 =?us-ascii?Q?b6CAjT0rxUdPd74VeYTZ3O1dfIbC68HStP4gjoQyx99c0shqbe1cWI0nhmMN?=
 =?us-ascii?Q?wJAMq+DZ4WJpb74gnP2D9Z1Mh1Ipq8dTvd8zwWYC+CDX2kPGhq/nvrOYnAs5?=
 =?us-ascii?Q?JS8dLJIUoO2Utkfkf+YwjT8SF+t0cCCS3YgJ6rhzHMSFvccU/y5QgD0RHcVm?=
 =?us-ascii?Q?cH6Qo7kePJp1Pu7V4xFn0kG4OAkmUBNb4wwxYWVaflWhqpk6oYGfQCY7MIjQ?=
 =?us-ascii?Q?yThkSnRhogW5/OWSYMH9bOVWrOhT1Dw2DholXTw7IBVIggkEwvNSp1gKZ2pn?=
 =?us-ascii?Q?6ZpDXYwtyejEY8tf2eufmbzfdkKBI1OgwxEVCF9RqTDs5Jsa7yWG4b2pO7oN?=
 =?us-ascii?Q?UwAARU6H2d3Dr9ej1c9QFJk6+cz79zUEiIxO35jJb27YLxzMJA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400017)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 20:34:04.3543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed1f8f6-fa67-4e38-a57b-08dc866801c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6138

Both the AMD ATL and the FMPM driver define INVALID_SPA. Include the
definition from the ATL internal.h header in the FMPM driver.

Signed-off-by: John Allen <john.allen@amd.com>
---
v5:
  - New in v5.
---
 drivers/ras/amd/fmpm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
index 271dfad05d68..90de737fbc90 100644
--- a/drivers/ras/amd/fmpm.c
+++ b/drivers/ras/amd/fmpm.c
@@ -56,6 +56,8 @@
 
 #include "../debugfs.h"
 
+#include "atl/internal.h"
+
 #define INVALID_CPU			UINT_MAX
 
 /* Validation Bits */
@@ -116,8 +118,6 @@ static struct fru_rec **fru_records;
 /* system physical addresses array */
 static u64 *spa_entries;
 
-#define INVALID_SPA	~0ULL
-
 static struct dentry *fmpm_dfs_dir;
 static struct dentry *fmpm_dfs_entries;
 
-- 
2.34.1


