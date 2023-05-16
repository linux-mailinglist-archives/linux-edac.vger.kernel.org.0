Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0BB7058CB
	for <lists+linux-edac@lfdr.de>; Tue, 16 May 2023 22:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjEPUZL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 May 2023 16:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjEPUZC (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 16 May 2023 16:25:02 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0FF132;
        Tue, 16 May 2023 13:25:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7kunu7eQukSFf2suKLEuuDy06BWYv28Oh80C2YgC8HryyxkgVX2OEL79yWoTXejg/PJedZEL+D3Jv9NHexkUFPY6D6gmwqMv28dIhypWCMiQt7IV7pmDaZWSW5skRXcqBRrpD7ppNYKzlbIarqaKjGju3SlPssm8IXZyCBMxSO42i0SBBv83bW9BLtkJ4SAe8ArFpkiNCHQ+28GN99T9VpsyYHHgL/Ar3HQMWg2trhg+3GRmh6q42Xceb1xRmhZZS2N5Y5qIZkqUXKPEzLbRz5xAhFMgCI5IPL5iGR/5KeuX6E4ufyz1zPahzqZ26EbrnRJGXI7QzjDNl6yjx+Zvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upqSgRjvn3kgYne4u2rmiqfVXMmajGzToqGyHGD3JE4=;
 b=ij+ePoE2R1zU32Pk6OxBJ8yK3qTdbtSiSxNFHiN5egbCZkeT4AeRQ91mxe3fb7m4eJgs1dwyXID0MC5eNbosrPQ9xgrlN63KnryAkGUhirSnU/Q3+WA+IA3tAWTuMkv1msdCvX/gX5CieArl7M/SPrh7z5ZkeEksu4IbiWaHdZ0v5MO/7QXrFk5/8j02OHh8h0vAb5x4h2p+jnjO4euV2W07x+2wks2BfYPOO7PDt6assjkrwidpmp0gFuLQYIN2v98zFrGstiRVGKMu1F+DysJLq5cPu1qA+X7Uxvi39DY+EOYF34KxMNda6NtR7BeY73uGHPhR03T8cqsxueniIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upqSgRjvn3kgYne4u2rmiqfVXMmajGzToqGyHGD3JE4=;
 b=W5vdo0ysY/07aHTncVJMcpEjJy7zzwqtYm6DuFynqlu2QqpsPFqZFgxJxWR0mTQQuqgXAhaFxkCZkT9k30HG0ITlxV4SPbwPD8x0RwYl2N/hB/lmN+geALMdNJZub//NDSKmK31zd743xKqHaYtIu1288haPf+3XrOh3NUZrh7Y=
Received: from BN6PR17CA0046.namprd17.prod.outlook.com (2603:10b6:405:75::35)
 by PH0PR12MB7011.namprd12.prod.outlook.com (2603:10b6:510:21c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 20:24:56 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::ad) by BN6PR17CA0046.outlook.office365.com
 (2603:10b6:405:75::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33 via Frontend
 Transport; Tue, 16 May 2023 20:24:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Tue, 16 May 2023 20:24:55 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 15:24:51 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <markgross@kernel.org>,
        <hdegoede@redhat.com>, <Shyam-sundar.S-k@amd.com>,
        <linux-edac@vger.kernel.org>, <clemens@ladisch.de>,
        <jdelvare@suse.com>, <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <mario.limonciello@amd.com>,
        <babu.moger@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 6/6] hwmon: (k10temp) Reduce k10temp_get_ccd_support() parameters
Date:   Tue, 16 May 2023 15:24:30 -0500
Message-ID: <20230516202430.4157216-7-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516202430.4157216-1-yazen.ghannam@amd.com>
References: <20230516202430.4157216-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT054:EE_|PH0PR12MB7011:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d542207-6bd2-4fe9-0be6-08db564b9cae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Q00+mEaaWNMa0Jkoky6j49pr/oCmL50EvJkg3lQ0Hf8MdS+zw8wheKF3iIBVxZifgyANnruXyGSM2bgjjqL7qNu33oJxN3mSDKR3tLaSyJyVQRYXVD/bjS8paJjzZy9njNIGZKJ/oQ1wrFhQMj4CgIQ/TY9ZkxNx83vm/kmJi4wZzATnXA6FVVPPnmTT+ba2kIMU/bSKCtsTwNuSAzzbAdFCyoOH3QvAXhBU1mXC/S1xPbso+mlW1H1KWeVpB1YEmBroH3z40/n5LHkKlDxDE2YwnkByBQV1UkhI7yEdqskf04dFVVv3EXVKq6Mbd46fvj2pkO0+UUrmsnTNdfEjJkhZVtnLNUWnSFnexetwr9Q/wpr5B18Txk/hNtHkUbgBIJxzpgeqEZw0sJra4qZo04O0IlSmnjwaNsMNDU1P4ccYxtYsX6A8pW4bW5nPv/Q6OHvR6hGrGrMJv9SW8Z0I5wGayk5+oSTzdZvKAZzg2xymD/cPjYSnFV1/tvxmPQYof1WXqeAltvj/L10lYlRmYNeyPwX95fJ+BX1dOV/QUTf3/cu4Kr4B0EeQdp2lXTTWg9ifhQMHO1sCmAJn8wL5eZqAiOw0YdwaFpIHJhYEc4g7izRRdFOmBLWaEOXvZ7q8F0o9HnoR6OyMYMK8CLRUdakOoU9Am6/+kTwN9/qkI02za7GGnildtdzvuDSZHK6v4BYsV4zEotNCH7CxEBHPS/ItDV3BwXOeONXLnhJmNsvwxI4rv35DHo0S6VslpmCAgnGAa8CT/2qHEGmOugVSA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199021)(46966006)(36840700001)(40470700004)(82740400003)(83380400001)(478600001)(54906003)(70586007)(70206006)(6666004)(7696005)(41300700001)(6916009)(36756003)(86362001)(40460700003)(4326008)(316002)(82310400005)(40480700001)(36860700001)(1076003)(336012)(47076005)(2616005)(426003)(356005)(81166007)(186003)(5660300002)(2906002)(44832011)(7416002)(8676002)(8936002)(26005)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 20:24:55.3932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d542207-6bd2-4fe9-0be6-08db564b9cae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7011
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

