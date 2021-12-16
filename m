Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDDC947790B
	for <lists+linux-edac@lfdr.de>; Thu, 16 Dec 2021 17:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbhLPQ3X (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 16 Dec 2021 11:29:23 -0500
Received: from mail-bn8nam08on2050.outbound.protection.outlook.com ([40.107.100.50]:33952
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233799AbhLPQ3W (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 16 Dec 2021 11:29:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IkI9w5QSlIH8EDXhP3fZaSrwNuJpVdvKcYexiuIRkFkYcMCjOkkdNENjhoQAivL1gLduCClomJsf+HRBtAHaMdPCJ+dkmB4qB3KK6TF2R0aK23VVmAKX76I+0l10N9vRULP60Wy88XcEN4YypIj/HtIgFvW3w+61tWFp8CUlMfsDd++h1NNhcDhqCEn6CQRu/Q8HzA5PX6eQgyqZkMJ06wjxnDU2bq2VRmm0ng1yG6/NPf3rf9No5uDm7rlsq2G82ohVhxEZTwnPcyO+mShcuhYBeXh1qJVdZ7b5HtRpimmgFgmGMd23pAlKITOTyDGx7v7qyDioAtryVa30JKvNyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Ea/5TXLcJTTjKzQnKLgMwdXTGE3SKJ4H7R751Ax9Tc=;
 b=daUg9vr+ZJxuGku3afmNtL2Or6H6S7fWKvM8hbVZf84QCUSttY64iHTb1F93T4E+XuTMbWF93D3RQElIlC/kQdetmMstL9wmkACdBfD9wPSruD4Q2yrJadz92EZHytWkJpFW+Ko6EvRjbWqzT2tqK9t//fhhZCnZiIFxyKLlSxA2Uk9hs2TNFxW9nz8qhKEnQKg6QUIjdNRG2i1DCkEN4GjmErWwRPM1fnhdilahijRuq0QFcEvp5WWPQGrt6SptI5y0KuXOFtBLwAsPzsAxAurWgI64B2Phd11ycihGdV3eweUgs+zYqtPHIWgkVvFklf2e4wp3ZoH42dsai36gHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ea/5TXLcJTTjKzQnKLgMwdXTGE3SKJ4H7R751Ax9Tc=;
 b=tB3vODsbA8PywpzKUvck9nSGXFbYJZIhyvfXiSHiCzaORX1c7ZH8ZR6wvjEribOW/oFp5rOF2AgOTWonN3yK96mJ1BOl1yWGSr3mU5N7fx5P5wldTrmHleXtswattgA14T0STZ13eeB5/aDYcLGOlEF+Nhp2Hbayp6pb3k8Puds=
Received: from MWHPR20CA0005.namprd20.prod.outlook.com (2603:10b6:300:13d::15)
 by MN2PR12MB3967.namprd12.prod.outlook.com (2603:10b6:208:16c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15; Thu, 16 Dec
 2021 16:29:19 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:13d:cafe::e5) by MWHPR20CA0005.outlook.office365.com
 (2603:10b6:300:13d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Thu, 16 Dec 2021 16:29:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Thu, 16 Dec 2021 16:29:18 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 16 Dec
 2021 10:29:17 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <william.roche@oracle.com>, <alexander.deucher@amd.com>,
        <mukul.joshi@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 0/2] AMD SMCA Updates
Date:   Thu, 16 Dec 2021 16:29:03 +0000
Message-ID: <20211216162905.4132657-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e1daeac-ddeb-4c5f-e50b-08d9c0b1357f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3967:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3967296CD8682679F58A714AF8779@MN2PR12MB3967.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GTbnXUOgEOIjCIo+c7lfJVMsMQ0333TdGuVUn8RInSgW6aPsYR6hIVO/xNUe0FL0AQadhCLLOqaD6wy7LNkeBKfgQfaCqn+pG18v6+Eh/FSEutEwNGS6zMHyeOO0ngJOUftk9mvSINJhlMFoHC+1/85rbMw4QyqMw8v+nBbtLvREK03qtRnwaMhZGFNR/1jmQxKXQaa+z8HeiVZa0T1AiZWPeg/61DO8UUA3sikgGL9TqXMLFevP4Xt2/RA2OJK35OA8BInXUDWNEkdCyY3Mq1thm3f9+W1+aX0LYpolZkZEH5NVS8E46LG18lmxR6hA8BMZe1HSf7zztoJYFcLecDduiupw9Hy8NdDD1zORKV6i+8sDTe2iTc5WmxdOgq7luwGe+FrgEInRRizaINNewkkNDmFg4CzIjtppzWY5bKJeJXSpm/h0NVatIlSYqKBciNePucKqgQFWWiMEzO9G2xgdSqj1KkjjTzVGrssqhM8De51M5rT0B62N4miV/EUTdz+pK3ZMzCA3gvQhh/UJH0AGPrPihKd85834JyuzszNBhHyrOwWmkl3yd2b6vihwGXU136t5aCCjp2v0RFxl+wJ3uAHCLPEG/HFvTmoqUwWqEi840VPEQC5CmLiTC4cQdZt7bPSnaTZK8vKLymqwgV2J7hmt5TRMTx0V7dSAbMYFUw+iTfHA8GIBDilfvxbSriSeNziRwGeGt6ClqwfYlNqybvBiWbJAK3iThxH1ZL4txrvCUHTlJtzgMI03TBOpTm0YN24BhzpqQNBrNWcH5AeUAuUBRqJxbWeO/EtJ5AgpQzb8GS3jrC6v7fxfKRF0oT31zT9PhyP46PW6WOfsFciG/+/cVKhbxO01Los5K5hov9D2yoQ1OyN8syvGJBLuA3Nufm6iPnL8b6LvpQ3j3fm6OuNm1P8vTaTnL2ExBlQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(7696005)(5660300002)(6666004)(4326008)(70586007)(47076005)(186003)(40460700001)(44832011)(2906002)(16526019)(83380400001)(2616005)(6916009)(336012)(356005)(26005)(8936002)(426003)(54906003)(15650500001)(316002)(82310400004)(70206006)(36756003)(81166007)(86362001)(1076003)(8676002)(36860700001)(966005)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 16:29:18.7235
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1daeac-ddeb-4c5f-e50b-08d9c0b1357f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3967
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi all,

This set adds supports for SMCA changes in future AMD systems.

Patch 1 adds new bank types and error descriptions used in future AMD
systems.

Patch 2 adjusts how SMCA bank information is cached. Future AMD systems
will have different bank type layouts between logical CPUs. So having a
single system-wide cache of the layout won't be correct.

Patch 1 from V1 was dropped from this set. I plan to send another set
for the thresholding sysfs updates discussed here:
https://lkml.kernel.org/r/20211203020017.728440-2-yazen.ghannam@amd.com

I expect there will be a few patches for adding the new interface,
removing the old interface and stale data strucutures, and documenting
the new interface.

Thanks,
Yazen

Link:
https://lkml.kernel.org/r/20211203020017.728440-1-yazen.ghannam@amd.com

v1->v2:
* Drop patch 1 from v1 set and rework the remaining patches.

Yazen Ghannam (2):
  x86/MCE/AMD, EDAC/mce_amd: Add new SMCA Bank Types
  x86/MCE/AMD, EDAC/mce_amd: Support non-uniform MCA bank type
    enumeration

 arch/x86/include/asm/mce.h              |  25 ++--
 arch/x86/kernel/cpu/mce/amd.c           |  87 ++++++++++----
 drivers/edac/mce_amd.c                  | 146 +++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |   2 +-
 4 files changed, 202 insertions(+), 58 deletions(-)

-- 
2.25.1

