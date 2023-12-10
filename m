Return-Path: <linux-edac+bounces-226-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC72580BCC7
	for <lists+linux-edac@lfdr.de>; Sun, 10 Dec 2023 20:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85DC1280ABB
	for <lists+linux-edac@lfdr.de>; Sun, 10 Dec 2023 19:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F07C1CA8A;
	Sun, 10 Dec 2023 19:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GGlfhLEz"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4861EB;
	Sun, 10 Dec 2023 11:49:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKV9mk6jKlG1qEnoSMEGJ3sxp3wGkUnDtinsElpx8SyuDYdz1NpsJb7iesj4OZpMmlLDRO4c1u2syoAqj6nShgZSzQfNV4n/N7aPI4VqkanjcHzATMh8YWTyj4HMZQWpgsA5YIR48IzvOROhPeNOqdKlGjL8Cj1bPgWTQFZx3V6S6N+t8tXMMLwC9Pypog+MPpk/n68xAAbsZ1lbKSWTFUVRYVZ3oTEIXvedXoVEDdbiJk+oDjAvybLlfKq8Y3MOueoFEqGIZs3oZ8jySHwW7yVdA4we362V0yRbJxlzo9cMmWnRIQaYKm6ZTlMWTdlUj3rACA4pXX8iaEk+PKJXaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tg4dQY8MDVcnN5rdcj57oKHO6dRCKZjsksjtPGZraMo=;
 b=j0iUenGC6Ub41VGHE876MmxX4h9vxSbH6U+ee//WBMiZKaACsJ4skUKJiV4oF+FQX8IJxC+D+JXw1M420d+RdYVA4FZ5Cykd2p3lpTagDODxPS0+CLX6nnWy9QBXAtFVRz5l65APvSalDMixhRNZP6XhEnlw4WYm5AkTOTLQmm/xY49raBWzPB/Ry02inOEFWaULrMhkduY0/1KD6uajySLkRs0VOqt/ZqgGDcTF3xYMJAy5Ay2guV4L+SDQlK71cMKnQavZT1OHuvG1Lcm3ANx5NTuizoRLaiFhNa7UFPXH13VaJ2ROSUqInH9sw7gJjCqBopvHOcDRyC10ffmuCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tg4dQY8MDVcnN5rdcj57oKHO6dRCKZjsksjtPGZraMo=;
 b=GGlfhLEzDFwuBJlbMCuvGnQN7Cv1p/WSz1PQQJqPVKPzbrG/mqB62DjYKxAAyW/9RnMVbNzkUuECbBuLALp1SUNxKQ38REdUt73cEhj1egM7xomScmM6mC9kMgieB2AheKl1zgUj6BUGMSreNGo9fX+b3HhR0+yEdK6mMtZNrtc=
Received: from CY5PR15CA0241.namprd15.prod.outlook.com (2603:10b6:930:66::10)
 by BY5PR12MB4257.namprd12.prod.outlook.com (2603:10b6:a03:20f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Sun, 10 Dec
 2023 19:49:45 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:930:66:cafe::92) by CY5PR15CA0241.outlook.office365.com
 (2603:10b6:930:66::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Sun, 10 Dec 2023 19:49:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Sun, 10 Dec 2023 19:49:45 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sun, 10 Dec
 2023 13:49:44 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<avadhut.naik@amd.com>, <john.allen@amd.com>, <william.roche@oracle.com>,
	<muralidhara.mk@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v3 0/3] AMD Address Translation Library
