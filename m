Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBD3512AA3
	for <lists+linux-edac@lfdr.de>; Thu, 28 Apr 2022 06:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiD1EoO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Apr 2022 00:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242727AbiD1EoM (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 28 Apr 2022 00:44:12 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2050.outbound.protection.outlook.com [40.107.96.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5357072E23
        for <linux-edac@vger.kernel.org>; Wed, 27 Apr 2022 21:40:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2FYUyndeviXJKp6weNsi99m4e+9K25R3wQXzrQHojC7A36V9VOQGI652wp1Dbck/8HOxhzf+/Pvm14BIgwCBk+DtQCqTmgrEth5wXBGtH/JMCjZZC10XoyEJGeiK2LMr2l6LMbcCWOB0WgH8eLqz/LncMO3ijvrScJ5FH+DeKcd7gSJV0ubtPRuY1yIxMkyOwnm0TH49KZWj7+nnURfaAcyp4rWltfVN0avr2m54sbWnhbZ5CgUWMU0LCZdmdLUPE/uHbRjg0lX2CdWrJyShyJz2Q9+a8V1kOjVrSmlaltZscP8mwunqUq0A1qlzIkOndb0KiXc0AQWr37nS4VhBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BO3HHZakIqqSdouqyS5lNicSPr6LtC8aJLqF60RvKaM=;
 b=D+8Wa1EcRZV9RHn2i2aaWLcRjNUZxF1HrSr5CKWkoOmWWaCljGuwePTOhB6BQEJuwiEPu9PxUmdV9IaI61ZszNHxt640ISeoYOgM8MAAfLGa+JtFMsNRtRIDZ6rAhc1lG1gaSMe31MF3X6YYSY62SBhxSEC6W07wbNUFgOmsJKAf/LHoBXZ22j1L41uMqsJVmmxMN4FElRVu4eomNqPzaAnG8ivGL4dYMnw12WlSwvic0P1YB9m/XHgq15BpxBsFPKdchTBRTVr55wkycdbHjJawMvkAq2Wyh28DJAFp78EFBLJ1Il/g0UxZPwej4lHOtbbk+LobbrXlmH0+ruHaRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BO3HHZakIqqSdouqyS5lNicSPr6LtC8aJLqF60RvKaM=;
 b=VJcUeug4Mi8iW/100MqkjEqcQOnk+Ti8/N9zFgBnjuI0JP1iDE9E+1GAELpNAyPx6vn86s6EuZE5uxTz39axoFBD3vO+7s0IU+Ys7iUpkgRUZ5hnkk/FfvUGyO86VtkYD06y9wo2sSGv3XAmMs/IaGYhEtp4/WeTyJy+mhTsn/0=
Received: from SA0PR11CA0162.namprd11.prod.outlook.com (2603:10b6:806:1bb::17)
 by CO6PR02MB7508.namprd02.prod.outlook.com (2603:10b6:303:a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 28 Apr
 2022 04:40:56 +0000
Received: from SN1NAM02FT0014.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:1bb:cafe::22) by SA0PR11CA0162.outlook.office365.com
 (2603:10b6:806:1bb::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12 via Frontend
 Transport; Thu, 28 Apr 2022 04:40:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0014.mail.protection.outlook.com (10.97.4.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 04:40:55 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 27 Apr 2022 21:40:55 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 27 Apr 2022 21:40:55 -0700
Envelope-to: linux-edac@vger.kernel.org,
 bp@alien8.de,
 mchehab@kernel.org,
 tony.luck@intel.com,
 james.morse@arm.com
Received: from [10.140.6.39] (port=55782 helo=xhdsgoud40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1njvxX-000FPU-5w; Wed, 27 Apr 2022 21:40:55 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-edac@vger.kernel.org>
CC:     <bp@alien8.de>, <mchehab@kernel.org>, <tony.luck@intel.com>,
        <james.morse@arm.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH] EDAC/synopsys: Fix the spdx header
Date:   Thu, 28 Apr 2022 10:10:51 +0530
Message-ID: <20220428044051.2842687-1-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 517efc0e-ecbe-435f-16b2-08da28d148c6
X-MS-TrafficTypeDiagnostic: CO6PR02MB7508:EE_
X-Microsoft-Antispam-PRVS: <CO6PR02MB75088D7ACB0E36030B2C2AE4AAFD9@CO6PR02MB7508.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S6K23vN4l+Ecujg+cTPugF+CXHSusRJrY4Brjw7Yeg1M8vO15jSq9yTCnvIuWPMRPt9/tFGnhvPNyBpEmbTQQjSvHI7ljW6LehEIkqbglcgCnBEBG5NzYyNHvSV3dswqxs6cpGd62BT/z+GI7Y7o7DKKU8o9BP/Q6QxyHN8xKAZ3av9N9bOkDaaPIaExU/9rNtmXe5d6AQ9lPaEH6SIWUzrAepHS8SQAlHlV8P6Gv72STGQ1L5yFDr2cid0Z9O9NiQuzttpBTasfo2jJ83sP0zU2sifayQsdMwY79kMJlYgrmWrX7QxLH7UzZTAoyoV+Epv84mFd1wMVWmUb9Xr1hMF5zkRocUcHb9C0iqzLKXJHhLs9oseg0qS6kGhdLAjWozAW8y7VCUuVUzQBgVBirOXjFHyqLa8zEuMc65GMWaqL/LcoWzBtlFXbEr/T06z5QDJs64rwmDdqUTQ40PU/0WXl5mW3F7wkynRsU09KOrQxV5cRxK0/JpkdMDOanQNBNUytVit4jBXCV3LN4af6PXiMAyZOmw+edOh5la3HDWJqTfw+agoQyaJc28jLVzQuuDU+isyMBSzQecY9Rg/hqX9gMlyfX2D9muGUPox2GOh9J8DLSpBxNmMKGmvxZIHKRRHt0N6dtMu15IuFQXtHG1GnBoZjosUvFPSq5TgWYIpdQ7UOPkoDltiWsqR41TH0wDXd5uNBl4AfCgtjOf3lKRxlJELeabVrU5uW8hxoBHo=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(7696005)(6666004)(9786002)(26005)(40460700003)(6916009)(316002)(54906003)(8676002)(70586007)(2906002)(70206006)(4326008)(508600001)(5660300002)(36756003)(8936002)(44832011)(1076003)(2616005)(47076005)(336012)(426003)(186003)(7636003)(83380400001)(356005)(107886003)(36860700001)(82310400005)(102446001)(2004002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 04:40:55.9782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 517efc0e-ecbe-435f-16b2-08da28d148c6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0014.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7508
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Also fixes the below warning

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
+/*

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/edac/synopsys_edac.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index f05ff02c0656..fbe2aa1e334a 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -1,22 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Synopsys DDR ECC Driver
  * This driver is based on ppc4xx_edac.c drivers
  *
  * Copyright (C) 2012 - 2014 Xilinx, Inc.
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details
  */
 
 #include <linux/edac.h>
-- 
2.25.1

