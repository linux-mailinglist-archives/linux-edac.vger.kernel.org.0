Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C34098834
	for <lists+linux-edac@lfdr.de>; Thu, 22 Aug 2019 02:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730946AbfHVAAA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 21 Aug 2019 20:00:00 -0400
Received: from mail-eopbgr770075.outbound.protection.outlook.com ([40.107.77.75]:25798
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727255AbfHVAAA (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 21 Aug 2019 20:00:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwDM22kqO++z/kyze2Vc64puzGSl79beKqzUOdTfL4swgfbn/D2yvjtbtSNH6Np3Zwma7LCGBPOme7Iwi3nim6qL+MtKDusPkDnssY2JVeCidzLPBU0PZzk6LNjocb4dw0te29a4wvBWc1+HVMzAIqtXkVs6Rlj95Fetd4wEufpz3OWDHyqxb6oCJBA5hDLOgC/r08+507yHYiB9v/NSuB6Sl9G05zfaOxm3IIPn89YeOLdeo0emWXCDq08fkb45fLjW4xijQ1ovr1VHsExfK6wYpci9JoY4RkBQRokXzAF3fQInd8wPTWQYtXeumxuaNZUa5ds5fjRSHo/GWYz7hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gF1ZSE6Ni3X8JJYbk7dcdDz2AWqzT8gBhB7aXWpNY4Q=;
 b=T3aDlAdKYSjUZ3SA90ftpL9fcuYFjDdwC+BsIAbHUN6ofRt+njsJtzfjYqFJziz+ZUxk6ult8g05UDZb7kzHaxopkKRv/jP1JgrvKvp7CZb9HF9TTyWzWLtI414HU09sH8TP+gIxi0TvVdVeEM7uQyrhDwG4s28eNaZP1hf+BgS1Mw0u/tarpS8wGvfwU8G+tWCdGadjgu4FX8Tr2+5vLyhLeJfEcMUvi3EyN5upHIa6ieMfCK5dgsm2nL0y+4BqMH+0Ls/826DLH+dcAga7okmkRHeUadb5IoJSW5xPLmIj1L60XJMIUyih531nmXB5pohc+kxfI3cUriINP5o2hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gF1ZSE6Ni3X8JJYbk7dcdDz2AWqzT8gBhB7aXWpNY4Q=;
 b=q/D2N+jLptGCxI2ZzJxmbohxlwFJ1PwkTXJxNRVgJPyioHjshVvT2XICaBys/CdNDzrIVWe6AF4P1u/HLQUf4Fo2qvGWExjTD4tw5b+6iN6TpFTCRakKoBuqAd3YvovTcJBsHuMcBZgbYiOUQi60R5JRf6kAA8mZq74TDMufsRY=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2815.namprd12.prod.outlook.com (52.135.107.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Wed, 21 Aug 2019 23:59:55 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d0b4:a849:c22b:3b53]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d0b4:a849:c22b:3b53%2]) with mapi id 15.20.2178.020; Wed, 21 Aug 2019
 23:59:55 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH v3 1/8] EDAC/amd64: Support more than two controllers for chip
 selects handling
Thread-Topic: [PATCH v3 1/8] EDAC/amd64: Support more than two controllers for
 chip selects handling
