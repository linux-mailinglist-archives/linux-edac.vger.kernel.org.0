Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F845D320F
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2019 22:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfJJU0Y (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Oct 2019 16:26:24 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:8924 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726533AbfJJUZ3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 10 Oct 2019 16:25:29 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9AKPMdM029873;
        Thu, 10 Oct 2019 13:25:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=w9guKr/08ubmt7IJxh9IGAibAwOTlUnbhIGpJ9pcE6I=;
 b=EoAPRiXv+cKRPnnMwqM9+n/s48O7SWNvK4CK3qPzjdyWhzWiE7g4QzFh0Ilgf0C3QMNs
 PnO/WHS5e6cL2j/CagHcXwhdgiDSRk/8CnKVU6Uzj4jhUu/sL5vpL2WOMGheRqOS2hPc
 DFQ1Snk01s1UtJ4vekuMl9y/jsuuZx3BBFZU3un+xd1pTFPVJGwKl+gH5HclHnSXnmI5
 8VhT5/7t4TgmhFZjqvcG0uLssYxdGvEk3MZ8LsdA0bLxOSuH0v58flhGddGfEaISIIf5
 toCjp6ioS7BEfbzHZWtprJlTrhN4lLzpTg3+jPZrxc6b4+wsUsnreboRbikozpGTXF4N 1w== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2vhdxbxqg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 10 Oct 2019 13:25:21 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 10 Oct
 2019 13:25:18 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.59) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 10 Oct 2019 13:25:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWrmkRZtzwc/HZb/BxOA+VobJCUmaXs0rpfFuAmEtXf1Z/k4nP85FSohH9kEyvBaqNndyXgTdyb472uR8HknH+fyCb/+hjabvhWBdpLzAnm+YkJKWNeLrY9iKv4/OrTdh1bHW0Qmy2zjLvg4kI+WOxmE12993aG/o24EjAnEWa59wJ6R24+09Ox3GDz9zvoTgOOr206SAHZyUABXnXJUmAUbFWOv9NDW2dXPhK0v5WTh+HRbGKVheY//isCGc8YZZPY+gwhxVTq50FqilmEyxdi8vx852R89Gy5HkjF+0J7OR4jBhU57q/umB3sb6SEm3XNmTFx31/7NQApHkzjRjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9guKr/08ubmt7IJxh9IGAibAwOTlUnbhIGpJ9pcE6I=;
 b=mTpCkMF94RJXh86UMw21V5xuJOGH8Ut92TrqH7QuFbHb4XRiVsTi7PRzUi9WOMmoLadaKrh56tkGsWyCB6fRrsENhsM+6lHbainMiw4xk9mjE5w1Boh2ja4/5kHiic085Fs9RSHMbD9COhQeGV7/0dWh+vF1tJUcK0wawd8HA13fPb76+lajDPO/Y+pAALTZUIkILmHcpLrV5h/ItZqnZ7WdZdRof0+DVbPAZstiGSIbMXWYF0N1CkkB22TBDLNcw42tNj3sPtsTqddDefdIDjtDvr0aBdZNj8SMiqCcQEH8RqDcynbJvM2x/1L51PDUjiJcgvJ1hl1shfJJRQ40Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9guKr/08ubmt7IJxh9IGAibAwOTlUnbhIGpJ9pcE6I=;
 b=w8IiWAW6yD/IB6mvYHDJcpWkyE2+lh+t2OoolMC87jL3rzrdFM24yKayUoSgsjk5q4dhu95e5tqTC48FcB+CQ7yfMCMLB33hRYnZK6HWWmclLQMVvESwNJ+2VEepfA+cFu5h659pY/H7trj1DUq+iPx0DykswboMDficqvwmTtc=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2701.namprd18.prod.outlook.com (20.179.22.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Thu, 10 Oct 2019 20:25:16 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763%3]) with mapi id 15.20.2327.026; Thu, 10 Oct 2019
 20:25:16 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 06/19] EDAC, mc: Remove per layer counters
Thread-Topic: [PATCH 06/19] EDAC, mc: Remove per layer counters
Thread-Index: AQHVf6jU3Hq1HIO940WaZOfHTRxydA==
Date:   Thu, 10 Oct 2019 20:25:16 +0000
Message-ID: <20191010202418.25098-7-rrichter@marvell.com>
References: <20191010202418.25098-1-rrichter@marvell.com>
In-Reply-To: <20191010202418.25098-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0336.eurprd05.prod.outlook.com
 (2603:10a6:7:92::31) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 144baca6-259a-458d-5d8b-08d74dbff672
