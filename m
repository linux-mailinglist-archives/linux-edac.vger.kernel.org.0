Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A81DBD31F5
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2019 22:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfJJUZf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Oct 2019 16:25:35 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:62496 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726205AbfJJUZe (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 10 Oct 2019 16:25:34 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9AKPMAT029869;
        Thu, 10 Oct 2019 13:25:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=LxWrU3SAxvcssVNIkGuJbn/CCcLwtALrnh0Yb/egWUc=;
 b=TuR+Dtq/qK7b8RgxT6QL3A18yN5XW/Gm7cpmzlhsDn8qa//+HRg1M6Kcgjr0LR9h61r0
 FaTJtSsk8ZfpJM8zEJlJS57A0bjxb/Uwu+BH7KGmzgQEtZOsXatNFPFh7sdrNyBbW1NO
 bMkKc/lSLCMI1epHJR8QVUr0ygeAYHd+AMKZ1WSs6g7Z+d88bMVE3EacWPKu7zkrOVrH
 fM9qaobdab+H/xKP+LMrrtO+Xvn1Hkl0+hGlRSckX3K0M7sHk4cZfQ1GrE4dKmUod5lR
 b6NPkhm6SYfwh4IbILLzKQJNr0zZw2dkPQS6LFOrU3YTuWI0PxAVaj5Kxv59vpLJPbtM qg== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2vhdxbxqgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 10 Oct 2019 13:25:27 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 10 Oct
 2019 13:25:26 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.58) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 10 Oct 2019 13:25:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgAcagfK2HIXEdAoET5VgMB9fAvmxkJSp47cvEfxPQr45cqF4zuSDPKFXilK1owY4dFYkHKD+AenObG7zdqG5bdCqcD2PoEPwLMyn+VyLUsQJOWUxEsOQVeH5b3FenHzeDdpIjm9+nBmM13kKXLJkcfSDvCUo+Vxj0PQK1+XVHSWeDyECDBjFyoGTrR5TJwMBMQCsPgPAe1lfmPZzT7lmA21RQqwMeFK6WUSrHZASMAEWPiZ3yOJbMZhdm2uHScJOVKxEdu8V64dFL9Pqxfz7fjCVYrPdDLxnQa1C5RIEdKyd03rRFBr0E7VIvaxxebEmJkeq2D7JOmLs7r1YS2oPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxWrU3SAxvcssVNIkGuJbn/CCcLwtALrnh0Yb/egWUc=;
 b=cJn1GkrL0wK1eC7gZ0kLt9aE0bDaEgJqETRczi10cMOLd5dqugc9au9numa+v4MkIcpuFGhDjNlh7lAJcFvyv5PkXn/cemTpaXeOfvyWOZsqNkwouvhtHBdmIenoarEfHShEYDdMWaFykefdDWqpihZ5qa7mBfgmIVSCohTnti2Cae3eiONpHLINUtia7WPPtEs2NtsR+BIoDbDQfd+AdXzHYjQCEO4NJrGDtR9n1VDXM7vxDgqXjqzZNHHIRKNOqe//dfJLTX3i94dTwQHzQeSstCNTtD2JQC2zA5gXotPc6WwutdXByVd5RC/RTJGYAXo2awIC9u37Dt2N0vyB2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxWrU3SAxvcssVNIkGuJbn/CCcLwtALrnh0Yb/egWUc=;
 b=HZHGnUrZKi1dqfnxPNKC2aNalMlQHgOR4NLyr2DfmEHKkG1xy/3DYaChs/IQNdXyf8K5HAQ1j5mamwdSQSMTUP7QzC0BE4VMVyTePIlfLY2t/8WHXDAMXmGfiyRn9eAa6nTj3CFNqreSyTSysWLBoOLYD68DBy5IHRSGpagOgvQ=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2447.namprd18.prod.outlook.com (20.179.82.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 10 Oct 2019 20:25:24 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763%3]) with mapi id 15.20.2327.026; Thu, 10 Oct 2019
 20:25:24 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 10/19] EDAC, mc: Rework edac_raw_mc_handle_error() to use
 struct dimm_info
Thread-Topic: [PATCH 10/19] EDAC, mc: Rework edac_raw_mc_handle_error() to use
 struct dimm_info
