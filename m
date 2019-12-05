Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B08B2113E3C
	for <lists+linux-edac@lfdr.de>; Thu,  5 Dec 2019 10:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbfLEJiP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 5 Dec 2019 04:38:15 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:20256 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729215AbfLEJiN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 5 Dec 2019 04:38:13 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB59b4jG023588;
        Thu, 5 Dec 2019 01:38:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=VcgVg3uNsxjAXMRsTRXPElCFXShVxk/CBxpn72jvrUY=;
 b=gvHokiDfALardjgCAm02HAcooTe0w2w9J4E/KSIXBrvOlEw76STX2KyTcWK1IiGRuJ+M
 Gul/9ihcuOtafK2klMX+HJCwQbDx+NqDb0ls2Wr1/HZ94AgCWc7Jh3q8LjVQb0RNMIu0
 3BxvdF4F2eIx/OeBzERBywkoGT7qUQ1CnjPui17Gtik5BrnPCIOLspwBsT5paAXfMMkV
 rX9YtcmBsKvZfPmigPUSD9q8sl011G1ypo6Zn+jKotS+2C6AgNNHxdzFsys9gaO3kixs
 2XgXHPyp9wBrOpHw6ytBvBYcMyUjtu8CWnDGke9p3LgOFlGVtNrKuOLfZkIoog8mXn/z tA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2wnvgvrcyq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 05 Dec 2019 01:38:03 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 5 Dec
 2019 01:38:03 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.55) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 5 Dec 2019 01:38:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R44g7vy9ZETo2XpG7TwEA/b9UtV+iW8aONDR5V9h7r/E4+sILFmL2hnVqbShOE7Q1m1sglgYlsOR5A3WTWS7wAmXzlHC9LHmaoI0pMXKC1x1cLneLGOY4T2wt/6cOKXfVLFe5EaWaKJGbE9+nOmQrhaYASVGiMK6abUw1o1HRoqMKlJT3uRMe7VTJdPNhVTso/t1OM0AMjrYTPv//dFU+/GIbKDdP+r6ymTMlkdROvb8Ct9bQXZrN9KPUU0ZH9HMpzCK0xjQaPjjporu4fqPJ5iAKbgPaYpLqby8aWThJsNR3MgE1sqCP83mVdXppyef9qdJ8MBNIbhnQJn0j4+iUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcgVg3uNsxjAXMRsTRXPElCFXShVxk/CBxpn72jvrUY=;
 b=P2rQemk92VsOyjWQnuog1X7SSYVf7qDoxxg4X9itajJEaJSye8wGN63ns09aNt82IIsegZbJ0NzuIdd4CCJjEIi/j8A5f/Fny5fQ6QGhGyiO9lrxEZ8jhgSGU6IrN/mO85AXIuiLVZOS1P4ez8QZ5OwX59L/nw5SzEPZBlnUAwjJxdD2JW9hAusacEyW4a1oxodzwgMhf/a/yeExevxFHwWdww56Pi8P9HIky1gVoTuyVeBH2IwgfsX5N61oGno2EXIm7axICSX3UhG3zkEnjDZkPs2nwG1GcXiun+yULtM4V9sHB68FfqMM6BHwCUX5XlrBoQpYzrkx1QMVPKDbHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcgVg3uNsxjAXMRsTRXPElCFXShVxk/CBxpn72jvrUY=;
 b=BG0ubPOmSpEpALan8OsOmLzqM8H5WuJO52JJisBK4aAFm7Ri0S12/NlC+ug3PjrRb4GG0+RNFCyPUjNTq1e5kfcl2YfyyD2I7kS2i/bDgwIbt4IhlSKoAryKMgLqnXP4GLGCeIEqGj4fR9LfacAnfQy/GbHIhf39BUvXFCc97d4=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2367.namprd18.prod.outlook.com (20.179.80.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Thu, 5 Dec 2019 09:38:02 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106%7]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 09:38:02 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kbuild test robot" <lkp@intel.com>
