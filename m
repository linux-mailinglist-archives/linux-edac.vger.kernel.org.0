Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47413F125A
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2019 10:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731508AbfKFJeR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Nov 2019 04:34:17 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:7676 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731754AbfKFJdq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 6 Nov 2019 04:33:46 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA69UIxN002503;
        Wed, 6 Nov 2019 01:33:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=nDutiY8c+N9qGVATOtNYzKTUxT2171TdIFMTe9gi/88=;
 b=nZ1dCOU07UdnLuN2PIrS3e5JvsMsPIrUjm2NDRWmJB0Ls80uvdUBPdfOOxqg4aYLD7xE
 2siNA/AJC3SiJw/8SNhlpYVVctkoQinBkNo0SxtVjm0CCZeUcMny7LFv+nWeo2UFCDhN
 jgKLGoYFCApZUmQv6uiNDw9pi1IUOLxSX1xI9FzLcMq8zm574pLKV5Hj6W2J5nmE5CxA
 vgeM3XHUm+3pJ5x3oTtl9wi53DM8xiIUxf/Cbs8SfRxHOkaCZD9fmXA1L1tEbfVwE3GC
 PvhOiQUt987jE5TeY75Hc2NtnsSiR5sJw4NgHv2c7nrRMlw3bxmCLIyAa7IhNBTxmh9F 2w== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2w3eud3c8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 01:33:34 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 6 Nov
 2019 01:33:33 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.59) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 6 Nov 2019 01:33:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZgNadBay0MQfaFkg9WdwnRae++v39VyV3jGmYXWzo26JnPMAWOnqYf8741oTVC7e8fRU6dAFcbVDlwixLgSoRjaq6okxMZPjrgNYPOICo1mzlBpRAjvywq+ygW4a/eHPRNRUqL9Cr6O8qWVFOoP5z/LBl4Q4udVFSDldux+7Gorf94AM9x+3dXKxgxC02vePo+VREBbfd2jTfBB8rVr4bEX6dYBi0FPww8O1bfgTIcXkCOe82uGA89roDONQXZI0/x0GZOEBqD+4D2xJiDZEANRiKvq7AoooXMdEmsbDrcY/BfFBTi7TYiX7vXbf0NtBljMuPE4l5RfTSoat0SFiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDutiY8c+N9qGVATOtNYzKTUxT2171TdIFMTe9gi/88=;
 b=hr/9jTm/l50pFOqJ867Z1v81IZ7lB3Wb1sM5xG8vQjU9XLnmp4hNPCdk17V/C0/P3Lg7Y5Ojhx3OJ6as9VKvLZDRIjDF29Zqwl+8Peg+1UKMEUfnxOmpr4BxnxJNXAHTm7jOrMy4KL6w4VGm26MSANlLOd8Zj609tpbBsMvoh/ghe7Zjz4MnUJQMNxv1LlrQr7ILBNNl75ikBBGX2lzyL3RmjeYrCNseYbViPCjLmTQdZj3Dq/3CBpnqWAwGPLPlhl0yMfnYykRsWRZupOxsemRerABrFkS2eQgjmP4yrQhYuC/kx7HcYrYk7iHU6qJP4OUxP4sE5RDBLe+eJeJ67A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDutiY8c+N9qGVATOtNYzKTUxT2171TdIFMTe9gi/88=;
 b=fRneUP0Ru4Z4Ag6n9Kx6bZ96aoouiSO1+tytjFRffHcjCpyFLzwE83WZ080/USOL2/UbJtenttS9JsP15sEP7yjoPT2rbsGFAlUBevTONxKCyU3mrXLHnPs0zKba4pgiDkFU2Mb1gae38TqbmLJgAZ2b27E8ZrYppvPG7KH36Xc=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3165.namprd18.prod.outlook.com (10.255.236.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 6 Nov 2019 09:33:32 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6%6]) with mapi id 15.20.2430.020; Wed, 6 Nov 2019
 09:33:32 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 14/20] EDAC, mc: Remove per layer counters
Thread-Topic: [PATCH v2 14/20] EDAC, mc: Remove per layer counters
Thread-Index: AQHVlIVBBrxvjhXd+UiTNn0fviO3ow==
Date:   Wed, 6 Nov 2019 09:33:32 +0000
Message-ID: <20191106093239.25517-15-rrichter@marvell.com>
References: <20191106093239.25517-1-rrichter@marvell.com>
In-Reply-To: <20191106093239.25517-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0287.eurprd05.prod.outlook.com
 (2603:10a6:7:93::18) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c47f5de-b017-4b69-2301-08d7629c63b6
