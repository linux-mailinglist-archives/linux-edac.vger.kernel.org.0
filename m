Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59C2787C75
	for <lists+linux-edac@lfdr.de>; Fri,  9 Aug 2019 16:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfHIOSG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 9 Aug 2019 10:18:06 -0400
Received: from mail-eopbgr70108.outbound.protection.outlook.com ([40.107.7.108]:57577
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726342AbfHIOSG (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 9 Aug 2019 10:18:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmU60R/nfyFdm6Go1YZz//r3hVSPs+kcCgRE5VbUj9QiTWfI10DtF08qLVQ3LXtqnuZj2MJUrFYfHbvgxJkvxWL2UVwHKVBdwZ3lUCtuE042LFzLx+kIrrHk94yhIV6NoG4/3ra3RHSJd4GXe9MK5kGT6V+pBsJE4wAClu0naJ8fjg7u7UUw/KqI//h7H8QzXy/d7Hq7H4auG4aGA5IlFU8xRNekwDSAk+nmAeXYRH9KOrUxAIrcdmDAI6HIp15+EwRkgGStlb0MuazvVNwmzpt2QdPM4ktpaJ0cm7Jth740clFWvwR0mwB0taEZmC20YXFZJSWvoBjXSY4gy5xw1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXoCPzRbQxbsytNpL3OhZfoVEDOMrThQSOQ2RkQUfcA=;
 b=RwS8GMKx4bG8vapcUpRj4DXC1UqFWnYmV1o5Sd4DBegeg4ibeVOwgBWyMajqPHbyIGxfO9Jvd9fBo6d5GbIuV91vQ/YddDH5MSkkkJNF74/dVN/OiIwUQvGm7fj2nKYjCkpFTSCtiFSJjjcpjQw6cNyRrzKKhfl12TNOn6SW+Z/w8XAFr9jWMTJNdb+iJ2gj7MS52C0y3/LH1oWUqYyIgAn7vY6NHrWiHjol/GOV6GFdHZuDIKuk7TQ8p3qZSridv3MT4vWfh1918PYgUSeDcY0BHxvzHZd9G+hhY0YXRysFMw2vIkcobSNTXahb/G4DF0XSE9+nX++oFtPq6Gr7LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom-usa.com; dmarc=pass action=none
 header.from=silicom-usa.com; dkim=pass header.d=silicom-usa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXoCPzRbQxbsytNpL3OhZfoVEDOMrThQSOQ2RkQUfcA=;
 b=dXuH0bbx8fr5Uj2118e5i0SbAf81SkhRxbWHy+7m2od7SkkBxzNIzrlm9SKMM2TsEQt5Ni76yBmK+XjaPukVRqy5X8qo6El/6yVrbw0DPhHp1llJ8lPaPDEPzLl3e3U+vqKdM6qPlbBt4wXnQxByaZ+UjE89DoCdsoX7tZjvA50=
Received: from VI1PR0402MB2717.eurprd04.prod.outlook.com (10.175.22.139) by
 VI1PR0402MB3774.eurprd04.prod.outlook.com (52.134.15.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.20; Fri, 9 Aug 2019 14:18:02 +0000
Received: from VI1PR0402MB2717.eurprd04.prod.outlook.com
 ([fe80::eca9:e1f:eca7:8439]) by VI1PR0402MB2717.eurprd04.prod.outlook.com
 ([fe80::eca9:e1f:eca7:8439%9]) with mapi id 15.20.2157.020; Fri, 9 Aug 2019
 14:18:02 +0000
From:   Stephen Douthit <stephend@silicom-usa.com>
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>
CC:     Stephen Douthit <stephend@silicom-usa.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] EDAC, pnd2: Fix ioremap() size in dnv_rd_reg()
Thread-Topic: [PATCH] EDAC, pnd2: Fix ioremap() size in dnv_rd_reg()
Thread-Index: AQHVTr1AyXwgab8zJESZbW4mAIpUAw==
Date:   Fri, 9 Aug 2019 14:18:02 +0000
Message-ID: <20190809141737.15580-1-stephend@silicom-usa.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR2001CA0027.namprd20.prod.outlook.com
 (2603:10b6:405:16::13) To VI1PR0402MB2717.eurprd04.prod.outlook.com
 (2603:10a6:800:b4::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stephend@silicom-usa.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.21.0
x-originating-ip: [96.82.2.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05df1eaa-ba6a-4ca9-3518-08d71cd4632e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0402MB3774;
x-ms-traffictypediagnostic: VI1PR0402MB3774:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB3774A486D226329E6452B69A94D60@VI1PR0402MB3774.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(396003)(136003)(39840400004)(189003)(199004)(50226002)(8936002)(486006)(2906002)(66066001)(6512007)(2616005)(476003)(316002)(3846002)(99286004)(6436002)(110136005)(54906003)(25786009)(6486002)(14454004)(53936002)(6116002)(256004)(478600001)(7736002)(86362001)(305945005)(81156014)(81166006)(8676002)(14444005)(102836004)(66446008)(5660300002)(4326008)(66946007)(66476007)(64756008)(36756003)(66556008)(6506007)(386003)(52116002)(26005)(71190400001)(71200400001)(186003)(1076003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0402MB3774;H:VI1PR0402MB2717.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: silicom-usa.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nfMnYUERkUg8EP7GvWNs7kDB86wLEipnLWa5Me52iOgodzM0iNYO7ILewRSN2gwNCeaIJMLzF0VBG3BjISCAXnw8PFcefwbGNcEJb0Pb0r0UktyAXb4vVTwWiN+BMxrn32rU1hpWH+G5lzYyxT6zqmqu/uqjUUza79jYRMQqTe8M3NTjos2bhfIWURf8KwhQ3La2IX9t957uLzDdKthXUHlhOooi/XcEN1Z5sP2F9vvtUy1mnkZDAjPmZZ/M56N2D+etYnbsi+kjNmEP5p0gBJpQ7SQEMCmFvp9R2zgH6Nt0aTUrbs/u99MmInNcB8jkKLQ63osrE+rxjJ1KXHlT53ZO8TA0HmJLYYecByvdmDbm0xysCa5u7YwsoHknrvc0QEKysOqs9JIMdgii9IYi01Y4tGfHoee66+xXyYHUzm4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silicom-usa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05df1eaa-ba6a-4ca9-3518-08d71cd4632e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 14:18:02.0960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xGPj2o197h/0xpFYOatlg1N2WOFxsOgIREdt/tGCKsqp9NYOVLsNbv2l1pjGFJSJw+eP5UdhnSzkc7+lx8M+RYCN3fa5P3cvTpFDlq0dYGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3774
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Depending on how BIOS has marked the reserved region containing the 32KB
MCHBAR you can get warnings like:

resource sanity check: requesting [mem 0xfed10000-0xfed1ffff], which spans =
more than reserved [mem 0xfed10000-0xfed17fff]
caller dnv_rd_reg+0xc8/0x240 [pnd2_edac] mapping multiple BARs

Not all of the mmio regions used in dnv_rd_reg() are the same size.  The
MCHBAR window is 32KB and the sideband ports are 64KB.  Pass the correct
size to ioremap() depending on which resource we're reading from.

Signed-off-by: Stephen Douthit <stephend@silicom-usa.com>
---
 drivers/edac/pnd2_edac.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index 903a4f1fadcc..0153c730750e 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -268,11 +268,14 @@ static u64 get_sideband_reg_base_addr(void)
 	}
 }
=20
+#define DNV_MCHBAR_SIZE  0x8000
+#define DNV_SB_PORT_SIZE 0x10000
 static int dnv_rd_reg(int port, int off, int op, void *data, size_t sz, ch=
ar *name)
 {
 	struct pci_dev *pdev;
 	char *base;
 	u64 addr;
+	unsigned long size;
=20
 	if (op =3D=3D 4) {
 		pdev =3D pci_get_device(PCI_VENDOR_ID_INTEL, 0x1980, NULL);
@@ -287,15 +290,17 @@ static int dnv_rd_reg(int port, int off, int op, void=
 *data, size_t sz, char *na
 			addr =3D get_mem_ctrl_hub_base_addr();
 			if (!addr)
 				return -ENODEV;
+			size =3D DNV_MCHBAR_SIZE;
 		} else {
 			/* MMIO via sideband register base address */
 			addr =3D get_sideband_reg_base_addr();
 			if (!addr)
 				return -ENODEV;
 			addr +=3D (port << 16);
+			size =3D DNV_SB_PORT_SIZE;
 		}
=20
-		base =3D ioremap((resource_size_t)addr, 0x10000);
+		base =3D ioremap((resource_size_t)addr, size);
 		if (!base)
 			return -ENODEV;
=20
--=20
2.21.0

