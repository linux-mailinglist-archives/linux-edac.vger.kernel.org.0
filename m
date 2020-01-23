Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E299D14640B
	for <lists+linux-edac@lfdr.de>; Thu, 23 Jan 2020 10:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgAWJDG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Jan 2020 04:03:06 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:65526 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726118AbgAWJDF (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 23 Jan 2020 04:03:05 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00N90NZj023654;
        Thu, 23 Jan 2020 01:02:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=8n/1g3+9aiQeFRsM5MVfKqoi0hRutk4BizwXavVJwQY=;
 b=H/zH3l3vMW4rM+W/ftlta/wIYSxu8WsvywzKfxfzF+2Rl+qwCJKBVKAhPCLe+kF4poTa
 pzuXIS5PorzPckrf1KvMct/lPj7UJElZXaYXe3vZ2uZqLRNtJz6RbiFWDFZGF0gl9/Hu
 R4X647WpMB+jHWoXEiqkULwu9fUQFdt5nuQV4RE4HnK3yFdRI2IZ9sX3dLsok+qwdFV2
 eodxQl4LiDbAljkK3rN3w/xIP/ppBMd6OiqQjO+q4yF/8iyxmsE4s3kXKX5+ITjws+ge
 0TKTWeM6jgqsd6fSoYqKbFggtD1GM8aLNiRcQ3E4QpoSO16XBCaUYP66RFfCrOQwlG2b Ig== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2xq4x4gqv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 23 Jan 2020 01:02:54 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 23 Jan
 2020 01:02:53 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.50) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 23 Jan 2020 01:02:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyM5dvfXdk8II+ZG7Vpo9+hfeslqExYTrO78yWNsUD44iVFFJrBtajEbE4l/AWr90UvATbYs/9K0RhY4Mv61PwE0JtV1a6G+jtI7REtn/v4ebZicE7DGTcwWULnASxeYTteFFkehknbv2UNujAO3C7/TmlkQuhLm5M9fb/YbyXsWZ4quxcwWmY3pmlLRKaDQ9DNRbYQzJ9KacSei5Um7rSUrvedMhuxTDTTttLL9yhTTzRNMSZ++OjYAoT/3RVYbnEH6zwIpNGSdW4dztGwK7A3KDwqVjnEAfOHStVsN/iwWenjcIj3ayq5qs4omrUqsJgldxDu3nJskY1k7GDg+jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8n/1g3+9aiQeFRsM5MVfKqoi0hRutk4BizwXavVJwQY=;
 b=NmmxyBleYoeoxJ2KMmatfV65yo9T6eTkzbUmfUxeV03myC+fMRfPtXdZmvUDEMPqEK+8qhY0FJHKdo2UR3MWpcWjrW74jEldQGBUj0nTe+NYRzCuJ2eR5pIggVwo4gx7UC71Kz38dnGI+r3uToMBiRssO2LwOacYr692XEgFHNQhogfOAztR9LGygfSEcSGqvLuHylNFUWoyCmNVALbCwPeCRBVkE+s5YjOYB/n/AcxFlPDNWtsLcR4QhYkEmH6+zsLTDRIrBe9Yimqk8jOVxKSDocrKpWxPWQg4tYHWEe6R5FA7ivRjZ3tLHaDWoOLoqoaY9+S5txvBapnXv+RzkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8n/1g3+9aiQeFRsM5MVfKqoi0hRutk4BizwXavVJwQY=;
 b=TkYCUvnl49Rt9LdKhKOZnvpgZ+stoy3HqI4yKKF0rA/l7KKCpFVWWpvTa4IWAru5YCr5BDtMvNSi3/oQnVgz2078aeCWy8XFRUW0KFOLodwe0sKPhJ55WsYUcS/JTaMm2jFPdR+YAhSjLHdJ7W67RTvaGY/AN5l4QI/gLB9gqrY=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3247.namprd18.prod.outlook.com (10.255.237.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Thu, 23 Jan 2020 09:02:52 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea%7]) with mapi id 15.20.2644.028; Thu, 23 Jan 2020
 09:02:52 +0000
