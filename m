Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90423D320B
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2019 22:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfJJU0N (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Oct 2019 16:26:13 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:24880 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726706AbfJJUZq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 10 Oct 2019 16:25:46 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9AKPMAW029869;
        Thu, 10 Oct 2019 13:25:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=hUFrqrpJtWF5tDX2FhMkctljMgIDndlf9B9L9MFguFo=;
 b=upvv9xGLlxo7Rv15dN0x5D8CQ6M+xjJ8BAfUDDrkYEnlykj5b7gn9CcMxFxwG15xMMgM
 hKC6xoRa/wlAg6N6i9mGRJJ/zDN/YOiP6EYh8TA5h4RdsUeSARTiUOdtzEcaT8NxbSMD
 6LeQCfKTiL/Qa6AxPGuZZZP1wr6La/bsxEGZRo8MvQi0Jn0B/ImQnBVy9s0muvyQFft3
 R8E+34G1R/LCOF6+EWs067CP6TCOq/+w/lSkPVGNmgJYCxIzlSJYQGPHOE9WpuJvuuhm
 GMMvQfSvV2McxMaZ2NFbOyFqnM0m2zHETPQLTnXzV80+eOIfsAggwetOvkTzOshaG8Gx kw== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2vhdxbxqh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 10 Oct 2019 13:25:32 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 10 Oct
 2019 13:25:30 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.52) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 10 Oct 2019 13:25:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnSQ6W/B/M/S0fPEPNDuhb/iHT2j7eCywRDkpUdXsD56z1+wKkhhbBveRN0YkVdKlRhxu+GomNevegO5oIjmKWnPfmpWpc8n/O6iPXYcCHZqXmZnmESST31S8Mzky2zTgL/u0OJ63mToMTzspGa1g/Ank24SfSv8pjTTDZxH7OuQnF+MHD1j7/JzZaBbydaefmDFH07afW+2uRfOeNAUKn26cQZQnJyvXzEpbZ8EybeABusiCgC1ixyMXW5sPxV9Am1tuzU8TDf8okUXnQn+KvNGV6eW1zuJpP1RG9Ur4wId8f8eUbFlAPjg6mRTH8QtPtOsASABYT1RkcaUOI42Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUFrqrpJtWF5tDX2FhMkctljMgIDndlf9B9L9MFguFo=;
 b=Y5T3brBQeHrNRiXA6/jbkNMHFdddYnUJH/ERfgD+L4KDuHg8bmCtvPRgbYkLX1djAgazxGRIkf0dEzBUcqrrGJTZgf5j1sMC6rQ1oqMl1M59wH3HeKw/4JYTRMHt2UyViL1Bjgf5cTPSp4fThrhA4elj28m+J9balmen6iywT+kdyNrJOP0zJp19zdShekc4i9X/Uel1JLdwqBWnr7AAknIdQdILRJOVBM0xEugZIi4NvkHwNlK5VtjloaI07bjPyf4WiAPLpZ6zgumaD9sEUOLS8aEOqbxwS6etxRexhTG+d90RnA06ADaCCZgWc6XPygUQwMkHCeSZ7I4qtsqLrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUFrqrpJtWF5tDX2FhMkctljMgIDndlf9B9L9MFguFo=;
 b=EicBnZBwZtEIIY4G/4oBx7pPitriGuJUA/fmX5dlxVyBnp8MIMPDsA1tFoZROo2aXAdNsKpfHjgQX+wkUDLcDpA5hphNp1fhZtRtiCSB2iK+1P0j835blC8Ep6tZxrBpr18gghZPgQM7YF5wQ1pxDyE0LpSIL5jmcrxJRQUWyvg=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2447.namprd18.prod.outlook.com (20.179.82.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 10 Oct 2019 20:25:29 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763%3]) with mapi id 15.20.2327.026; Thu, 10 Oct 2019
 20:25:29 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 12/19] EDAC: Store error type in struct edac_raw_error_desc
Thread-Topic: [PATCH 12/19] EDAC: Store error type in struct
 edac_raw_error_desc