Thread-Index: AQHVWHyHZ+QC7leK70is0OTYxFuabA==
Date:   Wed, 21 Aug 2019 23:59:55 +0000
Message-ID: <20190821235938.118710-2-Yazen.Ghannam@amd.com>
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
x-ms-office365-filtering-correlation-id: 4b6ba68c-be9a-44b2-acb9-08d72693a99b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2815;
x-ms-traffictypediagnostic: SN6PR12MB2815:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB28151926181D769FA339EDBEF8AA0@SN6PR12MB2815.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:390;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(189003)(199004)(6486002)(8936002)(6436002)(81156014)(99286004)(50226002)(8676002)(26005)(81166006)(52116002)(2906002)(6916009)(53936002)(5640700003)(476003)(54906003)(66946007)(25786009)(66476007)(386003)(64756008)(66446008)(66556008)(186003)(2351001)(446003)(11346002)(316002)(6506007)(6512007)(6306002)(2616005)(486006)(102836004)(14444005)(36756003)(478600001)(71190400001)(256004)(86362001)(2501003)(1076003)(4326008)(5660300002)(7736002)(305945005)(6116002)(3846002)(966005)(71200400001)(76176011)(66066001)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2815;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BRPz1bUARtpCAjDPw1QBV3WXcp6HNkXOOu/11b26D9aRu9EYNNQYN8zNDjbA82QhjF97vYm7gFl44KPA49X66KLQDgl2XI7j9E4BnjLP0lLyvYMOiNlW15rOUaO3FF82bmzMP7My8e5Ntp5XsC1Q9hFDbjbXS7ezQiIJ9bK52NzEMGvc4WOeIKxJAkhC4Q6figBIqojcZ6D/w0x8k9/YJya9hwuC/IIz0DXJmR32XyVJnkdjzt8J/Hqa7IEvYuQ0tx40/0PvSFDlfrvbeL5YPiq9ipj6wN+xBu8Mp7OlRkFwUQrcXilc6GREOJxtNMMQT+GMARRrwj/UyvXDS84swypxqiXqrQorSD0VnX/Dh9Zl4H2YQ/cl7CLpLCyk/FmJKkQl/uQFnR2E7mrdT/v4c0b0gTOcd35hTztUeFVjjsc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b6ba68c-be9a-44b2-acb9-08d72693a99b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 23:59:55.2059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r8f/1mb+xD5V0nJtLnG2azDfzAexVv7YJHbdATmTy5P2HH2NcCIie7u99net11EV6XvG277nV+3y03LfQ/utBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2815
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

The struct chip_select array that's used for saving chip select bases
and masks is fixed at length of two. There should be one struct
chip_select for each controller, so this array should be increased to
support systems that may have more than two controllers.

Increase the size of the struct chip_select array to eight, which is the
largest number of controllers per die currently supported on AMD
systems.

Fix number of DIMMs and Chip Select bases/masks on Family17h, because AMD
Family 17h systems support 2 DIMMs, 4 CS bases, and 2 CS masks per
channel.

Also, carve out the Family 17h+ reading of the bases/masks into a
separate function. This effectively reverts the original bases/masks
reading code to before Family 17h support was added.

This is a second version of a commit that was reverted.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20190709215643.171078-2-Yazen.Ghannam@amd.com

v2->v3:
* Drop Fixes: tags.

v1->v2:
* Patches 1 and 2 squashed together.

 drivers/edac/amd64_edac.c | 123 +++++++++++++++++++++-----------------
 drivers/edac/amd64_edac.h |   5 +-
 2 files changed, 71 insertions(+), 57 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 873437be86d9..dd60cf5a3d96 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -810,7 +810,7 @@ static void debug_display_dimm_sizes_df(struct amd64_pv=
t *pvt, u8 ctrl)
=20
 	edac_printk(KERN_DEBUG, EDAC_MC, "UMC%d chip selects:\n", ctrl);
=20
-	for (dimm =3D 0; dimm < 4; dimm++) {
+	for (dimm =3D 0; dimm < 2; dimm++) {
 		size0 =3D 0;
 		cs0 =3D dimm * 2;
=20
@@ -942,89 +942,102 @@ static void prep_chip_selects(struct amd64_pvt *pvt)
 	} else if (pvt->fam =3D=3D 0x15 && pvt->model =3D=3D 0x30) {
 		pvt->csels[0].b_cnt =3D pvt->csels[1].b_cnt =3D 4;
 		pvt->csels[0].m_cnt =3D pvt->csels[1].m_cnt =3D 2;
+	} else if (pvt->fam >=3D 0x17) {
+		int umc;
+
+		for_each_umc(umc) {
+			pvt->csels[umc].b_cnt =3D 4;
+			pvt->csels[umc].m_cnt =3D 2;
+		}
+
 	} else {
 		pvt->csels[0].b_cnt =3D pvt->csels[1].b_cnt =3D 8;
 		pvt->csels[0].m_cnt =3D pvt->csels[1].m_cnt =3D 4;
 	}
 }
