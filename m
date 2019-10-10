Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08A3CD31F8
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2019 22:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfJJUZg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Oct 2019 16:25:36 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:53356 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726953AbfJJUZg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 10 Oct 2019 16:25:36 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9AKKrWQ030264;
        Thu, 10 Oct 2019 13:25:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=udLHPpggucCdSFBTZuve5nlLyoSgWVEWuchiYCsVC2I=;
 b=e1si6GUEa5/9vowzCY4n2hZgRHuGfIaObzPIz/9cpSbbSkedfwd5/RecUaQPfL8/7U8m
 ixekbsho4JDRhJyVuSHhgyIFdvqEyxxervygoOHX7vpBaIEMpiOYArAHdtAw7oiW1L/q
 jD/W6tRoA3KygDIf2mARmEoqbljaj10R1Adzfe4qAXqWTj0USWXQklWyeU9TJIWoOkbr
 ziiccuQu8IYy0RjQox1cgzthmEonPQQpNRcXftHz96Ga6RgxoIE/SU9F5bcAWFYRj3Ip
 1Vu321SUZc+yrX9ge5HQNNlXWmJdT68sKWpV0ffUR+guqR7/N3qGXS9O8XwwFA6eiylR Gw== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2vj66h1gcv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 10 Oct 2019 13:25:23 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 10 Oct
 2019 13:25:22 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.54) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 10 Oct 2019 13:25:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXTqhiy306ZUQBIWPkZYHE0V9ZbkYkeouM93s1RLBjMX3yU3OtC6gKPeqp7Qk3+2zjQ7eIjvB+LVsa2tNXp2eOkLvZNSyv1uLg2ka23OKtnwCi+Cp8zay4wu4KHNGOxgFeMLCgcnfx4AWPubufSUBkPRZmd3pSK6sAJ1Y4Dtn2f1WDW96p6N6fl/pccIGKvLcQHclEp60hHHveC7CKcNN1RIa8zk+DtrAXb1GgxjuGAhhA7ZwDNKbr2f1hPpY7NElObTne7y4kR4VhAjlT9CDLMyCJf10eHoK1cyZlBYPkqyBf4JXlcBzAE6B7s7JamOmMf7k6rgHSB6XVV3j3zlhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udLHPpggucCdSFBTZuve5nlLyoSgWVEWuchiYCsVC2I=;
 b=EpGXl4Y1PnxerIedven7Y6bHqmhul6hLW+IWSXKWO+QE18T4zjypnhFBe8y/qilPgU6wAUcpm0lpF480GApK9U+FE4pVOC6nrb/HfOXWJ0DQZx3MQSgxnR2lZHNPhhSKo7ugAFeL1rCpiSt5iQX1tZxBkT1FY+X0wY8FmqzIZgeEfWV9/EXffqO3He88/XSnvJAWQxeFydWQVcy32wR0sds1bc+eoWDq5XJY1yAwWucPQEb0e0390pvaLiGtQ2Erx8DSBBeo8LWxqxildNa5zvUZNaZxuc8KkpEpZWTJuzJkYig1mhXWpXKOr9gT92AxrghpJ+IHbDzjs2fyFXa+gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udLHPpggucCdSFBTZuve5nlLyoSgWVEWuchiYCsVC2I=;
 b=ruNyvCfyh8iRpAdiFcyixUuxVqzj3e+fYDJ1dYU1h5R065txyrgxwrkFycjgPOMpXKX1PBRdUKrg+82+EhSgyUByT5vB00BY4AyBIucQFzvHtcr2a81iHMU9NHRN4LI8xdmvkYg9CsEGTnphBpyc8bBsebSuDGVoq2BUKaKwhU4=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2447.namprd18.prod.outlook.com (20.179.82.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 10 Oct 2019 20:25:20 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763%3]) with mapi id 15.20.2327.026; Thu, 10 Oct 2019
 20:25:20 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 08/19] EDAC, mc: Split edac_mc_alloc() into smaller functions
