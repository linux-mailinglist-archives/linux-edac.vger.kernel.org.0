Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93885F1248
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2019 10:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731749AbfKFJdo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Nov 2019 04:33:44 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:47866 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730806AbfKFJdh (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 6 Nov 2019 04:33:37 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA69UI3s002504;
        Wed, 6 Nov 2019 01:33:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=28ko0/C+71KwI1IFv1fLLYYIQVTMncihhaWc6VOSZ7k=;
 b=rXl9YJAYgTs1t3cos3qXbpOx8M+D7oJ9nXrNC3lbl8QUmQciC31eUqiK2+neTUR9eURE
 W3pJNPrVvdjH7dKqtYcmnazMKlrWd751LfqiQTqyR8fRiCfo3iMCNMnw231iy5d/pe14
 96ftrMPrGRPAQVmDxCJUDMEsrvngMDoI+7C5unP2whe6Zt2y0mZXpgmrLv25NmQRRonO
 TnttKgbPRiCd3PojUs19ygLInwHScR4AH3c/a4ugIGZ9CKPE4F82ENAP3EoAZSVA9GHL
 PvZf+8DKJGflQ52bIshIcUHnU7OOpyd/jDNIiTu7yCcQUo5gqwwqoIH8g6Gp9bgYYlk7 kw== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2w3eud3c88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 01:33:30 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 6 Nov
 2019 01:33:29 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.55) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 6 Nov 2019 01:33:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1I0GRpESFKtgjtApa44PgsVcuvTOCynaVCOASxPj9sapmemZ80aYUJpbEk4oW516K/grL3uPidN1S2nAV4S2LTAbBFtnh52jED5FJS+nHm1hcXW5CUwqaXKxtgZ6qDe/iNSLiHY47cpMjyrvUBsBe9jE83iqni9tNHRvGUrOY3fVzKfQdCt/cWoL7hdY9XXH5ocivT+BAp5aKfrAxgYxEKfHjHHSBbO4U+E955+Pe1N4W/D0x9Ufi1+tX2TiLDBUZoEsIjD6BHcJ5fkvPMMytMmp7UHWb/Harr8+XBOS0kpHJnYwt1rmx4Su9q3gPRRjFyyylPbPJHZJrW7ky4q7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28ko0/C+71KwI1IFv1fLLYYIQVTMncihhaWc6VOSZ7k=;
 b=FaiacnNxpvA/2HgEaOzqGE8qx+TzYEj+Ah7RoSWm9OdRjCVuXfkkeX9R0CIQfYoNIwBKj8pgGfVl3s4e+QDUD2Zb1MvLEc2xkGFj+1JxE7Wnw07DFBFxWP0E5JtRdoII/rKV0fnvL/SrjHzUa126+8Kg5079v+lFj+iG3ckOisTrBXjXTWySkryIrSOZ9M8LATN40d6MQBs9KqDUK+MW8r8/3SWYkugxTjdQnaiyYzj8yG7EoLdXIDOMzpaLsZKx0qWtUe0XKBVm+VHw5JTMunjSscE3jHGraNe1RFLVzTkVnsZPJuhluiGg+tneuy6b9NHQG6I1XxFP8HFkoXRQNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28ko0/C+71KwI1IFv1fLLYYIQVTMncihhaWc6VOSZ7k=;
 b=ofBWLLhWO7mmAbg1oKiZwEHmgOhcFMLfYMI18Z6KOroNDke1MQR0YuAvCUK/eO604JEypmo9fudIANW5jDkxnwlnytS11HJAi/wGXsNJ54gAhEUKaJ+RBw7oVkBIzXOE0ZLd8b//FLfiCp6Y8DdGwvlpO9QHAUUwvaJZu+vfZvM=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3165.namprd18.prod.outlook.com (10.255.236.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 6 Nov 2019 09:33:27 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6%6]) with mapi id 15.20.2430.020; Wed, 6 Nov 2019
 09:33:27 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>
Subject: [PATCH v2 12/20] EDAC, ghes: Unify trace_mc_event() code with edac_mc
 driver
Thread-Topic: [PATCH v2 12/20] EDAC, ghes: Unify trace_mc_event() code with
 edac_mc driver
Thread-Index: AQHVlIU+HDuE1rmeak2rq0BZPausfA==
Date:   Wed, 6 Nov 2019 09:33:27 +0000
Message-ID: <20191106093239.25517-13-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: b89a4bef-3b57-4150-c509-08d7629c60c6
x-ms-traffictypediagnostic: MN2PR18MB3165:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB3165E0FBE645D570637390C5D9790@MN2PR18MB3165.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(199004)(189003)(52116002)(305945005)(6486002)(76176011)(71190400001)(71200400001)(256004)(11346002)(446003)(7736002)(14444005)(6436002)(4326008)(6512007)(66446008)(66556008)(66476007)(66946007)(64756008)(5660300002)(1076003)(476003)(6116002)(3846002)(110136005)(54906003)(36756003)(2906002)(8676002)(99286004)(81166006)(81156014)(316002)(8936002)(50226002)(486006)(6506007)(386003)(102836004)(66066001)(2616005)(86362001)(478600001)(25786009)(186003)(14454004)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3165;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GR1/2v6SXD09vtuaYSaWto9rQNB9SwZl2/giajI4ir0CCx1ilRXxFxaSAdhsXDdDsYMu6njrCSwczZ8kev2lVzmPOvnRW4hcA6zI+LZyfZPvSkwGaLX2IwmO0WKgRY+qA3WMB/irZeqpngiVp+239f5VMVKVyHk70ufobICIbAiVmzL+G5Y9yhcSfGgQYESL8zKbt02kW4HqiCcbZJ3KVJrnLKfWw3xjYpHx10zWcVFDRA2f6ByNZ5pFtXU4o4Gn41LFDfd4Rv6yaiybSR8rpV/RXJgBXuUocAETpQltGT7H8gZWqgqo+zdvsfKl6S58IfPRePjKCJDmbLQ2+QUanyB6dBiS1TA2JOyxGgzbWjYulmLfE9tFI/E9zcq4eUI+fOgy5Jggp5q5lRDz+gOUmx9R3N2nv7Q+wlhbAJQe6nC5+7sP6/MzRQmmeDKq0vLD
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b89a4bef-3b57-4150-c509-08d7629c60c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 09:33:27.6662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fAZ3Kamb4MGn1C5JsJpmXfD94d/c9v9C2VizUEwykmolpoG0R8uoNIntb5DOJtrNI5qNXb23bACtN+8FhwGZvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3165
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_02:2019-11-06,2019-11-06 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The code in ghes_edac.c and edac_mc.c for grain_bits calculation and
calling trace_mc_event() is now the same. Move it to a single location
in edac_raw_mc_handle_error().

