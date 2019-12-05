Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC82E113E38
	for <lists+linux-edac@lfdr.de>; Thu,  5 Dec 2019 10:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfLEJiL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 5 Dec 2019 04:38:11 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:63250 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728707AbfLEJiL (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 5 Dec 2019 04:38:11 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB59b4jF023588;
        Thu, 5 Dec 2019 01:38:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=GeftYgWYZz4kPHpEAIl+McoT1pguf2PIpRTnugslLh8=;
 b=pIUnVAgYs0fAwfM3G2/81/PVsrnnY7P6dalV1fI76MxkovLethyhosFA7WX+TJ+VCkmw
 ll3TrkLAxA0tEUgb7zBB+Rh2yVSoRIhxd3DVeCGJQF23sa6+MilkiNhp1RWrpBn4rkjS
 H3rVUgYa1dZ+xJC/dN3AQPBvVnfkLeJXPDPStRGxp9dgY/zdebA5H+jUf5Q/i4FvRfvU
 +GW70/YO4jWM61QtLNwv4zvpkYd8PkjRHVP4WDpfcwYHOO03aMmiDDvDH+6dQZ0E0L+R
 zI5IArlb1G064oPSo/ejO2ku/Dfq6fS16j9jKzPrPpR+ZrsXrSHNhk6eLH6jE9NH2Mdk MQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2wnvgvrcye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 05 Dec 2019 01:38:00 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 5 Dec
 2019 01:37:58 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.58) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 5 Dec 2019 01:37:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQ56IFsnfzwp3eOlA1f5T3zTkT6Ytb6tmt+++pOuKkLes50tfGMl7PR4avS6EnR7vpkPMYgZnAljbJwYKIxPLVY2rZuou729aid38X+4j9Am4fi6/4CyOwTcZKRxVb8aVjCms94nNDh8WLcQaKI9soE5AbTS0S1SBJ00eLHl2/+nts9LhEhMuGj52HCMA6xfGHoINCMvVXURVaPCuhMoZMqSCxfpsaDh+BV7RKyT7gXWbePefkTtqzEly1WVr9kgqCnrbypqMHfLMGz50yIvqaDBYOT9deTNv2F3umZM/MHa+IcHaMD0BFDHMRuHg7APXcT9VA+++ae5RhyqZU16XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeftYgWYZz4kPHpEAIl+McoT1pguf2PIpRTnugslLh8=;
 b=G4ryZ7fJ3QOO7hGshYkVMYg0yWr4H4K3GqoRWaGzDmFCF5t2EU3nV6B6pGYyV+DwG9qqWFVvynOFhP0Gr0JysZfQYN4/i3YZie4f7NZ7hPVVXpFjJynu6/BpNlkt20AOst/uOVdSBwIwIDfIdUhcPgaBTC6+ZHX0MayVJ/CjupPpGKad72Kp9mMcnvSHtZby6YG+gapBhljJ4jPGF5fFA+JdFetjlARsWfswL4WIFFtwCYCZ8WAPxHd+PE+QTuErZ1XbUgM2RO2ADgKkb3Y71ShZPizFY/89IlwQsWPUX1BQQ0rw0oK7Z/JOvOLYod6dPThq9OZK/VekSsS31pDkFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeftYgWYZz4kPHpEAIl+McoT1pguf2PIpRTnugslLh8=;
 b=bczzf3SCi42XywtA5c94NCQb85PR14QeWT5xCRrgAqIZTfMiI01Qyfwn5U7RJUOAdUkVFitHuBRe096W48TGIHG921ynvlM2Y/ygUZWdkT/4dka9kTy4G4e5cCF7kDC12nKon0UXDNGnmlmJWaNilSSbxvlDEe4YQAml6mHLlxg=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2367.namprd18.prod.outlook.com (20.179.80.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Thu, 5 Dec 2019 09:37:57 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106%7]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 09:37:57 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>
Subject: [PATCH v2 01/10] EDAC/mc: Split edac_mc_alloc() into smaller
 functions
Thread-Topic: [PATCH v2 01/10] EDAC/mc: Split edac_mc_alloc() into smaller
 functions