x-ms-traffictypediagnostic: MN2PR18MB3165:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB316596B8D2B0734459452212D9790@MN2PR18MB3165.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(199004)(189003)(52116002)(305945005)(6486002)(76176011)(30864003)(71190400001)(71200400001)(256004)(11346002)(446003)(7736002)(6436002)(4326008)(6512007)(66446008)(66556008)(66476007)(66946007)(64756008)(5660300002)(1076003)(476003)(6116002)(3846002)(110136005)(54906003)(36756003)(2906002)(8676002)(99286004)(81166006)(81156014)(316002)(8936002)(50226002)(486006)(6506007)(386003)(102836004)(66066001)(2616005)(86362001)(478600001)(25786009)(186003)(14454004)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3165;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zHqCYjeDEB1ElwukySQ//Om1lcXE0mT0qmA8GpMw1BCj2jMtybFjEG678Mqv+YvzshR/Wg1x1qJRtDRZMpldlOEhEkn1mvNT0FdKqcJtSB1sp9EoGRHGlRKrYrRdh0PGjNzFWXQ9mrPKduRsx88VtXk+a8UPtwE8UM/DORzL/hbnQveoSDjW0iwOd6cgrmop0AL6h0L5pUbhYFvgO0eRtY7mRRWA97b3Zxfbz63b790kqdK0xlCswOEeIy+1H6tNmcfBPwzLiKRo2YHvx0WQnd9K1t1TDuWw8EqvK6B0OzdvlzISaL53fOu+ornXK//qA44zzhzI4k8TXRX5sYYvHucpoC1mMM/GnMG0bTlhOBog0kw/CpJclWZvgJbiLNhpuPWMvNHCcd+k0aJbwqdWaxX29SLss7QXpMx6VLhtv6R+fxqroVO3nHIt1P5I12AU
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c47f5de-b017-4b69-2301-08d7629c63b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 09:33:32.6913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y4uJDauwnKS4zhx22s20ShcjcdW0K+sn6lNWfZsJvWuix/M48Y2BunzZoDCWwqU+zUKXJM/1BP0Taec+uLwCuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3165
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_02:2019-11-06,2019-11-06 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Looking at how mci->{ue,ce}_per_layer[EDAC_MAX_LAYERS] is used, it
turns out that only the leaves in the memory hierarchy are consumed
(in sysfs), but not the intermediate layers, e.g.:

 count =3D dimm->mci->ce_per_layer[dimm->mci->n_layers-1][dimm->idx];

These unused counters only add complexity, remove them. The error
counter values are directly stored in struct dimm_info now.

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/edac_mc.c       | 106 ++++++++++++-----------------------
 drivers/edac/edac_mc_sysfs.c |  20 +++----
 drivers/edac/ghes_edac.c     |   5 +-
 include/linux/edac.h         |   7 +--
 4 files changed, 47 insertions(+), 91 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index b6032f51338e..dfc17c565d8f 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -315,12 +315,11 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_nu=
m,
 	struct csrow_info *csr;
 	struct rank_info *chan;
 	struct dimm_info *dimm;
-	u32 *ce_per_layer[EDAC_MAX_LAYERS], *ue_per_layer[EDAC_MAX_LAYERS];
 	unsigned int pos[EDAC_MAX_LAYERS];
-	unsigned int idx, size, tot_dimms =3D 1, count =3D 1;
-	unsigned int tot_csrows =3D 1, tot_channels =3D 1, tot_errcount =3D 0;
+	unsigned int idx, size, tot_dimms =3D 1;
+	unsigned int tot_csrows =3D 1, tot_channels =3D 1;
 	void *pvt, *p, *ptr =3D NULL;
-	int i, j, row, chn, n, len;
+	int j, row, chn, n, len;
 	bool per_rank =3D false;
=20
 	if (WARN_ON(n_layers > EDAC_MAX_LAYERS || n_layers =3D=3D 0))
@@ -346,19 +345,10 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_nu=
m,
 	 * stringent as what the compiler would provide if we could simply
 	 * hardcode everything into a single struct.
 	 */
