Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F109466CF60
	for <lists+linux-edac@lfdr.de>; Mon, 16 Jan 2023 20:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbjAPTLm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 16 Jan 2023 14:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbjAPTLk (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 16 Jan 2023 14:11:40 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA482A173;
        Mon, 16 Jan 2023 11:11:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGSoDDBswBFkXrqhqpRWd1ua9MsZ8eiOUpSkf+Jky7rMPlTJpXtLEabPksmGnnx+/plifzRr58YX19F6S6JyjYWqatSrffLHPr89T3cwHWJ/cvvJ0FTowSodyiq09l9FzDFWQ7EG7KZoGE2p6+ZjdY7U9IdajZuzn9xa7l0VGfxtkzF10iy1gJoPGZlCJj1e1y96ssIez3JhG+o3+ggHXdTt3uOqlagBTs3nLXhl2PifHCSG6UraKiRBAgBEMxBEUxt6RYtxWlH5Xt6o3OJPoOuc5zvGAbuFGO1DnXVUUdl5LL3Er9RUl9KzmTL3Gt45MAagb5QNw9VDeqMduLBg9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hN2HxDRz9CijzijOXuIc91nDWFRsOWJOJIF4l4Wucuk=;
 b=TTQYk7gf/KhFPKiMtrdBeXu5m1Xh/QmdI4rfHMvyucmENICNQRxpjI7qEMaJ5ClqWmN4OsBeBBLmYsHl7QfDJjjqAT0m55ws8s6zwZ4C8u2aL7rpYqI9YmLHZ6m6byMiWQusGlyC7tAS64cKoklAx+EYFTPbzPTUZwW3IFbMNxs8exVYf4D4Usc3YzlBqE/NKyzUteHISZbdOkF0+pAJpaiBjC/NYhbORzf/lBbiJgIgMtpj6AN539WtJHlajCzoQAe9fm1r7rVHVPogRD1XrOpINj7L3qyvUCMKsmDNFLQVBxzAaU3NwVSwkgR1LlIjAXKWmqkar8NJtQ9XhWpxmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hN2HxDRz9CijzijOXuIc91nDWFRsOWJOJIF4l4Wucuk=;
 b=QXfLqB36/SfX//l7nfBK7piGCel95FHoZULFs8l9h0WGaQmii9yt+8rgrW8dKqeHRM/l9KWGcuKV3SOD6jIp6hjKTvx3Evhn3bqvELafBSyvhWsUgGFtiolVDagD/xfK9XOGo5oPN+upj6wlmg/1Ub3v7KpNNc7wgL5zntOUmHs=
Received: from MW4PR03CA0357.namprd03.prod.outlook.com (2603:10b6:303:dc::32)
 by DS7PR12MB8345.namprd12.prod.outlook.com (2603:10b6:8:e5::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.19; Mon, 16 Jan 2023 19:11:36 +0000
Received: from CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc::4) by MW4PR03CA0357.outlook.office365.com
 (2603:10b6:303:dc::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Mon, 16 Jan 2023 19:11:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT085.mail.protection.outlook.com (10.13.174.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Mon, 16 Jan 2023 19:11:36 +0000
Received: from onyx-7400host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 16 Jan
 2023 13:11:35 -0600
From:   Avadhut Naik <avadnaik@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <tony.luck@intel.com>, <yazen.ghannam@amd.com>, <avadnaik@amd.com>
Subject: [PATCH v1 2/3] x86/MCE/AMD: Add HWID Fixup for PCS_XGMI SMCA
Date:   Mon, 16 Jan 2023 19:11:01 +0000
Message-ID: <20230116191102.4226-3-avadnaik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230116191102.4226-1-avadnaik@amd.com>
References: <20230116191102.4226-1-avadnaik@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT085:EE_|DS7PR12MB8345:EE_
X-MS-Office365-Filtering-Correlation-Id: ae6a2550-cbcc-44df-5fd4-08daf7f57d41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4/K8Ktj1sGwNkxqdb/n3s8AfavPq4FDIc/Z4zFpSdlL1zvyWBuF010ay3f3xl3pqj11FZcSvN/i4egTG2nwTF4dQg6k/A3uh+gI3oMlkA1rIqc8DDvyQ8wMMZgayZZ8cqEtO96WI5jOauzpmw8WjSKxVsDK7URFQ1DIKaXQp10F3iSGjA9Q0f/WbcTex2lLGmKg5DUZFRYGYbKumazFYwl6a1WIqZ2lT859cd/AflJjv8jLHh+/sKM6sI8CFxPxReyoRAf42aXw66RgbmriFAnpcJbYh6PpuS2oHSWiNWf25DDL0Z5k3X/Vv2ksyOLokgr6LLB+U/s4SD+zp5zrbqXsLrP5wx1DZz500ZUSbswHfUy5N9UbC081x25iirs7zpmo91mA78+RN8AlNnzqJKry6h4BkEPrhQM1Vp7tUTkhz6Hl5gYdQTFYObu/Eh+9VJBvWWm5VHZWIC2axe9P4clO7k8UjLxZV6eCIE66c4SYdvdPH4b/tc4dQFX8oEFdCFZCOA9mWhAow56ZGFdI3VlxkpsbK8d/fyBdEH6jxt+EBPWaldd3BjRGhsScpRBUTWNfLzJLGp/Kma7rFiHh82HOjlzMOH08kFxAUhJePIGSv+28nlLAvhYNvN+EzBDK9VgEWIp89aIR+YeDAf24T7C4i/LBEEfO4HZECuYOpqwJQF5veTubvNnMSeiLNueg9OsplVOFOy/7I0ENC5MO3dGr/BUpcW0yXbZePQDfoa/Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(36756003)(356005)(5660300002)(82310400005)(40460700003)(8936002)(2906002)(40480700001)(36860700001)(47076005)(83380400001)(426003)(82740400003)(54906003)(110136005)(81166007)(41300700001)(478600001)(8676002)(6666004)(2616005)(7696005)(336012)(4326008)(316002)(70586007)(1076003)(70206006)(16526019)(186003)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 19:11:36.5112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae6a2550-cbcc-44df-5fd4-08daf7f57d41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8345
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On AMD systems, during Scalable MCA (SMCA) initialization, the HWID and
McaType tuple, read from MCA_IPID register of a SMCA bank type, is used
by the kernel for populating the per-CPU smca_banks array. This very array
is, in turn being utilized by the edac_mce_amd module for determining the
SMCA bank type while decoding a machine check error.

However, on some AMD CPUs, the HWID read from the MCA_IPID register
for XGMI Controller SMCA bank type does not match the value expected by
the kernel. Consequently, the smca_banks array is not populated for the
bank type resulting in the machine check errors on the bank type not being
decoded.

As a solution, set the HWID, obtained from the MCA_IPID register, of the
XGMI Controller SMCA bank type on affected CPUs, to the value expected by
the kernel to ensure that the machine check errors on the bank type are
correctly decoded.

Signed-off-by: Avadhut Naik <avadnaik@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 23c5072fbbb7..b0cce0ce056c 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -249,6 +249,30 @@ static void default_deferred_error_interrupt(void)
 }
 void (*deferred_error_int_vector)(void) = default_deferred_error_interrupt;
 
+/*
+ * Errata encountered on AMD CPUs for some SMCA bank types requires fixup
+ * of HWID, read from MCA_IPID register, for accurate SMCA error decoding.
+ */
+static inline void fixup_hwid(unsigned int *hwid_mcatype)
+{
+	struct cpuinfo_x86 *c = &boot_cpu_data;
+
+	if (c->x86 == 0x19) {
+		switch (c->x86_model) {
+		/*
+		 * Handle discrepancy in HWID of kernel and MCA_IPID register
+		 * for XGMI Controller SMCA bank type
+		 */
+		case 0x30 ... 0x3F:
+			if (*hwid_mcatype == HWID_MCATYPE(0x80, 0x0))
+				*hwid_mcatype = HWID_MCATYPE(0x50, 0x0);
+			break;
+		default:
+			break;
+		}
+	}
+}
+
 static void smca_set_misc_banks_map(unsigned int bank, unsigned int cpu)
 {
 	u32 low, high;
@@ -321,6 +345,8 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 	hwid_mcatype = HWID_MCATYPE(high & MCI_IPID_HWID,
 				    (high & MCI_IPID_MCATYPE) >> 16);
 
+	fixup_hwid(&hwid_mcatype);
+
 	for (i = 0; i < ARRAY_SIZE(smca_hwid_mcatypes); i++) {
 		s_hwid = &smca_hwid_mcatypes[i];
 
-- 
2.34.1

