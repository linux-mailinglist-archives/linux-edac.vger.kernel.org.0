Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF6D14640F
	for <lists+linux-edac@lfdr.de>; Thu, 23 Jan 2020 10:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbgAWJDS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Jan 2020 04:03:18 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:27130 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729017AbgAWJDR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 23 Jan 2020 04:03:17 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00N91Ubx024446;
        Thu, 23 Jan 2020 01:03:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=cfZB2wG+a0PzgGa5RVy9nCNbgg3a9oxFw1IgmR/XLsg=;
 b=oOaVUZe+AwuhXy3cwlthMP4X+XxhxMHO11rX55NEc2xqwmADyc7wefwtu2J0pN3qov5G
 qJldjPzmEcJJaswD3+5VWEqroeIRWHON1fpDra9uweVs/t791BvXvFPJ35I+Li4g4CbT
 RgMfIZQY+9oZMhWa/9FP5ALWdX3myXU2Zc0NxneQLsvqlObnewXsAB4B7OGLhyfi3EIw
 Un99WUiRbYRrAfJNopkaDEwsROVEyWCXEgQhyV24SNs7QSYzPu/opm92cGo5dPWk+muG
 G4eqryEYQoXJGEfMSDAQAmz82A3cX4hqCdfgMXvNeooc61paIEcVeuj5VS6mUszxojwJ vA== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2xq4x4gqwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 23 Jan 2020 01:03:07 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 23 Jan
 2020 01:03:06 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 23 Jan 2020 01:03:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJsZrZLlJg8FEAZ3Qj5KiGOKB5GvQtNvqR4O9OGfQ6GauxMmnRCc6hJMLX6/E+Inrx8DQ8aoOla2rAiSBKLA7juoRhxfaxDQwejMN2zG9TBFoQQ3eGiWt1e1j1Y0tFGxUltbO5+iUyco6PT7BEzr4S8IpAyJxoLbIVF9oSuv2gbJkHrfAwg4M7tXGynrWS6X57sZsE+0ys+EZEdrE1oz96zgkTYvRToDawGfiY9BEOo8yIQ9OA9PNrVSfa3rRmqPoiFKv9VExWzZSRO8l3h1U9/ZjccwusIaIgMwbUYOUAUHObRROhm49itWJkWjskTalJ0URgYiugK02OVBjAtSiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfZB2wG+a0PzgGa5RVy9nCNbgg3a9oxFw1IgmR/XLsg=;
 b=dZHQtb1LOt/GMnpeJ/8wvsCzH+lRocoT3QIOpLcLn8fizocii5dj+AZ2rdxfOAMIPnQhKbobATWZEdg2w1tVAxclKsQ5WwB5QthdWOOktwBHg9pxUzCIGamuIBPVkAJAmW+z4ChktM+fwVOPoFnTyjOLFlJAt+uYLINhGAAndPCTXG05cHbVPz4/q3TId1HonmUxfD35iL237oLJWJLBUFU6OfcY2u7ulEaVLx1IpBy0sWzDINXOgzhrz7u/DyPnQlcn8tyiEFhT/Z00A3kVhdGaFGcS6n7PXxiPyT5BJ4z44t545S+OoL+4UqXp4fIB1PCkbzO9KyJ2OTrSQWocrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfZB2wG+a0PzgGa5RVy9nCNbgg3a9oxFw1IgmR/XLsg=;
 b=bv6dkH3WRV+r0IaPoGsvio0km027Zuulus+bMtrPyzgv4rhU272xBTRQTKVsbRB7uPYft8JoxEu6vaQa6hbxZkSWvOG45onbKxm0syIEnZoJZ9fg/qALKVO7QyvSdJPCv/RJRZBAMDppWdy/muc9m1H1FLIDIM/nS+DLpTvDR1o=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3247.namprd18.prod.outlook.com (10.255.237.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Thu, 23 Jan 2020 09:03:05 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea%7]) with mapi id 15.20.2644.028; Thu, 23 Jan 2020
 09:03:05 +0000
