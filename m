Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9DEAB072
	for <lists+linux-edac@lfdr.de>; Fri,  6 Sep 2019 03:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404289AbfIFB5A (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 5 Sep 2019 21:57:00 -0400
Received: from mail-eopbgr780081.outbound.protection.outlook.com ([40.107.78.81]:20032
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730991AbfIFB5A (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 5 Sep 2019 21:57:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OAaBfb0uxbV9qHSLPh8XV0+/fdKTJyrBr6EvtD4JpR72Ehn37z7ls+31fvC/229TI1w4vRx6Qi8+XR8Sj85BAG8EcnqAMUNAERooTGx+3XCFk8kokO9Neu1Dgc82q7mhIpL0J7iTwbymeyL2ws1zw/CpaJJgnD1InjX/LEqmQzvnP09CC8bzbbswvLiPtdDRV2OExXPiufHJWo9PLXiC7f8enZdB1lkSBlASWb1L+ELNsb2Cvq3qzGTKPcG3nICB2LNp5d7HIFDPCtIoTPTg35lbSYDmjQDPbqxdRi9x5nm68SjLs+DUuxCSEew0/ndtN9L778yTGG6o8Ar1Lrtp/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRio4hNt8T1u7yNTESFwffuQkBkWEHbekLMlZVbt4Zc=;
 b=WN4d8hDGauEetmuUFvJ4Ppyvf6DQOANfU1cx47ok/qcViSuOLluyPFCSEQ58kRWqhoIf4Wo8TTohA4N68Lx8B8cjUJC2dxbU0M4GNKBK1CJMHZOOcG0+qbtpDcc9IkgPRyHt8jBUOk2dyxj/VrMrhr/24IvFGUYEB36/BfNdJBnV4ZK4UwD+JF5sZuxT5Q8DbXS1TAenMDybidNeufQrXhuCh7lxjbm3TC1N8tdZzNIAnl8RweylKpIGNqcMp9k5ffhn+ZT2YYFyOxGTDfQNfwhLueea5zEZN+9SacRC1WKU+GmsNxmNj/AI5wCXnK0hOttFSAjaC+0FifQ2+N905w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=knights.ucf.edu; dmarc=pass action=none
 header.from=knights.ucf.edu; dkim=pass header.d=knights.ucf.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=knightsucfedu39751.onmicrosoft.com;
 s=selector2-knightsucfedu39751-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRio4hNt8T1u7yNTESFwffuQkBkWEHbekLMlZVbt4Zc=;
 b=Vt7mX+OVROi2AkX6WbzgjAEtZHmCwYudbkf6F1sHvmgJ8y/6GKYSJbrugT0eJuZ1FOOmYJ8cyOG60o1cpes4OsJMYLlHZwP1UwVfxXJSkX256ioFBruwozePIh+8Fr0wxVIuDnT2QCFC4QCfOaAcAqwQdbUcizjGU+bRyZ1PoN8=
Received: from BN7PR07MB5186.namprd07.prod.outlook.com (20.176.176.155) by
 BN7PR07MB4737.namprd07.prod.outlook.com (52.135.251.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Fri, 6 Sep 2019 01:56:56 +0000
Received: from BN7PR07MB5186.namprd07.prod.outlook.com
 ([fe80::682e:801a:5227:668f]) by BN7PR07MB5186.namprd07.prod.outlook.com
 ([fe80::682e:801a:5227:668f%7]) with mapi id 15.20.2220.022; Fri, 6 Sep 2019
 01:56:56 +0000
From:   Isaac Vaughn <isaac.vaughn@Knights.ucf.edu>
To:     Borislav Petkov <bp@alien8.de>
CC:     Isaac Vaughn <isaac.vaughn@Knights.ucf.edu>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        "trivial@kernel.org" <trivial@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: [PATCH] Add PCI device IDs for family 17h, model 70h
Thread-Topic: [PATCH] Add PCI device IDs for family 17h, model 70h
Thread-Index: AQHVZFZcluMS+DwUu0Crbwpgo6jw5w==
Date:   Fri, 6 Sep 2019 01:56:56 +0000
Message-ID: <20190905215650.f8b5d22b625ddcff7d093883@knights.ucf.edu>
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
x-clientproxiedby: BN6PR1101CA0019.namprd11.prod.outlook.com
 (2603:10b6:405:4a::29) To BN7PR07MB5186.namprd07.prod.outlook.com
 (2603:10b6:408:2a::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=isaac.vaughn@Knights.ucf.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-unknown-linux-gnu)
x-originating-ip: [132.170.59.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4260df50-e277-4e0c-2455-08d7326d7f02
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN7PR07MB4737;
x-ms-traffictypediagnostic: BN7PR07MB4737:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR07MB473707B835FA8109E32C17D2CEBA0@BN7PR07MB4737.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0152EBA40F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(396003)(136003)(346002)(189003)(199004)(2616005)(446003)(86362001)(486006)(44832011)(25786009)(99286004)(476003)(6486002)(6512007)(71200400001)(186003)(66476007)(66946007)(8676002)(64756008)(26005)(11346002)(66446008)(81156014)(81166006)(6436002)(4326008)(53936002)(102836004)(386003)(6506007)(66556008)(8936002)(76176011)(7736002)(71190400001)(50226002)(66066001)(52116002)(256004)(316002)(305945005)(14444005)(3846002)(1076003)(786003)(6116002)(14454004)(5660300002)(6916009)(75432002)(54906003)(2906002)(478600001)(88552002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4737;H:BN7PR07MB5186.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: Knights.ucf.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DZalc41Xto10J2dXipAy1vh+7r64O1jvFULy92MiEuE9jzSNV1aB5AWNPoYQ3YMCkE0wVsjlqr3nATIyT9HGhazsK5W8Vlle2jwxUPgOsQodQXc492b5lP0uSPiTIfLip7MjGY5LHlowTS+af1RYRNd+Df0BlrZ/FJ557/rI709NkPdtOSFl3rz9V85nOrxwAfI2G+543tJ01WgmGdCx3Y1pQW/gRxtWQmU4CmhlAbrawOoOcD3Mei51a+CoZ9lFoleBJ4N5ExQ+uOoyM4n4/3uq/B0eq/9a7BXaiHXQzpmVynTTIUtxoGx3EWlujy3Es4MMX0OWtEc6+zIsKybanUhEAunxlc7CNP6OgjecM0zs6XPEbwXOMnNJxqGrOpYGMegCHFk+r0/be6pOdgNDu9z/ZNtmHIg/JI3wBFhnTVs=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <835D049EFC473C48B791EB2CE4445655@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: knights.ucf.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4260df50-e277-4e0c-2455-08d7326d7f02
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2019 01:56:56.0964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5b16e182-78b3-412c-9196-68342689eeb7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jBSuEaPRdf+yMDNgCueWsGTQz/xKEd7UM8WYhw2Y7I7bJLDj8sEm8k5gveVrwyG+ra34S9kRmm6aQHG5W5iqW/AzLYSH4aR3RHepnJo50gE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4737
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add the new Family 17h Model 70h PCI IDs (device 18h functions 0,3,4,6)
to the kernel, the hwmon module, and the AMD64 EDAC module.

Signed-off-by: Isaac Vaughn <isaac.vaughn@knights.ucf.edu>
---
 arch/x86/kernel/amd_nb.c  |  3 +++
 drivers/edac/amd64_edac.c | 13 +++++++++++++
 drivers/edac/amd64_edac.h |  3 +++
 drivers/hwmon/k10temp.c   |  1 +
 include/linux/pci_ids.h   |  1 +
 5 files changed, 21 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index d63e63b7d1d9..0a8b816857c1 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -21,6 +21,7 @@
 #define PCI_DEVICE_ID_AMD_17H_DF_F4	0x1464
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
 #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4 0x1494
+#define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4 0x1444
=20
 /* Protect the PCI config register pairs used for SMN and DF indirect acce=
ss. */
 static DEFINE_MUTEX(smn_mutex);
@@ -49,6 +50,7 @@ const struct pci_device_id amd_nb_misc_ids[] =3D {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },
 	{}
 };
@@ -63,6 +65,7 @@ static const struct pci_device_id amd_nb_link_ids[] =3D {
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
