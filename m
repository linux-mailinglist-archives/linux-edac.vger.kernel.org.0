Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA286113E45
	for <lists+linux-edac@lfdr.de>; Thu,  5 Dec 2019 10:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbfLEJil (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 5 Dec 2019 04:38:41 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:16036 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729280AbfLEJiT (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 5 Dec 2019 04:38:19 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB59avmB023516;
        Thu, 5 Dec 2019 01:38:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=7QCxQf32pX5GTSWyiY2ZvY/59cTZ0aadsulEaPBkvR8=;
 b=kXjORx3kQDN2gqTrrhiJjXH+bjQlf81rbkv1LaR4kU6dQ8noJqrIutrouX66jhJI9u7Y
 W2eJELkedX1ZQ1DCd1yHw1lzZYKDBBXo7oOPYwmg1BSmXCKAdBEUX8pNgev7BRA5bmVV
 CzIr2dwPELG6UmmE/kA25YFipan6mn7VG38QXIsXk/8mkK5V9ogbGnvqM/vRRvWsdLwZ
 oy6bHj/GXO2eVe2ERc+Ov72BOFcaIGY2uXYWTu0Yofgco0vDTQ8HyoR+Rj1gi/tHFX4R
 OzJ4VOOrQQtLGqSAhfPbxYPL4pEcv3Db3vcP2oGivQsHxg/t2H0499cKrM/BsdyiLKiB ug== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2wnvgvrd0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 05 Dec 2019 01:38:12 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 5 Dec
 2019 01:38:11 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.55) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 5 Dec 2019 01:38:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTiZfwMEF12prDRJrecbeOEdISgzR0e5sPglUcG5GICbifXO+5R3/M6qG843Wgho3j6M1vdjd3BII0UdJSbCo8UnefNr1dr2HqhGt/2jf5+qkUKahrCQ1DsVN0GxU08KYMtcyBfiK+xaPSTI1kLR8WwGL+Z3cg1LbQs8i/+TuoWZx8MBC5a9lfBsUUHQDe5hV46Eu5LSdd0KiD7IG7oGr7Tso3uFRxSshBrcko05BqbFpJRP+FoLIuWlx+yM9LNi21z5zI2rY+zkvhdLfZG4YCqzX4SXxPUCP5QiN2S2a6+4ib6BQo8TVvd/t2qGTvJJLHhRlanQE74JtvJExanCUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QCxQf32pX5GTSWyiY2ZvY/59cTZ0aadsulEaPBkvR8=;
 b=OHPp+dOz7gcE80asxd5NGPHjhacobbs93KCaxxYHge2WnCiLceq8YhAb2s8FacQn51bKlBUsXG3uxIkuElzz3s8Qjw4rGLLfqJHtDjGGY3MZf9+p0UCPqDPLH4MwSDpttzfKrBQtbSOeS27FpyQGfIfywbn5BzFo6le2AJN65sPF08JXpw8cwOVGKg0+hpGkCFKw5fJg972gx+2n4Q1GDhFYeGhbhQkbef/K+000DoEeeUael26TJIEysuSKVYXSq/UZTJO2mHKrAZS0ETqLsYKUG5UhBNv4nHHkvsvFWyTDiIhK0XX01f9qdKs9YhKnqkyksn3OeX3qHQEZpiXQvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QCxQf32pX5GTSWyiY2ZvY/59cTZ0aadsulEaPBkvR8=;
 b=jqqEQUm8ZwBskL3yoxPRZ5stLVo7UmW/DL6oSUi9vB3WQzZgZz4JGxYkhAIVZkcw13wrHm6zacn3Y0olMOJqMwW1H+p+oF4zulqL138nu4JrYELKaq/itZD6zmH9e6YUSmEuJXb5VUtlgyRS70LsYQr+P0N2WzmmRD629D6Z0YY=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2367.namprd18.prod.outlook.com (20.179.80.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Thu, 5 Dec 2019 09:38:10 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106%7]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 09:38:10 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 07/10] EDAC/mc: Remove enable_per_layer_report function
 arguments
Thread-Topic: [PATCH v2 07/10] EDAC/mc: Remove enable_per_layer_report
 function arguments
