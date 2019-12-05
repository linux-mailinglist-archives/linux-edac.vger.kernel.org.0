Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05987113E3F
	for <lists+linux-edac@lfdr.de>; Thu,  5 Dec 2019 10:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbfLEJi0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 5 Dec 2019 04:38:26 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:26934 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729215AbfLEJi0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 5 Dec 2019 04:38:26 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB59bCNV023610;
        Thu, 5 Dec 2019 01:38:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=svAMmrkoHYpj9/ztDSBry02MrTezUAIKGGlTYdAyMsU=;
 b=XBlrAiCJJAOMfN0+bbF8ROOgye+WIJze4H0NBmIIvEI+jxyHj0I+pSfFlgyoCCGBmRAU
 1HRGgu8v16ravns/uE/PI3VV9o0rskJ99Mr2Q5etc90icjca7D4rYxnQlnE2VTTnfwGT
 zbbYo4dWRYd2bqDt5Wc94Y2IbH/Olnp03HUni53/Hgdq8YnMdVRvzK+OMt3rV+hsQD0q
 4JWrlsh6h9qE9Xb91Xg1Tut1NIBo6pT11DD1dASQpkZct+jgiOj36jLl3O77ySgdQSFN
 CcnYT/V71uwWQwv3Oj939Rme9bH31HE3895QNDYXhphs2mnyMIoClDY4pbjxnvhyRAh1 2g== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2wnvgvrd0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 05 Dec 2019 01:38:18 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 5 Dec
 2019 01:38:17 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.50) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 5 Dec 2019 01:38:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9kJd5riS3jFrrnxXblyt9fZdi2xMGu3q8WIzSOxjwFzHHhfClrWehMy2mJQdQqeOiJP1EhaXjNQ6g2hzb/DShumorcnLyIHVEoeep58Q1SQZLPali2aJeNTyYxORggA9t1iqfWtlR1d78UyxbBoKLUgN03nyc15Mi4U1azhydMMUEqOu5/Nrer86TlKyS5OvrBaXXHY8MNa/VT9qhneggccdwdaXj+UC7UpF2/kuQeTwqy/JRW5Zk6qEKhKBQtBQ6z0HkKzDbtEjfVHi1C0tle5ejzVvwzg8i6p55c50xErwH+xkH8wrYeXgBKR8CzNUzhiJfgaABkcnIhtL/qKJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svAMmrkoHYpj9/ztDSBry02MrTezUAIKGGlTYdAyMsU=;
 b=X+U0h7/9n0ir/PU+KeOS1zgEdSXiH+Z+/1Tu+naya+gczwQb6LaIRYqMvpe3fAznTXZGTD6IBsyb01kEfwu6yca2UeBb4cQsAkVIhGsJmnuXuQuFZPWo8o99FbihvlnWyFDZYm4ZAb8iHtrFZLbUCSGyLQiVXtVpy7tiT23DnL/MurKcD0KFc7zLK/n+8B5yn2V+i98fkIqtOi+DmpuaeZ8DobY5jKIHZMD+XxjykMF0/tiQVEu6Raa3r98OU44HpSbxrxf+e4nbrSmEBl508tTypz8e1gi1k+Drs1vODv+fbhTXvTDxGFTiisBkxximUs4RoGRg/ESzSDt+6+TyQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svAMmrkoHYpj9/ztDSBry02MrTezUAIKGGlTYdAyMsU=;
 b=QTvvfs9q0ITFbSXkfozleqjqba1NSNj8PZ2P1/wwHB26MiDuQMNdAzh6vZqKSEn/HrPx43zHWnOldeKJI3cmI3O0JvU0WWe/E/gi3za4P6haJwADXBjb7HgROj2G3ZIpm/Eae3ensXskSCbbg+zQ3wuXBcAsx2S2Pv+zZ2oB5gU=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2367.namprd18.prod.outlook.com (20.179.80.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Thu, 5 Dec 2019 09:38:14 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106%7]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 09:38:14 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 09/10] EDAC/mc: Remove detail[] string and cleanup error
 string generation
Thread-Topic: [PATCH v2 09/10] EDAC/mc: Remove detail[] string and cleanup
 error string generation
Thread-Index: AQHVq0+3Tp0059QzO0qu+SjsVfgAlA==
Date:   Thu, 5 Dec 2019 09:38:14 +0000
Message-ID: <20191205093739.4040-10-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: d8c8da47-77c8-4c3a-dea0-08d77966d9a5
x-ms-traffictypediagnostic: MN2PR18MB2367:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB23679A8889AA44EEB0D9F16AD95C0@MN2PR18MB2367.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(189003)(199004)(81166006)(14444005)(14454004)(36756003)(6512007)(316002)(478600001)(54906003)(5660300002)(110136005)(186003)(8936002)(50226002)(6486002)(26005)(99286004)(66556008)(66476007)(81156014)(71190400001)(86362001)(66946007)(66446008)(64756008)(25786009)(8676002)(2906002)(71200400001)(6506007)(4326008)(2616005)(11346002)(102836004)(305945005)(1076003)(76176011)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2367;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7FXLKQE11Ni0fY8gGTxO2w8qloysu4CVgT50/dRYVdxydIz3cPMQBO4ziRhWzXQbpC2FtH2z35DXjMAL+krk1mX7gsHsX5j84Cz6oIcBVfgbwhji08PhOWw/HFx+GTuEGC85h+4frh9QQsNaXVyZpUPqnDa9F3psbd/aICk3P46jsZlXgwqI2a/Dif/nDLt0/FFa8G8zZy7o4FCJPsIvMzABtKsHMypQNdVYUabzycj8CTRXQXgjN6LzhppDLjZU4a+oaV3khzalkN/fPVAjOkxOXVLJNrVlDhtVfm9tb9g/eLVz3hZ/5jlJGO1tMB3TuW+3bHsJbytdFIutz78NZz1O05iqp7f86D0ktGRWqGAd2pw9yyYhizRKgYojqFwvA+BNijI3VCUJqn2zsAA9EhOWvDniyQAtTimd5eNmbKsuX7P08FftPVT6157VnjIv
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c8da47-77c8-4c3a-dea0-08d77966d9a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 09:38:14.3374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: racIcUNVEK/4hAAR7HaOUfYRF3KIXK6ZtcPE4Wp8KGBthhOtJhIY23AFr/HTC+4FLv+jYdgVHzPL+TTWx15Qyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2367
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-05_01:2019-12-04,2019-12-05 signatures=0
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

