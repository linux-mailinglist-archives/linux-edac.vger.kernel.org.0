Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E371C731D5E
	for <lists+linux-edac@lfdr.de>; Thu, 15 Jun 2023 18:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236173AbjFOQDy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 15 Jun 2023 12:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234795AbjFOQDv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 15 Jun 2023 12:03:51 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1082949;
        Thu, 15 Jun 2023 09:03:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJEBnYGYkfHpsQFSP0OYJ7EBJbBHzP+K4pEF/mduHIm9d0a080EuUusR5TtFHbjx888YTnAXzS8J3s3nRXJQRjqEHG+K4P2dC/jJo16n2d+AK+eqVjDrK3S96wAl+u8+UtwELjGfykEGMSmE6L+DuwRokQz6xitbM+dUAClJWzV9dAec4nURKwG4ENnjF9pr50LaqwDS3iDLHF1MktPFpezHFIu/+giqPSa+z09Czp8xptjDaMjZlc17E4CbuYefJuqwHpjWl8rUmdZfCt+3Sx9Wu5nepTM2HOt0NXSwrjDk8wEojcRGZPuPBcGt+ZPMgxZE0xzCOiyk1oa7QB8ZZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7p4zo5ayo+Kmd3jmSYZOOe8kuz8N+Ns8XahyJ3wyjPo=;
 b=gqOKnh46bW7FvzwwjaL5BpHgnZyhYAbdzrKCexTrJPEsgCpy17z0M5rFDogz/q8irG+CTTKdghgYXCcG6Tp5ahJDWeySGIuYgEzzGeHcQdtHOqcexqq/+GibKLlIy6a+U1mOFoEQKH+HwCFCs01KLI+x8lRUVWrp/RYa6N9B3Fq7fdlVNE1h67Vwet0GOhuFKdfR/skTx+cWSgz4Gm0/cnUUMqpZ3chKuzMcpZccH44vvw8P4pbpVNGhmsPy8Iduuire+WIu+J/xNScpFF3gVPrlFmDf81voZrjuloaPee7pZ9DIom2g/EI1Zp7sC5UX1ZuZzzSI3TSl05gBY2rhtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7p4zo5ayo+Kmd3jmSYZOOe8kuz8N+Ns8XahyJ3wyjPo=;
 b=iYS+dmLPpmOY85TFiCyJoH4sJ0HNRHQPI1yt6nbiYCYTU5Q4pH34mm/M7TY/iY/K/kmT3EvW0r12wCRDBwTlY6r01/pX22ArjXo+FYml1tNh+ph8Z2OjQmrMC2npA5pkTr4rsqe8JuPNEnEAmkawjRMbqBmV5VxFWIkKXP3mXWo=
Received: from MW4PR03CA0255.namprd03.prod.outlook.com (2603:10b6:303:b4::20)
 by MW3PR12MB4507.namprd12.prod.outlook.com (2603:10b6:303:2c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 16:03:47 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:303:b4:cafe::91) by MW4PR03CA0255.outlook.office365.com
 (2603:10b6:303:b4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25 via Frontend
 Transport; Thu, 15 Jun 2023 16:03:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.27 via Frontend Transport; Thu, 15 Jun 2023 16:03:46 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 11:03:45 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <markgross@kernel.org>,
        <hdegoede@redhat.com>, <Shyam-sundar.S-k@amd.com>,
        <linux-edac@vger.kernel.org>, <clemens@ladisch.de>,
        <jdelvare@suse.com>, <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <mario.limonciello@amd.com>,
        <babu.moger@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 6/6] hwmon: (k10temp) Reduce k10temp_get_ccd_support() parameters
Date:   Thu, 15 Jun 2023 11:03:28 -0500
Message-ID: <20230615160328.419610-7-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230615160328.419610-1-yazen.ghannam@amd.com>
References: <20230615160328.419610-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|MW3PR12MB4507:EE_
X-MS-Office365-Filtering-Correlation-Id: 580ed92a-a9aa-46c1-6628-08db6dba1a09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tRg7L7/RA1vJFmRNhWYr4C/gLSgSlrN+1va26FJrxeLBpN0M7e5Ic2BbZLXIixSDXxseQd4xdVg8c6lnWty7CQSe6BHBS04sBciA6bXKDtq+Mab/8Y7XfDn7IRN8GqiFcdGANIMblN7T5tczqzgzEDeJUINBpWGP9HGMM61y/w8WlvK7wBsrw9Gq7p6mS82s8GOcYNyq9DouhnPkOc20XKnWga+tiS93dBg+CgKE/QL4OzKdlqmXZC8tn2JvB/WWKH2KI1AwtSS845ja5yGQXvU+t3uaKKlGlCDmfQYJkug3KplMGkPgWcLsE7DKlrZI56S6Xn+OAziLQI+nIe+UY4KYwLd6SryITW1kZ7PfGMIWhBJMDeBqDMHZLwkUVrIPWP0aP6ke4MA2kk4unSUCqZDPTEN3E5+ubyHN9+JTLkUjGpLjEeYTZ323MGkeAFbwx4kG7yApxJCBvhyv6/lmgesK3jxq0KNWZDXRQ+oo23uScbk3j23BC0x7pdlAIfjlnQVx8sdQPXggtnCF7vqkTy9HWoROYA1rOT1NduElUFlrXtkQ3lDXw7dZhJPTmtRiZSbaAQBT1sDnHmQwaoa8RFULJBvistTeW8rimDyMolFEpd8mWZyvgaCm++5+5LEFLq2cpeNj0GTqLlCUgekO0PFpweqV6opbAxKRu1XaQPnIq/KXLg8zZtJWOpzt35er1RpTheyJv8b1mWx4ohrYEcc1ytfMgdYW8VbvOMVJjE6YP8myoyPSj8xhpckMCYZsbVRWEY24RWlW4VvH4Jmr3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(5660300002)(44832011)(7416002)(8676002)(8936002)(41300700001)(40460700003)(2906002)(82310400005)(36756003)(40480700001)(478600001)(26005)(86362001)(1076003)(2616005)(47076005)(83380400001)(336012)(966005)(7696005)(426003)(6666004)(36860700001)(356005)(81166007)(4326008)(6916009)(70586007)(70206006)(316002)(186003)(82740400003)(16526019)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 16:03:46.9819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 580ed92a-a9aa-46c1-6628-08db6dba1a09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4507
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
Link:
https://lore.kernel.org/r/20230516202430.4157216-7-yazen.ghannam@amd.com

v1->v2:
* Add Acked-by from Guenter.

 drivers/hwmon/k10temp.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index dfbba8b72f43..dce97aab2fa7 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -377,8 +377,7 @@ static const struct hwmon_chip_info k10temp_chip_info = {
 	.info = k10temp_info,
 };
 
-static void k10temp_get_ccd_support(struct pci_dev *pdev,
-				    struct k10temp_data *data, int limit)
+static void k10temp_get_ccd_support(struct k10temp_data *data, int limit)
 {
 	u32 regval;
 	int i;
@@ -443,18 +442,18 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
@@ -467,21 +466,21 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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

