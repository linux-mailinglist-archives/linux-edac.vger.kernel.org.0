Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8179910BFEF
	for <lists+linux-edac@lfdr.de>; Wed, 27 Nov 2019 22:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbfK0Vzi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 27 Nov 2019 16:55:38 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:44034 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727798AbfK0VzF (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 27 Nov 2019 16:55:05 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xARLpk5P026852;
        Wed, 27 Nov 2019 13:54:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=p4XQFsZ1vCxGqQKEPMJI1oMeRWfaj3eM5bgY3ORJMl4=;
 b=m4/wmDpDyK496+S6jX+bkd9v+H427sAr5Q2hxa9sLgEKiX+d8V4psa7sCZemuCRdVKr6
 D5XoQk+fGvBxLECDoK0x22weXa6SUUtmXHS1mro52kanKdqN9eLgAGhyMLJlMZRyfBmJ
 HKjhJcv9FB1gcjFxcXFC3QiWxez/ckhjtP10Rr0hX7EASSF8FEhl9gizmIUZxbAgT/2F
 +7RWnJFM/QSrKEnYf0XwyU4F73puC9bPhF7m5EDbcgQ2MlfhBul8m+cMjCoAPeTGDsIg
 PB7VfIBlTWG6srdboj3oGtMjiVTyRCfJQv1o804DN4BAbqEO9Jndk3gZTYS/zDJLP1NT JQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2whmdyb5sa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 27 Nov 2019 13:54:58 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 27 Nov
 2019 13:54:58 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.51) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 27 Nov 2019 13:54:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsW597vioH5Xj6oPALepuUiZRz+QW865JG0V7oKCeNim/Ou4VWd/fb8XpFrq1wyXjQm6A3xIZ1j8tk/tRytsPy61e42z6m3kRmrKAy+8xKaUfgyiP+mfPVlgcnQEZgv05nB3rUgvsr4+yGlk4gj+ndcQdp3m80PhqTUxxIF1u+r67F5yaWdVpa8yRzmJDqs7rdFV+RFoqf7wFj8CFM9OkqYJn3FB3SkQKwJ3MBevbqXC6YRVIuZDWxKMC7XyZ3i3E6AO1ahUW1NJ0JtLCL40MoJ9COoUjJKCWXlfJaycE0LJvqeuMH77Q059vhGDknaMLiopqPt8lsbVhGKK0NBsCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4XQFsZ1vCxGqQKEPMJI1oMeRWfaj3eM5bgY3ORJMl4=;
 b=Mo0kV3H/H3N/84uD0JisfAoIFR5AManoIHrS9QvjpYnvblipCxBHZrVfLiq8CaNQBV6fSjwGgZhA0Nqjz5dSItxKfF+Nej4UAGynKogFep9qdhisOWNYOXGawsZ61k1azO36b81GwsDB/EZCx11hZL8riYUA2+2W9acU3giwu8ISN5xIAwszm2NCsOBdW4WOqr8LURJ6SUKbLJVtfK1vlJPBdR6D7jh1G0/wtGkHVMkBrJ24EdxggYjS5OA0c8t0MfawjXE8xO89v0SIA1MjoScX5Sb29TaU89oXbcU3zPEvQZVoGc5yr3j6B58+OTHQjIDo1HkH30pH5IvS4b3ebw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4XQFsZ1vCxGqQKEPMJI1oMeRWfaj3eM5bgY3ORJMl4=;
 b=KrNFTylfxqCwm7DC3mamhRs5cQkRnSZQ27ICvS5nmPZQcE1t/4ZLWCYef9q7+GzZaD9ix3t4JQWYw0pg9wvgwOrwIBN04Xtb/l32OtTSPJYUj7hGO7rB7oTD9g3eDi5B8cKmwXc3Qfe3u8nwQqmb2t2cRVKsbqcOnkii53xSHDw=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2477.namprd18.prod.outlook.com (20.179.81.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.22; Wed, 27 Nov 2019 21:54:56 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106%7]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 21:54:56 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 06/10] EDAC/mc: Report "unknown memory" on too many DIMM
 labels found
Thread-Topic: [PATCH 06/10] EDAC/mc: Report "unknown memory" on too many DIMM
 labels found
Thread-Index: AQHVpW1OH6J9ngfh/0quQkcd0wFb0Q==
Date:   Wed, 27 Nov 2019 21:54:56 +0000
Message-ID: <20191127215415.11230-7-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: 4f7a0990-a986-4112-7edd-08d773847108
x-ms-traffictypediagnostic: MN2PR18MB2477:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB247799074F74065F558CFFA8D9440@MN2PR18MB2477.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(189003)(199004)(14454004)(305945005)(110136005)(256004)(186003)(1076003)(4326008)(86362001)(11346002)(6436002)(14444005)(8676002)(6486002)(81156014)(2906002)(81166006)(386003)(6512007)(478600001)(76176011)(54906003)(99286004)(52116002)(8936002)(25786009)(7736002)(66946007)(6116002)(26005)(316002)(66066001)(50226002)(36756003)(71190400001)(3846002)(66476007)(66556008)(64756008)(66446008)(71200400001)(102836004)(2616005)(6506007)(446003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2477;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: axu9XjyfSo/xpmnqkr61MWhNrpQWibxJYVlMu2iGdSnv5IDsojYmnXlDUI8T3Xpju8CG4mrmV8tjToGBhzfgtyMp3g31U+8L75L3tkcGj915rcb8NNcHbJI288j5z6IT5HEwOHaftxqWbQK9NojYCJRhaP8CjxS/KAnGNGqutt7r8Zp5RKNHmTqNFmRtWGVZrKMAfaGm7lMGsg1QTqeRdH/29bzTVOcPOfVAapg/q9TcU8e5hvhTKd40yQnxlOsQBR0puxZ0vAX1asaTxDyoaPOkRR1Lm/oef24ZZtpLpYZ0hM0BCdYmOyGTP+xFPwiC2N5jk1WZU6RAmJjHzSyCoJWJDUEETkogianswwK4j0uKiQBVQOUcff/IgmBsgPAyTGFOeM1zp7CMeapLk5vEtzFweCVvCH1CUTyno3TI4T2d9rCkn1xWiInXRhnk8EmP
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f7a0990-a986-4112-7edd-08d773847108
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 21:54:56.6843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O6QTuZzQdIM/80N/WvENvOp41PVmMz8ALO48EzsNjBxu6ogbLfBUqTlNrDiR7pQeSh+yJ4ZAGwYdHr6OsCvYuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2477
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-27_04:2019-11-27,2019-11-27 signatures=0
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

