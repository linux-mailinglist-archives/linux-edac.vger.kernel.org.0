Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE2B7058C6
	for <lists+linux-edac@lfdr.de>; Tue, 16 May 2023 22:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjEPUZK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 May 2023 16:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjEPUZB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 16 May 2023 16:25:01 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6E497;
        Tue, 16 May 2023 13:25:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZjLHuNs0E4UZtKDXokZLt1SUSKwlY8a+OWvH4zcM0kHQMiVFTSUN+hIRT2ogFTXdGQewsaaqLzYW6769+jQYzjg4fKZU40Q8RAD3+gjTgn8P8u2Sy0CIIzN/bwHbHOqqgbNZAAvc0bkN6S7zhNUz9FmwVyaWoIS6hXTWcaEG3aR5nKbItQvzSzEzSiMZKsuIbiJsuM5Ly2U24BTvLXYg3Z9PygdGth7VaccmX9OxanBJ6TfUqZo7KbmHy7/+MkQ8SG0skzGmBd/BHzAFGG9TDQveQd2Nhkt7JLxXhZYW0ryhafoORkTrDIQucDRP1K6Q8QXtFof5T17Wgn+j7niGIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aji6vNroVQExDKpw5+gxvl+fZyGHaciz4uIiFsFbM+w=;
 b=FBZDbz5yhoHp9ey8o7w9cw3k65+YqehVv5eK9bcTKBjudQkLu0ctmHc6YgB5+dUjtkHwDMuXFIw0waT3vDbRIuSubBiAmOsEHCwqLgggH6SGi0ANXoX55NfV4ovJDNLxqF977lvc0yFP96ax4EEQYOk867j/8dixQGSTNugbSlFxwyzLJ2BjT31ur86oN329FetpIJz+FyrwNFM5FD4QdQ41oAICLxluBqIKTJUgCzgT6RYfo3mydKarsv01zGxgrg5BME9/gaD8vXgTd/D+v9CUSU5221tBXPPgxvJyCEAe0nsQm7X673mBKJJNu9HQ5E2kEE4rLY/5dorb4EBFyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aji6vNroVQExDKpw5+gxvl+fZyGHaciz4uIiFsFbM+w=;
 b=EtMNEX+n6Rx0g5rhxyDXEZN8A7o6RGQHYfCdLT6xZYV4NU5/X8tDm4+YAV7UvsvSQejZYgN6uHgW8nZSbXJUk8d/XcrEJjafXRCvq/iyOsGYI1hiRruYVJogbOjwx5C4S45bboYW33CnlQAp9hGYf+Jti6UzUbbuwBlKCkTjoRs=
Received: from BN6PR17CA0028.namprd17.prod.outlook.com (2603:10b6:405:75::17)
 by PH7PR12MB6788.namprd12.prod.outlook.com (2603:10b6:510:1ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 20:24:55 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::a4) by BN6PR17CA0028.outlook.office365.com
 (2603:10b6:405:75::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33 via Frontend
 Transport; Tue, 16 May 2023 20:24:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Tue, 16 May 2023 20:24:54 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 15:24:49 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <markgross@kernel.org>,
        <hdegoede@redhat.com>, <Shyam-sundar.S-k@amd.com>,
        <linux-edac@vger.kernel.org>, <clemens@ladisch.de>,
        <jdelvare@suse.com>, <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <mario.limonciello@amd.com>,
        <babu.moger@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 5/6] hwmon: (k10temp) Define helper function to read CCD temp
