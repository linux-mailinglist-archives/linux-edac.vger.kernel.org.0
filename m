Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D87FF1269
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2019 10:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731639AbfKFJdZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Nov 2019 04:33:25 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:4120 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731188AbfKFJdY (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 6 Nov 2019 04:33:24 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA69VKLR027217;
        Wed, 6 Nov 2019 01:33:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=Z5k9njPJN2G7MTwpf0Lve8/g4Vg/fCzv3uCHtlJZ0Pk=;
 b=SmUpqJx4gQr1s6ISs1xn6mrDXELhGz/Gfw7hZS0788rX08Lrtu65UVyYhFPIJVGJt489
 dQCVTIEABOM/8HeCQcLt3YLxRIPJWKtRZ1xlOLhjDd+BhC0yiWuTjFxDM4Z1MXnuJpre
 FOBmRJ3qgzukqh28Q9XWRpFfG0Q01VcM9ZvFKWO4XzU9iZo3KAqgXh7xsAeRQWCZzn8l
 Qgkm34q2YF8PSZ/yCNKD7gx7vyR64Bvzs6qyM4N5Njnz5acAFqUGPSh3bFhahzH4QlTc
 IYhEk2lFg/UcOYoxn0xrlAdRLRAyv+caKRl/RRs8+WwACiFDh3F0tW0afvloiWt56y11 mg== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2w19amyajv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 01:33:18 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 6 Nov
 2019 01:33:16 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.55) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 6 Nov 2019 01:33:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mK2ToIjJC3RD+MqME8TmXCbIpeJhIUXqdOxQck/Gc4oU7W6PkywGjBdqVXjkGGY/9SRCdFNRHTAQbQr67JHxgB5+5OLL6mIKEoIZQVdcnzyE+euQxFaDzTBB9sw8nB47/uH2ldy8yR/9WySDTeoH/ntYJ6wDCCoKj6KPv7Hafwesu//BnkhBDCwNbEo7UO1ZaUIAN6D9le+e0K9CixfNNpi6hkTZc8lNd1HuagQAvXz02K03x2BNkv1LWNxcPibA+VtfiyyDSRU1hITULnoF47b9U/7zR5ZcOMWhaHzcSMgovRfWIs6U+afQUkxIN7c4kq5wMV0xyvBWRMlCobZx/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5k9njPJN2G7MTwpf0Lve8/g4Vg/fCzv3uCHtlJZ0Pk=;
 b=dW7RN8mQ6m0bvHvFaTP3I5YTdg35hwA8Meuf3ArdpUfWTyGk37wuh2FA3xpQHTl4gvzVrwss3b1Js8RD0tTxlxSJcoE/gBreEmhVOPUeh2iCY5Iwl+QUjPUyNl0NijWi8YIh+9pIoQxRjVE50nzYU8rCw44yYJH9VuRecH/XxVHaSu/IHo+L6b7j5QzBjdEk2GqSRfNbKZ+B/lwWEmPeay+x487sztkZl2x6cdqt8BNRIfVCpOKOriAB0GBLAzfZ7zTOQ+ywd93nSUZn0P2Ar+CSDHJXRTysATjBYVJUvuF/cGKzKXzn7BXZP7XsP3EKWDYRz5hJuAWtoWcXdN23tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5k9njPJN2G7MTwpf0Lve8/g4Vg/fCzv3uCHtlJZ0Pk=;
 b=l1zBMdNppwipu59nUJAsjilANUel4ffdZFpvLBFtYBNF8QHydoKxFyrC1UZBj5kjDHRiWwMpLz4+SrB15/S61g9G69ZNaTIuxF9WtMeIgzn6A7KByU7KfXnvsQnUtZzUByXRa1e0DOyNPm+mPi1jTyWEZaxshq2GrJLL/gAgJOs=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3165.namprd18.prod.outlook.com (10.255.236.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 6 Nov 2019 09:33:14 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6%6]) with mapi id 15.20.2430.020; Wed, 6 Nov 2019
 09:33:14 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>
Subject: [PATCH v2 06/20] EDAC, mc: Reduce indentation level in
 edac_mc_handle_error()
Thread-Topic: [PATCH v2 06/20] EDAC, mc: Reduce indentation level in
 edac_mc_handle_error()
Thread-Index: AQHVlIU2IWhkSqNolE63BniXo8A8zQ==
Date:   Wed, 6 Nov 2019 09:33:14 +0000
Message-ID: <20191106093239.25517-7-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: 8cb39542-b3e9-44ab-2a70-08d7629c589a
x-ms-traffictypediagnostic: MN2PR18MB3165:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB3165C28A9804B6DADF40F129D9790@MN2PR18MB3165.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:873;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(199004)(189003)(52116002)(305945005)(6486002)(76176011)(71190400001)(71200400001)(256004)(11346002)(446003)(7736002)(14444005)(6436002)(4326008)(6512007)(66446008)(66556008)(66476007)(66946007)(64756008)(5660300002)(1076003)(476003)(6116002)(3846002)(110136005)(54906003)(36756003)(2906002)(8676002)(99286004)(81166006)(81156014)(316002)(8936002)(50226002)(486006)(6506007)(386003)(102836004)(66066001)(2616005)(86362001)(478600001)(25786009)(186003)(14454004)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3165;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N1C9Yr1O5+DdgABuMFM7SCv2w967JkoGmCnnJtQgUShwVOSJiVUNCKc4t6hTr5Tb8C5Rs5HgLG5PyDPTj+wgDXiwX+0HYiO6kAlaXXRgZ1fAvM1jgKE0OvPphGnX1iMFP7zdx9kcjVVkWHGUZ4saM3qpyhyrPM/EVwOdA8W1QV2SC7NDWNYI0VWZcIGy99k0J7vB+jgmtydoNo5AzhLPpuc7TbKkV241raCaLbZyO+c2uD//znK33YNpgWoyXbtKC0B+AQ9PrduVEcD+gakCkJjqAfICJgpMafBvhZOlLG7ijK0I5r0qyB1YUZX/XskIRWDZAYidUlNWiwYnjBdrD0BJuucJEhic1mZ5vhQCYiZwoPtSgl3PsqbSV7DV1y/6RkGGPM3/DP/8i0TXxlwRH/8YnA39AnKHTlwkYnv5t7bJciGVjllvNHgcX1NpAeN3
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb39542-b3e9-44ab-2a70-08d7629c589a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 09:33:14.0521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n5u6D0JgnMACcghZjGC8aNSI3WZyvsxR7uOJRw1TRIXC4njpTPhLiOs5agzlQ3OKm8WJVG+UORQbhCELfQzatw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3165
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_02:2019-11-06,2019-11-06 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Reduce the indentation level in edac_mc_handle_error() a bit by using
continue. No functional changes.

Signed-off-by: Robert Richter <rrichter@marvell.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/edac/edac_mc.c | 57 +++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 8bfe76d1bdf1..3dc1c5afabce 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -1171,36 +1171,37 @@ void edac_mc_handle_error(const enum hw_event_mc_er=
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

