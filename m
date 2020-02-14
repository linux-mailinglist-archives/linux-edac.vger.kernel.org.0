Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3341615D942
	for <lists+linux-edac@lfdr.de>; Fri, 14 Feb 2020 15:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbgBNOSg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 14 Feb 2020 09:18:36 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:22180 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726191AbgBNOSg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Fri, 14 Feb 2020 09:18:36 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01EEGxPc021164;
        Fri, 14 Feb 2020 06:18:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=pfpt0818;
 bh=O5jk9/hUKxBJkaEWkBXBm2JKB5kQRbWIQlxFpVVJwMY=;
 b=OJJUEnFD8LP1LhEnev8AT0VcF9XryxEwSP9lY/nbQznFQFLL05j9ieywYC+i/+CLbfP8
 rQjU7HbESY6mku9ahhvoQMZ+zniIvSNfjEO1XAAeA+epks2ai/Z5CR2MDdcJIExWvwoz
 /h42Zje5J845dzWWvMSRXpsvpBv3IA1wGi8oP+3/52xw1Bufp/JhffqqdzWS13o3vkR9
 zrnfUIxx2hxWcU0nhuEEgUUI+eOBKfT3ULoJpEXsEda3tTzUF8ehpUbmKNeJveUveHcH
 KEKuCr0myXZMyC5vvmn9iDtK4zPei+8+BNokEXJJAb40bvhTGC0HEk8ZPPuX6PaetX+f QA== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2y4be2myyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 14 Feb 2020 06:18:15 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 14 Feb
 2020 06:18:13 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 14 Feb 2020 06:18:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYWMmt46TTIAW/teui5KjnzBVd/v7q2GEwZTfnbXcjv3tLZpFdg8SDXm7cvhcCpeErWi0uf+T9mJ9pWGleFvWmHBV2Bn109eOrM00fGLWgNPCNAwVXj1cJLALaFSv1i7Sr4trb18Cz5sDHJZ3VjchTL9kdNOLXF+kt+kqxnmTX7sdkJJcX+JjeN+RIIvrd6rA7Qe+m0AQaqJqygzJYVVshwThs+vk5Y07Skz75ExYoK7CIauZGx8ZSwmKiP0USt2g6OAo3x+JWxsfRgszHyN4EWDG3ZiEni0WHHGrwefStqekdwgeBPeMWWhRc7R5TZs3LzKCC54uBLfJjkv7UD1xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5jk9/hUKxBJkaEWkBXBm2JKB5kQRbWIQlxFpVVJwMY=;
 b=HbGOBSumH9ERD1hTJxReSLp1Xk8qxfPd5ZWLXBqHDwu7bwfgC6BrYMpiKn8rIS2B+ic3RMyYF+GzxuXjqUD6YRBSiyhZ1imO7n4FX4ICytNA0ZVLzwFexcqz27LwsMfoY2VFzzJT0qE0D5g6Gav1/aTjyLDkknNpcPiYd/9i8gN5PvDfg5YUyGTKfA00tih9ckrUKzP10JsygTLwn2D+juREmKRXcmdMtB5LXZmfQlcWbFPNRMi8pAF8v++kbPphNorfhqSl6xgvv66JCVMr3fdcGcQdsAbaM1WcmooKG6I33bp0t8BZZrvGOQP0Ses/ylFU6IfbHUpveToMxEEnAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5jk9/hUKxBJkaEWkBXBm2JKB5kQRbWIQlxFpVVJwMY=;
 b=t5QDT3Hz92BWPE8ncdYajpVApxGZ0MREpEiU+9NfRXLkcM7AqJglaMRXBx5KD6FGCWWp5bg7raMhgrNu+PkOuLpT/ZZR2FY7R6StHc8x/2fGRIazf5tmlDUUIGzyMm7WHv2Sl82ovW6NOvtn4aa0Vn4r7uRsiudS7ZJhgnEB5wg=
Received: from DM6PR18MB3403.namprd18.prod.outlook.com (10.255.174.220) by
 DM6PR18MB2714.namprd18.prod.outlook.com (20.179.51.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.26; Fri, 14 Feb 2020 14:18:12 +0000
Received: from DM6PR18MB3403.namprd18.prod.outlook.com
 ([fe80::21f1:da96:3d0d:750d]) by DM6PR18MB3403.namprd18.prod.outlook.com
 ([fe80::21f1:da96:3d0d:750d%7]) with mapi id 15.20.2729.025; Fri, 14 Feb 2020
 14:18:12 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] EDAC/mc: Create new function edac_inc_csrow()
Date:   Fri, 14 Feb 2020 15:17:56 +0100
Message-ID: <20200214141757.8976-1-rrichter@marvell.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123090210.26933-6-rrichter@marvell.com>
References: <20200123090210.26933-6-rrichter@marvell.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR07CA0028.eurprd07.prod.outlook.com
 (2603:10a6:7:66::14) To DM6PR18MB3403.namprd18.prod.outlook.com
 (2603:10b6:5:1cc::28)