Received: from rric.localdomain (31.208.96.227) by HE1PR0902CA0010.eurprd09.prod.outlook.com (2603:10a6:3:e5::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend Transport; Thu, 23 Jan 2020 09:02:50 +0000
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
Subject: [PATCH v3 02/10] EDAC/mc: Reorder functions edac_mc_alloc*()
Thread-Topic: [PATCH v3 02/10] EDAC/mc: Reorder functions edac_mc_alloc*()
Thread-Index: AQHV0cvk9qjXYuG9WEiAcE89VHJTnQ==
Date:   Thu, 23 Jan 2020 09:02:52 +0000
Message-ID: <20200123090210.26933-3-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: 6edd91f5-0b80-4c1d-9aa0-08d79fe306ee
x-ms-traffictypediagnostic: MN2PR18MB3247:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB324758C9448800370722EFD2D90F0@MN2PR18MB3247.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(366004)(396003)(39850400004)(376002)(199004)(189003)(110136005)(66946007)(52116002)(6512007)(66476007)(66556008)(64756008)(66446008)(54906003)(478600001)(1076003)(5660300002)(956004)(2616005)(6486002)(6506007)(36756003)(2906002)(81156014)(8676002)(86362001)(26005)(81166006)(8936002)(71200400001)(4326008)(186003)(316002)(16526019);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3247;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hZhaIKaNTmJ03vJDUnMA8HoTXNDB1/QfyZfjMFCWsE4T2qDA4ptlwY7lIcMEF6DpYKegTI665OGaScp8FtAz5AQZ82e3MQnkhzWJtsrKo5CRSiUILgioX52eIVIfkxJxHoc5fHu7yEjkotGyMcsIs5D80dVOqU9ErLz4imPLdw2NhSYCKkOCCy35Za0+izIjQjL7Zd/duS4gOKHeNFZWuVmDp3tBv9/xDXNWYyZRlKPcIRg09/1beC8OxXOi9pOzOD3P3mIMKEcm3ZiyN/G1mfBnzfy4uqHkscodEjTbOgf/br6Aqg+O0A3zyLw4dsfzGbi3Hi5LthceZxqEmPTBfQG76gxMa5o1jNdtkYZvoBsUiI6Gqzb1GmoXvhPn3XbXAmB3Xa+Dqla9cmBaqBvxIoMN21KFsKUmUOZy+tr8NoGIgCkdt//mhfXV9s9sIQKl
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6edd91f5-0b80-4c1d-9aa0-08d79fe306ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 09:02:52.0796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kTS+zsZsIQ5vKUpr7GUVd5VNX9TpzMZ4HBcIewZb8JDdPfiEzg/wnaM8bTsLFSz2NMH1rkUDjeOc3VNum2rxYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3247
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-22_08:2020-01-22,2020-01-22 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Reorder the new created functions edac_mc_alloc_csrows() and
edac_mc_alloc_dimms() and move them before edac_mc_alloc(). No further
code changes.

Signed-off-by: Robert Richter <rrichter@marvell.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Acked-by: Aristeu Rozanski <aris@redhat.com>
---
 drivers/edac/edac_mc.c | 209 ++++++++++++++++++++---------------------
 1 file changed, 103 insertions(+), 106 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index d71006a4f07b..1e227e69e216 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -311,112 +311,6 @@ static void mci_release(struct device *dev)
 	kfree(mci);
 }
