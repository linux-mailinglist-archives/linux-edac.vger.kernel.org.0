Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1E4998831
	for <lists+linux-edac@lfdr.de>; Thu, 22 Aug 2019 02:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfHVAAC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 21 Aug 2019 20:00:02 -0400
Received: from mail-eopbgr770075.outbound.protection.outlook.com ([40.107.77.75]:25798
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730985AbfHVAAC (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 21 Aug 2019 20:00:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYQf4dkb3qljus9h5k+456kWqpBP1ULefDyjgk1oPy4E8ef4NYXNjAHQ8d3iiDleBBYFGOekdxL6KlMVqIp3Hb02yPlV9W/Z96pGLzpIcxPuYdfQFHig7+WMZtlHuCrQgELt6s6RAtinFMDUxXXPctBfpaW6yN78uvbuOHKMsF8QRlmTjRkPmMTBXpo7bBUIyYFqpcEyfcxGMnnVcTvnZl0uNqFJwOuN5sOGSKSY/dSFedTL67Jf4ERyTLh2/3Tnq/YUlIDc/es21Yz70uw8nFyvGoTqjMcu2fREwCJ36M807UI+Z8UdcqRQ6Mhi0l+H2UCfAyPrIuLhrM2hLhL8vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7CKow1jegGiDFt0Qvf0oEC6i8dyO1SeXhitG8JVp7I=;
 b=YeEIIFKUJFk0CGRl6ZpV1OxnbYSoqwwZT0MTvYlC34DjbwvTpWxZaBDDbhkJNhydOEQh6w5IFhGQmZhb9IKVcNy+gQQhHgivJuJJdmW4Ik/XFRZ8h4ybdnr5FgoIHSA5J6RJjGKcCu3QdcQLzrVidWxPebm7vht3SQpYCKkpriTTI5eaOot5MGdGweUxlIrkFIuTnvQfs1Us9pXW21O2J2DBVfB9DXbFoMsLymYVG8/atYcyHufFiL4h13IK49fyLIti5CwiTGfwKaEu6Ys36z+EAp2wVZDZhsM4RJLYhg33CgS2f4GZinI9R+XPYDX6KccxDCWT50+672H0bBMIzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7CKow1jegGiDFt0Qvf0oEC6i8dyO1SeXhitG8JVp7I=;
 b=pzJXPkW6W9cHaV0S1DTeqUHQfIRbkS8JQaUDjcUrX8lxHt3+TnZsN20B7ec0ZyZsf6A6VwO7mevQH6s05+wL9ZINoAbVtKMAK1jpsrqZsc4X1CBAYKpIUm+ZArfPeak5X2PhERIUuXXaIgZUf6Z6UJiYUGrpiZbUzUL20jpoO9Q=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2815.namprd12.prod.outlook.com (52.135.107.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Wed, 21 Aug 2019 23:59:58 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d0b4:a849:c22b:3b53]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d0b4:a849:c22b:3b53%2]) with mapi id 15.20.2178.020; Wed, 21 Aug 2019
 23:59:58 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH v3 3/8] EDAC/amd64: Initialize DIMM info for systems with more
 than two channels
Thread-Topic: [PATCH v3 3/8] EDAC/amd64: Initialize DIMM info for systems with
 more than two channels
Thread-Index: AQHVWHyIDoXglb097EC3hpkcG3/nbg==
Date:   Wed, 21 Aug 2019 23:59:57 +0000
Message-ID: <20190821235938.118710-4-Yazen.Ghannam@amd.com>
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
x-ms-office365-filtering-correlation-id: c65b91f9-88eb-4a8b-b617-08d72693ab0e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2815;
x-ms-traffictypediagnostic: SN6PR12MB2815:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB2815E4457876FAE210357401F8AA0@SN6PR12MB2815.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(189003)(199004)(6486002)(8936002)(6436002)(81156014)(99286004)(50226002)(8676002)(26005)(81166006)(52116002)(2906002)(6916009)(53936002)(5640700003)(476003)(54906003)(66946007)(25786009)(66476007)(386003)(64756008)(66446008)(66556008)(186003)(2351001)(446003)(11346002)(316002)(6506007)(6512007)(6306002)(2616005)(486006)(102836004)(14444005)(36756003)(478600001)(71190400001)(256004)(86362001)(2501003)(1076003)(4326008)(5660300002)(7736002)(305945005)(6116002)(3846002)(966005)(71200400001)(76176011)(66066001)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2815;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IdkAuhYbQwQkbE98l91Ed4vuA2C7tZfrqgFRmUzLUoc0f7vTn/3Ydq3BmcwqXR0fDBUGRfSyXhMW/+JYbp1s16OZ/vbOiJywFnOsTl9uKGHOhF1dOaLB2bOHO9pDU1bgn95sYjT3X9bdMUN2SQDnkCIp2wAuTtx+7h5TZAv5kwpfKeXzincDJvYsSAoqhDzKs1wDB0gJWSKEc2rbx2g2q1LGuC8PwWcizrsMiAdPFejSgIgP4Fv8srZbhw6Vh5nVzOrXfSe6dNPA+PCUOd/M7FoJ6xm4rok3w7WPlFmT+BUKPEaQmtxv1f9l//M2a/LLM6vf39jzafXdf2GphtewhGhWJD/IruMhu8NehhBiLUlDVEvBSSPDP8Kfg+uv0rfXgQoCt9s1T8MrS0qYXpnT8WpK3Dt6UpVNGf+XKy0+PLY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c65b91f9-88eb-4a8b-b617-08d72693ab0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 23:59:57.2538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xcBNBQcRnNCL9fhVnWb7gs2zN6PanguhRrHVr5acN3kuzaq6UpkH4yq7CoKgckgC+lNpliFYegIiY2De69Et1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2815
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Currently, the DIMM info for AMD Family 17h systems is initialized in
init_csrows(). This function is shared with legacy systems, and it has a
limit of two channel support.

