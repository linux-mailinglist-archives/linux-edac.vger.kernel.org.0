Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613111D9497
	for <lists+linux-edac@lfdr.de>; Tue, 19 May 2020 12:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbgESKpn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 19 May 2020 06:45:43 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:50342 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728675AbgESKpm (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Tue, 19 May 2020 06:45:42 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04JAeUiC030302;
        Tue, 19 May 2020 03:45:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=pfpt0818;
 bh=3goDE3ssYNCKrYs7A6T5G4XmNzhTU+H7VajfjPnbkWA=;
 b=A+lW433MACmQ7fwLxK4GaT8cDdXhsH5xTYWG1mH57mKrTrizLatFPFabBhYFsh+uCEGk
 qdBHJgW2/xFpn0NFJnTdWtyI9dbyQd2rvhgIgTd70ZDdy0knXhc72bVWkfZe8YswVUiD
 nFZizvgdX2HlafTnolXx+IPLFJdAOuBO+CGzlQd7X8PNKYjuU3q3LH5ZtWmS/mCivPcZ
 mrMgmm4yabE0nFhKfi82iuH+LTqi4KjYTvp8IrW9DGASbZSCyN0a7JLjubsUARV5kN9I
 OZuq1nH3/VvKKN7HNozpRJzMmBGHohnnb95N2IKtyttZKs3kGvhY86/qx3uOWEb9POum Ng== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 312fpp2ybm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 19 May 2020 03:45:25 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 19 May
 2020 03:45:23 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 19 May 2020 03:45:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYlTXHDEuUscaSEvUjGxtgZZivDvKCfamvR1AUltbXwvcYRroSWyYd5rCOlLjQHdgzVY70JwD6L1TYZJLpW3pm2CF8GJ8MsbNnugJnH8Sl++3+EBwZ6kFLLjUUUZ4TejOIItgoXlKXBORdYOLpUXzGlZ1AnmAWAz1yX1/I1hl7pu0cqWjRENLJoUJdBSeWUZsAfmLxupL1e8fCk7hgi5lCs0RLutbpRiXulZ2SRkbARQRin4zCYm7bwVj1eSEH32LhguCMaEdfocsMNaehXhO3q3G/1GBfHr+lpxOfiNPMr3J+Qoj8QbwftPesYD/biYTR9AprckV/G8BJqrVE7uhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3goDE3ssYNCKrYs7A6T5G4XmNzhTU+H7VajfjPnbkWA=;
 b=KZvj5kPkH5vFJ93IiZ1YXzaFTfUxOR9+temou0nWy08pknc9GjyD/6iQUl1UZ5XHK/5teZI8cRcXiazdPWsytt6UiPIOCeJMMFqoBhLm8I04E9ciiPnl6R3MavQ2Kyq85EH5guqOA8BaFOadFsSfoUwaDKmgfTH/HemlOoKdfLy+oJkHmrXjJrGRmIWp6KkqFE5LKtshk7QVz2S3+0S2B0lNsRio6IuUqgE2HNDFzEgZjWXMYLiUOW6fuvwY7x4P6StNxft+TdDJenATO41sDcbJUoldho4T3DLho0HSNbyxxJ1dzTQK1C0wf9EHJHaEYZqwoHXb86qZN1/AgsEIQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3goDE3ssYNCKrYs7A6T5G4XmNzhTU+H7VajfjPnbkWA=;
 b=GklB5EyK4zILj5jOo8Ozwi/HbdHdczvNdLcO7BpAYnbj97XQS0gk0z6rTKh+uZOf9/l4Vr/kU02/KHf3f/0Mv0ikGMKb4O+lWEqvOyj1pMO4UYs6hwzOAys/TT6XdevApDUQPle41x4GzFHD/gbzuRwEBiaTS01cklIjYbM32Rw=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=marvell.com;
Received: from BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
 by BYAPR18MB2455.namprd18.prod.outlook.com (2603:10b6:a03:132::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Tue, 19 May
 2020 10:45:22 +0000
Received: from BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d]) by BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d%7]) with mapi id 15.20.3021.020; Tue, 19 May 2020
 10:45:22 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        Matthias Brugger <mbrugger@suse.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/5] EDAC/ghes: Cleanup struct dimm_fill
Date:   Tue, 19 May 2020 12:44:40 +0200
Message-ID: <20200519104443.15673-3-rrichter@marvell.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200519104443.15673-1-rrichter@marvell.com>
References: <20200519104443.15673-1-rrichter@marvell.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1P189CA0023.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::36)
 To BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1P189CA0023.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24 via Frontend Transport; Tue, 19 May 2020 10:45:20 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a82a9aea-c59f-4b9b-b8d6-08d7fbe1bb30
