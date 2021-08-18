Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60CBE3EFDB7
	for <lists+linux-edac@lfdr.de>; Wed, 18 Aug 2021 09:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238925AbhHRHYM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 18 Aug 2021 03:24:12 -0400
Received: from mail-bn8nam12on2049.outbound.protection.outlook.com ([40.107.237.49]:9503
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238952AbhHRHYM (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 18 Aug 2021 03:24:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzuzK+b1beDOJZ4b+xSbuhGvRnSyBBXt/rTCZW7C3wRoc+N5Tc7NHbM655/ObbDD7IZBqzaV31bxEhKYttDT6FanY+hIaIIMVjyLC8HAPXIGfhueYGqVr/CpcDyvsfuzS2CAK85005X24nkynPYhZLSFZsi5fQztTRBhkqlP9oCOiMStvxUiCVG/Qt53xtlrvmTT8OB7bLxuLsCvTLtySLtxumD0gBAHWBsai0NqSsGhb7zrYNba9jc5Loe0vLJCQQv8I2YNXf6by4GLPUMYw2K134xcJ+sr+8u7CuLhMBKaKfuIh7KGVBkw+kolllLWtuUugn46leFJHpn5MxFkOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYUn4OFEh0hmqUOP5Z+/PjeIRP8d0U4bS7ps+mJb1BM=;
 b=OvFgZB5ktH2kGCg3bEYukF1tlZsDMwAkZ2cW5bdVc1mZAWmmRU7+ClC84fSKM1nlRbA4Uc1yrsN/DwNDpiNQIWYCaxKb0uYw83cVvo9M5tqVVivDm+b0DdszICg1NIfEs+YO7OplwHPEDh5f4IUOt59VoYO4HJ8Y1mwsgHNH8h5W35ePNTtls8aHGXAdbcFbKKWQu+fAhA2HgxRIyJL5Q151MXgj4rGXdgeEobTPlTa8Bq0vyA3XoBS8R7boTUnX04emuDrbG3r0+Hbe90TUuE+ZT0rPLoadMYhbax7ZO+AkXQ9nWfjSX4LJQXDSu1cpeQH8yXwbkCr+ZwjqHsqooA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYUn4OFEh0hmqUOP5Z+/PjeIRP8d0U4bS7ps+mJb1BM=;
 b=jnU3wZRCjhdumcJcldGCxoNKVSh0s6J+eU09mcVHYmVH4U/2KfgTxHbBU2UO2GV7AqzhS9oQQ+R4Q8drRe2cK/wifM2lLex9CojuuRKdjLu44wchwuaifmW8nbv6aKAUyJUjUFpR/Sz2GZtTccRGQmbymMibXLufqBRK2LU7HtY=
Received: from BN1PR10CA0018.namprd10.prod.outlook.com (2603:10b6:408:e0::23)
 by PH0PR02MB8357.namprd02.prod.outlook.com (2603:10b6:510:100::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Wed, 18 Aug
 2021 07:23:36 +0000
Received: from BN1NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::ea) by BN1PR10CA0018.outlook.office365.com
 (2603:10b6:408:e0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Wed, 18 Aug 2021 07:23:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT028.mail.protection.outlook.com (10.13.2.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Wed, 18 Aug 2021 07:23:36 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 18 Aug 2021 00:23:23 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 18 Aug 2021 00:23:23 -0700
Envelope-to: git@xilinx.com,
 linux-edac@vger.kernel.org,
 bp@alien8.de,
 mchehab@kernel.org
Received: from [10.140.6.59] (port=53052 helo=xhdshubhraj40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1mGFv0-0001xW-Db; Wed, 18 Aug 2021 00:23:22 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-edac@vger.kernel.org>
CC:     <bp@alien8.de>, <mchehab@kernel.org>, <michal.simek@xilinx.com>,
        <git@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 2/2] edac: synopsys: Fix the issue in reporting of the error count
Date:   Wed, 18 Aug 2021 12:53:15 +0530
Message-ID: <20210818072315.15149-2-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210818072315.15149-1-shubhrajyoti.datta@xilinx.com>
References: <20210818072315.15149-1-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c923733-86c9-47da-f8ef-08d9621917e0
X-MS-TrafficTypeDiagnostic: PH0PR02MB8357:
X-Microsoft-Antispam-PRVS: <PH0PR02MB8357BDC54C2A1743D888E2B3AAFF9@PH0PR02MB8357.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W8KA9iprfr+wZv4nYX027jfMd3FkX94zvW3lnDZ9S44dZ5nB4BSTbUL9sGsqPWpwHhV8da84tXCC49zldwFgmpf7BFKsjRmYWTSsKPPWVbmkpdeyi+rbC88eu5kfIKGjoOAMaQWPoVK6CknivKJIJFAvnZJYGAwn/FK0PRikrczQJm38rn1dHKe/9Ue9lTL2hZ3WLnuA9FDF0R6KQUoFEs3YeMWwx++j7UkftZPpVLLvexFwHxyEbM51s6kkWj5TwOQQ8G01P7UYItrwW51bp+5pV49qstPQizfhbynFGYyQFH18H2R9IduvOBYiRIt/KNxf1lAymOO1f2KuO7uShr9uOkFxWT7sOieaFYGv+EugYYHOvlGZsZeftppkDpXcr4npDOQPUxD42jYQPF5/iSGYqm1FuPZwRvAMJs4MOmVgOYt6HrPa7SOymTsDcipaAGm9uxE7+oVTAC4/axozUlzosMMtiuWvk+cg2/BZaz/zwxqOoacneOS0bVemAuHmawl3T8R/f2Z2ZjPTaw89A8Q00abKjmQbk6TTDt9KfJVLYcWLNRxiXAlXb3PL1D3eh4qMcoWRZBLSNOV/ieCPqBozVCIlt3syguA1mgxZSyd7psUOX9wuFtS1V0+CYBnjguaFxoyJETkEEyr5dj5vosaAyG2nzgCAajwOMeP2xw7p+TigE9/guLQ9Y5+M+ov6Oc0Ox7+GtFsVbLDTN6dpdYUb+PMczMfrcllbb75iOQA=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39850400004)(376002)(46966006)(36840700001)(70586007)(1076003)(107886003)(9786002)(36860700001)(336012)(70206006)(44832011)(8676002)(6916009)(26005)(356005)(426003)(4326008)(7696005)(54906003)(7636003)(2616005)(82310400003)(47076005)(186003)(6666004)(83380400001)(36906005)(2906002)(36756003)(5660300002)(82740400003)(8936002)(316002)(478600001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 07:23:36.2640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c923733-86c9-47da-f8ef-08d9621917e0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT028.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8357
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Currently we are reading the error count from status register which
is not correct, this patch fixes the issue by reading the count from
error count register(ERRCNT). Currently we are not reporting the
errors cumulatively.
Also send the cumulative errors to the edac_mc_handle_error.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/edac/synopsys_edac.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 7d08627e738b..38c03bdc2393 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -163,6 +163,11 @@
 #define ECC_STAT_CECNT_SHIFT		8
 #define ECC_STAT_BITNUM_MASK		0x7F
 
+/* ECC error count register definitions */
+#define ECC_ERRCNT_UECNT_MASK		0xFFFF0000
+#define ECC_ERRCNT_UECNT_SHIFT		16
+#define ECC_ERRCNT_CECNT_MASK		0xFFFF
+
 /* DDR QOS Interrupt register definitions */
 #define DDR_QOS_IRQ_STAT_OFST		0x20200
 #define DDR_QOSUE_MASK			0x4
@@ -418,14 +423,16 @@ static int zynqmp_get_error_info(struct synps_edac_priv *priv)
 	base = priv->baseaddr;
 	p = &priv->stat;
 
+	regval = readl(base + ECC_ERRCNT_OFST);
+	p->ce_cnt = regval & ECC_ERRCNT_CECNT_MASK;
+	p->ue_cnt = (regval & ECC_ERRCNT_UECNT_MASK) >> ECC_ERRCNT_UECNT_SHIFT;
+	if (!p->ce_cnt)
+		goto ue_err;
+
 	regval = readl(base + ECC_STAT_OFST);
 	if (!regval)
 		return 1;
 
-	p->ce_cnt = (regval & ECC_STAT_CECNT_MASK) >> ECC_STAT_CECNT_SHIFT;
-	p->ue_cnt = (regval & ECC_STAT_UECNT_MASK) >> ECC_STAT_UECNT_SHIFT;
-	if (!p->ce_cnt)
-		goto ue_err;
 
 	p->ceinfo.bitpos = (regval & ECC_STAT_BITNUM_MASK);
 
@@ -491,7 +498,7 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 		}
 
 		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
-				     p->ce_cnt, 0, 0, 0, 0, 0, -1,
+				     priv->ce_cnt, 0, 0, 0, 0, 0, -1,
 				     priv->message, "");
 	}
 
@@ -509,7 +516,7 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 		}
 
 		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
-				     p->ue_cnt, 0, 0, 0, 0, 0, -1,
+				     priv->ue_cnt, 0, 0, 0, 0, 0, -1,
 				     priv->message, "");
 	}
 
-- 
2.17.1

