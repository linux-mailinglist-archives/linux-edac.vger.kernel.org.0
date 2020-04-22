Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 575EC1B43B4
	for <lists+linux-edac@lfdr.de>; Wed, 22 Apr 2020 14:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgDVL7s (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 22 Apr 2020 07:59:48 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:35474 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728326AbgDVL7l (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 22 Apr 2020 07:59:41 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03MBpJqc031947;
        Wed, 22 Apr 2020 04:59:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=pfpt0818;
 bh=IkA9br3+xRFBqWpoHR3xpUv3vB3zjDM0I/9Bw11lJQY=;
 b=aRVvIYCa+HWq3znsHV2GhSiofWAboQeA/N8PUKTnIQ9PzK1y23783Hdw1wqv/CuN0Til
 99FT7sABNWHlKiw6PA2wQSNk9IidZMgOb4HcHKKnG4Vineyvn3t2/gqNtPc467Y011Vv
 +Qc7aRLvkl83bVWKCL5mOtTvS4shfV/E7NZByL+lsyvko5FufAV+p2pSB1emf+oRn1tW
 myfY/VdN3QAB/YWwRHM+/XLl73ga1hxE7uo7no9D1Ditj9yCSSUMFpPa2z1Neds5oPBf
 niAA4brd1IDwvk6sorg+Ti+mcf+HgbrSjddA5RQhiRmYDFki85sYGaYEzBgiAbZxBSDD ZQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 30jd011w4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 22 Apr 2020 04:59:06 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 22 Apr
 2020 04:59:04 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 22 Apr 2020 04:59:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0PGz1qKb35kphDMfiJn+FQ3u7gk73c5/0guu8jYOwF7GQ867vGKiOlUtHDal+DYRxXPW2BVS3y1/4kT3n6PAnSqjfID9FbNS1qOvK8/nLWfWoW0oiGJa+FPIgPBTaM9LO/jEaxMFRhmR6ZUlMJ/HzPokxqwQDlJBlX+rmHo1ZaeUBlP3eR6hFohQRF9zIbaw01sPNjpzJIqhCEvaKqRcUcIUjeS6JihEd3Y1MdLm8yO2x2u5lqpIodG0m2fvSLMOkVadq7NbZemFEr9PFVKTn12M06WAx69hrHSOegqNIOTIfSGXNhMcXahEgnLXV+BBHp4VVnRWw3CXvWyHsrz9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkA9br3+xRFBqWpoHR3xpUv3vB3zjDM0I/9Bw11lJQY=;
 b=cY1GJQi5lHbWrEzuRkBwLM4s6da8k7+CIX1ZphxPa33sJ+8oVQM5sSTon4fIvd6sn0aELnus0V8dZR8KgoPAdgvV3JDHgYv0ILZPkSqXGqs4+6ECLWe7cTO9psrksPA3NudFgb4sgsHht+UGDwHohR7dt0oinhXcKKT4fD5M0Cpr1maVcE7Xco688B5fBN/1zDj0rfq4VEzjjVj9Ro387VAtUhK/LSGxSytLTBbY4taMzuhxFKUShGp62Sls08jB3Ij+Iynnaao3GdJfX3atfJ4Tz6rA3QlbhkJSk8iibY3rXFWRz/u2JFumfnIO1LEE+WIJnZ2GyVUuQrl+VgQg9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkA9br3+xRFBqWpoHR3xpUv3vB3zjDM0I/9Bw11lJQY=;
 b=BK/RHbRSzYt56VNDsN0bHwp2YuaZkqFdDFyFbvwpAphnTIRYHv3r8RJVhh7BJ8O5wMMnhrG1URcPJGMMLyFn/6eewWICA8z3L59uCsj03KECj4Be6WHyWgBB53v/Y7SQryqRdNDBD9uRr1bXILLbut37XjdgchxJ5LWUqjyl9nY=
Received: from BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
 by BYAPR18MB2933.namprd18.prod.outlook.com (2603:10b6:a03:10e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Wed, 22 Apr
 2020 11:59:03 +0000
Received: from BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d]) by BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d%7]) with mapi id 15.20.2921.030; Wed, 22 Apr 2020
 11:59:03 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        Matthias Brugger <mbrugger@suse.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 06/10] EDAC/ghes: Remove local variable rdr_mask in ghes_edac_dmidecode()
