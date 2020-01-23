Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F12914641D
	for <lists+linux-edac@lfdr.de>; Thu, 23 Jan 2020 10:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgAWJDE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Jan 2020 04:03:04 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:9916 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725785AbgAWJDE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 23 Jan 2020 04:03:04 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00N90NUB023659;
        Thu, 23 Jan 2020 01:02:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=pedOqumVxSGoX2bFMtAWzhQdSBjFihUwNsAHiW6zzqI=;
 b=LV2X6KgJhKuyNqZqzdZqy8Ye8bFQ4i91DU+1jkdYxaFS6ow2hpTPyUOTmM803L5/AOE7
 nYfd/Ly/EonmPtgvm/IZdgdMVOGq/FOd2IoB5258mDWHiYfsQz/gGGLbkyHKNVRkoGMO
 ggfClS0//kJ1Ax/Uey56G49glvXhGTHBsH97pAAWFlWOmxLn2PcFh1+Y7NlEoK9DiTp+
 yynf1K0SbmJbX41V6qx4LAqniCOQKK+b54y+t2/jMuDl3o13upXkiB1I/s6c6cF2jKeT
 /CBRghbvDtWUyZyH63h50Pi69MJ/zHooISe9BgtNsYiBDF0tFJD1iSuKz57w/jX54CFF OQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2xq4x4gqv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 23 Jan 2020 01:02:52 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 23 Jan
 2020 01:02:51 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.59) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 23 Jan 2020 01:02:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bftLAbcf2RrCREoNHo5Kwt2fHevS7AXM1KV+mt/ycJW1HzBblg2+krS8aNf5V/hXUfG2yX9/7xi7cd3zGP3tU5wlx1guQn8drOkazNQ6uINUq/Xjg4iunDSqY/9Rc3UOQCMdTLTIGr07kCP45BhOZUHUrfGHy2QTbbY35ihFUmqLkW1HU7QDclJTf1burMl1DPBEwWaV6jwSr3PfkdD20q/pAWCy/q0FJdx6ToUt59TBMZlKcxExs7QKgLBY+ZqWePgKNqm7oCXaXmOiVyjAX2i8yJhiGuK57PbJCA16df2t6YQbLwEDc3+uPvm+GrX6EaZblSa4xuHRQQmiMPylmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pedOqumVxSGoX2bFMtAWzhQdSBjFihUwNsAHiW6zzqI=;
 b=hOjtzUOiJOmFW7QVjXOH1OJ3bI7KyOANmxJIiYYaE1vxPQQ9HaFVJy2wrR7P/eNPwHW1beD8eZxqZxgvfX0y65FKGYZr52s/QvT1HIGZuDRnHjejE7EDMyb4ylBAESbnznIsLUBuAZDVbJy65E4Xb+SgCgk7f9bll6lTiUg+/ZrY9txqz3FvFEbF0oixDlZkrsYDZhMjRNBwHp1WlgCa/ehgBMXaYJCdaLwVvpnp+1r7Tfc4uMoHkV6bHZYxck15vEJL0AR1aprCIYEgaAn29aB53ADVE5oY1tCBEu3C7P1TFZZkAYlhUXkQVo7eg0PhPnhr8IaNVNuwqtgTp3YDTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pedOqumVxSGoX2bFMtAWzhQdSBjFihUwNsAHiW6zzqI=;
 b=dhY7+97oRKV7E3sZfT3cBe5iZ0Y4qqgb5BKI4Somz31dB9pDd4SjiU7fQwNnDJnqyiyQUD2ITg/NgBmoT/h08Vy1MikjUiKidQspGOAiG0BS/Qzy4NpAJe+HrxFuS4IHDpR+4qaHyA+zfdxWKShcc5FM076Y96p8IP47VWw5nwY=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3247.namprd18.prod.outlook.com (10.255.237.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Thu, 23 Jan 2020 09:02:50 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea%7]) with mapi id 15.20.2644.028; Thu, 23 Jan 2020
 09:02:50 +0000
