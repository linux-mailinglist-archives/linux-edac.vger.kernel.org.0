Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7FAF1252
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2019 10:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731826AbfKFJd7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Nov 2019 04:33:59 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:34498 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731810AbfKFJd7 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 6 Nov 2019 04:33:59 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA69VFnN027198;
        Wed, 6 Nov 2019 01:33:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=T0K/P1k0RnHk2WGAsEbJojKAoqWQ5kxuwGXoqt/OUuw=;
 b=HgXBrmd17NCpppk7txBmnOLAVWzNBp+LKrv2NTMSBhPfXbVYs3lXFkHYuOIJ13borkJA
 sry1knUZeaGkIM5wmO5YlJeUOwIpk3vw2VgDP3LoIsW9ueELzmoqoURZnREOtxJD6lAk
 7ACwb2sWfVN6WBXERZn7rlRGKt98Xwt3ZJIVTeLeab+/w/zirVbrIZT1qmBNEcbZ6COK
 InYu3jhpBImsO3njUyWjnBRTNo8Hbi/PtZZ4zgqtfsZtuIH2uVc9FDGon1ZvtK9QxBtn
 HT9J69ZnMVpb7ZgorpcYli6aylLcbeK265Pp7rZ2WJbDE3oWPjnkgrHKpWanfLVkIXdX vQ== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2w19amyam6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 01:33:46 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 6 Nov
 2019 01:33:44 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.50) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 6 Nov 2019 01:33:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jceqQsDsfhtLDMVazrO/oB8H0LbOMax0JkntdZZg9Gmp8nlFWiqB+h9bWZDgx36hxCIYOwfko62XVDWU/oJf2qxrrh6I++l5pZ4VgPiEymgDNLd6B6DomScT7wvDL7PlmtqSg/6ZEoEWj39+7/1wMiBFEA0Can94D7xmoYe6lSFgAqZ3lgZeUi1U9S1kP9tlsfmEH7XFpYUePeAVhIbknswtP6VwSrvQS1XTDaQO8xGceJBdKRoBFsld/GDIZYvAhaC84PUbYGg5wLrLx5VnYtzc0yK8fUEp0q37VXcM3ddxe/qNpl677sEUoZPOGv9y2mOEUUeV4HP068/8EROOBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0K/P1k0RnHk2WGAsEbJojKAoqWQ5kxuwGXoqt/OUuw=;
 b=cRt1S8vNnJzufz7sOJUsaV4iI/LT1KCAmqLTBHpX7nbPwtrJcPpTADgiz3iUFCmQdRrC3gwDrYS56Sn8T4Z5752E+tbGBVF+RrnuOvWZL2WlQhzBWB+RA/Siv1bZMhH2Wiu+hIvg4TAVk1pjbVw+8iwjn+6//YoBQd8V1K0vofJmxH46n2jzB+/D1jAoJehbshFJx4feW0my7QGYPzio6gARQ/tYObQKUgdUlevijuU8GbRavJMRoFzHx3sUmvGflZnqCL+fvP/HRmNW0RWJJMlxFq1JGLx+oIqsasq+0PZ+kH/mfo+5eFlI+1XSfzfDvPQjbOA39LFn78JT1ivHtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0K/P1k0RnHk2WGAsEbJojKAoqWQ5kxuwGXoqt/OUuw=;
 b=GXeccZ3Q5+tqOysZV6iuvRHo+eEndEhryvTStYZp0e/ykwqdXsrKqJpWFj3d7eFwzbihkjsdte7rFyGCP3hursXrYtjzhi6YxOwroXZlSd7+KL0HCjB8OmhPWF/b5L17CUxor7i2mEhZDdnWJMvbzDnraqr/b4JIdIO7OW0OjUM=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3165.namprd18.prod.outlook.com (10.255.236.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 6 Nov 2019 09:33:42 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6%6]) with mapi id 15.20.2430.020; Wed, 6 Nov 2019
 09:33:42 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 18/20] EDAC: Store error type in struct edac_raw_error_desc
Thread-Topic: [PATCH v2 18/20] EDAC: Store error type in struct
 edac_raw_error_desc