Received: from rric.localdomain (31.208.96.227) by HE1PR0902CA0010.eurprd09.prod.outlook.com (2603:10a6:3:e5::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend Transport; Thu, 23 Jan 2020 09:03:03 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 08/10] EDAC/mc: Pass the error descriptor to error
 reporting functions
Thread-Topic: [PATCH v3 08/10] EDAC/mc: Pass the error descriptor to error
 reporting functions
Thread-Index: AQHV0cvshSy9gD4yMUy/bqYFQKBqFQ==
Date:   Thu, 23 Jan 2020 09:03:04 +0000
Message-ID: <20200123090210.26933-9-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: 6206cd74-1ba1-4c68-6644-08d79fe30e94
x-ms-traffictypediagnostic: MN2PR18MB3247:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB3247F798DDDC9FB60D56273DD90F0@MN2PR18MB3247.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:439;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(366004)(396003)(39850400004)(376002)(199004)(189003)(110136005)(66946007)(52116002)(6512007)(66476007)(66556008)(64756008)(66446008)(54906003)(478600001)(1076003)(5660300002)(956004)(2616005)(6486002)(6506007)(36756003)(2906002)(81156014)(8676002)(86362001)(26005)(81166006)(8936002)(71200400001)(4326008)(186003)(316002)(16526019);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3247;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 90cRd14zdA396wz989rQTXVOplaO9jDEAfSSl+YX+2B6N3KHxyDS+6/WlZd4sdOQO+ntPxXPolRa1U5vJMwWdBGyJhQWXmclRACdJ1TrSDkA9kqrENGjR5UxxHiG0YKG4Mj6INumzuDifAamjtpni9eERllZwSzeSAsWqVk2kX5c/b6ZB8+f0SoiOdm5SN9LTBoo3HbUsKghi52KvSzwYny1nNW480fJhi8RZxERxJ0zzRvdV8H/yr5gogYhf568HMGNJnV0/9Vf/Gj1tHYzOq+IvHMSMod+QSV/WYpr+je4QjH2v6U6AYx4WG3ZLrnY5f5HyExWVErO9f6vm8ozh6cGiJ5jctMl0xNN0gJlr6IGQ5vBozWvLBOQtYcIKVtrrSys9PxJwzvCgW8T9Q6nAJBqjom+HKdYPGVsvc0K9sjIqfKqvGawxZhNCNlhhRnq
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6206cd74-1ba1-4c68-6644-08d79fe30e94
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 09:03:04.8802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ep+T9pblUIFrbmNcjmMSDyCfyj4aJVz3FjKAPhXLzuu/RhU80vUM/emJIfn/Ji2iU0KcVbPQTWiv31ipzcazqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3247
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-22_08:2020-01-22,2020-01-22 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Most arguments of error reporting functions are already stored in
struct edac_raw_error_desc error descriptor. Pass the error descriptor
to the functions and reduce the functions' arg list.

Signed-off-by: Robert Richter <rrichter@marvell.com>
Acked-by: Aristeu Rozanski <aris@redhat.com>
---
 drivers/edac/edac_mc.c | 100 +++++++++++++++++------------------------
 1 file changed, 42 insertions(+), 58 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 35e427f89949..c71af845ef16 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -947,16 +947,16 @@ const char *edac_layer_name[] =3D {
 };
 EXPORT_SYMBOL_GPL(edac_layer_name);
