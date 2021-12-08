Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC90F46DA40
	for <lists+linux-edac@lfdr.de>; Wed,  8 Dec 2021 18:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbhLHRrq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 8 Dec 2021 12:47:46 -0500
Received: from mail-co1nam11on2068.outbound.protection.outlook.com ([40.107.220.68]:30465
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230036AbhLHRrq (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 8 Dec 2021 12:47:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kb1z4qP1SdcK4ZE8Sbph9zlKwRsRg/OLRs6yHoOtkvwB6sPlTzv20+89NE6tfLJ0vG0jzJvsU2eDjS/27YhVETQmQ4nvV5NaSkcJMfq1BYlaP90r2UpL6OKWOEd3kAGm5Lspt+V+pSegBsH/nIu1AOYkMJIUD+Rj6c6BMQftFASzdrIL8xpQpXwXmW9Ndk03TqYKJ+sbJ9i0Y2HjcbFhHF2N0ngOF5NJJQeW2dw0eLpauOfuSY3zjuCtXX1G5M8Ac/ighILdfPfUI2nmbg9yfwp2j1w/7ixZ12yQSTva1N2QweZ+e6oDSfTCNC2plpiiDa1ZHY1Sr3epKvxfwGpMhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzd11JH4W3AAjNk5b4sB0smVcfLRiCIRsFn6Ior07a4=;
 b=TSGXNJaHpu+IO5LYdwU6+lf0TmM5B7XF9Bm9kG92K6csHrctA1q4hCNHPL3lwyIjag3L6G8GZpUsxTTyc1ObW8y0h3IapY0Zq6LU/qC/RIXToTqVFrJONIIxKAnz+8Va36dAEU10iYS+y8bPWZEgd6icOsxrSNwIKFXgLEXXvL5+mYax0gCMBmkw4LXAh8q6mSu3yXBxk4YC9er6LgKzfG7zuHsBwMgFYIulVyjTbaJr/ZoTu9GH0ffocaUAe9mNXxL+NXDFI/EQ3yVV6NQ1OboNScBzOmHfPC4HAcTaC8ll0yDsw/hDhsXumphU6KD4t4docdMWl+VuhRV/CimNIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzd11JH4W3AAjNk5b4sB0smVcfLRiCIRsFn6Ior07a4=;
 b=pocBOlZGjV7uHuObJO3hU2Q1lazi2XdKiEg2Y6y61HiWHsnTVDu1nWF/KuewRmvZFtaDBA0v173M+re6q3H93PwxYXD3Aky+k8KTHpLIwL8TVvWd4fSn6nm/IKCOj14PGccPdz8WBLYNbGQtJ0rUTDjqnOtYIjQNmCA92/fJElE=
Received: from CO2PR05CA0075.namprd05.prod.outlook.com (2603:10b6:102:2::43)
 by CY4PR1201MB0070.namprd12.prod.outlook.com (2603:10b6:910:18::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19; Wed, 8 Dec
 2021 17:44:11 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:2:cafe::43) by CO2PR05CA0075.outlook.office365.com
 (2603:10b6:102:2::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11 via Frontend
 Transport; Wed, 8 Dec 2021 17:44:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 17:44:11 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 8 Dec
 2021 11:44:09 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <william.roche@oracle.com>, "Yazen Ghannam" <yazen.ghannam@amd.com>
Subject: [PATCH 0/4] AMD Family 19h Models 10h-1Fh Updates
Date:   Wed, 8 Dec 2021 17:43:52 +0000
Message-ID: <20211208174356.1997855-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 790deb89-fc2f-47e2-f124-08d9ba7257e1
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0070:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB007019EEA4B15085B8EE83E0F86F9@CY4PR1201MB0070.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:972;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MEQg3epuP91DxPtmlnQwBhd0QDFWE6bPiMWnr9FglEsxMUiC8PgRSPO2DARqezENunHX1nne9cNoDZEvY8zu9dlJY7SXqyFPkTMZ6UEQtrdRtVmoIwJiCyq9B1Y454p4ZAZ4VX/kdZ93+xJdzOnF00mgDs6ZLDwsCtDrk/eO7CKehAxdMuu25ZU6zTTmmK+Ay9ukq98X+cwfenqNSWUBGztCgV3H7ti9HbLwvu/evYSkfy95cRhkaUpaVFYCzUbe68YGadROtX0mXdgvB6+pH7HXr8xRmK8N8UYIOKNGtxR8wozqFEChUxWmv04l5puV4kbQ+l0YzqNdcXd01k5muq489/WmTOFRjAFdUgDHgm9S2GU4UOMmwk3cV+xaDMrGnVJIsu27djsC1YuEsg/y0lNzG4Va+rU3u8ocmX+rJOsY2UFcJAk1YUe63xJAu0GH4G2vRQZ8IwxUrHIn8OdaQ5wZ+Vci9kKHHB7I6zIoIKzuMq8pGeZrW813ZAq0fczrYwXe4dtx+/1k77LJMRdXT6ZprYWA3q/yOoxAEagzfLgyfJ307YR3F/uX3mFmxpOeMe9IaO8w/aCDls/KAhtuSUpsoS8dHX9u8LftaLZ0v4wqNYLkjTgTYvwSy8qqad07RZ018WSwv4CndPG6uEyqXM4+zeyCSBA3OJJ50XA/bjioiUMcr8n0MzlDryouhbalPvG4/rdH/P1jkN+ifBiDzcbvI8FuuOm7zmM2dsGL6QRkSIY54WM63rjLnZlKTVzJt+zdrhEaFcBqmX1ULNb1OMY+InOU6ihzDBwjWyV80j8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(47076005)(2906002)(4326008)(6666004)(5660300002)(54906003)(186003)(16526019)(81166007)(36860700001)(70206006)(40460700001)(2616005)(70586007)(316002)(336012)(82310400004)(6916009)(86362001)(508600001)(8936002)(83380400001)(26005)(7696005)(426003)(8676002)(36756003)(356005)(1076003)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 17:44:11.1536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 790deb89-fc2f-47e2-f124-08d9ba7257e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0070
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi all,

This set adds support for AMD Family 19h Models 10h-1Fh and A0h-AFh.

Patch 1 adds some new memory types into EDAC.

Patch 2 adds the PCI IDs, family structures, etc. for the new models.

Patch 3 is a small fixup on how some registers are checked.

Patch 4 adds register offset and other minor changes introduced with
these new models.

This set is based on the following branches:
  - tip/master
  - ras/edac-for-next
  - groeck/linux-staging/hwmon-next

The following commit in hwmon-next is needed for functional support of
this set.

  49e90c39d0be ("x86/amd_nb: Add AMD Family 19h Models (10h-1Fh) and (A0h-AFh) PCI IDs")

Thanks,
Yazen

Yazen Ghannam (4):
  EDAC: Add RDDR5 and LRDDR5 memory types
  EDAC/amd64: Add support for AMD Family 19h Models 10h-1Fh and A0h-AFh
  EDAC/amd64: Check register values from all UMCs
  EDAC/amd64: Add DDR5 support and related register changes

 drivers/edac/amd64_edac.c | 93 +++++++++++++++++++++++++++++++++++----
 drivers/edac/amd64_edac.h | 16 ++++++-
 drivers/edac/edac_mc.c    |  2 +
 include/linux/edac.h      |  6 +++
 4 files changed, 107 insertions(+), 10 deletions(-)

-- 
2.25.1

