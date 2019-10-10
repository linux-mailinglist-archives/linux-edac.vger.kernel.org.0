Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D91ADD31F1
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2019 22:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfJJUZ3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Oct 2019 16:25:29 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:6304 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726796AbfJJUZ2 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 10 Oct 2019 16:25:28 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9AKJulP025372;
        Thu, 10 Oct 2019 13:25:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=W/GiXdGBdNzyrXt7b0PxBhBepJr8qgS/JBnY13oClIw=;
 b=csbyjNdRwC+YFGRHZgBA6EbGOwxQtPS5UN61/Ymo2dfWZO2Zr3Woy09noyEVm7Xq9lj6
 N+Mhxc6Fi7WigWgf7V5whJLwBJJKtodpes6KjqTRxYV+hn2xAV4ypO/8jlEOTuPAXWDF
 3BAOHavkKoBKvAFg2bAAGn3z8sWlSL7dFKPRBlCma6SGz3zxDlWi00aNqRTIXL254yaZ
 I1P87yO/RHco5/25Uk/5dfrtnf4yC/1KEptjtrfuTc9YAkAVVwDaMRBj5bF068m4iCpK
 RGPOaJRzhfRlYho2OpN9CJFu92iZfO9jEmYC1IkxwAGDMTc6VTzhAXd+II+sMFHz800g 4A== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2vhdxbxqf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 10 Oct 2019 13:25:08 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 10 Oct
 2019 13:25:07 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.56) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 10 Oct 2019 13:25:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEe4wrRm7Ajo2eVMvX7/WbKfUky3e1FwYxT0J8+zNuHfZaRfzD3mjnX4ryJ63fN5O/JgBVSifF3ckIoakHCsQbd+iKE/yBsoNWmCHU6PPJuKPilmp+jgr6uHdp4b8vgerRda+GpKmqT20TXerFEsmB8Ldjgdfb5rpHPanCRL2zV1eb2086mowyNV4Ti2FynFZsAvtwO2TP/rNFCWw+CNPzK/eGF9rHFipysqk5iPpeFDgbTrUqSsEmfeQGby2el+uyCifQFNyXrXOj3u4IIdySJZOvYyOuyUqHyDFHuSrPZQr31BBtb+8wk/IcJhNhQi3YpLnDmlOvtkrvxgjTZnuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/GiXdGBdNzyrXt7b0PxBhBepJr8qgS/JBnY13oClIw=;
 b=T/9/JKtlkZjFUCAcDq18WrNxaCerS5KaJILsyHjxz5pdRh0a6sbgRzA29zH0+L4COsMf4yHwortRC7sRqvVuJ19hKfyismNKZKQEevqHMMgYPRHaq3cXJkJ7iWFviW0hxk6/rTcosXnyFEEWe1/G7PsmA18dD5rYbANF1Cd9Q9eMysrlgHlHb0zRbVJmbSOikrujOV3Y55abdPwED5MDhf5/eGaouDVxSk1uLcnUtbB1jCb/kUSBq8xVluyDLBRuImwRvzj7K5Hz1dPY8vRY3CCtbBk9e3+A2usOuShr3vkKTB73345z69LGOumsbHfsPu2aKfotz+Y7HY8GQc39kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/GiXdGBdNzyrXt7b0PxBhBepJr8qgS/JBnY13oClIw=;
 b=TvZtJQ6if0Fd0uzNrhGqpv8WmNDtB8eqHM13Q+TQvxcoI8GHUNL532CWd88SpyAmfJoPzDQpGCbubLUQWAFB54aIoGaRZzkA10wXcv7ksI2E99KLWopUtvhVn5pUuqjkdSMnQycEXVqiZnJE8/T35Hyuo5vnKlSHxGcFz4ZzWjA=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2701.namprd18.prod.outlook.com (20.179.22.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Thu, 10 Oct 2019 20:25:05 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763%3]) with mapi id 15.20.2327.026; Thu, 10 Oct 2019
 20:25:05 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Jason Baron <jbaron@akamai.com>, Tero Kristo <t-kristo@ti.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: [PATCH 01/19] EDAC: Replace EDAC_DIMM_PTR() macro with
 edac_get_dimm() function
