Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D912A17C177
	for <lists+linux-edac@lfdr.de>; Fri,  6 Mar 2020 16:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgCFPN7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 6 Mar 2020 10:13:59 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:28258 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726861AbgCFPN6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 6 Mar 2020 10:13:58 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 026F6mNp002765;
        Fri, 6 Mar 2020 07:13:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=pfpt0818;
 bh=inU91/NGf5sU7Ij3RXrmFxz22l4k+U4RGAo9V+HJDW0=;
 b=EXUjQXQJyRCfvz33/eQlVTPVHPEOymQYEer2h6oLQKYwmQhUeWIcv4aLdYAtS3qr2zMU
 RHaZc3hnuAlgtNCa1Cz7YMW3KsnHTrxYentv9a2wOlGi/QnnvE+9Al0mU8F9Y2ZeZroB
 UBmWlVLwHQHHQP8PwyCmZoJStA2/1cFHCM+YTGasYJsu5Ws7GG4W4d/NJCfJA6JekNp6
 gCEGQxA5Dd0Km6RTY/aj8Sx7IccBa6EBQ5F5F1SxaS2XPpMvgzTPswRR6KlPfVUYDJtm
 uvh47WojO9cwTW5NBKyMh1C1couF21Kqg+pMvt5+mULS5l1GMJMtK0WPeBDx6lPVKydH DQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2yjnjhb2d7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 06 Mar 2020 07:13:50 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 6 Mar
 2020 07:13:49 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 6 Mar 2020 07:13:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvrsTqwj0U3Jy1K1Xc1Hf0Ub1EWuUlpeO1nvFc+bwy2mX+eL2Eq/aTftJiskjQZ5Mxb7CVp4Ruh8ORm4RCvHQFbew20sHr1176zpZQL4US1ZcCAPznJmY/GCcFJLIGpivjfhFeIdJtGzQPTEKwEbGw6mrO7tW5QYLc36+s0j0AMyBWEVO3LjlpfcLCRBX0ExxZrFe2FxOYl7ehuf5j7CUDoe5YsqW90JWxvIdfQ8RZuGy12nEFofGUt1sbIPOORW032w7kKEk4x0MVom0K/yXJirLSN43FS6gEkF3T0rSbqRktR0mJxCSPiH0sp7Xjs1dIqn6JPYRZAZoMkflwnitA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inU91/NGf5sU7Ij3RXrmFxz22l4k+U4RGAo9V+HJDW0=;
 b=YcvcAvMP3ogqOKBgfm4akBbV/ZZxH7zjvJQwO15gU8dPQP9YmjSQ0yw6FcceceBT02RLVIy/caD17LpkRqX65KclRTLSK1KpHla3SJS3RsXZ2S2GsVhKx34BwEqvNv18NbABwfwr0r11if6+ftj7+3ywz61L0QdzDLavXAN9LbtmBTJbnGBoZK2mfN2epxhmuGjm3NclIXYjphT/9sikGbpIUH8AXbYuRgY4EkXFWTdw+68E26jTOEQwabN/zlKXq1LF0ugIQrG4pyg9Bigrc3jppRq1auDpRTThc7LSELD+JUej10XuhbhKx62GtmJgha3UvLrtlWNcYxkElvhLkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inU91/NGf5sU7Ij3RXrmFxz22l4k+U4RGAo9V+HJDW0=;
 b=pIaf0rlkpxUJRz8tkC78qwGCs0GRqOjWtwYMAT8PHIoN+ppg0qHIx47Xa5KtLQIL5eSuds33xKCRREOiPtNZetSzYjRfhMnbAqs9YTKfdURDmKlLNu6AGseaglc2t6whBGM8rnQtwrvQEfqhERa452t2DjOw4iREIvmaZUNJ4LI=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (2603:10b6:208:165::10)
 by MN2PR18MB2400.namprd18.prod.outlook.com (2603:10b6:208:ab::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14; Fri, 6 Mar
 2020 15:13:48 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::30c4:52fe:fdf8:faff]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::30c4:52fe:fdf8:faff%7]) with mapi id 15.20.2793.013; Fri, 6 Mar 2020
 15:13:48 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 05/11] EDAC/ghes: Cleanup struct ghes_edac_dimm_fill, rename it to ghes_dimm_fill