Received: from rric.localdomain (31.208.96.227) by HE1PR0902CA0010.eurprd09.prod.outlook.com (2603:10a6:3:e5::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend Transport; Thu, 23 Jan 2020 09:02:48 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v3 01/10] EDAC/mc: Split edac_mc_alloc() into smaller
 functions
Thread-Topic: [PATCH v3 01/10] EDAC/mc: Split edac_mc_alloc() into smaller
 functions
Thread-Index: AQHV0cvj3aBJvZTSoUaEEl52GdoWtA==
Date:   Thu, 23 Jan 2020 09:02:49 +0000
Message-ID: <20200123090210.26933-2-rrichter@marvell.com>
References: <20200123090210.26933-1-rrichter@marvell.com>
In-Reply-To: <20200123090210.26933-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0010.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::20) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a00f06ba-074a-4c51-80e0-08d79fe305a0
x-ms-traffictypediagnostic: MN2PR18MB3247:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB324764B80CB7A2AD124D4E9ED90F0@MN2PR18MB3247.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(366004)(396003)(39850400004)(376002)(199004)(189003)(110136005)(66946007)(52116002)(6512007)(66476007)(66556008)(64756008)(66446008)(54906003)(478600001)(1076003)(5660300002)(956004)(2616005)(6486002)(6506007)(36756003)(2906002)(81156014)(8676002)(86362001)(26005)(81166006)(8936002)(71200400001)(4326008)(186003)(316002)(16526019);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3247;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zCWbeKss5OZhO+jZqVQwG5QYU0y31W5/ANIW2ljHU4CIfUkZPLmHMrVo/NsTjxI0aDKSnsaa5bVJuD9OS7H9WqWShV9gIokhnEBJ9RGBvBJ5lqBTv2gyo9xMNL6cgvkUZ2lQpaQXrecd/Xd3pnnO+iAmloBpCc85f4CAFdFqM03SBL2Wf2kAXXwJp+rnp7wp0Pyc127P7ICqcziq1SO3MvuN1+AA9+ry+q1g0ORr85TTgk1uNT1naktgFLZqGPBRluaf7aJArkY4w+7T8CLeg9a9+j+iqJfVyafgeXmKymGL4OUAImQ6JXHhU1lNc4y6be0iW3+hQ/RjQmZqELcVMRtVDb+IT0x+JxBUS4/2J8YshxkPW1Hs7AGLFDIXBFE0CLa97Myk1bKjyJxfcEcHz6r9Ke4y3lpcxKFfoper9APKnGSUUjonra8f6odBeIb1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a00f06ba-074a-4c51-80e0-08d79fe305a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 09:02:49.8680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LuUNTksxbCVsFP0yqMYkACKC4uyz/FFK2DlpgCYjbPAmRx/Gw1aE+CZKwNSk2RIbHLV+XHsRtA9l1luIpvOX6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3247
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-22_08:2020-01-22,2020-01-22 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

edac_mc_alloc() is huge. Factor out code by moving it to the two new
functions edac_mc_alloc_csrows() and edac_mc_alloc_dimms(). Do not
move code yet for better review.

Signed-off-by: Robert Richter <rrichter@marvell.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Acked-by: Aristeu Rozanski <aris@redhat.com>
---
 drivers/edac/edac_mc.c | 105 +++++++++++++++++++++++++++--------------
 1 file changed, 70 insertions(+), 35 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 058efcd9032e..d71006a4f07b 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -311,6 +311,9 @@ static void mci_release(struct device *dev)
 	kfree(mci);
 }
=20
+static int edac_mc_alloc_csrows(struct mem_ctl_info *mci);
+static int edac_mc_alloc_dimms(struct mem_ctl_info *mci);
+
 struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
 				   unsigned int n_layers,
 				   struct edac_mc_layer *layers,
@@ -318,15 +321,11 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_nu=
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
@@ -401,16 +400,43 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_nu=
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
@@ -418,34 +444,51 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_nu=
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
@@ -455,16 +498,16 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_nu=
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
@@ -476,39 +519,31 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_nu=
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

