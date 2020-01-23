Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 683EA146418
	for <lists+linux-edac@lfdr.de>; Thu, 23 Jan 2020 10:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgAWJDO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Jan 2020 04:03:14 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:4476 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728855AbgAWJDN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 23 Jan 2020 04:03:13 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00N90NT7023653;
        Thu, 23 Jan 2020 01:03:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=gFmCqAWBvpBn2IDnOmDi8xNLZbExXowGkOPAk4w/Ybs=;
 b=k6pimnHd3kw/mOZ4n4oZEjmgrokM3N2jhXm5Oxqsqqi+Z9Uy6mXqSKTCNWX19kW52CU2
 F3OgKN9O7VymhnOb/zf+BR0Y/Toz4brB/4NwBxC0UNcf9BpU2uRbHmbwzigv8H2sterJ
 1q2oPAWRHNsQaswJ3a6tfG6/QiD2TiBKgO1riqdsnm5Dw1ZNdMq0qsBI29A11ddwvu6Z
 EDxbaeG896LrtI5MN/Uxr7ztHgnWcOypnzMhOS5a9cLVFdXGlRhm+4gYWHSpI0jOvVHW
 LOFyictI6oi/DCKRuPzUg2MaYWpXEPxXhHtmy8wNaxbW4sBq6Lfud59dbKZnQqK9iP0q mA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2xq4x4gqw9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 23 Jan 2020 01:03:05 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 23 Jan
 2020 01:03:04 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.59) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 23 Jan 2020 01:03:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYrkdYlXW0elrcv+jmoXrMKeb/+w+M6/OhKb43mfMJOw2MbAXQWV5Qb0Ue5Yf6zFFVP1NKmzc1REkyy9SRWk9wXk3e47CqnwC0L2JleTWtv/aCaZfTiumEKLFugTpCZnMtuaYKKoYL6xtezlggW6VHhGRbD7adXgF0Q6ow0MijXxKR6tOgByoORu2wohOT2vCLFJDjDk/5gGSxuVRgfI3zphUncJp/cjKKQdV+0TxotwVgABpcRb0V4qkeuuM6CsT4ghTaxtgO1bpkM3ZWXcLyvDj5EvGusdiVEK1pxeVIpmkTwyqaeGBpMTx/tqjGrLbucNm6ehHG4ICBBxrudomg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFmCqAWBvpBn2IDnOmDi8xNLZbExXowGkOPAk4w/Ybs=;
 b=CDeUVHr0aESpeNA0zJJMlHn72jdxu/uqjdaCROBVOjbRCJoWYdmuxzExqISmH9N4VyolnjSQQI6f5lFPh9muTZRPaXfQMK8i5W9KIYwkOznZtDXG8eDgWelC98GhBPgHp7ETDTOhuhPpqMrNZS9/ZIFLlfV6ZfzLPWh0PsCqOpKPjHPpD2ZnMPnj2W/jpT0wbhh4+qeaedDUl65eOuw/sZPIRp+JddNqlkD/ToWfTab58+4OBBZICMsGQnYC5pqvWGii1vVb7cSocD80laI/zxorQZYQlkAsYC83bjAcLsy+Y+STixaAsQXXxQR5YjAD4fL998Sq7tlXm0nZ9benxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFmCqAWBvpBn2IDnOmDi8xNLZbExXowGkOPAk4w/Ybs=;
 b=W4Zjiw/qHhiHzZEK5KBs43IMk4w5zjxDKJIRS8fJ4AZUCzcx9BzNra9Yblw8ck+9CcxDEgTFMhcoWt4aY4fQ94YjTkqOSwyvzIMr0OKQbJJS4gl94WeICz+lIQy3Mww4o3vJ+3J6c61Z81jynSf7jGz5H6dEfwdWvrowBy47+Xk=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3247.namprd18.prod.outlook.com (10.255.237.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Thu, 23 Jan 2020 09:03:03 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea%7]) with mapi id 15.20.2644.028; Thu, 23 Jan 2020
 09:03:03 +0000
Received: from rric.localdomain (31.208.96.227) by HE1PR0902CA0010.eurprd09.prod.outlook.com (2603:10a6:3:e5::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend Transport; Thu, 23 Jan 2020 09:03:01 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 07/10] EDAC/mc: Remove enable_per_layer_report function
 arguments
Thread-Topic: [PATCH v3 07/10] EDAC/mc: Remove enable_per_layer_report
 function arguments
