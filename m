Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC24AA97FE
	for <lists+linux-edac@lfdr.de>; Thu,  5 Sep 2019 03:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbfIEBVo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 4 Sep 2019 21:21:44 -0400
Received: from mail-eopbgr700050.outbound.protection.outlook.com ([40.107.70.50]:14080
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727544AbfIEBVo (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 4 Sep 2019 21:21:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJ2SuoVtLc0ctrKlAjOKOa/Q1l2xVP4SejghUtR9teJPZbybxj46mMZKPuxk0mmmky3Z9G0Zbu/E5d3BfYkvlPkVxc2aj6nDaKzcgon0NhBsfd/ZNgm+Npn39kMSA5fA2FzJ/RCJBEkCoHWP7M3uDq0c4KAPfxu0+iEcD3WBHaJSdN3ScxyJhxMOCL9f+vxnXUJnZafxIGyDc2GTNXSx5OCfjNoB/a0PyBaAOpME4109vaNjtkt1/gPBpIlfVKn2BrFsAuJrBzShARsgB+Kcx7XTwfjgmiNQqjIMlWaQioFYskfjbWN99mO82qh+TATW+kz6gxbBCt3t1jn0IFHvYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0j2gFcn6hCu5kIj/30ygpiUXJ4xWoo+T2/TYnRlrxU=;
 b=Grdx94YAyLBUoHPHpJGv6eHnIiKYSDOmYF/TEsEZTstCsafbz9m9VMMGk+BGaf8B2bv+9tuI3hnSRJGwmlzDbOFGArDQ4or76gkI5RKqnsfZXzorubm++KX0WghtsveBZIP4k7WWRoaggZQXNaLT42YNFZWZGCVt8UVmf9L4uloga/JJ1QxJr45o6XIEZUlpPOdth909CPkr92UYHO8ojOxm8ktHokRjIx4nCcvf4/jmKcos/0sDV5yhQoUpg6jNHu9UEnXBsayOpGDxb5oWT9FXnDRtjfOx61NX3Jyj4E2N7GwmWBGZHOaMYjBDldOcM7K4lPY/5eL4FWnLBezVYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=knights.ucf.edu; dmarc=pass action=none
 header.from=knights.ucf.edu; dkim=pass header.d=knights.ucf.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=knightsucfedu39751.onmicrosoft.com;
 s=selector2-knightsucfedu39751-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0j2gFcn6hCu5kIj/30ygpiUXJ4xWoo+T2/TYnRlrxU=;
 b=dv5jt2bF6IyvPGmX0zl1IJOvhyXUWcYBYP2+J+gJFF8SVVZabHBby01JR1TF4Cc9RLuHg76f9XyyeO/c2MTue7XP9SMJJppe+9h5GOvaEbe6xW8aTGQSShVngs/Aah9+/eDzA68N3xalIzU+FiPoQWMIdR8eS/bDVgbI/mekb+w=
Received: from BN7PR07MB5186.namprd07.prod.outlook.com (20.176.176.155) by
 BN7PR07MB4884.namprd07.prod.outlook.com (52.135.248.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Thu, 5 Sep 2019 01:21:40 +0000
Received: from BN7PR07MB5186.namprd07.prod.outlook.com
 ([fe80::682e:801a:5227:668f]) by BN7PR07MB5186.namprd07.prod.outlook.com
 ([fe80::682e:801a:5227:668f%7]) with mapi id 15.20.2220.022; Thu, 5 Sep 2019
 01:21:40 +0000
From:   Isaac Vaughn <isaac.vaughn@Knights.ucf.edu>
To:     Borislav Petkov <bp@alien8.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>
CC:     "trivial@kernel.org" <trivial@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [PATCH] amd64_edac - Add Family 17h Model 70h PCI IDs
Thread-Topic: [PATCH] amd64_edac - Add Family 17h Model 70h PCI IDs
Thread-Index: AQHVY2RbCb5+3YDIEkuYe/75JNXLCKccD30AgAA0MwY=
Date:   Thu, 5 Sep 2019 01:21:40 +0000
Message-ID: <BN7PR07MB5186E542BB3AD734262AA345CEBB0@BN7PR07MB5186.namprd07.prod.outlook.com>
References: <BN7PR07MB5186DD5732B95B784A9D46BFCEB80@BN7PR07MB5186.namprd07.prod.outlook.com>,<20190904215308.GA12374@zn.tnic>
In-Reply-To: <20190904215308.GA12374@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=isaac.vaughn@Knights.ucf.edu; 
x-originating-ip: [132.170.61.188]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f624779f-2b5e-490a-0909-08d7319f6789
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN7PR07MB4884;
x-ms-traffictypediagnostic: BN7PR07MB4884:
x-microsoft-antispam-prvs: <BN7PR07MB4884B4CABE9ADAFA9E162C62CEBB0@BN7PR07MB4884.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(136003)(346002)(396003)(199004)(189003)(7696005)(44832011)(88552002)(102836004)(110136005)(5660300002)(476003)(2906002)(26005)(11346002)(486006)(33656002)(76176011)(786003)(186003)(66946007)(8936002)(75432002)(6246003)(4326008)(52536014)(14444005)(446003)(81156014)(53936002)(6506007)(316002)(256004)(3846002)(81166006)(6436002)(7736002)(86362001)(305945005)(8676002)(74316002)(55016002)(9686003)(6116002)(66066001)(478600001)(54906003)(99286004)(76116006)(229853002)(71190400001)(71200400001)(14454004)(64756008)(25786009)(66446008)(66476007)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4884;H:BN7PR07MB5186.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: Knights.ucf.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GzFXEegHZX27hfrc4lWvxIiwjuwdjchKSHO5GtKihnJckneG3EGs1aYE7hQUosRZk9ZysWk8gIBO5zEzKq/wLilg+ye61YJW26E0m3aMhBFPcbYVfpxbsHULmdkKJkGMXr73MlxYeYUm/VS/lb+kgnH/4MPqs2SVb+PB5k9HRbDaX72wQlUP/P5lRvj3nlOaDy5MP4Obo1ldNl2nklUn9bglGd43mKBWUdCgg0DRc6Oh+SxxQnuz6UGTPeh3tNhj3CsVBJoDhFAMCjjDV9v/Sea6gJrW2pUnm7g71vfAtzExpKqplPndTHHrPJfn6g1ZhxirCoTiPNJWKg2V7Ohm+Oz8uASgqbSrfaYF14HBkKE+dm+bMWTib8nsXP8GQHPsufGkhAHqO+Jr9E7UlKxYZe65X9lKJCOipec/seRfeC0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: knights.ucf.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: f624779f-2b5e-490a-0909-08d7319f6789
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 01:21:40.1710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5b16e182-78b3-412c-9196-68342689eeb7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bPg3u6HQurQspiDx/R+uHnCB8OeQeh7/2b7ZWB8m7hEBzGD0l/wDOh/7jzVSBR4IByG3N3Y0BB/KBwOluX/tawcL7pQJ24mPEYuUCmzVGzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4884
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add the new Family 17h Model 70h PCI IDs (device 18h functions 0, 3, 4, and=
 6) to the kernel, the hwmon module, and the AMD64 EDAC module.

Signed-off-by: Isaac Vaughn <isaac.vaughn@knights.ucf.edu>
---
Changes to the amd64_edac were tested on 5.2.11 and the current patch was t=
ested on 5.3.0rc7. Since git's pager has been mangling my indentation, diff=
s were generated with the '--no-pager' option. (Not sure if this might make=
 output non-standard in some other way.)

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
 #define PCI_DEVICE_ID_AMD_17H_ROOT     0x1450
 #define PCI_DEVICE_ID_AMD_17H_M10H_ROOT        0x15d0
 #define PCI_DEVICE_ID_AMD_17H_M30H_ROOT        0x1480
+#define PCI_DEVICE_ID_AMD_17H_M70H_ROOT        0x1480
 #define PCI_DEVICE_ID_AMD_17H_DF_F4    0x1464
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
+       { PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_ROOT) },
        {}
 };
=20
@@ -49,6 +52,7 @@ const struct pci_device_id amd_nb_misc_ids[] =3D {
        { PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
        { PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F3) }=
,
        { PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F3) }=
,
+       { PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) }=
,
        { PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },
        {}
 };
