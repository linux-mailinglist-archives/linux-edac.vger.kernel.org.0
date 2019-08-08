Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77D8D86BE9
	for <lists+linux-edac@lfdr.de>; Thu,  8 Aug 2019 22:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390230AbfHHUwN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 8 Aug 2019 16:52:13 -0400
Received: from mail-eopbgr50103.outbound.protection.outlook.com ([40.107.5.103]:49433
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732786AbfHHUwM (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 8 Aug 2019 16:52:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnegIlsQOHkiibPYTJUiviHLFPVvnWitgI3LO0KDH39NpjPft50yyEU7XjcumNHtuzFZByyeCPA4cAiU5wuqRf4hXjdNZ2sRosnCyuoLDDOCgCref2M6Rh5iQqQZyX4JOTvWWHz1pO/igyOH/rNiFsOL3JaJ4BHbgwIyjI9/I+NTX8ZYqm90Uj63j4ZcA7uR6IK5hFA8Mop4ac+5bbg1rMDsLwj9RSpIQxUhIIbDDGXNfUJddfkgIon8lk+eunc5WoWqe7Te9lM/obgVlzgV/ActwoVjZ6I6Uo2MQjJJtw0qreLAi+uU7lIxpPGF8FHRSZHyh3XpUhMydP0/n+VxPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ag3FytFXrQCXhtqyWgy3ljKB9c6k7gZR3P+5VjugJyU=;
 b=HGlDBsIHNMxWJOjklCX4ndh0KOEjcZZcWt+8caq/we5c+3aSUXsjzwTY0iaYZCoXJpP7G+uBhX8FPFT2VgBa8y/emTveBoPD5U9NoOMlZ4wTJOvEF//gObpacSRIo5qdEnpiuTs3rT59o/pe3Vh/lmv1FsKqsC8PBHKBFzfQEd+FxdwmCNR3RbK4i8rzzdLqQhB/QeJ6MiNKrerz6MRTV81JDeOJ3RPVhGe3a2U2ARnm6GKoe/aUHezWWBWEheLEMQwc4GMpH1tDt6HQEBsF+1K3lp5QLJQ1PE1Yv98BAJsWzA8pgOKnOf5fkcRgnIJ4Tg1LJy4CePu/G7mkBfSEuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom-usa.com; dmarc=pass action=none
 header.from=silicom-usa.com; dkim=pass header.d=silicom-usa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ag3FytFXrQCXhtqyWgy3ljKB9c6k7gZR3P+5VjugJyU=;
 b=HHXCHmVIuzzINROtiFAd1S1N7w2SpVxGIKPLjiFb0il02/pu/aeZ72Ejmpq+aFeP4Scc+ZtwIiYveJ4bUQOWG9W9kRzrA4O7AbtCooHkVZc+CTiuM+IKXHJ0Sd9qQNhScKS+mS+cU4BFDAs5yV8HFu6lYPaofASEqVRaE9GUpTU=
Received: from VI1PR0402MB2717.eurprd04.prod.outlook.com (10.175.22.139) by
 VI1PR0402MB2910.eurprd04.prod.outlook.com (10.175.23.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Thu, 8 Aug 2019 20:52:09 +0000
Received: from VI1PR0402MB2717.eurprd04.prod.outlook.com
 ([fe80::eca9:e1f:eca7:8439]) by VI1PR0402MB2717.eurprd04.prod.outlook.com
 ([fe80::eca9:e1f:eca7:8439%9]) with mapi id 15.20.2157.015; Thu, 8 Aug 2019
 20:52:09 +0000
From:   Stephen Douthit <stephend@silicom-usa.com>
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>
CC:     Stephen Douthit <stephend@silicom-usa.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] EDAC, pnd2: Fix ioremap() size in dnv_rd_reg() from 64K ->
 32K
Thread-Topic: [PATCH] EDAC, pnd2: Fix ioremap() size in dnv_rd_reg() from 64K
 -> 32K
Thread-Index: AQHVTiskHjYyDh8ZF0eccCUFKX9IfQ==
Date:   Thu, 8 Aug 2019 20:52:08 +0000
Message-ID: <20190808205147.25547-1-stephend@silicom-usa.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR22CA0041.namprd22.prod.outlook.com
 (2603:10b6:404:37::27) To VI1PR0402MB2717.eurprd04.prod.outlook.com
 (2603:10a6:800:b4::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stephend@silicom-usa.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.21.0
x-originating-ip: [96.82.2.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f9bc469-1a39-4154-a4f7-08d71c424744
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0402MB2910;
x-ms-traffictypediagnostic: VI1PR0402MB2910:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB2910B14AE9743C527631B2CF94D70@VI1PR0402MB2910.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-forefront-prvs: 012349AD1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(396003)(39850400004)(136003)(189003)(199004)(8936002)(66476007)(186003)(86362001)(2906002)(26005)(66066001)(54906003)(478600001)(6436002)(50226002)(316002)(52116002)(110136005)(4744005)(2616005)(99286004)(1076003)(102836004)(476003)(486006)(386003)(6506007)(6486002)(305945005)(64756008)(3846002)(81166006)(7736002)(14454004)(81156014)(66446008)(66556008)(25786009)(4326008)(66946007)(5660300002)(71200400001)(71190400001)(6512007)(6116002)(8676002)(36756003)(256004)(14444005)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0402MB2910;H:VI1PR0402MB2717.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: silicom-usa.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Vjq7+6tMlQTJZ/UUA0VLK/8K/0Mufo0uT0OXGHnrTKobuKJWg3SUgAbpPG0ZkmkyH4lqFAUDnKelnSNESL8DgzEniAlFeMwI0lu30bOoxfE/CPXtJLVJqPcahkaPbXt8rO2A777FEbhsXRj9MmCfOVayWKB8XE83f94u5a2YIh3i659Ou/6owRs5biTp9kL5HC3KtNWquyrmPFJ67cUb4trYdOgp4RqYr9FhdWL4stenmYA4TmAUKW8LbdaC3z1HIiL1R5UdeMSXj8W/exUTuB0BrwIQEpc2TYgwzL+hwBRZ4UXX74kNw6YrrY2lLmtQrhzarbBtxNxi95U8YbdIeslnYAtHYF0T92vD8C8wKx0N9vEW+lyP0if/VL2S8NyE1Z27rWmwsgTHTPcthV5gAZs7L8BsdcT+h74TiT5u5Zk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silicom-usa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9bc469-1a39-4154-a4f7-08d71c424744
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2019 20:52:09.0152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ie2srQZfxmyCf9tp+FjceuG8Bu70zNnt7sGDVirnpM0853iWQdeczNgFvaad7fbhylmdJaXmfKQu3pQJ6aRR+gddEYvCmm9IneqFgVZx7uo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2910
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

BIOS has marked the 32K MCHBAR window as reserved, so when dnv_rd_reg()
tries to ioremap() a 64KB region you get warnings like:

resource sanity check: requesting [mem 0xfed10000-0xfed1ffff], which spans =
more than reserved [mem 0xfed10000-0xfed17fff]
caller dnv_rd_reg+0xc8/0x240 [pnd2_edac] mapping multiple BARs

ioremap() the correct size on Denverton platforms to get rid of those
warnings.

Signed-off-by: Stephen Douthit <stephend@silicom-usa.com>
---
 drivers/edac/pnd2_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index 903a4f1fadcc..1d16f2ac776e 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -295,7 +295,7 @@ static int dnv_rd_reg(int port, int off, int op, void *=
data, size_t sz, char *na
 			addr +=3D (port << 16);
 		}
=20
-		base =3D ioremap((resource_size_t)addr, 0x10000);
+		base =3D ioremap((resource_size_t)addr, 0x8000);
 		if (!base)
 			return -ENODEV;
=20
--=20
2.21.0