Thread-Index: AQHVlIVG4kntlIthJ0iEna0CMb2/Dg==
Date:   Wed, 6 Nov 2019 09:33:41 +0000
Message-ID: <20191106093239.25517-19-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: 4d2fde45-5090-4ed7-3801-08d7629c6939
x-ms-traffictypediagnostic: MN2PR18MB3165:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB316506634D933DCB2A9903C8D9790@MN2PR18MB3165.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(199004)(189003)(52116002)(305945005)(6486002)(76176011)(71190400001)(71200400001)(256004)(11346002)(446003)(7736002)(14444005)(6436002)(4326008)(6512007)(66446008)(66556008)(66476007)(66946007)(64756008)(5660300002)(1076003)(476003)(6116002)(3846002)(110136005)(54906003)(36756003)(2906002)(8676002)(99286004)(81166006)(81156014)(316002)(8936002)(50226002)(486006)(6506007)(386003)(102836004)(66066001)(2616005)(86362001)(478600001)(25786009)(186003)(14454004)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3165;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FGQXzpo4kofIk6LW+dPvAMkaTyMUZZiZzmrFNjXTMCMUYJHrSArNTGaE/I1K9yYGtkmDQNUaw05sefeEqdzhH4noVDiWUMVMTjDqMc8nDwsOC1lWHU2pASXtmhl2YBuLHcCVbmw69D66gWHDdbw6MrxbOtqfcK6Du1VMtEEPPFlEi1CKMlRUfrNEmQ2G0/IFw88DlDTseAyl8hic0QP8KPO6zyeKJgiDPEugzWad1EJ6INfIe4Eak8PWarP25dcABhjGAqksKttPiowm48GPcnfU9kPOGZYqxQuIrOYxedPQFVGhSfZp2maYC2NVhh9iFtvnPgesc2sV6GAw4kAZYH46fxXaTl7Rw9o3NUURq9jt9HV3ST2Mn1BUWo4AcATPQqM5PnlKDDQm/CHjXoIdbovK5q1TntN/bA3MhCvXXkpR0/WB65+ZwmARVcGn8GFV
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d2fde45-5090-4ed7-3801-08d7629c6939
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 09:33:41.8580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tWOz7mghJ1S7ChdUZBQYdetMpKxe2/k+FemrVymKEsRJqN76/FkaI7xtmyiKB8kg4popj4FFqmYNZmJ+eokP3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3165
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_02:2019-11-06,2019-11-06 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Store the error type in struct edac_raw_error_desc. This makes the
type parameter of edac_raw_mc_handle_error() obsolete.

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/edac_mc.c   | 10 +++++-----
 drivers/edac/edac_mc.h   |  4 +---
 drivers/edac/ghes_edac.c | 11 +++++------
 include/linux/edac.h     |  1 +
 4 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index e4a11218009b..7b4f5e98dfe8 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -1040,8 +1040,7 @@ static void edac_ue_error(struct mem_ctl_info *mci,
 	edac_inc_ue_error(mci, dimm, error_count);
 }
=20
-void edac_raw_mc_handle_error(const enum hw_event_mc_err_type type,
-			      struct mem_ctl_info *mci,
+void edac_raw_mc_handle_error(struct mem_ctl_info *mci,
 			      struct dimm_info *dimm,
 			      struct edac_raw_error_desc *e)
 {
@@ -1056,14 +1055,14 @@ void edac_raw_mc_handle_error(const enum hw_event_m=
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
@@ -1109,6 +1108,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
type type,
 	/* Fills the error report buffer */
 	memset(e, 0, sizeof (*e));
 	e->error_count =3D error_count;
+	e->type =3D type;
 	e->top_layer =3D top_layer;
 	e->mid_layer =3D mid_layer;
 	e->low_layer =3D low_layer;
@@ -1242,6 +1242,6 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
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
index 6eebaf28e31c..7d325d70d6d3 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -202,7 +202,6 @@ static void ghes_edac_dmidecode(const struct dmi_header=
 *dh, void *arg)
 void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 {
 	struct dimm_info *dimm;
-	enum hw_event_mc_err_type type;
 	struct edac_raw_error_desc *e;
 	struct mem_ctl_info *mci;
 	struct ghes_edac_pvt *pvt;
@@ -241,17 +240,17 @@ void ghes_edac_report_mem_error(int sev, struct cper_=
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
=20
 	dimm =3D edac_get_dimm_by_index(mci, e->top_layer);
=20
-	edac_raw_mc_handle_error(type, mci, dimm, e);
+	edac_raw_mc_handle_error(mci, dimm, e);
=20
 unlock:
 	spin_unlock_irqrestore(&ghes_lock, flags);
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

