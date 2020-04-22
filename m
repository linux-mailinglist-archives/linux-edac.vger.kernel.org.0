Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5391B43AD
	for <lists+linux-edac@lfdr.de>; Wed, 22 Apr 2020 13:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgDVL7i (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 22 Apr 2020 07:59:38 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:17644 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728288AbgDVL7f (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 22 Apr 2020 07:59:35 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03MBpgLT002215;
        Wed, 22 Apr 2020 04:59:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=pfpt0818;
 bh=JxTXLycuasncFz8Ofz7Gf3EqNG5pVBNMvsNhrBZ4GI8=;
 b=Z0U+dvS0AS65d/yTMDLuo0GZjNc8VInk5NSFq2xAxX3WTzxZaFBmlV4xe1LbZvB4z7wz
 x3ePcZ4yXdLjVfDO/ET5Vdf8cU649Y8UiIKA8OeJLOevf3q14bZZdMumSLOZjgpy1BZK
 HpVHqEaXVzutLy35Dm0gZ4rf4MgNbl4QIr3K2/lxWfx8m1tWGSGCTDN9hwLqyInPVYnW
 kzy/MNnO3Ec14QpFq77P06r3m/njK/93EF3BjPeu1L0cN+5kLxOEre/xOnQUlZSeoDEt
 cb86s0Ftaisssx1XJiNpOCrca7q3N/yjNH4R2irRKlcxDA0FrSdf0ZMPpSHzdOjAwWSe OA== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 30fxwph9ea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 22 Apr 2020 04:59:14 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 22 Apr
 2020 04:59:12 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 22 Apr 2020 04:59:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MN/2MdFNDeB1YdNDox3YBbbphqCO7X60KRlA1IGbaMlkl75bLDZrBqqx4+3XYF0eYiKQPgnidoZ/3DAJVxn3y9hbusI2icVqwBCadeUPSuPbwGPThwS51D1QpJgfFQjc9m3DErawAAro5W8VFF6ezfIzSANGysygcWokzOSfGYn2p+AnGCzOBUEGCRkGRhW7Epk/BGQQV/p8Ps5NBuDyxJLEYAidREYioJGTj/kXnDW65tX2SKWnBv5YP5q9lAzxX2oRQ3y5zf6QhWOAlZNwPhb428oie/qPinptJMN3mEyFmM1TqQU2csJDa3QwLmz+vBR9B/XQc2qnH02gW1UBmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxTXLycuasncFz8Ofz7Gf3EqNG5pVBNMvsNhrBZ4GI8=;
 b=UmMHiVG9f5cyMwKJdyo9GN3dCHu0D4KOOdoFZI0CzoefSPYICYa6Jos/7LSb8VE7hOHErTVj8j1u4s5wwIyyAAk9VM7fYpStvzMIajGyqJUKcSdQ0uuGewV/yAzRESNdTOEvEluiy7DypA8ggvbk8kH5MavVOPqaEVCJU8uMmrTBvWMXVqIdElVoNKHjGzPLqtBW4pYIPPsXI5jZ+uNqESMpK49obZG19LBfFKxfIruKJnDkFOdTCHariGNdlPAPOCzo1ExWbYPSET+mjb8v9gcnJVUWECoseczQCk/KhO4QwDxaLGfS4JZ8zmvbqhzkbM1aie5sc86pki7kqUW/DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxTXLycuasncFz8Ofz7Gf3EqNG5pVBNMvsNhrBZ4GI8=;
 b=Iaja+Is8E3CcZFWqwTJTNgM9Domz7UXkdAeyqUpfqrrhqc5sg9trA8ZhptuxIm/rq0w2dZdhbbJBWUCuARd0RRWL6uwkiJ+kFHl1fYoeN/2nJhRwMzBAzUUJTxFVgYzmLZ3kyvd80RZtUJGtlNHuAZX+JRB4qlle+1N+OzV5G9w=
Received: from BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
 by BYAPR18MB2933.namprd18.prod.outlook.com (2603:10b6:a03:10e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Wed, 22 Apr
 2020 11:59:12 +0000
Received: from BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d]) by BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d%7]) with mapi id 15.20.2921.030; Wed, 22 Apr 2020
 11:59:12 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        Matthias Brugger <mbrugger@suse.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 09/10] EDAC/ghes: Have a separate code path for creating the fake MC