X-MS-TrafficTypeDiagnostic: BYAPR18MB2455:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR18MB2455414DF75EDA49FB0E51B7D9B90@BYAPR18MB2455.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:326;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JlER1HU1taNiTJ3Mu2wgOjbGRYFHi0bJG05AgHd3I3jX9+JYK1hr3qLGSUV/RK9E+r5eqnWSpVSkd3Q1NTmYoseFjM2Spthph7uSsw64EtxKAFRTWmihUwb0plD8BSWdiO51LbErua5tBfa0+Z4SGCstRyDq3ZH1TYpCEeXqAAVzUEZBwNYy3fP3M9RDyXdtoeC2flMO5l/o4iOUDFP7SMxMcA7m10eKBMiJSCShOfGp7bhSYE0hPjIGfUbHO/jXHtsgDjOtnXNlD4mGBv7JwylO0NLDvGg7p/4903+tNLLd2YkDjtPt1lW2ggPVfZJS2dnVlBVrPtbBp1T5aHT27n8a+gNVN3M9WKYfwdchzWHCpntlrj6lchJArnqvEPeYyidJf5bjsVWLQpYl+YsP0bmAmfifti5V6BwQH1oW99rjiePte6e2HD2zTtbvRjn9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2661.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(186003)(316002)(16526019)(6666004)(956004)(2616005)(36756003)(8936002)(110136005)(86362001)(66946007)(6486002)(54906003)(26005)(5660300002)(6506007)(66556008)(6512007)(66476007)(52116002)(478600001)(8676002)(1076003)(4326008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: pW30Cxza0dKqD5JfG6ghXwI33/B+rw9KR9mF1bmIUPi4IzmRmf8qzGfU0CCM8glsiudcj7AN+gf/nSBehuMY2U6Mvdi4bN5URVXsQ0MgZtisLc1oaGsvtdIpdKhqlOu6HdgCRW3AcCd243k0DDlj0lgEdw4ZyDLi5FFaMDw27IgNwt3bZBTxB8Y0geN7ri30pweBRrexVQY2CQrPaQevS1jhvK5zDsyXpqODTpGWGKL9Hb04M6VZ3EWqtQOKEFcwSUQatvLrelj2bQlbmPzGoTyJ0WG3J0xny4Tv0IRGXARq17QM+nnCw2LDSlxNZ1wQkvD5LeB0XoE13OHgML54RZcZoa+fk7KHCHT4Wv8dGvQTLfbTTiT62ZOJX7txdPAxQ2T5EfIjy9TSwFP/0ECoyaK/UMv0HPBPckr1VS6Gx+YMHGSS2Q29fkaRpmTuhUfioCeHePYMZ69t4uGTeRYfPiVCuJ8ArKV+xeq4kGd/5TY=
X-MS-Exchange-CrossTenant-Network-Message-Id: a82a9aea-c59f-4b9b-b8d6-08d7fbe1bb30
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 10:45:22.5239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ed+GiAVJnBRi9aex8h6zmrKoJsabu4gpVYA3tg1uqUALx6QIY1ugXvPUl9h41cNmIb7RYZOuKGnCe1i3ojIQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2455
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-19_03:2020-05-19,2020-05-19 signatures=0
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
 drivers/edac/ghes_edac.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 2ed48a5d48d6..b72fe10b84d4 100644
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
@@ -112,19 +107,24 @@ static void dimm_setup_label(struct dimm_info *dimm, u16 handle)
 			"unknown memory (handle: 0x%.4x)", handle);
 }
 
+struct dimm_fill {
+	struct mem_ctl_info *mci;
+	int index;
+};
+
 static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
 {
-	struct ghes_edac_dimm_fill *dimm_fill = arg;
+	struct dimm_fill *dimm_fill = arg;
 	struct mem_ctl_info *mci = dimm_fill->mci;
 
 	if (dh->type == DMI_ENTRY_MEM_DEVICE) {
 		struct memdev_dmi_entry *entry = (struct memdev_dmi_entry *)dh;
-		struct dimm_info *dimm = edac_get_dimm(mci, dimm_fill->count, 0, 0);
+		struct dimm_info *dimm = edac_get_dimm_by_index(mci, dimm_fill->index);
 		u16 rdr_mask = BIT(7) | BIT(13);
 
 		if (entry->size == 0xffff) {
 			pr_info("Can't get DIMM%i size\n",
-				dimm_fill->count);
+				dimm_fill->index);
 			dimm->nr_pages = MiB_TO_PAGES(32);/* Unknown */
 		} else if (entry->size == 0x7fff) {
 			dimm->nr_pages = MiB_TO_PAGES(entry->extended_size);
@@ -196,7 +196,7 @@ static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
 
 		if (dimm->nr_pages) {
 			edac_dbg(1, "DIMM%i: %s size = %d MB%s\n",
-				dimm_fill->count, edac_mem_types[dimm->mtype],
+				dimm_fill->index, edac_mem_types[dimm->mtype],
 				PAGES_TO_MiB(dimm->nr_pages),
 				(dimm->edac_mode != EDAC_NONE) ? "(ECC)" : "");
 			edac_dbg(2, "\ttype %d, detail 0x%02x, width %d(total %d)\n",
@@ -206,7 +206,7 @@ static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
 
 		dimm->smbios_handle = entry->handle;
 
-		dimm_fill->count++;
+		dimm_fill->index++;
 	}
 }
 
@@ -468,7 +468,7 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	struct mem_ctl_info *mci;
 	struct ghes_pvt *pvt;
 	struct edac_mc_layer layers[1];
-	struct ghes_edac_dimm_fill dimm_fill;
+	struct dimm_fill dimm_fill;
 	unsigned long flags;
 	int idx = -1;
 
@@ -535,11 +535,11 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	}
 
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