Date: Sun, 10 Dec 2023 13:49:29 -0600
Message-ID: <20231210194932.43992-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|BY5PR12MB4257:EE_
X-MS-Office365-Filtering-Correlation-Id: e42ddb01-176a-4476-b317-08dbf9b928f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dXabKml4Ttx7AfgA9Q+0Y48WQ+548LQemoSXu1+or0jHpaD8JFR4aai9tRtBMNxXaKZW2F2QWDQiUOryCKepq33S3kjRQflEqer+Bqu1KbXMDphmIoh5gDL1aIRQuDxCd5U1boAhPKq5VjeMj6BMB2UitzOZfRurvODjoTpkCYv7+OMgEu94cUUg4j791KZWy9GDJFU1MocB6jgGq17r/pjxhInnX0YPsfXiMAPNKcQ84veO3nXh8UvDiVKkNwHATRAOHhrboWQSQoyreQue0E6V2KSx5RCxQOM7F4NQX63R7b0fGztNY8oShlLsOcoRkG356P/Dgu2+l4086eOjZOVf7BP5NwHBVZ7kaipHG9z0wN2C52QP6zBEInjJizBohcQcyHtkOac+P/hy1qv3zRpnJtIpnk1Rv03GGAn2C2pUGwcsjauZS/bQb/xhz/dMDC+N3BnuMdvZAbBAuH2UKzj1CuzkHUuZnceGZgwamBuVJ3kIL1esiYWdPNGjAkmpPLQFPqMcmQTg06cBnnDwfzYzyqR0pD6mON97EX92/D9jB85NdG8kJfghcBZSyhUCedVwjYymwncASdh1vaZEn3Wz8JeNzpxLjwO3DWlE4DL5On4eRBXYenxEGLN8FLkcfUQDQUpu9/bZoSgwWJzaELRUaKa38BkJywR0IR5MWtxaXZ6oIX2pe6YBgveB5FQVjpRqFUs23XhceOa7PdzuEjojE6Bptb6SBy6bZz6Qe3C/dAdkE9pHbB0QmWMeP938
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39850400004)(346002)(136003)(396003)(230922051799003)(1800799012)(186009)(82310400011)(64100799003)(451199024)(46966006)(36840700001)(2906002)(41300700001)(36860700001)(36756003)(86362001)(82740400003)(356005)(81166007)(2616005)(336012)(426003)(16526019)(1076003)(26005)(478600001)(6666004)(7696005)(47076005)(83380400001)(4326008)(5660300002)(44832011)(316002)(6916009)(70586007)(70206006)(54906003)(8936002)(8676002)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2023 19:49:45.3092
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e42ddb01-176a-4476-b317-08dbf9b928f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4257

Hi all,

This revision addresses comments from Boris for v2. The most substantial
change is how module loading/unloading is done for the library.

Thanks,
Yazen

Yazen Ghannam (3):
  RAS: Introduce AMD Address Translation Library
  EDAC/amd64: Use new AMD Address Translation Library
  Documentation: RAS: Add index and address translation section

 Documentation/RAS/address-translation.rst     |  24 +
 .../RAS/{ras.rst => error-decoding.rst}       |  11 +-
 Documentation/RAS/index.rst                   |  14 +
 Documentation/index.rst                       |   2 +-
 MAINTAINERS                                   |   8 +
 arch/x86/include/asm/amd_atl.h                |  18 +
 drivers/edac/Kconfig                          |   1 +
 drivers/edac/amd64_edac.c                     | 278 +-------
 drivers/ras/Kconfig                           |   1 +
 drivers/ras/Makefile                          |   2 +
 drivers/ras/amd/atl/Kconfig                   |  41 ++
 drivers/ras/amd/atl/Makefile                  |  20 +
 drivers/ras/amd/atl/access.c                  | 106 +++
 drivers/ras/amd/atl/core.c                    | 217 ++++++
 drivers/ras/amd/atl/dehash.c                  | 446 ++++++++++++
 drivers/ras/amd/atl/denormalize.c             | 616 ++++++++++++++++
 drivers/ras/amd/atl/internal.h                | 312 +++++++++
 drivers/ras/amd/atl/map.c                     | 659 ++++++++++++++++++
 drivers/ras/amd/atl/reg_fields.h              | 603 ++++++++++++++++
 drivers/ras/amd/atl/stub.c                    |  78 +++
 drivers/ras/amd/atl/stub.h                    |  34 +
 drivers/ras/amd/atl/system.c                  | 283 ++++++++
 drivers/ras/amd/atl/umc.c                     |  45 ++
 23 files changed, 3534 insertions(+), 285 deletions(-)
 create mode 100644 Documentation/RAS/address-translation.rst
 rename Documentation/RAS/{ras.rst => error-decoding.rst} (73%)
 create mode 100644 Documentation/RAS/index.rst
 create mode 100644 arch/x86/include/asm/amd_atl.h
 create mode 100644 drivers/ras/amd/atl/Kconfig
 create mode 100644 drivers/ras/amd/atl/Makefile
 create mode 100644 drivers/ras/amd/atl/access.c
 create mode 100644 drivers/ras/amd/atl/core.c
 create mode 100644 drivers/ras/amd/atl/dehash.c
 create mode 100644 drivers/ras/amd/atl/denormalize.c
 create mode 100644 drivers/ras/amd/atl/internal.h
 create mode 100644 drivers/ras/amd/atl/map.c
 create mode 100644 drivers/ras/amd/atl/reg_fields.h
 create mode 100644 drivers/ras/amd/atl/stub.c
 create mode 100644 drivers/ras/amd/atl/stub.h
 create mode 100644 drivers/ras/amd/atl/system.c
 create mode 100644 drivers/ras/amd/atl/umc.c


base-commit: ec00e2ed1bc2d6ed6a65ef2b1030ba3ab1575733
-- 
2.34.1