Date:   Wed, 22 Apr 2020 13:58:13 +0200
Message-ID: <20200422115814.22205-10-rrichter@marvell.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422115814.22205-1-rrichter@marvell.com>
References: <20200422115814.22205-1-rrichter@marvell.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0701CA0076.eurprd07.prod.outlook.com
 (2603:10a6:3:64::20) To BYAPR18MB2661.namprd18.prod.outlook.com
 (2603:10b6:a03:136::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR0701CA0076.eurprd07.prod.outlook.com (2603:10a6:3:64::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.6 via Frontend Transport; Wed, 22 Apr 2020 11:59:09 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccd420f3-ce1a-4780-0530-08d7e6b4924b
X-MS-TrafficTypeDiagnostic: BYAPR18MB2933:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR18MB29337C0A2C277A8833A6EB64D9D20@BYAPR18MB2933.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2661.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(366004)(396003)(39850400004)(376002)(136003)(6512007)(1076003)(6666004)(81156014)(8936002)(4326008)(6486002)(8676002)(2616005)(110136005)(52116002)(186003)(16526019)(86362001)(956004)(6506007)(66476007)(2906002)(66946007)(54906003)(26005)(66556008)(36756003)(5660300002)(478600001)(316002);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b5tNxIM985ocoNRNYOBRj/w/JniEToBM1ngdKxG/Q9b3PTxloS2p8Nws6ridCuHv0TagEbbZsCWZ42K64XFMFQQ132+e1VQ/eyTTOqzQKEtWsHt9JkzRFRZk4LXNAZ3vFZaJBgQ4GkH7n6ytxldiK0+p1xQmmWsEh5EwO9xfXZAKwWNRGiVuzVwMmlVf/NP7APYTXdI+EnSy3EityZwkr/YjzmnYXTasud98iI8gLNk4oEDX/UAu8x2sINK2pd7mFX7orodKBW8gy5odrY5SKBEcbyZ1gfbB+y1rSwMid9P9zuA6LJYwSwRZMMyfN24bF2d/eMw6PBhJ4EQO1tZZV0ZItn+FzUkBDo54cd3A8eoK0iQO6fg6puuzwTt8HOzy4MEiy6HHxTqYzFZ6P7b/jPldv3s/9qvUJ/x+bxmQxt8dp/EM5+ypAo2uhLG7FvsO
X-MS-Exchange-AntiSpam-MessageData: bHAWjwTYrM7cBXL6MkXMCK6kpA34+e1N9RdjxQ3Y/EQQ59GgokbA6Zr8vPBqQR7mOWfvGsY3svCtt+DjC7BSHZCmnwM42AED5jIn/NskSAvecitWDdYK5h8IYR+VBP9bFUTiyBMgKCGf1tbHEzsFlg==
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd420f3-ce1a-4780-0530-08d7e6b4924b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 11:59:12.2194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CAUk0DHuo3Lt4mFMWn9LcItOa81W2HlzKUy3BUZuRf14hAjTYQc0/iGn7V4f4SXg0ksJgB0eaMdbO7bDkKXzxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2933
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-22_03:2020-04-22,2020-04-22 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The code in ghes_edac_register() switches back and forth between
standard and fake controller creation. Do one thing only and separate
the code path that creates the fake MC.

Note: For better review the code is not yet carved out in separate
functions.

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/ghes_edac.c | 68 +++++++++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 26 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index af0a769071f4..af72da156696 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -615,7 +615,6 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	struct dimm_fill dimm_fill;
 	int rc = 0, num_dimm = 0;
 	struct mem_ctl_info *mci;
-	bool fake = false;
 	int idx;
 
 	if (IS_ENABLED(CONFIG_X86)) {
@@ -643,23 +642,43 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	if (rc < 0)
 		goto unlock;
 
-	/* Check if we've got a bogus BIOS */
-	if (num_dimm == 0) {
-		fake = true;
-		num_dimm = 1;
-	}
+	if (!num_dimm) {
+		/*
+		 * Bogus BIOS: Ignore DMI topology and use a single MC
+		 * with only one DIMM for the whole address range to
+		 * catch all errros.
+		 */
+		struct dimm_info *dimm;
+		LIST_HEAD(empty);
 
-	mci = ghes_mc_create(dev, 0, num_dimm);
-	if (!mci) {
-		rc = -ENOMEM;
-		goto unlock;
-	}
+		mci = ghes_mc_create(dev, 0, 1);
+		if (!mci) {
+			rc = -ENOMEM;
+			goto unlock;
+		}
+
+		dimm = edac_get_dimm_by_index(mci, 0);
+
+		dimm->nr_pages = 1;
+		dimm->grain = 128;
+		dimm->mtype = MEM_UNKNOWN;
+		dimm->dtype = DEV_UNKNOWN;
+		dimm->edac_mode = EDAC_SECDED;
+
+		snprintf(dimm->label, sizeof(dimm->label), "unknown memory");
+
+		rc = ghes_mc_add_or_free(mci, &empty);
+		if (rc)
+			goto unlock;
 
-	if (fake) {
 		pr_info("This system has a very crappy BIOS: It doesn't even list the DIMMS.\n");
 		pr_info("Its SMBIOS info is wrong. It is doubtful that the error report would\n");
 		pr_info("work on such system. Use this driver with caution\n");
-	} else if (idx < 0) {
+
+		goto out;
+	}
+
+	if (idx < 0) {
 		pr_info("This EDAC driver relies on BIOS to enumerate memory and get error reports.\n");
 		pr_info("Unfortunately, not all BIOSes reflect the memory layout correctly.\n");
 		pr_info("So, the end result of using this driver varies from vendor to vendor.\n");
@@ -668,26 +687,23 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 		pr_info("This system has %d DIMM sockets.\n", num_dimm);
 	}
 
-	INIT_LIST_HEAD(&dimm_fill.dimms);
+	mci = ghes_mc_create(dev, 0, num_dimm);
+	if (!mci) {
+		rc = -ENOMEM;
+		goto unlock;
+	}
 
-	if (!fake) {
-		dimm_fill.index = 0;
-		dimm_fill.mci = mci;
-		dmi_walk(ghes_edac_dmidecode, &dimm_fill);
-	} else {
-		struct dimm_info *dimm = edac_get_dimm_by_index(mci, 0);
+	dimm_fill.index = 0;
+	dimm_fill.mci = mci;
+	INIT_LIST_HEAD(&dimm_fill.dimms);
 
-		dimm->nr_pages = 1;
-		dimm->grain = 128;
-		dimm->mtype = MEM_UNKNOWN;
-		dimm->dtype = DEV_UNKNOWN;
-		dimm->edac_mode = EDAC_SECDED;
-	}
+	dmi_walk(ghes_edac_dmidecode, &dimm_fill);
 
 	rc = ghes_mc_add_or_free(mci, &dimm_fill.dimms);
 	if (rc < 0)
 		goto unlock;
 
+out:
 	/* only set on success */
 	refcount_set(&ghes_refcount, 1);
 
-- 
2.20.1

