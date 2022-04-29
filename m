Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34965148DF
	for <lists+linux-edac@lfdr.de>; Fri, 29 Apr 2022 14:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357879AbiD2MMs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 29 Apr 2022 08:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbiD2MMs (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 29 Apr 2022 08:12:48 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CA6A76DD
        for <linux-edac@vger.kernel.org>; Fri, 29 Apr 2022 05:09:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eR6o5Mkq599+zkGWv2ZIVotG5pFGE4G1kx2k0ZznkQ/ES+cj2adxSg8l6lJe8oxljPWdPP/W7lA8voL6buhJSFB9zfV7uZNWX5pDl9HQHx7UPVjQP/Qk1MnNCB2KYd9g32MxGbL2PQySX9cVi49YkuYFgew3qbSzpHS8ojTQMgo7v007Qeg2+IpZPxC8g+62D8OmF7jmieR76eXjyr66mecafMXPbynDmLlzKqkPk/NYQE/rUfA/YOvSTkHBkYXwfVNYNhE8HKIUljt0bXa2tVZaCsWzeXFqZHUcD+le3Msdh6wvqzA6i99dGheFNfZVKX2SBqIQpqZiPW//JrZmww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmIIiynTOrOGK3EWUtsGaJP6u+R4OFIGRfEKScRkvFM=;
 b=mB40SUFJCtxbDlaKzND+6HtHOxgoeWYz3DQzPwWTGcWnCzc9b0qkomDbZweCMO4+VToNIQObzSZzpRaG/cRMtfKu17Tgmj4C8XPZP7y36G5rao3wM1DFHHEUdJUVx8vM15SYHORmMHxNceMyeXgtQ+kExiR6WtUqzlzuESNjv8Gj4ZkLykbhRJem6dFK1cMiNhNs/EWrj9oHnJW8E3T/9n/E8fOpk6s9xikIlj8T8+fLFNG5Z2YB4GAXN2PGT0LXvHHKk8iNYJjjjlsz6sOBTFORm51KLrZUDyIpNvgwx573cazmorokvt2eRgMzKs/ZxeoO19v62qX/GTL5OFbxwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmIIiynTOrOGK3EWUtsGaJP6u+R4OFIGRfEKScRkvFM=;
 b=tDcoOnkdwtUX+yWuKrYrY9vbXRlWHKrdH7PvqQKK4UNnE/8GPITwS43Qz8E/BtEHXRGgjWFrZlyHYnr5UyL3bJ57CPPuOuscw3c05FkPOiP3pzX/o4eWFqr8xTXyAZID62xHER9xQ6KQtPDe3QrHyLPANt0/KUddmvVJ6ejBDHU=
Received: from SN7PR04CA0230.namprd04.prod.outlook.com (2603:10b6:806:127::25)
 by CH2PR02MB6232.namprd02.prod.outlook.com (2603:10b6:610:d::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 29 Apr
 2022 12:09:21 +0000
Received: from SN1NAM02FT0060.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:127:cafe::58) by SN7PR04CA0230.outlook.office365.com
 (2603:10b6:806:127::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Fri, 29 Apr 2022 12:09:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0060.mail.protection.outlook.com (10.97.4.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 12:09:21 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 29 Apr 2022 05:09:07 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 29 Apr 2022 05:09:07 -0700
Envelope-to: git@xilinx.com,
 linux-edac@vger.kernel.org,
 bp@alien8.de,
 mchehab@kernel.org,
 tony.luck@intel.com,
 james.morse@arm.com
Received: from [10.140.6.39] (port=57356 helo=xhdsgoud40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1nkPQp-000AOM-A7; Fri, 29 Apr 2022 05:09:07 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-edac@vger.kernel.org>
CC:     <bp@alien8.de>, <mchehab@kernel.org>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <michals@xilinx.com>, <git@xilinx.com>,
        "Shubhrajyoti Datta" <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH] EDAC/synopsys: Fix coding style issues
Date:   Fri, 29 Apr 2022 17:39:03 +0530
Message-ID: <20220429120903.3735206-1-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56762722-0fe0-4348-9b19-08da29d917f2
X-MS-TrafficTypeDiagnostic: CH2PR02MB6232:EE_
X-Microsoft-Antispam-PRVS: <CH2PR02MB623223E5AAFB2CD4F9ACBF01AAFC9@CH2PR02MB6232.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rmSEQ0Jb3pSDAqMyl6eLGeiFyDs8mzrLJw9i1wz1o/tSo2bozbzmK4Uk4rZW1zf8RjUD7sUGhUNd1i+ql9rbrf94Vf2fBWXrNxrgsRKa0reSQ+4+3GC+h/5hqr7MaWmXtV3r8OByOySWdx592FoPkRMw2sfENeFCqS8ryyIDU09bUG4VJBFdeW1kY5ExiBE3zg3Daf99wol1+exnCbMNXKYqeBOIqCqZ9aw3sXJwzv3XEbWYOCcr+c95ANYrcUpDFuWXm6OxwbAz4Yp57LgWMBf3sio1NcTIrk+zV+YSP+iteGQqyqkCfVRTeB3b3x9ZbtiguXp4NKCEonm8Ktw73+UQz2y2UTOzC6ocmgDedGDwIYL5ERQ0DzYd5MCGsf7Se26XK1hFqo6op4rns6d81Q+soYcJ8UX1L5kbPy18Vt9AJ7178ps1AUE1gO2m465nsOZQAd7Pjw8KrRqgFlzhZBwCE7kwSQRZ3nT/IFxP8IflS9ogk0bFUgY6FdGWTpncyjqetpX8/DSClur0xg8OAe9rlkWGV87/f8Fy0BjZvc8MMiMTjG0ORsv3ln/XaJ7B5x1+P83zPaCFHnXUhzczC8VL2fyyxc8UZfOCm01b/OqGUJYv7b0ageq2xivBON/xaYeaoHMiMnqOt/g8Fis4tAQ8G0dbujmasocePJbHjB3NL9m/MsyN/JKOKanEkaxrzhNkI35kpJ4tVUReciv1CA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(47076005)(1076003)(2616005)(356005)(107886003)(2906002)(186003)(426003)(336012)(7636003)(6666004)(26005)(7696005)(9786002)(36860700001)(8936002)(44832011)(40460700003)(83380400001)(8676002)(508600001)(4326008)(5660300002)(70586007)(70206006)(82310400005)(316002)(36756003)(6916009)(54906003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 12:09:21.1982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56762722-0fe0-4348-9b19-08da29d917f2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0060.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6232
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Most of these stuff are reported by checkpatch.
The fixes are:
    - Additional ()
    - Newlines
    - alignment

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/edac/synopsys_edac.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index f7d37c282819..5099a270d837 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -523,7 +523,6 @@ static void enable_intr(struct synps_edac_priv *priv)
 	else
 		writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
 		       priv->baseaddr + DDR_QOS_IRQ_EN_OFST);
-
 }
 
 static void disable_intr(struct synps_edac_priv *priv)
@@ -692,7 +691,7 @@ static bool zynq_get_ecc_state(void __iomem *base)
 		return false;
 
 	ecctype = readl(base + SCRUB_OFST) & SCRUB_MODE_MASK;
-	if ((ecctype == SCRUB_MODE_SECDED) && (dt == DEV_X2))
+	if (ecctype == SCRUB_MODE_SECDED && dt == DEV_X2)
 		return true;
 
 	return false;
@@ -716,8 +715,8 @@ static bool zynqmp_get_ecc_state(void __iomem *base)
 		return false;
 
 	ecctype = readl(base + ECC_CFG0_OFST) & SCRUB_MODE_MASK;
-	if ((ecctype == SCRUB_MODE_SECDED) &&
-	    ((dt == DEV_X2) || (dt == DEV_X4) || (dt == DEV_X8)))
+	if (ecctype == SCRUB_MODE_SECDED &&
+	    (dt == DEV_X2 || dt == DEV_X4 || dt == DEV_X8))
 		return true;
 
 	return false;
@@ -919,7 +918,6 @@ static const struct synps_platform_data synopsys_edac_def = {
 			  ),
 };
 
-
 static const struct of_device_id synps_edac_match[] = {
 	{
 		.compatible = "xlnx,zynq-ddrc-a05",
@@ -1245,7 +1243,6 @@ static void setup_column_address_map(struct synps_edac_priv *priv, u32 *addrmap)
 			priv->col_shift[index - width] = 0;
 		}
 	}
-
 }
 
 static void setup_bank_address_map(struct synps_edac_priv *priv, u32 *addrmap)