Subject: [PATCH v2 03/10] EDAC: Store error type in struct edac_raw_error_desc
Thread-Topic: [PATCH v2 03/10] EDAC: Store error type in struct
 edac_raw_error_desc
Thread-Index: AQHVq0+wAVwKV0n23Uap0dgfSroNbA==
Date:   Thu, 5 Dec 2019 09:38:02 +0000
Message-ID: <20191205093739.4040-4-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: bc4c514a-eab2-41e7-c8bd-08d77966d26e
x-ms-traffictypediagnostic: MN2PR18MB2367:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB23678974ED35E0A5FFA0E6EFD95C0@MN2PR18MB2367.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(189003)(199004)(81166006)(14444005)(14454004)(36756003)(6512007)(316002)(478600001)(54906003)(5660300002)(110136005)(186003)(8936002)(50226002)(6486002)(26005)(99286004)(66556008)(66476007)(81156014)(71190400001)(86362001)(66946007)(66446008)(64756008)(25786009)(8676002)(2906002)(71200400001)(6506007)(4326008)(2616005)(11346002)(102836004)(305945005)(1076003)(76176011)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2367;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tgmpy8AriyGpKImrwZnacIIF12rbdHb585o2s07JqLAw4oyAFYgo2ceimcVA99vrHri0GsDLcHP/xpIQMKKwRpmb2DxTlgWe4Lp+1JnsOZvPYRi0w0zqAQpYdh5i/aQbr9gUpTPYdbUHSXHfLebzQwIxZXJ9bgtA0E/R6JLTImaHy/uaWvqbqINXBxET/u1Q5RWzEoz2tSBl0fPsWgIhYwfh9pOYkomO3WJ/Ry6j3tRGImegU0gqxsiNzMYsUuFZuraDjiHiUjwtBufKBAkVJfF7QbZFB0Q8Xpcw2r+kv3aJICadD+6o5nYyBYPjb5aKY2EsJtB+DALDzo9wAXveLua3iO0ejA2wj4HDecgz7Qz5UsFdXPl9exctCj2NA0LDKRpADr1eQeP8KEDsnV2b55DJuTN0jd6/DqEEI5QorRQcY66WvC3AGHxeRIsaRuSH
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bc4c514a-eab2-41e7-c8bd-08d77966d26e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 09:38:02.2204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jt7oRtyIPqRh7+Dn1idaVAxarBlUM1ebOnsxjaSqHqoQjpT7uhWNBPBiq2bCjQykTJg4TXROrgo0elCf3P3Mqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2367
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-05_01:2019-12-04,2019-12-05 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Store the error type in struct edac_raw_error_desc. This makes the
type parameter of edac_raw_mc_handle_error() obsolete.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Robert Richter <rrichter@marvell.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 drivers/edac/edac_mc.c   | 10 +++++-----
 drivers/edac/edac_mc.h   |  4 +---
 drivers/edac/ghes_edac.c | 11 +++++------
 include/linux/edac.h     |  2 ++
 4 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index f2dee4e8ba85..ecab08032b4a 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -1084,8 +1084,7 @@ static void edac_ue_error(struct mem_ctl_info *mci,
 	edac_inc_ue_error(mci, enable_per_layer_report, pos, error_count);
 }
