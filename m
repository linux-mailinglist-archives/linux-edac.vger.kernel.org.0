Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC1C466F71
	for <lists+linux-edac@lfdr.de>; Fri,  3 Dec 2021 03:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbhLCCD7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 2 Dec 2021 21:03:59 -0500
Received: from mail-bn8nam08on2060.outbound.protection.outlook.com ([40.107.100.60]:57336
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233682AbhLCCD6 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 2 Dec 2021 21:03:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bl29hEM76Vh0Sfz01357VGb0QhjOINaXQY0QPk2xRhUqVbcc5d0kZ0WvzH82WEjCxpF3QBomCt8m3VZSAOgQQqjq0rfjBAEiJHIs/JgpVqn/5qbxnfHrUGKrVCLHMnfi2qLoxoEgJaya3MuyI7RbengGfBKBCiSp3sA4LCPM0aZ1PPwoSSK2E8Ia+hVjn1r5XGv+FOmwrNhbwWqrX9jG/LDnPSj8L6EsG1lVQUGy7B7q8fNG2gWNub8sAY1TjeYCLgPRE8yo1yzTpjJwaWjKMcX3NCX5KlNaScsxfcmC0JjYRH18RCNtHGUQn3v6JQr71XWa2EX1WIk8EaROM/TfkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rqsTCzrLiri0pkLwOcx9P9w5rs2jJU/HgL6AZHp0//Q=;
 b=dRKE5XSai8Ps7EYAhWuT4BBRgVUQinJ6qaiUET42I3WBd5w2XI9/oC/wHfX4Q+1jsL3T+zQ4oC/NN3IGGa2wbuMm/o5O7TVbmbUC8ebUkwgEWBFVJ8BgH2D6R2hM2QnouudF65TVAm7Jea6q7I8iBk80wWAUvRMq30BvYjUX/VUevxIFUUQcUFSWO19IuP7UKJXZft0SEf3foaPToG+vVoYkx9p+L66DtLco9ZlB2kcSS18/EdNS2/tpDrHLPfm4t4oD24HqYUpZdSYRLgTMMbhvPseYXC9xoSYw6bWL/1GpXUnlpz8r8kQxYtgFNxu6JzsOVi9GQf/v2FB2zcHEkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqsTCzrLiri0pkLwOcx9P9w5rs2jJU/HgL6AZHp0//Q=;
 b=M0Em739m/3tt6LvOCl4N+S6mknRUrQP+6yc0hgEgXIqVm8PRuvvE7zf7quAbYo+YQg2VacYFpWWnA/jqNJ/imNK7JHvYQ5S0+CTODjVJiq216b6FZovD4siX5dnF9X4fmh/5uWOvnd6cL6EA8valZAKOUlabcuGjU9Dig44wG34=
Received: from MW4PR04CA0148.namprd04.prod.outlook.com (2603:10b6:303:84::33)
 by BN7PR12MB2755.namprd12.prod.outlook.com (2603:10b6:408:32::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 02:00:33 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::72) by MW4PR04CA0148.outlook.office365.com
 (2603:10b6:303:84::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Fri, 3 Dec 2021 02:00:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 02:00:33 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 2 Dec
 2021 20:00:31 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <mukul.joshi@amd.com>, <alexander.deucher@amd.com>,
        <william.roche@oracle.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 0/3] AMD SMCA Updates
Date:   Fri, 3 Dec 2021 02:00:14 +0000
Message-ID: <20211203020017.728440-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 752419ff-e838-47f4-c7be-08d9b600b0de
X-MS-TrafficTypeDiagnostic: BN7PR12MB2755:
X-Microsoft-Antispam-PRVS: <BN7PR12MB275539BA3F2DDB55877728B3F86A9@BN7PR12MB2755.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SKths6R0aXk46hZT2M5Uvia2KygdQBnH1LReoxYA3pVx7Lun6FlMz1tO7XC2Q6NNqRS7xsCmgHpG5IFCj+eWI9koG2tLSNNNzLr+J+sqWjwbQNOVdpp3EidRCEP1n04oS+OI8FgC9IWN3PZoL0o4qgsCMAigxIMvBFeT+iVOkkCXbCiLL816MtYj+oZj0p03Fq8q0JRg+wqX0xfazzyEJcA8DJcWCR5yUrXTJwKGE483fQAOEMmyfH29TwMOis9C+7DIQtRtEGS0o/O9wGY66WG8hYncF/DfRKbAbLRWIE/JqJ1MmCr084vJMQ3ecThxe1icRuHXXrGx5PxK4dYzTu6XLUu0u2eostTLZO4FdOBNzk9g4pnAhNMgN4AULxHHGEoR7TbqkOsmRrfI79D8ny25xJ/bL620Aw+pOsVCEMcqv7Q6THOLQ0d0VPylHWSDN9hK+uxvQIoJ4lmGTB5zb8HTt4rbi49aLlHIqFXEE5sla9VTbuyMVc73io+XNxDpaDH9u6jKnWFzKmriA1rdvGfFCq1gKHbCrJ/7Gmeqq1GK6ayorYzIdkyGt3YwVuqHrtVRPgugeA1vAzpXr0DenSPQeXEvly+odRKY2QCYahq+st7zjJZhPvW46zM5GL/XQpM2X3oMRqVvg0f/ZavcsbEN7pFEFYbsurHQP/oznrHkFHhls3rhosIQZRBZSEdhB+wsJyJwigkTBWo+gcfWhmbAi9eDzxTEJgfmqB017BIaFV1YJs7hXIFF/v8jup/O0WsWkB//iY/mvdcuuzqN8qNJUsJG4Ac8iztVtyY8or4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(47076005)(83380400001)(82310400004)(86362001)(36756003)(356005)(81166007)(8936002)(36860700001)(8676002)(6666004)(54906003)(26005)(7696005)(4744005)(1076003)(2906002)(336012)(426003)(316002)(16526019)(70586007)(44832011)(2616005)(5660300002)(6916009)(186003)(508600001)(4326008)(70206006)(15650500001)(40460700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 02:00:33.1718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 752419ff-e838-47f4-c7be-08d9b600b0de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2755
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi all,

This set adds supports for SMCA changes in future AMD systems.

Patch 1 adds an "unknown" bank type so that sysfs initialization issues
can be avoided on systems with new bank types.

Patch 2 adds new bank types and error descriptions used in future AMD
systems.

Patch 3 adjusts how SMCA bank information is cached. Future AMD systems
will have different bank type layouts between logical CPUs. So having a
single system-wide cache of the layout won't be correct.

Thanks,
Yazen

Yazen Ghannam (3):
  x86/MCE/AMD: Provide an "Unknown" MCA bank type
  x86/MCE/AMD, EDAC/mce_amd: Add new SMCA Bank Types
  x86/MCE/AMD, EDAC/mce_amd: Support non-uniform MCA bank type
    enumeration

 arch/x86/include/asm/mce.h              |  26 ++---
 arch/x86/kernel/cpu/mce/amd.c           | 114 +++++++++++++-----
 drivers/edac/mce_amd.c                  | 148 +++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |   2 +-
 4 files changed, 228 insertions(+), 62 deletions(-)

-- 
2.25.1

