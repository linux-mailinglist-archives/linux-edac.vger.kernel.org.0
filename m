Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6269883D
	for <lists+linux-edac@lfdr.de>; Thu, 22 Aug 2019 02:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731150AbfHVAAY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 21 Aug 2019 20:00:24 -0400
Received: from mail-eopbgr770075.outbound.protection.outlook.com ([40.107.77.75]:25798
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730943AbfHVAAX (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 21 Aug 2019 20:00:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETkW6SQsGpIAKbTo2/mKccD6yZ7ckscNtI/7NpQ4ugyeqT+8v2G9+q0V33fPolY51UEsIi9YLmJ06alDYJ6+OOoevDfXtOcjYIoitrfSGL3GLB76/QHF+DvkkxQW/6mvnzlh8fPJVoSEAUq0Pa9OUI+8v0PfVIpVXR7Uzc4zZEOZ4S+ycLIPr7axR1dgFuVxvMhjVvdamxs5UrYvisgRxgecCMMExbvVRBdgDtLJYjqybic1goYWP1gXsNdMGwTd+kWqo39aHPus/NN5AzKni5TrGKsmEF5WQSVmvid+iLC3z6chBpJnMoNJRFpKjSGjJFF2aMJGYBvWpxZv3FZ4Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6hgGypV05PVcoTSXAfbcpMiztq8+9G41qu1XaPNRwo=;
 b=T2wThBDP9vgOnkSVY/SFLDabz5/pvcD0mRdpXWQc0KFf9/maeAE4zzcBy46n/6lL9Br1AFu8ijAq4R3VMWl+Af7FrVAGKu1GPDk3LWxYoc3fRBinpcyLv6w+VsVnYwwiZjUI6EYefkQPcCDXraGJ9+yLtfD57GL4gGqzsp1gzzEj+VUgW/kxMuAkkvML2EmcSgDPRL4je/f7GgHY2BS144Q82A4KLwWYXeKe2Bw03XM36hqFEqV4t26EDqIF4vHrRoOAknQ73VvVixGR4eN0skfARME+ZHp40RCYIGmevEukpOV4J2cNtmhWIIO/m/gGHy/sN9/iDsreTaVJaWWM1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6hgGypV05PVcoTSXAfbcpMiztq8+9G41qu1XaPNRwo=;
 b=m8Tlak2zRD0hG9SPXCFBdJW2EzWY2eTa7vBhrhpHhk+VXSBBc3fy9n5c6lTJV6kwFun8+ci6w+Ssaf9uwVKrrsJuLSRWc84kUjt+d7V89MdzPXfG5zxnaEAkSaGM6yAPLQ/7PpOe9aT11llfBq78E5bj5UF4tKip0DqJ6TV32Zc=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2815.namprd12.prod.outlook.com (52.135.107.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Thu, 22 Aug 2019 00:00:02 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d0b4:a849:c22b:3b53]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d0b4:a849:c22b:3b53%2]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 00:00:02 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH v3 7/8] EDAC/amd64: Support Asymmetric Dual-Rank DIMMs
