Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFE47058C1
	for <lists+linux-edac@lfdr.de>; Tue, 16 May 2023 22:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjEPUZI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 May 2023 16:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjEPUYv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 16 May 2023 16:24:51 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF99397;
        Tue, 16 May 2023 13:24:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZxzENCwMuGmXL7Irdx0TiZS9J7x96Pdrf+DrcEA3XMdxH5u5NwuLWz1TkR5gDZf9ywbG9JJb4g+a6xc/aB8rZO74hQpU3UCdYHIdmzWG9IYS09F/LPCILXF96o0PCsz9CIt9w3CeB5CXnwFioesGSbpIum3uTa3dwtL5nAd1RjmV/3s2/2bKaVVu2dHWFE+3diYSdgarMojqm9lVSMWTtInOQVtAcKZc2LFtPAdLzR9i521BV6FSDbuVILey6R9J8EAToYlfGJD1xzcZHV148JNcww+LiZItIqjcMRZsjht/XvWQYzdSs7G/K2tqyxT/YuLlv+dZIPt82aUJRfw2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J03kh9KQTcEyJIqijy8cUhLGif8AiK3cLVTK3VIx5t0=;
 b=Ch+uOlSX0YKRmZje93uKhy6ZY5zsi/oWn68Gi7sAIfnK34UKur6olOmqhAaB5xooo/RQT+U70iJ56P1HOqUSKsR36ADGmcP5IopdluczNQ2C5t+VMJVfS1pTAAHiqL9+1z/LfaAiiiYSJ27aGyH0oa3EZhdMQM6n+ABVn2cgEHm0p4bETeHBOiCUwp8ujIxxIN9w9lgwD6CMn2M2AfGCeS/91aMijNSFaEtFkOJbJYQH5lQn/Ve7hHbwzoAxQc5nWjQ2KZn3Jecpp/LGszCndWpbbTahgtQSyBLyybocbYeSdmOvANMdTRXh1nqHWT+0e23oQLmDhgvSeagz58vWzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J03kh9KQTcEyJIqijy8cUhLGif8AiK3cLVTK3VIx5t0=;
 b=1u3lH8hNZzdWMrD21qkyZnq7z9LYcdbYojw1Jcm+G3/oEW5M+y/YjWTqQ7L/rjcdni72Tnzc+lnqpNoDUl7o7XelCv0cFRPK3O3xnkumt+E+69Kx7Y26rEHNu2pP1k5+8o1Sgq0XgnGVmXcAdB5dpsCFHQqHfrHW5zKPbg2xmqw=
Received: from BN7PR06CA0072.namprd06.prod.outlook.com (2603:10b6:408:34::49)
 by CH0PR12MB5059.namprd12.prod.outlook.com (2603:10b6:610:e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 20:24:48 +0000
Received: from BN8NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::a9) by BN7PR06CA0072.outlook.office365.com
 (2603:10b6:408:34::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33 via Frontend
 Transport; Tue, 16 May 2023 20:24:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT108.mail.protection.outlook.com (10.13.176.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.17 via Frontend Transport; Tue, 16 May 2023 20:24:48 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 15:24:46 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <markgross@kernel.org>,
        <hdegoede@redhat.com>, <Shyam-sundar.S-k@amd.com>,
        <linux-edac@vger.kernel.org>, <clemens@ladisch.de>,
        <jdelvare@suse.com>, <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <mario.limonciello@amd.com>,
        <babu.moger@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 3/6] hwmon: (k10temp) Check return value of amd_smn_read()
Date:   Tue, 16 May 2023 15:24:27 -0500
Message-ID: <20230516202430.4157216-4-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT108:EE_|CH0PR12MB5059:EE_
X-MS-Office365-Filtering-Correlation-Id: 89feed6a-01aa-481d-b4f0-08db564b986a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8yxSqmumN/gNECtDNfn1lUY/AcHyud4jT6FH8O9AqMao4ivs3hUwcYad/23JMrvuBMApUx1ywbO419AbctlWnq9WqQGm3FWsD5pJd9YFwCsM5QT4tyP/0dsmo4fboeF89Cu61u2rfzig46hjoC58HzktlkrZshhHUYHzAf4UkpYq5vRV/CTnICVWGtmc8hxroSeGMSe+AZlPeIYizZGrLu3TM2IhBufEBHqPJ6k3De5Rcg5uTBraqldK4YbTAJ+MvND3EJQstC0M4r6PxyK96oLDw1o4bS7xrXOF6HR/C3tSJqt3o4QmEndLo+4VlxAOya0EZ0IEcfN+liEddJ9FYDbYCTZSeAs6BfEI/lNvvjSwuLdSXBOinsspvbruD1yNtizI53TtXlaK+OS6nmbAq9CUgHvd5KUpU8LqAHxV85mhuOS2igevnkDA1DRDx7DG+HaamFLkpkAB6LozYQh0eGljiBciE6RGAfEr4PCn/QrWKorZTaoCECnymJlxTC8mQZlpY7zoraX1tbxw1iyKm0bv9ZHUzeEXR75/XVU55bLN0JauWUIN9mSh8Cbn2xShC+BjE5Cy3gmTdHINgTp5LFLlChVE6hZ7JPBxe7lHjJBsx4tmc8+OnUSAsBfNSzGo6UfKk7/Di+w9/fIIYfMQB+rr6LflI31HkSP9Pn4FwSOYRAU0hAAm3XK8V6bwKjHwWpXu3MCpyQOE2DD+I9tfdaW6BNuiFzFxM8J9X7KaybeXIz5LcFkFmCX/An0XGFMGtHR8ZnfkvEdeDj8Bvv1GGQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199021)(46966006)(40470700004)(36840700001)(44832011)(2906002)(36860700001)(16526019)(83380400001)(7416002)(54906003)(8936002)(1076003)(26005)(186003)(47076005)(478600001)(2616005)(336012)(426003)(8676002)(5660300002)(316002)(40460700003)(81166007)(82310400005)(86362001)(356005)(41300700001)(40480700001)(82740400003)(36756003)(70206006)(6666004)(70586007)(6916009)(4326008)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 20:24:48.2410
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89feed6a-01aa-481d-b4f0-08db564b986a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5059
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

