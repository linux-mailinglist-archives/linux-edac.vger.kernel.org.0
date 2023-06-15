Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBABB731D5B
	for <lists+linux-edac@lfdr.de>; Thu, 15 Jun 2023 18:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235755AbjFOQDx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 15 Jun 2023 12:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjFOQDu (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 15 Jun 2023 12:03:50 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6B8E4;
        Thu, 15 Jun 2023 09:03:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OE2q1YgsVuHWmuYpMSOyAt7nLHFg4BniCyDISezhTM5rn/fggr7G3M7syb3x7HklbUs87eosDkJe5CudoqK+a1e9bpyICXJUpVnqeIdlN4Ofoz21jZX9QlwZrMlzEZjIUevlCtKhf9PWZyu7jSdQIQJeCL5p0cm/uynzK87IJShEar+4vFe/DCk0pBak2BPS2rBCQak5Mi2sZJXYhy+N/Y9YErBy67/4CHiR3oRRQLd9Saa/cVxpKVQQ/wO6iTW96UXYS/RhvaPaYj+IIpAoOGKerEpmFaK+9ybFopANxtEPWzX3IdzOKZHlgv6SpXRjT7jfmQCiVWkaGomxlRF1kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8n6pR0SsFdo/0r+QsQhrVNyQ/1Xi+TgwPwV7FJp1+qs=;
 b=JImipQ81VQELXjuNiVMArYqNDql3ZCHwjEHOnyX/DE9xdfUFBaDrUXVKUPA1ZZVOsr9pafRUB2OTHBEv8klleQYJTjGbI2FfdgbMWsnO20YAQI9prttuXFEhThmW8cB7HNHoOI6i2dQ6/bDVzXLUotCwf/EUT/JdW7Qc29qFKm6I9ZnsZfC0FEypeVCf1h7RNeYQx3IML1FXLfVIXTUyClP21Ga2OrbFnIdo+aTUL//g54aHLJpy+ifZTFNAKLDgo4QSfGZKAM+24mxgpgDh49Sd80re3bnfy7nal4fLUm9GjF93ITQZtFTg6EVHEuJEV5ixDZpUAv40LfH+GYvx9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8n6pR0SsFdo/0r+QsQhrVNyQ/1Xi+TgwPwV7FJp1+qs=;
 b=yHiFiUK7SfMBkxGXNc33KwfEJAZvZfYWA/962gYvMXxpV0sL/RW9YTqKB5YyAWiNZNXiovXzIr6DvfrE1e7Yi9IWptq4AKmLsg9kUY84w9K8PbJku3WN3BYaSVtblvN+FEM2z7NMKHEGe78Wp0Lre5K1h9067ZIVQpyVHmRfpb0=
Received: from MW4PR03CA0265.namprd03.prod.outlook.com (2603:10b6:303:b4::30)
 by BY5PR12MB4870.namprd12.prod.outlook.com (2603:10b6:a03:1de::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Thu, 15 Jun
 2023 16:03:46 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:303:b4:cafe::f1) by MW4PR03CA0265.outlook.office365.com
 (2603:10b6:303:b4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27 via Frontend
 Transport; Thu, 15 Jun 2023 16:03:46 +0000
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
 2023 11:03:44 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <markgross@kernel.org>,
        <hdegoede@redhat.com>, <Shyam-sundar.S-k@amd.com>,
        <linux-edac@vger.kernel.org>, <clemens@ladisch.de>,
        <jdelvare@suse.com>, <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <mario.limonciello@amd.com>,
        <babu.moger@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 5/6] hwmon: (k10temp) Define helper function to read CCD temp
Date:   Thu, 15 Jun 2023 11:03:27 -0500
Message-ID: <20230615160328.419610-6-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|BY5PR12MB4870:EE_
X-MS-Office365-Filtering-Correlation-Id: 8df0a458-a603-414c-b8df-08db6dba19ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DqFWcK1R9Qd2DxQxtloXZVhdXn5dvE57vA71bbu4PzQFQxpc5HJ2qD+31rn0BHzZymxwGzvffHBE+dxVeS3GkTDiOdNHSIi4EY0EuIebMqv3T1s4JCegcvEaJS8xK2IzIwGPMxHOVv9QHulAd8GU26kkwdnKchlwc+8/jYVHcRsTlMn0dhOoucyR7BAnPV+htYLDKW5BU1ZOy57OR5wm+rGIHhk3m+dVxUTPRz4nAZNL8//habS+PIG5OG/tN5zx0hBrMc4RjYEzP0vd3knaxXh2jFN/W71+Dly59XSKNqElrg3YIzCJOEfN8az80NBvAReEu5b5pv6vSmbNIKc0YogY86kgz/aiBGNLkK2cnDxWH3r6H7CVPf9WYTV5Y+HYb53VATeyEw+Tebu9Fd//Pdi/V8YkqsKVLKE1eM/iB2baUnSIVAeHE7wgQ7SM/uHJbN19pH+JuFgH23CHXeAEk3mLY7pM2PXHWnIPUPC5SJbZ4CgCCko7Ob9V+tWrjZIvl/CMlH6J8FdqS7moRzUXe6lmia5Kkyvvey1HtNySHVa3RFttv2T6F0KW2N0i5LeCChRpxe9duglj7PDPhPeJrluG+r4RX9MHN8Zm3Q9Z8ueqIFN9b1n7SQ3CLf9kh0AdwW/g0NL02PldIAkMeY3ZIZIUq3b/HStNwgAmqlse4ndL2+P9nFWEklPKn3KeFz8DVw6D6Qgnpnr81WxvRuMO6J9/VidkbST5HzfWdoNIyzB20ITRVqlgZJ/FBzK3+tV9
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(2616005)(336012)(54906003)(83380400001)(426003)(36756003)(70586007)(47076005)(4326008)(356005)(82740400003)(478600001)(81166007)(70206006)(6916009)(2906002)(6666004)(16526019)(316002)(186003)(7696005)(26005)(36860700001)(8676002)(8936002)(86362001)(7416002)(82310400005)(966005)(41300700001)(5660300002)(40460700003)(44832011)(40480700001)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 16:03:46.4662
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df0a458-a603-414c-b8df-08db6dba19ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4870
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The CCD temperature register is read in two places. These reads are done
using an AMD SMN access, and a number of parameters are needed for the
operation.

Move the SMN access and parameter gathering into a helper function in
order to simply the code flow. This also has a benefit of centralizing
the hardware register access in a single place in case fixes or special
decoding is required.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20230516202430.4157216-6-yazen.ghannam@amd.com

v1->v2:
* Address comments from Guenter.

 drivers/hwmon/k10temp.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 70f7b77e6ece..dfbba8b72f43 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -150,6 +150,13 @@ static void read_tempreg_nb_zen(struct pci_dev *pdev, u32 *regval)
 		*regval = 0;
 }
 
