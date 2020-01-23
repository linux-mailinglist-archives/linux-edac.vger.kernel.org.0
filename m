Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9968D146414
	for <lists+linux-edac@lfdr.de>; Thu, 23 Jan 2020 10:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgAWJDT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Jan 2020 04:03:19 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:23614 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728899AbgAWJDS (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 23 Jan 2020 04:03:18 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00N90NT9023653;
        Thu, 23 Jan 2020 01:03:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=fE2AQyxU/cCcMUG3PJuAjwUgEbMalu8cPmxnqqIncfY=;
 b=APj2XSWbOJaYwWXfpIqeJR3oIgZ39OTWOu4aYRMzs0Ldh6QQhZRoagV4sIjFEwTKhtZp
 zydTWB2wZDGPjV7xYo+gzReqHGHCCXXKOLale+ZwQmkDQfRoCtAWmoGLdlyaNWV32kmw
 f576aORVSKmzJoQ5gFeJ5+K+jlzLJtekEIAQGvqFy4jTYNwT+0RLIYiH493g/7hGZ0AT
 iHJUm+5ZeOy317KzqRm/vD5lNYJWNCaCpH9GfNjp3rteUJFMPF7ndzoRz+8zeq6vOdZx
 Ks9E0pAw4smkihoKtglqf7h9d+U+FzzwOxuOq+PgfrTiVWkYohDaA9V1ZqJY89z4Ia+/ ng== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2xq4x4gqwn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 23 Jan 2020 01:03:09 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 23 Jan
 2020 01:03:08 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 23 Jan 2020 01:03:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0BZA+AlrWFu/kMo8A7AL1lrfOdq5r97Ulh+LkOOH+YWxX6K89cVc6jyhDwWpNmiDlQ60tQxPKF6EMFOMx4hBpmIrjXjJGSIjDlWpeQ5/mwSe7BjjMzcHhNunzAbuZekmKVYeuDC4J3Dr0HGI+z3884jJE7aoWwr4DX3kvjbxZ+dMXVCZ9KiGD9uCb+BqijEPD5xnJGIL+bzpQ+l42PX8bqh12oWyiTXFrXnDTTTKT6XE0T9qzo65nwr7b+0YEsXFtBjOZl3rzh4JZqaYxvYs3Lb5KcZsyPz714mYlDpsul8Hy95jW5i8xjZ5/ZoPxM/J+CKjA15f8xvA6z0c5xtlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fE2AQyxU/cCcMUG3PJuAjwUgEbMalu8cPmxnqqIncfY=;
 b=b5mmHw2mLfj+gOJsJ6YhwlIt2NDM+pCFjEii+8uu4Zym2sx5Se7bAlIyPUK5Xi5BjuLLjGe4Ttn0yAJphJaxOCjlM4DGAtRkevQXLOHQgq42XVWdEKw/rkuztfSrGqF2EhGIJ0ybRGbZYMt21zPMB4UMx8He5i8LEswu95ybkBt70Pc98tfHleVDSchgAClKva1C4ImzSXNnnH4o79Sky3k2jDPDYOZazJbPmCEAvR7upHpTCDl70Z/4J7DR3woPzpy+zB3EBYwbNFIlDlCh1Sp9MsM6+omF2pURtSvW2V+VLl3b0dpt+0RR/a65EI4p4+qwWyf2KunPBW+hZbvwiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fE2AQyxU/cCcMUG3PJuAjwUgEbMalu8cPmxnqqIncfY=;
 b=A9c8xi7hQo9PYs+ZFdTtU+zaZoqmj/O1ZM0CPvtQzCBvnJ22tuACfkmt6/ALuLzu1bku68LIsApAW7vaTHzYKqop739IQYROvZR/EHEdfIUTdyaEZdoBZ2Js0vCplI5/fKNKaqt9EM1rzTjCiKTtd/u2+QtCd/cw2L9P+54u3uk=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3247.namprd18.prod.outlook.com (10.255.237.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Thu, 23 Jan 2020 09:03:07 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea%7]) with mapi id 15.20.2644.028; Thu, 23 Jan 2020
 09:03:07 +0000
Received: from rric.localdomain (31.208.96.227) by HE1PR0902CA0010.eurprd09.prod.outlook.com (2603:10a6:3:e5::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend Transport; Thu, 23 Jan 2020 09:03:05 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 09/10] EDAC/mc: Remove detail[] string and cleanup error
 string generation
Thread-Topic: [PATCH v3 09/10] EDAC/mc: Remove detail[] string and cleanup
 error string generation
