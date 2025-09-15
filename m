Return-Path: <linux-edac+bounces-4806-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDABFB586A3
	for <lists+linux-edac@lfdr.de>; Mon, 15 Sep 2025 23:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9301F201E15
	for <lists+linux-edac@lfdr.de>; Mon, 15 Sep 2025 21:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BC42C0F61;
	Mon, 15 Sep 2025 21:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uewUyl3S"
X-Original-To: linux-edac@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010032.outbound.protection.outlook.com [52.101.85.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A4614AD2D;
	Mon, 15 Sep 2025 21:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757971374; cv=fail; b=eMvhQx3CHgmVvVZ59E1b3Emulov7MF9H7eAGLM0uf9yv122DKleaCJw3NDjLlzIpWatbNwxw0MelgSpnXRFR47VwxHKHZXJ5Z+V6YThAAsT5mLdCNAOrOPD9JMpZMUlIreRtPkXx8V2vXAmCNJ5Ry6Legho6uzuMpQ3Ld/LxLiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757971374; c=relaxed/simple;
	bh=EMigTDxH+p5vmTP2yB+CC7TihpMxXfhuVSCnMiXLkJM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=APFiuXu56qRZL+mqZr9kXZmV9b/2nLP4pVB8A6F/8YWOGbs68gHjjqgAJaUNEVWJC0eoNNbLcaZX9TVMiCTczXdrdj9ooHVzqagst/CdFtrqkDBV+ZUwJgFxJ48LsjEtfjuZHmdrX1JaWCefHy5B4H9EVgVG34GAOhyipJTq9hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uewUyl3S; arc=fail smtp.client-ip=52.101.85.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X90g9od8xA5X1CqaATpwNDUVSSjLEJBC9fKmkq1Y7Vnm8FHN8Rm5g2PPRaeQot0Ooc3BexK3nmxVCSR+7t7cADq9ufc2zPfr+2zQtSb46LjHbYUaz9sRjLpJEReykHHEqv9WV+dRlkUNuTT0h/W2Bpux8pKVMMQ7nPLnAz2Oono7p59pgC56rUOCWtPbTXLtq3RhFQF7lu8NxKpN9Egq104QnSindndAFME+or63wr2Hrz1dmxzMN8uHvagk4c1tkUk6LeE700j8gZfDBw9OfyaF3N4AFX28DJ3m6x9V/iAPk2pH8LrxzAV594jZiFoV2F/sESywEwU6cbN7XY+vpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5SXCcgh/1r/lA6FN1cexDodpAkrv4VQvgXQCprcCFg=;
 b=bX8fMOEl+tx/No/rvgbnqP5GSfVV2KO0GDXvFZfCrgkfmalHYlRdXrM6wLCH+qtGK0Sy1AY9U0Yq7oy7uuxffsOToaMypRJGjEU5AWQjo0IOhwOvEGSxlbhXuG0vuTXb7Vrt69OJ5rtu7s04alVusRSszgfYWAlZNG6szhgQJ0iRPFPDs9b6aCz+8Ar6qioAXIHSzAqK7aE4F1pO9M7XlXBgX3HMoLcWc76sfm21qOSph0UgSt7UmQFDzT4C5xE1iykKgR6KfJCyVmVtKCtp8FEWLSx1NR5766EaRiTI18v5bSGO9vfZowzMyInzC/oMMgnhRXH96y1CFSLPPpw8VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5SXCcgh/1r/lA6FN1cexDodpAkrv4VQvgXQCprcCFg=;
 b=uewUyl3SBxW92j2ZgUfL/Qww7u4ih3RBU0ugY4vvtcuxQD1/eKkiSbnqrIo+c0KruvO629MKVdOdvVRBgS9xMXCk6Criu/7YyfA0JfAcPBtCribu8+xWvJqFynVEQWtePYHTlXGmtpdoDosDrdGww2exOzIWNxd71IUnrSJB3N0=
Received: from BN9P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::27)
 by SN7PR12MB8172.namprd12.prod.outlook.com (2603:10b6:806:352::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 21:22:51 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:408:10c:cafe::85) by BN9P222CA0022.outlook.office365.com
 (2603:10b6:408:10c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Mon,
 15 Sep 2025 21:22:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 21:22:51 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 15 Sep 2025 14:22:50 -0700
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <bp@alien8.de>, <yazen.ghannam@amd.com>, <john.allen@amd.com>,
	<linux-kernel@vger.kernel.org>, <avadnaik@amd.com>
Subject: [PATCH v2 0/2] Incorporate DRAM address in EDAC messages
Date: Mon, 15 Sep 2025 21:20:21 +0000
Message-ID: <20250915212244.886668-1-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|SN7PR12MB8172:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eacc707-1d5e-46fc-44ed-08ddf49e06e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?goqHXiZXW2Z+Niqe4kJM2iFhVobzhfrQM3w7uuayq0YT3tM8KtvF0zRcn+0V?=
 =?us-ascii?Q?KuU102k9cJ8A+5MQ+rOFZPebbOxu3+YBQ4fbWFmKwwy+E/iJXNxR/D/X6m+X?=
 =?us-ascii?Q?BMPDBrULtPTEXEGHB4iXl4QnVf75Jrc3oaWFEqMm6+TvdUhOKeYOIfk5Ir12?=
 =?us-ascii?Q?jt1ShPJrRaw9QYsxV31SHzAWXQ/Yth2w2/wI0aFlvTRGB3viWB8g+YoNUl54?=
 =?us-ascii?Q?8FOct57C/3ePXgwQekfH16jwGrHOtcP02AnYwh7nqzrbJnVKVH/VefRfuqRg?=
 =?us-ascii?Q?EghVU8S2RrMSZYIMmoF7ohfJIt3jM28GHqJ27+s4VzYG4HC5ql2r6An92TFF?=
 =?us-ascii?Q?SPImbrrpkUpl6aZoFnvVEhmrS5xY6WUU7NzzzAksJ+eKp2QGvA6TwURgVxPJ?=
 =?us-ascii?Q?Yp4T+OBnzY/bPv1dh18Uk2Arjp8sHcd1SkyujzU4q5OVSMwul8XiF6Pmxece?=
 =?us-ascii?Q?2COocweCeNcdqwiXZdJlsL+iu1KqBZTvHUF6aiZ5UltDyzk4P1iWgCL8F/lz?=
 =?us-ascii?Q?UKYWoTqR8nirk895febcoh9CpeJjCJac1jKdnyahMsbqPsYrGk6OofaKJFSF?=
 =?us-ascii?Q?O2bLI56we/LgCn+S/GTqs5jCUfVK7tS9Y/T7p+A5JT922XdDvLjP6LpfpbOW?=
 =?us-ascii?Q?T5FSeZGa6zTkFBIz/fXVoicsGbsF70IfOmzicHlK85Svq4HCjCB0bIyhAgJT?=
 =?us-ascii?Q?/fzEQE+7maoEIbZBOsyMJCaWbCrbnIdnrIZSfqRywu1J2JrNTLlr+K8nekQz?=
 =?us-ascii?Q?E/nDp4tsPJVlbKug5/kZ8l+277iTcPIBzKoAGKN+gKVEtX8rYyCjtb4kaohz?=
 =?us-ascii?Q?TioI3KMrXRG4FXtHW7JBckDVsU/rLmVDPbWcE1wQfO24jCFJDN1FC2QhQMet?=
 =?us-ascii?Q?Od91SAzHOod1SbYVSIaOgtHVECmDJDi4VaIS0RRaM3rPtcJNG9O+U0UPtUxI?=
 =?us-ascii?Q?ylgSrSo4WGbwP2donCqUH3yg0mTiid9YhA2ox86YLji0K6mmplO3WJFWHjwv?=
 =?us-ascii?Q?CEmDehGbp022VrDuMYSwlZ5RpkuhWwTx4PoJ9Kde3WLQvE3r/hNw6vM1tQ0u?=
 =?us-ascii?Q?rIWXUYoU1caX67QrSlG7xT3qgjBzFV+fPSaB7pC9Ev3UmWUabV120YYE4LOh?=
 =?us-ascii?Q?V6J6NiJTeBSs6snu5x0IQxJx99DcPBkcKB7qXkeDaSgGaZ5hUuq8AYcZysmZ?=
 =?us-ascii?Q?UHgtPUwYPizqDYkgkUygAat+JFoKGVJ9mObRUpdyx21qtgvNBZPKU5J0Soaa?=
 =?us-ascii?Q?GYtT6OoacteV8XFhKDQ1JWqiJ9XUg+zQdLUybuLv9BnLAcVMMyxX/a5FUGnf?=
 =?us-ascii?Q?p5u39nzjyTRgIexvVQOaPqe6sWTFkBxkctcf+PIOU8zbDM/KFgvNXoL1kODp?=
 =?us-ascii?Q?pt9wfCc2I/UatdU/VFZGk3rVEZ1muNbwlNRbsXqfueCEJz+JXcTC4TbT5Z/e?=
 =?us-ascii?Q?1fTLonhbZpUaB9C5l5Vo/tiE8AnMPvg5HVRRKuNt/JFUKriQ5tJLUr8+87pU?=
 =?us-ascii?Q?7tFBAwLiq+mq7L725rfPuUrjpfK0aV7c2RAi?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 21:22:51.3944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eacc707-1d5e-46fc-44ed-08ddf49e06e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8172

Currently, the amd64_edac module only provides UMC normalized and system
physical address when a DRAM ECC error occurs. DRAM Address is neither
logged nor exported through tracepoint.

Modern AMD SOCs provide UEFI PRM module that implements various address
translation PRM handlers. These PRM handlers can be leveraged to convert
UMC normalized address into DRAM address at runtime on occurrence of a
DRAM ECC error. This translated DRAM address can then be logged and
exported through tracepoints. This set adds the required support to
accomplish the aforementioned.

The first patch adds support in the Address Translation Library to invoke
the appropriate PRM handler to perform the translation.

The second patch leverages the support added in the first patch to log
DRAM Address and export it through the RAS tracepoint on occurrence of a
DRAM ECC error.

Changes in v2:
 - Modify commit messages per feedback received.
 - Remove unnecessary variables.
 - Rename struct dram_addr to atl_dram_addr.
 - Replace sprintf call in __log_ecc_error() with scnprintf.
 - Pass the DRAM Address to edac_mc_handle_error() through "other_detail"
parameter instead of "msg".

Avadhut Naik (2):
  RAS/AMD/ATL: Translate UMC normalized address to DRAM address using
    PRM
  EDAC/amd64: Incorporate DRAM Address in EDAC message

 drivers/edac/amd64_edac.c      | 23 +++++++++++++++++++++-
 drivers/edac/amd64_edac.h      |  1 +
 drivers/ras/amd/atl/core.c     |  3 ++-
 drivers/ras/amd/atl/internal.h |  9 +++++++++
 drivers/ras/amd/atl/prm.c      | 36 ++++++++++++++++++++++++++++++----
 drivers/ras/amd/atl/umc.c      |  9 +++++++++
 drivers/ras/ras.c              | 18 +++++++++++++++--
 include/linux/ras.h            | 19 +++++++++++++++++-
 8 files changed, 109 insertions(+), 9 deletions(-)


base-commit: 501973598d05fdb1d1089fbf3cf40b605b836e16
-- 
2.43.0


