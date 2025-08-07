Return-Path: <linux-edac+bounces-4536-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04353B1DE39
	for <lists+linux-edac@lfdr.de>; Thu,  7 Aug 2025 22:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48EFC62439C
	for <lists+linux-edac@lfdr.de>; Thu,  7 Aug 2025 20:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8448E273D80;
	Thu,  7 Aug 2025 20:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EqbDUuPo"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E558E2741D6;
	Thu,  7 Aug 2025 20:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754597958; cv=fail; b=GYFMn8i7wKv3F+8wrpuo6e1O6zzRX0Yt/8EcPtlVxB4vxi4AKXXGQfcA5xFONCKgBLpDudEKK0Gb98Qv1j6pdWs/qlolNqtKHWjYLqJlluQTpBt0JSPOoYlQzexxQWXVhkBFKynBHKOyQ+kfFWEdiyPaVEih9cVUcZhfB8VjvqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754597958; c=relaxed/simple;
	bh=P8EckklJKgr5djP058rQMeLJJ+NdmPdhYYsgwu7Lp/I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gw+rzsy3rlPT8aBgihLwgDiTDoJwvjlrB6NubWBI4stdU5gu3v2lm9qCQ/KyNWc6noIlj6nn7hMYajQovT2QzYTqLVUzhLvUyDv1qt6GKpqZvoakUPfrhOP1g7Pu315RjQeZSxoFdAy1PZX2/oOUifshCrXn0Re6AECeVdsNnaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EqbDUuPo; arc=fail smtp.client-ip=40.107.223.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8IPqTdI6FfgV9jRp2QyPWsf2pLVjpXzbHwaowMnIU2wZpYWwR2YMudbOCpDGti5QX+wBdGxdDbYHj57oIZPOV8+jCjoedHRFGzcLS0v2TzC/mbnDi+gIF6AoRCyN+k79dtavHRixVOW+BRHFRgfriCYuURwirGotKO31byPGcMfOzkQSzamVnGDNY2Tzw80Nir2YjpbBHTJiDL7CzFgEMB8u3kWKlkjq9vKtD+yHXQUPWhywl7nkQrF4HodUhTXgok72JPecvUMhxDyloSRj5vByUonQB2MEqGNxFEwRvVS9qFyLrWTk2E99hT0v6E8sZrtkmjbRl2QlWBYyZZ6fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLDAu1Y24ftavJT+sUVebg/7v+w1hlI2NeeIj37WLhQ=;
 b=TG3XsYOGNb0dabE3eFqsCa0zZTtBsmR8PhKZD1OXZj+L5977HDZuWR6VO+YOX1uFCQDTydVf1N+ZtNCzQ4eFuStvulejpe1nNLzFOTJlX/p6kKVEDeTJWRwcRtxRw2tybUhQUztH6Tl7oemgPid24pytx4X0dgi4cjyHdL3XiXCu3VlhmWmaUiJg9bLQYCu8uILQzBMbZptotO/xY8fQsF9p7e+e2g7xe9VvX85WyBbBfkpD2pSYPhYrDMSzb1IhSPFzVbUFGlaJWcrICTpQnayiF7Gq12Chh0pXfqI/1mHjQrbBl/brCngqoJrm/0WHCPrLMCvQ9HJtWDGQQgT6zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLDAu1Y24ftavJT+sUVebg/7v+w1hlI2NeeIj37WLhQ=;
 b=EqbDUuPoWYjRm7UezbSkF1uSlZs/FkeJUW2U0OMmdBYdbQMcLtW5k10QkXNY1zPgJn5617hnanW7TB5MO2FN8ncXaoibebk87s9H6CJVGkpuMBgPPZYrz6xpvjCVDvdgppOK5QoDHvr2DKDkv5Y3/84FEE6eK6GSsQVE7GqypMU=
