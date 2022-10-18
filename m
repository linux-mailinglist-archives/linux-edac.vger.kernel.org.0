Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413AA602FDA
	for <lists+linux-edac@lfdr.de>; Tue, 18 Oct 2022 17:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiJRPgw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 18 Oct 2022 11:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiJRPgt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 18 Oct 2022 11:36:49 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D232BAD992;
        Tue, 18 Oct 2022 08:36:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RlkWV852OLkOK6VIC4MJ7pbO5fAQ+OZFXN8utvL/kPI4uluZxYZgF8+i2GPHMuxlGNIL9MyGOmZ2IKZ13P0Ek21O6uScm+9nHbPJQrcTw6FOlJCIS5iMY9LDu59XOnGGRklKmRPKuTgkQC0T3W4ViAQdqbPp+f6HMqbvdFVMAj+9jG1qWmG1ojCgykHrWUqgcWZG8mehUg1y7lEMgPsMaKLszio+g4JeWnCGUCWZWUF4em+8Zp0BRgLZ5LvWEZU7BuImeYRQdrRP7Hkc/3FPMvepb+tD8piiUT+G4i0ZQ8K7mv4gA8ExHvii4rqB78uso5q+bKVtHViU8H/C2sCBNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuGk9mXWTlSnx7JBlqdTIHQR7j4WXV/bRxEo5ZyKCEI=;
 b=ix4Ek4PgOyJFsNds9CHVU3lSPe0A3VdA1/N+HKri1o8BQLe45EtXXEASvzG0SKGeBey5tRh5mGDvJB+/Yh+1WlIErolBfIPXTdxVuiEkkkM4Q2rN8ATqYpsj2VbKnC+ydjMHzZrV/CiDscaVEW//Gss8JW716ijFDNJovuSNk2qkHb8Bm4neHC28KUtLH0c40wPsvBRZTyKTWOfzzGwkLunURXuWrSmsVdrw6gajeNKFJFzP9WH7rFh2gIHdFqq8t+SZmrOCqWtuzex4hYyPR7xgNLg1SbCEbMkL0DDp7PIwO+r+BZp6ZmcPEAOSizrhMfDLNt2vLWPfsM6DING2aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuGk9mXWTlSnx7JBlqdTIHQR7j4WXV/bRxEo5ZyKCEI=;
 b=3pTRfrX1o/J1oaoU5M+qDQl8URFbOMTpbLq4ivx93sdC3SlSeNzgbkQfeyki0xanLvl5DSDcRXUkGKgIIgF0LMQG6lz6RrsD5grhY+C1YoG3efBZBbloZxSABke30eLV3q7uhDDbopsF3VnPWw1KLcaF1AoiDGBPLTnuuv1Bz4w=
Received: from MW4PR04CA0386.namprd04.prod.outlook.com (2603:10b6:303:81::31)
 by MN2PR12MB4160.namprd12.prod.outlook.com (2603:10b6:208:19a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Tue, 18 Oct
 2022 15:36:46 +0000
Received: from CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::91) by MW4PR04CA0386.outlook.office365.com
 (2603:10b6:303:81::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30 via Frontend
 Transport; Tue, 18 Oct 2022 15:36:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT111.mail.protection.outlook.com (10.13.174.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 15:36:44 +0000
Received: from titanite-35bahost.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 10:36:42 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <Smita.KoralahalliChannabasappa@amd.com>, <mchehab@kernel.org>,
        <tony.luck@intel.com>, <james.morse@arm.com>, <rric@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH] EDAC/mc_sysfs: Increase legacy channel support to 12
Date:   Tue, 18 Oct 2022 10:36:30 -0500
Message-ID: <20221018153630.14664-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT111:EE_|MN2PR12MB4160:EE_
X-MS-Office365-Filtering-Correlation-Id: 634c7ccc-862e-4bcc-8815-08dab11e9007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MNOfAXvMh1PlL9nHeo5F+XUu33QfJsb9f0WET7VQWbP+lPOFgQoGvA8pMnW5Ah27W19MpvHzo+aKY65domWtL1lO1buxbstPEa6Ry6C82jjBZfNfX7cqhZapQG8HLJ1fF6Ly5urD6CnCOg5GgS92dLOrFIQq5XAuUT9KKdiZt+9qYcVLwnbbVBBwAXXUuM/E2qqXHDNWpj6KyDxW8y8R3M/kKetFbp+QonwmpeoNucpjH7oT4w9vbXCH5baCAyxWlKcFLIn/JQE2t7d1H4P0oOvpI1gf5nn8a6oGSw9jEACqbwz4XocdtZwRgE8T0cqPh6SIRh1p5SuH3UGJr6c6C2EoOPT9shEsHs3aec67Rg1rtF0WLlQAgctHYrvhpTqP1BzZosUbzvYOLt00VZT3Z2eSzj3FOpXeaASom/6ccpIneWhWTE6+/oQsoanG2JZPxTheCtbp0+EgZtWiffH3B7wbtg0NpQuGuKE7hWvFQlBsjyb/CR+ex9TDGF649aI9djRV54O6dONSCE7xYGIMhh0FjOZqLknOTnCA/pLBiBcit65lgGjvRYBm1mxr0h5ithKmO3v7sEDcKw2/ZpPjI4Dibf0EbMnzaRcveNdsGP9/r0I1QSsyWnCNWCNuFYL2RomCPZbhB9yQuO7dhpK7udYgjzgnnVkGGdg0O/5Gxb/FEaPdlGA8BTV4TYLBlZ+6w9cCbo9hXF04juzudhdJUpjkGXGjFJnJuN2ecnTu3qRR20xtrSn6/IQ0dLZhG+tdd5St6amCgvGSRqx36yLMSNZyO/FDx+IoaIfkateL+fo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199015)(36840700001)(40470700004)(46966006)(36756003)(47076005)(44832011)(8936002)(5660300002)(82740400003)(81166007)(336012)(83380400001)(356005)(86362001)(426003)(36860700001)(26005)(110136005)(54906003)(40460700003)(16526019)(6666004)(1076003)(2616005)(478600001)(186003)(316002)(40480700001)(4326008)(70586007)(41300700001)(70206006)(8676002)(82310400005)(2906002)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 15:36:44.8175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 634c7ccc-862e-4bcc-8815-08dab11e9007
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4160
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Newer AMD systems, such as Genoa, can support up to 12 channels per EDAC
"mc" device. These are detected by the device's EDAC module, and the
current EDAC interface is properly enumerated. However, the legacy EDAC
sysfs interface provides device attributes only for channels 0 to 7.
Therefore, channels 8 to 11 will not be visible in the legacy interface.
This was overlooked in the initial support for AMD Genoa.