=20
+static void read_umc_base_mask(struct amd64_pvt *pvt)
+{
+	u32 umc_base_reg, umc_mask_reg;
+	u32 base_reg, mask_reg;
+	u32 *base, *mask;
+	int cs, umc;
+
+	for_each_umc(umc) {
+		umc_base_reg =3D get_umc_base(umc) + UMCCH_BASE_ADDR;
+
+		for_each_chip_select(cs, umc, pvt) {
+			base =3D &pvt->csels[umc].csbases[cs];
+
+			base_reg =3D umc_base_reg + (cs * 4);
+
+			if (!amd_smn_read(pvt->mc_node_id, base_reg, base))
+				edac_dbg(0, "  DCSB%d[%d]=3D0x%08x reg: 0x%x\n",
+					 umc, cs, *base, base_reg);
+		}
+
+		umc_mask_reg =3D get_umc_base(umc) + UMCCH_ADDR_MASK;
+
+		for_each_chip_select_mask(cs, umc, pvt) {
+			mask =3D &pvt->csels[umc].csmasks[cs];
+
+			mask_reg =3D umc_mask_reg + (cs * 4);
+
+			if (!amd_smn_read(pvt->mc_node_id, mask_reg, mask))
+				edac_dbg(0, "  DCSM%d[%d]=3D0x%08x reg: 0x%x\n",
+					 umc, cs, *mask, mask_reg);
+		}
+	}
+}
+
 /*
  * Function 2 Offset F10_DCSB0; read in the DCS Base and DCS Mask register=
s
  */
 static void read_dct_base_mask(struct amd64_pvt *pvt)
 {
-	int base_reg0, base_reg1, mask_reg0, mask_reg1, cs;
+	int cs;
=20
 	prep_chip_selects(pvt);
=20
-	if (pvt->umc) {
-		base_reg0 =3D get_umc_base(0) + UMCCH_BASE_ADDR;
-		base_reg1 =3D get_umc_base(1) + UMCCH_BASE_ADDR;
-		mask_reg0 =3D get_umc_base(0) + UMCCH_ADDR_MASK;
-		mask_reg1 =3D get_umc_base(1) + UMCCH_ADDR_MASK;
-	} else {
-		base_reg0 =3D DCSB0;
-		base_reg1 =3D DCSB1;
-		mask_reg0 =3D DCSM0;
-		mask_reg1 =3D DCSM1;
-	}
+	if (pvt->umc)
+		return read_umc_base_mask(pvt);
=20
 	for_each_chip_select(cs, 0, pvt) {
-		int reg0   =3D base_reg0 + (cs * 4);
-		int reg1   =3D base_reg1 + (cs * 4);
+		int reg0   =3D DCSB0 + (cs * 4);
+		int reg1   =3D DCSB1 + (cs * 4);
 		u32 *base0 =3D &pvt->csels[0].csbases[cs];
 		u32 *base1 =3D &pvt->csels[1].csbases[cs];
=20
-		if (pvt->umc) {
-			if (!amd_smn_read(pvt->mc_node_id, reg0, base0))
-				edac_dbg(0, "  DCSB0[%d]=3D0x%08x reg: 0x%x\n",
-					 cs, *base0, reg0);
-
-			if (!amd_smn_read(pvt->mc_node_id, reg1, base1))
-				edac_dbg(0, "  DCSB1[%d]=3D0x%08x reg: 0x%x\n",
-					 cs, *base1, reg1);
-		} else {
-			if (!amd64_read_dct_pci_cfg(pvt, 0, reg0, base0))
-				edac_dbg(0, "  DCSB0[%d]=3D0x%08x reg: F2x%x\n",
-					 cs, *base0, reg0);
+		if (!amd64_read_dct_pci_cfg(pvt, 0, reg0, base0))
+			edac_dbg(0, "  DCSB0[%d]=3D0x%08x reg: F2x%x\n",
+				 cs, *base0, reg0);
=20
-			if (pvt->fam =3D=3D 0xf)
-				continue;
+		if (pvt->fam =3D=3D 0xf)
+			continue;
=20
-			if (!amd64_read_dct_pci_cfg(pvt, 1, reg0, base1))
-				edac_dbg(0, "  DCSB1[%d]=3D0x%08x reg: F2x%x\n",
-					 cs, *base1, (pvt->fam =3D=3D 0x10) ? reg1
-								: reg0);
-		}
+		if (!amd64_read_dct_pci_cfg(pvt, 1, reg0, base1))
+			edac_dbg(0, "  DCSB1[%d]=3D0x%08x reg: F2x%x\n",
+				 cs, *base1, (pvt->fam =3D=3D 0x10) ? reg1
+							: reg0);
 	}
=20
 	for_each_chip_select_mask(cs, 0, pvt) {
-		int reg0   =3D mask_reg0 + (cs * 4);
-		int reg1   =3D mask_reg1 + (cs * 4);
+		int reg0   =3D DCSM0 + (cs * 4);
+		int reg1   =3D DCSM1 + (cs * 4);
 		u32 *mask0 =3D &pvt->csels[0].csmasks[cs];
 		u32 *mask1 =3D &pvt->csels[1].csmasks[cs];
=20
-		if (pvt->umc) {
-			if (!amd_smn_read(pvt->mc_node_id, reg0, mask0))
-				edac_dbg(0, "    DCSM0[%d]=3D0x%08x reg: 0x%x\n",
-					 cs, *mask0, reg0);
-
-			if (!amd_smn_read(pvt->mc_node_id, reg1, mask1))
-				edac_dbg(0, "    DCSM1[%d]=3D0x%08x reg: 0x%x\n",
-					 cs, *mask1, reg1);
-		} else {
-			if (!amd64_read_dct_pci_cfg(pvt, 0, reg0, mask0))
-				edac_dbg(0, "    DCSM0[%d]=3D0x%08x reg: F2x%x\n",
-					 cs, *mask0, reg0);
+		if (!amd64_read_dct_pci_cfg(pvt, 0, reg0, mask0))
+			edac_dbg(0, "    DCSM0[%d]=3D0x%08x reg: F2x%x\n",
+				 cs, *mask0, reg0);
=20
-			if (pvt->fam =3D=3D 0xf)
-				continue;
+		if (pvt->fam =3D=3D 0xf)
+			continue;
=20
-			if (!amd64_read_dct_pci_cfg(pvt, 1, reg0, mask1))
-				edac_dbg(0, "    DCSM1[%d]=3D0x%08x reg: F2x%x\n",
-					 cs, *mask1, (pvt->fam =3D=3D 0x10) ? reg1
-								: reg0);
-		}
+		if (!amd64_read_dct_pci_cfg(pvt, 1, reg0, mask1))
+			edac_dbg(0, "    DCSM1[%d]=3D0x%08x reg: F2x%x\n",
+				 cs, *mask1, (pvt->fam =3D=3D 0x10) ? reg1
+							: reg0);
 	}
 }
=20
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 8f66472f7adc..4dce6a2ac75f 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -96,6 +96,7 @@
 /* Hardware limit on ChipSelect rows per MC and processors per system */
 #define NUM_CHIPSELECTS			8
 #define DRAM_RANGES			8
+#define NUM_CONTROLLERS			8
=20
 #define ON true
 #define OFF false
@@ -351,8 +352,8 @@ struct amd64_pvt {
 	u32 dbam0;		/* DRAM Base Address Mapping reg for DCT0 */
 	u32 dbam1;		/* DRAM Base Address Mapping reg for DCT1 */
=20
-	/* one for each DCT */
-	struct chip_select csels[2];
+	/* one for each DCT/UMC */
+	struct chip_select csels[NUM_CONTROLLERS];
=20
 	/* DRAM base and limit pairs F1x[78,70,68,60,58,50,48,40] */
 	struct dram_range ranges[DRAM_RANGES];
--=20
2.17.1