Thread-Index: AQHVq0+taMPTMMoQPUeGfck/EcAERw==
Date:   Thu, 5 Dec 2019 09:37:57 +0000
Message-ID: <20191205093739.4040-2-rrichter@marvell.com>
References: <20191205093739.4040-1-rrichter@marvell.com>
In-Reply-To: <20191205093739.4040-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0170.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::18) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1fd058e5-079b-44d1-7e01-08d77966cfd6
x-ms-traffictypediagnostic: MN2PR18MB2367:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB23675BC4DDA3A432212BF555D95C0@MN2PR18MB2367.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(189003)(199004)(81166006)(14454004)(36756003)(6512007)(316002)(478600001)(54906003)(5660300002)(110136005)(186003)(8936002)(50226002)(6486002)(26005)(99286004)(66556008)(66476007)(81156014)(71190400001)(86362001)(66946007)(66446008)(64756008)(25786009)(8676002)(2906002)(71200400001)(6506007)(4326008)(2616005)(11346002)(102836004)(305945005)(1076003)(76176011)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2367;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t9tJ59B9A4yA+5Fxp9JO362lsQzTo89SOcxHIYfSTdLQZIB/vl9CkaB9QclmyE0IbnhmTRJtr3uPaFaFQUvQXEN95Ss4LR2k7JSyGZKBJ8sx2zcsYGnuZYILLyR52hbYsicaH5VDnc4antf2w55v7M7FKwG3aWXbP9bHsxSqt6oBKvZeymV9Vq30GcTPTlBtzV5haaYL9Am6hiMy0PMpdm9dCw5VFoN8vWwIEXGuLKdXlYa3fUHAM49N+Uzh9lW/bA6VODl+IwkRQmYk2Y6kA2KyPQrZuskeSNekQIjJKAf6m4HXKlpCu1Fvlz3Z5jVnMvNQV+5/BxsLjVI0lW/gOE4+zmh8mLbC9NWNZENuTD9rSG+/0K5RERFexh1fyylGTt2Bja7VOr33hsnI5WD2u9SCqbkBOW+A/8HGhnuQP6v0XGEKEAOSR8TAzaQfQsIr
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd058e5-079b-44d1-7e01-08d77966cfd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 09:37:57.8389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uc6+O5Vf/h9rn7KLGkqFvdvqc5CqNeD+5Y1/MQ+OYTuuTbay0YYl11hcL/P6tps79oTFNstyowsRPsLWGrUAyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2367
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-05_01:2019-12-04,2019-12-05 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

edac_mc_alloc() is huge. Factor out code by moving it to the two new
functions edac_mc_alloc_csrows() and edac_mc_alloc_dimms(). Do not
move code yet for better review.

Signed-off-by: Robert Richter <rrichter@marvell.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/edac/edac_mc.c | 105 +++++++++++++++++++++++++++--------------
 1 file changed, 70 insertions(+), 35 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 7243b88f81d8..9068287604dd 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -305,6 +305,9 @@ static void _edac_mc_free(struct mem_ctl_info *mci)
 	kfree(mci);
 }
=20
+static int edac_mc_alloc_csrows(struct mem_ctl_info *mci);
+static int edac_mc_alloc_dimms(struct mem_ctl_info *mci);
+
 struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
 				   unsigned int n_layers,
 				   struct edac_mc_layer *layers,