Thread-Index: AQHV0cvtQfuhM7KLJku6wzmNeEiLsg==
Date:   Thu, 23 Jan 2020 09:03:06 +0000
Message-ID: <20200123090210.26933-10-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: c394bfd5-5ef1-4d88-a1ad-08d79fe30fc2
x-ms-traffictypediagnostic: MN2PR18MB3247:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB3247ADBCFFC4A637EB858339D90F0@MN2PR18MB3247.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(366004)(396003)(39850400004)(376002)(199004)(189003)(110136005)(66946007)(52116002)(6512007)(66476007)(66556008)(64756008)(66446008)(54906003)(478600001)(1076003)(5660300002)(956004)(2616005)(6486002)(6506007)(36756003)(2906002)(81156014)(8676002)(86362001)(26005)(81166006)(8936002)(71200400001)(4326008)(186003)(316002)(16526019);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3247;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1hKaCyANnimAIGXpwXSAwnSNcxXf5PTokPxVWzUDnTk2dTitI5W33z1cua9CUeYSnt2vV5v9M9B5QLCwijpCr5Dp0Dv+P2x0KIzK7TRwmNqyC1wdzeHfUmaJk3LK+p/WY1upqr2SWese2sqbBWkhR+emPKIkWi+lBjXSTXEAAn9uzQyvi6rizDuM5U95nOKwAb03r6mEIfuzAEptokVuGdgjM1/jN5kMrOtC5dcQZqyPbgwlTR17+IMhadiIvWP2iZnbG1IgjtLyrBGFGH80ARheS/T65lsf2j0skMJv/6M+s4tqrLoY9AANsIPFFLwIC7NSoTbsvt/u83sUGU3QWBMnKVfIrKZ6MxvpjCYv9ondL8GEg+6keitKREwlBHSl/+spAQgEsL7YQLxm8qMuh5shMa+5UErBaecGURTLgYRQU3dIyxbAV50AtyfIGgNt
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c394bfd5-5ef1-4d88-a1ad-08d79fe30fc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 09:03:06.9609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QLSM2ewPGmWrxqOSo9rzBHJsH5fhgcnt6sSG9m63rst7y/LeKFf0ehGf4+hiM+zsfRXbRSskiYPTwlJDroMDpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3247
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-22_08:2020-01-22,2020-01-22 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The error descriptor is passed to the error reporting functions, so
the error details can be directly generated there. Move string
generation from edac_raw_mc_handle_error() to edac_ce_error() and
edac_ue_error(). The intermediate detail[] string can be removed then.

Also, cleanup the string generation by switching to a single variant
only using the ternary operator.

Signed-off-by: Robert Richter <rrichter@marvell.com>
Acked-by: Aristeu Rozanski <aris@redhat.com>
---
 drivers/edac/edac_mc.c | 83 +++++++++++++-----------------------------
 1 file changed, 25 insertions(+), 58 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index c71af845ef16..60639def8697 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -995,27 +995,18 @@ static void edac_inc_ue_error(struct edac_raw_error_d=
esc *e)
 	}
 }
=20
-static void edac_ce_error(struct edac_raw_error_desc *e,
-			  const char *detail)
+static void edac_ce_error(struct edac_raw_error_desc *e)
 {
 	struct mem_ctl_info *mci =3D error_desc_to_mci(e);
 	unsigned long remapped_page;
-	char *msg_aux =3D "";
-
-	if (*e->msg)
-		msg_aux =3D " ";
=20
 	if (edac_mc_get_log_ce()) {
-		if (e->other_detail && *e->other_detail)
-			edac_mc_printk(mci, KERN_WARNING,
-				       "%d CE %s%son %s (%s %s - %s)\n",
-				       e->error_count, e->msg, msg_aux, e->label,
-				       e->location, detail, e->other_detail);
-		else
-			edac_mc_printk(mci, KERN_WARNING,
-				       "%d CE %s%son %s (%s %s)\n",
-				       e->error_count, e->msg, msg_aux, e->label,
-				       e->location, detail);
+		edac_mc_printk(mci, KERN_WARNING,
+			"%d CE %s%son %s (%s page:0x%lx offset:0x%lx grain:%ld syndrome:0x%lx%s=
%s)\n",
+			e->error_count, e->msg, *e->msg ? " " : "", e->label,
+			e->location, e->page_frame_number, e->offset_in_page,
+			e->grain, e->syndrome, *e->other_detail ? " - " : "",
+			e->other_detail);
 	}