Thread-Index: AQHVf6jbve5vRxDO20qtSKMm5w5VjQ==
Date:   Thu, 10 Oct 2019 20:25:29 +0000
Message-ID: <20191010202418.25098-13-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: 79c5f0f9-cfdd-4b3c-60ab-08d74dbffde7
x-ms-traffictypediagnostic: MN2PR18MB2447:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB24473F0B037641BC3ABEFC16D9940@MN2PR18MB2447.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 018632C080
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(199004)(189003)(6512007)(476003)(8936002)(25786009)(50226002)(8676002)(81156014)(81166006)(14444005)(7736002)(305945005)(256004)(486006)(14454004)(2616005)(6436002)(86362001)(66066001)(36756003)(66946007)(66476007)(66556008)(64756008)(66446008)(11346002)(446003)(71190400001)(71200400001)(6486002)(186003)(478600001)(5660300002)(386003)(316002)(3846002)(26005)(4326008)(6116002)(2906002)(52116002)(76176011)(99286004)(54906003)(110136005)(6506007)(102836004)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2447;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BTHqc+tddcs+I7SPB/Ecm+amnGE0NzP+MPYPQvq5DFgoQ6EHqjzDIhahdck8jd5A4nLbLrY//tAd7TBZrzWzbcQFZ/CUYtnfhEnEh/tawZtCmbVu2G35rAZhCCBFI0aArvTAkmrG6eu7cYhm8+XXO15oCreE+ZppxBlbZi0OtcEXustvoLVyFoEgSSkWJ1baToAl1d/jh892PNTXT29KHDaccCod7YbLi2U4pjvi3h/jrRfPjYkZXPqEC+1mGwdZMcQ91Yu2tjdhbuvNIv51ssTblE8MPwbBxH7gLuP8IVdxt8Chs9l9kTzy7hbab0KjMeH9B+RmikQmoaITfx821SWQJ41FTQVzR07kdhVb9f1qmn0wsBPKZOf7r18xpENX7zW1ElcGuUzG354DjRHyz7StE8+FOXmBxjb53ut0SFE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c5f0f9-cfdd-4b3c-60ab-08d74dbffde7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 20:25:29.1425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ufosMd5oxkXrrU8ZPr+hUjs2Wy/SSg4D4av5mbXzGMiMqEzmF19mou3ZE7O8g/KI4M02EB8pHLwWU7Bw24WlIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2447
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-10_07:2019-10-10,2019-10-10 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Store the error type in struct edac_raw_error_desc. This makes the
type parameter of edac_raw_mc_handle_error() obsolete.

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/edac_mc.c   |  8 ++++----
 drivers/edac/edac_mc.h   |  4 +---
 drivers/edac/ghes_edac.c | 13 ++++++-------
 include/linux/edac.h     |  1 +
 4 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index cdfb383f7a35..ca206854b8ee 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -1040,15 +1040,14 @@ static void edac_ue_error(struct mem_ctl_info *mci,
 	edac_inc_ue_error(mci, dimm, error_count);
 }
