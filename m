Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F15E731D57
	for <lists+linux-edac@lfdr.de>; Thu, 15 Jun 2023 18:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbjFOQDw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 15 Jun 2023 12:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbjFOQDt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 15 Jun 2023 12:03:49 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C45B10F6;
        Thu, 15 Jun 2023 09:03:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/aCEWUfHbKbmFj0zH6Pusnpw247qDHRx/iLk6hS396CqoLv4XbGgS12uC1sWqyS1Rap51ml1sgrRrCyylt9gunIBZ+CbMzaIUS/+RwZOvYEfCGxf67/Z7eu7gWhjxsDIZ7oCLcKa9PG+GmE8IzNDwQQ4H3HdyKMenspqHc7WiBahfc86FJuorUpZ4KdcCeGE823d4qMW0ZtUpMI4nAYkYmPgFigqDHgdsL4BGYw0T2LUOw8iE/1z/g1nEIV66JMOYh7caVA9nIviVrab5ynos0EfxNprrBXfCfHcgF32eVw+V2G02kntbYWpXIeIHS8K2iIUacilzN4ccb56wdPLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wv09vh/3iS3GQHdwiIKsRLm5TCml32iKvra5Gp72h3I=;
 b=HXdc5zNVr+Ifi2wC/LlzXYFnO7gNXtMAXm6dEQ+Gu0z8F/nB/4RYLkbl+z4iPH6vRhy+sDGYsvhWQv9Q8AuKX3IhsVUVGNy6weOAZseoM1FaKhpeByuSvqPUW/6/RXIvezUKOWF0IFNhPb83y0sB09AvXFBq1TLgj96eogG7ZIi2A3m34BIfEtJWdTCY5E8t++RVscSqKAjX+EWu/kQfN07JCookJ3UZY7XCvqBadHS6GZxwKtfZgluW5SpbN/Kefyn110vwJZi+aWeaRRKz8+Onvvy4YYTWBOd+tLVPt3Lk8eLvU5ZNv0YWXyDEJDsnfG4i1Iko2UsC+zIqMNjGGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wv09vh/3iS3GQHdwiIKsRLm5TCml32iKvra5Gp72h3I=;
 b=VjgZkjUmaEpJx7u7h4VB2aSezS+pYHE1OHDrGJlWn3Mj1OvKljUpWv9lbvekBsRZj+qEzEIR/UG4S5pYPIbxglztbjROUDxrFc3LJZ8iY/V/36TBppwgV5SqtLKCY0EHMXKZxY5OA9NyOvbSm+tTw/cnssHwix1bWg+wbJp0CFE=
Received: from MW4PR03CA0268.namprd03.prod.outlook.com (2603:10b6:303:b4::33)
 by SA1PR12MB6774.namprd12.prod.outlook.com (2603:10b6:806:259::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 16:03:44 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:303:b4:cafe::41) by MW4PR03CA0268.outlook.office365.com
 (2603:10b6:303:b4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27 via Frontend
 Transport; Thu, 15 Jun 2023 16:03:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.27 via Frontend Transport; Thu, 15 Jun 2023 16:03:44 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 11:03:43 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <markgross@kernel.org>,
        <hdegoede@redhat.com>, <Shyam-sundar.S-k@amd.com>,
        <linux-edac@vger.kernel.org>, <clemens@ladisch.de>,
        <jdelvare@suse.com>, <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <mario.limonciello@amd.com>,
        <babu.moger@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 3/6] hwmon: (k10temp) Check return value of amd_smn_read()
