Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B621AC2F5
	for <lists+linux-edac@lfdr.de>; Sat,  7 Sep 2019 01:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392887AbfIFXWW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 6 Sep 2019 19:22:22 -0400
Received: from mail-eopbgr810083.outbound.protection.outlook.com ([40.107.81.83]:22336
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732131AbfIFXWW (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 6 Sep 2019 19:22:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gf9N1PVtaEj3367MxIdqHrMXBdkVL2zBR2e9kLhv1JSXYMui2SUZKnLMoeHeSuZPCJ+UNAfGRrTghv/zIzODMV6EM5CM66YBgTHz1Bxu2RKR5hFK7ZbaWZa6HC+CQX5rQSk94nj4TXp5ZEpOkiXXxmtsPZiBNmGXk4DeUAfqjAdhsSXYmdDOjRoMPS0xH7269cv448YFZEt1bfErlhDnFbmMGrcRRVUIBGsjy6UTXoXLcfK9KubRzJzhiTDU0kN6j1hfaXzCvHqO9C0MVV9wnE6xKHhLya8ciPRxYNMtx0vstZLzcLdc7ja2+7YO2IYEl3Isiljm+toezigbkQ9UYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Re/OxUZbzUXGhJHaZBJOdblBhtvrLl9KrKFh7RLbwc=;
 b=NA+pXC/OdmZW+CbAKMKLxgJ86fbEKsF2ophsEwXjXhWXWUJwqUoSWPZ2fZSYiolCQYYPtTG5qSXFz1MenIrVZ4/waFg96P6F24E4Hh6ywzjT+oaKDRr+CTDLE7yS2N87fx/G9BLNQxvBskBw8fsuqcJoON+7GNjB75jgU1kPAoNqhPX6RFWjPrfUknMIQqfR2ZXVeTqMUa/dAzzQaD+LWbzUvM/m3fa4Nj3BIOpLniJC0GrcGL1u9+O20fVlrMqrkpJAHrPd04A9Ny81JQjUlSm6yF6FL0+NJFJeoi6snWg3as7sJ6L62em+jIaM0XKlZORhqB3evR1cWOE0RLnrFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=knights.ucf.edu; dmarc=pass action=none
 header.from=knights.ucf.edu; dkim=pass header.d=knights.ucf.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=knightsucfedu39751.onmicrosoft.com;
 s=selector2-knightsucfedu39751-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Re/OxUZbzUXGhJHaZBJOdblBhtvrLl9KrKFh7RLbwc=;
 b=IHs+bNP8gtUhObk2W7cadhT4/kC/06bvpZQHMgVJiTpjjypTOo8XqqgbaIA3d4S8LLQkGdGQQrtj4AFLwhCFL9wvtf0PAwSqTKML2B3LR8npILsez/4D0Ynn/hyIp2YxvnjbAKiOcG8ctJCsrCmrczz4qqb7gqfKe49IqqhDE/w=
Received: from BN7PR07MB5186.namprd07.prod.outlook.com (20.176.176.155) by
 BN7PR07MB4258.namprd07.prod.outlook.com (52.135.242.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Fri, 6 Sep 2019 23:21:38 +0000
Received: from BN7PR07MB5186.namprd07.prod.outlook.com
 ([fe80::682e:801a:5227:668f]) by BN7PR07MB5186.namprd07.prod.outlook.com
 ([fe80::682e:801a:5227:668f%7]) with mapi id 15.20.2220.022; Fri, 6 Sep 2019
 23:21:38 +0000
From:   Isaac Vaughn <isaac.vaughn@Knights.ucf.edu>
To:     Borislav Petkov <bp@alien8.de>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] Add PCI device IDs for family 17h, model 70h
Thread-Topic: [PATCH] Add PCI device IDs for family 17h, model 70h
Thread-Index: AQHVZQnUh7Ebv130M0alIHUhtmAMhQ==
Date:   Fri, 6 Sep 2019 23:21:38 +0000
Message-ID: <20190906192131.8ced0ca112146f32d82b6cae@knights.ucf.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR1801CA0023.namprd18.prod.outlook.com
 (2603:10b6:405:5f::36) To BN7PR07MB5186.namprd07.prod.outlook.com
 (2603:10b6:408:2a::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=isaac.vaughn@Knights.ucf.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-unknown-linux-gnu)
x-originating-ip: [132.170.61.99]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb535556-763d-464b-c48c-08d73320f76c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN7PR07MB4258;
x-ms-traffictypediagnostic: BN7PR07MB4258:
x-microsoft-antispam-prvs: <BN7PR07MB4258B4E44F63B9E8E63070C2CEBA0@BN7PR07MB4258.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-forefront-prvs: 0152EBA40F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(376002)(396003)(366004)(199004)(189003)(75432002)(71200400001)(71190400001)(66066001)(50226002)(186003)(1076003)(86362001)(66946007)(256004)(5660300002)(6512007)(6916009)(53936002)(6436002)(14454004)(478600001)(66476007)(25786009)(3846002)(4326008)(64756008)(66446008)(66556008)(476003)(2906002)(6486002)(6116002)(305945005)(88552002)(8936002)(6506007)(386003)(26005)(102836004)(99286004)(316002)(786003)(8676002)(81156014)(52116002)(2616005)(54906003)(44832011)(486006)(81166006)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4258;H:BN7PR07MB5186.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: Knights.ucf.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7F+ESkwvq4P13Hp7BemchKMCBg3TnP+kcrfU7VaTSReqLThU7lPJEFMqZSNNyI62pQANX5Q+uvCGQfXmbwYpF2JncvHmfzfnGcievGvpM1mPeGZ7iSkEylLcZ/heYGBIo1Bp0dTUBI8KYkRnfZ5ed9kPgTAjIU0zLqZC301BDHY10Fhns0jLuQS0OSzdt4QuLy6TxdlmQ46BgDPexk21hAqvYWNLoKaqeDs/rhno6f7M1b+bB5jvoXCNxR7zaKm9qsL5tpypd3GenuJ8G0tSo/8iPQaGFxQyo7EzM7IHY2RMA9OxVyAuXAsdUhXbX9e1V7XaSemLhmRcEpsIt4Nt7bbJsOX5v9eJzeBGMGupIjJmcH1IVGp/dpXElKa2F03Z0RmVeRuPz1MG3SgNRCHUg2DMCNIxdbuTOVVtkjdaeqA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4864796329BE3247A31201B95777A322@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: knights.ucf.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: cb535556-763d-464b-c48c-08d73320f76c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2019 23:21:38.2753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5b16e182-78b3-412c-9196-68342689eeb7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gRYRJvabhRhbFnRvyJx+T+i4ylXDiUCTAXd0tqskJ0m89tawYxCNA/CvemMRY5n1gnzYrdKJKFLa+DM2T5dUrI9jFaiDLdOsqiuTttJpKyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4258
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add the new Family 17h Model 70h PCI IDs (device 18h functions 0 and 6)
to the AMD64 EDAC module.

Cc: Borislav Petkov <bp@alien8.de> (maintainer:EDAC-AMD64)
Cc: Mauro Carvalho Chehab <mchehab@kernel.org> (supporter:EDAC-CORE)
Cc: James Morse <james.morse@arm.com> (reviewer:EDAC-CORE)
Cc: linux-edac@vger.kernel.org (open list:EDAC-AMD64)
Cc: linux-kernel@vger.kernel.org (open list)
Signed-off-by: Isaac Vaughn <isaac.vaughn@knights.ucf.edu>
---
 drivers/edac/amd64_edac.c | 13 +++++++++++++
 drivers/edac/amd64_edac.h |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 873437be86d9..a35c97f9100a 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2253,6 +2253,15 @@ static struct amd64_family_type family_types[] =3D {
 			.dbam_to_cs		=3D f17_base_addr_to_cs_size,
 		}
 	},
+	[F17_M70H_CPUS] =3D {
+		.ctl_name =3D "F17h_M70h",
+		.f0_id =3D PCI_DEVICE_ID_AMD_17H_M70H_DF_F0,
+		.f6_id =3D PCI_DEVICE_ID_AMD_17H_M70H_DF_F6,
+		.ops =3D {
+			.early_channel_count	=3D f17_early_channel_count,
+			.dbam_to_cs		=3D f17_base_addr_to_cs_size,
+		}
+	},
 };