=20
-static void edac_inc_ce_error(struct mem_ctl_info *mci,
-			      const int pos[EDAC_MAX_LAYERS],
-			      const u16 count)
+static void edac_inc_ce_error(struct edac_raw_error_desc *e)
 {
+	struct mem_ctl_info *mci =3D error_desc_to_mci(e);
+	int pos[EDAC_MAX_LAYERS] =3D { e->top_layer, e->mid_layer, e->low_layer }=
;
 	int i, index =3D 0;
=20
-	mci->ce_mc +=3D count;
+	mci->ce_mc +=3D e->error_count;
=20
 	if (pos[0] < 0) {
-		mci->ce_noinfo_count +=3D count;
+		mci->ce_noinfo_count +=3D e->error_count;
 		return;
 	}
=20
@@ -964,23 +964,23 @@ static void edac_inc_ce_error(struct mem_ctl_info *mc=
i,
 		if (pos[i] < 0)
 			break;
 		index +=3D pos[i];
-		mci->ce_per_layer[i][index] +=3D count;
+		mci->ce_per_layer[i][index] +=3D e->error_count;
=20
 		if (i < mci->n_layers - 1)
 			index *=3D mci->layers[i + 1].size;
 	}
 }
=20
-static void edac_inc_ue_error(struct mem_ctl_info *mci,
-				    const int pos[EDAC_MAX_LAYERS],
-				    const u16 count)
+static void edac_inc_ue_error(struct edac_raw_error_desc *e)
 {
+	struct mem_ctl_info *mci =3D error_desc_to_mci(e);
+	int pos[EDAC_MAX_LAYERS] =3D { e->top_layer, e->mid_layer, e->low_layer }=
;
 	int i, index =3D 0;
=20
-	mci->ue_mc +=3D count;
+	mci->ue_mc +=3D e->error_count;
=20
 	if (pos[0] < 0) {
-		mci->ue_noinfo_count +=3D count;
+		mci->ue_noinfo_count +=3D e->error_count;
 		return;
 	}
=20
@@ -988,44 +988,37 @@ static void edac_inc_ue_error(struct mem_ctl_info *mc=
i,
 		if (pos[i] < 0)
 			break;
 		index +=3D pos[i];
-		mci->ue_per_layer[i][index] +=3D count;
+		mci->ue_per_layer[i][index] +=3D e->error_count;
=20
 		if (i < mci->n_layers - 1)
 			index *=3D mci->layers[i + 1].size;
 	}
 }
=20
-static void edac_ce_error(struct mem_ctl_info *mci,
-			  const u16 error_count,
-			  const int pos[EDAC_MAX_LAYERS],
-			  const char *msg,
-			  const char *location,
-			  const char *label,
-			  const char *detail,
-			  const char *other_detail,
-			  const unsigned long page_frame_number,
-			  const unsigned long offset_in_page,
-			  long grain)
+static void edac_ce_error(struct edac_raw_error_desc *e,
+			  const char *detail)
 {
+	struct mem_ctl_info *mci =3D error_desc_to_mci(e);
 	unsigned long remapped_page;
 	char *msg_aux =3D "";
=20
-	if (*msg)
+	if (*e->msg)
 		msg_aux =3D " ";
=20
 	if (edac_mc_get_log_ce()) {
-		if (other_detail && *other_detail)
+		if (e->other_detail && *e->other_detail)
 			edac_mc_printk(mci, KERN_WARNING,
 				       "%d CE %s%son %s (%s %s - %s)\n",
-				       error_count, msg, msg_aux, label,
-				       location, detail, other_detail);
+				       e->error_count, e->msg, msg_aux, e->label,
+				       e->location, detail, e->other_detail);
 		else
 			edac_mc_printk(mci, KERN_WARNING,
 				       "%d CE %s%son %s (%s %s)\n",
-				       error_count, msg, msg_aux, label,
-				       location, detail);
+				       e->error_count, e->msg, msg_aux, e->label,
+				       e->location, detail);
 	}
-	edac_inc_ce_error(mci, pos, error_count);
+
+	edac_inc_ce_error(e);
=20
 	if (mci->scrub_mode =3D=3D SCRUB_SW_SRC) {
 		/*
@@ -1040,51 +1033,46 @@ static void edac_ce_error(struct mem_ctl_info *mci,
 			* be scrubbed.
 			*/
 		remapped_page =3D mci->ctl_page_to_phys ?
-			mci->ctl_page_to_phys(mci, page_frame_number) :
-			page_frame_number;
+			mci->ctl_page_to_phys(mci, e->page_frame_number) :
+			e->page_frame_number;
=20
-		edac_mc_scrub_block(remapped_page,
-					offset_in_page, grain);
+		edac_mc_scrub_block(remapped_page, e->offset_in_page, e->grain);
 	}
 }