Currently, k10temp_get_ccd_support() takes as input "pdev" and "data".
However, "pdev" is already included in "data". Furthermore, the "pdev"
parameter is no longer used in k10temp_get_ccd_support(), since its use
was moved into read_ccd_temp_reg().

Drop the "pdev" input parameter as it is no longer needed.

No functional change is intended.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/hwmon/k10temp.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 06af1fe38af7..873dbe0f5806 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -379,8 +379,7 @@ static const struct hwmon_chip_info k10temp_chip_info = {
 	.info = k10temp_info,
 };
 
-static void k10temp_get_ccd_support(struct pci_dev *pdev,
-				    struct k10temp_data *data, int limit)
+static void k10temp_get_ccd_support(struct k10temp_data *data, int limit)
 {
 	u32 regval;
 	int i;
@@ -435,18 +434,18 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		case 0x11:	/* Zen APU */
 		case 0x18:	/* Zen+ APU */
 			data->ccd_offset = 0x154;
-			k10temp_get_ccd_support(pdev, data, 4);
+			k10temp_get_ccd_support(data, 4);
 			break;
 		case 0x31:	/* Zen2 Threadripper */
 		case 0x60:	/* Renoir */
 		case 0x68:	/* Lucienne */
 		case 0x71:	/* Zen2 */
 			data->ccd_offset = 0x154;
-			k10temp_get_ccd_support(pdev, data, 8);
+			k10temp_get_ccd_support(data, 8);
 			break;
 		case 0xa0 ... 0xaf:
 			data->ccd_offset = 0x300;
-			k10temp_get_ccd_support(pdev, data, 8);
+			k10temp_get_ccd_support(data, 8);
 			break;
 		}
 	} else if (boot_cpu_data.x86 == 0x19) {
@@ -459,21 +458,21 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		case 0x21:		/* Zen3 Ryzen Desktop */
 		case 0x50 ... 0x5f:	/* Green Sardine */
 			data->ccd_offset = 0x154;
-			k10temp_get_ccd_support(pdev, data, 8);
+			k10temp_get_ccd_support(data, 8);
 			break;
 		case 0x40 ... 0x4f:	/* Yellow Carp */
 			data->ccd_offset = 0x300;
-			k10temp_get_ccd_support(pdev, data, 8);
+			k10temp_get_ccd_support(data, 8);
 			break;
 		case 0x60 ... 0x6f:
 		case 0x70 ... 0x7f:
 			data->ccd_offset = 0x308;
-			k10temp_get_ccd_support(pdev, data, 8);
+			k10temp_get_ccd_support(data, 8);
 			break;
 		case 0x10 ... 0x1f:
 		case 0xa0 ... 0xaf:
 			data->ccd_offset = 0x300;
-			k10temp_get_ccd_support(pdev, data, 12);
+			k10temp_get_ccd_support(data, 12);
 			break;
 		}
 	} else {
-- 
2.34.1