=20
 /*
@@ -3241,6 +3250,10 @@ static struct amd64_family_type *per_family_init(str=
uct amd64_pvt *pvt)
 			fam_type =3D &family_types[F17_M30H_CPUS];
 			pvt->ops =3D &family_types[F17_M30H_CPUS].ops;
 			break;
+		} else if (pvt->model >=3D 0x70 && pvt->model <=3D 0x7f) {
+			fam_type =3D &family_types[F17_M70H_CPUS];
+			pvt->ops =3D &family_types[F17_M70H_CPUS].ops;
+			break;
 		}
 		/* fall through */
 	case 0x18:
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 8f66472f7adc..1adf7ddbf744 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -119,6 +119,8 @@
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F6 0x15ee
 #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F0 0x1490
 #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F6 0x1496
+#define PCI_DEVICE_ID_AMD_17H_M70H_DF_F0 0x1440
+#define PCI_DEVICE_ID_AMD_17H_M70H_DF_F6 0x1446
=20
 /*
  * Function 1 - Address Map
@@ -285,6 +287,7 @@ enum amd_families {
 	F17_CPUS,
 	F17_M10H_CPUS,
 	F17_M30H_CPUS,
+	F17_M70H_CPUS,
 	NUM_FAMILIES,
 };
=20
--=20
2.23.0