=20
-void edac_raw_mc_handle_error(const enum hw_event_mc_err_type type,
-			      struct mem_ctl_info *mci,
+void edac_raw_mc_handle_error(struct mem_ctl_info *mci,
 			      struct edac_raw_error_desc *e)
 {
 	char detail[80];
@@ -1100,14 +1099,14 @@ void edac_raw_mc_handle_error(const enum hw_event_m=
c_err_type type,
=20
 	/* Report the error via the trace interface */
 	if (IS_ENABLED(CONFIG_RAS))
-		trace_mc_event(type, e->msg, e->label, e->error_count,
+		trace_mc_event(e->type, e->msg, e->label, e->error_count,
 			       mci->mc_idx, e->top_layer, e->mid_layer,
 			       e->low_layer,
 			       (e->page_frame_number << PAGE_SHIFT) | e->offset_in_page,
 			       grain_bits, e->syndrome, e->other_detail);
=20
 	/* Memory type dependent details about the error */
-	if (type =3D=3D HW_EVENT_ERR_CORRECTED) {
+	if (e->type =3D=3D HW_EVENT_ERR_CORRECTED) {
 		snprintf(detail, sizeof(detail),
 			"page:0x%lx offset:0x%lx grain:%ld syndrome:0x%lx",
 			e->page_frame_number, e->offset_in_page,
@@ -1152,6 +1151,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
type type,
 	/* Fills the error report buffer */
 	memset(e, 0, sizeof (*e));
 	e->error_count =3D error_count;
+	e->type =3D type;
 	e->top_layer =3D top_layer;
 	e->mid_layer =3D mid_layer;
 	e->low_layer =3D low_layer;
@@ -1282,6 +1282,6 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
type type,
 	if (p > e->location)
 		*(p - 1) =3D '\0';
=20
-	edac_raw_mc_handle_error(type, mci, e);
+	edac_raw_mc_handle_error(mci, e);
 }
 EXPORT_SYMBOL_GPL(edac_mc_handle_error);
diff --git a/drivers/edac/edac_mc.h b/drivers/edac/edac_mc.h
index 02aac5c61d00..5d78be774f9e 100644
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
  * @e:			error description
  *
@@ -220,8 +219,7 @@ extern int edac_mc_find_csrow_by_page(struct mem_ctl_in=
fo *mci,
  * only be called directly when the hardware error come directly from BIOS=
,
  * like in the case of APEI GHES driver.
  */
-void edac_raw_mc_handle_error(const enum hw_event_mc_err_type type,
-			      struct mem_ctl_info *mci,
+void edac_raw_mc_handle_error(struct mem_ctl_info *mci,
 			      struct edac_raw_error_desc *e);
=20
 /**
diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index b99080d8a10c..7c3e5264a41e 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -201,7 +201,6 @@ static void ghes_edac_dmidecode(const struct dmi_header=
 *dh, void *arg)
=20
 void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 {
-	enum hw_event_mc_err_type type;
 	struct edac_raw_error_desc *e;
 	struct mem_ctl_info *mci;
 	struct ghes_edac_pvt *pvt;
@@ -240,17 +239,17 @@ void ghes_edac_report_mem_error(int sev, struct cper_=
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
@@ -442,7 +441,7 @@ void ghes_edac_report_mem_error(int sev, struct cper_se=
c_mem_err *mem_err)
 	if (p > pvt->other_detail)
 		*(p - 1) =3D '\0';
=20
-	edac_raw_mc_handle_error(type, mci, e);
+	edac_raw_mc_handle_error(mci, e);
=20
 unlock:
 	spin_unlock_irqrestore(&ghes_lock, flags);
diff --git a/include/linux/edac.h b/include/linux/edac.h
index cc31b9742684..6703eb492cd2 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -442,6 +442,7 @@ struct errcount_attribute_data {
  * struct edac_raw_error_desc - Raw error report structure
  * @grain:			minimum granularity for an error report, in bytes
  * @error_count:		number of errors of the same type
+ * @type:			severity of the error (CE/UE/Fatal)
  * @top_layer:			top layer of the error (layer[0])
  * @mid_layer:			middle layer of the error (layer[1])
  * @low_layer:			low layer of the error (layer[2])
@@ -462,6 +463,7 @@ struct edac_raw_error_desc {
 	long grain;
=20
 	u16 error_count;
+	enum hw_event_mc_err_type type;
 	int top_layer;
 	int mid_layer;
 	int low_layer;
--=20
2.20.1

