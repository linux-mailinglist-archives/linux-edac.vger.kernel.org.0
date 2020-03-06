Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6508217C176
	for <lists+linux-edac@lfdr.de>; Fri,  6 Mar 2020 16:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbgCFPN7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 6 Mar 2020 10:13:59 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:59086 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727137AbgCFPN6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 6 Mar 2020 10:13:58 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 026F6X1u002690;
        Fri, 6 Mar 2020 07:13:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=pfpt0818;
 bh=YrWvS8qCSdSB7oGG6iZU3K72KjZZW1yGrGOFxGuh6co=;
 b=X8O1ROCO7Z5avAD/mXAJEhpLjPnWvrYeSr+GwOOpYy/QRSwt/iQtQvN3vYf4/2LBraoB
 7WaRX2Fv8wc8wW8R1XcRimv6DV0RnWJI4Jnfx04r01ck//h3VuhAE8K8x0cs6eV5BAv6
 0F5PBk8LMWByYknP0uCQJyiGtO93fI5V20JU0k9PyxoKPjjp49jQTJ/X9iduxS8V1H2P
 BntaxKnW7co5xEcK/0wSKPWLs+WiZezHfDmD1RvDIO8CYAEev2Ep0XjafT/4rgszcwVM
 hNk+7vspT9lfsCaKz9+tBs7kCjzRRWzjQ0W5kcvnAZyJxQtXGdKVZS7Gi3aJ0U+d/q12 CA== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2yjnjhb2d4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 06 Mar 2020 07:13:49 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 6 Mar
 2020 07:13:48 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 6 Mar
 2020 07:13:47 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 6 Mar 2020 07:13:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ew3Hnt8RK5S6Lctx8B1RjvLeaHnnammYInYqfu0TlpvZHHM9XeVIfZncX2XnWnb71ZaAsfyCciwhoyKFn6duQ5WZJPsuv5aQkH48DMWDT4F7yikZ6spI9Ta4QiJV5PYKnigZ7umR0aG9EFBMoqbwgN4PmHUCiJ8sZituU2bNCec4qEzwhzsn2Flnqa8j5ne30n9L5cF3CDPPGc3JBDII3ca6OfY8hQR5Lk405ElnbXhuJrHRxcc5DJLRuutR8JlAiF0zCpbx2LWnroAzRpH/wwRfn9H7gslsjWy/iYROPhnQE1eVAbyBo4G6gu0l2PRxlUM13zmVfH0P5aoHSMZH1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrWvS8qCSdSB7oGG6iZU3K72KjZZW1yGrGOFxGuh6co=;
 b=gZYw+jejopV1b6nf2QJCLO8kGp7m4+224uETZY9unIOei/NZxNEt/u5edbac7AhXph79L4wzFj2bJL9zi+OAeq7YQ4V+FQse53n5ncm8VeRcSrOjmcOZ5zveK3Wun9CU4GuuypkjYhYmPmCyi1VrTCLw4QhA5XE/uK0zAKOLoVDZgfVIeWBOhGqGR9oLdZLQyfx6cjpdt3ySOAiSzuzV4pwvDfQ3swjAnE5VogOmLfm19/giISRU8M5DqXWhwDXzC/iT06SWzoSP2F9kiUtM7geK8KQRETl1qwY1zOQc1lv6OWWiotyjVCWaNuXU1RcRqkcQxTfhUX0m3N4kFlLc/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrWvS8qCSdSB7oGG6iZU3K72KjZZW1yGrGOFxGuh6co=;
 b=Eatu055TUJpV3fPrYIvYxGnzrP//2lf6AD/hEdo+Z+VGIicVqR4FOC3EczBr3HH72hNBxNPO7HE1jvfNBCjwUkzWxtY0icCVjsn2tYMVNyncVoz7/rFmiHJ1nG3DsMPbjnkRX1/gsgGYKKkXQeexMRP6Am4hwseBvzrYIqxBXXk=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (2603:10b6:208:165::10)
 by MN2PR18MB2400.namprd18.prod.outlook.com (2603:10b6:208:ab::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14; Fri, 6 Mar
 2020 15:13:46 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::30c4:52fe:fdf8:faff]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::30c4:52fe:fdf8:faff%7]) with mapi id 15.20.2793.013; Fri, 6 Mar 2020
 15:13:46 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 04/11] EDAC/ghes: Remove unused members of struct ghes_edac_pvt, rename it to ghes_mci
