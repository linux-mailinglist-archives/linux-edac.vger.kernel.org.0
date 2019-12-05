Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 903B1113E3E
	for <lists+linux-edac@lfdr.de>; Thu,  5 Dec 2019 10:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbfLEJiZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 5 Dec 2019 04:38:25 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:17372 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729102AbfLEJiY (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 5 Dec 2019 04:38:24 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB59XxxC004816;
        Thu, 5 Dec 2019 01:38:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=p4XQFsZ1vCxGqQKEPMJI1oMeRWfaj3eM5bgY3ORJMl4=;
 b=Z7/HZNuCN5bIuGVM4YmOViza3q4+pDjFoW43j3qA5ri/ogPl03Rfb4+N78png/KLYiKH
 fGS9EEpIbpb25wthrn3LK7vwBqiZXzH2EKchD9mwAt9R1aKeBzpAjDTGj4hgE4Lp4S36
 BmDiuqzivCfjGVOpYs85fGWbxudZmUzLola3nxYreZQ8IeLacIz14epGWx0DxV3lcQMg
 pcIp2zHekN8o6w5dZe8jELDJ+YG0LYV2lkCK41pGCgUKN8/Yr1KfHs2HV93NGouYL5lQ
 f3PWlhjpJNyJaZEIJikj9tSLwl6apee/Xfh/UEcNreu83ZDnVr1L7vVHoaI1XhEuihiC yw== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2wpybwg0d4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 05 Dec 2019 01:38:12 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 5 Dec
 2019 01:38:10 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.53) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 5 Dec 2019 01:38:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBy2SSg2OQHqPLRkQ1A+bTBXu/RrMx2s7TwB4Sn0NsKVRR+Bvp9Z52JEEXZ2aTPzeuPfUzIwwZtzPUrZhUw1FQSlf+rE1RurQlygAhPuaBkGcyy5cmEEiNsaZv8qeOxWuCNY/JcUA/inIywfYgvuP29rffsMhatgdzTpmkiRaiwpAE/SuAUjf92zKuEENWOWA9lNqA3v0fjKA1O6cIdqnBW0lbrv9ECobKYIA2+xahLrHme/4U9hoqnm9uprx0U5Uv/gIDiwp9ytn1PiuNeZe1vYXXDSWY83Rsc6/jiD0JFEBerp4+DeP8NHUa21cGk6WYwARew4KT6yhIHMBiF8yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4XQFsZ1vCxGqQKEPMJI1oMeRWfaj3eM5bgY3ORJMl4=;
 b=K64d4I0LxLT7qx7CJ9aC+rYyxKD1BYpA6J5Q5UWwb+ML549z90gr7Aio3gqcZnbvZwDYsVjwzTsbDGybG8SoxGOWhJkizlY5Rj64LGo13dkW3xxSHYmFcM+n0IDtYPmR6j0LT3E3ISZo/oczZygWKP8qH/CwKrhc7v0Nqsz7oXGbBEk2GnjKnk0HgqPOJbsix6S1NtoYTKDAkfpdU0jn2iWjHCyOT7+aMppZp7PLHMmDMc/titdryJe4rVS1r8Ydlv75nd8ucsWmeq7WkBvuit6XIyAtsbfU/LXqvyNRWRrSr05CjeOwx5tHNckB6F+vgWhb6GJ4VrrSjq3BXdrwfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4XQFsZ1vCxGqQKEPMJI1oMeRWfaj3eM5bgY3ORJMl4=;
 b=Lx1AhorOYUgR+tFIdWBG2T3dPwtuR0DrnC4Pp4es7l8UXJzxNUxso+mVATujnelDyw62uGLFLQhl+kfTJ6hORZ19pRjxyC7seHw/1GFmecZly/vRKZk1nVITwhFv/BUC9WekaUfP/E3B341cgelrVn/u0v9k/8q3+eKOm3/OMxw=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2367.namprd18.prod.outlook.com (20.179.80.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Thu, 5 Dec 2019 09:38:08 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106%7]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 09:38:08 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 06/10] EDAC/mc: Report "unknown memory" on too many DIMM
 labels found
