Return-Path: <linux-edac+bounces-1227-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 303A58FF5EC
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 22:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 486311C22CAC
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 20:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF4812AAE2;
	Thu,  6 Jun 2024 20:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v3tC0zhZ"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2065.outbound.protection.outlook.com [40.107.212.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5097502B2;
	Thu,  6 Jun 2024 20:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717706017; cv=fail; b=gYHbgtdGL6fGiD8kIqDGlIjxQt7o7Dp5SSMeXJLJb9KT9cFKUUgHLQbR3W0CULZ82QUv17kLYU+B2YVYNKZl/BjElZs68T6bAMvXLQGRhllliKIf4r3XCh3sAS2FxAj9rTPYDUSHMsnOTqSCKlTJ5mTDZmZGxLDimf7vGSSKZSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717706017; c=relaxed/simple;
	bh=7Ef9Sa4/2DrVsnKbPvkgX/opf61OMnniFIihv3dCRAU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KAa7PAuvPaER8KgMipgjI6PYn88bh3u7B9Ixh/IiujRc6Ko2YFhCdBfWiLDZaIXs5W6Ld55VJbCQDmDeT9FfNN4Javk4ymGWJOK7RVDKokej8DvKQXAlB2AyzkKXUaItIf4h4SlbSQVsVPXhDEy9Dvl8fiPBXJ4tmiuVX/tw5Dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v3tC0zhZ; arc=fail smtp.client-ip=40.107.212.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DrZywx1Vku1Q7Ely6Ni/AQK5stQPNdqQfMxQH+mlgi0S/KkFSASeoPVWb/bgJGihQCRXNS3ojIMtIzrEcAyQfnzNRiwifl4jsGY3Rff2UTkkRFvCq9qiwzD3eL0CGCFcmrUYB+j2NNnPnJRcoBpxcVVDpAe2WcFOjhLuQyW5WCBQwPG9U0KwCeAIg+xWpyMn+Yc4EMTdR17VGEjTCdxz0hMf183M+mC4Qmj3wiZOXoi74OyqZCQSa15bNdk6flXG1M+iLBatzR+Mbp3iTQGTZyqZHK5hvUJxnvt67L8Jjt+anQwUrEIryZnrX2gXftkbH5aUBQnYKJRB0btQ/Rsb7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVJakZmE406vnFf73or+0SoSWOvg1UK0QhLB+ma23tc=;
 b=ln3QVx0nVExGw1ciwu43aDNmpe4TovGU1mn1PCckMSuCdvqspOjnCiz6rGh/lKeIuLaAAuzi1vuJeBRs3yJyt9YPgbtA0ZZwTtPt5v14uhroSROG4GgHaoEfMpgGe22VIdL1QL9OPvON3qiBvi6vLJGwwowBmzhXuJAtW4DhF0gCRQaZvqxdEn3ul+pQf0BikuradqzPltzf5du66MYJeYgZ/quGRWkpW1eX6a2f4ysgAo66hqoZyOuAazDiZXEgHdrNxht3Jq3BhwXZlWll9PHZvfI2OxRMKY9LAEMYIKAjnXLeTNlvhgGN1PwxdUP7NpHSq937kZneDNKAP/uaNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVJakZmE406vnFf73or+0SoSWOvg1UK0QhLB+ma23tc=;
 b=v3tC0zhZ6Z3M14LtZKqEBIX5jOtAq26ezq/TuI138ZySrKpW4uZx72bSkKSi+kJiZrMQxkDaBjth+oSRqHCDdqbngBCSdmFxoaKWd5oOAXYgfPH65x1dy3r50N1AcktgJeBsyNzmXZZAE4Sjy83ue8Ldt7jgTeTuobGJNIaVKe0=