Thread-Topic: [PATCH v3 7/8] EDAC/amd64: Support Asymmetric Dual-Rank DIMMs
Thread-Index: AQHVWHyLNIgg0pPI/0SnSpoL9D1KYw==
Date:   Thu, 22 Aug 2019 00:00:02 +0000
Message-ID: <20190821235938.118710-8-Yazen.Ghannam@amd.com>
References: <20190821235938.118710-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20190821235938.118710-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN2PR01CA0006.prod.exchangelabs.com (2603:10b6:804:2::16)
 To SN6PR12MB2639.namprd12.prod.outlook.com (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06fd4dee-ec3a-409e-8d67-08d72693ae20
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2815;
x-ms-traffictypediagnostic: SN6PR12MB2815:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB2815C3853AB8882145B7EDFBF8A50@SN6PR12MB2815.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(189003)(199004)(6486002)(8936002)(6436002)(81156014)(99286004)(50226002)(8676002)(26005)(81166006)(52116002)(2906002)(6916009)(53936002)(5640700003)(476003)(54906003)(66946007)(25786009)(66476007)(386003)(64756008)(66446008)(66556008)(186003)(2351001)(446003)(11346002)(316002)(6506007)(6512007)(6306002)(2616005)(486006)(102836004)(36756003)(478600001)(71190400001)(256004)(86362001)(2501003)(1076003)(4326008)(5660300002)(7736002)(305945005)(6116002)(3846002)(966005)(71200400001)(76176011)(66066001)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2815;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nHFXVk4kJvvjSy37cpBX6hOPBGkQlUMz3SigEtWbWbhYqt+RPIlLd9oSg1BVpBhtfksrh13FhMIYezEb1tQ57jdY9+LyA9uf3GeHM2hia2x7X3vhuOTkdB4BfYJd/ryxcqxH3MPlJ/oppvy21S8YtjaZYS3YoNJeRFXdSnEP+G/usocWZejJFHqQuYvNnlPxfTCfRKmwFyUNzkKfu7qY6BiXqlMHnO95Q5h0kB3rKhH+FNLPMMJPpTcPlKwlFW2O0Q82M6PdAnNhOdcmAliKJ+UJCt8QOtjWx3ImdsR/Q2wW+umD+fdAolLj7Jn4TMdTVm5Six3iZt9tfAmpxnoemwzslCqXX8r06rJgUWaTGsQu7JBHFXmHZ/awmj1CMpndUEE8WYDwKWKtRfctN5mFoRt8bWIyXz69ZSrV6ehx7JE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06fd4dee-ec3a-409e-8d67-08d72693ae20
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 00:00:02.1940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K/QnXHQjfWtJqbrvjg0UWNBeBM3pYkvTIazEDPPVC1BEfTwUj1FRu2sZWacWwfnt9nJL3vj4RvtGfB4TAy3WOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2815
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Future AMD systems will support "Asymmetric" Dual-Rank DIMMs. These are
DIMMs where the ranks are of different sizes.

The even rank will use the Primary Even Chip Select registers and the
odd rank will use the Secondary Odd Chip Select registers.

Recognize if a Secondary Odd Chip Select is being used. Use the
Secondary Odd Address Mask when calculating the chip select size.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20190709215643.171078-8-Yazen.Ghannam@amd.com

v2->v3:
* Add check of csrow_nr before using secondary mask.

v1->v2:
* No change.

 drivers/edac/amd64_edac.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 26ce48fcaf00..4d1e6daa7ec4 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -790,9 +790,13 @@ static void debug_dump_dramcfg_low(struct amd64_pvt *p=
vt, u32 dclr, int chan)
=20
 #define CS_EVEN_PRIMARY		BIT(0)
 #define CS_ODD_PRIMARY		BIT(1)
+#define CS_EVEN_SECONDARY	BIT(2)
+#define CS_ODD_SECONDARY	BIT(3)
=20
-#define CS_EVEN			CS_EVEN_PRIMARY
-#define CS_ODD			CS_ODD_PRIMARY
+#define CS_EVEN			(CS_EVEN_PRIMARY | CS_EVEN_SECONDARY)
+#define CS_ODD			(CS_ODD_PRIMARY | CS_EVEN_SECONDARY)
+
+#define csrow_sec_enabled(i, dct, pvt)	((pvt)->csels[(dct)].csbases_sec[(i=
)] & DCSB_CS_ENABLE)
=20
 static int f17_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
 {
@@ -804,6 +808,10 @@ static int f17_get_cs_mode(int dimm, u8 ctrl, struct a=
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
@@ -1600,7 +1608,11 @@ static int f17_addr_mask_to_cs_size(struct amd64_pvt=
 *pvt, u8 umc,
 	 */
 	dimm =3D csrow_nr >> 1;
=20
-	addr_mask_orig =3D pvt->csels[umc].csmasks[dimm];
+	/* Asymmetric Dual-Rank DIMM support. */
+	if ((csrow_nr & 1) && (cs_mode & CS_ODD_SECONDARY))
+		addr_mask_orig =3D pvt->csels[umc].csmasks_sec[dimm];
+	else
+		addr_mask_orig =3D pvt->csels[umc].csmasks[dimm];
=20
 	/*
 	 * The number of zero bits in the mask is equal to the number of bits
--=20
2.17.1