Thread-Topic: [PATCH 01/19] EDAC: Replace EDAC_DIMM_PTR() macro with
 edac_get_dimm() function
Thread-Index: AQHVf6jNve/3IMiRJ0u/d/8Li7yNMw==
Date:   Thu, 10 Oct 2019 20:25:05 +0000
Message-ID: <20191010202418.25098-2-rrichter@marvell.com>
References: <20191010202418.25098-1-rrichter@marvell.com>
In-Reply-To: <20191010202418.25098-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0336.eurprd05.prod.outlook.com
 (2603:10a6:7:92::31) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f428880-e909-4f22-0977-08d74dbfefe1
x-ms-traffictypediagnostic: MN2PR18MB2701:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB2701F63AE79474A068FA942BD9940@MN2PR18MB2701.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:169;
x-forefront-prvs: 018632C080
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39850400004)(346002)(136003)(366004)(376002)(189003)(199004)(6436002)(6512007)(54906003)(71190400001)(110136005)(14454004)(316002)(6486002)(86362001)(71200400001)(5660300002)(2906002)(66066001)(25786009)(50226002)(478600001)(11346002)(446003)(476003)(486006)(3846002)(6116002)(2616005)(99286004)(30864003)(1076003)(6506007)(76176011)(4326008)(14444005)(386003)(7736002)(305945005)(52116002)(26005)(256004)(102836004)(81166006)(66946007)(36756003)(186003)(81156014)(66446008)(66556008)(8936002)(64756008)(8676002)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2701;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uR5kyoA54SZENaHQ0fIB4DLn4Fp6eCXX9tCGzfb+eHgtNGc90H/l6ytQfUDYfB/U+YEV9oSAqshK9bTCdzhfGG75vt7qlFwjmIwm+bUmAGrbWruEnVPyNp4FPhJk07ceK/kWITmAI/6nyh80Z2uoc02oBoSaAVT1kvdkHHbaigcMhavu7c1zTk4JOyvu12Q17tdWESCuU6pnp7G2Yt3k1z35c7xZ34l0PLwexK74fqOLqWTxZ0HwDlXOLjSZZOGoD20SaJx0sKQwiUmRnG7cCbMOE3OzXdTj1w1ohlqih2k15gEO/fOg7cV8fEq1Vpcm37/keVNB5/V7J5cdphCea0h2+ZjozPMLuMKOr7Txj0sdibkThFXwiNn2YVZAJKU2iQFucbv1qTDjuIHLIiPTw7brLS3w2ZMOwwxwWB4MDok=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f428880-e909-4f22-0977-08d74dbfefe1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 20:25:05.6438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JPWRK4r2lvF1voxyW6gYzDj4cyo+AfteT5YrRvZHgTCci+kHr5ik9D9ho4b3wi+E9Owftk0PnV5yz0d0uMTZfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2701
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-10_07:2019-10-10,2019-10-10 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The EDAC_DIMM_PTR() macro takes 3 arguments from struct mem_ctl_info.
Clean up this interface to only pass the mci struct and replace this
macro with the new function edac_get_dimm().

Also introduce the edac_get_dimm_by_index() function for later use.
This allows it to get a dimm pointer only by a given index. This can
be useful if the dimm's position within the layers of the memory
controller or the exact size of the layers are unknown.

Small style changes made for some hunks after applying the semantic
patch.

Semantic patch used:

@@ expression mci, a, b,c; @@

-EDAC_DIMM_PTR(mci->layers, mci->dimms, mci->n_layers, a, b, c)
+edac_get_dimm(mci, a, b, c)

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/edac_mc.c      |  1 +
 drivers/edac/ghes_edac.c    |  7 +--
 drivers/edac/i10nm_base.c   |  3 +-
 drivers/edac/i3200_edac.c   |  3 +-
 drivers/edac/i5000_edac.c   |  5 +-
 drivers/edac/i5100_edac.c   |  3 +-
 drivers/edac/i5400_edac.c   |  3 +-
 drivers/edac/i7300_edac.c   |  3 +-
 drivers/edac/i7core_edac.c  |  3 +-
 drivers/edac/ie31200_edac.c |  7 +--
 drivers/edac/pnd2_edac.c    |  4 +-
 drivers/edac/sb_edac.c      |  2 +-
 drivers/edac/skx_base.c     |  3 +-
 drivers/edac/ti_edac.c      |  2 +-
 include/linux/edac.h        | 92 ++++++++++++++++++++++++-------------
 15 files changed, 79 insertions(+), 62 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index e6fd079783bd..3d45adb5957f 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -438,6 +438,7 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
 			goto error;
 		mci->dimms[off] =3D dimm;
 		dimm->mci =3D mci;
