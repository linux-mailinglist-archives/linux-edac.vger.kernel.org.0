Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD96A3F5027
	for <lists+linux-edac@lfdr.de>; Mon, 23 Aug 2021 20:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbhHWSNO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 23 Aug 2021 14:13:14 -0400
Received: from mail-bn7nam10on2074.outbound.protection.outlook.com ([40.107.92.74]:62241
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231955AbhHWSNL (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 23 Aug 2021 14:13:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKy/fIzqDDeENY0Ts3J29V3j0nW0CLKpbw8tM1ln0bQMX0uJvwWCDwzl58c62zIGybGnbjY1GMD8qSGkdvbd0TTwsdiw3HWjv36HekdnRcsNxQODcLDoDIDK9mKEPnaqkYPCnHW0HAxKQJ4NAcZTf0O1ONePnXlG75VuizHfaswIJgb6xYQwDUpYAWBiyfLu1DMiqa0YWS2cOsrwHMOsnSygufctTtShjBz7TjKs1vqwkCfych1G5yUKDhcnC+DrRiET/jy21c4D1cJL/B33SHY4MSbd9ZfebuGdXr3L6t7UJ3ZQlm/NercDGWI1M7kMk+PvSUK8xH5bvzj6plGBWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RyVEG1lJ7hfEGatWdIIr8806yPlyWVZz83jpPE2i1R8=;
 b=RZwRZogRQLwC+Ch0fASSlO76I4d9V/X53AgNnBk6NNq2y/iHu3cWLjsPtRLalNhzrUzc9MclT45an273nXGlGaAbEkc2uSqkveYGRMhlf3x9uvwd9759TI4YHPSwa5cKLA29V3uQG7Fm9SI+94Qt3jHicI4g1+ebUD+wnu5AowFkSHAEC5vaezelSyrSevmwuZIBRn7x9lyMpZzUKcGjaiOgcxeWCtprCUNpqc04fDJcQ0vr69wGEypUZcwZwN+eXCeDZr8qUQofclRrj0bz7DA58AXgRDIZswfjLiFivJXsRWtwP3Fs7DFFiuAn3cUAugaitlwseNTv5RbPaKwtbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RyVEG1lJ7hfEGatWdIIr8806yPlyWVZz83jpPE2i1R8=;
 b=A/oGq/f453CCTyAxdVnwd2yVY/GgzzY3vU+UqEP1STz7b3XrMyXG5XQVD0pI0y4vHMxEl8E4SEmExykUihPTzy9x8a6TPPldPPK2A5ukAtA+db3ISXcEknfXLzNMvjqUfYkRV2XPZSo4Vyu/RM1LAMFzJ8OWvYeHxLJApd9+ATo=
Received: from MWHPR11CA0002.namprd11.prod.outlook.com (2603:10b6:301:1::12)
 by BYAPR12MB4694.namprd12.prod.outlook.com (2603:10b6:a03:a5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Mon, 23 Aug
 2021 18:12:23 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:1:cafe::91) by MWHPR11CA0002.outlook.office365.com
 (2603:10b6:301:1::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.18 via Frontend
 Transport; Mon, 23 Aug 2021 18:12:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 18:12:23 +0000
Received: from SLES15.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 23 Aug
 2021 13:12:19 -0500
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mchehab@kernel.org>,
        <Yazen.Ghannam@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>,
        Muralidhara M K <muralimk@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v3 2/3] EDAC/mce_amd: Extract node id from MCA_IPID
Date:   Tue, 24 Aug 2021 00:24:36 +0530
Message-ID: <20210823185437.94417-3-nchatrad@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210823185437.94417-1-nchatrad@amd.com>
References: <20210806074350.114614-4-nchatrad@amd.com>
 <20210823185437.94417-1-nchatrad@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b98fb6eb-53fd-47bb-91df-08d966618e4d
X-MS-TrafficTypeDiagnostic: BYAPR12MB4694:
X-Microsoft-Antispam-PRVS: <BYAPR12MB4694F770C00CA763B31C44A1E8C49@BYAPR12MB4694.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bHTBOG8wBxsMXoPJJzdvmrIExdbHpe8XCLwU+dU6Y/84SStoGI+0fSbBSw0BK0oyhEidXIPdy5LsXyUm5tlFBLt6+20C4VnuQSQRmxaZhlY59AuN3P8bJj0o/tcwUaGdPvSMQpblV5QIzttXR6Uj2VimAMnYdL3qpbEfskpk93zGqLYpEQ2HC1IuWlYbqnfZZbhMF8KW4NP3tsdIN5pDaEHf0Akap48x9fupMsntAvjisRB9En9E9aXyIAmV6LCKIeyQ9X1asceh20j21Yc/2zeYxKX92KFg4sgqRD+pWO+15joIzOYZMZuRGjbY4Gadt+9w9lQGpy/RmT5cJ+1f5rZnpAXxunpwpYJ4tYMFRBkw9XYbXbX5zVgdD4o3wHnngXgrb53SM52N8dsFu1Z/5gTAOfyfsm8o/OSwm7BZ45VkwkTyIs3GspYgcmrKPe229Qug6dDCRu+Bo3FpQdT7xHbAXNV02oc048wePZ0lUhPOlBXPneOKtz4fSithGu5FjTf6B3lDYX5QoM45UwTHXEVntBKtRANVHEp+1t5Ub/TY8IIE8Va8OrFu6fDJXmLc7L3NsJSlN3aXSyFB70nvmp1bujbYKfJ0J4dqtjPNFQLa30XN+IVolJgZjGrLIUMnPLDIIMQvuJfWoHPnDk0PfQH5pb48VMUvGGKC01qEBTh4klERdylaCy3vu/VQSMksAxPrknbPRxTbGsTbNpMHGKDS19UdwnF+DMRiRH2D7PxM+IZ6ApQ6Da/eOCTWRRfkVAj9N46Jbt1ACqzkezmQyA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(396003)(346002)(36840700001)(46966006)(426003)(82740400003)(83380400001)(8676002)(81166007)(336012)(186003)(4326008)(16526019)(2616005)(478600001)(316002)(36756003)(54906003)(6666004)(110136005)(26005)(2906002)(70586007)(7696005)(70206006)(356005)(1076003)(36860700001)(82310400003)(47076005)(34020700004)(5660300002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 18:12:23.3375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b98fb6eb-53fd-47bb-91df-08d966618e4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4694
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On SMCA banks of the NONCPU nodes, the node id information is
available in MCA_IPID[47:44](InstanceIdHi).

Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Changes since v2:
1. Modified subject and commit message
2. Added Reviewed by Yazen Ghannam

 drivers/edac/mce_amd.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 27d56920b469..1398032ba25a 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -1072,8 +1072,23 @@ static void decode_smca_error(struct mce *m)
 	if (xec < smca_mce_descs[bank_type].num_descs)
 		pr_cont(", %s.\n", smca_mce_descs[bank_type].descs[xec]);
 
-	if (bank_type == SMCA_UMC && xec == 0 && decode_dram_ecc)
-		decode_dram_ecc(topology_die_id(m->extcpu), m);
+	if (xec == 0 && decode_dram_ecc) {
+		int node_id = 0;
+
+		if (bank_type == SMCA_UMC) {
+			node_id = topology_die_id(m->extcpu);
+		} else if (bank_type == SMCA_UMC_V2) {
+			/*
+			 * SMCA_UMC_V2 is used on the noncpu nodes, extract
+			 * the node id from MCA_IPID[47:44](InstanceIdHi)
+			 */
+			node_id = ((m->ipid >> 44) & 0xF);
+		} else {
+			return;
+		}
+
+		decode_dram_ecc(node_id, m);
+	}
 }
 
 static inline void amd_decode_err_code(u16 ec)
-- 
2.25.1

