Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACFC70D7FC
	for <lists+linux-edac@lfdr.de>; Tue, 23 May 2023 10:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236054AbjEWI4W (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 23 May 2023 04:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbjEWI4V (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 23 May 2023 04:56:21 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36C2FE;
        Tue, 23 May 2023 01:56:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ns77+6TOe4i0F1YDS7uIkd+srj2XQClc7b9dQvYnUyWyxiQJvLZiZX/lzkPqeSl2rgegWPa68ga0kb01LrhK5k6zFf0G64U2s+toSYx8bnfyCnAKgPFcduIuHG25LkHt/Wss/zFlXb904JTrnHtyVvOuecQD5oM+iy4qhhuQ0oFnL1AOiq7qCiY7b9cwMK8/S4BBNo0Mlg3XdYGW/WjFOB+AZMyVWak3+qiGVcwe3Xx/WI3d6i6sz6aaicYbEoFrkjCJevzUt2pTh9XtOYAzMxXUCZQ04aqass8ZFeOQvhYAK7T72rJ3VgLNwuX7jOktVyngj8DTyP9EHsiLO7G42Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7sCBkrm39wGlaeEusXYI2a6fbO/pAqwdlGXo95aV4U=;
 b=hGGo0SSN385F5j2g2agaA4KtPzGtbxtjsforua6aM+HQZ9zSn4L0DgopiNYZnNkVyuPg6/d7Wd8F45/OzGj8AWlm0LqSO7J/jYIdRbhQ5KxMwZD99YcghrYUYig1hyOmGmugkOKUuDz/1UvVhXgchn8WKAk/+Ro4W9nOJX4mdqK5AIzWJjmX9VlDOoE9X3uXRQVUMLr1v85LjG27pQYdl0TXPEwy4HHG6+6Lm+HQmfQgy7fAIwV4dvkhZIWgWDx+3UneXLDp8ChxNTJ/RsL0LQeJ+k5jacdaV3gn0PVL+ufUL3w+DJgcI9Su1fqj4IBsbdny+QN51dukPB+4DXGlcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7sCBkrm39wGlaeEusXYI2a6fbO/pAqwdlGXo95aV4U=;
 b=gfuKwj8ZABMYUtN7wVpc8//xluU1jel8RcJviN4j5UUxrgZyW7ZCioVoT5dS0xwuzRmQ168Km39uFRcztOP/lBY851Q+710SNnJIcKLKezelACxOiGqasoVdbVd42y9I9nCdX0bWb16xBFk/22TFfdLe27xAKFku5BIgN9+/Gkw=
Received: from BYAPR03CA0020.namprd03.prod.outlook.com (2603:10b6:a02:a8::33)
 by PH8PR12MB8432.namprd12.prod.outlook.com (2603:10b6:510:25b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 08:56:14 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a02:a8:cafe::6) by BYAPR03CA0020.outlook.office365.com
 (2603:10b6:a02:a8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Tue, 23 May 2023 08:56:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.29 via Frontend Transport; Tue, 23 May 2023 08:56:13 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 23 May
 2023 03:56:09 -0500
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <tony.luck@intel.com>,
        <yazen.ghannam@amd.com>, <nchatrad@amd.com>,
        Muralidhara M K <muralidhara.mk@amd.com>
Subject: [PATCH] EDAC/mc: Add new HBM3 memory type
Date:   Tue, 23 May 2023 08:55:49 +0000
Message-ID: <20230523085550.391768-1-muralimk@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT067:EE_|PH8PR12MB8432:EE_
X-MS-Office365-Filtering-Correlation-Id: 0950bdb3-36fc-4a7b-adc2-08db5b6b8fe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ayc+QL/qJzHVBP23SYjzaoKxNlFrRQ4SMI9Skq5BoYB+nocYE4OcsoQ9F6sXcarxrFayySECnaj3KeDdfQMlwSNDlRFdhkkBQtXzjX00wO67iGnGZAVWKsE0dEQBZESvjQI9GSKC7e71CxjZ0cTwON1ijHM2swkMm6P4cNlN/h/VkNZpksN0IPRu6IS2kueB3KF2AoCg5ph2mDmGsSBrjW1lJL+22eniVXMIgvSo/vzJASXQ3U/NAzMCnxqVO8w4mnHTOWQJmd1IVM7zOdO0FvF1mJcfRSWGdEuHaWT7JFsCNWMxD4xe72MfDd09IUh3PELJM2vLbqRoqSUHZlF+gO8sRGBkYdHzMM77prPdH+k5fnkh9AwJrONCfYZCpNOSO32Qehdptu8U8QpExVgZU5acWGnDVVfPA7mG77tGVQF5FIyr7N0+zOZfxQ7f3OobZBR5SaMMnO9nrGBFTRphw8Fe+nJBkiX6l1HaL9dHY6b/ezairxi9fwL42YYSzo54wfKe7P0iqDQPlfMOtCTmB3gQZrfxCMQ2M3dgm0EOvYSW2FyTTvGPRByJeuBmGMzCkiaFG7lIIFVHIGypPi9y+jkwZWT8CWNstyEUoQHpJYl7SV6dqe1Fn4dZ+gfe3x/EhLG6m5X/6crZZ81FkbYvxwiC4/LrVoQLQGBrn7K6jHEpkKBgOBV0e1zYkNFvXcoQcyr+7+Q6umHq0OyW5FbvdeCUCRWpGE+jvD/i2kQHOzcn1mLDl3PY36FA+P1EEygIH6Q9wJxz6MRbYDMWhiI03w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199021)(36840700001)(40470700004)(46966006)(2906002)(5660300002)(83380400001)(8676002)(8936002)(82310400005)(70586007)(36756003)(70206006)(4326008)(54906003)(316002)(110136005)(7696005)(478600001)(6666004)(41300700001)(40480700001)(336012)(426003)(2616005)(356005)(26005)(82740400003)(81166007)(1076003)(47076005)(186003)(16526019)(36860700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 08:56:13.6294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0950bdb3-36fc-4a7b-adc2-08db5b6b8fe8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8432
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

Add a new entry to 'enum mem_type' and a new string to 'edac_mem_types[]'
for HBM3 (High Bandwidth Memory Gen 3) new memory type.

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
---
 drivers/edac/edac_mc.c | 1 +
 include/linux/edac.h   | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 6faeb2ab3960..d6eed727b0cd 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -166,6 +166,7 @@ const char * const edac_mem_types[] = {
 	[MEM_NVDIMM]	= "Non-volatile-RAM",
 	[MEM_WIO2]	= "Wide-IO-2",
 	[MEM_HBM2]	= "High-bandwidth-memory-Gen2",
+	[MEM_HBM3]	= "High-bandwidth-memory-Gen3",
 };
 EXPORT_SYMBOL_GPL(edac_mem_types);
 
diff --git a/include/linux/edac.h b/include/linux/edac.h
index fa4bda2a70f6..1174beb94ab6 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -187,6 +187,7 @@ static inline char *mc_event_error_type(const unsigned int err_type)
  * @MEM_NVDIMM:		Non-volatile RAM
  * @MEM_WIO2:		Wide I/O 2.
  * @MEM_HBM2:		High bandwidth Memory Gen 2.
+ * @MEM_HBM3:		High bandwidth Memory Gen 3.
  */
 enum mem_type {
 	MEM_EMPTY = 0,
@@ -218,6 +219,7 @@ enum mem_type {
 	MEM_NVDIMM,
 	MEM_WIO2,
 	MEM_HBM2,
+	MEM_HBM3,
 };
 
 #define MEM_FLAG_EMPTY		BIT(MEM_EMPTY)
@@ -248,6 +250,7 @@ enum mem_type {
 #define MEM_FLAG_NVDIMM		BIT(MEM_NVDIMM)
 #define MEM_FLAG_WIO2		BIT(MEM_WIO2)
 #define MEM_FLAG_HBM2		BIT(MEM_HBM2)
+#define MEM_FLAG_HBM3		BIT(MEM_HBM3)
 
 /**
  * enum edac_type - Error Detection and Correction capabilities and mode
-- 
2.25.1