@@ -1257,7 +1254,6 @@ static void setup_bank_address_map(struct synps_edac_priv *priv, u32 *addrmap)
 				BANK_MAX_VAL_MASK) == BANK_MAX_VAL_MASK) ? 0 :
 				(((addrmap[1] >> 16) & BANK_MAX_VAL_MASK) +
 				 BANK_B2_BASE);
-
 }
 
 static void setup_bg_address_map(struct synps_edac_priv *priv, u32 *addrmap)
@@ -1267,7 +1263,6 @@ static void setup_bg_address_map(struct synps_edac_priv *priv, u32 *addrmap)
 	priv->bankgrp_shift[1] = (((addrmap[8] >> 8) & BANKGRP_MAX_VAL_MASK) ==
 				BANKGRP_MAX_VAL_MASK) ? 0 : (((addrmap[8] >> 8)
 				& BANKGRP_MAX_VAL_MASK) + BANKGRP_B1_BASE);
-
 }
 
 static void setup_rank_address_map(struct synps_edac_priv *priv, u32 *addrmap)
@@ -1381,7 +1376,7 @@ static int mc_probe(struct platform_device *pdev)
 		rc = edac_create_sysfs_attributes(mci);
 		if (rc) {
 			edac_printk(KERN_ERR, EDAC_MC,
-					"Failed to create sysfs entries\n");
+				    "Failed to create sysfs entries\n");
 			goto free_edac_mc;
 		}
 	}
-- 
2.25.1

