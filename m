Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9304E1B43A4
	for <lists+linux-edac@lfdr.de>; Wed, 22 Apr 2020 13:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgDVL7T (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 22 Apr 2020 07:59:19 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:55078 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726519AbgDVL7T (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 22 Apr 2020 07:59:19 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03MBq3N0002632;
        Wed, 22 Apr 2020 04:59:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=pfpt0818;
 bh=OVUkuliCuJYoxa2r32d45JPdmZPm20SXxguMDv3BRQI=;
 b=eKZFJ10DVrLKxxeZK4i1LDBEf0Yg+j2wf7wnDrH/QeuQjjyczVex/iPMPx2ooTFRq1bY
 j5wL92K043+Dqr3JlwHVnplhPLW8RMlatz9U2kasHbVlu4f0TsQ8iqsphFDCZvZqOm3h
 1U1kl2JS8hunrDJo7/aXC13Oa60SDHSDOd4CLbPu5upa1kx7+PsxAbf7rhVvgHfqCTkO
 yUsvTyoZfJ15MNwBPXM6cAoS16IgLAnqO71oxzI9qjofA3nuJq95LouRDTTOwTu3ZuQf
 QuBr4jM8jht/S2aD3jxAXSSHURV/Clm+d/fyfzg4wCP47EDRlwuNvnnrdxm51ktbW+PG 2w== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 30fxwph9dv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 22 Apr 2020 04:59:08 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 22 Apr
 2020 04:59:07 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 22 Apr 2020 04:59:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COGivUyXPv2UdYD2HI9wMmGoojp5k3zn/lAeNAqqrIxVxHVOGlxdjKfKaNvS4KbCSwz7Jh4jYZmOev4DIxc6t8AbLzXslvSVn/V+ztEom4dT+IgQUM6b4AL1se6alcMvpYMl8zvLAcAvTY1SWDEknsFQx19ZDTO4MmSJ1fLhHtY2ip0FzX5hvLetXQWF3WO1YPfS1v7eX/I1EBw8cODpaRG9JIJ3yY+64H+RuW+yAF/ZZZNsP0NoTzdmenNDqZvljIxsop9/2fMFMgrx6ZXH4beyV3KQj5EnyNVjxAxUPZinhLvune5R/D+OEX4kxBQ8t6LPLj2pR61MlWKQjc1ZPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVUkuliCuJYoxa2r32d45JPdmZPm20SXxguMDv3BRQI=;
 b=OnW/1bFcbuUN1knX4mYQMnAXli5v/4upaPFvhuJeOnjsh/8uiFvFArwMR7m6gCWWwQM8vXD71rWxWhUBZRpAcfvS30YxICOighEIaR67UVPIbPb9jmj3Iqc7VrATgP+tspYdiUe2HZZAds4/+T0j4XdD3/ZWNhadzTejZqia1jtKJZnH7X6dnUuxjjZWZjF83CIwdo7tYZzCojDlNhOKCkiMC3cyEllrBTYmr+hFwIQFi/mRaJahucr5zrIXhBwAgMqRWfmsRWihYpMR8H54lmvdeS/KY+Y02jLqy14tetB+JZd6XkW2KpP4hJkvDw2EMVnVnFTkzdsNovfr4gZoLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVUkuliCuJYoxa2r32d45JPdmZPm20SXxguMDv3BRQI=;
 b=UR1oS+M2KCeMdFOKHyq8aOGgkMWQtjPKCX0qzddgukPso9oP4AbZSAPVij+KVFcch2tBeuA3rNEzrenYce+lEaRFEmZO7ZyJdLJkiP1t5wtTmGYxxd3vIMKp8FvldZHyPBeXIKMH0T1iK89FNh8ltgRT4YeXT5rrUtxS0PosmAE=
Received: from BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
 by BYAPR18MB2933.namprd18.prod.outlook.com (2603:10b6:a03:10e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Wed, 22 Apr
 2020 11:59:06 +0000
Received: from BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d]) by BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d%7]) with mapi id 15.20.2921.030; Wed, 22 Apr 2020
 11:59:06 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        Matthias Brugger <mbrugger@suse.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 07/10] EDAC/ghes: Cleanup struct ghes_edac_dimm_fill, rename it to ghes_dimm_fill
