Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16C9E63D9A
	for <lists+linux-edac@lfdr.de>; Tue,  9 Jul 2019 23:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbfGIV5H (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Jul 2019 17:57:07 -0400
Received: from mail-eopbgr800070.outbound.protection.outlook.com ([40.107.80.70]:26896
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729746AbfGIV5F (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 9 Jul 2019 17:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIPPgT1aRFicv8j9/d2EFUQOOsRDjDyAwuwhmN/3kB8=;
 b=Wq1ahEImn74ym/yQ7tR1mDYsOZcBoceQwj7pY0/n38STACqa0DWkfXUbl5GVks02ishQ6rI31rOMBvDhTi/oZ/vLpakYUXttyCXMgwFhSoLkWAXs/xksIDprjYM/Wc9fQbGYRytq/93m+yRon/4mh3UgDYRFrYO6SG+ix0xUqkc=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2814.namprd12.prod.outlook.com (52.135.107.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Tue, 9 Jul 2019 21:56:56 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::fd06:e03b:2b06:e8d7]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::fd06:e03b:2b06:e8d7%6]) with mapi id 15.20.2052.020; Tue, 9 Jul 2019
 21:56:56 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH v2 4/7] EDAC/amd64: Find Chip Select memory size using Address
 Mask
Thread-Topic: [PATCH v2 4/7] EDAC/amd64: Find Chip Select memory size using
 Address Mask
Thread-Index: AQHVNqE5XWhkmPyJEEistxECM36LWw==
Date:   Tue, 9 Jul 2019 21:56:56 +0000
Message-ID: <20190709215643.171078-5-Yazen.Ghannam@amd.com>
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
x-ms-office365-filtering-correlation-id: 7b4aade0-cc9b-4dd0-7b92-08d704b85c38
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2814;
x-ms-traffictypediagnostic: SN6PR12MB2814:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR12MB2814619DFBE20A4EDA7D1043F8F10@SN6PR12MB2814.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(199004)(189003)(26005)(8936002)(4326008)(6486002)(54906003)(6916009)(6512007)(6436002)(5640700003)(6306002)(102836004)(1076003)(966005)(6506007)(52116002)(386003)(53936002)(14444005)(76176011)(6116002)(68736007)(81156014)(25786009)(99286004)(316002)(50226002)(36756003)(186003)(2906002)(5660300002)(86362001)(11346002)(446003)(476003)(2616005)(81166006)(256004)(486006)(2501003)(66066001)(66476007)(66946007)(305945005)(3846002)(66446008)(71190400001)(66556008)(64756008)(71200400001)(478600001)(7736002)(14454004)(2351001)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2814;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: e4stY6lh6wK4fI0LZ6RzocDis+VrISxbFgNetxBW03gE02x4JqEOvLkIAraoDitnvgvIKeYnVX/dumt2YIL6dGiQhmuJ8++sQ1xufuwuUnqWMOblPtsP13a5iyHuw8n12nb9T32xX4ap0MKOlAHyXx7+M0K7VF6e3OIuUudU4K4u0VNojAepYKY7pmzgKq5SZSWb/OIJXMwCZzUwj1kvjijr8TxKQiEEpXG6oNQDzruIUaAJ8KsgoQyI1nRXSyLjcq9zXQgYfNApmR//HiyCH6oDx2Bik0WutSxUcUicE0L5TkHwUl2tDDaRaj5KdDTVC4jdS6MUp6c4LjMQ+MMWrUDkNQKMmKkEbW2q5nIiqn8BMqDjzuca3VWvaeQNRV0Ixj4PXdcysCYJLalx17aFJ01HQLgQYoMkTiUqzLGmc/M=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b4aade0-cc9b-4dd0-7b92-08d704b85c38
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 21:56:56.6332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yghannam@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2814
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Chip Select memory size reporting on AMD Family 17h was recently fixed
in order to account for interleaving. However, the current method is not
robust.

The Chip Select Address Mask can be used to find the memory size. There
are a few cases.

1) For single-rank, use the address mask as the size.

2) For dual-rank non-interleaved, use the address mask divided by 2 as
the size.

3) For dual-rank interleaved, do #2 but "de-interleave" the address mask
first.