=20
 	edac_inc_ce_error(e);
@@ -1040,36 +1031,24 @@ static void edac_ce_error(struct edac_raw_error_des=
c *e,
 	}
 }
=20
-static void edac_ue_error(struct edac_raw_error_desc *e,
-			  const char *detail)
+static void edac_ue_error(struct edac_raw_error_desc *e)
 {
 	struct mem_ctl_info *mci =3D error_desc_to_mci(e);
-	char *msg_aux =3D "";
-
-	if (*e->msg)
-		msg_aux =3D " ";
=20
 	if (edac_mc_get_log_ue()) {
-		if (e->other_detail && *e->other_detail)
-			edac_mc_printk(mci, KERN_WARNING,
-				       "%d UE %s%son %s (%s %s - %s)\n",
-				       e->error_count, e->msg, msg_aux, e->label,
-				       e->location, detail, e->other_detail);
-		else
-			edac_mc_printk(mci, KERN_WARNING,
-				       "%d UE %s%son %s (%s %s)\n",
-				       e->error_count, e->msg, msg_aux, e->label,
-				       e->location, detail);
+		edac_mc_printk(mci, KERN_WARNING,
+			"%d UE %s%son %s (%s page:0x%lx offset:0x%lx grain:%ld%s%s)\n",
+			e->error_count, e->msg, *e->msg ? " " : "", e->label,
+			e->location, e->page_frame_number, e->offset_in_page,
+			e->grain, *e->other_detail ? " - " : "",
+			e->other_detail);
 	}
=20
 	if (edac_mc_get_panic_on_ue()) {
-		if (e->other_detail && *e->other_detail)
-			panic("UE %s%son %s (%s%s - %s)\n",
-			      e->msg, msg_aux, e->label, e->location, detail,
-			      e->other_detail);
-		else
-			panic("UE %s%son %s (%s%s)\n",
-			      e->msg, msg_aux, e->label, e->location, detail);
+		panic("UE %s%son %s (%s page:0x%lx offset:0x%lx grain:%ld%s%s)\n",
+			e->msg, *e->msg ? " " : "", e->label, e->location,
+			e->page_frame_number, e->offset_in_page, e->grain,
+			*e->other_detail ? " - " : "", e->other_detail);
 	}
=20
 	edac_inc_ue_error(e);
@@ -1098,7 +1077,6 @@ static void edac_inc_csrow(struct edac_raw_error_desc=
 *e, int row, int chan)
 void edac_raw_mc_handle_error(struct edac_raw_error_desc *e)
 {
 	struct mem_ctl_info *mci =3D error_desc_to_mci(e);
-	char detail[80];
 	u8 grain_bits;
=20
 	/* Sanity-check driver-supplied grain value. */
@@ -1115,22 +1093,10 @@ void edac_raw_mc_handle_error(struct edac_raw_error=
_desc *e)
 			       (e->page_frame_number << PAGE_SHIFT) | e->offset_in_page,
 			       grain_bits, e->syndrome, e->other_detail);
=20
-	/* Memory type dependent details about the error */
-	if (e->type =3D=3D HW_EVENT_ERR_CORRECTED) {
-		snprintf(detail, sizeof(detail),
-			"page:0x%lx offset:0x%lx grain:%ld syndrome:0x%lx",
-			e->page_frame_number, e->offset_in_page,
-			e->grain, e->syndrome);
-		edac_ce_error(e, detail);
-	} else {
-		snprintf(detail, sizeof(detail),
-			"page:0x%lx offset:0x%lx grain:%ld",
-			e->page_frame_number, e->offset_in_page, e->grain);
-
-		edac_ue_error(e, detail);
-	}
-
-
+	if (e->type =3D=3D HW_EVENT_ERR_CORRECTED)
+		edac_ce_error(e);
+	else
+		edac_ue_error(e);
 }
 EXPORT_SYMBOL_GPL(edac_raw_mc_handle_error);
=20
@@ -1166,8 +1132,9 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
type type,
 	e->page_frame_number =3D page_frame_number;
 	e->offset_in_page =3D offset_in_page;
 	e->syndrome =3D syndrome;
-	e->msg =3D msg;
-	e->other_detail =3D other_detail;
+	/* need valid strings here for both: */
+	e->msg =3D msg ? msg : "";
+	e->other_detail =3D other_detail ? other_detail : "";
=20
 	/*
 	 * Check if the event report is consistent and if the memory
--=20
2.20.1

