Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E3D4A8AC9
	for <lists+linux-edac@lfdr.de>; Thu,  3 Feb 2022 18:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353144AbiBCRvD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 3 Feb 2022 12:51:03 -0500
Received: from mail-bn8nam12on2083.outbound.protection.outlook.com ([40.107.237.83]:9307
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1353130AbiBCRug (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 3 Feb 2022 12:50:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a15spsYnkd3GpKAN6Gf0iCp2oZNSN5/QJo6oIe7xmfoO3XwdrnSJsnyjsVIWsxJ5AJA1TwYiLQSiKKNE3VOLfyyiKJZNl0FeIECjoleq4JqcXnpSRjwGrbWNfJOM0UHuWRh3R/rvn/lG36z4zUYkAQZ35zsdHg0/jmGxbXkvC5DpHjScw0KE7t85Azk17zfDqv6JjvElKyQsphi4ONj+G6opxxG6RuN4kvyz2jYzA56y/DuFWLGG8V3V1IhOyudObhegu/bPRRF0fp1pSoWpseTzD4PSBZjpZslzZk2toZbKTYRAlRxSf1DEeLyvVcpxmKNMrhw8e33+MahVxKS81A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8q72zyNt/6inybY3OwfW6Uw+5CoELZtmwbgqCYs0Nw=;
 b=hyC6xAJBaZezBMuyneqUgN83jbCRtwTdpB2oe2etF8dFuo98erdo3WjuDJSfkEGulJCTxdpQ9Qs1G1ib/7lBI1d4T7z1Mots6rssQkH9DGPsFWzxmrlrp4Z0u1qW/auzs6HMeQp93eLmtDykKPMe+i6ERrO3QXv/hR3tYigEiyh53f+hyxhtI/2mUM3cziasqmFsT1scCjooZ19NzxHGEVlESIch8Lh2/teqb85bY7PdLPh45R5vo8mFaL2zssvFdje2YPve4WSQmuyBKOJzobYuyXo95NwXfaUhAxx5DjLVyY4kaEyNy+JcGE1GPWdvhC9svj6Vw2PtoycYdbFW/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8q72zyNt/6inybY3OwfW6Uw+5CoELZtmwbgqCYs0Nw=;
 b=Vrm6m7Bzlffd5NvjypPRHbTPuLQvx7rthDEgHIaTM8ipuTgbVNjRqZiSI6+laQFaEToIvg29ZBOhuWibb3rag1PV+a5UwLpJVNHVoHuWE1A8QlED3G4YCiH6hUmqo7W8zGtB8vC4n0pjJIiH+HBRV3XbXUHRT1ZGSiDDIM7ftmU=
Received: from MW4PR04CA0326.namprd04.prod.outlook.com (2603:10b6:303:82::31)
 by DM6PR12MB2988.namprd12.prod.outlook.com (2603:10b6:5:3d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Thu, 3 Feb
 2022 17:50:32 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::39) by MW4PR04CA0326.outlook.office365.com
 (2603:10b6:303:82::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Thu, 3 Feb 2022 17:50:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Thu, 3 Feb 2022 17:50:32 +0000
Received: from node-bp128-r03d.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Feb
 2022 11:50:29 -0600
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>
Subject: [PATCH v7 12/12] EDAC/amd64: Add fixed UMC to CS mapping
Date:   Thu, 3 Feb 2022 11:49:42 -0600
Message-ID: <20220203174942.31630-13-nchatrad@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220203174942.31630-1-nchatrad@amd.com>
References: <20220203174942.31630-1-nchatrad@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e317c230-d95b-49b5-2b6e-08d9e73dac83
X-MS-TrafficTypeDiagnostic: DM6PR12MB2988:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2988A1ADB7F4DB00A6FC32ECE8289@DM6PR12MB2988.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:561;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xIBPVE+x9LofRxAREc9lqqHc0UyT72L8SkuN84EoB9Z+VV4qhk5KQ7696oDUTWmFTGOn/UJnwVA+MjFFRt38HosrTX7o/JMq7c02PhprgXEbMgS/oQZtXRBRQ5A2257qsbh85UWUZdf/EXC1v1iLpWtnR3xaps4M5opn+fmb+jSp7B7gNbwxnbzWAXggrdEMT1Js0JvfFwoMqRiwceSLeKjs3qR9dV36JILHJ8opzr8EMUuliFV7iBEf4fHL1fN2aT7vnxl1fuFnu6dxNVB3XYRrnY4iDW9p51LASDspf8tNR4+ONWNR40eT8XZX/9SvB5D4WMux8IMH0s0QClfC+vbHUMPzSLJgqYy722KVsQbyCz/6gHxcc90R7elAbyFr6f2L+2hILeGcFsr6qUhI1vW2gySGaCDh2oMeI66m9ZrSQJtlvLkMKb7cRLZpamem2reiGgxg34PEjsu6DG533XTCgdXqEoOz35rIpD0f1S4NFZrH1X4eFkqjtACyzIdHz63jRbN8PltUZQiUQmG3TkzJcuKeQWTbc9CJuVYhnM/gAMnFijWiB/PzN8M/6fJNzKEBeU1bMrYCBUvHVAS0I4LxHjMpB3FvSLrGUoqlF7QEMSUmf/pQX+GIDSBpkeMs+0nEFborT/JHd4gPkXq+xEz29H0vr8gaT4rcbk/WLKcNPXgEUgObKqLiOG+NUwcnJY2IFtH0zgH0ML5TF3ru6HFj7lTYaG+Z7vgvzJGbzXzs+hFpoj502RtQPR5eatUjr9I9HvAnyGwOCZvMDD/N57r8LdOlKjs7xKQZOfebGZE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(70206006)(70586007)(4326008)(47076005)(7696005)(8676002)(40460700003)(81166007)(508600001)(36756003)(82310400004)(966005)(36860700001)(356005)(8936002)(83380400001)(316002)(2906002)(1076003)(6666004)(54906003)(2616005)(16526019)(426003)(336012)(110136005)(186003)(26005)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 17:50:32.1059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e317c230-d95b-49b5-2b6e-08d9e73dac83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2988
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

GPU memory address mapping entries in Aldebaran will enable on which
channel the error occurred.

Aldebaran has 2 dies and are enumerated alternatively
 * die0's are enumerated as node 2, 4, 6 and 8
 * die1's are enumerated as node 1, 3, 5 and 7

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
---
Link:
v3->v7:
* Split and fixed UMC to CS mapping from patch 33 in v3.
  https://patchwork.kernel.org/project/linux-edac/patch/20211028175728.121452-34-yazen.ghannam@amd.com/

 drivers/edac/amd64_edac.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 6e0d617fd95f..e0f9f3a4fff8 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1540,6 +1540,36 @@ static u16 get_dst_fabric_id_df35(struct addr_ctx *ctx)
 	return ctx->reg_limit_addr & 0xFFF;
 }
 
+/* UMC to CS mapping for Aldebaran die[0]s */
+u8 umc_to_cs_mapping_aldebaran_die0[] = { 28, 20, 24, 16, 12, 4, 8, 0,
+					 6, 30, 2, 26, 22, 14, 18, 10,
+					 19, 11, 15, 7, 3, 27, 31, 23,
+					 9, 1, 5, 29, 25, 17, 21, 13};
+
+/* UMC to CS mapping for Aldebaran die[1]s */
+u8 umc_to_cs_mapping_aldebaran_die1[] = { 19, 11, 15, 7, 3, 27, 31, 23,
+					9, 1, 5, 29, 25, 17, 21, 13,
+					28, 20, 24, 16, 12, 4, 8, 0,
+					6, 30, 2, 26, 22, 14, 18, 10};
+
+int get_umc_to_cs_mapping(struct addr_ctx *ctx)
+{
+	if (ctx->inst_id >= sizeof(umc_to_cs_mapping_aldebaran_die0))
+		return -EINVAL;
+
+	/*
+	 * Aldebaran has 2 dies and are enumerated alternatively
+	 * die0's are enumerated as node 2, 4, 6 and 8
+	 * die1's are enumerated as node 1, 3, 5 and 7
+	 */
+	if (ctx->nid % 2)
+		ctx->inst_id = umc_to_cs_mapping_aldebaran_die1[ctx->inst_id];
+	else
+		ctx->inst_id = umc_to_cs_mapping_aldebaran_die0[ctx->inst_id];
+
+	return 0;
+}
+
 static int get_cs_fabric_id_df35(struct addr_ctx *ctx)
 {
 	u16 nid = ctx->nid;
-- 
2.25.1

