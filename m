Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03973F123A
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2019 10:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfKFJdQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Nov 2019 04:33:16 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:23972 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725856AbfKFJdQ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 6 Nov 2019 04:33:16 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA69Unxj003167;
        Wed, 6 Nov 2019 01:33:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=DSDXJqBl84EvmUJYBfU1UHYK2SRl9BBOA2sWchkTMjU=;
 b=FV6H3dx9duVnaIymdVo5Kna/OwvCL/UGO832KOGtdMDBB2P4PKuE29/OfEWmxTO/y7g8
 DMG7YZreytfgWiivCEwoXKssrEvJyfa/n/+Ltke2kUhCWHcV7aPs4nQa0lnyajmiCt+l
 I94IXD3FRzlqB9Mvqz0ODk4NAKEF97EORNvTXAjBmLXzhep5Pjh3bXypxySBhmIScDHG
 yQ32yCQjq5CpIv9OXfmWoel4ZURnK7bcsZryhUezuoUN6RllpsUczanJl/vwzufaUQwc
 b6U4NpePEbxbxjsNAc6u45gITvInEmoTmMdMhA64/rEjnK1DUO1n+9N+bB6xiC+LzUaH Kg== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2w3eud3c68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 01:33:08 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 6 Nov
 2019 01:33:07 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.50) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 6 Nov 2019 01:33:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbiI+ndT6e+FVegzvXyNGADFIwn/Va/jRkBs+WkJdaIwT1V7dPXnZou9IGRPD4cx0I5kkH9zY5bxHy+Z44sFcV3EGzZjFp3QCYrusCve8ijdhRY32oPQiE8iJOHQtOQlsq37TjuWIvz8JDa9gejbZwIV3Tm1jk958piyzCYjZhgLqnvo49bajAy27IXibuL7GJStzKqWp2k4YhsMIxuI57GzhMCGD+E8MWq2FtXZD/lXAC78L/A123tCh5MidFCCk84rU/AeOm3iEIMvco7iCGAJ+rVYo+SOfGq14CHfLX2noWPPxBXlqeUXaJ3+/4HjQkqj60QaXAZjsWj10x2g3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSDXJqBl84EvmUJYBfU1UHYK2SRl9BBOA2sWchkTMjU=;
 b=iLJcH9I5Ok9bX9pwNOxMnIVcuolY/DLVIppFNxAKWoxs6nuc0ktd54yAq1muoLyl132H5XXja9AofP7A/U0UZw5nm3GXzOMj+Qm79ItsMi8JLgk9SkC9HRDVEF44Ds5JAaLIsApZI9mEeQaJNeZFP3X3QnwIsdhEe+AMxWvnIPPtrOEZqPrd/gCYjfisMGltUVi65OBk0IivMbFFUU3jvoFUNBhq+2Ijt0WaMIJHemmM5ZbBw/drPPqHtXruPXlFc1fwLwlvpMcWCkAQ4Eu7qU2u3lTWURghmxmlCT31n7zpJWvK+u7XZFyYrnUbpZFW8Ny5lIX5awwf6Ka8ggAdFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSDXJqBl84EvmUJYBfU1UHYK2SRl9BBOA2sWchkTMjU=;
 b=I331/8wHi8sx4LUt/laYnSmJtLXfn6dE3IfkvtAy36N3/EcN204truHhAXrvhOCcg8ez6WxrMlvU6s79cPKJRUGLJhOFEuJ4c81iXB0Gp5A4smeCbwIWp9t2pMMLb6mxsbxaGWHf4N+3oMDMmblDzbZjgys7DnOSBRFB5my9gfI=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3165.namprd18.prod.outlook.com (10.255.236.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 6 Nov 2019 09:33:04 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6%6]) with mapi id 15.20.2430.020; Wed, 6 Nov 2019
 09:33:04 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 02/20] EDAC: Remove EDAC_DIMM_OFF() macro
Thread-Topic: [PATCH v2 02/20] EDAC: Remove EDAC_DIMM_OFF() macro
Thread-Index: AQHVlIUwz6HF5naXQkGmp5+ZC78PIA==
Date:   Wed, 6 Nov 2019 09:33:04 +0000
Message-ID: <20191106093239.25517-3-rrichter@marvell.com>
References: <20191106093239.25517-1-rrichter@marvell.com>
In-Reply-To: <20191106093239.25517-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0287.eurprd05.prod.outlook.com
 (2603:10a6:7:93::18) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4520a4e-5809-4ec5-23ad-08d7629c5308