Date:   Tue, 16 May 2023 15:24:29 -0500
Message-ID: <20230516202430.4157216-6-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT054:EE_|PH7PR12MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: fc937b06-58b2-4076-da8b-08db564b9c17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: esrzDOQGD2tL0y8i+wrTgv3k5X9vhyZ47ILDwriMkpxf4IB1oZi/oYU3WHNCsruk2CtJsy6c7A+bxuSEOy1qtQlKFHRFutTbA75FOM02RVV4IZnPxP/du0GM8Mn1xdvFVoU9/CwG2NGUthNdJOjuK8E65uhyZIKnRAvUNopwgf8z4HCukJZXE+R5Abp4li+4Y9xrgQzQypkYUXr+EUhnGhgFy5dmgDqnsJLqindIoXhodDhkg1BwgIRppZbMrwBF8UWP/5rNSq/r6KmhIbtpAJJknxqL9T9vTqukXjDcSTNg20AitZU3iMGUtfBtuI42Ku9dB7amzARzPIhEb0sS8HBaknKjc5K2DRPkMuMwo8BOOfjC5PKLKDEB4Z0Cp1K/bQiTcRwjHCgNdRuwdJ9edyIwEUpZM2zJyWWUsfGYVMFb2x19RLjt637081HSnWkU3Mh430aP956J+r0ckcjrqscCsmDPGiWDWIsJszOBtD76sE7RwviFi0F6uYzp+V3k9jaxJNifaiK4YGVj+FrAsQdDu7sBbvq5n5zg806dAUH1sf6m9a9GKUbxeypZo2iAuZHAivrGRXC2cZMBnJ2IIk8Y5AniY6hR3DMJmeE82Q7utzv0qOX1VbuTm6uKvQXunqJEs5cLLJVQFdBQR+5KbxaYmnWvetrdG9gNS1/c2KN8G394b1CUvytgRJIGvfQn4YdyvuChBfWmnWKNYFIijTBCaQR4lVnqJGFx9FUpSSORup+gkQdU8v1EgtHqSWif/kcaN9VQa2BUmjB/31jgww==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(7416002)(5660300002)(44832011)(8936002)(47076005)(36860700001)(83380400001)(36756003)(2906002)(16526019)(186003)(2616005)(356005)(336012)(82740400003)(81166007)(426003)(86362001)(82310400005)(8676002)(40480700001)(26005)(1076003)(41300700001)(6666004)(316002)(6916009)(4326008)(70586007)(70206006)(7696005)(478600001)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 20:24:54.4089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc937b06-58b2-4076-da8b-08db564b9c17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6788
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

The CCD temperature register is read in two places. These reads are done
using an AMD SMN access, and a number of parameters are needed for the
operation.

Move the SMN access and parameter gathering into a helper function in
order to simply the code flow. This also has a benefit of centralizing
the hardware register access in a single place in case fixes or special
decoding is required.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/hwmon/k10temp.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 6ea1fa62b7c1..06af1fe38af7 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -150,6 +150,18 @@ static void read_tempreg_nb_zen(struct pci_dev *pdev, u32 *regval)
 		*regval = 0;
 }
 
+static int read_ccd_temp_reg(struct k10temp_data *data, int ccd, u32 *regval)
+{
+	u16 node_id = amd_pci_dev_to_node_id(data->pdev);
+	u32 tmp;
+
+	if (amd_smn_read(node_id, ZEN_CCD_TEMP(data->ccd_offset, ccd), &tmp))
+		return -EINVAL;
+
+	*regval = tmp;
+	return 0;
+}
+
 static long get_raw_temp(struct k10temp_data *data)
 {
 	u32 regval;
@@ -214,9 +226,7 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
 				*val = 0;
 			break;
 		case 2 ... 13:		/* Tccd{1-12} */
-			if (amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
-					 ZEN_CCD_TEMP(data->ccd_offset, channel - 2),
-					 &regval))
+			if (read_ccd_temp_reg(data, channel - 2, &regval))
 				return -EINVAL;
 
 			*val = (regval & ZEN_CCD_TEMP_MASK) * 125 - 49000;
@@ -376,8 +386,7 @@ static void k10temp_get_ccd_support(struct pci_dev *pdev,
 	int i;
 
 	for (i = 0; i < limit; i++) {
-		if (amd_smn_read(amd_pci_dev_to_node_id(pdev),
-				 ZEN_CCD_TEMP(data->ccd_offset, i), &regval))
+		if (read_ccd_temp_reg(data, i, &regval))
 			continue;
 
 		if (regval & ZEN_CCD_TEMP_VALID)
-- 
2.34.1