@@ -312,15 +315,11 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_nu=
m,
 {
 	struct mem_ctl_info *mci;
 	struct edac_mc_layer *layer;
-	struct csrow_info *csr;
-	struct rank_info *chan;
-	struct dimm_info *dimm;
 	u32 *ce_per_layer[EDAC_MAX_LAYERS], *ue_per_layer[EDAC_MAX_LAYERS];
-	unsigned int pos[EDAC_MAX_LAYERS];
 	unsigned int idx, size, tot_dimms =3D 1, count =3D 1;
 	unsigned int tot_csrows =3D 1, tot_channels =3D 1, tot_errcount =3D 0;
-	void *pvt, *p, *ptr =3D NULL;
-	int i, j, row, chn, n, len;
+	void *pvt, *ptr =3D NULL;
+	int i;
 	bool per_rank =3D false;
=20
 	if (WARN_ON(n_layers > EDAC_MAX_LAYERS || n_layers =3D=3D 0))
@@ -392,16 +391,43 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_nu=
m,
 	mci->num_cschannel =3D tot_channels;
 	mci->csbased =3D per_rank;
=20
+	if (edac_mc_alloc_csrows(mci))
+		goto error;
+
+	if (edac_mc_alloc_dimms(mci))
+		goto error;
+
+	mci->op_state =3D OP_ALLOC;
+
+	return mci;
+
+error:
+	_edac_mc_free(mci);
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(edac_mc_alloc);
+
+static int edac_mc_alloc_csrows(struct mem_ctl_info *mci)
+{
+	unsigned int tot_csrows =3D mci->nr_csrows;
+	unsigned int tot_channels =3D mci->num_cschannel;
+	unsigned int row, chn;
+
 	/*
 	 * Alocate and fill the csrow/channels structs
 	 */
 	mci->csrows =3D kcalloc(tot_csrows, sizeof(*mci->csrows), GFP_KERNEL);
 	if (!mci->csrows)
-		goto error;
+		return -ENOMEM;
+
 	for (row =3D 0; row < tot_csrows; row++) {
+		struct csrow_info *csr;
+
 		csr =3D kzalloc(sizeof(**mci->csrows), GFP_KERNEL);
 		if (!csr)
-			goto error;
+			return -ENOMEM;
+
 		mci->csrows[row] =3D csr;
 		csr->csrow_idx =3D row;
 		csr->mci =3D mci;
@@ -409,34 +435,51 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_nu=
m,
 		csr->channels =3D kcalloc(tot_channels, sizeof(*csr->channels),
 					GFP_KERNEL);
 		if (!csr->channels)
-			goto error;
+			return -ENOMEM;
=20
 		for (chn =3D 0; chn < tot_channels; chn++) {
+			struct rank_info *chan;
+
 			chan =3D kzalloc(sizeof(**csr->channels), GFP_KERNEL);
 			if (!chan)
-				goto error;
+				return -ENOMEM;
+
 			csr->channels[chn] =3D chan;
 			chan->chan_idx =3D chn;
 			chan->csrow =3D csr;
 		}
 	}
=20
+	return 0;
+}
+
+static int edac_mc_alloc_dimms(struct mem_ctl_info *mci)
+{
+	void *p;
+	unsigned int pos[EDAC_MAX_LAYERS];
+	unsigned int row, chn, idx;
+	int layer;
+
 	/*
 	 * Allocate and fill the dimm structs
 	 */
-	mci->dimms  =3D kcalloc(tot_dimms, sizeof(*mci->dimms), GFP_KERNEL);
+	mci->dimms  =3D kcalloc(mci->tot_dimms, sizeof(*mci->dimms), GFP_KERNEL);
 	if (!mci->dimms)
-		goto error;
+		return -ENOMEM;
=20
 	memset(&pos, 0, sizeof(pos));
 	row =3D 0;
 	chn =3D 0;
-	for (idx =3D 0; idx < tot_dimms; idx++) {
+	for (idx =3D 0; idx < mci->tot_dimms; idx++) {
+		struct dimm_info *dimm;
+		struct rank_info *chan;
+		int n, len;
+
 		chan =3D mci->csrows[row]->channels[chn];
=20
 		dimm =3D kzalloc(sizeof(**mci->dimms), GFP_KERNEL);
 		if (!dimm)
-			goto error;
+			return -ENOMEM;
 		mci->dimms[idx] =3D dimm;
 		dimm->mci =3D mci;
 		dimm->idx =3D idx;
@@ -446,16 +489,16 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_nu=
m,
 		 */
 		len =3D sizeof(dimm->label);
 		p =3D dimm->label;
-		n =3D snprintf(p, len, "mc#%u", mc_num);
+		n =3D snprintf(p, len, "mc#%u", mci->mc_idx);
 		p +=3D n;
 		len -=3D n;
-		for (j =3D 0; j < n_layers; j++) {
+		for (layer =3D 0; layer < mci->n_layers; layer++) {
 			n =3D snprintf(p, len, "%s#%u",
-				     edac_layer_name[layers[j].type],
-				     pos[j]);
+				     edac_layer_name[mci->layers[layer].type],
+				     pos[layer]);
 			p +=3D n;
 			len -=3D n;
-			dimm->location[j] =3D pos[j];
+			dimm->location[layer] =3D pos[layer];
=20
 			if (len <=3D 0)
 				break;
@@ -467,39 +510,31 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_nu=
m,
 		dimm->cschannel =3D chn;
=20
 		/* Increment csrow location */
-		if (layers[0].is_virt_csrow) {
+		if (mci->layers[0].is_virt_csrow) {
 			chn++;
-			if (chn =3D=3D tot_channels) {
+			if (chn =3D=3D mci->num_cschannel) {
 				chn =3D 0;
 				row++;
 			}
 		} else {
 			row++;
-			if (row =3D=3D tot_csrows) {
+			if (row =3D=3D mci->nr_csrows) {
 				row =3D 0;
 				chn++;
 			}
 		}
=20
 		/* Increment dimm location */
-		for (j =3D n_layers - 1; j >=3D 0; j--) {
-			pos[j]++;
-			if (pos[j] < layers[j].size)
+		for (layer =3D mci->n_layers - 1; layer >=3D 0; layer--) {
+			pos[layer]++;
+			if (pos[layer] < mci->layers[layer].size)
 				break;
-			pos[j] =3D 0;
+			pos[layer] =3D 0;
 		}
 	}
=20
-	mci->op_state =3D OP_ALLOC;
-
-	return mci;
-
-error:
-	_edac_mc_free(mci);
-
-	return NULL;
+	return 0;
 }
-EXPORT_SYMBOL_GPL(edac_mc_alloc);
=20
 void edac_mc_free(struct mem_ctl_info *mci)
 {
--=20
2.20.1

