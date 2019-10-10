Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21ACCD31F6
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2019 22:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfJJUZg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Oct 2019 16:25:36 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:32242 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726976AbfJJUZg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 10 Oct 2019 16:25:36 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9AKK9d2030109;
        Thu, 10 Oct 2019 13:25:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=EYTMuCOq9Y0HKhT9rS1SnxbL8uWRb/y3I05+8fGvlGY=;
 b=tqPKyYQNq6JjJpL2j7G7E2vNDviF6kGuGkuG3buZGisSJCrjRFuEl1GRZAsk1giQGGIP
 ifZ2Tytr1FYkJ2Q3G/QXXW1uWGd9XjLT2qq3Q6+lGnlWPgMZbgDBwqYTtDCGYtdJuTkr
 YUImVqbzjbbMClXFAaLrAByBE32g96bgLIelBeh408LY+Uzdz+mOCpUtwICiw+4VNijD
 mm3mHNmBn6aT2C0uWW0CIaUlTJJU1tdUnjZ4D2Q+d6SFgWc0qV9eSYBvSMPVmg/TymsW
 ff3xywxNnSaPz4n6tCMzMT124tw8hY9uIBQ1s/FJtoZA8gRmkEXdF3r8VMvsAizhMFLx LQ== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2vj66h1gcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 10 Oct 2019 13:25:17 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 10 Oct
 2019 13:25:16 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.51) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 10 Oct 2019 13:25:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcLKrvq0XacfaktPUrwSGB+KqwEvGEy/6GhyIcfkHmYT6hr0G4XxDgXAiN1rsBpQdgKAsEP/fjd/yqECASu0d6btpRTOvwIFuZm7Ecf5zD50OsivvHrxrmE8FViCJls1AvwfFw+NXF77V05RziOK0rvH4K+Nkm6X3hLdG+y1Ki/fiN1XZ7N+atoOCwzftYztOsbSm3LqyTTIusfDscZ4EIgd+UjZBFaLcNyaxda5k1bXrD7kwMDVRnzxlrj1TP38R47579Bas5N7ayeAhjWvP9IlRYU3trT+9PQawARWJQxhYPPaUawFPC/068SAnI/Vt8je3Wc63SUK5xxs/IRJGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYTMuCOq9Y0HKhT9rS1SnxbL8uWRb/y3I05+8fGvlGY=;
 b=TLTp4fUTSAmJTV/fYeYAcQJbLHhT2A6oYE1NjUEkxX+9CNC5EaTC5jNuahRwJ5WeMGAPahsSnVRzj8z060Ba+4fuAoiTUEpexyGGSj2cxoi06QX5d2qkdqcRq8EnPmGwoBkmU3pcU5TBIFlMhFI5xi34BmUGfb5sbQ0X0ZW94pbmYukTy37jR+mpkDQiSr4EffidtPe4Cb9M+POhbWtNyhGZx5luevw0tIG3kwh1S0FnUusAwfy4NNP81As6btD7OA6mij3NB97YqnMeVyZ5rE//uOD567cn/NlP9WNIdPDnaiZmf05uvAfwOzS/04PtqpltZ2lclCveU4B1OLfmjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYTMuCOq9Y0HKhT9rS1SnxbL8uWRb/y3I05+8fGvlGY=;
 b=l4muzkvZz2tYvxpzxrMzia4Jc1attmogpo/QUHSOc0yfUTiGXAiNERUjYoJH+Pr8TB0y24Mj3BlxbnGzQ0Vn9iOIyvx4K1yPLZxQ1fEjVHL/1o6XWpslhgNbSqo68uBdXeaI6ft/dgA9eu+sX2/Pq6WCbxRmVTQxNYwv0gZiUF4=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2701.namprd18.prod.outlook.com (20.179.22.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Thu, 10 Oct 2019 20:25:14 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763%3]) with mapi id 15.20.2327.026; Thu, 10 Oct 2019
 20:25:14 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 05/19] EDAC, mc: Reduce indentation level in
 edac_mc_handle_error()
Thread-Topic: [PATCH 05/19] EDAC, mc: Reduce indentation level in
 edac_mc_handle_error()