-	mci =3D edac_align_ptr(&ptr, sizeof(*mci), 1);
-	layer =3D edac_align_ptr(&ptr, sizeof(*layer), n_layers);
-	for (i =3D 0; i < n_layers; i++) {
-		count *=3D layers[i].size;
-		edac_dbg(4, "errcount layer %d size %d\n", i, count);
-		ce_per_layer[i] =3D edac_align_ptr(&ptr, sizeof(u32), count);
-		ue_per_layer[i] =3D edac_align_ptr(&ptr, sizeof(u32), count);
-		tot_errcount +=3D 2 * count;
-	}
-
-	edac_dbg(4, "allocating %d error counters\n", tot_errcount);
-	pvt =3D edac_align_ptr(&ptr, sz_pvt, 1);
-	size =3D ((unsigned long)pvt) + sz_pvt;
+	mci	=3D edac_align_ptr(&ptr, sizeof(*mci), 1);
+	layer	=3D edac_align_ptr(&ptr, sizeof(*layer), n_layers);
+	pvt	=3D edac_align_ptr(&ptr, sz_pvt, 1);
+	size	=3D ((unsigned long)pvt) + sz_pvt;
=20
 	edac_dbg(1, "allocating %u bytes for mci data (%d %s, %d csrows/channels)=
\n",
 		 size,
@@ -374,10 +364,6 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num=
,
 	 * rather than an imaginary chunk of memory located at address 0.
 	 */
 	layer =3D (struct edac_mc_layer *)(((char *)mci) + ((unsigned long)layer)=
);
-	for (i =3D 0; i < n_layers; i++) {
-		mci->ce_per_layer[i] =3D (u32 *)((char *)mci + ((unsigned long)ce_per_la=
yer[i]));
-		mci->ue_per_layer[i] =3D (u32 *)((char *)mci + ((unsigned long)ue_per_la=
yer[i]));
-	}
 	pvt =3D sz_pvt ? (((char *)mci) + ((unsigned long)pvt)) : NULL;
=20
 	/* setup index and various internal pointers */
@@ -908,53 +894,31 @@ const char *edac_layer_name[] =3D {
 EXPORT_SYMBOL_GPL(edac_layer_name);
=20
 static void edac_inc_ce_error(struct mem_ctl_info *mci,
-			      bool enable_per_layer_report,
 			      const int pos[EDAC_MAX_LAYERS],
 			      const u16 count)
 {
-	int i, index =3D 0;
+	struct dimm_info *dimm =3D edac_get_dimm(mci, pos[0], pos[1], pos[2]);
=20
 	mci->ce_mc +=3D count;
=20
-	if (!enable_per_layer_report) {
+	if (dimm)
+		dimm->ce_count +=3D count;
+	else
 		mci->ce_noinfo_count +=3D count;
-		return;
-	}
-
-	for (i =3D 0; i < mci->n_layers; i++) {
-		if (pos[i] < 0)
-			break;
-		index +=3D pos[i];
-		mci->ce_per_layer[i][index] +=3D count;
-
-		if (i < mci->n_layers - 1)
-			index *=3D mci->layers[i + 1].size;
-	}
 }
=20
 static void edac_inc_ue_error(struct mem_ctl_info *mci,
-				    bool enable_per_layer_report,
 				    const int pos[EDAC_MAX_LAYERS],
 				    const u16 count)
 {
-	int i, index =3D 0;
+	struct dimm_info *dimm =3D edac_get_dimm(mci, pos[0], pos[1], pos[2]);
=20
 	mci->ue_mc +=3D count;
=20
-	if (!enable_per_layer_report) {
+	if (dimm)
+		dimm->ue_count +=3D count;
+	else
 		mci->ue_noinfo_count +=3D count;
-		return;
-	}
-
-	for (i =3D 0; i < mci->n_layers; i++) {
-		if (pos[i] < 0)
-			break;
-		index +=3D pos[i];
-		mci->ue_per_layer[i][index] +=3D count;
-
-		if (i < mci->n_layers - 1)
-			index *=3D mci->layers[i + 1].size;
-	}
 }
=20
 static void edac_ce_error(struct mem_ctl_info *mci,
@@ -965,7 +929,6 @@ static void edac_ce_error(struct mem_ctl_info *mci,
 			  const char *label,
 			  const char *detail,
 			  const char *other_detail,
-			  const bool enable_per_layer_report,
 			  const unsigned long page_frame_number,
 			  const unsigned long offset_in_page,
 			  long grain)
@@ -988,7 +951,7 @@ static void edac_ce_error(struct mem_ctl_info *mci,
 				       error_count, msg, msg_aux, label,
 				       location, detail);
 	}
-	edac_inc_ce_error(mci, enable_per_layer_report, pos, error_count);
+	edac_inc_ce_error(mci, pos, error_count);
=20
 	if (mci->scrub_mode =3D=3D SCRUB_SW_SRC) {
 		/*
@@ -1018,8 +981,7 @@ static void edac_ue_error(struct mem_ctl_info *mci,
 			  const char *location,
 			  const char *label,
 			  const char *detail,
-			  const char *other_detail,
-			  const bool enable_per_layer_report)
+			  const char *other_detail)
 {
 	char *msg_aux =3D "";
=20
@@ -1048,7 +1010,7 @@ static void edac_ue_error(struct mem_ctl_info *mci,
 			      msg, msg_aux, label, location, detail);
 	}
=20
-	edac_inc_ue_error(mci, enable_per_layer_report, pos, error_count);
+	edac_inc_ue_error(mci, pos, error_count);
 }
=20
 void edac_raw_mc_handle_error(const enum hw_event_mc_err_type type,
@@ -1079,16 +1041,16 @@ void edac_raw_mc_handle_error(const enum hw_event_m=
c_err_type type,
 			"page:0x%lx offset:0x%lx grain:%ld syndrome:0x%lx",
 			e->page_frame_number, e->offset_in_page,
 			e->grain, e->syndrome);
-		edac_ce_error(mci, e->error_count, pos, e->msg, e->location, e->label,
-			      detail, e->other_detail, e->enable_per_layer_report,
+		edac_ce_error(mci, e->error_count, pos, e->msg, e->location,
+			      e->label, detail, e->other_detail,
 			      e->page_frame_number, e->offset_in_page, e->grain);
 	} else {
 		snprintf(detail, sizeof(detail),
 			"page:0x%lx offset:0x%lx grain:%ld",
 			e->page_frame_number, e->offset_in_page, e->grain);
=20
-		edac_ue_error(mci, e->error_count, pos, e->msg, e->location, e->label,
-			      detail, e->other_detail, e->enable_per_layer_report);
+		edac_ue_error(mci, e->error_count, pos, e->msg, e->location,
+			      e->label, detail, e->other_detail);
 	}
=20
=20
@@ -1113,6 +1075,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
type type,
 	int pos[EDAC_MAX_LAYERS] =3D { top_layer, mid_layer, low_layer };
 	int i, n_labels =3D 0;
 	struct edac_raw_error_desc *e =3D &mci->error_desc;
+	bool any_memory =3D true;
=20
 	edac_dbg(3, "MC%d\n", mci->mc_idx);
=20
@@ -1130,9 +1093,9 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
type type,
=20
 	/*
 	 * Check if the event report is consistent and if the memory
-	 * location is known. If it is known, enable_per_layer_report will be
-	 * true, the DIMM(s) label info will be filled and the per-layer
-	 * error counters will be incremented.
+	 * location is known. If it is known, the DIMM(s) label info
+	 * will be filled and the DIMM's error counters will be
+	 * incremented.
 	 */
 	for (i =3D 0; i < mci->n_layers; i++) {
 		if (pos[i] >=3D (int)mci->layers[i].size) {
@@ -1150,7 +1113,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
type type,
 			pos[i] =3D -1;
 		}
 		if (pos[i] >=3D 0)
-			e->enable_per_layer_report =3D true;
+			any_memory =3D false;
 	}
=20
 	/*
@@ -1180,16 +1143,17 @@ void edac_mc_handle_error(const enum hw_event_mc_er=
r_type type,
 			e->grain =3D dimm->grain;
=20
 		/*
-		 * If the error is memory-controller wide, there's no need to
-		 * seek for the affected DIMMs because the whole
-		 * channel/memory controller/...  may be affected.
-		 * Also, don't show errors for empty DIMM slots.
+		 * If the error is memory-controller wide, there's no
+		 * need to seek for the affected DIMMs because the
+		 * whole channel/memory controller/... may be
+		 * affected. Also, don't show errors for empty DIMM
+		 * slots.
 		 */
-		if (!e->enable_per_layer_report || !dimm->nr_pages)
+		if (any_memory || !dimm->nr_pages)
 			continue;
=20
 		if (n_labels >=3D EDAC_MAX_LABELS) {
-			e->enable_per_layer_report =3D false;
+			any_memory =3D true;
 			break;
 		}
 		n_labels++;
@@ -1218,7 +1182,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
type type,
 			chan =3D -2;
 	}
=20
-	if (!e->enable_per_layer_report) {
+	if (any_memory) {
 		strcpy(e->label, "any memory");
 	} else {
 		edac_dbg(4, "csrow/channel to increment: (%d,%d)\n", row, chan);
diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 0367554e7437..8682df2f7f4f 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -556,10 +556,8 @@ static ssize_t dimmdev_ce_count_show(struct device *de=
v,
 				      char *data)
 {
 	struct dimm_info *dimm =3D to_dimm(dev);
-	u32 count;
=20
-	count =3D dimm->mci->ce_per_layer[dimm->mci->n_layers-1][dimm->idx];
-	return sprintf(data, "%u\n", count);
+	return sprintf(data, "%u\n", dimm->ce_count);
 }
=20
 static ssize_t dimmdev_ue_count_show(struct device *dev,
@@ -567,10 +565,8 @@ static ssize_t dimmdev_ue_count_show(struct device *de=
v,
 				      char *data)
 {
 	struct dimm_info *dimm =3D to_dimm(dev);
-	u32 count;
=20
-	count =3D dimm->mci->ue_per_layer[dimm->mci->n_layers-1][dimm->idx];
-	return sprintf(data, "%u\n", count);
+	return sprintf(data, "%u\n", dimm->ue_count);
 }
=20
 /* dimm/rank attribute files */
@@ -666,7 +662,9 @@ static ssize_t mci_reset_counters_store(struct device *=
dev,
 					const char *data, size_t count)
 {
 	struct mem_ctl_info *mci =3D to_mci(dev);
-	int cnt, row, chan, i;
+	struct dimm_info *dimm;
+	int row, chan;
+
 	mci->ue_mc =3D 0;
 	mci->ce_mc =3D 0;
 	mci->ue_noinfo_count =3D 0;
@@ -682,11 +680,9 @@ static ssize_t mci_reset_counters_store(struct device =
*dev,
 			ri->channels[chan]->ce_count =3D 0;
 	}
=20
-	cnt =3D 1;
-	for (i =3D 0; i < mci->n_layers; i++) {
-		cnt *=3D mci->layers[i].size;
-		memset(mci->ce_per_layer[i], 0, cnt * sizeof(u32));
-		memset(mci->ue_per_layer[i], 0, cnt * sizeof(u32));
+	mci_for_each_dimm(mci, dimm) {
+		dimm->ue_count =3D 0;
+		dimm->ce_count =3D 0;
 	}
=20
 	mci->start_time =3D jiffies;
diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 725b9c58c028..74017da1f72c 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -356,11 +356,8 @@ void ghes_edac_report_mem_error(int sev, struct cper_s=
ec_mem_err *mem_err)
 				     mem_err->mem_dev_handle);
=20
 		index =3D get_dimm_smbios_index(mci, mem_err->mem_dev_handle);
-		if (index >=3D 0) {
+		if (index >=3D 0)
 			e->top_layer =3D index;
-			e->enable_per_layer_report =3D true;
-		}
-
 	}
 	if (p > e->location)
 		*(p - 1) =3D '\0';
diff --git a/include/linux/edac.h b/include/linux/edac.h
index 67be279abd11..4d9673954856 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -383,6 +383,9 @@ struct dimm_info {
 	unsigned int csrow, cschannel;	/* Points to the old API data */
=20
 	u16 smbios_handle;              /* Handle for SMBIOS type 17 */
+
+	u32 ce_count;
+	u32 ue_count;
 };
=20
 /**
@@ -453,8 +456,6 @@ struct errcount_attribute_data {
  * @location:			location of the error
  * @label:			label of the affected DIMM(s)
  * @other_detail:		other driver-specific detail about the error
- * @enable_per_layer_report:	if false, the error affects all layers
- *				(typically, a memory controller error)
  */
 struct edac_raw_error_desc {
 	char location[LOCATION_SIZE];
@@ -470,7 +471,6 @@ struct edac_raw_error_desc {
 	unsigned long syndrome;
 	const char *msg;
 	const char *other_detail;
-	bool enable_per_layer_report;
 };
=20
 /* MEMORY controller information structure
@@ -560,7 +560,6 @@ struct mem_ctl_info {
 	 */
 	u32 ce_noinfo_count, ue_noinfo_count;
 	u32 ue_mc, ce_mc;
-	u32 *ce_per_layer[EDAC_MAX_LAYERS], *ue_per_layer[EDAC_MAX_LAYERS];
=20
 	struct completion complete;
=20
--=20
2.20.1