=20
-static int edac_mc_alloc_csrows(struct mem_ctl_info *mci);
-static int edac_mc_alloc_dimms(struct mem_ctl_info *mci);
-
-struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
-				   unsigned int n_layers,
-				   struct edac_mc_layer *layers,
-				   unsigned int sz_pvt)
-{
-	struct mem_ctl_info *mci;
-	struct edac_mc_layer *layer;
-	u32 *ce_per_layer[EDAC_MAX_LAYERS], *ue_per_layer[EDAC_MAX_LAYERS];
-	unsigned int idx, size, tot_dimms =3D 1, count =3D 1;
-	unsigned int tot_csrows =3D 1, tot_channels =3D 1, tot_errcount =3D 0;
-	void *pvt, *ptr =3D NULL;
-	int i;
-	bool per_rank =3D false;
-
-	if (WARN_ON(n_layers > EDAC_MAX_LAYERS || n_layers =3D=3D 0))
-		return NULL;
-
-	/*
-	 * Calculate the total amount of dimms and csrows/cschannels while
-	 * in the old API emulation mode
-	 */
-	for (idx =3D 0; idx < n_layers; idx++) {
-		tot_dimms *=3D layers[idx].size;
-
-		if (layers[idx].is_virt_csrow)
-			tot_csrows *=3D layers[idx].size;
-		else
-			tot_channels *=3D layers[idx].size;
-
-		if (layers[idx].type =3D=3D EDAC_MC_LAYER_CHIP_SELECT)
-			per_rank =3D true;
-	}
-
-	/* Figure out the offsets of the various items from the start of an mc
-	 * structure.  We want the alignment of each item to be at least as
-	 * stringent as what the compiler would provide if we could simply
-	 * hardcode everything into a single struct.
-	 */
-	mci =3D edac_align_ptr(&ptr, sizeof(*mci), 1);
-	layer =3D edac_align_ptr(&ptr, sizeof(*layer), n_layers);
-	for (i =3D 0; i < n_layers; i++) {
-		count *=3D layers[i].size;
-		edac_dbg(4, "errcount layer %d size %d\n", i, count);
-		ce_per_layer[i] =3D edac_align_ptr(&ptr, sizeof(u32), count);
-		ue_per_layer[i] =3D edac_align_ptr(&ptr, sizeof(u32), count);
-		tot_errcount +=3D 2 * count;
-	}
-
-	edac_dbg(4, "allocating %d error counters\n", tot_errcount);
-	pvt =3D edac_align_ptr(&ptr, sz_pvt, 1);
-	size =3D ((unsigned long)pvt) + sz_pvt;
-
-	edac_dbg(1, "allocating %u bytes for mci data (%d %s, %d csrows/channels)=
\n",
-		 size,
-		 tot_dimms,
-		 per_rank ? "ranks" : "dimms",
-		 tot_csrows * tot_channels);
-
-	mci =3D kzalloc(size, GFP_KERNEL);
-	if (mci =3D=3D NULL)
-		return NULL;
-
-	mci->dev.release =3D mci_release;
-	device_initialize(&mci->dev);
-
-	/* Adjust pointers so they point within the memory we just allocated
-	 * rather than an imaginary chunk of memory located at address 0.
-	 */
-	layer =3D (struct edac_mc_layer *)(((char *)mci) + ((unsigned long)layer)=
);
-	for (i =3D 0; i < n_layers; i++) {
-		mci->ce_per_layer[i] =3D (u32 *)((char *)mci + ((unsigned long)ce_per_la=
yer[i]));
-		mci->ue_per_layer[i] =3D (u32 *)((char *)mci + ((unsigned long)ue_per_la=
yer[i]));
-	}
-	pvt =3D sz_pvt ? (((char *)mci) + ((unsigned long)pvt)) : NULL;
-
-	/* setup index and various internal pointers */
-	mci->mc_idx =3D mc_num;
-	mci->tot_dimms =3D tot_dimms;
-	mci->pvt_info =3D pvt;
-	mci->n_layers =3D n_layers;
-	mci->layers =3D layer;
-	memcpy(mci->layers, layers, sizeof(*layer) * n_layers);
-	mci->nr_csrows =3D tot_csrows;
-	mci->num_cschannel =3D tot_channels;
-	mci->csbased =3D per_rank;
-
-	if (edac_mc_alloc_csrows(mci))
-		goto error;
-
-	if (edac_mc_alloc_dimms(mci))
-		goto error;
-
-	mci->op_state =3D OP_ALLOC;
-
-	return mci;
-
-error:
-	_edac_mc_free(mci);
-
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(edac_mc_alloc);
-
 static int edac_mc_alloc_csrows(struct mem_ctl_info *mci)
 {
 	unsigned int tot_csrows =3D mci->nr_csrows;
@@ -545,6 +439,109 @@ static int edac_mc_alloc_dimms(struct mem_ctl_info *m=
ci)
 	return 0;
 }
=20
+struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
+				   unsigned int n_layers,
+				   struct edac_mc_layer *layers,
+				   unsigned int sz_pvt)
+{
+	struct mem_ctl_info *mci;
+	struct edac_mc_layer *layer;
+	u32 *ce_per_layer[EDAC_MAX_LAYERS], *ue_per_layer[EDAC_MAX_LAYERS];
+	unsigned int idx, size, tot_dimms =3D 1, count =3D 1;
+	unsigned int tot_csrows =3D 1, tot_channels =3D 1, tot_errcount =3D 0;
+	void *pvt, *ptr =3D NULL;
+	int i;
+	bool per_rank =3D false;
+
+	if (WARN_ON(n_layers > EDAC_MAX_LAYERS || n_layers =3D=3D 0))
+		return NULL;
+
+	/*
+	 * Calculate the total amount of dimms and csrows/cschannels while
+	 * in the old API emulation mode
+	 */
+	for (idx =3D 0; idx < n_layers; idx++) {
+		tot_dimms *=3D layers[idx].size;
+
+		if (layers[idx].is_virt_csrow)
+			tot_csrows *=3D layers[idx].size;
+		else
+			tot_channels *=3D layers[idx].size;
+
+		if (layers[idx].type =3D=3D EDAC_MC_LAYER_CHIP_SELECT)
+			per_rank =3D true;
+	}
+
+	/* Figure out the offsets of the various items from the start of an mc
+	 * structure.  We want the alignment of each item to be at least as
+	 * stringent as what the compiler would provide if we could simply
+	 * hardcode everything into a single struct.
+	 */
+	mci =3D edac_align_ptr(&ptr, sizeof(*mci), 1);
+	layer =3D edac_align_ptr(&ptr, sizeof(*layer), n_layers);
+	for (i =3D 0; i < n_layers; i++) {
+		count *=3D layers[i].size;
+		edac_dbg(4, "errcount layer %d size %d\n", i, count);
+		ce_per_layer[i] =3D edac_align_ptr(&ptr, sizeof(u32), count);
+		ue_per_layer[i] =3D edac_align_ptr(&ptr, sizeof(u32), count);
+		tot_errcount +=3D 2 * count;
+	}
+
+	edac_dbg(4, "allocating %d error counters\n", tot_errcount);
+	pvt =3D edac_align_ptr(&ptr, sz_pvt, 1);
+	size =3D ((unsigned long)pvt) + sz_pvt;
+
+	edac_dbg(1, "allocating %u bytes for mci data (%d %s, %d csrows/channels)=
\n",
+		 size,
+		 tot_dimms,
+		 per_rank ? "ranks" : "dimms",
+		 tot_csrows * tot_channels);
+
+	mci =3D kzalloc(size, GFP_KERNEL);
+	if (mci =3D=3D NULL)
+		return NULL;
+
+	mci->dev.release =3D mci_release;
+	device_initialize(&mci->dev);
+
+	/* Adjust pointers so they point within the memory we just allocated
+	 * rather than an imaginary chunk of memory located at address 0.
+	 */
+	layer =3D (struct edac_mc_layer *)(((char *)mci) + ((unsigned long)layer)=
);
+	for (i =3D 0; i < n_layers; i++) {
+		mci->ce_per_layer[i] =3D (u32 *)((char *)mci + ((unsigned long)ce_per_la=
yer[i]));
+		mci->ue_per_layer[i] =3D (u32 *)((char *)mci + ((unsigned long)ue_per_la=
yer[i]));
+	}
+	pvt =3D sz_pvt ? (((char *)mci) + ((unsigned long)pvt)) : NULL;
+
+	/* setup index and various internal pointers */
+	mci->mc_idx =3D mc_num;
+	mci->tot_dimms =3D tot_dimms;
+	mci->pvt_info =3D pvt;
+	mci->n_layers =3D n_layers;
+	mci->layers =3D layer;
+	memcpy(mci->layers, layers, sizeof(*layer) * n_layers);
+	mci->nr_csrows =3D tot_csrows;
+	mci->num_cschannel =3D tot_channels;
+	mci->csbased =3D per_rank;
+
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
 void edac_mc_free(struct mem_ctl_info *mci)
 {
 	edac_dbg(1, "\n");
--=20
2.20.1