Check the return value of amd_smn_read() before saving a value. This
ensures invalid values aren't saved or used.

There are three cases here with slightly different behavior.

1) read_tempreg_nb_zen():
	This is a function pointer which does not include a return code.
	In this case, set the register value to 0 on failure. This
	enforces Read-as-Zero behavior.

2) k10temp_read_temp():
	This function does have return codes, so return -EINVAL on a
	failed register read. Continued operation is not necessary,
	since there is no valid data from the register. Furthermore, if
	the register value was set to 0, then the following operation
	would underflow.

3) k10temp_get_ccd_support():
	This function reads the same register from multiple CCD
	instances in a loop. And a bitmask is formed if a specific bit
	is set in each register instance. The loop should continue on a
	failed register read, skipping the bit check.

Furthermore, the __must_check attribute will be added to amd_smn_read().
Therefore, this change is required to avoid compile-time warnings.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/hwmon/k10temp.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 7b177b9fbb09..6ea1fa62b7c1 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -145,8 +145,9 @@ static void read_tempreg_nb_f15(struct pci_dev *pdev, u32 *regval)
 
 static void read_tempreg_nb_zen(struct pci_dev *pdev, u32 *regval)
 {
-	amd_smn_read(amd_pci_dev_to_node_id(pdev),
-		     ZEN_REPORTED_TEMP_CTRL_BASE, regval);
+	if (amd_smn_read(amd_pci_dev_to_node_id(pdev),
+			 ZEN_REPORTED_TEMP_CTRL_BASE, regval))
+		*regval = 0;
 }
 
 static long get_raw_temp(struct k10temp_data *data)
@@ -213,9 +214,11 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
 				*val = 0;
 			break;
 		case 2 ... 13:		/* Tccd{1-12} */
-			amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
-				     ZEN_CCD_TEMP(data->ccd_offset, channel - 2),
-						  &regval);
+			if (amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
+					 ZEN_CCD_TEMP(data->ccd_offset, channel - 2),
+					 &regval))
+				return -EINVAL;
+
 			*val = (regval & ZEN_CCD_TEMP_MASK) * 125 - 49000;
 			break;
 		default:
@@ -373,8 +376,10 @@ static void k10temp_get_ccd_support(struct pci_dev *pdev,
 	int i;
 
 	for (i = 0; i < limit; i++) {
-		amd_smn_read(amd_pci_dev_to_node_id(pdev),
-			     ZEN_CCD_TEMP(data->ccd_offset, i), &regval);
+		if (amd_smn_read(amd_pci_dev_to_node_id(pdev),
+				 ZEN_CCD_TEMP(data->ccd_offset, i), &regval))
+			continue;
+
 		if (regval & ZEN_CCD_TEMP_VALID)
 			data->show_temp |= BIT(TCCD_BIT(i));
 	}
-- 
2.34.1

