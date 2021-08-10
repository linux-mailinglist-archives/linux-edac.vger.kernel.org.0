Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC0B3E7E27
	for <lists+linux-edac@lfdr.de>; Tue, 10 Aug 2021 19:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbhHJRXT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 10 Aug 2021 13:23:19 -0400
Received: from mail-bn8nam11on2083.outbound.protection.outlook.com ([40.107.236.83]:49472
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229582AbhHJRXS (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 10 Aug 2021 13:23:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekpesfYJhUOyO1W6zhvGDnSgpEe5g4Wqnf1l+i/11KNIVD0Ul3FwvSC832pbVC8rVoKO7pum/F4msis/SpeuT6x4VLzO2hvPJ7e9y8k71lM2ie4iEcgidu0eWLTeDqNrAgQ/36i+fyYc68o3SeXMMJDMqiNe/7mfFn/OwtdqikyqDkf2ujMsYGP89rOTpW4X1btYUBO7kR7Oafie3m/yiM7E7/J5UW2T0PLaJACnHlXi3Oe7mIz5dKrGBgX+0ldddUrQ+6CgSNwxxkVwtH1+SlWnpgPzkdQtCwMkx5u0T23RlDYEHiGSKV+S7yJwcAnH3oGj/6O3i+q3wO9yt5+tAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMa81uHlVm5wegPjFlwdcZGZl3Fu6WB87Z9c1wnFA+o=;
 b=BAMhRqvghHyLod9AhfGLYw5jMW78PDejI3zbxfCBEtCCxAq7d3YHvmY8RxmJQbC4O4JTdi1tgaQpAZYxlA34asSJRTmXHqHqloQF+W08YkHSeyXky8ijLV2TLnlWnJHvCW3dJDvlA9QgNTScJcBrN7DPy3tyP3M3jAEIqPx05CLmce0dpOYSpnnfAVC9iq4VQJ9K55wAvjB7ff5OzWwZc9Y5ncgzUPlifrR3o4et3tuKumqN96muPH5ZYIPvH/vhS/DGN+9JxA2JbeWGnTkC13oYbzli6epbpvS4IlfPoIuDa0WRZtAdk/3YtDymz+/ozHE5/MECMSPWUAjSmJXskQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMa81uHlVm5wegPjFlwdcZGZl3Fu6WB87Z9c1wnFA+o=;
 b=gthmjzYJNRJ3Iu5AmuWVJcTRfl38MFdV2VZStdRn8fNCQbv87dFXGM4x2MTVDlIiqMxeUt9T7uUtPCT6at6aEMkiNRnFUawqxgWkWznhUURE2xWaosENZDcvujyu++Tt3sG/yyoO39w36xb+1Q58lV0AHX5gVSZJ+ISTwxSSEzc=
Received: from MWHPR19CA0024.namprd19.prod.outlook.com (2603:10b6:300:d4::34)
 by MWHPR12MB1359.namprd12.prod.outlook.com (2603:10b6:300:11::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Tue, 10 Aug
 2021 17:22:54 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:d4:cafe::89) by MWHPR19CA0024.outlook.office365.com
 (2603:10b6:300:d4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend
 Transport; Tue, 10 Aug 2021 17:22:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Tue, 10 Aug 2021 17:22:54 +0000
Received: from milan-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 10 Aug
 2021 12:22:51 -0500
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <bp@alien8.de>, <mingo@redhat.com>, <mchehab@kernel.org>,
        <mchehab+huawei@kernel.org>, <yazen.ghannam@amd.com>,
        Muralidhara M K <muralimk@amd.com>
Subject: [PATCH 2/4] rasdaemon: set SMCA maximum number of banks to 64
Date:   Tue, 10 Aug 2021 22:52:12 +0530
Message-ID: <20210810172214.134099-3-nchatrad@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210810172214.134099-1-nchatrad@amd.com>
References: <20210810172214.134099-1-nchatrad@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66e75b42-d296-440a-6ebb-08d95c237d2a
X-MS-TrafficTypeDiagnostic: MWHPR12MB1359:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1359A98123B9F64108648F39E8F79@MWHPR12MB1359.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:171;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QggA+7ruYBz9P1rMf2CFaVrgaiAWPm9gJJjWpvuu/Htj+8n/BWu7hAerSj+762D7SGSZjEdCiwoDj2LR1mX4S7lZKkAG+HQdZwEzvh3hI/8onGakEJYU+CYgTr03U/lz5E9LCNvCDXhTdUv7gNJZFYVWfcrjRA4ujuybTZawOal3bUMhts77FA+8pv8sMOHkA5qEKrn2gdMYpyjU3eDzm/fsEwa/cP+53D2QiH1ZkVCNfKIhN8ERB/1jFEZKgODcmIqbS7I+7gz19bZgRXtBIMsMgYv2MUzqFxH5p/oLABhOQ1XA4MED/QpmbhMSEDul/iyneOIaYoGl5MpaOJU+eNi+HkIZw9SO+/O1i+gSks9PKQ2S3GFdBQcS2/qT6a+hYcgOrf6BP4AwFSSFvNPsZYUvjM9KsvNREQfh0E4M4epDap6aYM+Jewg5cpeCu4flZt0d+ED3oyiZkqNB/P/SkZa1mO+ZcsS5bMJlLUk9m0a2B32mrhnHbX+77hg5BwtI3pLKdX1kJOo652rAkYWhojRZRds+x7bjrHGlG9BiLITjWYYGIqcJJs4zZgwG2rzW9KP7umx2R3v9fKa3AHLlMucmkYThsajq8/3hXLy++LmC5kwgu9gu6MWn8oy4SGmC4oJ5cQy9jlu+wHCxZjE+eaKkHvWUipF3GNNxcuCXx39/CetvlISgU7g6ZLzeSeWjT4nEpKQBtJCGlHH2ZYwHiuBtYmoAqD6tKBZGY9It6x+TRLz6/nfkIZ2Jx2HQXGipu2gYS7HD73R8wedn37IdUA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(81166007)(356005)(8936002)(36756003)(83380400001)(316002)(34020700004)(82310400003)(8676002)(6916009)(336012)(508600001)(16526019)(2906002)(26005)(36860700001)(186003)(4326008)(54906003)(5660300002)(15650500001)(70586007)(70206006)(7696005)(6666004)(47076005)(426003)(1076003)(4744005)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 17:22:54.1600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e75b42-d296-440a-6ebb-08d95c237d2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1359
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralimk@amd.com>

Newer AMD systems with SMCA banks support up to 64 MCA banks per CPU.

This patch is based on the commit below upstremed into the kernel
[a0bc32b3cacf194dc479b342f006203fd1e1941a]

Signed-off-by: Muralidhara M K <muralimk@amd.com>
---
 mce-amd-smca.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mce-amd-smca.c b/mce-amd-smca.c
index e0cf512..3c346f4 100644
--- a/mce-amd-smca.c
+++ b/mce-amd-smca.c
@@ -75,6 +75,9 @@ enum smca_bank_types {
 	N_SMCA_BANK_TYPES
 };
 
+/* Maximum number of MCA banks per CPU. */
+#define MAX_NR_BANKS	64
+
 /* SMCA Extended error strings */
 /* Load Store */
 static const char * const smca_ls_mce_desc[] = {
-- 
2.17.1

