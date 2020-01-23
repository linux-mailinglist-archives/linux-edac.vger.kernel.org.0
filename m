Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFEE14641F
	for <lists+linux-edac@lfdr.de>; Thu, 23 Jan 2020 10:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgAWJDp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Jan 2020 04:03:45 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:48808 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726194AbgAWJDp (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 23 Jan 2020 04:03:45 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00N90d8c023738;
        Thu, 23 Jan 2020 01:02:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=7L5zpdjJ9AFTNz7nqpQNB+kfqsuvsfqwA4gKEAy8/yg=;
 b=EmIVpNaK/uhMFnmlrIC3tSw2pmq14kt+Zvl4ZlqQ78z9zO+FnLQSAGPBOQokTeQ8bLjL
 J978FpFLAA9Ko4rBVtqu5XuipgP9eF/OPpcKI/xL52I2bzGPWuZe906CfjHOsbW1iHLi
 8/M5ri3oxkj5XO6SOy6og+Zvg6nuIr/OsYAcPVZzHwnECsGWIhkSldO0rw8XoPCze5hU
 R+xOU15lJlj2LAxONRl18BV3L4xy9pEVbSBdnUak21VyBs1/ImB/5U9nm/vjdRiRYSgZ
 +lHeIC8b2sKnZXsWTT2xQF7R0oHIUMNIdf8Dn8zCBBl231od60Xvip/7T70bqewssP+i sQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2xq4x4gqvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 23 Jan 2020 01:02:57 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 23 Jan
 2020 01:02:55 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.59) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 23 Jan 2020 01:02:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SP/TZeFW8pbO8VB+s690RFMmFxOt9cXkoFZfsTNMOzDdAVYIXryDyAgovSpllt0Bk8KTxIqz3RqaLn2EDzhB9vnz9yA4P6zXLD5xTq1A5ZIDFAzCmnejS/J1h2Zx8uYSjZHpRvUZmDKRWBD/osZuJwTGmlJuxxk+NpPG2ZomU1hawn3arYIJQSoOUXOoad/rlDnyyhSlbQxzHp6/oQGBbQUcSPtghvWRjHpLJ/I7S7mVGZvMDApiMCKYiKVwimZrBQEtTgw7ux2y59Pg69O/F1Bw5YaO0tuYjqnzeyfXaGEaoKOU8xVXVpSvv4u1udXmJVlrNcNlQKRKHaoG0FHbgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7L5zpdjJ9AFTNz7nqpQNB+kfqsuvsfqwA4gKEAy8/yg=;
 b=ks13gIG13sbFpewBoutH/Pv2s/iRp4CBKQQSvBq9w5aMMOOIqopkuG1G73rx/VEqod1tVy0IbXYGaVPxLdezrgyjgs+ZiAZmCQr6UA+QbtfnKNHgytLr4fy1c2rgCSC8EYyg4TMK1wAdmqm78v90wkzmpu62sbTSkVHE5sqNpEU2lZWC4QzRAhe/WojFhGaI0lZoFa0rRhaf4vjiq8ez5vZZ6z8OmEkKuIpr8tansKSTptpt3DQxa2pZZyaYrEKFRUu63z/4eU6fBY27WH6ZMSPNBFGqtq6g+BSD7lm4yxqTOP1iHdUVwV8UAfqWGhOP+8+d8I9tKzxwS/qzSVpokg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7L5zpdjJ9AFTNz7nqpQNB+kfqsuvsfqwA4gKEAy8/yg=;
 b=SZsDxmLaE6laZkHwG+sumgxqXCzqQIF7HfjbDNGQ4LUran99d9sgGykGsNwQjnTQ2WfDDSqlvdeD1dR9bkDOmOSsO4kexUJA0EX/F/5aaPfFX9eKKiAeFmu3tjRNcFInqryLxp69Wo8vP4+DwlabSYs9kew6CTpX0MMm1DWzYiE=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3247.namprd18.prod.outlook.com (10.255.237.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Thu, 23 Jan 2020 09:02:54 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea%7]) with mapi id 15.20.2644.028; Thu, 23 Jan 2020
 09:02:54 +0000
