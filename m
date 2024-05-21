Return-Path: <linux-edac+bounces-1081-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6F08CAEAE
	for <lists+linux-edac@lfdr.de>; Tue, 21 May 2024 14:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3628283D74
	for <lists+linux-edac@lfdr.de>; Tue, 21 May 2024 12:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24069770E4;
	Tue, 21 May 2024 12:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WsZxgTiw"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567031E48B;
	Tue, 21 May 2024 12:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716296091; cv=fail; b=gePjvWgJ0bQwRXe2IeZ9AciIzmmJtgM5OGKkspDMaVKr1Q8CZ6aI6c45NAEnOa6G0J1tnmOsRoZ26RSDFrqeG8prfSWg06yV33f1AyOxTRRwH06MKA4qN5yE3+e0HOPScsfx/Yg3herFC/ssdhnQBXSJBlezkZKYARIEfu0byOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716296091; c=relaxed/simple;
	bh=Y8I8k4keWkcG1D12AXcUFlRd0Ha86wUAhdNLE+qeJmk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=po+zOGnUwynkZOU8s1WDNUIOpZIwrx/OvEEDfwG/o13Btx/tq/TkKtqJ4kxgKuW99iGU7cYFYdHHTcXG9pHE/8QbCsFVcy22sVUye5HS8JydOaOlOMLmzsF/XwxOiH69Eu59b+oMdz7PFDCiLJ/CmvCaQY/L6IUQRl982Ctquv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WsZxgTiw; arc=fail smtp.client-ip=40.107.236.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TzhyXN44jKTD6gHV5oF55pVCHBlVedwKIR2eteoDGQCYn7hGUdP8pv5Ow2N/UQDFKxQQ9XwS8br+s2uJ28iBNcP9MwU401LBAV/XK/Kvr1zE1X3l0f0pzHd4AF+n/6/m8VNlGPtz+2Db4Zwx+V1T+BqCt1/l+Q0/OfBuzt1NEdi2bLkagp73XIpTqWTgrtVjlteJcmTQ/ndZFO1aTM1mC1gIfwEMHWI4zaUeFoaEGhBlp5aAjaEPPRUpALfcPK4ueEl3puF/KHCCkSbx3yssW3TwMMDRDbOtPqWewVDNC0VWMMo7vlUvV4RLTX5C8b9yQyO9E5bVCKLGYV9hXtxdhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=teLstv84Gv6bGSTI9Yp5gyXOcgjWW12CtPodeYFvr1k=;
 b=IGq+uihyXht/cxaTs+gFDUNLUdjuDEXlbDRc6Tnu9uakKUWus5KzlZJmpasC076k3sOTe9eHLV/imcOwyE+pCGKQjcuxu16OQ/XaUPxGiHxCxSLG+rzTrVpmSFoWBficMGJfg4j9rq0R1GjtMMl9kyrp8HVfdyb0hp4T76Lkg65bsKtJel49j9HZ/pZpH46Sy7q5a4KX0dDcuj11W+zvQ46nzDesIxec6QalEkNm4eH+bKGXyCmA9UMVc0eU+W14XMa4brOkauQEXPjjixE1OYwY2vA96tN50DOtSh6r/QOIqKbIvu+OtH06HAVj4Mps16n99Ooi2rczgK0azKKD8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=teLstv84Gv6bGSTI9Yp5gyXOcgjWW12CtPodeYFvr1k=;
 b=WsZxgTiwzy7bF8ERbKJEka7h8M7qF0+4sD/8fm0PfyYwCb+V6SwMIYMHUY/zjo29AKuToBJbdMNNbIcEzkXf7cmuBl3EhNWopHbBqshpjPrsxilVyeCey4hFbkxPg+bZrvKg8SLS4uEDcRlxSEB+XMYeLPOkwiV4YywlzhX10WU=
Received: from PH8PR20CA0018.namprd20.prod.outlook.com (2603:10b6:510:23c::28)
 by MW4PR12MB6731.namprd12.prod.outlook.com (2603:10b6:303:1eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 12:54:46 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:23c:cafe::a3) by PH8PR20CA0018.outlook.office365.com
 (2603:10b6:510:23c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.37 via Frontend
 Transport; Tue, 21 May 2024 12:54:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Tue, 21 May 2024 12:54:45 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 21 May
 2024 07:54:44 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<avadhut.naik@amd.com>, <john.allen@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH 0/3] Rework mce_setup()
