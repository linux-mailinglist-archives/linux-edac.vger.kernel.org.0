Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB126113E2A
	for <lists+linux-edac@lfdr.de>; Thu,  5 Dec 2019 10:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbfLEJiV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 5 Dec 2019 04:38:21 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:28908 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729215AbfLEJiU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 5 Dec 2019 04:38:20 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB59bKkX023619;
        Thu, 5 Dec 2019 01:38:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=g1gwTQlHy1wvorIqQq7F4OyXokTTiOv4CbtXHcDzafA=;
 b=CQgLC1Z1oQlVIlJ01pxwoy828QyKLYKAylkHYgTfoXmLPVS8+/61Izllg/0W6X5lfWw6
 fF5b4KOM2IaSmP0QSp92RbBnds2FxHdPRoaKUcHmpTaSbfiYPAWiUj9rryRLoBdHxOPr
 IYRRgy/1k4rEV7AYnLYbgWhYTg8PHhoSwGTGLoHHLHZFuxrDLeL0VrkOPo4IkYQFHSkA
 RINrCdX9oIu1b+CUf7f0KkL7MQoiBJcXc5xUN2EI+hR6soDKFlJ2CD9d4MdfK4bNawyb
 IZNg8ZgzERFPiaik3WLS+QvV4l/98/spvh+iIyrLKWhGnyrV+qmX7gjn2Zp6oypWXUHn Hw== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2wnvgvrd0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 05 Dec 2019 01:38:14 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 5 Dec
 2019 01:38:13 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.55) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 5 Dec 2019 01:38:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grE8DqRqU3Kjt5UjHtMoUMGVlS+7Ve20YONTN35vP4KyEgw4EnaL1c2V2kS5vKgKJLoPurD5rODb7ZApGzYynDZLi/PrzTFIh7Zx9F8GCwr6Z0b2BetowOunrBvK+15CGNvlQhQLJ00uXvMAAABiG4WIMKgcnOATg0dL/p967+rZYwl0XoctglosaeU8zcmU+8ds+8K+KFuezbdgwQSevU1zUWICmJ1uCLKzUb6RLwes3bc3zap8+Lypb1bCL3lShHmNNiFomi+2OrDwfB//FgtPzs0xrSPY4m9QDKXc/OBhz5yPwuAIpfd3OQgnP++zQyd5E1LmXGhvOWvsksCgOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1gwTQlHy1wvorIqQq7F4OyXokTTiOv4CbtXHcDzafA=;
 b=jteOIAGzjf75TM11eMQ0XpvQIKJPthlzrEE8/H8+w0fd3FQ09bcHUD+60Ks+AZ3ITKkybHoBXK0jQvp6c8kNxo3o7ALmYURcrrVdG0W0lAQAO1Sso3wwgtuEvNaIh9X9235IXRPoejGVzo67ozfDNmBxESx5mPoEUiVPDsfsGcHITH/pXl8DFyEeNUlBKpFwK2zYWw9vIY+NN1o1jZvIjezmq7x4doFftwO+M0N4G03C8RYRT+kkubFtkZc4RMYC3k3MsrkfRU7PgXFfQ4tXuc8AptA45vj9t18WnVtfx01F1Gb96/kUu+DCv1mOB4umJCsGi24/Nmj5rvHQbpn47g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1gwTQlHy1wvorIqQq7F4OyXokTTiOv4CbtXHcDzafA=;
 b=fCxh3ASJggNODLU3qmWtSyidtdkQY4hRRI88Skrfw1pltOAA8PPh91D+VN/xkqya1P+5IeG8BbbdKX3pNK8pTQFtKybZR7P/VqYRgorbdLW7U1gqEuC7QEj3s2hS6RlMqYoxEeQHrVmhlBXoN5OHHUAxmky+LKY+t/8uTfARnjI=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2367.namprd18.prod.outlook.com (20.179.80.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Thu, 5 Dec 2019 09:38:12 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106%7]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 09:38:12 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 08/10] EDAC/mc: Pass the error descriptor to error
 reporting functions
Thread-Topic: [PATCH v2 08/10] EDAC/mc: Pass the error descriptor to error
 reporting functions
Thread-Index: AQHVq0+2OTakJ7xVJkC7+Ue06c1H3A==
Date:   Thu, 5 Dec 2019 09:38:12 +0000
Message-ID: <20191205093739.4040-9-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: beb199b4-2e73-41ac-756c-08d77966d880
x-ms-traffictypediagnostic: MN2PR18MB2367:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB2367C5D8E74723538D0E3A4BD95C0@MN2PR18MB2367.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:439;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(189003)(199004)(81166006)(14444005)(14454004)(36756003)(6512007)(316002)(478600001)(54906003)(5660300002)(110136005)(186003)(8936002)(50226002)(6486002)(26005)(99286004)(66556008)(66476007)(81156014)(71190400001)(86362001)(66946007)(66446008)(64756008)(25786009)(8676002)(2906002)(71200400001)(6506007)(4326008)(2616005)(11346002)(102836004)(305945005)(1076003)(76176011)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2367;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8/M1II7M38QDMYpxfzJRyXY7NePHULMpYSIr9J8QS7cD8vE1Fb+swwd5su0JqGmxGej+R9Baa8i0a97vd0kZO4Wa4iBNa2YllcaN0A/BogoV1lbSlBdD5ca4TMzzScQIL0yNQ8wtWCvefuM3K5fr8PvS62Mt/S3dX3kP0Pj9hXSxP87yMwCyrE+jM/krGSNuN8Xf0kMyuob8mvYt5R40rd9KZm107lSmRH0lkxBKYfir2dVCwoLgLLzQ0VxJHupDk6bmiVfWR8MrWVX6jHgPLxtGhSc/pbb0CtbsYxcpq2P0+cKnEgJtRwg5trwPg4DFu71gAXRnjQfnKA3J0JR3WQcUJEK+5BkRkBM78WuyZ0AVqWB3qI4EM7AMvGxhciaD+LoGU9DsCb0+WIVgSNixxopoQtxSRnjAE6X4OchOwi9dJ4Xvf62F12OS22EFkb+9
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: beb199b4-2e73-41ac-756c-08d77966d880
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 09:38:12.4215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J4okMD5BVnaqBXz7RDBHjrr9WrPsx5TLnrwOfgjsQAQjhXrZOjyyA2Bmjzu2Rfji70cXflc3LfXuZYX65lC6RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2367
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-05_01:2019-12-04,2019-12-05 signatures=0
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