+		dimm->idx =3D off;
=20
 		/*
 		 * Copy DIMM location and initialize it.
diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index d413a0bdc9ad..fb31e80dfe94 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -98,9 +98,7 @@ static void ghes_edac_dmidecode(const struct dmi_header *=
dh, void *arg)
=20
 	if (dh->type =3D=3D DMI_ENTRY_MEM_DEVICE) {
 		struct memdev_dmi_entry *entry =3D (struct memdev_dmi_entry *)dh;
-		struct dimm_info *dimm =3D EDAC_DIMM_PTR(mci->layers, mci->dimms,
-						       mci->n_layers,
-						       dimm_fill->count, 0, 0);
+		struct dimm_info *dimm =3D edac_get_dimm(mci, dimm_fill->count, 0, 0);
 		u16 rdr_mask =3D BIT(7) | BIT(13);
=20
 		if (entry->size =3D=3D 0xffff) {
@@ -527,8 +525,7 @@ int ghes_edac_register(struct ghes *ghes, struct device=
 *dev)
 		dimm_fill.mci =3D mci;
 		dmi_walk(ghes_edac_dmidecode, &dimm_fill);
 	} else {
-		struct dimm_info *dimm =3D EDAC_DIMM_PTR(mci->layers, mci->dimms,
-						       mci->n_layers, 0, 0, 0);
+		struct dimm_info *dimm =3D edac_get_dimm(mci, 0, 0, 0);
=20
 		dimm->nr_pages =3D 1;
 		dimm->grain =3D 128;
diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index c370d5457e6b..059eccf0582b 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -154,8 +154,7 @@ static int i10nm_get_dimm_config(struct mem_ctl_info *m=
ci)
=20
 		ndimms =3D 0;
 		for (j =3D 0; j < I10NM_NUM_DIMMS; j++) {
-			dimm =3D EDAC_DIMM_PTR(mci->layers, mci->dimms,
-					     mci->n_layers, i, j, 0);
+			dimm =3D edac_get_dimm(mci, i, j, 0);
 			mtr =3D I10NM_GET_DIMMMTR(imc, i, j);
 			mcddrtcfg =3D I10NM_GET_MCDDRTCFG(imc, i, j);
 			edac_dbg(1, "dimmmtr 0x%x mcddrtcfg 0x%x (mc%d ch%d dimm%d)\n",
diff --git a/drivers/edac/i3200_edac.c b/drivers/edac/i3200_edac.c
index 299b441647cd..432b375a4075 100644
--- a/drivers/edac/i3200_edac.c
+++ b/drivers/edac/i3200_edac.c
@@ -392,8 +392,7 @@ static int i3200_probe1(struct pci_dev *pdev, int dev_i=
dx)
 		unsigned long nr_pages;
=20
 		for (j =3D 0; j < nr_channels; j++) {
-			struct dimm_info *dimm =3D EDAC_DIMM_PTR(mci->layers, mci->dimms,
-							       mci->n_layers, i, j, 0);
+			struct dimm_info *dimm =3D edac_get_dimm(mci, i, j, 0);
=20
 			nr_pages =3D drb_to_nr_pages(drbs, stacked, j, i);
 			if (nr_pages =3D=3D 0)
diff --git a/drivers/edac/i5000_edac.c b/drivers/edac/i5000_edac.c
index 078a7351bf05..1a6f69c859ab 100644
--- a/drivers/edac/i5000_edac.c
+++ b/drivers/edac/i5000_edac.c
@@ -1275,9 +1275,8 @@ static int i5000_init_csrows(struct mem_ctl_info *mci=
)
 			if (!MTR_DIMMS_PRESENT(mtr))
 				continue;
=20
-			dimm =3D EDAC_DIMM_PTR(mci->layers, mci->dimms, mci->n_layers,
-				       channel / MAX_BRANCHES,
-				       channel % MAX_BRANCHES, slot);
+			dimm =3D edac_get_dimm(mci, channel / MAX_BRANCHES,
+					     channel % MAX_BRANCHES, slot);
=20
 			csrow_megs =3D pvt->dimm_info[slot][channel].megabytes;
 			dimm->grain =3D 8;
diff --git a/drivers/edac/i5100_edac.c b/drivers/edac/i5100_edac.c
index 12bebecb203b..134586753311 100644
--- a/drivers/edac/i5100_edac.c
+++ b/drivers/edac/i5100_edac.c
@@ -858,8 +858,7 @@ static void i5100_init_csrows(struct mem_ctl_info *mci)
 		if (!npages)
 			continue;
=20
-		dimm =3D EDAC_DIMM_PTR(mci->layers, mci->dimms, mci->n_layers,
-			       chan, rank, 0);
+		dimm =3D edac_get_dimm(mci, chan, rank, 0);
=20
 		dimm->nr_pages =3D npages;
 		dimm->grain =3D 32;
diff --git a/drivers/edac/i5400_edac.c b/drivers/edac/i5400_edac.c
index 8c86c6fd7da7..f131c05ade9f 100644
--- a/drivers/edac/i5400_edac.c
+++ b/drivers/edac/i5400_edac.c
@@ -1187,8 +1187,7 @@ static int i5400_init_dimms(struct mem_ctl_info *mci)
 			if (!MTR_DIMMS_PRESENT(mtr))
 				continue;
=20
-			dimm =3D EDAC_DIMM_PTR(mci->layers, mci->dimms, mci->n_layers,
-				       channel / 2, channel % 2, slot);
+			dimm =3D edac_get_dimm(mci, channel / 2, channel % 2, slot);
=20
 			size_mb =3D  pvt->dimm_info[slot][channel].megabytes;
=20
diff --git a/drivers/edac/i7300_edac.c b/drivers/edac/i7300_edac.c
index 447d357c7a67..2e9bbe56cde9 100644
--- a/drivers/edac/i7300_edac.c
+++ b/drivers/edac/i7300_edac.c
@@ -794,8 +794,7 @@ static int i7300_init_csrows(struct mem_ctl_info *mci)
 			for (ch =3D 0; ch < max_channel; ch++) {
 				int channel =3D to_channel(ch, branch);
=20
-				dimm =3D EDAC_DIMM_PTR(mci->layers, mci->dimms,
-					       mci->n_layers, branch, ch, slot);
+				dimm =3D edac_get_dimm(mci, branch, ch, slot);
=20
 				dinfo =3D &pvt->dimm_info[slot][channel];
=20
diff --git a/drivers/edac/i7core_edac.c b/drivers/edac/i7core_edac.c
index a71cca6eeb33..b3135b208f9a 100644
--- a/drivers/edac/i7core_edac.c
+++ b/drivers/edac/i7core_edac.c
@@ -585,8 +585,7 @@ static int get_dimm_config(struct mem_ctl_info *mci)
 			if (!DIMM_PRESENT(dimm_dod[j]))
 				continue;
=20
-			dimm =3D EDAC_DIMM_PTR(mci->layers, mci->dimms, mci->n_layers,
-				       i, j, 0);
+			dimm =3D edac_get_dimm(mci, i, j, 0);
 			banks =3D numbank(MC_DOD_NUMBANK(dimm_dod[j]));
 			ranks =3D numrank(MC_DOD_NUMRANK(dimm_dod[j]));
 			rows =3D numrow(MC_DOD_NUMROW(dimm_dod[j]));
diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index d26300f9cb07..4f65073f230b 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -490,9 +490,7 @@ static int ie31200_probe1(struct pci_dev *pdev, int dev=
_idx)
=20
 			if (dimm_info[j][i].dual_rank) {
 				nr_pages =3D nr_pages / 2;
-				dimm =3D EDAC_DIMM_PTR(mci->layers, mci->dimms,
-						     mci->n_layers, (i * 2) + 1,
-						     j, 0);
+				dimm =3D edac_get_dimm(mci, (i * 2) + 1, j, 0);
 				dimm->nr_pages =3D nr_pages;
 				edac_dbg(0, "set nr pages: 0x%lx\n", nr_pages);
 				dimm->grain =3D 8; /* just a guess */
