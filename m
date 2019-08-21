Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BED7698835
	for <lists+linux-edac@lfdr.de>; Thu, 22 Aug 2019 02:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730985AbfHVAAE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 21 Aug 2019 20:00:04 -0400
Received: from mail-eopbgr770075.outbound.protection.outlook.com ([40.107.77.75]:25798
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731006AbfHVAAD (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 21 Aug 2019 20:00:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ASUyPiiRmf/SieC1ZZVaRNUhD4pSm3v9XYGFS46r14WA9M2zLz8KfxYbbtUcgZTJ06iPqeEv+8hijr78r98w9FSGzW8A5jOgGt1NqiwcJcqRgdBnWjmKld4gk+sqDj3ilQfIarEa/lbrlLCh1+YZIzu26tL7usUIEwoHPL06+tUxR/Nrk9Yw/fWaFM/+Qn6vUVAHlNRiXACjFUeygjylPE7gKBN8m4C7sXjPBKsIU32frNnb05vi5kIoQvkMM8J9XIwIzgo7JrseepTVCyowUw92d8aNKD5eKRQHExe3darAyniAXG5NR52Q1Uw4lvA5G04DZG5rhisJlQlb6FUcbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFsL8ckfua3jR2+6zgFUmboWYwxYvZqaXikKs6x6wdo=;
 b=CybE225YV0EDA0q3Sq9tDrumQscQFvC391K1DmiXYLWBeL2OHl1RgDx1C0ZpL6fnfsQ07gc1U5F1Uojqo2fxBJr62zQiCREp6FlUyaAwFJLUoiwKrfrNLVMcEPI3IA69FQuvKenzY5iSvt/MNpPthDVIXtxJI2mmEx8C2vjzH+WH1gV/xcSnjysbuqwmQnvLkr+zpbiWxdPT+pcv4IOwz04eSRGbQxGazvp9n8LBwTYeIvyQOKMtBLc+g0jR9nXLlO6+8PUWr5o4kZz/Mxa2s1m9qCw4hClP5128JJQ5Q2cZVZuHzkgwOQBj8SFSRJE58SYDXNmXKW58gkKSrZg96w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFsL8ckfua3jR2+6zgFUmboWYwxYvZqaXikKs6x6wdo=;
 b=o4Fx9SjdOzaxCPDir4UkLQIgngfR87W0ybWYfcEI5ZUZ1iblYqncXHIjsaB5zP+Uxr2e7lWmFEsYoTvdE6mMUnoMkNPg09Z08prghNa2E6DBhkaq5kdTZZ8AqJqpipb6M5kB3Ov2byITEZWCTgLRxOBG+g2Y+7bUlt6VeC5n3Ek=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2815.namprd12.prod.outlook.com (52.135.107.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Thu, 22 Aug 2019 00:00:00 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d0b4:a849:c22b:3b53]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d0b4:a849:c22b:3b53%2]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 00:00:00 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH v3 4/8] EDAC/amd64: Find Chip Select memory size using Address
 Mask
Thread-Topic: [PATCH v3 4/8] EDAC/amd64: Find Chip Select memory size using
 Address Mask