Received: from CH0P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::21)
 by IA1PR12MB8239.namprd12.prod.outlook.com (2603:10b6:208:3f7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 20:33:32 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::36) by CH0P220CA0027.outlook.office365.com
 (2603:10b6:610:ef::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31 via Frontend
 Transport; Thu, 6 Jun 2024 20:33:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 20:33:32 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 15:33:31 -0500
From: John Allen <john.allen@amd.com>
To: <bp@alien8.de>, <linux-edac@vger.kernel.org>, <tony.luck@intel.com>,
	<yazen.ghannam@amd.com>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<muralidhara.mk@amd.com>, John Allen <john.allen@amd.com>
Subject: [PATCH v5 0/6] RAS: ATL: DF 4.5 NP2 Denormalization
Date: Thu, 6 Jun 2024 20:33:07 +0000
Message-ID: <20240606203313.51197-1-john.allen@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|IA1PR12MB8239:EE_
X-MS-Office365-Filtering-Correlation-Id: 392a10c9-9879-4f74-06e6-08dc8667eeb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|82310400017|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tEU4VTiBABXAQT8FrnmmXQpaHRlxLxmV7Hs3b4O5Rho2uKCaxWbkYZIqtQPA?=
 =?us-ascii?Q?mX2Gs/KUvIr8bBFt4miXl36l0F9rPop9XWhsj/cr7U9j7QxslvPksdWqK3+2?=
 =?us-ascii?Q?9iWTYkSe1q6Cv8/lqAaim/J5VC8sw/p0bL7WOtmwHvx2jFKn+kMwgxKE77PU?=
 =?us-ascii?Q?1gnMR6rHLsykW3H446a+Co2Nq4eeclMP4Q0+nKu/R9yocAyCFPlwgFXtepzC?=
 =?us-ascii?Q?ZCUY/9B1BSIgpSYRRh4TMICP/obfExpWG/9omOnXBAvo0aI2AGtczR+oor1/?=
 =?us-ascii?Q?iCe/gX7YrAxf3qL3tE2QaDY5PFl7aMXYdW38UHt5fQM9uSna4v8QI5j0iYRb?=
 =?us-ascii?Q?mVeRF0HCJX2gTnd3fhx9MQsaVkS5ajosdmbnsjmb+S8J3T63cbqUP9DfHxq0?=
 =?us-ascii?Q?tJG4OOpXDNSCeyp6LQXUUiWfkjeNzvqyxRKO02/hHXRjyLOmK/zLw8c69UCR?=
 =?us-ascii?Q?mxV7QfErS6n8F+g5NV+9C8ClOQlSQXl1ngk9FAVe42rpIgPrx1k4jg2BctJy?=
 =?us-ascii?Q?AoR1kJPGdKWDIuvIYD3mYW970jd+/sB76iyNcnjmiI4re440nRwuqUhLOU1X?=
 =?us-ascii?Q?/KcfjX4Yw5QenivancCRFehlE0OQLUU2iMpS0tDoAcpjK5V65ibqcsPpminb?=
 =?us-ascii?Q?JOOad4ToG5Clv5iqgCMC4DTfn53ZIw50UG1F3R1DwUDfmXDaIJo+nA18WN3u?=
 =?us-ascii?Q?jlU5t27qZ16Mn482Ul+BtIpmFl/su8kocN4ny9pIbBDF+k1ZjWSTD+YTpr0V?=
 =?us-ascii?Q?J/BUZyJUzm2e8z/P7Q/XgvrRQssR8m9o6fr/nl1COjonRvQ0jwHHAUmopWx3?=
 =?us-ascii?Q?iDd6PtG7x6sQdvifvLUuvdHJaE/K+NmfThnq5w/SgIc0FgaaILA6EFj4C3MN?=
 =?us-ascii?Q?p4Kvsx13nDS7heqYrSjRrtQsqf38HFmi+id7/7NTM6gBxGV1BFgJhKZBHQwj?=
 =?us-ascii?Q?xJqqRzYwFisrv4F2N1F0o3l1MwsS28UqLn6sAFIL8mJHElsq7fBmWcgf9U5m?=
 =?us-ascii?Q?LwyUk0r4R1pHGHlZbIwOQfJ4e7RR4mPt0UxgqVX1YhaO9iAw4U7UCaKxwpCw?=
 =?us-ascii?Q?kT9Ox2Wvil5KBghZAangcVMn/iuBfjPYprNGN7kUYKaRi4OAhZ/z69KroD6x?=
 =?us-ascii?Q?hQY0WfdipKyoF+UgUl+71BEOyJMpp1TnYABDt7No17DrOYvNJoEse4RxJxHl?=
 =?us-ascii?Q?ApFJKLqjWeOzLglnB3tryT7HnRR9E8lSNs0Rbjo3ti98LoHvCXYgo5Pcgick?=
 =?us-ascii?Q?xjAScO1286t3F9kcEPhlSkFYDQ4gAzJqPjEZXkQPu1dKms8C3TXIDo/oKmIH?=
 =?us-ascii?Q?A8V9g4XA9kPJ+T5GbHQlXOGjatu6v/ljedYhKZJWW0bcGljlkt/fsvF53Wxb?=
 =?us-ascii?Q?CocG7d3oqIRbOJOup4bIN2BHmxddMToL0JVpEX714lq0GwAFzg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400017)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 20:33:32.3424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 392a10c9-9879-4f74-06e6-08dc8667eeb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8239

Implement non-power-of-two denormalization for Data Fabric 4.5 in the
AMD address translation library.

Tree:
git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git
Base commit:
dadc295cbd03955cc1ba55af55e23a06713d1a5f
(origin/edac-amd-atl)

v2:
  - Fix compilation error.
  - Make remove_base_and_hole the inverse of add_base_and_hole.
  - Move all map validation checks to validate_address_map at the
    beginning of translation
v3:
  - Fix bug where the legacy hole was not getting removed properly.
  - Minor rework of functions for matching the normalized address and
    logical cs fabric id.
v4:
  - Merge common cases in map validation function.
  - Fix map validation for cases that don't have explicit checks.
v5:
  - Add patches to add a pr_fmt prefix for the driver and share the
    internal.h header with the FMPM driver.
  - Don't fail to load driver if DRAM hole base can't be read.

John Allen (6):
  RAS/AMD/ATL: Add amd_atl pr_fmt prefix
  RAS/AMD/ATL: Read DRAM hole base early
  RAS/AMD/ATL: Expand helpers for adding and removing base and hole
  RAS/AMD/ATL: Validate address map when information is gathered
  RAS/AMD/ATL: Implement DF 4.5 NP2 denormalization
  RAS/AMD/FMPM: Use atl internal.h for INVALID_SPA

 drivers/ras/amd/atl/core.c        |  50 +--
 drivers/ras/amd/atl/dehash.c      |  43 ---
 drivers/ras/amd/atl/denormalize.c | 561 ++++++++++++++++++++++++++++++
 drivers/ras/amd/atl/internal.h    |  48 +++
 drivers/ras/amd/atl/map.c         |  97 ++++++
 drivers/ras/amd/atl/system.c      |  21 +-
 drivers/ras/amd/fmpm.c            |   4 +-
 7 files changed, 755 insertions(+), 69 deletions(-)

-- 
2.34.1