Thread-Topic: [PATCH v2 06/10] EDAC/mc: Report "unknown memory" on too many
 DIMM labels found
Thread-Index: AQHVq0+zgY+Ar2abxEWY9eRyfsDdMw==
Date:   Thu, 5 Dec 2019 09:38:08 +0000
Message-ID: <20191205093739.4040-7-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: 8ed2afa4-4298-46d9-fd49-08d77966d604
x-ms-traffictypediagnostic: MN2PR18MB2367:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB23673C92B76089DE7B0901A8D95C0@MN2PR18MB2367.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(189003)(199004)(81166006)(14444005)(14454004)(36756003)(6512007)(316002)(478600001)(54906003)(5660300002)(110136005)(186003)(8936002)(50226002)(6486002)(26005)(99286004)(66556008)(66476007)(81156014)(71190400001)(86362001)(66946007)(66446008)(64756008)(25786009)(8676002)(2906002)(71200400001)(6506007)(4326008)(2616005)(11346002)(102836004)(305945005)(1076003)(76176011)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2367;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F5GpYosiQTlNCnl/HRDFO6ckW1JoLOtat6WrLKHENE4x8yS+/+GH6MJgzHo1DHrsVJ/w65b1t0ATYyJsTiTfPctCtaOFWTOvsY7XxezZ5Se/VvzkatujPQIH6Ht4q2cgBpR7gfoJFF6J8j8BwDf6UWuxvBmbWEr8KD6K5PaksU/sQv8t3RELDp2pwLn6iSmOYdf/BQ+uRipLtJ6gMivUWe7eov9WgwQycyZS1bpqoa3Fri48iBNdOdHKsykzfYfzLIDoPlFBms7SHEyYtYGOszGU32ODyPVHM/kevQYVI6afweiy9X5Msjj0l3UlkZVseWqgS69gjrZXGSQ6I28Jm2cf/XXhIlOLP9mcb+m7OlYL4iVSrYlJUoPngtbKutpnmo5Et/4T4+B31neRalb2S/bjxUyr8iyw2IEX1Xh3K9RpUn5+xAF1ix+W/pp33g7V
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed2afa4-4298-46d9-fd49-08d77966d604
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 09:38:08.2559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dnk4ky1acYdfAPzun6Skn1x7qD1XKWPlRaJ8u4h6JtsaNep3/phzBlGN63TkByNZtMmBSRFM1aNTfYzCQoIelw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2367
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-05_01:2019-12-04,2019-12-05 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

There is a limitation to report only EDAC_MAX_LABELS in e->label of
the error descriptor. This is to prevent a possible string overflow.
Current implementation falls back to "any memory" in this case and
also stops all further processing to find a unique row and channel of
the possible error location. Reporting "any memory" is wrong as the
memory controller reported an error location for one of the layers.
Instead, report "unknown memory" and also do not break early in the
loop to further check row and channel for uniqueness.

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/edac_mc.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index e81d33960a0c..2b12320ce2f1 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -1243,20 +1243,21 @@ void edac_mc_handle_error(const enum hw_event_mc_er=
r_type type,
 		 * channel/memory controller/...  may be affected.
 		 * Also, don't show errors for empty DIMM slots.
 		 */
-		if (!e->enable_per_layer_report || !dimm->nr_pages)
+		if (!dimm->nr_pages)
 			continue;
=20
-		if (n_labels >=3D EDAC_MAX_LABELS) {
-			e->enable_per_layer_report =3D false;
-			break;
-		}
 		n_labels++;
-		if (p !=3D e->label) {
-			strcpy(p, OTHER_LABEL);
-			p +=3D strlen(OTHER_LABEL);
+		if (n_labels > EDAC_MAX_LABELS) {
+			p =3D e->label;
+			*p =3D '\0';
+		} else {
+			if (p !=3D e->label) {
+				strcpy(p, OTHER_LABEL);
+				p +=3D strlen(OTHER_LABEL);
+			}
+			strcpy(p, dimm->label);
+			p +=3D strlen(p);
 		}
-		strcpy(p, dimm->label);
-		p +=3D strlen(p);
=20
 		/*
 		 * get csrow/channel of the DIMM, in order to allow
--=20
2.20.1