Received: from BYAPR04CA0035.namprd04.prod.outlook.com (2603:10b6:a03:40::48)
 by CH2PR12MB4039.namprd12.prod.outlook.com (2603:10b6:610:a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.17; Thu, 7 Aug
 2025 20:18:51 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:a03:40:cafe::fb) by BYAPR04CA0035.outlook.office365.com
 (2603:10b6:a03:40::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.16 via Frontend Transport; Thu,
 7 Aug 2025 20:18:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.0 via Frontend Transport; Thu, 7 Aug 2025 20:18:50 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 7 Aug 2025 15:18:49 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <bp@alien8.de>, <yazen.ghannam@amd.com>, <linux-kernel@vger.kernel.org>,
	<avadhut.naik@amd.com>
Subject: [PATCH v2 0/2] Add support for AMD Family 1Ah-based SOCs
Date: Thu, 7 Aug 2025 20:14:52 +0000
Message-ID: <20250807201843.4045761-1-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|CH2PR12MB4039:EE_
X-MS-Office365-Filtering-Correlation-Id: a416e83d-118f-4600-30d2-08ddd5ef9f88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1bpa+936F+oW8SPVXQCrmjKZt4b7hooOQvj35f2z5uEAgNbLU7MIGT2pPMVi?=
 =?us-ascii?Q?Lpfwr96/2vVX6r7uIiqaCpU+vJI3AKI7iEzrZ/KoofMk/dgYfUECXoT6640N?=
 =?us-ascii?Q?DERQAn2/OFDUECg3/cbN7dyuhGqF7VqHKSVcGrEH3lXe5lTiPWtLFKMaLgfn?=
 =?us-ascii?Q?cp4KN+0ZhvQ0V2PejhO6k0YT1T6vZYOhOPbEh/9F7xYAifbenhcrDEgFbUHA?=
 =?us-ascii?Q?/t+hfbbxiraAd3hODh4p1khZMhKtllvMaG8PRp01hED8csuyc6NzrW1olGpZ?=
 =?us-ascii?Q?nypnEglY5C6Stgt/f/om3KrRDVg9k3z1GWphZ5W8kdiE2YW3BLK8fbfRD7qA?=
 =?us-ascii?Q?we1Cgwk4lBCtYZgfKG2cSJ8x6uoVyX0Dz4Mixmk+iNn+UKlq/3LcoZKSCJ6/?=
 =?us-ascii?Q?w3wu9B9GOROCJ7SO8V/SZNVcUlkCP6t8Kv1RK6T2EGjebw6LIxgnMXt1O66I?=
 =?us-ascii?Q?HyyVup3lI6ZNs3g4ZmOMT1JbdBNxqz+jC00n6Gnt7JhuAYbJMdNv997a85gw?=
 =?us-ascii?Q?QM7Xj3A4geaTkvyMAZl+AgCnizq3fIGslJxNCynCYqJQemjZS1ic7jZWjxQ2?=
 =?us-ascii?Q?/375vHtF7rGuyMcTZR9nEls3Il5+4JzULivtEwysSuhC8qE1hjXeLvstDfyW?=
 =?us-ascii?Q?Clv3WZLQjNqIjbdHF3ViHTubmxIMVsn3Vw2cFOybDJH/1IxkDazdo2S+Z97J?=
 =?us-ascii?Q?5lx3/S7MtmpgwAFjFO3jWwRYYpX9J5PFQ1COu7880/De8NC5bVZkTzjDtHa2?=
 =?us-ascii?Q?A+wXPN5PY+BoDyyZyC+WRoVUbiVWFhClYwYy6BZCNXMe7EcZevM1dCXfAy0u?=
 =?us-ascii?Q?sM+tshqFHC22FUeFWE1ZnvSPsIvGIxPc7sTffzUumBhW1/QaxWpf353LYNv3?=
 =?us-ascii?Q?WV4uEzhYKIRAA0TmsAmqL1TX05CpGxBIzfOX+7Ffp7/cLPW1BGVG0B8t47C1?=
 =?us-ascii?Q?6/wOlIoTbDlIqXHJTWqDjP8Jscd4gfmuiD234x8XtK1HYhlSx+14dYE5/FAw?=
 =?us-ascii?Q?l+jL9qQ5F8mwMgAzk1JAW3SdZF5V/29C4xK3aOUyR1TLi5DOjsgmjk30irxY?=
 =?us-ascii?Q?F+IOv0Oegkpsb7twyOh4ecWGI7DmguV//eTWIHqkM2drxmaETtDN3gp8PGzd?=
 =?us-ascii?Q?bHORK4iabk7W6vV/hQdnHCV/jcgNEFdRr+pv5RRL/3mBBRvr7axDc6ienFQi?=
 =?us-ascii?Q?aWVR7eK6Tm3ZgH1CZqgWs5XalYTkAm+jeo9y7jS03ESeXHRBon/24L3iAoB1?=
 =?us-ascii?Q?CZRd8ZEDwGuY9j1xL+VlLGVfm9/uVAupMxEtG9fhV06j+QuFtdXGEua/yQav?=
 =?us-ascii?Q?VHP+o9IKlSvvcClwDEUIIaDg/Pxe3688BD9WDlL4RLWDT0KxU9PBXnvZQ1eb?=
 =?us-ascii?Q?ArnuMcDKNkjQwhGjMK8QcvM/G2BgkvRKmtNbvpEe4j6iLZ0ZfY9zlQKkW0fz?=
 =?us-ascii?Q?hKMtLgYObVx890dVtReAj+tT+wwpDt+8bUWSZLt5hMA1DVGRK9Pmr2Zw//H3?=
 =?us-ascii?Q?C73kvV4mBmL8a1r3O6OCTypzfvLjStBN5EVB?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 20:18:50.5540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a416e83d-118f-4600-30d2-08ddd5ef9f88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4039

This patchset adds support for newer AMD's Family 1Ah-based SOCs.

The first patch adds support for these new SOCs in the amd64_edac module.

The second patch modifies the legacy EDAC sysfs interface so that the 16
UMCs supported by some of these new SOCs are appropriately visible through
the interface.

Changes in v2:
 - Remove extra tabs.
 - Update the legacy EDAC sysfs interface.

Links:
v1: https://lore.kernel.org/all/20250722192855.3108575-1-avadhut.naik@amd.com/

Avadhut Naik (2):
  EDAC/amd64: Add support for AMD family 1Ah-based newer models
  EDAC/mc_sysfs: Increase legacy channel support to 16

 drivers/edac/amd64_edac.c    | 20 ++++++++++++++++++++
 drivers/edac/amd64_edac.h    |  2 +-
 drivers/edac/edac_mc_sysfs.c | 24 ++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 1 deletion(-)


base-commit: 1fb0ddddf5d139089675b86702933cbca992b4d4
-- 
2.43.0


