Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247971D9491
	for <lists+linux-edac@lfdr.de>; Tue, 19 May 2020 12:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgESKpf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 19 May 2020 06:45:35 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:58320 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726494AbgESKpf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Tue, 19 May 2020 06:45:35 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04JAedaq031351;
        Tue, 19 May 2020 03:45:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=pfpt0818;
 bh=lLCAHuSobwIEK/Wiic+M3Y+HJjZXSuwrKpFZxVRimaE=;
 b=LDygkSvnzxnbL3fR6KkYsQPEWye/3U8ebeXWRiCcwrMHgkCDyx3UFnrqUOePr91Zgk9l
 z8QytF+XoQmEgEwZTDrl3EM/nWT25RvTWiYGXQYW6zFLq7XtXW3oqwfwOVh1/qQdvxe+
 jdmZ3wkaAuZiGnGWSErNWWUNLsLBvydezBMGCZvjPfzlG7aPhaETPDh24IDw5Lrn1SZq
 5TUYqsg0sLLlufKXh6I8ysoBf7aKjXF2NaU1nbF9q+rgKH3NsUSxTyanycl58ofycILx
 KvZzumcr3qdNl+Yjqn81Xvc4i2fEM+3lptz/J9a6lu6cSPOrGOHTVwHL6K8BD0XD5ib7 qQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 312dhqkgnb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 19 May 2020 03:45:21 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 19 May
 2020 03:45:20 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 19 May 2020 03:45:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFryiegkaEq3t2S0bQGheKmwMqFJDnIv1QKbF5/jZcMokt9eHqFYkGOGz3mgNW5jwtXUwmoc7mgMrJyG9Lp0a4k052uXAvlmaRPQd5vI1ECKIabRF9DDBUiAqgQ2Y5grDkNdrROIWhrT+JMt9IlN671a2WMMuRJsi2gUosBrlIR7A0lQR2flD8pVy62Uv5sSeDiuG2d4yVnn02gQe82XrHdpnG4WZn5kTvIle5CGc9bQNRQtnOPqP/RF1meGW5gEjdiCDzHqKY33Hbf8LqltHX1tzgrhnd5IaW4CVIAR1jPTHC4t5oMIjkX3SOULV/OmHdaACjhnUW7qFv4zkC/EvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLCAHuSobwIEK/Wiic+M3Y+HJjZXSuwrKpFZxVRimaE=;
 b=hnMP/ErzaXQY6AzqUXooEZShdWA+N92W4hdSsCL0Y5NPzPWlOcl7kmyI+l96qZrfhwbbnyDEzan2V1p7xIbIy4033lNafLDpVubE5/aW/ADW1mo69zGMqNpln1poerNPuCdIO+1USIlAlbDHrs2qA0ELK9ULzCH5J/TUsn16z3hc0hFZF19e2lAw6gJrOkKufbiEo53g5BfmldgwjbxhEJcfmPoU9SHfkocymltZcaDgjn84D8eMmTCq/6SAbAM4ivQA6k1gmbq4Al9uP4NOgOn1T8ek0yDBil5af1d1RjtVrQHHTNgPf6No11CE7adNkmE1uzjTdG4VYVXgKEuUXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLCAHuSobwIEK/Wiic+M3Y+HJjZXSuwrKpFZxVRimaE=;
 b=uX1uM6goISqhS+B7JzAmXuHVtOXJ0np/jHkb8tyLmJw7GJaJytAyOoD55ix3NphodRBdix/1vA7Fysy8iq1xrWCnAJz4VbgLiiL3OXrbZHE3y9ifSv6wnuF4UFtelgvxWlbZU673lseCvuR4l5kv3FucuzRT0nlg+UK+cqyFYds=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=marvell.com;
Received: from BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
 by BYAPR18MB2455.namprd18.prod.outlook.com (2603:10b6:a03:132::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Tue, 19 May
 2020 10:45:19 +0000
Received: from BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d]) by BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d%7]) with mapi id 15.20.3021.020; Tue, 19 May 2020
 10:45:19 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        Matthias Brugger <mbrugger@suse.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/5] EDAC/ghes: Remove unused members of struct ghes_edac_pvt, rename it to ghes_pvt
Date:   Tue, 19 May 2020 12:44:39 +0200
Message-ID: <20200519104443.15673-2-rrichter@marvell.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200519104443.15673-1-rrichter@marvell.com>
References: <20200519104443.15673-1-rrichter@marvell.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1P189CA0023.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::36)
 To BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1P189CA0023.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24 via Frontend Transport; Tue, 19 May 2020 10:45:17 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40020fce-f882-4471-76ad-08d7fbe1b954