Add additional device attributes so that up to 12 channels are visible
in the legacy EDAC sysfs interface.

Ignore checkpatch warnings about "Symbolic permissions" to maintain
coding style.

Fixes: e2be5955a886 ("EDAC/amd64: Add support for AMD Family 19h Models 10h-1Fh and A0h-AFh")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: <stable@vger.kernel.org>
---
 drivers/edac/edac_mc_sysfs.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 0a638c97702a..15f63452a9be 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -298,6 +298,14 @@ DEVICE_CHANNEL(ch6_dimm_label, S_IRUGO | S_IWUSR,
 	channel_dimm_label_show, channel_dimm_label_store, 6);
 DEVICE_CHANNEL(ch7_dimm_label, S_IRUGO | S_IWUSR,
 	channel_dimm_label_show, channel_dimm_label_store, 7);
+DEVICE_CHANNEL(ch8_dimm_label, S_IRUGO | S_IWUSR,
+	channel_dimm_label_show, channel_dimm_label_store, 8);
+DEVICE_CHANNEL(ch9_dimm_label, S_IRUGO | S_IWUSR,
+	channel_dimm_label_show, channel_dimm_label_store, 9);
+DEVICE_CHANNEL(ch10_dimm_label, S_IRUGO | S_IWUSR,
+	channel_dimm_label_show, channel_dimm_label_store, 10);
+DEVICE_CHANNEL(ch11_dimm_label, S_IRUGO | S_IWUSR,
+	channel_dimm_label_show, channel_dimm_label_store, 11);
 
 /* Total possible dynamic DIMM Label attribute file table */
 static struct attribute *dynamic_csrow_dimm_attr[] = {
@@ -309,6 +317,10 @@ static struct attribute *dynamic_csrow_dimm_attr[] = {
 	&dev_attr_legacy_ch5_dimm_label.attr.attr,
 	&dev_attr_legacy_ch6_dimm_label.attr.attr,
 	&dev_attr_legacy_ch7_dimm_label.attr.attr,
+	&dev_attr_legacy_ch8_dimm_label.attr.attr,
+	&dev_attr_legacy_ch9_dimm_label.attr.attr,
+	&dev_attr_legacy_ch10_dimm_label.attr.attr,
+	&dev_attr_legacy_ch11_dimm_label.attr.attr,
 	NULL
 };
 
@@ -329,6 +341,14 @@ DEVICE_CHANNEL(ch6_ce_count, S_IRUGO,
 		   channel_ce_count_show, NULL, 6);
 DEVICE_CHANNEL(ch7_ce_count, S_IRUGO,
 		   channel_ce_count_show, NULL, 7);
+DEVICE_CHANNEL(ch8_ce_count, S_IRUGO,
+		   channel_ce_count_show, NULL, 8);
+DEVICE_CHANNEL(ch9_ce_count, S_IRUGO,
+		   channel_ce_count_show, NULL, 9);
+DEVICE_CHANNEL(ch10_ce_count, S_IRUGO,
+		   channel_ce_count_show, NULL, 10);
+DEVICE_CHANNEL(ch11_ce_count, S_IRUGO,
+		   channel_ce_count_show, NULL, 11);
 
 /* Total possible dynamic ce_count attribute file table */
 static struct attribute *dynamic_csrow_ce_count_attr[] = {
@@ -340,6 +360,10 @@ static struct attribute *dynamic_csrow_ce_count_attr[] = {
 	&dev_attr_legacy_ch5_ce_count.attr.attr,
 	&dev_attr_legacy_ch6_ce_count.attr.attr,
 	&dev_attr_legacy_ch7_ce_count.attr.attr,
+	&dev_attr_legacy_ch8_ce_count.attr.attr,
+	&dev_attr_legacy_ch9_ce_count.attr.attr,
+	&dev_attr_legacy_ch10_ce_count.attr.attr,
+	&dev_attr_legacy_ch11_ce_count.attr.attr,
 	NULL
 };
 
-- 
2.34.1

