Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86AFA4DD7D6
	for <lists+linux-edac@lfdr.de>; Fri, 18 Mar 2022 11:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbiCRKUa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 18 Mar 2022 06:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234232AbiCRKU3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 18 Mar 2022 06:20:29 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608E01ED041
        for <linux-edac@vger.kernel.org>; Fri, 18 Mar 2022 03:19:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tf1A4yuj0SW76B55Xx7T8HnTvSEjFL2Uht/f4AWBvTfqWDWwjNEdkJIVn0KMa1Vf1qoOEARUTghghaZwslEYR902qfRkgJrb2l+LhJ6lZYcxncn432u5n1XGCn/G7GGYhQRHnNRjKcjoGYFsIgj0pxt63sZOpwt2Kg+f5MuncqfZu+KAqaE5WdgVRWDuumVYNznpD74R42cG7Z+tg2tyMWb+AQaFBDEPJx9YXHeb6xb9o7sO/iVtgU1wzc9Dri3etjS3tkvyu81YyxXALLD99J9zR2evdBLqFHOU6vgrKZ24KoU6C4F27SO6+gDAy/vY3H3rzWV2KZrwjkDM4Luajw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKPGL4d5O0SAwJUI/+cwV94/ZTVOrQLm1uETQ2YE7s0=;
 b=TBdBRaiPkuZcmkmWmEvBpo3wOjA6nif59kXoCUdAXRtzBbCW2f/MighmSR5s/mV5Dc8yN7yryE2paBjKUJPLPwN/xK/m88vlHqLwHjVG7lJ2yN1CHxY6AfLw+PVEvJOnTAJ773O8d7V/pWOl0zirRrc0Z8N2kJwQlqhhvDmWW4JBgDIFasm49L99Q/k/vogiIfuf43uJzFoW7VZ4VotAAttcEAjXQGlOvBBzgfEPSUAs6gJeqLcajzsNC5824hdxmbkYgYpMItS8BcAae+Ts3fkCQKCVIpnLuAPfg8Jdut956fTRpPcXQT+7dzcImyl40UDJ80hdeYl07qzeUNMCaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKPGL4d5O0SAwJUI/+cwV94/ZTVOrQLm1uETQ2YE7s0=;
 b=DRG/cJvgD+4XZZKp6Ae35GnIDEC6GzmNiSUnHE2z1+RvUUnZJlaiBXcGgI4PYXBeMV0HfuUwkFSJtlddWuvqO/IsD/FcBiT7V5SNT2udKBXtkQg35eCaNPZGfsUgzKNN4djiVaUD7rMWyEVF0W0pRuEGiY1dco5HR7oTGe8wEhA=
Received: from BN1PR13CA0002.namprd13.prod.outlook.com (2603:10b6:408:e2::7)
 by BL3PR02MB7972.namprd02.prod.outlook.com (2603:10b6:208:357::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 10:19:09 +0000
Received: from BN1NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::75) by BN1PR13CA0002.outlook.office365.com
 (2603:10b6:408:e2::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.8 via Frontend
 Transport; Fri, 18 Mar 2022 10:19:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT008.mail.protection.outlook.com (10.13.2.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Fri, 18 Mar 2022 10:19:09 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 18 Mar 2022 03:19:07 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 18 Mar 2022 03:19:07 -0700
Envelope-to: git@xilinx.com,
 linux-edac@vger.kernel.org,
 rric@kernel.org,
 bp@alien8.de,
 mchehab@kernel.org,
 tony.luck@intel.com
Received: from [10.140.6.59] (port=49908 helo=xhdshubhraj40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1nV9hL-000A77-7q; Fri, 18 Mar 2022 03:19:07 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-edac@vger.kernel.org>
CC:     <michal.simek@xilinx.com>, <rric@kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <git@xilinx.com>,
        "Shubhrajyoti Datta" <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v2] edac: synopsys: Fix the issue in reporting of the error count
Date:   Fri, 18 Mar 2022 15:49:00 +0530
Message-ID: <20220318101900.28872-1-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85bf931e-5c57-4175-8f52-08da08c8bd98
X-MS-TrafficTypeDiagnostic: BL3PR02MB7972:EE_
X-Microsoft-Antispam-PRVS: <BL3PR02MB7972BED6717D59993105628EAA139@BL3PR02MB7972.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UaR7OMZXq7dzYnpuXOHrxnnTN0+dcYMOgwFoh25rXXlZyZEzzkM8lvysId91B8mTN0Ni4lWRC+pMSqlWu/hZhhd0Vv+s6Q5HKZPo+nxI8MWmN0qrvFdoqkj4vSmR3A/WCqbIxIJ1ud2shv6N17vd0cBHkYRP4g54RkH/7uTW4BCdIZWq0qmNIBbDlACO485rmZB1Kdl+gHWYGTvoFbln37kMr6e5eUKvDJn7zFAgCztvgPpCLBx65kiwsjQ4DErewGc3HlEnWNP/0ZFrO+RO040T51eYH3M2Jlfs/ph6hM2e7gccZbmy06tKaYfZ6esy5/tC5e7a4FelXteo/+4Iy4UZG00r3a/W+qmDvYs8r4OaIrrTQGo7Sw/6txEiEGKGX0FT/8xd7j0l2TFngFuU4h8xLPsRRVZlC9afLxdSra8AGbPPjc05+nKCbkZk4LL3spoyd6rzdrj6jRV2eXmWGjWoeRSIBUxv3WdBVlod4u6Lsc8m15rrVPrprDCrDXJjez/nQ4VlgDnCCSW657bEE/sLRctB7aAv3ucAflcwV4Q91DEGxiNNex3EuDV5g7RLa/gmG12/EzT7hzIHmkta9ND7JbZBGolVwdgfg0adlroA1orz6MhdsB1pktyowIRYSqpEjuMnKJgR2wyasRy68mOAG4x9HYPcRQvxhdkJ1ALPPhG2ly7e7VrkMLHGwJHVnF8YNdLdO00XbJKAS0rapA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(186003)(26005)(8676002)(70206006)(70586007)(4326008)(356005)(47076005)(316002)(6916009)(82310400004)(40460700003)(508600001)(6666004)(7696005)(54906003)(5660300002)(336012)(36756003)(426003)(7636003)(83380400001)(36860700001)(8936002)(9786002)(44832011)(2906002)(1076003)(2616005)(107886003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 10:19:09.2313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85bf931e-5c57-4175-8f52-08da08c8bd98
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT008.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB7972
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Currently the error count from status register is being read which
is not correct. Fix the issue by reading the count from the
error count register(ERRCNT).

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
v2:
Remove the cumulative count change

 drivers/edac/synopsys_edac.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index f05ff02c0656..1a9a5b886903 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -164,6 +164,11 @@
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
@@ -423,14 +428,16 @@ static int zynqmp_get_error_info(struct synps_edac_priv *priv)
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
 
-- 
2.17.1