Thread-Index: AQHVWHyKwuWo/C0dq0iYuy0UUHtZrQ==
Date:   Wed, 21 Aug 2019 23:59:59 +0000
Message-ID: <20190821235938.118710-5-Yazen.Ghannam@amd.com>
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
x-ms-office365-filtering-correlation-id: 8426f62d-2b62-4ce1-b73a-08d72693abbc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2815;
x-ms-traffictypediagnostic: SN6PR12MB2815:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB28153AE666DA179B8D2D823BF8A50@SN6PR12MB2815.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(189003)(199004)(6486002)(8936002)(6436002)(81156014)(99286004)(50226002)(8676002)(26005)(81166006)(52116002)(2906002)(6916009)(53936002)(5640700003)(476003)(54906003)(66946007)(25786009)(66476007)(386003)(64756008)(66446008)(66556008)(186003)(2351001)(446003)(11346002)(316002)(6506007)(6512007)(6306002)(2616005)(486006)(102836004)(14444005)(36756003)(478600001)(71190400001)(256004)(86362001)(2501003)(1076003)(4326008)(5660300002)(7736002)(305945005)(6116002)(3846002)(966005)(71200400001)(76176011)(66066001)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2815;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kTg1edmx/8DboUxXfEhZFTJ4a2PTNMdYGpMcPbIHBNeSaQzozoJZukUQccyTg+9ju9gwz6ZUsfPbKWN7+tHBlOHhikjAUm5YUmYSdlZ/3pImtOzB4O3a/4OlyWoqiy+6G+1DmpruQQX6VFctKBhg76PMbbx9R0rYpdLByo/tegMJSgtJTCtwej1EuohM1IavhMAw3wX4JXttwu/3b8p/Likz8j95hHZGBcGkrbMr3A7AgERP/FXuCaEzpJCoTM/6hkoZwW4Su0MVwUi34CbtbJiJAcJF3hoeT2+JsZmsl3gT4UyPV6XFJrFvId2+smn7SQiJs/fR1FGxG92uJOf2kByNcwcZEe7QWJC9J5e59/xIX+58SqwnP3Bfzy8gB95UzVz++e5rXuDi4/pk4wDVOlbHTs1LtVfbYnglVHPi164=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8426f62d-2b62-4ce1-b73a-08d72693abbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 23:59:59.6884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FNJWp82Bl6+6JEOPJFARvOca9YQ5GwaGjf15OCDg7LyJfiSxu6oskv3xmFh084PV8q10JqDDOo0R6lxg8kbO3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2815
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Chip Select memory size reporting on AMD Family 17h was recently fixed
in order to account for interleaving. However, the current method is not
robust.

The Chip Select Address Mask can be used to find the memory size. There
are a couple of cases.

1) For single-rank and dual-rank non-interleaved, use the address mask
plus 1 as the size.

2) For dual-rank interleaved, do #1 but "de-interleave" the address mask
first.

Always "de-interleave" the address mask in order to simplify the code
flow. Bit mask manipulation is necessary to check for interleaving, so
just go ahead and do the de-interleaving. In the non-interleaved case,
the original and de-interleaved address masks will be the same.

To de-interleave the mask, count the number of zero bits in the middle
of the mask and swap them with the most significant bits.

For example,
Original=3D0xFFFF9FE, De-interleaved=3D0x3FFFFFE

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20190709215643.171078-5-Yazen.Ghannam@amd.com

v2->v3:
* Drop Fixes: tag.
* Add checks to only return CS size for enabled CSes.

v1->v2:
* No change.

 drivers/edac/amd64_edac.c | 114 +++++++++++++++++++++++---------------
 1 file changed, 70 insertions(+), 44 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 001dc85122e9..c4f2d7c59b04 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -788,51 +788,39 @@ static void debug_dump_dramcfg_low(struct amd64_pvt *=
pvt, u32 dclr, int chan)
 		 (dclr & BIT(15)) ?  "yes" : "no");
 }
=20
-/*
- * The Address Mask should be a contiguous set of bits in the non-interlea=
ved
- * case. So to check for CS interleaving, find the most- and least-signifi=
cant
- * bits of the mask, generate a contiguous bitmask, and compare the two.
- */
-static bool f17_cs_interleaved(struct amd64_pvt *pvt, u8 ctrl, int cs)
+#define CS_EVEN_PRIMARY		BIT(0)
+#define CS_ODD_PRIMARY		BIT(1)
+
+#define CS_EVEN			CS_EVEN_PRIMARY
+#define CS_ODD			CS_ODD_PRIMARY
+
+static int f17_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
 {
-	u32 mask =3D pvt->csels[ctrl].csmasks[cs >> 1];
-	u32 msb =3D fls(mask) - 1, lsb =3D ffs(mask) - 1;
-	u32 test_mask =3D GENMASK(msb, lsb);
+	int cs_mode =3D 0;
=20
-	edac_dbg(1, "mask=3D0x%08x test_mask=3D0x%08x\n", mask, test_mask);
+	if (csrow_enabled(2 * dimm, ctrl, pvt))
+		cs_mode |=3D CS_EVEN_PRIMARY;
=20
-	return mask ^ test_mask;
+	if (csrow_enabled(2 * dimm + 1, ctrl, pvt))
+		cs_mode |=3D CS_ODD_PRIMARY;
+
+	return cs_mode;
 }
