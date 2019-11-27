Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D17FF10BFE8
	for <lists+linux-edac@lfdr.de>; Wed, 27 Nov 2019 22:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbfK0VzX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 27 Nov 2019 16:55:23 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:29768 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727990AbfK0VzM (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 27 Nov 2019 16:55:12 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xARLpgUi026844;
        Wed, 27 Nov 2019 13:55:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=svAMmrkoHYpj9/ztDSBry02MrTezUAIKGGlTYdAyMsU=;
 b=AjnZgceCjsv0paP/hF67GZC5AHrT4Fj2xSp4bHZjN+XutJLqt7v0JvgFEfBbtd5cPbr5
 KsQGfBOnPGr8L2PG/uWtWqIC/QseOJAP3fAY1SCqpLE+DAPZKMoxxZIr5ucYSCfaDp5B
 TI5ITs3B7szEVZdhh/sCm5RxqkBPJTCP89ofh9rJJIErIXSdbNaRZAuVhrX0nDk2g44M
 CX8tj0AXgK3zKuT9D7U/HSnVzToUXGPnqHVQ1YmEztJowrC5PTC1WBHdgRunZKbagjxX
 FE80PIgCkwEqXKM89KsjJaLvzGjCVLH0OdgJNm8JvtxQ6o3m+6+uYBSw6uDBgLucHT78 KQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2whmdyb5sg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 27 Nov 2019 13:55:05 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 27 Nov
 2019 13:55:04 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.58) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 27 Nov 2019 13:55:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jW0VX+O21nLZH9divZxsJIzecGufZnLCfQLF0Dxr1ZtTlbm4MWVuJetXJTd6hTMkdlsdk+BPJSHd3DpX2TP9LAM8w8pQMSe5aNoBoQYjpPBPozr17NhJNkLB0o0ytBVmfNjzbc5rxWCBVJIGqEc0UbDHF/VDcXSJH/nOBmek3RZd7H/5iU8ixczTVwh8uoRhYtrSngxXNldZ+o5gJu5qQC28LD9D39U77xvi3cnPPl6fRzaxFuYZwYgT6Xb53ZY558amYc/1S/sXem4jo277Up67nn0Wj4wkNrCvCjyPnx95C9vmOlJifkHRKJGeAXuLpTHoCKT74gtCaN0RuSYs3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svAMmrkoHYpj9/ztDSBry02MrTezUAIKGGlTYdAyMsU=;
 b=PF9Ow61E2XNgtMRrGw70vC5IRGda9qWqaLUa5HH6WnxndcmLaEW84ivZjsmD3NN3I4pSterCedKyxwTqyuriXF2i8ACqET/i/JYK9RUBR8Q3bEK61ow1GnaLlPVMwh/RbpvOTHLJa/gbjLV2gQGayfXwDbboDcmBvhjPiKwYcFxexbOoVpYwdHVcn4wPxQbTmS/RTjcRvbGRnr8nEtzpBKo2DbUjROdxPAd/cX85NeYH1KlD+AxNOk0/NZMZSzGDazuOjCPx44cAPmVYVqe/ynM+t60BadcqV45gBNBuBCK99vJ9Z5A2Xv/KVkS6xqE1tdJrYUDjPXIEjizcQJ1y9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svAMmrkoHYpj9/ztDSBry02MrTezUAIKGGlTYdAyMsU=;
 b=pXG0V4aV+unjmFyb0tySjEEvyj/NNf9H8AzfdDTN4IrAGkimSWAsBxA8jcLCv3pbCBZwacSquuSvKJ3mLdZlVE4VM1C5PDwD63OJH746/IMbO+cOfTBvtqx0DIduyTIYeiIG+vgjF2npZbXbLfyS6KhxMuEIG5mYUGTtg4S01rE=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3197.namprd18.prod.outlook.com (10.255.239.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Wed, 27 Nov 2019 21:55:02 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106%7]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 21:55:02 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 09/10] EDAC/mc: Remove detail[] string and cleanup error
 string generation
Thread-Topic: [PATCH 09/10] EDAC/mc: Remove detail[] string and cleanup error
 string generation
Thread-Index: AQHVpW1S4eaK7Sm7SU+tRFH77sEi0A==
Date:   Wed, 27 Nov 2019 21:55:02 +0000
Message-ID: <20191127215415.11230-10-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: b7e6903d-2424-4afc-ab9d-08d773847497
x-ms-traffictypediagnostic: MN2PR18MB3197:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB31979910A5B97D52CD8846B1D9440@MN2PR18MB3197.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(189003)(199004)(52116002)(3846002)(66556008)(66476007)(6436002)(36756003)(11346002)(4326008)(102836004)(386003)(6506007)(316002)(54906003)(6512007)(2616005)(6486002)(99286004)(446003)(110136005)(6116002)(86362001)(25786009)(14454004)(1076003)(478600001)(14444005)(256004)(66946007)(305945005)(7736002)(66066001)(76176011)(81156014)(8676002)(186003)(8936002)(50226002)(81166006)(2906002)(26005)(5660300002)(66446008)(64756008)(71200400001)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3197;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KdmDfzj3GtyEL8fb3goVE96gFbezLCezg2eCLnn6hv5HV3WYQz8Hl31nc1Xann8gtJAANwT8JO1J95xOQDdMDEEPSKJuEF0Y4ABu69skeX2/ezwFbypL6k1VTIUOO2wAZETqoVhuS7sJTqqUrXLMfR4ZMPz60xxMYfA5yW9dZv+7KvoGoqIAtCk59ZrjGgNfRbbiUJiUqdBsPDhJzk2vQH2+JgK3OZzFj3HaMw4oLavTRY0EkcHD7kHH3N7YRmZUw1AN6Gu+4VKbZ+I389AcVNSZmCb0z8o0ArwjPhP4nBbcFdwUgmNox+gQ6Wc4u/x3eUB1ueW+iCE0C4bTWDjdVF33/hCOuf+PMWe4Ehl4rORDMBwx6YpxSnZ1Q5KJT+UKtE00adZRH2o/bBlmozIH8eKokpJYMTigE0Al8TXk7Xe9fIlUYJ+UHWSp2VzKYNa4
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e6903d-2424-4afc-ab9d-08d773847497
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 21:55:02.6927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xSbZbNFmxFz95hDjFC4MQsGB1aGpJAfTvWGP98pMFeHjNrAoq5ZT7DwewkAYTb5FVuBapKddNS0xQAOF62Dd5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3197
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-27_04:2019-11-27,2019-11-27 signatures=0
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
---
 drivers/edac/edac_mc.c | 83 +++++++++++++-----------------------------
 1 file changed, 25 insertions(+), 58 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 545d25c8654e..5ea834fceb50 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -993,27 +993,18 @@ static void edac_inc_ue_error(struct edac_raw_error_d=
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
@@ -1038,36 +1029,24 @@ static void edac_ce_error(struct edac_raw_error_des=
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
@@ -1096,7 +1075,6 @@ static void edac_inc_csrow(struct edac_raw_error_desc=
 *e, int row, int chan)
 void edac_raw_mc_handle_error(struct edac_raw_error_desc *e)
 {
 	struct mem_ctl_info *mci =3D error_desc_to_mci(e);
-	char detail[80];
 	u8 grain_bits;
=20
 	/* Sanity-check driver-supplied grain value. */
@@ -1113,22 +1091,10 @@ void edac_raw_mc_handle_error(struct edac_raw_error=
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
@@ -1164,8 +1130,9 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
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

