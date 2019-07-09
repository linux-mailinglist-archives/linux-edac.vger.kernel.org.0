Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 570FD63DA1
	for <lists+linux-edac@lfdr.de>; Tue,  9 Jul 2019 23:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbfGIV5N (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Jul 2019 17:57:13 -0400
Received: from mail-eopbgr690059.outbound.protection.outlook.com ([40.107.69.59]:63872
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729786AbfGIV5C (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 9 Jul 2019 17:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mckTv+s/JRdf5bao4dcLRovMz1xHK4RThrrFPOl6nyk=;
 b=n0t0UVLmwUqfES969ujA5JLNHv1EUjPGwMdQju2b9lFpmRmaaTSK6gKvqImA5AQc6ZZWXJh0eU1ngWHgKY13j1psRhr6z/1Z3mTVPoiG+wHKDVcSeDiTgICNi23bZLpS6hRhiI3c2NrpPLCEliH4pXSpsaBRDrMtMrw+m8eJUFE=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2718.namprd12.prod.outlook.com (52.135.103.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Tue, 9 Jul 2019 21:56:58 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::fd06:e03b:2b06:e8d7]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::fd06:e03b:2b06:e8d7%6]) with mapi id 15.20.2052.020; Tue, 9 Jul 2019
 21:56:58 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH v2 7/7] EDAC/amd64: Support Asymmetric Dual-Rank DIMMs
Thread-Topic: [PATCH v2 7/7] EDAC/amd64: Support Asymmetric Dual-Rank DIMMs
Thread-Index: AQHVNqE6J4H7oRniNEKmFoXEUgkvBA==
Date:   Tue, 9 Jul 2019 21:56:58 +0000
Message-ID: <20190709215643.171078-8-Yazen.Ghannam@amd.com>
References: <20190709215643.171078-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20190709215643.171078-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0401CA0034.namprd04.prod.outlook.com
 (2603:10b6:803:2a::20) To SN6PR12MB2639.namprd12.prod.outlook.com
 (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 834f5b18-c139-4e0a-c40e-08d704b85d37
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2718;
x-ms-traffictypediagnostic: SN6PR12MB2718:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR12MB271817D3C285DC4015B8F76DF8F10@SN6PR12MB2718.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(199004)(189003)(6506007)(53936002)(386003)(76176011)(26005)(2351001)(186003)(2501003)(14444005)(256004)(6116002)(99286004)(52116002)(102836004)(6306002)(2906002)(6512007)(68736007)(1076003)(6916009)(305945005)(5660300002)(66066001)(3846002)(6436002)(50226002)(66446008)(66556008)(66476007)(66946007)(64756008)(71200400001)(36756003)(71190400001)(2616005)(8676002)(81166006)(966005)(25786009)(316002)(81156014)(446003)(4326008)(54906003)(11346002)(8936002)(14454004)(486006)(478600001)(86362001)(5640700003)(7736002)(6486002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2718;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mH5lwuyTeUlDQRg3KHHjdO/BfXo0sTAs0J4jjCSU+yEj3DoEcw+9pb+qCL0DEHIRfUlGAZ0vpGy/7zDQSpFYG/IzSP09s4oqPx/MtoJwJJ/HsBNlpRNimCO777ALkJIQ1GH6ZTbFCC6gMH8151DDHC+8v+XX3HN0gXXVXZ5UMYW+ovfutV5a3jMnI/oemoJUN0YATUsgGZNe44TmzGY3Oid0t/1TnuVXJAs+76Kehtu4NWCQiSdrdk0AIbCS8MwqDwaDWKY3da47C/H+OZeIDACszl1BznXNMOoLxgtzDoYeyjmD4SfIp3uJ6hYBhqbWn6+g0FOfFxU5VAx/e7UDJ0viKkGkj026BWth/eM9UxO2HwFf84I+drnCH8zi/yLgajC73i+8zqnFZyYFP34WtTXu3qMfL8fgN9ChnGp90Q8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 834f5b18-c139-4e0a-c40e-08d704b85d37
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 21:56:58.2552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yghannam@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2718
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Future AMD systems will support "Asymmetric" Dual-Rank DIMMs. These are
DIMMs were the ranks are of different sizes.

The even rank will use the Primary Even Chip Select registers and the
odd rank will use the Secondary Odd Chip Select registers.

Recognize if a Secondary Odd Chip Select is being used. Use the
Secondary Odd Address Mask when calculating the chip select size.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20190531234501.32826-9-Yazen.Ghannam@amd.com

v1->v2:
* No change.

 drivers/edac/amd64_edac.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 006417cb79dc..6c284a4f980c 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -790,6 +790,9 @@ static void debug_dump_dramcfg_low(struct amd64_pvt *pv=
t, u32 dclr, int chan)
=20
 #define CS_EVEN_PRIMARY		BIT(0)
 #define CS_ODD_PRIMARY		BIT(1)
+#define CS_ODD_SECONDARY	BIT(2)
+
+#define csrow_sec_enabled(i, dct, pvt)	((pvt)->csels[(dct)].csbases_sec[(i=
)] & DCSB_CS_ENABLE)
=20
 static int f17_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
 {
@@ -801,6 +804,10 @@ static int f17_get_cs_mode(int dimm, u8 ctrl, struct a=
md64_pvt *pvt)
 	if (csrow_enabled(2 * dimm + 1, ctrl, pvt))
 		cs_mode |=3D CS_ODD_PRIMARY;
=20
+	/* Asymmetric Dual-Rank DIMM support. */
+	if (csrow_sec_enabled(2 * dimm + 1, ctrl, pvt))
+		cs_mode |=3D CS_ODD_SECONDARY;
+
 	return cs_mode;
 }
=20
@@ -1590,7 +1597,11 @@ static int f17_addr_mask_to_cs_size(struct amd64_pvt=
 *pvt, u8 umc,
 	 */
 	dimm =3D csrow_nr >> 1;
=20
-	addr_mask_orig =3D pvt->csels[umc].csmasks[dimm];
+	/* Asymmetric Dual-Rank DIMM support. */
+	if (cs_mode & CS_ODD_SECONDARY)
+		addr_mask_orig =3D pvt->csels[umc].csmasks_sec[dimm];
+	else
+		addr_mask_orig =3D pvt->csels[umc].csmasks[dimm];
=20
 	/*
 	 * The number of zero bits in the mask is equal to the number of bits
--=20
2.17.1