=20
-void edac_raw_mc_handle_error(const enum hw_event_mc_err_type type,
-			      struct mem_ctl_info *mci,
+void edac_raw_mc_handle_error(struct mem_ctl_info *mci,
 			      struct dimm_info *dimm,
 			      struct edac_raw_error_desc *e)
 {
 	char detail[80];
=20
 	/* Memory type dependent details about the error */
-	if (type =3D=3D HW_EVENT_ERR_CORRECTED) {
+	if (e->type =3D=3D HW_EVENT_ERR_CORRECTED) {
 		snprintf(detail, sizeof(detail),
 			"page:0x%lx offset:0x%lx grain:%ld syndrome:0x%lx",
 			e->page_frame_number, e->offset_in_page,
@@ -1095,6 +1094,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
type type,
 	/* Fills the error report buffer */
 	memset(e, 0, sizeof (*e));
 	e->error_count =3D error_count;
+	e->type =3D type;
 	e->top_layer =3D top_layer;
 	e->mid_layer =3D mid_layer;
 	e->low_layer =3D low_layer;
@@ -1243,6 +1243,6 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
type type,
=20
 	dimm =3D edac_get_dimm(mci, top_layer, mid_layer, low_layer);
=20
-	edac_raw_mc_handle_error(type, mci, dimm, e);
+	edac_raw_mc_handle_error(mci, dimm, e);
 }
 EXPORT_SYMBOL_GPL(edac_mc_handle_error);
diff --git a/drivers/edac/edac_mc.h b/drivers/edac/edac_mc.h
index 2c3e2fbcedc4..a8f1b5b5e873 100644
--- a/drivers/edac/edac_mc.h
+++ b/drivers/edac/edac_mc.h
@@ -212,7 +212,6 @@ extern int edac_mc_find_csrow_by_page(struct mem_ctl_in=
fo *mci,
  * edac_raw_mc_handle_error() - Reports a memory event to userspace withou=
t
  *	doing anything to discover the error location.
  *
- * @type:		severity of the error (CE/UE/Fatal)
  * @mci:		a struct mem_ctl_info pointer
  * @dimm:		a struct dimm_info pointer
  * @e:			error description
@@ -221,8 +220,7 @@ extern int edac_mc_find_csrow_by_page(struct mem_ctl_in=
fo *mci,
  * only be called directly when the hardware error come directly from BIOS=
,
  * like in the case of APEI GHES driver.
  */
-void edac_raw_mc_handle_error(const enum hw_event_mc_err_type type,
-			      struct mem_ctl_info *mci,
+void edac_raw_mc_handle_error(struct mem_ctl_info *mci,
 			      struct dimm_info *dimm,
 			      struct edac_raw_error_desc *e);
=20
diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 4f5721cf4380..1db1c012bed9 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -194,7 +194,6 @@ static void ghes_edac_dmidecode(const struct dmi_header=
 *dh, void *arg)
 void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 {
 	struct dimm_info *dimm;
-	enum hw_event_mc_err_type type;
 	struct edac_raw_error_desc *e;
 	struct mem_ctl_info *mci;
 	struct ghes_edac_pvt *pvt =3D ghes_pvt;
@@ -232,17 +231,17 @@ void ghes_edac_report_mem_error(int sev, struct cper_=
sec_mem_err *mem_err)
=20
 	switch (sev) {
 	case GHES_SEV_CORRECTED:
-		type =3D HW_EVENT_ERR_CORRECTED;
+		e->type =3D HW_EVENT_ERR_CORRECTED;
 		break;
 	case GHES_SEV_RECOVERABLE:
-		type =3D HW_EVENT_ERR_UNCORRECTED;
+		e->type =3D HW_EVENT_ERR_UNCORRECTED;
 		break;
 	case GHES_SEV_PANIC:
-		type =3D HW_EVENT_ERR_FATAL;
+		e->type =3D HW_EVENT_ERR_FATAL;
 		break;
 	default:
 	case GHES_SEV_NO:
-		type =3D HW_EVENT_ERR_INFO;
+		e->type =3D HW_EVENT_ERR_INFO;
 	}
=20
 	edac_dbg(1, "error validation_bits: 0x%08llx\n",
@@ -433,14 +432,14 @@ void ghes_edac_report_mem_error(int sev, struct cper_=
sec_mem_err *mem_err)
 	grain_bits =3D fls_long(e->grain);
 	snprintf(pvt->detail_location, sizeof(pvt->detail_location),
 		 "APEI location: %s %s", e->location, e->other_detail);
-	trace_mc_event(type, e->msg, e->label, e->error_count,
+	trace_mc_event(e->type, e->msg, e->label, e->error_count,
 		       mci->mc_idx, e->top_layer, e->mid_layer, e->low_layer,
 		       (e->page_frame_number << PAGE_SHIFT) | e->offset_in_page,
 		       grain_bits, e->syndrome, pvt->detail_location);
=20
 	dimm =3D edac_get_dimm_by_index(mci, e->top_layer);
=20
-	edac_raw_mc_handle_error(type, mci, dimm, e);
+	edac_raw_mc_handle_error(mci, dimm, e);
=20
 	spin_unlock_irqrestore(&ghes_lock, flags);
 }
diff --git a/include/linux/edac.h b/include/linux/edac.h
index 4d9673954856..587c53b87fdf 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -463,6 +463,7 @@ struct edac_raw_error_desc {
 	long grain;
=20
 	u16 error_count;
+	enum hw_event_mc_err_type type;
 	int top_layer;
 	int mid_layer;
 	int low_layer;
--=20
2.20.1