Thread-Topic: [PATCH 08/19] EDAC, mc: Split edac_mc_alloc() into smaller
 functions
Thread-Index: AQHVf6jWE7qOLpzA6EKyyfCisGqFZQ==
Date:   Thu, 10 Oct 2019 20:25:20 +0000
Message-ID: <20191010202418.25098-9-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: 3f6b017d-5721-4383-75fa-08d74dbff8c1
x-ms-traffictypediagnostic: MN2PR18MB2447:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB2447FE23BE334C86E5EE03B3D9940@MN2PR18MB2447.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 018632C080
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(199004)(189003)(6512007)(476003)(8936002)(25786009)(50226002)(8676002)(81156014)(81166006)(7736002)(305945005)(256004)(486006)(14454004)(2616005)(6436002)(86362001)(66066001)(36756003)(66946007)(66476007)(66556008)(64756008)(66446008)(11346002)(446003)(71190400001)(71200400001)(6486002)(186003)(478600001)(5660300002)(386003)(316002)(3846002)(26005)(4326008)(6116002)(2906002)(52116002)(76176011)(99286004)(54906003)(110136005)(6506007)(102836004)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2447;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uWZQJhZ2z0IcFw1t8TFVRPgUSmRszDdMps61d0oV2hI+UhYwSAgXSm0HLpNkwUG2UBd+BZ30PIezMr1ODOXs7yrhioWmTYkyNDpQxQ42MtTUFs2sPkntkLtSdenEQkgeXI8TSoRE6QuYh1roq8H4QZBQPfGXk3pOIPS7YSIOXeyMbIhWu0NK2kh2mcJPd2DyD1j3rmtEcIriWW/ZEx3aOXQXu/wn+7AsNbVHzszqGss2M8u6PuagI4MF9hG7M+QIy2u8jQZH13+q2JcHlePn77hiKVlCLhrK8TiYAdVh2R8wS0OCelKu8H84DIJvQNSH7DCr33vkKo9U2QArQOTy01KOtXzJKgudIR5UbJJvwTmn+RxmJvV9Fum8WhrgolDynAWTLoLB4hYCd7GrPAaeqtvvJXEOqzIg4l0ukRubfmU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6b017d-5721-4383-75fa-08d74dbff8c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 20:25:20.5484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JS+eQeOl+3s+0BtYWCpcQ4B73OPAg36HdmhYSXcXMEgbl0zDDfrzKbzT1IJMMFnZ/+cCMYFoOiOYEEMD8NUAYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2447
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-10_07:2019-10-10,2019-10-10 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

edac_mc_alloc() is huge. Factor out code by moving it to the two new
functions edac_mc_alloc_csrows() and edac_mc_alloc_dimms(). Do not
move code yet for better review.

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/edac_mc.c | 104 +++++++++++++++++++++++++++--------------
 1 file changed, 69 insertions(+), 35 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index a893f793be8a..0db504cb3419 100644
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
@@ -312,14 +315,9 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num=
,
 {
 	struct mem_ctl_info *mci;
 	struct edac_mc_layer *layer;
-	struct csrow_info *csr;
-	struct rank_info *chan;
-	struct dimm_info *dimm;
-	unsigned int pos[EDAC_MAX_LAYERS];
 	unsigned int idx, size, tot_dimms =3D 1;
 	unsigned int tot_csrows =3D 1, tot_channels =3D 1;
-	void *pvt, *p, *ptr =3D NULL;
-	int j, row, chn, n, len;
+	void *pvt, *ptr =3D NULL;
 	bool per_rank =3D false;
=20
 	if (WARN_ON(n_layers > EDAC_MAX_LAYERS || n_layers =3D=3D 0))
@@ -377,16 +375,43 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_nu=
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
@@ -394,34 +419,51 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_nu=
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
@@ -431,16 +473,16 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_nu=
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
@@ -452,39 +494,31 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_nu=
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