Date: Tue, 21 May 2024 07:54:31 -0500
Message-ID: <20240521125434.1555845-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|MW4PR12MB6731:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ca2446b-ee65-4880-908c-08dc799530af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QrR0vnHYwh4LQgkoZU8EPSEGdLsqL3QoYVKAV6kOrgUorpdVxF1zyEFSSqPf?=
 =?us-ascii?Q?fwD9yscEYTrdPGYYGEU+of1vs+4In2Nd6yGZ2qy/phMN9e9WVmQIDl3qWp30?=
 =?us-ascii?Q?WNukMoIfupM6RSPNKFPb02x1SjEv5p0dZqavoGmXcDs8A59cnRQ+hcEKHDLl?=
 =?us-ascii?Q?1Z4qYjuYFH6KIEM5jPvyJDxJ20IpcdHnokU0qaUjsHfJClCfAy1FXlwWsV4n?=
 =?us-ascii?Q?Ze/U3hv2eSbaxc9sDPZ4WMUY1oA4y1+hg52JywStp8iAz8Ytq1D+Pcl6v4BD?=
 =?us-ascii?Q?Fhzxc2ewlZefmnFwwf7X3Ve515GBFq2Z9/0LQPiZCHZhMtZkqDZlgs7QI05K?=
 =?us-ascii?Q?pW4MRTgScwShxZ7N8h7YcVATioJy9psuUtQV3OtQMEElGAoVq80V4dMkSxjZ?=
 =?us-ascii?Q?teASsks6ge4xIqT+nZOfG4Tw+OiYUQupov6pvXWM6fasI24ybNL3A7L6I5Lf?=
 =?us-ascii?Q?eMV9+JkKbHzqyRl6r6XCfBv+B0dR30t5Ph0CafsTkTXUY0hXIw07nt5D8UUX?=
 =?us-ascii?Q?AbshGNHYEgHBWNEgGhC50ofy5TLRGLynYb93qGMAs01CBFoQcaKSck2Wpy9Z?=
 =?us-ascii?Q?HtQvDVw+17zxVkuxNUg2EqQ1RwJyarJ2szD0VyLLlgJmDp4LF0cfLjmP9wxC?=
 =?us-ascii?Q?IiBTEYu3OkEWvSJfstpzHJMQd4YsyDiWDZpWzLf/ngmyTbHtDo2Dd3ziktgL?=
 =?us-ascii?Q?zDCaluFbE1S03kJcYZUJYJfe2j4s1TfCA39iEJrs+gUzI7lphGCGmaE03zrD?=
 =?us-ascii?Q?TtvevHso0sBlkw9B1HpV2UPplUhnL1Nw3msanKZzl/+A2PBWU5bVPe37bkut?=
 =?us-ascii?Q?sZhKHpaQ9q+PuXYnbePoiFF7EStOmhneViVsUeZpqDJMyUTD2q+dU4wbgrwH?=
 =?us-ascii?Q?7gLTdcYWY4hyVDYrSOfjsfd3NhHBHMrxNsaMhvwz0XEbOGrv97cfOceGgfwl?=
 =?us-ascii?Q?9mmdpM8KOOArT4ze8OtiLqR/p5a6A2n0m+jobPHinOXLP7qfy2PPAhAypbgu?=
 =?us-ascii?Q?zuy524fQN85wIz8ZUdWX5BxsKeyK+0AeljSx6TfzEXQXiOfzNGL8x0DYX3Wy?=
 =?us-ascii?Q?vtJUZDqgWFFk3a+bxi9QWE1tLy7b/4N/lCCG0k/tSJ3eeezxEUVE8CEV99gc?=
 =?us-ascii?Q?ORKIRfHgs7cQIpmfl7FWWBAToBe47wheYgRqE/gV8/qXpJoGvnZjwl930ehE?=
 =?us-ascii?Q?rPKn8K5mA21Byx21hmicEypIF5KDZ6WTYstWaLaKKiYhCUQvlk8p6vbTDggW?=
 =?us-ascii?Q?RiTF160i274W///titMIz70x8xg2k0cSYUXwZFXJttDP6C3gPxwGx05TegFb?=
 =?us-ascii?Q?c3PWv8b6VlFzV56PWpTM0ZjL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 12:54:45.2574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca2446b-ee65-4880-908c-08dc799530af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6731

Hi all,

This set is the next revision of the following patches:
https://lkml.kernel.org/r/20240404151359.47970-2-yazen.ghannam@amd.com
https://lkml.kernel.org/r/20240404151359.47970-3-yazen.ghannam@amd.com

Patch 1 does the function renaming that Boris suggested.

Patches 2 and 3 are mostly unchanged except for rebasing on patch 1.

Thanks,
Yazen

Yazen Ghannam (3):
  x86/mce: Rename mce_setup() to mce_prep_record()
  x86/mce: Define mce_prep_record() helpers for common and per-CPU
    fields
  x86/mce: Use mce_prep_record() helpers for
    apei_smca_report_x86_error()

 arch/x86/include/asm/mce.h         |  2 +-
 arch/x86/kernel/cpu/mce/amd.c      |  2 +-
 arch/x86/kernel/cpu/mce/apei.c     | 19 +++++++--------
 arch/x86/kernel/cpu/mce/core.c     | 38 ++++++++++++++++++++----------
 arch/x86/kernel/cpu/mce/internal.h |  2 ++
 5 files changed, 37 insertions(+), 26 deletions(-)


base-commit: 108c6494bdf1dfeaefc0a506e2f471aa92fafdd6
-- 
2.34.1


