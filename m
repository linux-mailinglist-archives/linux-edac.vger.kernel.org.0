Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB4410BFEB
	for <lists+linux-edac@lfdr.de>; Wed, 27 Nov 2019 22:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfK0Vz2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 27 Nov 2019 16:55:28 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:47830 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727923AbfK0VzK (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 27 Nov 2019 16:55:10 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xARLpJ9a023352;
        Wed, 27 Nov 2019 13:55:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=g1gwTQlHy1wvorIqQq7F4OyXokTTiOv4CbtXHcDzafA=;
 b=NTl8ol5aR/x5J7IVYVstQMbW53Ws2+b6WzzPf2+VF/XVntddzQXbGCZrAYDO8WwOfZx5
 81V9zIA2RC7X+EHJNVxtVLvZubBvegCD1FPozDBIJFvelLXNtoU5CvUhzBeNV7GVTn5s
 LO3556Sfp2L17nIrEYt+e8nA3h22kyLPvJe2rmWpkkVMkQGE3lFa8nev/7n6zIOO3162
 BF0ZfBmwkEzYZursYWg9s+Hk9FmH2ySHZV0UG1X+q+2bajTaFz3Ic3MpAjvhaS9wye0p
 qxcvezvlbg/CrJi7iGuutdp0AUXxLh0MGckSyby3A4/BnvylfG6D0KWQZBF63lpFG3pq 8Q== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2whmdyb5sc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 27 Nov 2019 13:55:03 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 27 Nov
 2019 13:55:02 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.58) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 27 Nov 2019 13:55:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idgsT5wmBILCq6Ynigdg/6c87TuVHE+SqCe/em35HimYRLa3MgaeAQreqrWpC5cXBVbPAVEVuxOP2BZyh1Mv34HKlzKSgznUYrN7TyIKBCqYVUHDF+VBF4oTySY1kg/hN0AJsPP1FClZpo999pxoGxqrCNVQ44AOmIARsKDuX9O5djqSjQAD1H/qjf0tDcuhdBFFzOqIgpvTGd8Km60HjAkXo+MnOX9rzmZz7+W3jeusZOVZuWQlAjVaTWa+5cj34+az5XdUetoxOUOVeNJX6Q774UvaDSSdXELWbZimViSop+IfXqGrdwIn+pIo2X0DC0+RKMjSkcSNC5Vvs0m8zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1gwTQlHy1wvorIqQq7F4OyXokTTiOv4CbtXHcDzafA=;
 b=VjaWQ7Xb5vMXR2aZIP811cy79DwggxGRcV0Woh4sOGB8XnijRD/f8qBepr6xCAvVBZt+lyhS6uFW3yQ1eaGLva4Z1QwiQlVA2kiWscZvcce2KhbpNZBVqaUQyvx0Z/23Uy/sPKV3o5aNgrk84lyOeyUfDmk9Z1rVJW1dk8v+KNGmJtWibRmnHasfMq8zoGyiHV8cfDCDIcOMtWrVfBiA5OhvVFDtCGlhzF3IrbocR7vgRGAxHSDcpqU1gv1/lFcYPIopMV4nO5BXM0mydkdkrTnW4gRJthF22/WRv5Gp5ECnY2BzikViCb9pYqVlZrebNCxQeRp/BQSvoH/0RfiYBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1gwTQlHy1wvorIqQq7F4OyXokTTiOv4CbtXHcDzafA=;
 b=C3RIqpsM0FD4DIADP5HAxt7F8Z2M1r10AbHBGM4+Ra0QbDiQRWZ+pQL7wl8h4AK5vMzLf/DkBNPnoXsV3YxcQkbLEV5vhJpNl/CPrAeNSf5kNfqLTz9v8FxLYNBOluEq8cZoU2D24tR9SbOqzNOwOGUODgg95rVO3GEm8iCj/2M=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2477.namprd18.prod.outlook.com (20.179.81.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.22; Wed, 27 Nov 2019 21:55:00 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106%7]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 21:55:00 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 08/10] EDAC/mc: Pass the error descriptor to error reporting
 functions