This prevents initialization of the DIMM info for a number of ranks, so
there will be missing ranks in the EDAC sysfs.

Create a new init_csrows_df() for Family17h+ and revert init_csrows()
back to pre-Family17h support.

Loop over all channels in the new function in order to support systems
with more than two channels.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20190709215643.171078-4-Yazen.Ghannam@amd.com

v2->v3:
* Drop Fixes: tag.
* Add x8 DRAM device case.

v1->v2:
* No change.

 drivers/edac/amd64_edac.c | 66 ++++++++++++++++++++++++++++++---------
 1 file changed, 52 insertions(+), 14 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 0e8b2137edbb..001dc85122e9 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2837,6 +2837,49 @@ static u32 get_csrow_nr_pages(struct amd64_pvt *pvt,=
 u8 dct, int csrow_nr_orig)
 	return nr_pages;
 }
=20
+static int init_csrows_df(struct mem_ctl_info *mci)
+{
+	struct amd64_pvt *pvt =3D mci->pvt_info;
+	enum edac_type edac_mode =3D EDAC_NONE;
+	enum dev_type dev_type =3D DEV_UNKNOWN;
+	struct dimm_info *dimm;
+	int empty =3D 1;
+	u8 umc, cs;
+
+	if (mci->edac_ctl_cap & EDAC_FLAG_S16ECD16ED) {
+		edac_mode =3D EDAC_S16ECD16ED;
+		dev_type =3D DEV_X16;
+	} else if (mci->edac_ctl_cap & EDAC_FLAG_S8ECD8ED) {
+		edac_mode =3D EDAC_S8ECD8ED;
+		dev_type =3D DEV_X8;
+	} else if (mci->edac_ctl_cap & EDAC_FLAG_S4ECD4ED) {
+		edac_mode =3D EDAC_S4ECD4ED;
+		dev_type =3D DEV_X4;
+	} else if (mci->edac_ctl_cap & EDAC_FLAG_SECDED) {
+		edac_mode =3D EDAC_SECDED;
+	}
+
+	for_each_umc(umc) {
+		for_each_chip_select(cs, umc, pvt) {
+			if (!csrow_enabled(cs, umc, pvt))
+				continue;
+
+			empty =3D 0;
+			dimm =3D mci->csrows[cs]->channels[umc]->dimm;
+
+			edac_dbg(1, "MC node: %d, csrow: %d\n",
+					pvt->mc_node_id, cs);
+
+			dimm->nr_pages =3D get_csrow_nr_pages(pvt, umc, cs);
+			dimm->mtype =3D pvt->dram_type;
+			dimm->edac_mode =3D edac_mode;
+			dimm->dtype =3D dev_type;
+		}
+	}
+
+	return empty;
+}
+
 /*
  * Initialize the array of csrow attribute instances, based on the values
  * from pci config hardware registers.
@@ -2851,15 +2894,16 @@ static int init_csrows(struct mem_ctl_info *mci)
 	int nr_pages =3D 0;
 	u32 val;
=20
-	if (!pvt->umc) {
-		amd64_read_pci_cfg(pvt->F3, NBCFG, &val);
+	if (pvt->umc)
+		return init_csrows_df(mci);
+
+	amd64_read_pci_cfg(pvt->F3, NBCFG, &val);
=20
-		pvt->nbcfg =3D val;
+	pvt->nbcfg =3D val;
=20
-		edac_dbg(0, "node %d, NBCFG=3D0x%08x[ChipKillEccCap: %d|DramEccEn: %d]\n=
",
-			 pvt->mc_node_id, val,
-			 !!(val & NBCFG_CHIPKILL), !!(val & NBCFG_ECC_ENABLE));
-	}
+	edac_dbg(0, "node %d, NBCFG=3D0x%08x[ChipKillEccCap: %d|DramEccEn: %d]\n"=
,
+		 pvt->mc_node_id, val,
+		 !!(val & NBCFG_CHIPKILL), !!(val & NBCFG_ECC_ENABLE));
=20
 	/*
 	 * We iterate over DCT0 here but we look at DCT1 in parallel, if needed.
@@ -2896,13 +2940,7 @@ static int init_csrows(struct mem_ctl_info *mci)
 		edac_dbg(1, "Total csrow%d pages: %u\n", i, nr_pages);
=20
 		/* Determine DIMM ECC mode: */
-		if (pvt->umc) {
-			if (mci->edac_ctl_cap & EDAC_FLAG_S4ECD4ED)
-				edac_mode =3D EDAC_S4ECD4ED;
-			else if (mci->edac_ctl_cap & EDAC_FLAG_SECDED)
-				edac_mode =3D EDAC_SECDED;
-
-		} else if (pvt->nbcfg & NBCFG_ECC_ENABLE) {
+		if (pvt->nbcfg & NBCFG_ECC_ENABLE) {
 			edac_mode =3D (pvt->nbcfg & NBCFG_CHIPKILL)
 					? EDAC_S4ECD4ED
 					: EDAC_SECDED;
--=20
2.17.1