The only difference is the missing IS_ENABLED(CONFIG_RAS) switch, but
this is needed for ghes too.

Signed-off-by: Robert Richter <rrichter@marvell.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/edac/edac_mc.c   | 30 +++++++++++++++---------------
 drivers/edac/ghes_edac.c | 13 -------------
 2 files changed, 15 insertions(+), 28 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index f76252b7a787..b6032f51338e 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -1057,6 +1057,21 @@ void edac_raw_mc_handle_error(const enum hw_event_mc=
_err_type type,
 {
 	char detail[80];
 	int pos[EDAC_MAX_LAYERS] =3D { e->top_layer, e->mid_layer, e->low_layer }=
;
+	u8 grain_bits;
+
+	/* Sanity-check driver-supplied grain value. */
+	if (WARN_ON_ONCE(!e->grain))
+		e->grain =3D 1;
+
+	grain_bits =3D fls_long(e->grain - 1);
+
+	/* Report the error via the trace interface */
+	if (IS_ENABLED(CONFIG_RAS))
+		trace_mc_event(type, e->msg, e->label, e->error_count,
+			       mci->mc_idx, e->top_layer, e->mid_layer,
+			       e->low_layer,
+			       (e->page_frame_number << PAGE_SHIFT) | e->offset_in_page,
+			       grain_bits, e->syndrome, e->other_detail);
=20
 	/* Memory type dependent details about the error */
 	if (type =3D=3D HW_EVENT_ERR_CORRECTED) {
@@ -1097,7 +1112,6 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
type type,
 	int row =3D -1, chan =3D -1;
 	int pos[EDAC_MAX_LAYERS] =3D { top_layer, mid_layer, low_layer };
 	int i, n_labels =3D 0;
-	u8 grain_bits;
 	struct edac_raw_error_desc *e =3D &mci->error_desc;
=20
 	edac_dbg(3, "MC%d\n", mci->mc_idx);
@@ -1235,20 +1249,6 @@ void edac_mc_handle_error(const enum hw_event_mc_err=
_type type,
 	if (p > e->location)
 		*(p - 1) =3D '\0';
=20
-	/* Sanity-check driver-supplied grain value. */
-	if (WARN_ON_ONCE(!e->grain))
-		e->grain =3D 1;
-
-	grain_bits =3D fls_long(e->grain - 1);
-
-	/* Report the error via the trace interface */
-	if (IS_ENABLED(CONFIG_RAS))
-		trace_mc_event(type, e->msg, e->label, e->error_count,
-			       mci->mc_idx, e->top_layer, e->mid_layer,
-			       e->low_layer,
-			       (e->page_frame_number << PAGE_SHIFT) | e->offset_in_page,
-			       grain_bits, e->syndrome, e->other_detail);
-
 	edac_raw_mc_handle_error(type, mci, e);
 }
 EXPORT_SYMBOL_GPL(edac_mc_handle_error);
diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index cb1ab44361f0..725b9c58c028 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -207,7 +207,6 @@ void ghes_edac_report_mem_error(int sev, struct cper_se=
c_mem_err *mem_err)
 	struct ghes_edac_pvt *pvt;
 	unsigned long flags;
 	char *p;
-	u8 grain_bits;
=20
 	/*
 	 * We can do the locking below because GHES defers error processing
@@ -443,18 +442,6 @@ void ghes_edac_report_mem_error(int sev, struct cper_s=
ec_mem_err *mem_err)
 	if (p > pvt->other_detail)
 		*(p - 1) =3D '\0';
=20
-	/* Sanity-check driver-supplied grain value. */
-	if (WARN_ON_ONCE(!e->grain))
-		e->grain =3D 1;
-
-	grain_bits =3D fls_long(e->grain - 1);
-
-	/* Generate the trace event */
-	trace_mc_event(type, e->msg, e->label, e->error_count,
-		       mci->mc_idx, e->top_layer, e->mid_layer, e->low_layer,
-		       (e->page_frame_number << PAGE_SHIFT) | e->offset_in_page,
-		       grain_bits, e->syndrome, e->other_detail);
-
 	edac_raw_mc_handle_error(type, mci, e);
 unlock:
 	spin_unlock_irqrestore(&ghes_lock, flags);
--=20
2.20.1