@@ -503,8 +501,7 @@ static int ie31200_probe1(struct pci_dev *pdev, int dev=
_idx)
 				dimm->dtype =3D DEV_UNKNOWN;
 				dimm->edac_mode =3D EDAC_UNKNOWN;
 			}
-			dimm =3D EDAC_DIMM_PTR(mci->layers, mci->dimms,
-					     mci->n_layers, i * 2, j, 0);
+			dimm =3D edac_get_dimm(mci, i * 2, j, 0);
 			dimm->nr_pages =3D nr_pages;
 			edac_dbg(0, "set nr pages: 0x%lx\n", nr_pages);
 			dimm->grain =3D 8; /* same guess */
diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index b1193be1ef1d..933f7722b893 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -1231,7 +1231,7 @@ static void apl_get_dimm_config(struct mem_ctl_info *=
mci)
 		if (!(chan_mask & BIT(i)))
 			continue;
=20
-		dimm =3D EDAC_DIMM_PTR(mci->layers, mci->dimms, mci->n_layers, i, 0, 0);
+		dimm =3D edac_get_dimm(mci, i, 0, 0);
 		if (!dimm) {
 			edac_dbg(0, "No allocated DIMM for channel %d\n", i);
 			continue;
@@ -1311,7 +1311,7 @@ static void dnv_get_dimm_config(struct mem_ctl_info *=
mci)
 			if (!ranks_of_dimm[j])
 				continue;
=20
-			dimm =3D EDAC_DIMM_PTR(mci->layers, mci->dimms, mci->n_layers, i, j, 0)=
;
+			dimm =3D edac_get_dimm(mci, i, j, 0);
 			if (!dimm) {
 				edac_dbg(0, "No allocated DIMM for channel %d DIMM %d\n", i, j);
 				continue;
diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index a2fd39d330d6..4957e8ee1879 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -1621,7 +1621,7 @@ static int __populate_dimms(struct mem_ctl_info *mci,
 		}
=20
 		for (j =3D 0; j < max_dimms_per_channel; j++) {
-			dimm =3D EDAC_DIMM_PTR(mci->layers, mci->dimms, mci->n_layers, i, j, 0)=
;
+			dimm =3D edac_get_dimm(mci, i, j, 0);
 			if (pvt->info.type =3D=3D KNIGHTS_LANDING) {
 				pci_read_config_dword(pvt->knl.pci_channel[i],
 					knl_mtr_reg, &mtr);
diff --git a/drivers/edac/skx_base.c b/drivers/edac/skx_base.c
index 0fcf3785e8f3..8895eda365ff 100644
--- a/drivers/edac/skx_base.c
+++ b/drivers/edac/skx_base.c
@@ -177,8 +177,7 @@ static int skx_get_dimm_config(struct mem_ctl_info *mci=
)
 		pci_read_config_dword(imc->chan[i].cdev, 0x8C, &amap);
 		pci_read_config_dword(imc->chan[i].cdev, 0x400, &mcddrtcfg);
 		for (j =3D 0; j < SKX_NUM_DIMMS; j++) {
-			dimm =3D EDAC_DIMM_PTR(mci->layers, mci->dimms,
-					     mci->n_layers, i, j, 0);
+			dimm =3D edac_get_dimm(mci, i, j, 0);
 			pci_read_config_dword(imc->chan[i].cdev,
 					      0x80 + 4 * j, &mtr);
 			if (IS_DIMM_PRESENT(mtr)) {
diff --git a/drivers/edac/ti_edac.c b/drivers/edac/ti_edac.c
index 6ac26d1b929f..8be3e89a510e 100644
--- a/drivers/edac/ti_edac.c
+++ b/drivers/edac/ti_edac.c
@@ -135,7 +135,7 @@ static void ti_edac_setup_dimm(struct mem_ctl_info *mci=
, u32 type)
 	u32 val;
 	u32 memsize;
=20
-	dimm =3D EDAC_DIMM_PTR(mci->layers, mci->dimms, mci->n_layers, 0, 0, 0);
+	dimm =3D edac_get_dimm(mci, 0, 0, 0);
=20
 	val =3D ti_edac_readl(edac, EMIF_SDRAM_CONFIG);
=20
diff --git a/include/linux/edac.h b/include/linux/edac.h
index c19483b90079..7f9804438589 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -403,37 +403,6 @@ struct edac_mc_layer {
 	__i;								\
 })
=20
-/**
- * EDAC_DIMM_PTR - Macro responsible to get a pointer inside a pointer arr=
ay
- *		   for the element given by [layer0,layer1,layer2] position
- *
- * @layers:	a struct edac_mc_layer array, describing how many elements
- *		were allocated for each layer
- * @var:	name of the var where we want to get the pointer
- *		(like mci->dimms)
- * @nlayers:	Number of layers at the @layers array
- * @layer0:	layer0 position
- * @layer1:	layer1 position. Unused if n_layers < 2
- * @layer2:	layer2 position. Unused if n_layers < 3
- *
- * For 1 layer, this macro returns "var[layer0]";
- *
- * For 2 layers, this macro is similar to allocate a bi-dimensional array
- * and to return "var[layer0][layer1]";
- *
- * For 3 layers, this macro is similar to allocate a tri-dimensional array
- * and to return "var[layer0][layer1][layer2]";
- */
-#define EDAC_DIMM_PTR(layers, var, nlayers, layer0, layer1, layer2) ({	\
-	typeof(*var) __p;						\
-	int ___i =3D EDAC_DIMM_OFF(layers, nlayers, layer0, layer1, layer2);	\
-	if (___i < 0)							\
-		__p =3D NULL;						\
-	else								\
-		__p =3D (var)[___i];					\
-	__p;								\
-})
-
 struct dimm_info {
 	struct device dev;
=20
@@ -443,6 +412,7 @@ struct dimm_info {
 	unsigned int location[EDAC_MAX_LAYERS];
=20
 	struct mem_ctl_info *mci;	/* the parent */
+	unsigned int idx;		/* index within the parent dimm array */
=20
 	u32 grain;		/* granularity of reported error in bytes */
 	enum dev_type dtype;	/* memory device type */
@@ -669,4 +639,64 @@ struct mem_ctl_info {
 	bool fake_inject_ue;
 	u16 fake_inject_count;
 };
+
+/**
+ * edac_get_dimm_by_index - Get DIMM info from a memory controller
+ *                          given by an index
+ *
+ * @mci:	a struct mem_ctl_info
+ * @index:	index in the memory controller's DIMM array
+ *
+ * Returns a struct dimm_info* or NULL on failure.
+ */
+static inline struct dimm_info *
+edac_get_dimm_by_index(struct mem_ctl_info *mci, int index)
+{
+	if (index < 0 || index >=3D mci->tot_dimms)
+		return NULL;
+
+	if (WARN_ON_ONCE(mci->dimms[index]->idx !=3D index))
+		return NULL;
+
+	return mci->dimms[index];
+}
+
+/**
+ * edac_get_dimm - Get DIMM info from a memory controller given by
+ *                 [layer0,layer1,layer2] position
+ *
+ * @mci:	a struct mem_ctl_info
+ * @layer0:	layer0 position
+ * @layer1:	layer1 position. Unused if n_layers < 2
+ * @layer2:	layer2 position. Unused if n_layers < 3
+ *
+ * For 1 layer, this function returns "dimms[layer0]";
+ *
+ * For 2 layers, this function is similar to allocate a bi-dimensional
+ * array and to return "dimms[layer0][layer1]";
+ *
+ * For 3 layers, this function is similar to allocate a tri-dimensional ar=
ray
+ * and to return "dimms[layer0][layer1][layer2]";
+ */
+static inline struct dimm_info *edac_get_dimm(struct mem_ctl_info *mci,
+	int layer0, int layer1, int layer2)
+{
+	int index;
+
+	if (layer0 < 0
+	    || (mci->n_layers > 1 && layer1 < 0)
+	    || (mci->n_layers > 2 && layer2 < 0))
+		return NULL;
+
+	index =3D layer0;
+
+	if (mci->n_layers > 1)
+		index =3D index * mci->layers[1].size + layer1;
+
+	if (mci->n_layers > 2)
+		index =3D index * mci->layers[2].size + layer2;
+
+	return edac_get_dimm_by_index(mci, index);
+}
+
 #endif
--=20
2.20.1