=20
 static void debug_display_dimm_sizes_df(struct amd64_pvt *pvt, u8 ctrl)
 {
-	int dimm, size0, size1, cs0, cs1;
+	int dimm, size0, size1, cs0, cs1, cs_mode;
=20
 	edac_printk(KERN_DEBUG, EDAC_MC, "UMC%d chip selects:\n", ctrl);
=20
 	for (dimm =3D 0; dimm < 2; dimm++) {
-		size0 =3D 0;
 		cs0 =3D dimm * 2;
-
-		if (csrow_enabled(cs0, ctrl, pvt))
-			size0 =3D pvt->ops->dbam_to_cs(pvt, ctrl, 0, cs0);
-
-		size1 =3D 0;
 		cs1 =3D dimm * 2 + 1;
=20
-		if (csrow_enabled(cs1, ctrl, pvt)) {
-			/*
-			 * CS interleaving is only supported if both CSes have
-			 * the same amount of memory. Because they are
-			 * interleaved, it will look like both CSes have the
-			 * full amount of memory. Save the size for both as
-			 * half the amount we found on CS0, if interleaved.
-			 */
-			if (f17_cs_interleaved(pvt, ctrl, cs1))
-				size1 =3D size0 =3D (size0 >> 1);
-			else
-				size1 =3D pvt->ops->dbam_to_cs(pvt, ctrl, 0, cs1);
-		}
+		cs_mode =3D f17_get_cs_mode(dimm, ctrl, pvt);
+
+		size0 =3D pvt->ops->dbam_to_cs(pvt, ctrl, cs_mode, cs0);
+		size1 =3D pvt->ops->dbam_to_cs(pvt, ctrl, cs_mode, cs1);
=20
 		amd64_info(EDAC_MC ": %d: %5dMB %d: %5dMB\n",
 				cs0,	size0,
@@ -1569,18 +1557,54 @@ static int f16_dbam_to_chip_select(struct amd64_pvt=
 *pvt, u8 dct,
 		return ddr3_cs_size(cs_mode, false);
 }
=20
-static int f17_base_addr_to_cs_size(struct amd64_pvt *pvt, u8 umc,
+static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
 				    unsigned int cs_mode, int csrow_nr)
 {
-	u32 base_addr =3D pvt->csels[umc].csbases[csrow_nr];
+	u32 addr_mask_orig, addr_mask_deinterleaved;
+	u32 msb, weight, num_zero_bits;
+	int dimm, size =3D 0;
=20
-	/*  Each mask is used for every two base addresses. */
-	u32 addr_mask =3D pvt->csels[umc].csmasks[csrow_nr >> 1];
+	/* No Chip Selects are enabled. */
+	if (!cs_mode)
+		return size;
=20
-	/*  Register [31:1] =3D Address [39:9]. Size is in kBs here. */
-	u32 size =3D ((addr_mask >> 1) - (base_addr >> 1) + 1) >> 1;
+	/* Requested size of an even CS but none are enabled. */
+	if (!(cs_mode & CS_EVEN) && !(csrow_nr & 1))
+		return size;
=20
-	edac_dbg(1, "BaseAddr: 0x%x, AddrMask: 0x%x\n", base_addr, addr_mask);
+	/* Requested size of an odd CS but none are enabled. */
+	if (!(cs_mode & CS_ODD) && (csrow_nr & 1))
+		return size;
+
+	/*
+	 * There is one mask per DIMM, and two Chip Selects per DIMM.
+	 *	CS0 and CS1 -> DIMM0
+	 *	CS2 and CS3 -> DIMM1
+	 */
+	dimm =3D csrow_nr >> 1;
+
+	addr_mask_orig =3D pvt->csels[umc].csmasks[dimm];
+
+	/*
+	 * The number of zero bits in the mask is equal to the number of bits
+	 * in a full mask minus the number of bits in the current mask.
+	 *
+	 * The MSB is the number of bits in the full mask because BIT[0] is
+	 * always 0.
+	 */
+	msb =3D fls(addr_mask_orig) - 1;
+	weight =3D hweight_long(addr_mask_orig);
+	num_zero_bits =3D msb - weight;
+
+	/* Take the number of zero bits off from the top of the mask. */
+	addr_mask_deinterleaved =3D GENMASK_ULL(msb - num_zero_bits, 1);
+
+	edac_dbg(1, "CS%d DIMM%d AddrMasks:\n", csrow_nr, dimm);
+	edac_dbg(1, "  Original AddrMask: 0x%x\n", addr_mask_orig);
+	edac_dbg(1, "  Deinterleaved AddrMask: 0x%x\n", addr_mask_deinterleaved);
+
+	/* Register [31:1] =3D Address [39:9]. Size is in kBs here. */
+	size =3D (addr_mask_deinterleaved >> 2) + 1;
=20
 	/* Return size in MBs. */
 	return size >> 10;
@@ -2245,7 +2269,7 @@ static struct amd64_family_type family_types[] =3D {
 		.f6_id =3D PCI_DEVICE_ID_AMD_17H_DF_F6,
 		.ops =3D {
 			.early_channel_count	=3D f17_early_channel_count,
-			.dbam_to_cs		=3D f17_base_addr_to_cs_size,
+			.dbam_to_cs		=3D f17_addr_mask_to_cs_size,
 		}
 	},
 	[F17_M10H_CPUS] =3D {
@@ -2254,7 +2278,7 @@ static struct amd64_family_type family_types[] =3D {
 		.f6_id =3D PCI_DEVICE_ID_AMD_17H_M10H_DF_F6,
 		.ops =3D {
 			.early_channel_count	=3D f17_early_channel_count,
-			.dbam_to_cs		=3D f17_base_addr_to_cs_size,
+			.dbam_to_cs		=3D f17_addr_mask_to_cs_size,
 		}
 	},
 	[F17_M30H_CPUS] =3D {
@@ -2263,7 +2287,7 @@ static struct amd64_family_type family_types[] =3D {
 		.f6_id =3D PCI_DEVICE_ID_AMD_17H_M30H_DF_F6,
 		.ops =3D {
 			.early_channel_count	=3D f17_early_channel_count,
-			.dbam_to_cs		=3D f17_base_addr_to_cs_size,
+			.dbam_to_cs		=3D f17_addr_mask_to_cs_size,
 		}
 	},
 };
@@ -2822,10 +2846,12 @@ static u32 get_csrow_nr_pages(struct amd64_pvt *pvt=
, u8 dct, int csrow_nr_orig)
 	int csrow_nr =3D csrow_nr_orig;
 	u32 cs_mode, nr_pages;
=20
-	if (!pvt->umc)
+	if (!pvt->umc) {
 		csrow_nr >>=3D 1;
-
-	cs_mode =3D DBAM_DIMM(csrow_nr, dbam);
+		cs_mode =3D DBAM_DIMM(csrow_nr, dbam);
+	} else {
+		cs_mode =3D f17_get_cs_mode(csrow_nr >> 1, dct, pvt);
+	}
=20
 	nr_pages   =3D pvt->ops->dbam_to_cs(pvt, dct, cs_mode, csrow_nr);
 	nr_pages <<=3D 20 - PAGE_SHIFT;
--=20
2.17.1