Date:   Thu, 15 Jun 2023 11:03:25 -0500
Message-ID: <20230615160328.419610-4-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|SA1PR12MB6774:EE_
X-MS-Office365-Filtering-Correlation-Id: c14fe072-7f39-4e5d-d9f7-08db6dba1897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FVo/Z3uo5/jMUUC3oyvWuFvujJ2hh3ljp0e/iU2Ck0/Cn+6M9baQnFj087DXdnfNsoeabbIy33ngLMaZgfWS9K+nyuAranbKjZsIcWIpbDYne+2lSSxTaTI7+5Z2+hM+82Wi7HV6KHwO15YeDhO8aZbymc3Gy6nRT83+UfiQ3N0glDBEFiUdlI4Vpq2GgxNRQGt+r69J/AX7w+pAarbbHJCUKSgdigSiqS8ZSX4P1CFtLEu01lKpKyauD9LiFhfBb2agHDz0kj0K9ddmZEAfHB8tsb/WDYGrn6rkjaPQIVmxUdlUK0six1/EoCAhwO3Z6WiwHdyi5soyisoqmIRRkAp5IT/7OIcnZn6oyuqeh1UtyJt1B5FbbFRnjHHtZ82KGTrvcLfUk+YbWFnSehqrxbUC6tvI8/IF+uPmHSuVDNIcXJnHq0PitjDRj0ItoW3BC6wZ7eG4tMiqcxCNkW1AYGrhnkOiERwNMG9X6lyb+l/B2/6iGHe6a3+yEYqoFZr0pKyFUEuHWu172MbTKwd3bStFg5V7Mh4i2Pk2Rl/7Unkd8tZO/2WjBd4Z1+pba79YNHGqWjlsn+tK3je8rmMUu7/BU++rY9h871E/Yl9Pp5lYYQQw4q804PjXD5AcsyeFFSU2V512rSiOKmUPlCyqVnznmQoYGWEYWyIvR1p9X/Jox5Ew9da2VxkIvBnD4zcs9XoUf0kSrHUV3DFHKWICUKhQV1NZ/3SatU9sh5K8XSiNjh7RuiFHf6MFwCmGnMV3zbOKhS+6LVSnh4s5m2xNaQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199021)(46966006)(40470700004)(36840700001)(186003)(82310400005)(40480700001)(40460700003)(966005)(7696005)(6666004)(478600001)(16526019)(2616005)(26005)(1076003)(8676002)(41300700001)(8936002)(70586007)(316002)(7416002)(44832011)(5660300002)(36756003)(4326008)(70206006)(54906003)(82740400003)(81166007)(356005)(6916009)(47076005)(86362001)(2906002)(83380400001)(426003)(36860700001)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 16:03:44.5444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c14fe072-7f39-4e5d-d9f7-08db6dba1897
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6774
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
	This function does have return codes, so return the error code
	from the failed register read. Continued operation is not
	necessary, since there is no valid data from the register.
	Furthermore, if the register value was set to 0, then the
	following operation would underflow.

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
Link:
https://lore.kernel.org/r/20230516202430.4157216-4-yazen.ghannam@amd.com

v1->v2:
* Address comments from Guenter.

 drivers/hwmon/k10temp.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 7b177b9fbb09..70f7b77e6ece 100644
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
@@ -197,6 +198,7 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
 			     long *val)
 {
 	struct k10temp_data *data = dev_get_drvdata(dev);
+	int ret = -EOPNOTSUPP;
 	u32 regval;
 
 	switch (attr) {
@@ -213,13 +215,17 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
 				*val = 0;
 			break;
 		case 2 ... 13:		/* Tccd{1-12} */
-			amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
-				     ZEN_CCD_TEMP(data->ccd_offset, channel - 2),
-						  &regval);
+			ret = amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
+					   ZEN_CCD_TEMP(data->ccd_offset, channel - 2),
+					   &regval);
+
+			if (ret)
+				return ret;
+
 			*val = (regval & ZEN_CCD_TEMP_MASK) * 125 - 49000;
 			break;
 		default:
-			return -EOPNOTSUPP;
+			return ret;
 		}
 		break;
 	case hwmon_temp_max:
@@ -235,7 +241,7 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
 			- ((regval >> 24) & 0xf)) * 500 + 52000;
 		break;
 	default:
-		return -EOPNOTSUPP;
+		return ret;
 	}
 	return 0;
 }
@@ -373,8 +379,20 @@ static void k10temp_get_ccd_support(struct pci_dev *pdev,
 	int i;
 
 	for (i = 0; i < limit; i++) {
-		amd_smn_read(amd_pci_dev_to_node_id(pdev),
-			     ZEN_CCD_TEMP(data->ccd_offset, i), &regval);
+		/*
+		 * Ignore inaccessible CCDs.
+		 *
+		 * Some systems will return a register value of 0, and the TEMP_VALID
+		 * bit check below will naturally fail.
+		 *
+		 * Other systems will return a PCI_ERROR_RESPONSE (0xFFFFFFFF) for
+		 * the register value. And this will incorrectly pass the TEMP_VALID
+		 * bit check.
+		 */
+		if (amd_smn_read(amd_pci_dev_to_node_id(pdev),
+				 ZEN_CCD_TEMP(data->ccd_offset, i), &regval))
+			continue;
+
 		if (regval & ZEN_CCD_TEMP_VALID)
 			data->show_temp |= BIT(TCCD_BIT(i));
 	}
-- 
2.34.1