+static int read_ccd_temp_reg(struct k10temp_data *data, int ccd, u32 *regval)
+{
+	u16 node_id = amd_pci_dev_to_node_id(data->pdev);
+
+	return amd_smn_read(node_id, ZEN_CCD_TEMP(data->ccd_offset, ccd), regval);
+}
+
 static long get_raw_temp(struct k10temp_data *data)
 {
 	u32 regval;
@@ -215,9 +222,7 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
 				*val = 0;
 			break;
 		case 2 ... 13:		/* Tccd{1-12} */
-			ret = amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
-					   ZEN_CCD_TEMP(data->ccd_offset, channel - 2),
-					   &regval);
+			ret = read_ccd_temp_reg(data, channel - 2, &regval);
 
 			if (ret)
 				return ret;
@@ -389,8 +394,7 @@ static void k10temp_get_ccd_support(struct pci_dev *pdev,
 		 * the register value. And this will incorrectly pass the TEMP_VALID
 		 * bit check.
 		 */
-		if (amd_smn_read(amd_pci_dev_to_node_id(pdev),
-				 ZEN_CCD_TEMP(data->ccd_offset, i), &regval))
+		if (read_ccd_temp_reg(data, i, &regval))
 			continue;
 
 		if (regval & ZEN_CCD_TEMP_VALID)
-- 
2.34.1

