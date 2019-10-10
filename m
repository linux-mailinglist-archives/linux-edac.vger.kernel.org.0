Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B718D31F0
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2019 22:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfJJUZ3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Oct 2019 16:25:29 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:21414 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726757AbfJJUZ2 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 10 Oct 2019 16:25:28 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9AKJujH025251;
        Thu, 10 Oct 2019 13:25:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=p+udCukPlPwswbWHZRjmj/wpHRMK1txYSnQh2Qv8kFU=;
 b=q5SfKuhYzfVD5iX5S77PjEUm58Y7ZfDMhTEPkMU2Jq2/Wv4EcSQoJ/lXAsfUgh75cFQd
 kSuC6tQ48Rs39j9zsWIl8+J9/739gk6gQJYChSHsKdpDnhHXGqdf+frA6W1D+J5St5FH
 rrrnTUdsmpnX6fNRhNliuUcs9AemgLjVsufMJzwq2ugfnYIyG0urZWjE28hc7b248fPz
 +hwE1YSPET1abBIGAx+IqQ3nkl3uCAIofDUA9zeBvb98mJnwZedZplPry/exsVTTn9b7
 15XB+EQdMQ6O1C7u2DYLy+wypKR8h0h/4bT6XtZGToz/Wf3OHsUJSLz5Z3PxdRoZR5aK Pg== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2vhdxbxqfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 10 Oct 2019 13:25:10 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 10 Oct
 2019 13:25:09 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.56) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 10 Oct 2019 13:25:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHl0nkjj9GGGS8QRQ1+xr3K0Wllwj7KJ0YG7k28LH2R0RMeATXegx5p7DSTJ+y+ZtQMqS+deHO7ch0lPvPAnfy6vbl2Un8O3mBl99aZSf14g8H+YhQuU413rvM2ENna2I17JbvWxWQO7QlwYXBvdQtxHoFwSbx9hJ8hsz8lEuV68VNPG6IaJ6JeYx2EgYAZvzS5ICiHYz1ViJa2If2pCBZAFwU+Du1Ayi4R/RfKong/Mmi0IR+ZiQnsrEWdqSgxh9glfna+23Gc1N1t4+zmu13crO3KpH/vVktl/IanJMq38v6Mh2tI2qZv6OB3GwlehxyKPhXis8lMMsjUQdlHm7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+udCukPlPwswbWHZRjmj/wpHRMK1txYSnQh2Qv8kFU=;
 b=WQ8FoUyBz6xWqsAsq0twOQ83B4n04Pg5X9M+PPnTsJbETRfCJIR1u9iC5PAgr/3XmHjzlbLxNcH7MTyTojo/x8DGk1AZRiqJVisRSU1IQHItNmBuXDv8rkoT7PLkXo7yyF7ZxGA39YiAFSjjenSS4OomzwL8iDEoHc9T+AY32qjF52CaXgtnL9QtRRZl3mtoDYrT0QAmqVJ2CtmiShP9Vbmwv5ZLrAUJZgOR95aGEPB0gYZSj6W72K+cxhUatW3ox4609i77+62epQ7Voggh3KDWPiwACo4sBI0Osu+Myp8irLm4aACv+sE2/eUjsJDh1qOR40xv55IoDNgbb8hbcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+udCukPlPwswbWHZRjmj/wpHRMK1txYSnQh2Qv8kFU=;
 b=XzK5LIBifME2Ow5N5Eegir+Gcwash1m605HofSIh9RoE+CIBZDAuZwhFeWfiLUdjBuSJGgeITHs9yV3K5Ogos9/elSwkmcrK1PjwgInEzqQ/3XWtyzB9/MSC71NqQfu1Fkr64Owp5SXZDODbPhqRFzerc7OLzXzQBtUvKCU3iiw=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2701.namprd18.prod.outlook.com (20.179.22.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Thu, 10 Oct 2019 20:25:07 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763%3]) with mapi id 15.20.2327.026; Thu, 10 Oct 2019
 20:25:07 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 02/19] EDAC: Remove EDAC_DIMM_OFF() macro
Thread-Topic: [PATCH 02/19] EDAC: Remove EDAC_DIMM_OFF() macro
Thread-Index: AQHVf6jOVfuHIna6UUqSRNg3t3vfNQ==
Date:   Thu, 10 Oct 2019 20:25:07 +0000
Message-ID: <20191010202418.25098-3-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: ecd990db-9d6d-47dd-5f65-08d74dbff129
x-ms-traffictypediagnostic: MN2PR18MB2701:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB27017ECE8A07482DA547D82AD9940@MN2PR18MB2701.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 018632C080
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39850400004)(346002)(136003)(366004)(376002)(189003)(199004)(6436002)(6512007)(54906003)(71190400001)(110136005)(14454004)(316002)(6486002)(86362001)(71200400001)(5660300002)(2906002)(66066001)(25786009)(50226002)(478600001)(11346002)(446003)(476003)(486006)(3846002)(6116002)(2616005)(99286004)(1076003)(6506007)(76176011)(4326008)(14444005)(386003)(7736002)(305945005)(52116002)(26005)(256004)(102836004)(81166006)(66946007)(36756003)(186003)(81156014)(66446008)(66556008)(8936002)(64756008)(8676002)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2701;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9fXmRy4L8O5IdHR537PFwf942EUrQizhJPONhiOTcCesqv7gZ76OJy2jPhGJEXXavMuGs/ZC8OBOrYIUIpydY7hglz83wUJuW7Th0nHpTg/tiwa8Omqd9umtwE5eoUgm/L7AoT3ZEKP/uslCeTunkdErKDiemrTUQRmYr4rvKoyb2yME7bBlf7BiZ39sxPz4qnXJlVxUJ89bjRAHsu2dfmt/dntWxrvNUEQcUAV/+mJF78U1c1Mi0yx8EQgseWTG9ri8aeXdlA4uDuk78yVxLvf812hGALNCDwyDl3anluVr12C8lfsdpKCQ+j1At9c/GGI+7fPJW1hFFHBM1npRzT9f2mqJ9oWUkT53JzV2SFJZlcwZTQVskmSs2NzVk6C5t6jH1XrgPiusp2tbANYgM9L4h4LcdLwmXdLCyuFTnU8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd990db-9d6d-47dd-5f65-08d74dbff129
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 20:25:07.7566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n7PrjCSY02bcRHKwbyARQrDCUcPUUlbNeIKslBXS9dSRlmvgn7TtjBM0hzhA00krMY0Q9EutBLuUvlwa+PCZBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2701
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-10_07:2019-10-10,2019-10-10 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The EDAC_DIMM_OFF() macro takes 5 arguments to get the DIMM's index.
This can be much simplified now as the offset is already stored in
struct dimm_info. Use it directly and completely remove the
EDAC_DIMM_OFF() macro.

Another advantage is that edac_mc_alloc() could be used even if the
exact size of the layers is unknown. Only the number of DIMMs would be
needed.

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/edac_mc.c       | 15 +++++--------
 drivers/edac/edac_mc_sysfs.c | 20 ++++--------------
 include/linux/edac.h         | 41 ------------------------------------
 3 files changed, 9 insertions(+), 67 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 3d45adb5957f..72088d49b03b 100644
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
@@ -425,20 +425,15 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_nu=
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
-		dimm->idx =3D off;
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
index 7f9804438589..79c5564ee314 100644
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
--=20
2.20.1

