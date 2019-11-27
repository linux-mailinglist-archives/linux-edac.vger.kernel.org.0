Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14D1510BFF2
	for <lists+linux-edac@lfdr.de>; Wed, 27 Nov 2019 22:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfK0Vy5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 27 Nov 2019 16:54:57 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:21030 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727194AbfK0Vy5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 27 Nov 2019 16:54:57 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xARLniuP004627;
        Wed, 27 Nov 2019 13:54:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=GeftYgWYZz4kPHpEAIl+McoT1pguf2PIpRTnugslLh8=;
 b=QYfqDFRVU0HIaql/xBOYatUp6hQX5bczO3QH2laZHV0ZFDe3eobGBdKNkLuBrZ+yzlQr
 ZPiukDVFwm2FjgoyD69ueHhBVQJUxiF1pkVRykSf3zobwXaWGn6tSlVJtM8kxqqEVIxS
 CckimnL8CpSYg2prW5hBkbYpXsKnJrwdAEdnykQf8f/yPr02sl+3WCqzY/knJtQ9X7Xa
 0rllu8mRDerKQaRp0+fBFO1944Y+v/o8uZ/0K3KqqIjm6zK2NugU/rcmYxqaMw6aqCBD
 YgUOhZm32ka92e5uDMQ6jfO4fGbVh6cn7CddwRYSsuA5ojgutpYlFIAXwj5nwNYuw86c Tw== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2whd08mrcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 27 Nov 2019 13:54:49 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 27 Nov
 2019 13:54:47 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.57) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 27 Nov 2019 13:54:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLfHguYMkk4P3g/enm/ARHG0nckZG4plArSXmdB8WP8ERB0wxaeHgmN7g4m1hi2J1FyN2HRTHlExIg12JaNEliZs97isTTc/JLoILlQNi3277tqNXeuGkiqukE5vPwsNkPEmbrYf4UvSCkv7h0kvJD1U5TZWvsbvKfxWv/y2u/T8D+6Dk6T6yX+Fy2vIkRJaMo7doCh58pO1YyMY/41AJ4zTxvBuaHueFNUx9s2ydhfgG6IWIHKOwsS2xvtj7egKpmuHWxKdndJpy62fSLb/Lp3azy5ljK2hGNgG6Su39Biv2Pj+GUTz4mOZcC4VyFGqGs7EZBs1DB9uQuFUiFZykg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeftYgWYZz4kPHpEAIl+McoT1pguf2PIpRTnugslLh8=;
 b=AWCfdpgs+58/CwGZK1jaTWqAIdahUVTZfdZKmL05PT0l2qoq1RIUTrYqiEGPx4KLmGKAdb9aZ7UwRwP9P8j+aMm9UKFP4QP3IT9vqwxQ8Z0fyKIMFIMXjfnr8paF5lJ+nrI+taGOjV0RqvoaTWGiIZiV7oo/VB6oLR6csVdHV5c5RLq/pYRt0Rmzz5kjJTFJrrLBGnp9fEQARCBHwgbY8zAvqd0lMQKMUGmwOCwzSW50/+cNhPSUlT1tIetlkFc6F5BAtMfeWAGWAutTQZjA2+GcsICIIFlL2vlH9T0ke9UhSDKnVzE/vwNJVIg5qjAdS0JjMWyfsKZWcvpJpad/UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeftYgWYZz4kPHpEAIl+McoT1pguf2PIpRTnugslLh8=;
 b=eVFNcJBq+l5DmQI1Br8t3U03Bg3g4O+FfaCM3pqJorp6zYasiUydeQ1uaH2C7rnPAu01NKxZ1AciBRYqta7iD4a03N+c1TdehKpjkmzgbdEKYqeUIV/qXVY7MJHcGdAREqy1Z02NQLvZZIzcmOedZ1lT6zO+jt4lAYzZSeCJ2X8=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2477.namprd18.prod.outlook.com (20.179.81.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.22; Wed, 27 Nov 2019 21:54:46 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106%7]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 21:54:46 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>
Subject: [PATCH 01/10] EDAC/mc: Split edac_mc_alloc() into smaller functions
Thread-Topic: [PATCH 01/10] EDAC/mc: Split edac_mc_alloc() into smaller
 functions
Thread-Index: AQHVpW1IhZ77l4wd9kmwY7w9uUFS9Q==
Date:   Wed, 27 Nov 2019 21:54:45 +0000
Message-ID: <20191127215415.11230-2-rrichter@marvell.com>
References: <20191127215415.11230-1-rrichter@marvell.com>
In-Reply-To: <20191127215415.11230-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0017.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::30) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3fcb794-a4f5-4a30-030e-08d773846a96
x-ms-traffictypediagnostic: MN2PR18MB2477:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB24771B9D799CF49C71313C08D9440@MN2PR18MB2477.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(189003)(199004)(14454004)(305945005)(110136005)(256004)(186003)(1076003)(4326008)(86362001)(11346002)(6436002)(8676002)(6486002)(81156014)(2906002)(81166006)(386003)(6512007)(478600001)(76176011)(54906003)(99286004)(52116002)(8936002)(25786009)(7736002)(66946007)(6116002)(26005)(316002)(66066001)(50226002)(36756003)(71190400001)(3846002)(66476007)(66556008)(64756008)(66446008)(71200400001)(102836004)(2616005)(6506007)(446003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2477;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jjJ/eOy+Mqce08CAggWe4KceXZasQetPs+t5PNzt4aajVwEjcVkIwA9a2cM/8Ot5fhXSRvgyALWJWAPdGhHlLvLn4TRPob3A05/Ggex874Vp4jnKNf/fXsQ+v3ty7pY0jfcJ0e+TMv0U9Hl1ZE7QsgcOWX8wMs267zfYbD8Jt3Ti//cvm40He7Ykn6kl5jSm5NCcEeXt1Cny+7a0ndUplygcJ+oXLleXAwuscR1CorKl3NwBdOmPeOS177EjX8U/Z5+jo0HbcvWocNVLCz1QSztAtBEF97qEpwdAjR5qJSX73oigGtNkrTLcQyxXwvFcBuJUQPyeevSDN6RrqTPkZ/PTLdQvUbHMJZ62atkd8JWFejDUnt5sfjpRfo3z3AMN+2YD1q4GYMv4t89FOJOBcYk3lbMftPbM+i9qil9ycLCJASBcXrpbhR5cugKad98c
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d3fcb794-a4f5-4a30-030e-08d773846a96
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 21:54:45.8707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pmXtjXT14TlPocBmGSFXp8aDhvTn2yxihQ3R9h1QLMOaXNGxH1oSqv7dClHANXzKZoRuvL94dimOscMrGAp8Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2477
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-27_04:2019-11-27,2019-11-27 signatures=0
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