Thread-Topic: [PATCH 08/10] EDAC/mc: Pass the error descriptor to error
 reporting functions
Thread-Index: AQHVpW1RM6DOVbMlwEuImzrZCxNAuA==
Date:   Wed, 27 Nov 2019 21:55:00 +0000
Message-ID: <20191127215415.11230-9-rrichter@marvell.com>
References: <20191127215415.11230-1-rrichter@marvell.com>
In-Reply-To: <20191127215415.11230-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0017.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::30) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10b54e80-b6b3-45bf-d263-08d773847378
x-ms-traffictypediagnostic: MN2PR18MB2477:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB2477079E2C4DEFC29F0EA962D9440@MN2PR18MB2477.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:439;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(189003)(199004)(14454004)(305945005)(110136005)(256004)(186003)(1076003)(4326008)(86362001)(11346002)(6436002)(14444005)(8676002)(6486002)(81156014)(2906002)(81166006)(386003)(6512007)(478600001)(76176011)(54906003)(99286004)(52116002)(8936002)(25786009)(7736002)(66946007)(6116002)(26005)(316002)(66066001)(50226002)(36756003)(71190400001)(3846002)(66476007)(66556008)(64756008)(66446008)(71200400001)(102836004)(2616005)(6506007)(446003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2477;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qNWbAThFqA3MC00VKq3PJWXrvlOp6hkyQZPCjDEh/NYMiefXCcRbO5ZQH+45GYoa9FAre9bdgKuAKtCSagD2GOytO+yoT+7/V5jIr4okp9aVHd0BR2VW3Hcr90nFfC3RCprrcRwnmeG8CvmchdFlwmxCmK6CKZUwcn2E3r5BrK4qK0BGVWvB1d34mtNfLP0CR/DlqUhNraGAD6zhILVAK1cnvgKPU/ANk+tzRR1wsILqGeIdXRJsoL13OkLULppg2YhZoVR9LLiw9t90RvDPo2QW94ZpY10VzVOUd9KQu1WrY06TZNCaOyprRk2JTJSmEmv65cCGtdS4f+tjKgyUVhwkQWXkXWmcxxfN3RvEiw15GcnSlzFrNkfjo1ff5AnTnLtc339YL1wmqBTHoSPyGkGLI9Sk8p6W1ZNal445RJjMgIOn/BOqk+VyYBXk99gB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b54e80-b6b3-45bf-d263-08d773847378
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 21:55:00.7858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IuDcCXJzkwYbnHU41X3ImlkTm1BpadU5XzyfVotJEwwQaWuWJoL01ddD4QUd0JbXrBKZF8uh6MatzRHBkqxfvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2477
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-27_04:2019-11-27,2019-11-27 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Most arguments of error reporting functions are already stored in
struct edac_raw_error_desc error descriptor. Pass the error descriptor
to the functions and reduce the functions' arg list.

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/edac_mc.c | 100 +++++++++++++++++------------------------
 1 file changed, 42 insertions(+), 58 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 38a9a68eebfe..545d25c8654e 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -945,16 +945,16 @@ const char *edac_layer_name[] =3D {
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
@@ -962,23 +962,23 @@ static void edac_inc_ce_error(struct mem_ctl_info *mc=
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
@@ -986,44 +986,37 @@ static void edac_inc_ue_error(struct mem_ctl_info *mc=
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
@@ -1038,51 +1031,46 @@ static void edac_ce_error(struct mem_ctl_info *mci,
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
@@ -1109,7 +1097,6 @@ void edac_raw_mc_handle_error(struct edac_raw_error_d=
esc *e)
 {
 	struct mem_ctl_info *mci =3D error_desc_to_mci(e);
 	char detail[80];
-	int pos[EDAC_MAX_LAYERS] =3D { e->top_layer, e->mid_layer, e->low_layer }=
;
 	u8 grain_bits;
=20
 	/* Sanity-check driver-supplied grain value. */
@@ -1132,16 +1119,13 @@ void edac_raw_mc_handle_error(struct edac_raw_error=
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

