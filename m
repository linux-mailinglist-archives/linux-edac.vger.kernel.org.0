Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE92113E21
	for <lists+linux-edac@lfdr.de>; Thu,  5 Dec 2019 10:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbfLEJiL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 5 Dec 2019 04:38:11 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:29260 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726384AbfLEJiL (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 5 Dec 2019 04:38:11 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB59bKkW023619;
        Thu, 5 Dec 2019 01:38:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=VLw/rMyY0DRRcoTdhPTeXFSd28qQbBSgE+KDk2nrgWw=;
 b=lZhMENemMHEzlBUR7m31FaRz8SWAD05+RvDz8i/CgLOJlNFSbNv4tKECjt6FCeR2dRba
 DfQ6lasBumUs26OUrDB8lTM2vTQWgkyeHIzZ3FkbBqH4NgfXtvBH+B7e4i3THKCKsoiC
 iZ4BafQ5anMSMx0CARXF2SLkgJwLJxTGupZ9ST2ttLXYhti8CF09k38BqKJwV5V4EZjr
 1tKKcDl0VwXchpe/GQVb/teuOsdmKv42Eh30GOr8Veyat3mOlA2jKe9MYxh/1gCeMPgw
 OvgVUXX3mOVGQPt5cd0JGe4AdApKUm+Zl5pDIJgT05InOWTCH4r99BhXyJrpztUjiwtm RQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2wnvgvrcyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 05 Dec 2019 01:38:03 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 5 Dec
 2019 01:38:02 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.55) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 5 Dec 2019 01:38:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4cYMYSZpVhtsi6ceQjuTvefXsudLZTl/wUoQ28/hexNFt5so65mzX7Jk6H8/54ZdXIMbA1NJzUkFqtb0ey54zlXpN+ovaeGjTPW5nWdAkgr2aHu2ogB7ksbL9yiKK/42of3AhYQGeTZo3ieZ+pLTPIIaREcANR59f+Re2ifV2GN6fVMTH2fa4+B6xEepT/2mnEo1X2VaW0EInwhPeQR1wLDXmCMssTnpXGgcGSWMYpEB6jbuHVG5e09uhcwHwbRDwlgSWeohGKr8eqzar9P8QTLirbLanyIG14YPVK8hoK2Mdvmj2vpJZ2cr3xyEySlcYwRe1wpw/Vmuq6U2r78Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLw/rMyY0DRRcoTdhPTeXFSd28qQbBSgE+KDk2nrgWw=;
 b=lBDNyMhjCTvp3sRQ9OLH2f+fMydq9tauLoKD4aq/ZUMtfhpY3+RN7C3pgT5o7QDClPqZ92sEitJOOm2Gzw8PGrlo2Xy9DgeEmIG0HkrIQVf2OOOMjY2+KhEjHN0gbfyIZAFAQVZZUmvDbOu7gH4++/ZpVX6dsGB3CZ3udutOno0EhQEENrQhQT0sSR78qYjFVDAJNrvPUqb1P/U9hyX9L6RQudrxdQjSGdeqMSSqxjrvh+mh10oshDpLjqXpyznLdeHMNVhLp4PKVewtdrMDAq3tZHPA4oaSTdAcDtiQAuKnwmvN1KiTp+1g3MToIpMGEDVBmqDqWJLUMVdjNAZnXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLw/rMyY0DRRcoTdhPTeXFSd28qQbBSgE+KDk2nrgWw=;
 b=PBy39npwdrCzxuPmwFnIZNdyUuLhPKHZXd6myh7AiAI5e18POnRfvzX/KJf2S+ql9r9ooWJwovB6Yb/HuyIIPXxgrL4Zr2CVXhVVcl5ZZAg6C2sZhGWP4ru0m/VdEgNjG4DewP+l1us6MBnlAUoRPFWH2WGtGL8SOLzFYJT61Sc=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2367.namprd18.prod.outlook.com (20.179.80.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Thu, 5 Dec 2019 09:37:59 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106%7]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 09:37:59 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>
Subject: [PATCH v2 02/10] EDAC/mc: Reorder functions edac_mc_alloc*()
Thread-Topic: [PATCH v2 02/10] EDAC/mc: Reorder functions edac_mc_alloc*()
Thread-Index: AQHVq0+uGfP8zCioCUSQF9fluRdaUw==
Date:   Thu, 5 Dec 2019 09:37:59 +0000
Message-ID: <20191205093739.4040-3-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: e4a4d1fe-3d2d-4681-0542-08d77966d100
x-ms-traffictypediagnostic: MN2PR18MB2367:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB236706C9C76C830E222F47A7D95C0@MN2PR18MB2367.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(189003)(199004)(81166006)(14454004)(36756003)(6512007)(316002)(478600001)(54906003)(5660300002)(110136005)(186003)(8936002)(50226002)(6486002)(26005)(99286004)(66556008)(66476007)(81156014)(71190400001)(86362001)(66946007)(66446008)(64756008)(25786009)(8676002)(2906002)(71200400001)(6506007)(4326008)(2616005)(11346002)(102836004)(305945005)(1076003)(76176011)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2367;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5S3435aybNtop0djMBNfRFm9TsCsNv6xVu7TZNIusKdQPOkwfxntMPoJhQceajqSAk4p//r/jtQCPriTUqMPMXU2gLl2TCNBHevtlOocoyFR98TuJ65Cz8FQNJLTCPq9mPIrpKHm+Ksl59cQMwG1qGaKORLcXBQ/ZT3jGKIaMsLZmaKtlsfrqFklAwF+8mx+AWMzsHqXdQPVmYaXnJBSfvOEppexHiQgVqRsp5/bDW2R55RzkWz/WNkqk2a7cwn1rWu48mKUwvwNEynGlTqBu9RmiCvaMrrdUPk8k4tkDtxL/h5DJq7sui7+KJ8RIVFOxWtxpQmRe9Tc0wUZ8bKSnIyplowe0AdtNTDQHggtNfUrttfX7cjiGOpncBW8n2tVAtyFB3MwILCu+oKsyzNHQEuNZn3p9CzQd6aWjYI3bVQ3jp1zmQ7++rFxXmqOqVKB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a4d1fe-3d2d-4681-0542-08d77966d100
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 09:37:59.8098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HUA/v1cdphRuQdvIgihqna1nouLpJeoTaddky/dDZ3RNvoY8ri0mGIIPi0o6fXUfGGZzG9OW0qLpseWIg4d/Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2367
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-05_01:2019-12-04,2019-12-05 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Reorder the new created functions edac_mc_alloc_csrows() and
edac_mc_alloc_dimms() and move them before edac_mc_alloc(). No further
code changes.

Signed-off-by: Robert Richter <rrichter@marvell.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/edac/edac_mc.c | 203 ++++++++++++++++++++---------------------
 1 file changed, 100 insertions(+), 103 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 9068287604dd..f2dee4e8ba85 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -305,109 +305,6 @@ static void _edac_mc_free(struct mem_ctl_info *mci)
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
@@ -536,6 +433,106 @@ static int edac_mc_alloc_dimms(struct mem_ctl_info *m=
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