Thread-Index: AQHVf6jYfQgEDGZWeEejtcHtIqpAxA==
Date:   Thu, 10 Oct 2019 20:25:24 +0000
Message-ID: <20191010202418.25098-11-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: 27d5b5b7-4b5c-4612-04e8-08d74dbffb3c
x-ms-traffictypediagnostic: MN2PR18MB2447:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB24476283E84158736FB3E5CCD9940@MN2PR18MB2447.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 018632C080
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(199004)(189003)(6512007)(476003)(8936002)(25786009)(50226002)(8676002)(81156014)(81166006)(14444005)(7736002)(305945005)(256004)(486006)(14454004)(2616005)(6436002)(86362001)(66066001)(36756003)(66946007)(66476007)(66556008)(64756008)(66446008)(11346002)(446003)(71190400001)(71200400001)(6486002)(186003)(478600001)(5660300002)(386003)(316002)(3846002)(26005)(4326008)(6116002)(2906002)(52116002)(76176011)(99286004)(54906003)(110136005)(6506007)(102836004)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2447;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lopiUudqvuZwaXDJYDcCeDZq6aPS4ZbpdGYL+r37rOlG3EcpVKEPU4oUvjmzLzpx3qzRhaIfyeqpp+spo4jn05+n8G7ZfhW0BAa5rI3BXiQUS936tleOswGAB2bYxpFAIdmhe6PWFqRQNBdqiSPr8SIi7Wt79+zvoRzwyjufjzGy4IkEibsnJiQQuBEZck/OIj2CWlTO2js21FEJznY77bsrRw/CJ2mio2P9GtuDFe33V4Gg8cH2MwFlS/bORbASl60+jM/zy2cDz/5LUkjNh3GRUB9tYBKL2m2djwt7IVHfbBqzcJevADBrGY5Oyzc4FNElsx/sHbNPrdYSf2UW8w2qfsz++V1xeYoEnj8RLMyQCRIJCtTFr2CKgcs5YuJEsA93Td33obQRipnCduckcPOFSjQg71lJsVTG+6GSCb0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d5b5b7-4b5c-4612-04e8-08d74dbffb3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 20:25:24.7740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dGFrjn0weVCxpWFHY7Yjhp/Sf1vAvxo+R7Mnsn3CkIxlVEOxrL3Tb2VDY098EX/MQQWwyZK/zhjLM+4qEsz0IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2447
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-10_07:2019-10-10,2019-10-10 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The error handling functions have the pos[] array argument for
determing the dimm handle. Rework those functions to use the dimm
handle directly.

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/edac_mc.c   | 28 +++++++++++++---------------
 drivers/edac/edac_mc.h   |  2 ++
 drivers/edac/ghes_edac.c |  6 +++++-
 3 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 6d880cf4d599..cdfb383f7a35 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -925,11 +925,9 @@ const char *edac_layer_name[] =3D {
 EXPORT_SYMBOL_GPL(edac_layer_name);
=20
 static void edac_inc_ce_error(struct mem_ctl_info *mci,
-			      const int pos[EDAC_MAX_LAYERS],
+			      struct dimm_info *dimm,
 			      const u16 count)
 {
-	struct dimm_info *dimm =3D edac_get_dimm(mci, pos[0], pos[1], pos[2]);
-
 	mci->ce_mc +=3D count;
=20
 	if (dimm)
@@ -939,11 +937,9 @@ static void edac_inc_ce_error(struct mem_ctl_info *mci=
,
 }
=20
 static void edac_inc_ue_error(struct mem_ctl_info *mci,
-				    const int pos[EDAC_MAX_LAYERS],
-				    const u16 count)
+			      struct dimm_info *dimm,
+			      const u16 count)
 {
-	struct dimm_info *dimm =3D edac_get_dimm(mci, pos[0], pos[1], pos[2]);
-
 	mci->ue_mc +=3D count;
=20
 	if (dimm)
@@ -953,8 +949,8 @@ static void edac_inc_ue_error(struct mem_ctl_info *mci,
 }
=20
 static void edac_ce_error(struct mem_ctl_info *mci,
+			  struct dimm_info *dimm,
 			  const u16 error_count,
-			  const int pos[EDAC_MAX_LAYERS],
 			  const char *msg,
 			  const char *location,
 			  const char *label,
@@ -982,7 +978,7 @@ static void edac_ce_error(struct mem_ctl_info *mci,
 				       error_count, msg, msg_aux, label,
 				       location, detail);
 	}
-	edac_inc_ce_error(mci, pos, error_count);
+	edac_inc_ce_error(mci, dimm, error_count);
=20
 	if (mci->scrub_mode =3D=3D SCRUB_SW_SRC) {
 		/*
@@ -1006,8 +1002,8 @@ static void edac_ce_error(struct mem_ctl_info *mci,
 }
=20
 static void edac_ue_error(struct mem_ctl_info *mci,
+			  struct dimm_info *dimm,
 			  const u16 error_count,
-			  const int pos[EDAC_MAX_LAYERS],
 			  const char *msg,
 			  const char *location,
 			  const char *label,
@@ -1041,15 +1037,15 @@ static void edac_ue_error(struct mem_ctl_info *mci,
 			      msg, msg_aux, label, location, detail);
 	}
=20
-	edac_inc_ue_error(mci, pos, error_count);
+	edac_inc_ue_error(mci, dimm, error_count);
 }
=20
 void edac_raw_mc_handle_error(const enum hw_event_mc_err_type type,
 			      struct mem_ctl_info *mci,
+			      struct dimm_info *dimm,
 			      struct edac_raw_error_desc *e)
 {
 	char detail[80];
-	int pos[EDAC_MAX_LAYERS] =3D { e->top_layer, e->mid_layer, e->low_layer }=
;
=20
 	/* Memory type dependent details about the error */
 	if (type =3D=3D HW_EVENT_ERR_CORRECTED) {
@@ -1057,7 +1053,7 @@ void edac_raw_mc_handle_error(const enum hw_event_mc_=
err_type type,
 			"page:0x%lx offset:0x%lx grain:%ld syndrome:0x%lx",
 			e->page_frame_number, e->offset_in_page,
 			e->grain, e->syndrome);
-		edac_ce_error(mci, e->error_count, pos, e->msg, e->location,
+		edac_ce_error(mci, dimm, e->error_count, e->msg, e->location,
 			      e->label, detail, e->other_detail,
 			      e->page_frame_number, e->offset_in_page, e->grain);
 	} else {
@@ -1065,7 +1061,7 @@ void edac_raw_mc_handle_error(const enum hw_event_mc_=
err_type type,
 			"page:0x%lx offset:0x%lx grain:%ld",
 			e->page_frame_number, e->offset_in_page, e->grain);
=20
-		edac_ue_error(mci, e->error_count, pos, e->msg, e->location,
+		edac_ue_error(mci, dimm, e->error_count, e->msg, e->location,
 			      e->label, detail, e->other_detail);
 	}
=20
@@ -1245,6 +1241,8 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
type type,
 			       (e->page_frame_number << PAGE_SHIFT) | e->offset_in_page,
 			       grain_bits, e->syndrome, e->other_detail);
=20
-	edac_raw_mc_handle_error(type, mci, e);
+	dimm =3D edac_get_dimm(mci, top_layer, mid_layer, low_layer);
+
+	edac_raw_mc_handle_error(type, mci, dimm, e);
 }
 EXPORT_SYMBOL_GPL(edac_mc_handle_error);
diff --git a/drivers/edac/edac_mc.h b/drivers/edac/edac_mc.h
index 02aac5c61d00..2c3e2fbcedc4 100644
--- a/drivers/edac/edac_mc.h
+++ b/drivers/edac/edac_mc.h
@@ -214,6 +214,7 @@ extern int edac_mc_find_csrow_by_page(struct mem_ctl_in=
fo *mci,
  *
  * @type:		severity of the error (CE/UE/Fatal)
  * @mci:		a struct mem_ctl_info pointer
+ * @dimm:		a struct dimm_info pointer
  * @e:			error description
  *
  * This raw function is used internally by edac_mc_handle_error(). It shou=
ld
@@ -222,6 +223,7 @@ extern int edac_mc_find_csrow_by_page(struct mem_ctl_in=
fo *mci,
  */
 void edac_raw_mc_handle_error(const enum hw_event_mc_err_type type,
 			      struct mem_ctl_info *mci,
+			      struct dimm_info *dimm,
 			      struct edac_raw_error_desc *e);
=20
 /**
diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index e0b90c6d7d63..4f5721cf4380 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -193,6 +193,7 @@ static void ghes_edac_dmidecode(const struct dmi_header=
 *dh, void *arg)
=20
 void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 {
+	struct dimm_info *dimm;
 	enum hw_event_mc_err_type type;
 	struct edac_raw_error_desc *e;
 	struct mem_ctl_info *mci;
@@ -437,7 +438,10 @@ void ghes_edac_report_mem_error(int sev, struct cper_s=
ec_mem_err *mem_err)
 		       (e->page_frame_number << PAGE_SHIFT) | e->offset_in_page,
 		       grain_bits, e->syndrome, pvt->detail_location);
=20
-	edac_raw_mc_handle_error(type, mci, e);
+	dimm =3D edac_get_dimm_by_index(mci, e->top_layer);
+
+	edac_raw_mc_handle_error(type, mci, dimm, e);
+
 	spin_unlock_irqrestore(&ghes_lock, flags);
 }
=20
--=20
2.20.1

