Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4960F125D
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2019 10:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731754AbfKFJeV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Nov 2019 04:34:21 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:13070 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731759AbfKFJdq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 6 Nov 2019 04:33:46 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA69VFnL027198;
        Wed, 6 Nov 2019 01:33:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=pCo0iu+QeVIL291bbUxBVAKfEb45CT4fRBRt4sOB+L0=;
 b=DIoenD+f2SUOpmvszZTsI9b01wOeEaIYt52U9JdIdUmUvuLWkgXseoWxwW7K0/yfxCup
 BgSoIjMzd/eutLgRkTFWpzk4noCtfDqawXphvVF69Givrv2OG7gWW/6OvGS0JFdzJlHN
 WfXOX15VLy8YrXslIMnw3Fi0uBWp5lEo+nKjKDWV4fzBER95JzfVAYq+j4v7BybfXUdd
 Yf+vw1aw8flsKaNCp8yJiKCYTSpbRegUkI1mMVTAUMHKdpFzS+L+0GzUiBKOPyHK7LPz
 rgLPxWbJy2b0LFMp4jiYVoBIfyjyfuAwMt/G/g8TwTX88Sdt67x62901xIt1xu3dSoxe Ug== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2w19amyakw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 01:33:38 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 6 Nov
 2019 01:33:36 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.51) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 6 Nov 2019 01:33:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpGg+1Tbws8EHzqJqq8kWDp5mnKMLpvsKaBKHvuquNcPQtQwiBr/LYbsbLLaaOG6tSNPv1YyycSvcJ1SEUjo+9nwRPcjTuZCvbsrzuwQbBBfUucpsE0gIewEHIQtCSFfyLc+oCo1FpwPAt5CafwlNDA+G0ViwZPCvKzwf7ocxFCvx1J5RkTWAqeCEEN/p/9pWIlj5LjYW0awIoOwrNrSjRLo+AgpxoQLo5k5fB0kRzwgMTSY90D3jwoVoYpUgCzUOaAW2pNAqMCKyXeRIyFT0saHyxLEsH7Eovmgc8tYWBzim1g2zHOjDR5/pSFk9Kw+12f5GZIDxS9Uuqz9NSLzZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCo0iu+QeVIL291bbUxBVAKfEb45CT4fRBRt4sOB+L0=;
 b=eg7MkC+MneNULMgBvcDGM1jLn4qcrWIjevtZTNpChv8UAArMsh4DSWWo3Da+59D1klWGz8cfV6Oh/d/zst1VcpoCH28i7TgcMw4E4cJgZupXzBIElCd/baf/+vCZEBh8e9U1L60UHyHKj8hSu1/PAqnmAKLMGkWNqELc5nHQAzsc6ldQSBK+NWiLYqveDzC16y1KZvwaxy8l1/HVA8KZ1vjZK6WlcLdC7CRHROd5b6U5FWsR5AOfLcuXxUOhKaja5L427Yt2LMdUqqH9YSAD0aVLRR00ipyFuANsTzBdTcQdv45Z5QwI1iYMGSBDG4dK61Rt2oDkUXceYArY4tTfSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCo0iu+QeVIL291bbUxBVAKfEb45CT4fRBRt4sOB+L0=;
 b=nypiTJza4KrmzD9PVpaPCqkFVOJza1OUvY9U2dhfqrPHTofInRRSylyknMTeH6Rkc/S+FyHmslje81KlidLrustgqRmC+NQXyYBX5b4Kx6qX7SJ76uqvXgC3E/2pc6cyrLS5OmbktVEiR3WJ6IZ/+gW1aH1LSzUbYGcjJPK2szs=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3165.namprd18.prod.outlook.com (10.255.236.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 6 Nov 2019 09:33:35 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6%6]) with mapi id 15.20.2430.020; Wed, 6 Nov 2019
 09:33:35 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>
Subject: [PATCH v2 15/20] EDAC, mc: Split edac_mc_alloc() into smaller
 functions
Thread-Topic: [PATCH v2 15/20] EDAC, mc: Split edac_mc_alloc() into smaller
 functions
Thread-Index: AQHVlIVCjMQKpUaSAEWu8ODDUwPZTQ==
Date:   Wed, 6 Nov 2019 09:33:34 +0000
Message-ID: <20191106093239.25517-16-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: e3e18a5a-34b6-4d3f-4b4c-08d7629c6512
x-ms-traffictypediagnostic: MN2PR18MB3165:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB3165554D1C2A38623D08FDDDD9790@MN2PR18MB3165.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(199004)(189003)(52116002)(305945005)(6486002)(76176011)(71190400001)(71200400001)(256004)(11346002)(446003)(7736002)(6436002)(4326008)(6512007)(66446008)(66556008)(66476007)(66946007)(64756008)(5660300002)(1076003)(476003)(6116002)(3846002)(110136005)(54906003)(36756003)(2906002)(8676002)(99286004)(81166006)(81156014)(316002)(8936002)(50226002)(486006)(6506007)(386003)(102836004)(66066001)(2616005)(86362001)(478600001)(25786009)(186003)(14454004)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3165;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rt3baEn3w+sefEPTFnKBnuf4xaZ1J+yWlCCoVLS6SqZbZs4ORlptdJGlyjpWWSIWH9WgTDTQxjPgfHyyDx6hzL+KWdkBfV+yadAotck4ehdxUm3ZpOYLtow1bv0RFa737STezcJJhfU2bFL5pGQCdCflqF7ZdgmOkQMkAYW+EIdPWicK+i0/tTQ1ZRHd9unxiUxjJgiotX8EQHfBOgcSPLRhVyWHtY2iQc9WAgC0ZhwaRrQ1B45R33+zz3UduafctxqvstHp2/B/daTdGnFLL4R5PvntD/ubcmtTDoCGk3AmgV8ueiKA/S4Zu5qTXJAtyNf3TeZfqfsgknM/D06RQ+03eFF3w7OMgscgGH8VUFaNkl4Y6BIBXPvbtxu6PlvXXteFxs2Kx4wQveb/MckJP4KC4B+XSq4QpTPIrxi2yURwHRyuoK1O47YdPbKiEgra
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e18a5a-34b6-4d3f-4b4c-08d7629c6512
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 09:33:34.9250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wEVqB5Jc+fqOcH7FNTXqo6LukYo64xmW2C4LLeDT2+6CRoTULlHh43jPSgCtPUHslVJDOnob+L7PCjrZKdX6pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3165
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_02:2019-11-06,2019-11-06 signatures=0
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
 drivers/edac/edac_mc.c | 104 +++++++++++++++++++++++++++--------------
 1 file changed, 69 insertions(+), 35 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index dfc17c565d8f..042a4504bb7f 100644
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