Date:   Fri,  6 Mar 2020 16:13:11 +0100
Message-ID: <20200306151318.17422-5-rrichter@marvell.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200306151318.17422-1-rrichter@marvell.com>
References: <20200306151318.17422-1-rrichter@marvell.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0102CA0059.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::36) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR0102CA0059.eurprd01.prod.exchangelabs.com (2603:10a6:7:7d::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend Transport; Fri, 6 Mar 2020 15:13:44 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 668ea2cb-21d0-496e-2e59-08d7c1e0f723
X-MS-TrafficTypeDiagnostic: MN2PR18MB2400:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR18MB240087C9CB4633B6A85F20B7D9E30@MN2PR18MB2400.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-Forefront-PRVS: 0334223192
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39850400004)(396003)(366004)(136003)(199004)(189003)(81156014)(81166006)(5660300002)(8676002)(6666004)(54906003)(26005)(956004)(2616005)(4326008)(16526019)(316002)(110136005)(186003)(2906002)(8936002)(86362001)(6512007)(36756003)(478600001)(6486002)(1076003)(66556008)(52116002)(66946007)(66476007)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2400;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iEq89dPUEX/+XJTVVbd8MAFPwfUZfU1Zi6WfF5xPXDgEOlC85rFyDeEEIxH/8VoGd2CWbOA02Tploa3hRWpe0Ask3fbODk13+694HgaNrdCJT5Gp8FraU/exmHQ4+nuheTfWzmB28FT497x6rwJ7hAgS0JfyR3lyZKH0OQA6H0D808XT/J2MjQi9akvlZ9niDMkmXLGBRmuPhi93J9uzphGqsHMBZ6nsiTbMndBEZKWRAniL1/aSnc8w7HOxU1rNK9jNLFfAtgBgBi/C4ludEBAplQZt+cO2SdHurgE2W0IPuE88fBC1nSFRhifWiTfGiuL77r9altIpq6CrasjxI96hyFMZhtuduDRsTWasWtPOdImgB1vMMljy1D6ibDIOrUcxk/meyawKU5YmdddDXPFxLCVWohbL5Z2Pjw7jTDkX+ifTu757pVh8iS0BoXbl
X-MS-Exchange-AntiSpam-MessageData: 9rHjNTm6mMNsmXLdQqCh78ef/WUVWnEL44a5fVJkt3j5cY4wy3unWHRfQpu5edKv4Y4YcLGirZoi6J+d2/78RX38ILOBbXHVHiFCvAYH+HhLaprD4+BSL3KMVXnkuTiIk+IVDOPDDy/LesTKfeUqGQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 668ea2cb-21d0-496e-2e59-08d7c1e0f723
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2020 15:13:46.2165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kOitXErcSyZpqk1Y5gs324/R2dyNTbHbA8cGteBIsIQmugFR4l84VbZ5xecQGOf0CCVC7ozyt7x+kjGXUtmMAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2400
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-06_04:2020-03-06,2020-03-06 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The struct members list and ghes of struct ghes_edac_pvt are unused,
remove them. On that occasion, rename it to struct ghes_mci. This is
shorter and aligns better with the current naming scheme.

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/ghes_edac.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index fce53893731a..438972dfea09 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -15,9 +15,7 @@
 #include "edac_module.h"
 #include <ras/ras_event.h>
 
-struct ghes_edac_pvt {
-	struct list_head list;
-	struct ghes *ghes;
+struct ghes_mci {
 	struct mem_ctl_info *mci;
 
 	/* Buffers for the error handling routine */
@@ -32,7 +30,7 @@ static refcount_t ghes_refcount = REFCOUNT_INIT(0);
  * also provides the necessary (implicit) memory barrier for the SMP
  * case to make the pointer visible on another CPU.
  */
-static struct ghes_edac_pvt *ghes_pvt;
+static struct ghes_mci *ghes_pvt;
 
 /* GHES registration mutex */
 static DEFINE_MUTEX(ghes_reg_mutex);
@@ -217,7 +215,7 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 {
 	struct edac_raw_error_desc *e;
 	struct mem_ctl_info *mci;
-	struct ghes_edac_pvt *pvt;
+	struct ghes_mci *pvt;
 	unsigned long flags;
 	char *p;
 
@@ -469,7 +467,7 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	bool fake = false;
 	int rc = 0, num_dimm = 0;
 	struct mem_ctl_info *mci;
-	struct ghes_edac_pvt *pvt;
+	struct ghes_mci *pvt;
 	struct edac_mc_layer layers[1];
 	struct ghes_edac_dimm_fill dimm_fill;
 	unsigned long flags;
@@ -506,7 +504,7 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	layers[0].size = num_dimm;
 	layers[0].is_virt_csrow = true;
 
-	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, sizeof(struct ghes_edac_pvt));
+	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, sizeof(*pvt));
 	if (!mci) {
 		pr_info("Can't allocate memory for EDAC data\n");
 		rc = -ENOMEM;
@@ -514,7 +512,6 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	}
 
 	pvt		= mci->pvt_info;
-	pvt->ghes	= ghes;
 	pvt->mci	= mci;
 
 	mci->pdev = dev;
-- 
2.20.1