x-ms-traffictypediagnostic: MN2PR18MB3165:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB3165AC8140D9F2A1664C4DFAD9790@MN2PR18MB3165.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(199004)(189003)(52116002)(305945005)(6486002)(76176011)(71190400001)(71200400001)(256004)(11346002)(446003)(7736002)(14444005)(6436002)(4326008)(6512007)(66446008)(66556008)(66476007)(66946007)(64756008)(5660300002)(1076003)(476003)(6116002)(3846002)(110136005)(54906003)(36756003)(2906002)(8676002)(99286004)(81166006)(81156014)(316002)(8936002)(50226002)(486006)(6506007)(386003)(102836004)(66066001)(2616005)(86362001)(478600001)(25786009)(186003)(14454004)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3165;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zn3QNqwGBhTHsruqgFZ4hpbU0t4MqN/lLHcYWF+FFF2U+ub04NsU1ZoL3cpgp8L6l6+NONnBP9sVJdXIlmskz8aJuUWXMGL7dmp7qsFDLSefV6fv8PPcedTBrXR9n4OXhsWQ1J6hhfp/jvw2xELcTUaxD+BX+56dSyKSPYUggKFccItp6rkV2Lmv0c/RA7FZraOgftxsyxctWrQ0w+YkcPDY0cW5rg4N3WatHkbRg1uhvHP+CKlYYHUoC3C1qk4M0KfEu+glJKFH6o8BRB73jjqN1t3HhkMGQNdPzAKphTzthcwet65Wi5B1rwpPe93kmF3Tl1B2nHU2WdXXLBXLKiMT4G9OpbFjqIblxJMTrTEoFHeLLnJ3QLsBX8xbhYENClSq/2Q5LICLTnMBPcL6Sb/O1Wy5UVg7j4/o1U+IDa6Aq7GeeyYJEh60rB2OxsxK
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a4520a4e-5809-4ec5-23ad-08d7629c5308
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 09:33:04.5815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AcUKPm766T1yE0EXTcoSifbIoOn0JkTnl+Pls2zZPPmjmwPEVHDZPHs2J9D0lLufJWjxz4x4D4Wo5o3TiSVuwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3165
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_02:2019-11-06,2019-11-06 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The EDAC_DIMM_OFF() macro takes 5 arguments to get the DIMM's index.
This can be much simplified. Store the index in struct dimm_info to
avoid its calculation and remove the EDAC_DIMM_OFF() macro. The index
can be directly used.

Another advantage is that edac_mc_alloc() could be used even if the
exact size of the layers is unknown. Only the number of DIMMs would be
needed.

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/edac_mc.c       | 14 ++++-------
 drivers/edac/edac_mc_sysfs.c | 20 ++++------------
 include/linux/edac.h         | 45 ++++--------------------------------
 3 files changed, 13 insertions(+), 66 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index e6fd079783bd..72088d49b03b 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -314,10 +314,10 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_nu=
m,
 	struct dimm_info *dimm;
 	u32 *ce_per_layer[EDAC_MAX_LAYERS], *ue_per_layer[EDAC_MAX_LAYERS];
 	unsigned int pos[EDAC_MAX_LAYERS];
-	unsigned int size, tot_dimms =3D 1, count =3D 1;
+	unsigned int idx, size, tot_dimms =3D 1, count =3D 1;
 	unsigned int tot_csrows =3D 1, tot_channels =3D 1, tot_errcount =3D 0;
 	void *pvt, *p, *ptr =3D NULL;
-	int i, j, row, chn, n, len, off;
+	int i, j, row, chn, n, len;
 	bool per_rank =3D false;
=20
 	BUG_ON(n_layers > EDAC_MAX_LAYERS || n_layers =3D=3D 0);
@@ -425,19 +425,15 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_nu=
m,
 	memset(&pos, 0, sizeof(pos));
 	row =3D 0;
 	chn =3D 0;