Date:   Wed, 22 Apr 2020 13:58:10 +0200
Message-ID: <20200422115814.22205-7-rrichter@marvell.com>
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
Received: from rric.localdomain (31.208.96.227) by HE1PR0701CA0076.eurprd07.prod.outlook.com (2603:10a6:3:64::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.6 via Frontend Transport; Wed, 22 Apr 2020 11:59:00 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b953180-b936-42fe-e261-08d7e6b48cbb
X-MS-TrafficTypeDiagnostic: BYAPR18MB2933:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR18MB2933C04AB5BC8DA7E0A74E46D9D20@BYAPR18MB2933.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2661.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(366004)(396003)(39850400004)(376002)(136003)(6512007)(1076003)(6666004)(81156014)(8936002)(4326008)(6486002)(8676002)(2616005)(110136005)(52116002)(186003)(16526019)(86362001)(956004)(6506007)(66476007)(2906002)(66946007)(54906003)(26005)(66556008)(36756003)(5660300002)(478600001)(316002);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: um2R5ffdWZQx8TqBPJxUrdt73lJPpXPbnZe7mlKI5VvPhep0p5IgP0Ceuk2IMs19hQ6JAPy+pXc+uSB1daZz8ZPynVcdrzyjUDBIN+tJokORWnxOIPGy8Umlu+TALx9S0Kx39BsFfpB5tk2eeW9Isz/3t5u6OhCSTD1L30xU0HtyyWfMUMAvu3wF7fnJaGKTijCaKQNqZs/P3CzKwj3cfUEf+oyY9nscMoajJ/WG3vac5jFHAMoC/cU6zu2r+8CJ1cM6J6adJtApFHRzj5SgePWhDr3hN7xyAXSD5U32Qz+6GYJygYzVY1jLhK3WCvoq2VisqgNFVyD30cZKPMr17ZJtGdGDtR8tGOcoj8Hr1C5BHosoXIIvN0yu1cp9c0D5RNGBMChhlR4+RKc1azE8wWIFVAwuZEQToUMm8DC4rgfygMf6a9MtZ0/bAM9mFqt4
X-MS-Exchange-AntiSpam-MessageData: UOm1YSC1hxyIg1Nu3qDiuBvnhfDR7YoNcRVVQLKZXo4AEwYQdAGlKlIJ2UVSXl7JWOZPZrToPZHhgUGL1Y1wxQw/bMV6ttAthRFgKJ3QVUZ6A7zDnMI2zK55EKjKMa1MpfaO00SziZ0jEhsJl3cjvA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b953180-b936-42fe-e261-08d7e6b48cbb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 11:59:03.0886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /lndd0G6mRxtBw47ki4GqeMNa1OaFuDF6yEa1Z3//R5cB38E21pWz5vsfqj4+vhH3mxj9PniW3Jkk1d1jEeZ3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2933
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-22_03:2020-04-22,2020-04-22 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The local variable rdr_mask serves as a static constant here. It hides
what the code is doing. Remove it and replace it with the actual logic
that checks some bits.

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/ghes_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index a5890afa9c71..038e560fd332 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -191,7 +191,6 @@ static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
 	if (dh->type == DMI_ENTRY_MEM_DEVICE) {
 		struct memdev_dmi_entry *entry = (struct memdev_dmi_entry *)dh;
 		struct dimm_info *dimm = edac_get_dimm(mci, dimm_fill->count, 0, 0);
-		u16 rdr_mask = BIT(7) | BIT(13);
 
 		if (entry->size == 0xffff) {
 			pr_info("Can't get DIMM%i size\n",
@@ -241,7 +240,8 @@ static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
 		default:
 			if (entry->type_detail & BIT(6))
 				dimm->mtype = MEM_RMBS;
-			else if ((entry->type_detail & rdr_mask) == rdr_mask)
+			else if ((entry->type_detail & BIT(7)) &&
+				 (entry->type_detail & BIT(13)))
 				dimm->mtype = MEM_RDR;
 			else if (entry->type_detail & BIT(7))
 				dimm->mtype = MEM_SDR;
-- 
2.20.1