@@ -63,6 +67,7 @@ static const struct pci_device_id amd_nb_link_ids[] =3D {
        { PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_DF_F4) },
        { PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F4) }=
,
        { PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F4) }=
,
+       { PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F4) }=
,
        { PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
        {}
 };
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 873437be86d9..a35c97f9100a 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2253,6 +2253,15 @@ static struct amd64_family_type family_types[] =3D {
                        .dbam_to_cs             =3D f17_base_addr_to_cs_siz=
e,
                }
        },
+       [F17_M70H_CPUS] =3D {
+               .ctl_name =3D "F17h_M70h",
+               .f0_id =3D PCI_DEVICE_ID_AMD_17H_M70H_DF_F0,
+               .f6_id =3D PCI_DEVICE_ID_AMD_17H_M70H_DF_F6,
+               .ops =3D {
+                       .early_channel_count    =3D f17_early_channel_count=
,
+                       .dbam_to_cs             =3D f17_base_addr_to_cs_siz=
e,
+               }
+       },
 };
=20
 /*
@@ -3241,6 +3250,10 @@ static struct amd64_family_type *per_family_init(str=
uct amd64_pvt *pvt)
                        fam_type =3D &family_types[F17_M30H_CPUS];
                        pvt->ops =3D &family_types[F17_M30H_CPUS].ops;
                        break;
+               } else if (pvt->model >=3D 0x70 && pvt->model <=3D 0x7f) {
+                       fam_type =3D &family_types[F17_M70H_CPUS];
+                       pvt->ops =3D &family_types[F17_M70H_CPUS].ops;
+                       break;
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
+       F17_M70H_CPUS,
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
+       { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
        { PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
        {}
 };
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index c842735a4f45..4b97f427cc92 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -548,6 +548,7 @@
 #define PCI_DEVICE_ID_AMD_17H_DF_F3    0x1463
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F3 0x15eb
 #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F3 0x1493
+#define PCI_DEVICE_ID_AMD_17H_M70H_DF_F3 0x1443
 #define PCI_DEVICE_ID_AMD_CNB17H_F3    0x1703
 #define PCI_DEVICE_ID_AMD_LANCE                0x2000
 #define PCI_DEVICE_ID_AMD_LANCE_HOME   0x2001=