Date:   Wed, 22 Apr 2020 13:58:11 +0200
Message-ID: <20200422115814.22205-8-rrichter@marvell.com>
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
Received: from rric.localdomain (31.208.96.227) by HE1PR0701CA0076.eurprd07.prod.outlook.com (2603:10a6:3:64::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.6 via Frontend Transport; Wed, 22 Apr 2020 11:59:03 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fedcac11-003c-4ef0-b2e8-08d7e6b48ea7
X-MS-TrafficTypeDiagnostic: BYAPR18MB2933:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR18MB29336D55111F331C0ACA4D8CD9D20@BYAPR18MB2933.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:191;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2661.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(366004)(396003)(39850400004)(376002)(136003)(6512007)(1076003)(6666004)(81156014)(8936002)(4326008)(6486002)(8676002)(2616005)(110136005)(52116002)(186003)(16526019)(86362001)(956004)(6506007)(66476007)(2906002)(66946007)(54906003)(26005)(66556008)(36756003)(5660300002)(478600001)(316002);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x16sueIF1+4AE/ZHEodupo8E5yJmKF76CasUcmiwATovnZo8HKU1zlKyEKO+TpHBzADRxxJQ3xyKYpx+C9fhN1yoyV7NWj0e/u5P5Auu/3+2BdLETCvnnMWHzhmZMgAHl6MMp95SuM61YwGjYklbysSrQurLyU8EH1s9OMbk4K+hoCBPO5rJuXuJwJQVoRYzJwFCOk7eEt6hmrCjWtkw9yTSK1y0aiRRTgEiBfOS7/ZaIx25zBZYRB4XNToxzmoDJ0T2QViDAWskqYJupausqAkbb2dqP/qgFKno0li/XZg7R5UOHK5cgcgazjhc/XCMDwZsS4HsKp7a/NeXPQxKSTZShZI5j9GBl8qev1QnZ9XOYm0nsap19r2WTFlU19C//7O0VcTjsFrnIB6w4PSxuddINLzx+K0W2kjptCT+IC5FMzaex1AeMVOI6LI4XBCT
X-MS-Exchange-AntiSpam-MessageData: VBxFUPGGaDO+GOrwd07ur5bTzXS6JwOIIOntG3wDXUOyoxIuRefUkKVUetvqusk205QQOsZ5HYv3PIx40IsbjeZc8kCsbdL4h/ZiJrFw9ePvnftJAYiP7nKfexbAI/U5moZqWmAr7/VbJIBIYJlQKg==
X-MS-Exchange-CrossTenant-Network-Message-Id: fedcac11-003c-4ef0-b2e8-08d7e6b48ea7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 11:59:06.1359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Be/PAXAgDtyZlzDSPh1173ijDgyNCJS33XuzhvpMwUEsnnGdn0Ueup4dbCTNjOatlgdCkm1LcRyhYQXQCFOpTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2933
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-22_03:2020-04-22,2020-04-22 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The struct is used to store temporary data for the dmidecode callback.
Clean this up a bit:

 1) Rename member count to index since this is what it is used for.

 2) Move code close to ghes_edac_dmidecode() where it is used.

 3) While at it, use edac_get_dimm_by_index().

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/ghes_edac.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 038e560fd332..4eadc5b344c8 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -88,12 +88,6 @@ struct memdev_dmi_entry {
 	u16 conf_mem_clk_speed;
 } __attribute__((__packed__));
 
-struct dimm_fill {
-	struct list_head dimms;
-	struct mem_ctl_info *mci;
-	unsigned int count;
-};
-
 static int ghes_dimm_pool_create(int num_dimm)
 {
 	struct ghes_dimm *ghes_dimm;
@@ -182,6 +176,12 @@ static void ghes_dimm_setup_label(struct dimm_info *dimm, u16 handle)
 			"unknown memory (handle: 0x%.4x)", handle);
 }
 
+struct dimm_fill {
+	struct list_head dimms;
+	struct mem_ctl_info *mci;
+	int index;
+};
+
 static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
 {
 	struct dimm_fill *dimm_fill = arg;
@@ -190,11 +190,11 @@ static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
 
 	if (dh->type == DMI_ENTRY_MEM_DEVICE) {
 		struct memdev_dmi_entry *entry = (struct memdev_dmi_entry *)dh;
-		struct dimm_info *dimm = edac_get_dimm(mci, dimm_fill->count, 0, 0);
+		struct dimm_info *dimm = edac_get_dimm_by_index(mci, dimm_fill->index);
 
 		if (entry->size == 0xffff) {
 			pr_info("Can't get DIMM%i size\n",
-				dimm_fill->count);
+				dimm_fill->index);
 			dimm->nr_pages = MiB_TO_PAGES(32);/* Unknown */
 		} else if (entry->size == 0x7fff) {
 			dimm->nr_pages = MiB_TO_PAGES(entry->extended_size);
@@ -267,7 +267,7 @@ static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
 
 		if (dimm->nr_pages) {
 			edac_dbg(1, "DIMM%i: %s size = %d MB%s\n",
-				dimm_fill->count, edac_mem_types[dimm->mtype],
+				dimm_fill->index, edac_mem_types[dimm->mtype],
 				PAGES_TO_MiB(dimm->nr_pages),
 				(dimm->edac_mode != EDAC_NONE) ? "(ECC)" : "");
 			edac_dbg(2, "\ttype %d, detail 0x%02x, width %d(total %d)\n",
@@ -280,7 +280,7 @@ static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
 		if (ghes_dimm)
 			list_add_tail(&ghes_dimm->entry, &dimm_fill->dimms);
 
-		dimm_fill->count++;
+		dimm_fill->index++;
 	}
 }
 
@@ -614,11 +614,11 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	INIT_LIST_HEAD(&dimm_fill.dimms);
 
 	if (!fake) {
-		dimm_fill.count = 0;
+		dimm_fill.index = 0;
 		dimm_fill.mci = mci;
 		dmi_walk(ghes_edac_dmidecode, &dimm_fill);
 	} else {
-		struct dimm_info *dimm = edac_get_dimm(mci, 0, 0, 0);
+		struct dimm_info *dimm = edac_get_dimm_by_index(mci, 0);
 
 		dimm->nr_pages = 1;
 		dimm->grain = 128;
-- 
2.20.1