MIME-Version: 1.0
Received: from rric.localdomain (31.208.96.227) by HE1PR07CA0028.eurprd07.prod.outlook.com (2603:10a6:7:66::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.6 via Frontend Transport; Fri, 14 Feb 2020 14:18:10 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fd91830-57da-4011-eefa-08d7b158b927
X-MS-TrafficTypeDiagnostic: DM6PR18MB2714:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR18MB2714BBB99A447662046F905FD9150@DM6PR18MB2714.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 03137AC81E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(199004)(189003)(4326008)(6486002)(8936002)(81156014)(8676002)(81166006)(956004)(2616005)(36756003)(110136005)(54906003)(66946007)(6506007)(66476007)(66556008)(5660300002)(478600001)(2906002)(316002)(6512007)(186003)(52116002)(16526019)(1076003)(6666004)(86362001)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR18MB2714;H:DM6PR18MB3403.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u/QtMaQ7ERO6JNlexsefMj1Ii/oKykHGhGeu+FvyiaYiAtNqNxh9P/ti2wUAePcCMlebJnfkldtm3S7yW/QW7v+vkBBzG0cEFPlmK05sESWaG28Ym2GgiTrS+LaAqLCvj2E2nAsE2zo1EtcE1NvMrXu11/39B7Xz5IbphENi8KCTQ+zC6NSn+oKoJeXtXhypiDFcmhqI3ErUD+NTfSqkx3QsAwzq+VtHvgkysotn11SiUFzgElvm1N/L2hWoiMbD5gPVYfqKfyGr+fZfZmexUMUfgE0sq43L6z+pgeJIOXt2Ubxs8v4lnASxwyQHVgwWMtYSuBvRQ7+KKObvZXFM61rwf4uVER/Sbo+GT1xf+YFJAbPlT8L7aYc0baCrudq7+KYfPYpxrqKfcp3LSHoX97/RIPWOw1Fl7EO9JsJJwLK6BBYh3mJrU8m24Gl6ETSy
X-MS-Exchange-AntiSpam-MessageData: 8gDM/Rzs3p4kk/Uj8zv4Wc00MoT4zrC24u3/Mh65N9oAgp2s1aaa40IeRjzlbcqzaR1ZmzEd3wzWHkw41cZoJ3ZWiseVy7OV23+qqQ2aaOqsPyoyuVHYOeKPBuRuybmZRueq2NCDmXqxw8ZhUnrg6Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd91830-57da-4011-eefa-08d7b158b927
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2020 14:18:12.0403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H3L5+nG+7KrckA2rHuKzOadErwjzTqqnm83m92pzlPnwB2j+a0TeR7V2cGEmy12tEKGj8CQnPNlg2FcCwi8ANA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB2714
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-14_04:2020-02-12,2020-02-14 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Have a separate function to count errors in csrow/channel. This better
separates code and reduces the indentation level.

Implementation note: Function edac_inc_csrow() counts the same as
before, ->ce_count is only incremented if row >= 0. This is esp. true
for the case of (!e->enable_per_layer_report). Here, a DIMM was not
found, variable row still has a value of -1 and ->ce_count is not
incremented.

Signed-off-by: Robert Richter <rrichter@marvell.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Acked-by: Aristeu Rozanski <aris@redhat.com>
---
v2:
 * updated patch description to address the case fir
   (!e->enable_per_layer_report),
 * reordered variable declarations
---
 drivers/edac/edac_mc.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index e817a710739f..31ba988359d2 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -1089,6 +1089,26 @@ static void edac_ue_error(struct mem_ctl_info *mci,
 	edac_inc_ue_error(mci, enable_per_layer_report, pos, error_count);
 }
 
+static void edac_inc_csrow(struct edac_raw_error_desc *e, int row, int chan)
+{
+	struct mem_ctl_info *mci = error_desc_to_mci(e);
+	enum hw_event_mc_err_type type = e->type;
+	u16 count = e->error_count;
+
+	if (row < 0)
+		return;
+
+	edac_dbg(4, "csrow/channel to increment: (%d,%d)\n", row, chan);
+
+	if (type == HW_EVENT_ERR_CORRECTED) {
+		mci->csrows[row]->ce_count += count;
+		if (chan >= 0)
+			mci->csrows[row]->channels[chan]->ce_count += count;
+	} else {
+		mci->csrows[row]->ue_count += count;
+	}
+}
+
 void edac_raw_mc_handle_error(struct edac_raw_error_desc *e)
 {
 	struct mem_ctl_info *mci = error_desc_to_mci(e);
@@ -1256,22 +1276,12 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
 			chan = -2;
 	}
 
-	if (!e->enable_per_layer_report) {
+	if (!e->enable_per_layer_report)
 		strcpy(e->label, "any memory");
-	} else {
-		edac_dbg(4, "csrow/channel to increment: (%d,%d)\n", row, chan);
-		if (p == e->label)
-			strcpy(e->label, "unknown memory");
-		if (type == HW_EVENT_ERR_CORRECTED) {
-			if (row >= 0) {
-				mci->csrows[row]->ce_count += error_count;
-				if (chan >= 0)
-					mci->csrows[row]->channels[chan]->ce_count += error_count;
-			}
-		} else
-			if (row >= 0)
-				mci->csrows[row]->ue_count += error_count;
-	}
+	else if (!*e->label)
+		strcpy(e->label, "unknown memory");
+
+	edac_inc_csrow(e, row, chan);
 
 	/* Fill the RAM location data */
 	p = e->location;
-- 
2.20.1