Always "de-interleave" the address mask in order to simplify the code
flow. Bit mask manipulation is necessary to check for interleaving, so
just go ahead do the de-interleaving. In the non-interleaved case, the
original and de-interleaved address masks will be the same.

To de-interleave the mask, count the number of zero bits in the middle
of the mask and swap them with the most significant bits.

For example,
Original=3D0xFFFF9FE, De-interleaved=3D0x3FFFFFE

Fixes: fc00c6a41638 ("EDAC/amd64: Adjust printed chip select sizes when int=
erleaved")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20190531234501.32826-6-Yazen.Ghannam@amd.com

v1->v2:
* No change.

 drivers/edac/amd64_edac.c | 107 ++++++++++++++++++++++----------------
 1 file changed, 63 insertions(+), 44 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index d0926b181c7c..f0424c10cac0 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -788,51 +788,36 @@ static void debug_dump_dramcfg_low(struct amd64_pvt *=
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
+static int f17_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
 {
-	u32 mask =3D pvt->csels[ctrl].csmasks[cs >> 1];
-	u32 msb =3D fls(mask) - 1, lsb =3D ffs(mask) - 1;
-	u32 test_mask =3D GENMASK(msb, lsb);
+	int cs_mode =3D 0;
+
+	if (csrow_enabled(2 * dimm, ctrl, pvt))
+		cs_mode |=3D CS_EVEN_PRIMARY;
=20
-	edac_dbg(1, "mask=3D0x%08x test_mask=3D0x%08x\n", mask, test_mask);
+	if (csrow_enabled(2 * dimm + 1, ctrl, pvt))
+		cs_mode |=3D CS_ODD_PRIMARY;
=20
-	return mask ^ test_mask;
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
@@ -1569,18 +1554,50 @@ static int f16_dbam_to_chip_select(struct amd64_pvt=
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
+	int dimm, dual_rank, size =3D 0;
=20
-	/*  Each mask is used for every two base addresses. */
-	u32 addr_mask =3D pvt->csels[umc].csmasks[csrow_nr >> 1];
+	if (!cs_mode)
+		return size;
=20
-	/*  Register [31:1] =3D Address [39:9]. Size is in kBs here. */
-	u32 size =3D ((addr_mask >> 1) - (base_addr >> 1) + 1) >> 1;
+	dual_rank =3D !!(cs_mode & (CS_EVEN_PRIMARY | CS_ODD_PRIMARY));
=20
-	edac_dbg(1, "BaseAddr: 0x%x, AddrMask: 0x%x\n", base_addr, addr_mask);
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
+	size =3D addr_mask_deinterleaved >> 1;
+
+	/* Divide size by two if dual rank. */
+	size >>=3D dual_rank;
=20
 	/* Return size in MBs. */
 	return size >> 10;
@@ -2245,7 +2262,7 @@ static struct amd64_family_type family_types[] =3D {
 		.f6_id =3D PCI_DEVICE_ID_AMD_17H_DF_F6,
 		.ops =3D {
 			.early_channel_count	=3D f17_early_channel_count,
-			.dbam_to_cs		=3D f17_base_addr_to_cs_size,
+			.dbam_to_cs		=3D f17_addr_mask_to_cs_size,
 		}
 	},
 	[F17_M10H_CPUS] =3D {
@@ -2254,7 +2271,7 @@ static struct amd64_family_type family_types[] =3D {
 		.f6_id =3D PCI_DEVICE_ID_AMD_17H_M10H_DF_F6,
 		.ops =3D {
 			.early_channel_count	=3D f17_early_channel_count,
-			.dbam_to_cs		=3D f17_base_addr_to_cs_size,
+			.dbam_to_cs		=3D f17_addr_mask_to_cs_size,
 		}
 	},
 	[F17_M30H_CPUS] =3D {
@@ -2263,7 +2280,7 @@ static struct amd64_family_type family_types[] =3D {
 		.f6_id =3D PCI_DEVICE_ID_AMD_17H_M30H_DF_F6,
 		.ops =3D {
 			.early_channel_count	=3D f17_early_channel_count,
-			.dbam_to_cs		=3D f17_base_addr_to_cs_size,
+			.dbam_to_cs		=3D f17_addr_mask_to_cs_size,
 		}
 	},
 };
@@ -2822,10 +2839,12 @@ static u32 get_csrow_nr_pages(struct amd64_pvt *pvt=
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