x-ms-traffictypediagnostic: MN2PR18MB2701:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB2701B92834DA6F2CFB6F6185D9940@MN2PR18MB2701.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 018632C080
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39850400004)(346002)(136003)(366004)(376002)(189003)(199004)(6436002)(6512007)(54906003)(71190400001)(110136005)(14454004)(316002)(6486002)(86362001)(71200400001)(5660300002)(2906002)(66066001)(25786009)(50226002)(478600001)(11346002)(446003)(476003)(486006)(3846002)(6116002)(2616005)(99286004)(30864003)(1076003)(6506007)(76176011)(4326008)(386003)(7736002)(305945005)(52116002)(26005)(256004)(102836004)(81166006)(66946007)(36756003)(186003)(81156014)(66446008)(66556008)(8936002)(64756008)(8676002)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2701;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SzHzf+vr9iEJxj8jdjBDab2pCjH0LEXgWOfwm+/xKKN0QpSKSJpI5u77ijgm4q+HkMl7xFnfNw0xwBbNfVtRb3uMGbP9QcJ0zymqSfl12ATLwNc+l0aUWiI4eA9txfTkpDUC5C7pqsA72/ApHnV1AR+OgkSsOQFvfX2H+GW8G/+oBPHoi8P/hUyeSi08z76WY7ekqwDWpRwg4mCuBmzjgLpPZKMRlDR2y3jiKRTGYT5yEA83r8iZD1EwbmGNN+4Q+I4Wkng+4AorpFCouUNhlSU7Y+MbDJasqFPB0T7QEHjbcBjOpQOGirF6GxalZS9q84k65NCkyokCuf+iYhgg1/PbtvDc/2suIlT8rESbEQQFkHzhoy+tA8Scfuv5RDfTR50jsCEd0nyp35ru35sOciudDFXp6JVg+6rid72xDEk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 144baca6-259a-458d-5d8b-08d74dbff672
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 20:25:16.7515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aIA+A7OxY7Kk+I/yxFNYHkrbUMcoZxeOje1lyKheiIWne4kU59zkhmtaUddm1eHt+ETNU8iEJVuOQt3Eg5pM6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2701
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-10_07:2019-10-10,2019-10-10 signatures=0
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
 drivers/edac/edac_mc.c       | 104 ++++++++++++-----------------------
 drivers/edac/edac_mc_sysfs.c |  20 +++----
 drivers/edac/ghes_edac.c     |   5 +-
 include/linux/edac.h         |   7 +--
 4 files changed, 46 insertions(+), 90 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 45b02bb31964..c1e142643006 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -315,10 +315,9 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num=
,
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
 	int i, j, row, chn, n, len;
 	bool per_rank =3D false;
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
@@ -1064,16 +1026,16 @@ void edac_raw_mc_handle_error(const enum hw_event_m=
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
@@ -1099,6 +1061,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
type type,
 	int i, n_labels =3D 0;
 	u8 grain_bits;
 	struct edac_raw_error_desc *e =3D &mci->error_desc;
+	bool any_memory =3D true;
=20
 	edac_dbg(3, "MC%d\n", mci->mc_idx);
=20
@@ -1116,9 +1079,9 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
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
@@ -1136,7 +1099,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
type type,
 			pos[i] =3D -1;
 		}
 		if (pos[i] >=3D 0)
-			e->enable_per_layer_report =3D true;
+			any_memory =3D false;
 	}
=20
 	/*
@@ -1166,16 +1129,17 @@ void edac_mc_handle_error(const enum hw_event_mc_er=
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
@@ -1205,7 +1169,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
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
index 842080d7b33a..e0b90c6d7d63 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -347,11 +347,8 @@ void ghes_edac_report_mem_error(int sev, struct cper_s=
ec_mem_err *mem_err)
 				     mem_err->mem_dev_handle);
=20
 		index =3D get_dimm_smbios_index(mem_err->mem_dev_handle);
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
index 8beb6e834be9..8e72222e50b0 100644
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
 	/*
@@ -475,7 +476,6 @@ struct edac_raw_error_desc {
 	unsigned long syndrome;
 	const char *msg;
 	const char *other_detail;
-	bool enable_per_layer_report;
 };
=20
 /* MEMORY controller information structure
@@ -565,7 +565,6 @@ struct mem_ctl_info {
 	 */
 	u32 ce_noinfo_count, ue_noinfo_count;
 	u32 ue_mc, ce_mc;
-	u32 *ce_per_layer[EDAC_MAX_LAYERS], *ue_per_layer[EDAC_MAX_LAYERS];
=20
 	struct completion complete;
=20
--=20
2.20.1

