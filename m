Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A086A475C48
	for <lists+linux-edac@lfdr.de>; Wed, 15 Dec 2021 16:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244189AbhLOPxr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 15 Dec 2021 10:53:47 -0500
Received: from mail-mw2nam12on2061.outbound.protection.outlook.com ([40.107.244.61]:43198
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238061AbhLOPxr (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 15 Dec 2021 10:53:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fIrwdy07I9A17Gx3GZzoqWW1JXtRfs3kE1gpb0KEdIZZgu+LPDGGlFiyL2tMMAEBTfoMcR7ahrVPtur55WBWEkhf17DvZQalDepRo4ELvYoRc+5gvh7aN1IOt/TUrQn7QnGymZRjUA/40+YfuCGW78zRK4O+Cn3M1XBB45i4B5epABaY7YPnN2LxV7eK0kxR3t05FdYkM2lo8Jn/uDZtu6952iNNb1srnE3fME+um7foKoeLQok2vq5KxF949tq7y4hgqD1wq7xlxvgbyYKSHp1MyRCvk1/9w2UH3kF0KH3spCaGVlk3RZkvsM8hELEVad0Z6o8k1S4Vct9gAqaymg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RB9b2zvAH5bih7L9EtObsYfV1gjmysvLWFVZlkRa3GA=;
 b=M6CMr/BuzxwWkZ5u0z1fb0+TufsUz6Z8FUXoh+P/GxuqBBxdYcdVO/Ick+fGhBOmltzKwo5ZqaQ+ACNgdi1IZFH6EzoX+SxCs4/e1NCVaWSqFN3IgNlacCmCdLJlydCUZp0WgIQKlmE9BIRmvi/PC72BjE2CDBJvjzyHFdnXU6a51ieKnOSv9gOzcu2GGfjvpMIedcmQMT+QxsNAOukJI3ctGWub0wmxqKYzWL8x3a58mjj3XaAs9XZ767tLCcBHEz9smArMLgNidIsu82Pm81zCUBqup4YQCWAb3ilLEO9NlaqRJl7maF1z79iMZ6gjoo+Rg7zqqyd2j4xsZBNbPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RB9b2zvAH5bih7L9EtObsYfV1gjmysvLWFVZlkRa3GA=;
 b=WtiL1n3ZBmcpUEMc/pvhyeZio9arRwiMEYbnTZmYjw9Exxc4s8euLkFAjlakrkQBzpBWYhLPZgnWYZiszQU6xBDE0HMeo21+voqV7ItnrXhG9mzBd7Iico8DGo0OzkUVuAKCDQtxY6DjqXRN3B5Od/oEAph9pI9h6/zig2KxxEw=
Received: from BN6PR19CA0090.namprd19.prod.outlook.com (2603:10b6:404:133::28)
 by DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Wed, 15 Dec
 2021 15:53:44 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:133:cafe::6e) by BN6PR19CA0090.outlook.office365.com
 (2603:10b6:404:133::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17 via Frontend
 Transport; Wed, 15 Dec 2021 15:53:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Wed, 15 Dec 2021 15:53:44 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 15 Dec
 2021 09:53:43 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <william.roche@oracle.com>, "Yazen Ghannam" <yazen.ghannam@amd.com>
Subject: [PATCH v2 0/2] AMD Family 19h Models 10h-1Fh Updates
Date:   Wed, 15 Dec 2021 15:53:07 +0000
Message-ID: <20211215155309.2711917-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b0e77a1-ebe1-4204-57b4-08d9bfe312e9
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB48273D4821381AE81185C2BCF8769@DM6PR12MB4827.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eFgPmwjtSdcPQdoPf7biWeLEEhCdlaazjPXvVn4x5ymOvVolhBy6V2AIjo0x1Klc/WwvTjjpq5tC+u2AZqhkvwBqL3AY6ZQqiSb9K5UmxwJ5DCaYPDLT3rQUby1OHrKGO9HAKd27l+qxZaCpTyysPfo350ao2zCfW/jVYUCq2w6bOlcE+4lku8F0pKgN2kH7YjkfjbX7m/Hzk2ybarHoadjCbriphv4XMkuX88nBKqhynREK4bQ0Mske1Yx+UPY2acoXGQBHe5Dqvhr6rB+2JXrRQsg65ce2Bw+Uf73wQcLweXgVxJzp+sqIeIqbe8qGQCNLZNPRXPWZvz74vjrqAGuZs9b3yUF+PjA/8oMoCOMBPpZO3qX0YYgduKdUBYI3HVe8qxM1Fa9a4kx1bommkOU1vsg1y3iQ6PiYbFNwGfIjN9UAkpMrVdseUnB9s6gcML2uDVEozW62YKJDiN35xXDJa44YE/yLOiSFumWHgPBxmQ6q63Jv31xpGsUtEhQuGxlIXeA6MLUeoZFXfYRzVrrK09YNjon39eu20oys0sYaJY4f3rZwOznZ2r3LRscc8q0KFyIP5qMk870JNOgS23JjethufDNXM0Hn2P4UuhBioLnvK8hTrvRs2wqHnV5u/aNzahbmn5np+wFZxEm1GvB7OAKnYdnXvid2zJFfqMe48ClPF0AHw8c1LR97XqNsblUPg8ysY+WHb1NP8tMv1xj8fvlQQ2Nm5NtkBs6HVlnptInR2lJU7JlFdS66U8H9XJMHFB0quqR2+oGgY7Z0+Fas6gP83V0WLuyR+36Dq30=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(6916009)(83380400001)(86362001)(508600001)(2616005)(44832011)(6666004)(336012)(186003)(16526019)(8676002)(15650500001)(36756003)(81166007)(26005)(426003)(47076005)(8936002)(82310400004)(54906003)(316002)(5660300002)(356005)(40460700001)(36860700001)(1076003)(2906002)(4326008)(70586007)(70206006)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 15:53:44.4970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b0e77a1-ebe1-4204-57b4-08d9bfe312e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4827
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi all,

This set adds support for AMD Family 19h Models 10h-1Fh and A0h-AFh.

This second revision includes patches 3 and 4 from the first. Patches 1
and 2 from the first set were applied.

This set is based on the following branches:
  - tip/master
  - ras/edac-for-next
  - groeck/linux-staging/hwmon-next

The following commit in hwmon-next is needed for functional support of
this set.

  49e90c39d0be ("x86/amd_nb: Add AMD Family 19h Models (10h-1Fh) and (A0h-AFh) PCI IDs")

Patch 1 is a small fixup on how some registers are checked. The patch is
functionally the same as patch 3 in set 1, but the commit message
updated to give more details.

Patch 2 adds register offset and other minor changes introduced with
these new models. The patch is updated to use a different name for a new
flag (thanks Boris for the suggestion).

Thanks,
Yazen

Yazen Ghannam (2):
  EDAC/amd64: Check register values from all UMCs
  EDAC/amd64: Add new register offset support and related changes

 drivers/edac/amd64_edac.c | 70 ++++++++++++++++++++++++++++++++++-----
 drivers/edac/amd64_edac.h | 14 ++++++++
 2 files changed, 76 insertions(+), 8 deletions(-)

-- 
2.25.1