-	for (i =3D 0; i < tot_dimms; i++) {
+	for (idx =3D 0; idx < tot_dimms; idx++) {
 		chan =3D mci->csrows[row]->channels[chn];
-		off =3D EDAC_DIMM_OFF(layer, n_layers, pos[0], pos[1], pos[2]);
-		if (off < 0 || off >=3D tot_dimms) {
-			edac_mc_printk(mci, KERN_ERR, "EDAC core bug: EDAC_DIMM_OFF is trying t=
o do an illegal data access\n");
-			goto error;
-		}
=20
 		dimm =3D kzalloc(sizeof(**mci->dimms), GFP_KERNEL);
 		if (!dimm)
 			goto error;
-		mci->dimms[off] =3D dimm;
+		mci->dimms[idx] =3D dimm;
 		dimm->mci =3D mci;
+		dimm->idx =3D idx;
=20
 		/*
 		 * Copy DIMM location and initialize it.
diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 32d016f1ecd1..91e4c8f155af 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -557,14 +557,8 @@ static ssize_t dimmdev_ce_count_show(struct device *de=
v,
 {
 	struct dimm_info *dimm =3D to_dimm(dev);
 	u32 count;
-	int off;
-
-	off =3D EDAC_DIMM_OFF(dimm->mci->layers,
-			    dimm->mci->n_layers,
-			    dimm->location[0],
-			    dimm->location[1],
-			    dimm->location[2]);
-	count =3D dimm->mci->ce_per_layer[dimm->mci->n_layers-1][off];
+
+	count =3D dimm->mci->ce_per_layer[dimm->mci->n_layers-1][dimm->idx];
 	return sprintf(data, "%u\n", count);
 }
=20
@@ -574,14 +568,8 @@ static ssize_t dimmdev_ue_count_show(struct device *de=
v,
 {
 	struct dimm_info *dimm =3D to_dimm(dev);
 	u32 count;
-	int off;
-
-	off =3D EDAC_DIMM_OFF(dimm->mci->layers,
-			    dimm->mci->n_layers,
-			    dimm->location[0],
-			    dimm->location[1],
-			    dimm->location[2]);
-	count =3D dimm->mci->ue_per_layer[dimm->mci->n_layers-1][off];
+
+	count =3D dimm->mci->ue_per_layer[dimm->mci->n_layers-1][dimm->idx];
 	return sprintf(data, "%u\n", count);
 }
=20
diff --git a/include/linux/edac.h b/include/linux/edac.h
index 696bfb684d92..79c5564ee314 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -362,47 +362,6 @@ struct edac_mc_layer {
  */
 #define EDAC_MAX_LAYERS		3
=20
-/**
- * EDAC_DIMM_OFF - Macro responsible to get a pointer offset inside a poin=
ter
- *		   array for the element given by [layer0,layer1,layer2]
- *		   position
- *
- * @layers:	a struct edac_mc_layer array, describing how many elements
- *		were allocated for each layer
- * @nlayers:	Number of layers at the @layers array
- * @layer0:	layer0 position
- * @layer1:	layer1 position. Unused if n_layers < 2
- * @layer2:	layer2 position. Unused if n_layers < 3
- *
- * For 1 layer, this macro returns "var[layer0] - var";
- *
- * For 2 layers, this macro is similar to allocate a bi-dimensional array
- * and to return "var[layer0][layer1] - var";
- *
- * For 3 layers, this macro is similar to allocate a tri-dimensional array
- * and to return "var[layer0][layer1][layer2] - var".
- *
- * A loop could be used here to make it more generic, but, as we only have
- * 3 layers, this is a little faster.
- *
- * By design, layers can never be 0 or more than 3. If that ever happens,
- * a NULL is returned, causing an OOPS during the memory allocation routin=
e,
- * with would point to the developer that he's doing something wrong.
- */
-#define EDAC_DIMM_OFF(layers, nlayers, layer0, layer1, layer2) ({		\
-	int __i;							\
-	if ((nlayers) =3D=3D 1)						\
-		__i =3D layer0;						\
-	else if ((nlayers) =3D=3D 2)					\
-		__i =3D (layer1) + ((layers[1]).size * (layer0));		\
-	else if ((nlayers) =3D=3D 3)					\
-		__i =3D (layer2) + ((layers[2]).size * ((layer1) +	\
-			    ((layers[1]).size * (layer0))));		\
-	else								\
-		__i =3D -EINVAL;						\
-	__i;								\
-})
-
 struct dimm_info {
 	struct device dev;
=20
@@ -412,6 +371,7 @@ struct dimm_info {
 	unsigned int location[EDAC_MAX_LAYERS];
=20
 	struct mem_ctl_info *mci;	/* the parent */
+	unsigned int idx;		/* index within the parent dimm array */
=20
 	u32 grain;		/* granularity of reported error in bytes */
 	enum dev_type dtype;	/* memory device type */
@@ -654,6 +614,9 @@ edac_get_dimm_by_index(struct mem_ctl_info *mci, int in=
dex)
 	if (index < 0 || index >=3D mci->tot_dimms)
 		return NULL;
=20
+	if (WARN_ON_ONCE(mci->dimms[index]->idx !=3D index))
+		return NULL;
+
 	return mci->dimms[index];
 }
=20
--=20
2.20.1