Received: from rric.localdomain (31.208.96.227) by HE1PR0902CA0010.eurprd09.prod.outlook.com (2603:10a6:3:e5::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend Transport; Thu, 23 Jan 2020 09:02:52 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH v3 03/10] EDAC: Store error type in struct edac_raw_error_desc
Thread-Topic: [PATCH v3 03/10] EDAC: Store error type in struct
 edac_raw_error_desc
Thread-Index: AQHV0cvm/jC4lc5uckebz748+umIeQ==
Date:   Thu, 23 Jan 2020 09:02:54 +0000
Message-ID: <20200123090210.26933-4-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: e69621b9-10da-4205-f1b7-08d79fe30866
x-ms-traffictypediagnostic: MN2PR18MB3247:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB32472B91D3E2C7001E89FE68D90F0@MN2PR18MB3247.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(366004)(396003)(39850400004)(376002)(199004)(189003)(110136005)(66946007)(52116002)(6512007)(66476007)(66556008)(64756008)(66446008)(54906003)(478600001)(1076003)(5660300002)(956004)(2616005)(6486002)(6506007)(36756003)(2906002)(81156014)(8676002)(86362001)(26005)(81166006)(8936002)(71200400001)(4326008)(186003)(316002)(16526019);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3247;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xdFYAMeXGZg+0uJFf1E8Q8CPbfeIxwo32+9jpl2iYUHS85JFh9bwOUjjhVhckkWtsrocWhpyHRYyzqTEBL3E6nJLgfRrF2Bp66M0XIckqiGTYeDhm5wO0QH5epI7QSq6fX/BfqleKlX9nnj0ste8SgiqNkxJaLeuTxPyY+14kCZSpgxAcDMIIi4mbKHNahb83mYiE8mh+/mm3RuVnRph0j6rAxZ+/bl5Q8Ar5IOWFz9ua2VpluiVz7p+2w2zRABEz7lEPhyr8kZ8pSSniBTi8COXKsBu0wKsPCGPD/kpbfMEykjM1O01dDUjMAsyWT+9i23P22QTCOoLDAfyt/Mo2jGYBGYgCDKutaX6rcsdeXuvlVwHuSzhLMSHLrVHZa8pLDmpnVXz4Szd1zxzARm9Cc5Mbc61cYMTILzhwK6drPcPFBWrGRtIGJDgn3DlwWoR
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e69621b9-10da-4205-f1b7-08d79fe30866
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 09:02:54.5030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XtFLa77ZttG2cIOJF/XpgzkFPdJv3myJe3OHX30GTN2dg/JZOFOAoFIjAnVUfZlKREKmJa95IjQkE7hOZLZGMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3247
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-22_08:2020-01-22,2020-01-22 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Store the error type in struct edac_raw_error_desc. This makes the
type parameter of edac_raw_mc_handle_error() obsolete.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Robert Richter <rrichter@marvell.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Acked-by: Aristeu Rozanski <aris@redhat.com>
---
 drivers/edac/edac_mc.c   | 10 +++++-----
 drivers/edac/edac_mc.h   |  4 +---
 drivers/edac/ghes_edac.c | 11 +++++------
 include/linux/edac.h     |  2 ++
 4 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 1e227e69e216..8ef69d24297d 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -1086,8 +1086,7 @@ static void edac_ue_error(struct mem_ctl_info *mci,
 	edac_inc_ue_error(mci, enable_per_layer_report, pos, error_count);
 }
=20
-void edac_raw_mc_handle_error(const enum hw_event_mc_err_type type,
-			      struct mem_ctl_info *mci,
+void edac_raw_mc_handle_error(struct mem_ctl_info *mci,
 			      struct edac_raw_error_desc *e)
 {
 	char detail[80];
@@ -1102,14 +1101,14 @@ void edac_raw_mc_handle_error(const enum hw_event_m=
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
@@ -1154,6 +1153,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
type type,
 	/* Fills the error report buffer */
 	memset(e, 0, sizeof (*e));
 	e->error_count =3D error_count;
+	e->type =3D type;
 	e->top_layer =3D top_layer;
 	e->mid_layer =3D mid_layer;
 	e->low_layer =3D low_layer;
@@ -1284,6 +1284,6 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
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

