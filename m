Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0C610BFF1
	for <lists+linux-edac@lfdr.de>; Wed, 27 Nov 2019 22:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfK0VzC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 27 Nov 2019 16:55:02 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:42454 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727194AbfK0VzB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 27 Nov 2019 16:55:01 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xARLo17P005224;
        Wed, 27 Nov 2019 13:54:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=R+NmB3CHIrIyT8pz2/5npFRUY8xFJoKcObHAousD6aA=;
 b=iXThzT3JckANbDqdnQHgan7FI8TcxVVc2XoZ0scOH3NEdovvftUQSPM03FRrXgnbCvll
 w5JmY1nXzS9bRP+ZGN7r2KiTRQWybw6MzAXy6WMTKmGl0DMrtZrEhwvcoQXQxiRO6nms
 Y/hCnyAiO96wft+bVzvyNzJHg66WzRYDkjzI/DZteBQZbU09pH4zU5uZFvgCjo15z9yV
 rMvXCVvadj3MZgl3el6pQUPo1aSuE+sIUmSQw8Jjvatcr7nXdRbRJX5Bg5szO9h+zMPj
 vmVBy8VM5nvwJj2RoQCz6UIRFChlHymAIGhnxD+inUkEQxbHfC/bZm3U1/HAnY5qkRN7 uA== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2whd08mrd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 27 Nov 2019 13:54:53 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 27 Nov
 2019 13:54:51 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.58) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 27 Nov 2019 13:54:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWhCmyXnkqtGk3ZZk/htec8Y0DbsDj9PxDcgs9+HOYf1UBU9Z2XdqvrtypgLI6j4W3Xqo93zBzqFXl+Rdt8D8cF27eJKYtxM11QtxEsSHX8O2elGGizyzg1xRwXjZiiIUivzhz4zZrWyQFa14+8e5aoGOTOyWQAxcPEjecv+P55LqeXVrKgMV+FdjJwsGpvcNhSKoEMpzMfbrexL6ArEZjFmeA4BtGD+OrCtfiVtdJsd1IfjfbtuV4h0GaRxEAHeX5q0FEstO3pulpwQVr379obHeVEFGCNn0vvfFEK1jj9dWS9n+coaaKX5cum1D4iolEFGqAkV1/vZiwflCVbVhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+NmB3CHIrIyT8pz2/5npFRUY8xFJoKcObHAousD6aA=;
 b=CLH2OhQNF5IiHmzfhwKF6NnU6lF3Rw6hOvEP8Dqgt52KKtUA9FW5yWMr8jiWywfw1YkK6lcElGIWcC29s8GBROxRNwtr2gqpVMEIli0iSS7RK6p4VwYvLQhi+lmQ3oASVRuUjHcQb5SJkBiaIZbcOuMaa3F4E9b3vyQX2hoTDs9qyysJE+APtzuChZElrxY7rvV4GVA71GVoIJva5fno4Ra1E5EpdzZh0le6d5USDeGIHCZn2h4CzFHXemVEBWKLJdX0HS19fXtGI64zQD5MPB2NL3yG42MOV3t8bcAchdt1wfpV6xPSzs2RUgY+QsmLwYOM0PmiNVgQnyM5P949cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+NmB3CHIrIyT8pz2/5npFRUY8xFJoKcObHAousD6aA=;
 b=qiL3/rmWbboo9wwPd5iCIWm/nT0S39dFvIfDrrLwwnQXCQ4QhFEf+pfOonHY/aijZLi88uDAjYkkNf49OGZusrYkpB5jEgpSKFxZtGrFOCf3fIrmSXrKjBRNlBvNwVIQzAsaQmzdh1F6dq7Qnc2eDVXb6RVzF6mcvbh7+OIHZ/0=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2477.namprd18.prod.outlook.com (20.179.81.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.22; Wed, 27 Nov 2019 21:54:50 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106%7]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 21:54:50 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 03/10] EDAC: Store error type in struct edac_raw_error_desc
Thread-Topic: [PATCH 03/10] EDAC: Store error type in struct
 edac_raw_error_desc
Thread-Index: AQHVpW1KlAZxbPSPEU+s5QRyNfxu4Q==
Date:   Wed, 27 Nov 2019 21:54:50 +0000
Message-ID: <20191127215415.11230-4-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: 8b716797-77d1-4e45-46f9-08d773846d27
x-ms-traffictypediagnostic: MN2PR18MB2477:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB2477F8C4A463ABF2A74F2E04D9440@MN2PR18MB2477.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(189003)(199004)(14454004)(305945005)(110136005)(256004)(186003)(1076003)(4326008)(86362001)(11346002)(6436002)(14444005)(8676002)(6486002)(81156014)(2906002)(81166006)(386003)(6512007)(478600001)(76176011)(54906003)(99286004)(52116002)(8936002)(25786009)(7736002)(66946007)(6116002)(26005)(316002)(66066001)(50226002)(36756003)(71190400001)(3846002)(66476007)(66556008)(64756008)(66446008)(71200400001)(102836004)(2616005)(6506007)(446003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2477;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: umS2Mj0iyJ5mluk5jezLYRYJPxTIAFYqF/JrkuhpKH6EAowvW4X269Vad2L/PpBxIpkf0JDpGkhAPzm75TPx4jP0noEAsfUpCjDiemZuRR0YMMFghqXgmquMWEVnoQsJiXzaUT1ns3mdsyhDgdc+rhSNI+pp7K238xCbhdazk2wjyJHZcQMJRqOt1eTkxwkjNX83UT2/FHQP8eSU9ee4mP9lsK7Sp+9pLPRLYYodMcDHWvHNnQ2o0CvNb0+ymr7Wfn79TqjzJTQzgHDSlZ9ViyV67GHhaO3erPMzm2fICzs4rM2j6taNU/Gq2KNNcuBnd9w4STIIz2r3irEXeUYlKn7EQipv0kt5F3Ed3tjTxcJX3ml1NeqDyyKaEJ4ZH9xtNgtdxRa2Wpl4OgbwAvhHvj43F3NSHt4pj68wC3PMjTBWh6so1n2upWiLiAro481Y
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b716797-77d1-4e45-46f9-08d773846d27
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 21:54:50.1901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xfBNtWawneGDb9q2qMwEW93h4RARj6Bjty5kDawFaHvrW0CYUQPx9c+XVju5jEsfJ39obo0IWFdUU4ZXVaHK1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2477
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-27_04:2019-11-27,2019-11-27 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Store the error type in struct edac_raw_error_desc. This makes the
type parameter of edac_raw_mc_handle_error() obsolete.

Signed-off-by: Robert Richter <rrichter@marvell.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 drivers/edac/edac_mc.c   | 10 +++++-----
 drivers/edac/edac_mc.h   |  4 +---
 drivers/edac/ghes_edac.c | 11 +++++------
 include/linux/edac.h     |  1 +
 4 files changed, 12 insertions(+), 14 deletions(-)

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
index cc31b9742684..5c1bdef30757 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -462,6 +462,7 @@ struct edac_raw_error_desc {
 	long grain;
=20
 	u16 error_count;
+	enum hw_event_mc_err_type type;
 	int top_layer;
 	int mid_layer;
 	int low_layer;
--=20
2.20.1

