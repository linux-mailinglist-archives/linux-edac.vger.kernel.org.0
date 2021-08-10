Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04CCC3E7E28
	for <lists+linux-edac@lfdr.de>; Tue, 10 Aug 2021 19:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhHJRXX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 10 Aug 2021 13:23:23 -0400
Received: from mail-bn1nam07on2079.outbound.protection.outlook.com ([40.107.212.79]:42334
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230262AbhHJRXW (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 10 Aug 2021 13:23:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrj6bD+Z5c8vFmeqm+6iYbiEm7Zd3Bydc6UCN3OB+UcBp/p8e1FfkdBVhrpCY3C+0sKF1B7UMN9FYOmNLIpsZr9tpUbQYiII5AU+DRGl0/ROn+ZsWYqL/lE7qGTJuWtZA8T2RiZiS519qE7He/rL20uOKbZYlGS+mBX8CDUjxzMeI9Os4RQlx0iplsRUbj9mArYfY2uZ0DQgBx+FxLRZS75d16ahwOLIJb9M1biSL7PCZIdK4o7LEd9vpeUwLLomQchmw+0QnOcYPuzaTk35qUoo6XAav9EgEU6jGvG0RZf95DoO1EjHXWgiQHGuE6Hl1zBVREQkTtFLhZfvGPyeeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QE9XDASmNn6+nO/shQlVtLnBXIJ0fS0NDRT9s4fGWP0=;
 b=WaiXH7dLYCnQrhYa91Ljh3JcCj6tx5QOcxduMN4Xh4r+5qlD50NToEx1cOqsF6nBD6161g7pkKWXNsmgBQy6fghi+xOREokl7IVkxdQkrm5d8COfIkgDkjo6w9QXnzKKMmptyylgAIDkQmrGg9eeJfDyYzEkvVLNwH6T8txEveMCPbigi0nzHPkBzS37pa+DlSdHVe1Kbv63pceY3GawJgzZITxn6IUNYplsSkJnJOvk48ZUjoU9BD+Hnk+I/mfLIYycXSQKd5UpAEOiSMN63qJ0/LkRAcDV9d/bbbgILIS08ruB/EhbxAy5ljdt6YKYy0xxd01FjNu0cYKOrKtHCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QE9XDASmNn6+nO/shQlVtLnBXIJ0fS0NDRT9s4fGWP0=;
 b=oKISedRJ5yemn/B7lUmwtoK5nxhvb1il9bZQQSoLCyAeFaD/RjdexTi7ZizmDVhBgKEkOJTv5gRrR6x5N+jhghL+V3D57CKjy1mD3blr46jO9VNj3t4O7j74yTCMgw6wh7Lmm6kZWjEr3YGVdKFJfzeT+1cz5+8PXixPr6Nnnzc=
Received: from MWHPR19CA0008.namprd19.prod.outlook.com (2603:10b6:300:d4::18)
 by DM6PR12MB4417.namprd12.prod.outlook.com (2603:10b6:5:2a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Tue, 10 Aug
 2021 17:22:58 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:d4:cafe::a7) by MWHPR19CA0008.outlook.office365.com
 (2603:10b6:300:d4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Tue, 10 Aug 2021 17:22:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Tue, 10 Aug 2021 17:22:57 +0000
Received: from milan-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 10 Aug
 2021 12:22:55 -0500
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <bp@alien8.de>, <mingo@redhat.com>, <mchehab@kernel.org>,
        <mchehab+huawei@kernel.org>, <yazen.ghannam@amd.com>,
        Muralidhara M K <muralimk@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>
Subject: [PATCH 3/4] rasdaemon: Enumerate memory on noncpu nodes
Date:   Tue, 10 Aug 2021 22:52:13 +0530
Message-ID: <20210810172214.134099-4-nchatrad@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: cf0140cd-d137-4e10-dfe4-08d95c237f6a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4417:
X-Microsoft-Antispam-PRVS: <DM6PR12MB44172207E2F23E433EE6C764E8F79@DM6PR12MB4417.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zkNzlJanGYHOJtRHu0PEZAgXMZlMDGyGFg0IGzERXvUklMIVsprcU1mDKmJLI8bhJd3VU6D1lL4L/qVaR+RT25GXrw3i8Qj/lJTPLPKt6mQ4aKl6bMEHMbjNOSVpxAZkO7Cp5TAnNsYOUNJuBCDFuUjYRMpRwnpG5ENzSOy494ONTtayHpL05PAVsbTtD41IcCzIg+30MMWW7F3ZFYI/A4toIzeNxfPjdNEG9AdgoAI6NLoy4Ac6iQZhhRB5zi10cHC6Xz1hZXoWTTC2S7XqY7wqD079usTYoQCHmEjpK1nNbIaPSR1g2PyA7uXGu4/zmGQbgYesmUvxSUgqcWZ/GGeXtkfYI+40r4rsO7dNPysP/4JtfGFKw5QQF9cdF/WuG2T1FwWl7oIRuyHnxGi2GFVcBVOamQPhNCVEANQRGt8kZVvkrXtMlu/0+GUvnuEg8xuHJmsUexCboUqrzVW3ZhDohU8NEB4lLAx/LmqrcFfRwdoyvhJDO23E7E94HRcH6df8t9YyZlrvAuuYpg6OkxL7WZHl0OnIP22oGDwkUJ8bcYHQITgQUOm2Y/4anuVtZI6EsfGGpwCEgXAVVzdOp82hZftaxMHaPEw03zMq5qPi0aG6Z42kgAt1uK/ot6pE9xIlPVKMHpoXUeeR62lD/T1EEZXGpR5fekmy5NHPq/y2WZm2hGjWgJw4yXoKXLwxU9c/e3haiRvH/lrtwE87P1UFZfTcPFnoU1BbmqLVY/vx8lZrKDbuYKReUr0AeR4qJoswWg4TvAXwOiksyAA1Mg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(36840700001)(46966006)(2906002)(26005)(186003)(81166007)(8936002)(356005)(36756003)(2616005)(4326008)(34020700004)(6666004)(316002)(16526019)(82310400003)(5660300002)(1076003)(83380400001)(47076005)(7696005)(426003)(82740400003)(70206006)(70586007)(336012)(8676002)(54906003)(478600001)(6916009)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 17:22:57.9358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf0140cd-d137-4e10-dfe4-08d95c237f6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4417
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralimk@amd.com>

On newer heterogeneous systems from AMD with GPU nodes
(with HBM2 memory) connected via xGMI links to the CPUs.

The node id information is available in the
MCA_IPID[47:44](InstanceIdHI) register.

The UMC Phys on Aldeberan nodes are enumerated as csrow
The UMC channels connected to HBMs are enumerated as ranks.

Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
---
 mce-amd-smca.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/mce-amd-smca.c b/mce-amd-smca.c
index 3c346f4..9381aa1 100644
--- a/mce-amd-smca.c
+++ b/mce-amd-smca.c
@@ -78,6 +78,16 @@ enum smca_bank_types {
 /* Maximum number of MCA banks per CPU. */
 #define MAX_NR_BANKS	64
 
+/*
+ * On newer heterogeneous systems the data gabrics of the CPUs and GPUs
+ * are connected directly via a custom links, like is done with
+ * 2 socket CPU systems and also within a socket for Multi-chip Module
+ * (MCM) CPUs like Naples.
+ * The first GPU node(non cpu) is assumed to have an "AMD Node ID" value
+ * of 8 (the second GPU node has 9, etc.).
+ */
+#define NONCPU_NODE_INDEX	8
+
 /* SMCA Extended error strings */
 /* Load Store */
 static const char * const smca_ls_mce_desc[] = {
@@ -531,6 +541,26 @@ static int find_umc_channel(struct mce_event *e)
 {
 	return EXTRACT(e->ipid, 0, 31) >> 20;
 }
+
+/*
+ * The HBM memory managed by the UMCCH of the noncpu node
+ * can be calculated based on the [15:12]bits of IPID
+ */
+static int find_hbm_channel(struct mce_event *e)
+{
+	int umc, tmp;
+
+	umc = EXTRACT(e->ipid, 0, 31) >> 20;
+
+	/*
+	 * The HBM channel managed by the UMC of the noncpu node
+	 * can be calculated based on the [15:12]bits of IPID as follows
+	 */
+	tmp = ((e->ipid >> 12) & 0xf);
+
+	return (umc % 2) ? tmp + 4 : tmp;
+}
+
 /* Decode extended errors according to Scalable MCA specification */
 static void decode_smca_error(struct mce_event *e)
 {
@@ -539,6 +569,7 @@ static void decode_smca_error(struct mce_event *e)
 	unsigned short xec = (e->status >> 16) & 0x3f;
 	const struct smca_hwid *s_hwid;
 	uint32_t mcatype_hwid = EXTRACT(e->ipid, 32, 63);
+	uint8_t mcatype_instancehi = EXTRACT(e->ipid, 44, 47);
 	unsigned int csrow = -1, channel = -1;
 	unsigned int i;
 
@@ -548,14 +579,16 @@ static void decode_smca_error(struct mce_event *e)
 			bank_type = s_hwid->bank_type;
 			break;
 		}
+		if (mcatype_instancehi >= NONCPU_NODE_INDEX)
+			bank_type = SMCA_UMC_V2;
 	}
 
-	if (i >= ARRAY_SIZE(smca_hwid_mcatypes)) {
+	if (i >= MAX_NR_BANKS) {
 		strcpy(e->mcastatus_msg, "Couldn't find bank type with IPID");
 		return;
 	}
 
-	if (bank_type >= N_SMCA_BANK_TYPES) {
+	if (bank_type >= MAX_NR_BANKS) {
 		strcpy(e->mcastatus_msg, "Don't know how to decode this bank");
 		return;
 	}
@@ -580,6 +613,16 @@ static void decode_smca_error(struct mce_event *e)
 		mce_snprintf(e->mc_location, "memory_channel=%d,csrow=%d",
 			     channel, csrow);
 	}
+
+	if (bank_type == SMCA_UMC_V2 && xec == 0) {
+		/* The UMCPHY is reported as csrow in case of noncpu nodes */
+		csrow = find_umc_channel(e) / 2;
+		/* UMCCH is managing the HBM memory */
+		channel = find_hbm_channel(e);
+		mce_snprintf(e->mc_location, "memory_channel=%d,csrow=%d",
+			     channel, csrow);
+	}
+
 }
 
 int parse_amd_smca_event(struct ras_events *ras, struct mce_event *e)
-- 
2.17.1