X-MS-TrafficTypeDiagnostic: BYAPR18MB2455:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR18MB2455DBACF90BF7378892036DD9B90@BYAPR18MB2455.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7FJVj1WTU2JGafnQUuJBgVtcxI7lUsu+rsDt09qH7mvO/1If+nDzhkfJaASlNYNBaOna/owo69z+TF9fYVXEWHmgctAoSTWFurfnVWvwXu5l0K9DsP10ikYRRH35Kbrd7SSrnE9W9DzA3tdhZt0lXXhOr/RwmD9kl7Coa8AMGUr6/JLpqqNlhLeTaNksLMVOEv7CCtx9L+tcd8pe0jimzxTdSBWj02asG/EZGRuLdw0vJpc5vfLf4ECXvnmiPo88c+IWSL1ceSVQMER8rg4+wA+UCgClfEvDwrNHyCfItxMPUFIkaE0mAIFQRyVm2DMRBCSSddv2+z5jpUIu4UQtaYMefWkksv2n4CT9t+tGn55oXj3HUv15AxgQZy3ts56CfNvUId+HjFRjK9SwKt+s+bSddjx7caak+8XCaMe9+uckBQRwxGdEgHPK8bUXJkA3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2661.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(186003)(316002)(16526019)(6666004)(956004)(2616005)(36756003)(8936002)(110136005)(86362001)(66946007)(6486002)(54906003)(26005)(5660300002)(6506007)(66556008)(6512007)(66476007)(52116002)(478600001)(8676002)(1076003)(4326008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: MfySS82USyBrU5vlpT4c+0jGSVW+1a7PH4JCz9ZOPg5LXDaVM9CI182GVhwPHY+9ymU40ltiFadlcsopb4jANBRneBWTMrG6VF0Iebbb4T465Ln8ZrffO7P883GZxM77mLlFNr3dFI7IvB0P1fB7S1tQQD1xzNDL5UJ/6YNa0/ndpqr/BTlZSlSpNwQBU6TLG0vOBVqUpkjZFa0ac9YRkvcbPYwKoSFz2jlkHkB1SQ3e3llXkURnftGdmz48+M78/Vgzv77S70Hw5ZBuCaGhAlzFLBwuUDsnemz8PWiwS9UCborjmUdgAI9dYo+7BMGO8lcBwzt1c3mJVgsow9Gk61mAKrEGldtN/KKbLzE/YqgRNbh26UUniwOjwX2GK7Ds2cqtHHMWUgCKl9jZzU13PQ02CzlKRnI60V5YFjQzB+X8fPcO0SEsdhGf+mhfvy1CxUCmW5jDojyfJGMb/Fml+n1HJn3ui82FVFaj3luqk30=
X-MS-Exchange-CrossTenant-Network-Message-Id: 40020fce-f882-4471-76ad-08d7fbe1b954
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 10:45:19.5086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uHdkdjq8zFxBGAx0qmT6PXhmpogdx1FcbRucYIkBBTFhkJXBbAuP2QnbOo37DhtUneI1gJdbKVoKzf4fHnCyNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2455
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-19_03:2020-05-19,2020-05-19 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The struct members list and ghes of struct ghes_edac_pvt are unused,
remove them. On that occasion, rename it to the shorter name struct
ghes_pvt.

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/ghes_edac.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index c7d404629863..2ed48a5d48d6 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -15,9 +15,7 @@
 #include "edac_module.h"
 #include <ras/ras_event.h>
 
-struct ghes_edac_pvt {
-	struct list_head list;
-	struct ghes *ghes;
+struct ghes_pvt {
 	struct mem_ctl_info *mci;
 
 	/* Buffers for the error handling routine */
@@ -32,7 +30,7 @@ static refcount_t ghes_refcount = REFCOUNT_INIT(0);
  * also provides the necessary (implicit) memory barrier for the SMP
  * case to make the pointer visible on another CPU.
  */
-static struct ghes_edac_pvt *ghes_pvt;
+static struct ghes_pvt *ghes_pvt;
 
 /* GHES registration mutex */
 static DEFINE_MUTEX(ghes_reg_mutex);
@@ -216,7 +214,7 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 {
 	struct edac_raw_error_desc *e;
 	struct mem_ctl_info *mci;
-	struct ghes_edac_pvt *pvt;
+	struct ghes_pvt *pvt;
 	unsigned long flags;
 	char *p;
 
@@ -468,7 +466,7 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	bool fake = false;
 	int rc = 0, num_dimm = 0;
 	struct mem_ctl_info *mci;
-	struct ghes_edac_pvt *pvt;
+	struct ghes_pvt *pvt;
 	struct edac_mc_layer layers[1];
 	struct ghes_edac_dimm_fill dimm_fill;
 	unsigned long flags;
@@ -505,7 +503,7 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	layers[0].size = num_dimm;
 	layers[0].is_virt_csrow = true;
 
-	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, sizeof(struct ghes_edac_pvt));
+	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, sizeof(struct ghes_pvt));
 	if (!mci) {
 		pr_info("Can't allocate memory for EDAC data\n");
 		rc = -ENOMEM;
@@ -513,7 +511,6 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	}
 
 	pvt		= mci->pvt_info;
-	pvt->ghes	= ghes;
 	pvt->mci	= mci;
 
 	mci->pdev = dev;
-- 
2.20.1