=20
-static void edac_ue_error(struct mem_ctl_info *mci,
-			  const u16 error_count,
-			  const int pos[EDAC_MAX_LAYERS],
-			  const char *msg,
-			  const char *location,
-			  const char *label,
-			  const char *detail,
-			  const char *other_detail)
+static void edac_ue_error(struct edac_raw_error_desc *e,
+			  const char *detail)
 {
+	struct mem_ctl_info *mci =3D error_desc_to_mci(e);
 	char *msg_aux =3D "";
=20
-	if (*msg)
+	if (*e->msg)
 		msg_aux =3D " ";
=20
 	if (edac_mc_get_log_ue()) {
-		if (other_detail && *other_detail)
+		if (e->other_detail && *e->other_detail)
 			edac_mc_printk(mci, KERN_WARNING,
 				       "%d UE %s%son %s (%s %s - %s)\n",
-				       error_count, msg, msg_aux, label,
-				       location, detail, other_detail);
+				       e->error_count, e->msg, msg_aux, e->label,
+				       e->location, detail, e->other_detail);
 		else
 			edac_mc_printk(mci, KERN_WARNING,
 				       "%d UE %s%son %s (%s %s)\n",
-				       error_count, msg, msg_aux, label,
-				       location, detail);
+				       e->error_count, e->msg, msg_aux, e->label,
+				       e->location, detail);
 	}
=20
 	if (edac_mc_get_panic_on_ue()) {
-		if (other_detail && *other_detail)
+		if (e->other_detail && *e->other_detail)
 			panic("UE %s%son %s (%s%s - %s)\n",
-			      msg, msg_aux, label, location, detail, other_detail);
+			      e->msg, msg_aux, e->label, e->location, detail,
+			      e->other_detail);
 		else
 			panic("UE %s%son %s (%s%s)\n",
-			      msg, msg_aux, label, location, detail);
+			      e->msg, msg_aux, e->label, e->location, detail);
 	}
=20
-	edac_inc_ue_error(mci, pos, error_count);
+	edac_inc_ue_error(e);
 }
=20
 static void edac_inc_csrow(struct edac_raw_error_desc *e, int row, int cha=
n)
@@ -1111,7 +1099,6 @@ void edac_raw_mc_handle_error(struct edac_raw_error_d=
esc *e)
 {
 	struct mem_ctl_info *mci =3D error_desc_to_mci(e);
 	char detail[80];
-	int pos[EDAC_MAX_LAYERS] =3D { e->top_layer, e->mid_layer, e->low_layer }=
;
 	u8 grain_bits;
=20
 	/* Sanity-check driver-supplied grain value. */
@@ -1134,16 +1121,13 @@ void edac_raw_mc_handle_error(struct edac_raw_error=
_desc *e)
 			"page:0x%lx offset:0x%lx grain:%ld syndrome:0x%lx",
 			e->page_frame_number, e->offset_in_page,
 			e->grain, e->syndrome);
-		edac_ce_error(mci, e->error_count, pos, e->msg, e->location,
-			      e->label, detail, e->other_detail,
-			      e->page_frame_number, e->offset_in_page, e->grain);
+		edac_ce_error(e, detail);
 	} else {
 		snprintf(detail, sizeof(detail),
 			"page:0x%lx offset:0x%lx grain:%ld",
 			e->page_frame_number, e->offset_in_page, e->grain);
=20
-		edac_ue_error(mci, e->error_count, pos, e->msg, e->location,
-			      e->label, detail, e->other_detail);
+		edac_ue_error(e, detail);
 	}
=20
=20
--=20
2.20.1

