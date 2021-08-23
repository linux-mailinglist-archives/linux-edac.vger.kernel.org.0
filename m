Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69EE3F5023
	for <lists+linux-edac@lfdr.de>; Mon, 23 Aug 2021 20:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhHWSMz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 23 Aug 2021 14:12:55 -0400
Received: from mail-bn8nam12on2078.outbound.protection.outlook.com ([40.107.237.78]:57057
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229676AbhHWSMz (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 23 Aug 2021 14:12:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExvIDXAjaTGp5cHGcG8XuXRwzTBomZKFmWUjjMUrpI3BrMvBZUO75jxJ2b6ucQnv93ER/cc0eiPSFbXLshxnlvVt7HuKxf3krlcXSpvJ2/GOBuI6l1tW7NrmaM0g8rAYRs+lf2rC0XDl3Oqn38IdNs5mX/7qc5oJ59i4o7WFnC297gLoQyC95YCcNd3N6vHyrpE6xoH2ILsrwLEEXD8B8VX5ESK4poebfhN3FJ3xoz9abFBRiLhAsVHGndaY7K+tOXmhBzh/9zZBX3/z3Img7K1U1GckM9ilYrkyFHKd5TwDfvyudL6uJDdaTtmZk7/Huhw+RWbzSyy/3EljNJA4lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gZQj1Nivwk29O3gtHJlbF6zzCaovhX+6S1ars+hkbA=;
 b=DVNe8XDTWYLiiK01d2Ty3TaAgrcz07cQgji1celnIubXG88MG/07Z/7xFmrMwbO93zsfKI2wAqC22myZowpJw2NS92HhgNJ5uH6cWat9hDqbZgtuKk/p2yX6rtzlWM5PNJm/09r9WmyIbvdymRMek1ymlMEbmtH1oOEnkDv/rhvzRqza3OzW7X/izDI+cn2H+0ZbdTe4pJwexw3c3QFnnwzSniWYlO6p6EWywACyvnNXIwlXA8B0Ae67F8hNTKM88noAJs8hp1q3rg6H0gH0cRe1SlApTplk3EI36Qpe5bwosN5e0b9SyXScHeqTRVtqmaKqt17dZKAJM+YBCSSz6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gZQj1Nivwk29O3gtHJlbF6zzCaovhX+6S1ars+hkbA=;
 b=0IrvL6/NnZcpYysSu2sODYP1HT9NpF4vSAhxRfFHb0crNTEaxT7lGkMQSw3OLaDz7iWIV88DzDVkW6qxP5HhcQkPofYFwBNYxrOVGtPFXgDG8e9/Dj/sas+BtaOVxtuGXwiQCiYYDR9vL26c1/cG3UEQCRGHnBu17UpDfBAgFGM=
Received: from MW4PR04CA0297.namprd04.prod.outlook.com (2603:10b6:303:89::32)
 by DM6PR12MB5533.namprd12.prod.outlook.com (2603:10b6:5:1bc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Mon, 23 Aug
 2021 18:12:10 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::b8) by MW4PR04CA0297.outlook.office365.com
 (2603:10b6:303:89::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Mon, 23 Aug 2021 18:12:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 18:12:10 +0000
Received: from SLES15.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 23 Aug
 2021 13:12:07 -0500
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mchehab@kernel.org>,
        <Yazen.Ghannam@amd.com>, Muralidhara M K <muralimk@amd.com>
Subject: [PATCH v3 0/3] x86/edac/amd64: Add support for noncpu nodes
Date:   Tue, 24 Aug 2021 00:24:34 +0530
Message-ID: <20210823185437.94417-1-nchatrad@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210806074350.114614-4-nchatrad@amd.com>
References: <20210806074350.114614-4-nchatrad@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56e723ec-fa54-40d7-d064-08d966618660
X-MS-TrafficTypeDiagnostic: DM6PR12MB5533:
X-Microsoft-Antispam-PRVS: <DM6PR12MB55332DD5722A604251B4839AE8C49@DM6PR12MB5533.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HtFBmrtOvfdqfaRP0z8Ly1ROgQqPTOGH2lp+3CuM2g4tViz0Kwp4OW50Zw4mumsw1wANIZqPSch3gEo/s0qY1C6DuqsUvBtslt74ce4JFGG91sejc/A4V8QUJ6ffMPcU1yH9glM7rSGaKVCf8iEN7Ds+bps0SprGLAHipgEfMg8BR4XUVNoLVli0HrEZKU36K7iEnr5eUZYXAlqZB9ZYbfeXB1op9iNmtW+8fbRyG7UaxECx2xo7BfwyqIeXTyyKlghvvWs4oQZHX7n+H6Eyy142fKHVllgJrcsXDLBrUanLgSZPQlHz5kCnYN8Kp6dlXXDuwhi/eORRms0zbktcSkbNQ3v6BDFo2HX9o3GBOOOqkmROiOe20iUZ/IfHbj5YMJ0vCp4EPM9MvDLuM3XpTgf+1PYbBQE2yFzh+8vLc/3ytDpTtrGIswxayFDRkz3dMVzWa+dgKTenObqEQc5551h2/qEV4JkuYSxoFdJQZxHI2hWxPV4PvNXjRT/rQRVGsOqF+xDJvfh8kL3c3UgE+hhLbgpTLfaSQ8Sxrc+zcomY2zwA2GoKLcyqa3DwxRh1p6Xlz6khgG7pKh7GF4AT5mO4yp9Aw4giJ6dbOV27+LRQjNv7HURktzFcG3EaGMgHhk5ik3ncF5ob3UZFqz9jw+8xMuqbZPC9oPW1dVIiwECMD/H3l6wksV4nuX1PKzsMMTWSCa/Yck02QnJz42I3K/FwdmZzXsPDBMbttFz9yzOMC5wNwyiP7DBLlfgrDbLUzpUYlcdx1S6sU6frYS3bk5N7dZy2wquyfDX0VKBnRNrO0FohN43PKxcwQe2MQ/snO5Bz+LMm2HlKK+5jEbi7XFgedMnGbOSfr7IPdzcxZW0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(46966006)(36840700001)(34020700004)(70206006)(6666004)(81166007)(70586007)(47076005)(83380400001)(82310400003)(82740400003)(356005)(186003)(2906002)(16526019)(426003)(36860700001)(26005)(8936002)(4326008)(36756003)(8676002)(54906003)(316002)(478600001)(110136005)(5660300002)(2616005)(1076003)(336012)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 18:12:10.0429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e723ec-fa54-40d7-d064-08d966618660
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5533
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralimk@amd.com>

On newer heterogeneous systems the data fabrics of the CPUs and GPUs
are connected directly via a custom links.

This patchset do not have any dependency on series by Yazen Ghannam
AMD MCA Address Translation Updates
[https://patchwork.kernel.org/project/linux-edac/list/?series=505989]

This patchset does the following
1. Add support for northbridges on Aldebaran
        * x86/amd_nb: Add support for northbridges on Aldebaran
2. Modifies the amd64_edac module to
   a. Handle the UMCs on the noncpu nodes,
        * EDAC/mce_amd: Extract node id from MCA_IPID
   b. Enumerate PCI IDs and HBM memory
        * EDAC/amd64: Enumerate memory on noncpu nodes

Muralidhara M K (1):
  x86/amd_nb: Add support for northbridges on Aldebaran

Naveen Krishna Chatradhi (2):
  EDAC/mce_amd: Extract node id from MCA_IPID
  EDAC/amd64: Enumerate memory on noncpu nodes

 arch/x86/include/asm/amd_nb.h |  10 ++
 arch/x86/kernel/amd_nb.c      |  63 +++++++++-
 drivers/edac/amd64_edac.c     | 219 ++++++++++++++++++++++++++++++----
 drivers/edac/amd64_edac.h     |  28 +++++
 drivers/edac/mce_amd.c        |  19 ++-
 include/linux/pci_ids.h       |   1 +
 6 files changed, 308 insertions(+), 32 deletions(-)

-- 
2.25.1