Date:   Fri,  6 Mar 2020 16:13:12 +0100
Message-ID: <20200306151318.17422-6-rrichter@marvell.com>
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
Received: from rric.localdomain (31.208.96.227) by HE1PR0102CA0059.eurprd01.prod.exchangelabs.com (2603:10a6:7:7d::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend Transport; Fri, 6 Mar 2020 15:13:46 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8abb355-04bc-46bf-c87e-08d7c1e0f86f
X-MS-TrafficTypeDiagnostic: MN2PR18MB2400:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR18MB24003874E8631B90E34472B9D9E30@MN2PR18MB2400.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:265;
X-Forefront-PRVS: 0334223192
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(199004)(189003)(81156014)(81166006)(5660300002)(8676002)(6666004)(54906003)(26005)(956004)(2616005)(4326008)(16526019)(316002)(110136005)(186003)(2906002)(8936002)(86362001)(6512007)(36756003)(478600001)(6486002)(1076003)(66556008)(52116002)(66946007)(66476007)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2400;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oppAOfUypQ2dJhjurYivF09QOgDyuxx35ei1a/m7ly7M3lxEgg2+e5dKXtJvq+8F9Q3HTNFxO76v7x/RlXZyX+Y4wqqak7RDiWpZtHJoSfUzpapY0YB0+WF1dxFfOGk/nngfNzE0yZM5lMVsRouUmbu2mzFl5vVHcHO7NHk4gDh5UefXi7sTXHIO6RW3+1JOMuSt18rg4qRYzxj3Krxp0rSNZuEDEmfWpqVWvnNNdHAbFYqlXp4IDPdms72W9OMGywXQLJ6mN8Y/BO6LkN2Hz/XnCia9oYM4ffGmfyL+IKzxwDk14albf2SFCi+Go41pkHr3EewWpkXaM+tRaHXv/BCUxR1m+zhLHAZLcY3C13tvoisu5u9tKyf5rfvkVaQyGzaquHgTF8IKn9XUUtcCcLJlpyDYM1fPHUvvQM936XEQrNCaxMa0E7+lq7oxECzY
X-MS-Exchange-AntiSpam-MessageData: GtMjLCQP9dnxq3L6NtxS3GQtdWHMUJ4gpyTEmlgkcurngMMmZu9rjYYz0GbxgArdjLi7P7/5JaAXBJjNeUus2FjHmpD7ItSgkVCOcIaq3R77bBluw6RqZ23JwoqBQf9dQDmb2L4Eht289/9uuV5n4Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: a8abb355-04bc-46bf-c87e-08d7c1e0f86f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2020 15:13:48.3823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T4lAO8SjiwCQ63lOvx+wfLd9PK8E440ZCVOm1VoQNZLqtAA/hIzIrLogBPsP3PcaEbQzA2vF7QYdeAmDg4l28w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2400
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-06_04:2020-03-06,2020-03-06 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The struct is used to store temporary data for the dmidecode callback.
Clean this up a bit:

 1) Rename it to something shorter and more reasonable.

 2) Rename member count to index since this is what it is used for.

 3) Move code close to ghes_edac_dmidecode() where it is used.

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/ghes_edac.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 438972dfea09..358519e8c2e9 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -72,11 +72,6 @@ struct memdev_dmi_entry {
 	u16 conf_mem_clk_speed;
 } __attribute__((__packed__));
 
-struct ghes_edac_dimm_fill {
-	struct mem_ctl_info *mci;
-	unsigned int count;
-};
-
 static void ghes_edac_count_dimms(const struct dmi_header *dh, void *arg)
 {
 	int *num_dimm = arg;
@@ -113,18 +108,23 @@ static void ghes_dimm_setup_label(struct dimm_info *dimm, u16 handle)
 			"unknown memory (handle: 0x%.4x)", handle);
 }
 
+struct ghes_dimm_fill {
+	struct mem_ctl_info *mci;
+	int index;
+};
+
 static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
 {
-	struct ghes_edac_dimm_fill *dimm_fill = arg;
+	struct ghes_dimm_fill *dimm_fill = arg;
 	struct mem_ctl_info *mci = dimm_fill->mci;
 
 	if (dh->type == DMI_ENTRY_MEM_DEVICE) {
 		struct memdev_dmi_entry *entry = (struct memdev_dmi_entry *)dh;
-		struct dimm_info *dimm = edac_get_dimm(mci, dimm_fill->count, 0, 0);
+		struct dimm_info *dimm = edac_get_dimm(mci, dimm_fill->index, 0, 0);
 
 		if (entry->size == 0xffff) {
 			pr_info("Can't get DIMM%i size\n",
-				dimm_fill->count);
+				dimm_fill->index);
 			dimm->nr_pages = MiB_TO_PAGES(32);/* Unknown */
 		} else if (entry->size == 0x7fff) {
 			dimm->nr_pages = MiB_TO_PAGES(entry->extended_size);
@@ -197,7 +197,7 @@ static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
 
 		if (dimm->nr_pages) {
 			edac_dbg(1, "DIMM%i: %s size = %d MB%s\n",
-				dimm_fill->count, edac_mem_types[dimm->mtype],
+				dimm_fill->index, edac_mem_types[dimm->mtype],
 				PAGES_TO_MiB(dimm->nr_pages),
 				(dimm->edac_mode != EDAC_NONE) ? "(ECC)" : "");
 			edac_dbg(2, "\ttype %d, detail 0x%02x, width %d(total %d)\n",
@@ -207,7 +207,7 @@ static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
 
 		dimm->smbios_handle = entry->handle;
 
-		dimm_fill->count++;
+		dimm_fill->index++;
 	}
 }
 
@@ -469,7 +469,7 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	struct mem_ctl_info *mci;
 	struct ghes_mci *pvt;
 	struct edac_mc_layer layers[1];
-	struct ghes_edac_dimm_fill dimm_fill;
+	struct ghes_dimm_fill dimm_fill;
 	unsigned long flags;
 	int idx = -1;
 
@@ -536,7 +536,7 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	}
 
 	if (!fake) {
-		dimm_fill.count = 0;
+		dimm_fill.index = 0;
 		dimm_fill.mci = mci;
 		dmi_walk(ghes_edac_dmidecode, &dimm_fill);
 	} else {
-- 
2.20.1