Thread-Index: AQHVq0+0Niy4TymAK06bA7H1VLoYzw==
Date:   Thu, 5 Dec 2019 09:38:10 +0000
Message-ID: <20191205093739.4040-8-rrichter@marvell.com>
References: <20191205093739.4040-1-rrichter@marvell.com>
In-Reply-To: <20191205093739.4040-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0170.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::18) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ad335bf-fda5-4cf9-33ed-08d77966d752
x-ms-traffictypediagnostic: MN2PR18MB2367:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB2367BF2E4DA0B754CDE1AC6BD95C0@MN2PR18MB2367.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(189003)(199004)(81166006)(14454004)(36756003)(6512007)(316002)(478600001)(54906003)(5660300002)(110136005)(186003)(8936002)(50226002)(6486002)(26005)(99286004)(66556008)(66476007)(81156014)(71190400001)(86362001)(66946007)(66446008)(64756008)(25786009)(8676002)(2906002)(71200400001)(6506007)(4326008)(2616005)(11346002)(102836004)(305945005)(1076003)(76176011)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2367;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GJaneQdJ+ye+CQkQWSBc52Ji3wRI+bSoMSHUTt0E5SAR2hDjKcg9ufawdUgzSZHQ24Y2khwCeWNTKLA5AxUO9bljq58Q/27Hxw+t9l9dZrxK0aj+kkQG9nFhF67OB24nS4zaWVPcHGBAwPyzRgFzQrVP6pZDtsei/iBcSAij1mS2tHePqaAW3cRiojjR9DhJt2PYgxWmo8OplDuexnj64iPTzJfDkeeMqisL3W7yzprEPkPHJ7O722l9R9IilfrMuvjP3favu9HR37WZ8B5oYCVJU4lHMKwsb0RM3//7P6OGH0A93HPVv1wpakBplv75WYbINRfqFqGPslGsV2Alz82eWyCGVOQpj0fiaqFI3KXS9Fhyv6G7GxTXmI01b6FjGMVfTvysPozms5CHHFC2PlbzdCOURHXoUXrYqc2vi1iCwP77pXkTO6tQSyDFKSyW
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad335bf-fda5-4cf9-33ed-08d77966d752
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 09:38:10.5246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dKjhof8Mp+YM9FFxIV3FLGRq7gFETmRpepNungfAp7I5hZH9/38vz26PRqYPk8q3MP5UQWB09ph8DvtpLR+7rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2367
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-05_01:2019-12-04,2019-12-05 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Many functions carry the enable_per_layer_report argument. This is a
bool value indicating the error information contains some location
data where the error occurred. This can easily being determined by
checking the pos[] array for values. Negative values indicate there is
no location available. So if the top layer is negative, the error
location is unknown.