Thread-Index: AQHVf6jSoX7xq8/JmEOcYRo6qU8krg==
Date:   Thu, 10 Oct 2019 20:25:14 +0000
Message-ID: <20191010202418.25098-6-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: e046d57b-4fa5-40c4-1e03-08d74dbff520
x-ms-traffictypediagnostic: MN2PR18MB2701:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB27019BA05F7FBB1FF55DDCF6D9940@MN2PR18MB2701.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:873;
x-forefront-prvs: 018632C080
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39850400004)(346002)(136003)(366004)(376002)(189003)(199004)(6436002)(6512007)(54906003)(71190400001)(110136005)(14454004)(316002)(6486002)(86362001)(71200400001)(5660300002)(2906002)(66066001)(25786009)(50226002)(478600001)(11346002)(446003)(476003)(486006)(3846002)(6116002)(2616005)(99286004)(1076003)(6506007)(76176011)(4326008)(14444005)(386003)(7736002)(305945005)(52116002)(26005)(256004)(102836004)(81166006)(66946007)(36756003)(186003)(81156014)(66446008)(66556008)(8936002)(64756008)(8676002)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2701;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bvw0kedsWy7S2ZcuvzLvlrTpKnXJqY+sgj3f6lSpBd+3eKhprBWl+0SIGdhtfzFP/yMdPLUCNm/bWiMO+wv3qL66ssR0cQ4XbL6q936PoAzYqzi12QKMqKeIw8P0KPhVHlbP5Y5uLRFlTynB9yq3/2us97LjL058kIltV+vON9IyYZ9Who5MPVo3STXhAQXFtpvo4MDj/xvcgLbLLKjaTBjzmCbYGllMMKCq8hgrBcgqZ3i5zxeWAMo7l376dClcF17Wdg8MMJxbdduNRsuRZ874PctDa5anpRrg4sFtxo2xQfQknGE2vRdQTjdvRaPtLoZzGKcLuk57E3OawZIK13C0cF5DRUJ12WR6SZQPnMJt7ZqQ/s1ZRdLnSle4ncwWjsBIWPEYNC94sN95HyECXo3f0jHv3apjOL0dc24OEbs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e046d57b-4fa5-40c4-1e03-08d74dbff520
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 20:25:14.4708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3eQxafBhZl8R64Ib7H4HegjUtVet4LQ5LMzA0rS1o4dJcRpjlz5vUKh6EmUDVlIaVapP0pgRJ3MTb7ttAbdgAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2701
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-10_07:2019-10-10,2019-10-10 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Reduce the indentation level in edac_mc_handle_error() a bit by using
continue. No functional changes.

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/edac_mc.c | 59 +++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index f2cbca77bc50..45b02bb31964 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -1171,37 +1171,38 @@ void edac_mc_handle_error(const enum hw_event_mc_er=
r_type type,
 		 * channel/memory controller/...  may be affected.
 		 * Also, don't show errors for empty DIMM slots.
 		 */
-		if (e->enable_per_layer_report && dimm->nr_pages) {
-			if (n_labels >=3D EDAC_MAX_LABELS) {
-				e->enable_per_layer_report =3D false;
-				break;
-			}
-			n_labels++;
-			if (p !=3D e->label) {
-				strcpy(p, OTHER_LABEL);
-				p +=3D strlen(OTHER_LABEL);
-			}
-			strcpy(p, dimm->label);
-			p +=3D strlen(p);
-			*p =3D '\0';
+		if (!e->enable_per_layer_report || !dimm->nr_pages)
+			continue;
=20
-			/*
-			 * get csrow/channel of the DIMM, in order to allow
-			 * incrementing the compat API counters
-			 */
-			edac_dbg(4, "%s csrows map: (%d,%d)\n",
-				 mci->csbased ? "rank" : "dimm",
-				 dimm->csrow, dimm->cschannel);
-			if (row =3D=3D -1)
-				row =3D dimm->csrow;
-			else if (row >=3D 0 && row !=3D dimm->csrow)
-				row =3D -2;
-
-			if (chan =3D=3D -1)
-				chan =3D dimm->cschannel;
-			else if (chan >=3D 0 && chan !=3D dimm->cschannel)
-				chan =3D -2;
+		if (n_labels >=3D EDAC_MAX_LABELS) {
+			e->enable_per_layer_report =3D false;
+			break;
+		}
+		n_labels++;
+		if (p !=3D e->label) {
+			strcpy(p, OTHER_LABEL);
+			p +=3D strlen(OTHER_LABEL);
 		}
+		strcpy(p, dimm->label);
+		p +=3D strlen(p);
+		*p =3D '\0';
+
+		/*
+		 * get csrow/channel of the DIMM, in order to allow
+		 * incrementing the compat API counters
+		 */
+		edac_dbg(4, "%s csrows map: (%d,%d)\n",
+			mci->csbased ? "rank" : "dimm",
+			dimm->csrow, dimm->cschannel);
+		if (row =3D=3D -1)
+			row =3D dimm->csrow;
+		else if (row >=3D 0 && row !=3D dimm->csrow)
+			row =3D -2;
+
+		if (chan =3D=3D -1)
+			chan =3D dimm->cschannel;
+		else if (chan >=3D 0 && chan !=3D dimm->cschannel)
+			chan =3D -2;
 	}
=20
 	if (!e->enable_per_layer_report) {
--=20
2.20.1