Thread-Index: AQHV0cvrvhi7xSaqbUaI1aoqTXiNXQ==
Date:   Thu, 23 Jan 2020 09:03:02 +0000
Message-ID: <20200123090210.26933-8-rrichter@marvell.com>
References: <20200123090210.26933-1-rrichter@marvell.com>
In-Reply-To: <20200123090210.26933-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0010.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::20) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e80a1d86-c95f-4369-c27c-08d79fe30d68
x-ms-traffictypediagnostic: MN2PR18MB3247:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB3247F1EFCE74109B10905388D90F0@MN2PR18MB3247.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(366004)(396003)(39850400004)(376002)(199004)(189003)(110136005)(66946007)(52116002)(6512007)(66476007)(66556008)(64756008)(66446008)(54906003)(478600001)(1076003)(5660300002)(956004)(2616005)(6486002)(6506007)(36756003)(2906002)(81156014)(8676002)(86362001)(26005)(81166006)(8936002)(71200400001)(4326008)(186003)(316002)(16526019);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3247;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +xJBcHD0dZMNFDS5PDhDrrGYOCB+7eS0iiQo7tsY3bahiHbySY1B4scDRoBlnjm9X4eUE2HnnVyz97rsNRzsufqZhMFRjfHud9milkv8+QPWT+c+c3tLPfsyRUd3Zf+eHnL7SrM2MJ5oj+7Fa888deBaYdDuKtLfm3VmNca73dBQUTLPs0gkmrJmp+P+lSGbFYiF5x23c2RcIVOngEPoqFMF3+eOeEU2ADgMmHtmKtbQCSz/RQBzVxOvt5rSOBMlfWrFEnjjjkvAXG+rZ27P4jtNWfFeQezWbjHZG0r1BZB96EhFFhWm5zvktdWAq6zXdYqZygVDR8GzU+ZhO43Cab7/t04Q75lv/PjdlFOSdHqB9dU3AQxhjolVzTx0pWePGgVVlzS6oAYWkUoguZ8AysWPCOX0EPRLykcJ+JAo4splsNRLWb6SiQfRi6ndmzOs
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e80a1d86-c95f-4369-c27c-08d79fe30d68
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 09:03:02.9105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GHorrGT07xo/TRUd3fdyd/7734xZ41PvrkaobzxA5P0xJHcdERw8LWsF3wFb4/rTrKcz2YirRRa0pLL3lgc71A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3247
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-22_08:2020-01-22,2020-01-22 signatures=0
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
Acked-by: Aristeu Rozanski <aris@redhat.com>
---
 drivers/edac/edac_mc.c   | 42 +++++++++++++++++++---------------------
 drivers/edac/ghes_edac.c |  5 +----
 include/linux/edac.h     |  3 ---
 3 files changed, 21 insertions(+), 29 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index aa94152777fe..35e427f89949 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -948,7 +948,6 @@ const char *edac_layer_name[] =3D {
 EXPORT_SYMBOL_GPL(edac_layer_name);
=20
 static void edac_inc_ce_error(struct mem_ctl_info *mci,
-			      bool enable_per_layer_report,
 			      const int pos[EDAC_MAX_LAYERS],
 			      const u16 count)
 {
@@ -956,7 +955,7 @@ static void edac_inc_ce_error(struct mem_ctl_info *mci,
=20
 	mci->ce_mc +=3D count;
=20
-	if (!enable_per_layer_report) {
+	if (pos[0] < 0) {
 		mci->ce_noinfo_count +=3D count;
 		return;
 	}
@@ -973,7 +972,6 @@ static void edac_inc_ce_error(struct mem_ctl_info *mci,
 }
=20
 static void edac_inc_ue_error(struct mem_ctl_info *mci,
-				    bool enable_per_layer_report,
 				    const int pos[EDAC_MAX_LAYERS],
 				    const u16 count)
 {
@@ -981,7 +979,7 @@ static void edac_inc_ue_error(struct mem_ctl_info *mci,
=20
 	mci->ue_mc +=3D count;
=20
-	if (!enable_per_layer_report) {
+	if (pos[0] < 0) {
 		mci->ue_noinfo_count +=3D count;
 		return;
 	}
@@ -1005,7 +1003,6 @@ static void edac_ce_error(struct mem_ctl_info *mci,
 			  const char *label,
 			  const char *detail,
 			  const char *other_detail,
-			  const bool enable_per_layer_report,
 			  const unsigned long page_frame_number,
 			  const unsigned long offset_in_page,
 			  long grain)
@@ -1028,7 +1025,7 @@ static void edac_ce_error(struct mem_ctl_info *mci,
 				       error_count, msg, msg_aux, label,
 				       location, detail);
 	}
-	edac_inc_ce_error(mci, enable_per_layer_report, pos, error_count);
+	edac_inc_ce_error(mci, pos, error_count);
=20
 	if (mci->scrub_mode =3D=3D SCRUB_SW_SRC) {
 		/*
@@ -1058,8 +1055,7 @@ static void edac_ue_error(struct mem_ctl_info *mci,
 			  const char *location,
 			  const char *label,
 			  const char *detail,
-			  const char *other_detail,
-			  const bool enable_per_layer_report)
+			  const char *other_detail)
 {
 	char *msg_aux =3D "";
=20
@@ -1088,7 +1084,7 @@ static void edac_ue_error(struct mem_ctl_info *mci,
 			      msg, msg_aux, label, location, detail);
 	}
=20
-	edac_inc_ue_error(mci, enable_per_layer_report, pos, error_count);
+	edac_inc_ue_error(mci, pos, error_count);
 }
=20
 static void edac_inc_csrow(struct edac_raw_error_desc *e, int row, int cha=
n)
@@ -1138,16 +1134,16 @@ void edac_raw_mc_handle_error(struct edac_raw_error=
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
@@ -1172,6 +1168,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
type type,
 	int pos[EDAC_MAX_LAYERS] =3D { top_layer, mid_layer, low_layer };
 	int i, n_labels =3D 0;
 	struct edac_raw_error_desc *e =3D &mci->error_desc;
+	bool any_memory =3D true;
=20
 	edac_dbg(3, "MC%d\n", mci->mc_idx);
=20
@@ -1190,9 +1187,9 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
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
@@ -1210,7 +1207,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
type type,
 			pos[i] =3D -1;
 		}
 		if (pos[i] >=3D 0)
-			e->enable_per_layer_report =3D true;
+			any_memory =3D false;
 	}
=20
 	/*
@@ -1240,10 +1237,11 @@ void edac_mc_handle_error(const enum hw_event_mc_er=
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
@@ -1279,7 +1277,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
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