Just check if the top layer is negative and remove
enable_per_layer_report as function argument and also from struct
edac_raw_error_desc.

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/edac_mc.c   | 42 +++++++++++++++++++---------------------
 drivers/edac/ghes_edac.c |  5 +----
 include/linux/edac.h     |  3 ---
 3 files changed, 21 insertions(+), 29 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 2b12320ce2f1..38a9a68eebfe 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -946,7 +946,6 @@ const char *edac_layer_name[] =3D {
 EXPORT_SYMBOL_GPL(edac_layer_name);
=20
 static void edac_inc_ce_error(struct mem_ctl_info *mci,
-			      bool enable_per_layer_report,
 			      const int pos[EDAC_MAX_LAYERS],
 			      const u16 count)
 {
@@ -954,7 +953,7 @@ static void edac_inc_ce_error(struct mem_ctl_info *mci,
=20
 	mci->ce_mc +=3D count;
=20
-	if (!enable_per_layer_report) {
+	if (pos[0] < 0) {
 		mci->ce_noinfo_count +=3D count;
 		return;
 	}
@@ -971,7 +970,6 @@ static void edac_inc_ce_error(struct mem_ctl_info *mci,
 }
=20
 static void edac_inc_ue_error(struct mem_ctl_info *mci,
-				    bool enable_per_layer_report,
 				    const int pos[EDAC_MAX_LAYERS],
 				    const u16 count)
 {
@@ -979,7 +977,7 @@ static void edac_inc_ue_error(struct mem_ctl_info *mci,
=20
 	mci->ue_mc +=3D count;
=20
-	if (!enable_per_layer_report) {
+	if (pos[0] < 0) {
 		mci->ue_noinfo_count +=3D count;
 		return;
 	}
@@ -1003,7 +1001,6 @@ static void edac_ce_error(struct mem_ctl_info *mci,
 			  const char *label,
 			  const char *detail,
 			  const char *other_detail,
-			  const bool enable_per_layer_report,
 			  const unsigned long page_frame_number,
 			  const unsigned long offset_in_page,
 			  long grain)
@@ -1026,7 +1023,7 @@ static void edac_ce_error(struct mem_ctl_info *mci,
 				       error_count, msg, msg_aux, label,
 				       location, detail);
 	}
-	edac_inc_ce_error(mci, enable_per_layer_report, pos, error_count);
+	edac_inc_ce_error(mci, pos, error_count);
=20
 	if (mci->scrub_mode =3D=3D SCRUB_SW_SRC) {
 		/*
@@ -1056,8 +1053,7 @@ static void edac_ue_error(struct mem_ctl_info *mci,
 			  const char *location,
 			  const char *label,
 			  const char *detail,
-			  const char *other_detail,
-			  const bool enable_per_layer_report)
+			  const char *other_detail)
 {
 	char *msg_aux =3D "";
=20
@@ -1086,7 +1082,7 @@ static void edac_ue_error(struct mem_ctl_info *mci,
 			      msg, msg_aux, label, location, detail);
 	}
=20
-	edac_inc_ue_error(mci, enable_per_layer_report, pos, error_count);
+	edac_inc_ue_error(mci, pos, error_count);
 }
=20
 static void edac_inc_csrow(struct edac_raw_error_desc *e, int row, int cha=
n)
@@ -1136,16 +1132,16 @@ void edac_raw_mc_handle_error(struct edac_raw_error=
_desc *e)
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
@@ -1170,6 +1166,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
type type,
 	int pos[EDAC_MAX_LAYERS] =3D { top_layer, mid_layer, low_layer };
 	int i, n_labels =3D 0;
 	struct edac_raw_error_desc *e =3D &mci->error_desc;
+	bool any_memory =3D true;
=20
 	edac_dbg(3, "MC%d\n", mci->mc_idx);
=20
@@ -1188,9 +1185,9 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
type type,
=20
 	/*
 	 * Check if the event report is consistent and if the memory
-	 * location is known. If it is known, enable_per_layer_report will be
-	 * true, the DIMM(s) label info will be filled and the per-layer
-	 * error counters will be incremented.
+	 * location is known. If it is known, the DIMM(s) label info
+	 * will be filled and the per-layer error counters will be
+	 * incremented.
 	 */
 	for (i =3D 0; i < mci->n_layers; i++) {
 		if (pos[i] >=3D (int)mci->layers[i].size) {
@@ -1208,7 +1205,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
type type,
 			pos[i] =3D -1;
 		}
 		if (pos[i] >=3D 0)
-			e->enable_per_layer_report =3D true;
+			any_memory =3D false;
 	}
=20
 	/*
@@ -1238,10 +1235,11 @@ void edac_mc_handle_error(const enum hw_event_mc_er=
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
 		if (!dimm->nr_pages)
 			continue;
@@ -1277,7 +1275,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
type type,
 			chan =3D -2;
 	}
=20
-	if (!e->enable_per_layer_report)
+	if (any_memory)
 		strcpy(e->label, "any memory");
 	else if (!*e->label)
 		strcpy(e->label, "unknown memory");
diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index bef8a428c429..cb3dab56a875 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -355,11 +355,8 @@ void ghes_edac_report_mem_error(int sev, struct cper_s=
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
index 6703eb492cd2..815f246e0abd 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -454,8 +454,6 @@ struct errcount_attribute_data {
  * @location:			location of the error
  * @label:			label of the affected DIMM(s)
  * @other_detail:		other driver-specific detail about the error
- * @enable_per_layer_report:	if false, the error affects all layers
- *				(typically, a memory controller error)
  */
 struct edac_raw_error_desc {
 	char location[LOCATION_SIZE];
@@ -472,7 +470,6 @@ struct edac_raw_error_desc {
 	unsigned long syndrome;
 	const char *msg;
 	const char *other_detail;
-	bool enable_per_layer_report;
 };
=20
 /* MEMORY controller information structure
--=20
2.20.1

