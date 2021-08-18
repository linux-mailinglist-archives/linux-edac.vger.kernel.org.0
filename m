Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4CE3EFDB6
	for <lists+linux-edac@lfdr.de>; Wed, 18 Aug 2021 09:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238597AbhHRHX7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 18 Aug 2021 03:23:59 -0400
Received: from mail-bn8nam12on2085.outbound.protection.outlook.com ([40.107.237.85]:60640
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238080AbhHRHX7 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 18 Aug 2021 03:23:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9/zgNQXBhRQJl70ZbcP/uB86M2sq5mVo1tbryvWQhoxS3gWcDyIE/Hfz9x1u8DR4dQrANFoB6YrE+s0JeHD8OF5dGOvIzF22JEXnvqnzdM+wskqdFv3hVQVyjixcMgn4OQ64L/8NkbLMxKFSxd+sungNmqzSoAUaeKkl9gK6HhGAo4qadGEBc4umHfFCGnz0iDie2SDLe1M9273ztGYzhabRo06YjSSrfVyzUXWi+ZykZEUIKalYCZyem1T7ZQ13Iw9aJ2ROaMTqiMY49XVeqP0LNFpk5M0n8driRnOnMcn6FF92UDDuUY/nx6vzA4h0mApILcs+IoYx1aPN2mFew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DLkY+HIFdd1zaj02aLAf52MtQBue5ONmhbO/RvWC8k=;
 b=hPEMmTh7rcrsz+J6ZdrgiH8OCQqIjKcvcr6QGlH80zCA1k8+wneHzv2kV7UEbXrhUG/mZ7s3hDc/TJRNMqqzlN4UP2fxkJMaGErHsiSuEAvtChYGhWXBtKC5tIk4NgU9LNqgV+mkAW9igjIB7jwyOd1usvmzLd9GvuL+HO858h6asIC5qEJUvHIN9/hU0guTB5qj3Ll8ixRAG/QRZCY3pqtjN9tfUkX0nuHNxAU5rQNgM1pDFjBTBFFCSuohMzlQwfozISasa0VXVJekjR8KumRdVyZ6mXKY7iImsHibj/9ncTczZS5eYjvqDzy+ilr0lGt71+aQSKJynW3DhNdfBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DLkY+HIFdd1zaj02aLAf52MtQBue5ONmhbO/RvWC8k=;
 b=WnGlW0oi/Re3knJcmaPAR12Dv4EIYWYsxNQJy+64ssfj/+RnyROKqDB/U0sZklvvDcSR60TBJ5xGZmlzGe7fINfjYwPogK6EVdKWDbLLwPZQrjktbVOKB4omG09pDSyXXi6PGgW6/lXO0i3dzwUZ2kW8uRj2bOhXI6SC0GBrlh8=
Received: from BN9PR03CA0342.namprd03.prod.outlook.com (2603:10b6:408:f6::17)
 by DM5PR02MB2892.namprd02.prod.outlook.com (2603:10b6:3:113::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.18; Wed, 18 Aug
 2021 07:23:22 +0000
Received: from BN1NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::b) by BN9PR03CA0342.outlook.office365.com
 (2603:10b6:408:f6::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Wed, 18 Aug 2021 07:23:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT020.mail.protection.outlook.com (10.13.2.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Wed, 18 Aug 2021 07:23:22 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 18 Aug 2021 00:23:21 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 18 Aug 2021 00:23:21 -0700
Envelope-to: git@xilinx.com,
 linux-edac@vger.kernel.org,
 bp@alien8.de,
 mchehab@kernel.org
Received: from [10.140.6.59] (port=53052 helo=xhdshubhraj40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1mGFux-0001xW-RC; Wed, 18 Aug 2021 00:23:20 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-edac@vger.kernel.org>
CC:     <bp@alien8.de>, <mchehab@kernel.org>, <michal.simek@xilinx.com>,
        <git@xilinx.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 1/2] edac: synopsys: Fix the wrong value assignment for edac_mode
Date:   Wed, 18 Aug 2021 12:53:14 +0530
Message-ID: <20210818072315.15149-1-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85feafcd-a48d-4973-d246-08d962190fca
X-MS-TrafficTypeDiagnostic: DM5PR02MB2892:
X-Microsoft-Antispam-PRVS: <DM5PR02MB2892BD83F5A3B50A641E6F91AAFF9@DM5PR02MB2892.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nKS2cPOcwoIiNaS0SqPaNlaVjxEtkakzJXULDOBnJV7ILQhI5UqBA5cxBEFNj0aXJll8y3kV7nuY9iYO21NJkFl9zTH61Sga+1mY07CVv4BcV4Jxukq3aFprbGyIOpS/Y0rlqSpzdE84zzamKca0CaCBzZRMU6dLautd6PAC5kxQ1AxGRYPvIJmsQsexLytMWqeraU783d5Di2h/T8mHaY69wB28MmV+cxpOhZRenL92a75cvfDgsaXZ2NoQ34KNJELgOVcsoBc1NZsNnu+xGSnwkqUpO2a+fluIUZJrFnVdPtzxN8qMVcxqyOowOMgihU0tSPzWvO9+NlsLVBgeHVN21y9v4MSqpj9fmnt0FGFv19rt++JnAlhj5aY09K1/7KFLbzOXUcwRKKbDqvrviHWkum33bm/1tZHYB5VR4eRPH6qSb30fMechn0Anq/rPxJNiFtn3YQGSyWXeaq5KNUKP8OzN/P76ODH1H+v9LL/cXWE3AKqqXtrp8FnXz8WxVHIVc6usw8TP5nAB4/LG4EiJmS/le3HSuO2BSt0dFd1vSjBgvQ+Apz+QZ37vjY3a+Yjw8DIJ7Bb3O0YV8aHsblDq/OHB2SvtVXfWCvR71yyKEafTd7oKgYIBxyr2nOUskDs/vvEixY2BiljNjvvrcxJR3hAcP6gxyZ4JHI2tKPvmfwR/d62DcfKeHjfT2+7KtFH6eUm36raMsXvSSKheRugb8elJgeZLobhU8F8UhLE=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(46966006)(36840700001)(2616005)(4326008)(54906003)(70586007)(1076003)(2906002)(44832011)(36860700001)(8676002)(6916009)(316002)(336012)(356005)(426003)(7636003)(36756003)(82310400003)(8936002)(83380400001)(82740400003)(36906005)(478600001)(70206006)(7696005)(9786002)(186003)(47076005)(107886003)(26005)(4744005)(5660300002)(6666004)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 07:23:22.6961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85feafcd-a48d-4973-d246-08d962190fca
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT020.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2892
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>

This patch corrected the edac_mode value by using enum instead of bitmask.

Addresses-coverity: enumerated type mixed with another type.
Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/edac/synopsys_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 7e7146b22c16..7d08627e738b 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -782,7 +782,7 @@ static void init_csrows(struct mem_ctl_info *mci)
 
 		for (j = 0; j < csi->nr_channels; j++) {
 			dimm		= csi->channels[j]->dimm;
-			dimm->edac_mode	= EDAC_FLAG_SECDED;
+			dimm->edac_mode	= EDAC_SECDED;
 			dimm->mtype	= p_data->get_mtype(priv->baseaddr);
 			dimm->nr_pages	= (size >> PAGE_SHIFT) / csi->nr_channels;
 			dimm->grain	= SYNPS_EDAC_ERR_GRAIN;
-- 
2.17.1

