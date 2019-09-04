Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 342F5A94BB
	for <lists+linux-edac@lfdr.de>; Wed,  4 Sep 2019 23:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbfIDVNu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 4 Sep 2019 17:13:50 -0400
Received: from mail-eopbgr760075.outbound.protection.outlook.com ([40.107.76.75]:41830
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727387AbfIDVNu (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 4 Sep 2019 17:13:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIcycpTcSdoBeev/ApOFhbc4c1CwD7D9yp1wPPux+k6q1PpSiQLhSAAJKT0jSzXSBA97FYZDSSRuQZreFKtImeJPKJ6AGEySqiYya5Y8hdWoRlQbPnSI1hzenvjFepD+UySnUhAI7NkawwPYcJ9OjDBPrTPCNoJIWfcBJ0z/rLtHGfSk4TbgTyPIfOe/HrB32prv3mL93xv6q2qIXUYbKNG8RaYkcJNt7FfomYS17u9ASUPZvti5WXaPFCGaADLH628P9+SCzsjEDkWipq1xA5MlpNXXCOwz373htOzTbnJKxkcsEWrvgkSv1n9IbaMzRNeEJlWn0BSakkLujMNrKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVxddbkfgZBNaBfYlQYG95WXYjFLo543kD3UsSZ9Vo0=;
 b=A66jrMuH1NkVDCsj4tc60ctG6bRP1NNt64rXutHr8cRwrUjfQFvnUfHV6q4FC64ECvm9dqa7Lh1AD4NyqRgMcTpRUvwgP+qtEKih/UO4KU2a3SVVt89l51uzZsIHi4jOkdfjQ2s58Ge3kbRYdu9ojBn3XEf8YDIdFPtdw+vV5sOBS26hlgKhuexNTp3ir+5nQ/ZHfYeKHWH/Kmx87IdwTEgay5f1DFRBxQDL6iA5FPYtpgFpzpsCIDwzgJPgXeou0HAteLY4Av03FjROaXfLMGfLHVT7WV9bF3YhKbLjG0QH0AsNe/zlxUTmdJMB8/JuCd1ndeqFgDXasbWY4WDZCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=knights.ucf.edu; dmarc=pass action=none
 header.from=knights.ucf.edu; dkim=pass header.d=knights.ucf.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=knightsucfedu39751.onmicrosoft.com;
 s=selector2-knightsucfedu39751-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVxddbkfgZBNaBfYlQYG95WXYjFLo543kD3UsSZ9Vo0=;
 b=S+iyTeapOdFkbowhvBBuWBK/gQGIEuEre7Ozu4oIPujbh4fC7BPvZghGaPUYKgYKdJo7KDcUUnk/8fA86LyxPAQcUoNQXP08Km+xTpplGMVxr2UpG7xj8KJOorhTMGEB5hD8zUvACycabZWnE6mmlTLRLOjj3ZYZl+24+CPbYI8=
Received: from BN7PR07MB5186.namprd07.prod.outlook.com (20.176.176.155) by
 BN7PR07MB4884.namprd07.prod.outlook.com (52.135.248.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Wed, 4 Sep 2019 21:13:48 +0000
Received: from BN7PR07MB5186.namprd07.prod.outlook.com
 ([fe80::682e:801a:5227:668f]) by BN7PR07MB5186.namprd07.prod.outlook.com
 ([fe80::682e:801a:5227:668f%7]) with mapi id 15.20.2220.022; Wed, 4 Sep 2019
 21:13:48 +0000
From:   Isaac Vaughn <isaac.vaughn@Knights.ucf.edu>
To:     Borislav Petkov <bp@alien8.de>
CC:     "trivial@kernel.org" <trivial@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: [PATCH] amd64_edac - Add Family 17h Model 70h PCI IDs
Thread-Topic: [PATCH] amd64_edac - Add Family 17h Model 70h PCI IDs
Thread-Index: AQHVY2RbCb5+3YDIEkuYe/75JNXLCA==
Date:   Wed, 4 Sep 2019 21:13:47 +0000
Message-ID: <BN7PR07MB5186DD5732B95B784A9D46BFCEB80@BN7PR07MB5186.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=isaac.vaughn@Knights.ucf.edu; 
x-originating-ip: [132.170.57.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ae48605-cbbb-41d6-68eb-08d7317cc6ff
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN7PR07MB4884;
x-ms-traffictypediagnostic: BN7PR07MB4884:
x-microsoft-antispam-prvs: <BN7PR07MB48844CAFE4A0EB5A694C9BE4CEB80@BN7PR07MB4884.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0150F3F97D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(136003)(346002)(39860400002)(199004)(189003)(88552002)(7696005)(44832011)(5660300002)(476003)(2906002)(26005)(102836004)(486006)(33656002)(786003)(186003)(66946007)(8936002)(75432002)(4326008)(52536014)(6506007)(53936002)(316002)(256004)(3846002)(81166006)(6436002)(7736002)(305945005)(86362001)(6116002)(8676002)(55016002)(9686003)(74316002)(81156014)(66066001)(478600001)(54906003)(99286004)(76116006)(14454004)(413944005)(66556008)(66476007)(6916009)(66446008)(25786009)(71190400001)(71200400001)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4884;H:BN7PR07MB5186.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: Knights.ucf.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zdPCv4ds+kxxXQ6CtqBUlJKH7QtQinI0dsBApPMPwzqrJpGhzVOkz6lAFtnBYD1CUS5xcK6Mq5zyE+rSD4A39kmnboiHJ6JV1kZxu0i0hA1+J11JnWA0Yoa3HWlKmMNj3Q+40ZVRAp7jUY+YF8iy3JIhcBdZ8gxhepYqIdhazsiYXDit86GOqkcKMmtkoWNRonBGkRIHoaSYYMpN2FN5RMBvaEsj19NbbwjzFFIdg7S/SkpOwqFEg9j5E6fWMnw8oZ8f7j+Rx/pThFumi1cz1TACCqr3m/e8BjHeK9ElM8JPkreVVjC8KPtnVpmcqFmhGhYWzpOp5U2uC0TjbG9gmAxbKY/+bFngQebEEpHwO3RY5qiArgfyTTQEPyNxj3pd5E+w7QV3fKPJai4NJgq/ynASNw0YnFsH6GB4axI32ZE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: knights.ucf.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae48605-cbbb-41d6-68eb-08d7317cc6ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2019 21:13:47.9068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5b16e182-78b3-412c-9196-68342689eeb7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1JixBC8z5TcZPm3nFBaWh0vGLS7gvK69febL8OWRb7AYHicfkh+PAYbB7UPFW6ox8cBBW6UatEENtNsG7Nyrctsy7hPYUpT7bFdAEZaN8CA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4884
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Dear Mr. Petkov,

I noticed the current EDAC driver doesn't support the new Zen 2 (model 70h)=
 processors, so I patched the new device ids in. The changes are minimal, I=
 merely extended the existing enums with information from the new models.

This is my first kernel patch and I'm not sure I followed the guide (kernel=
.org/doc/html/v5.2/process/submitting-patches.html) correctly, so please le=
t me know if I need to resubmit this email with updated formatting prior to=
 review.

Sincerely,
Isaac Vaughn

Signed-off-by: Isaac Vaughn <isaac.vaughn@knights.ucf.edu>
---

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 873437be86d9..a35c97f9100a 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2253,6 +2253,15 @@ static struct amd64_family_type family_types[] =3D {
                        .dbam_to_cs             =3D f17_base_addr_to_cs_siz=
e,
                }
        },
+ [F17_M70H_CPUS] =3D {
+         .ctl_name =3D F17h_M70h,
+         .f0_id =3D PCI_DEVICE_ID_AMD_17H_M70H_DF_F0,
+         .f6_id =3D PCI_DEVICE_ID_AMD_17H_M70H_DF_F6,
+         .ops =3D {
+                 .early_channel_count        =3D f17_early_channel_count,
+                 .dbam_to_cs         =3D f17_base_addr_to_cs_size,
+         }
+ },
 };
=20
 /*
@@ -3241,6 +3250,10 @@ static struct amd64_family_type *per_family_init(str=
uct amd64_pvt *pvt)
                        fam_type =3D &family_types[F17_M30H_CPUS];
                        pvt->ops =3D &family_types[F17_M30H_CPUS].ops;
                        break;
+         } else if (pvt->model >=3D 0x70 && pvt->model <=3D 0x7f) {
+                 fam_type =3D &family_types[F17_M70H_CPUS];
+                 pvt->ops =3D &family_types[F17_M70H_CPUS].ops;
+                 break;
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
+ F17_M70H_CPUS,
        NUM_FAMILIES,
 };
=20
~
~
~
~
~=
