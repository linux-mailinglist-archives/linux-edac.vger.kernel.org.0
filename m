Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82B2FAAFF9
	for <lists+linux-edac@lfdr.de>; Fri,  6 Sep 2019 03:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733189AbfIFBBo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 5 Sep 2019 21:01:44 -0400
Received: from mail-eopbgr720084.outbound.protection.outlook.com ([40.107.72.84]:18064
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731344AbfIFBBo (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 5 Sep 2019 21:01:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNGUXzX7eYNeS1/Gu8xi6260g2vWWf6Tv4HXXPZuqWaIf17IgAtFzS6e+CF0Hgtn4wpmuXNqj6Pp7ahOIP9qflgIYSbgwcVLmM6ZcG4t7mWTyfLt1td5CywNyhjNklTLc5AIDqjBvHoXZJQS687FIt9WSgAlAVj8doI2kOuPcpmqPTLy4zTdAJbiJXHPhNFRuiSk10rjF1SiiCx6nGJaFH+jPvQl+NlHKLInahGbxiYBsCLHKMWGWJzzST1cWvD9CqWpZQu/VTHLYYu6XNpZx76Xvo5SAUs7ZK6TDj8GU1yDqlqNkdIiJqER8FUBvI4/EW8T+SIDiDWJcahJHf7+Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tSh8TeOK1aGw9lkNvDHEIkXtjBVPieJPo6PZLldOhU=;
 b=gUu3/A0g9DUa0AxOHleWoLlRZ8TaB1NRM6kslhzDA47VQHgrUTJfJYqYzaoCmfW+ua9atPgh3I0KXysHEW8F980T/HPNyfc+EgBZq+Q786QLwa7wrJ0PtKGEdQFWEkiaWjZktROX/xVKCZGqFXfDR6x/cW9zpZv/NX9VRZo99mmNgDBNgN0fzwh2Hn+hBttu6jRL24VKrQGVyoJW1NFwfpJX7RpbHCDjiEjuexh4HNp8VnsFiQHKwEHkR/IL0pq0pjl9AKtewL4PH4+L1bZvuviKv8wJNyRuJgoPlu/d5ymyUcPrcBOVyqvN3vk6FeVlRbdWAcfVThqv1gLYisohgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=knights.ucf.edu; dmarc=pass action=none
 header.from=knights.ucf.edu; dkim=pass header.d=knights.ucf.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=knightsucfedu39751.onmicrosoft.com;
 s=selector2-knightsucfedu39751-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tSh8TeOK1aGw9lkNvDHEIkXtjBVPieJPo6PZLldOhU=;
 b=IeyvP9wO4YND+mkb7wFYEn03bFtllsEiVN/TNu2LIPw0ce5IqNmwglrYKF9pmJbQhNBpZH7zubGTqMHQecxRWBL9uuHVcoN/s5DAT6V7tmHhA1MJsEPlbCEeiptm5EZtdP79NSNHG64HCfJMgA5KIkkxI2Ddzag2ZNzOIIQo/xM=
Received: from BN7PR07MB5186.namprd07.prod.outlook.com (20.176.176.155) by
 BN7PR07MB4321.namprd07.prod.outlook.com (52.135.244.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.20; Fri, 6 Sep 2019 01:01:40 +0000
Received: from BN7PR07MB5186.namprd07.prod.outlook.com
 ([fe80::682e:801a:5227:668f]) by BN7PR07MB5186.namprd07.prod.outlook.com
 ([fe80::682e:801a:5227:668f%7]) with mapi id 15.20.2220.022; Fri, 6 Sep 2019
 01:01:40 +0000
From:   Isaac Vaughn <isaac.vaughn@Knights.ucf.edu>
To:     Borislav Petkov <bp@alien8.de>
CC:     Isaac Vaughn <isaac.vaughn@Knights.ucf.edu>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        "trivial@kernel.org" <trivial@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: [PATCH] Add PCI device IDs for family 17h, model 70h
Thread-Topic: [PATCH] Add PCI device IDs for family 17h, model 70h
Thread-Index: AQHVZE6kH3oGzh5RYUazEryN7a2A8w==
Date:   Fri, 6 Sep 2019 01:01:40 +0000
Message-ID: <20190905210134.007503f968a34cff43921390@knights.ucf.edu>
References: <BN7PR07MB5186DD5732B95B784A9D46BFCEB80@BN7PR07MB5186.namprd07.prod.outlook.com>
        <20190904215308.GA12374@zn.tnic>
        <BN7PR07MB5186E542BB3AD734262AA345CEBB0@BN7PR07MB5186.namprd07.prod.outlook.com>
        <20190905070917.GA19246@zn.tnic>
        <BN7PR07MB51864F8287CAD4847BF17A83CEBB0@BN7PR07MB5186.namprd07.prod.outlook.com>
        <20190905135408.GE19246@zn.tnic>
In-Reply-To: <20190905135408.GE19246@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR1201CA0003.namprd12.prod.outlook.com
 (2603:10b6:405:4c::13) To BN7PR07MB5186.namprd07.prod.outlook.com
 (2603:10b6:408:2a::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=isaac.vaughn@Knights.ucf.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-unknown-linux-gnu)
x-originating-ip: [132.170.59.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ccc741c-b9e8-4e28-eb00-08d73265c66b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN7PR07MB4321;
x-ms-traffictypediagnostic: BN7PR07MB4321:|BN7PR07MB4321:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR07MB43215114B4C50BC678E30415CEBA0@BN7PR07MB4321.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0152EBA40F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39860400002)(396003)(136003)(199004)(189003)(86362001)(14454004)(446003)(44832011)(478600001)(71190400001)(75432002)(11346002)(7736002)(71200400001)(2616005)(256004)(305945005)(486006)(102836004)(6916009)(88552002)(66066001)(14444005)(6506007)(2906002)(386003)(6512007)(476003)(66446008)(52116002)(66476007)(8676002)(3846002)(6436002)(66556008)(53936002)(316002)(66946007)(26005)(8936002)(4326008)(6116002)(64756008)(81156014)(99286004)(81166006)(5660300002)(25786009)(186003)(786003)(1076003)(50226002)(76176011)(6486002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4321;H:BN7PR07MB5186.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: Knights.ucf.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LEC6rS+DgA63SzU9GyN0il9fPjY8qgV+WOqd9EA2MydSa2LNtnty+dk+JM0dDKB0qEQaltebJcw0ifLAp0yLj+CqaThXs16c4jQnN6XqHLQgqfPuKrqPVViLLVTHEgLR9upGP6uxbnSIyXUY83m3jwuGKvVUZzCWCoXYlMPqqGSR73HmNumE7Jh1gt3Sxzhkvn8PFsh0pOQne9dAyXqgKLtc39d6x9LxvmtFhmENLd9wSnw3ldHzc5QZYGT6BtiwrRdR4TAfAXexsjq9Rwa00PKaErJ7QcoGiPN4XEVMkebM7LqqOsh0BIygp/8hREXb/UgUB7MxxqKjxH1d9NTCU8kHBGBQyZg9yxfV37x2cdwbyxML0WFewHTa4F4CGN+rsd789G44mdPZbCByVQnLZtdfovu7wgXLsyLWP0PyOdY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F9F7D624F653084DB5E408FE4C11CAA0@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: knights.ucf.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ccc741c-b9e8-4e28-eb00-08d73265c66b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2019 01:01:40.3718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5b16e182-78b3-412c-9196-68342689eeb7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SdBi0V/YmEOlPLV1QA8/Rc7bjUB8FeO5Z6kipaMqhIJDG9wEZET99M7oS8DFcU0rn/qW0QF5OxDlzDPrPkM2UfGyycVuEaU8m90cd8Z5Wh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4321
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add the new Family 17h Model 70h PCI IDs (device 18h functions 0,3,4,6)
to the kernel, the hwmon module, and the AMD64 EDAC module.

Signed-off-by: Isaac Vaughn <isaac.vaughn@knights.ucf.edu>
---
 arch/x86/kernel/amd_nb.c  |  5 +++++
 drivers/edac/amd64_edac.c | 13 +++++++++++++
 drivers/edac/amd64_edac.h |  3 +++
 drivers/hwmon/k10temp.c   |  1 +
 include/linux/pci_ids.h   |  1 +
 5 files changed, 23 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index d63e63b7d1d9..08cc057126ba 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -18,9 +18,11 @@
 #define PCI_DEVICE_ID_AMD_17H_ROOT	0x1450
 #define PCI_DEVICE_ID_AMD_17H_M10H_ROOT	0x15d0
 #define PCI_DEVICE_ID_AMD_17H_M30H_ROOT	0x1480
+#define PCI_DEVICE_ID_AMD_17H_M70H_ROOT	0x1480
 #define PCI_DEVICE_ID_AMD_17H_DF_F4	0x1464
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
 #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4 0x1494
+#define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4 0x1444
=20
 /* Protect the PCI config register pairs used for SMN and DF indirect acce=
ss. */
 static DEFINE_MUTEX(smn_mutex);
@@ -31,6 +33,7 @@ static const struct pci_device_id amd_root_ids[] =3D {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_ROOT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_ROOT) },
 	{}
 };
=20
@@ -49,6 +52,7 @@ const struct pci_device_id amd_nb_misc_ids[] =3D {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },
 	{}
 };
@@ -63,6 +67,7 @@ static const struct pci_device_id amd_nb_link_ids[] =3D {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
 	{}
 };
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
diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index c77e89239dcd..5c1dddde193c 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -349,6 +349,7 @@ static const struct pci_device_id k10temp_id_table[] =
=3D {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
 	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{}
 };
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index c842735a4f45..4b97f427cc92 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -548,6 +548,7 @@
 #define PCI_DEVICE_ID_AMD_17H_DF_F3	0x1463
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F3 0x15eb
 #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F3 0x1493
+#define PCI_DEVICE_ID_AMD_17H_M70H_DF_F3 0x1443
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
 #define PCI_DEVICE_ID_AMD_LANCE		0x2000
 #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
--=20
2.23.0
