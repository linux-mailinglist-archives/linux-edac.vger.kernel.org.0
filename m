Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7255CF124A
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2019 10:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbfKFJdr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Nov 2019 04:33:47 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:35586 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731762AbfKFJdq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 6 Nov 2019 04:33:46 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA69UIxP002503;
        Wed, 6 Nov 2019 01:33:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=oHO92d7KGndljACQeZ/Sx00cl4+R7rl70yEiWGIEkHM=;
 b=CS5LhbNVDn5asvEfA24l+JLZ6bLUsHn2iuJgfwLWa832zGUtUioy207hq/4I+dbwbbpM
 mR+S1Zw5Mwq2cX+tbD3oYEkjg6EM4SoNxmzOScP80bHU2JGcPhlA+uvtxUJvNDBuwnxK
 ORaulRFg2iQz9UAUqHgke3Ys2adqqHSZj3bsNoOiYDZXq/P4wFotfgg/nDgYW1TmcTti
 HZk7EFtRAy/Bp7HJkiX3FC3ss9lx0ERYgfytkXSNFPzf8EFr2GtFbgUznq2j9/NfJxY8
 Rk8QKppqZbDnyd1yhvEk9tBpGuamtvAxl5+2WNzAhkMgFWWyWgUimAC+2oS6NY7dt74m LA== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2w3eud3c8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 01:33:39 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 6 Nov
 2019 01:33:38 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.52) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 6 Nov 2019 01:33:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4/MWgCYIHv/iNEXytDcaShJfKF4W3vXfxctdZQ8YufaVUwLfC7/7A5vY0MLWB/0bqX4xLGLtEMtHliGbK/EKg8N/fj7ls2kdbkgm2LHkC3mJZkuEwzou3yxD2cxzI3O4sp7BPIVtFDUG2mqWsjJ+HBH8SHlt5BToAd99l+a0viQrMk0TLwrOpxfs247HUvHJVMEpTkyoa9wF6c+7bnq5Zw2p2MLDa1OwtVwlmgpDz3+4hray31JXf0U+7v9ACcIaUGTGnS8U0pNf4XguMMr9KJkIBJTD2OYyWXY3ufRSMzlHMinfbSMhB49aZH+JUyt+wtuu5E52zlaRUcWXArO8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHO92d7KGndljACQeZ/Sx00cl4+R7rl70yEiWGIEkHM=;
 b=XtuMKRN3yUIWjZuUsJ+IiXDRpVTatZaZe8ZeaB13h1kWKHD5iTWc7Ki9ksfCdIPN0amNVxFqzgo6aiZvCEK7PRwBYgj3sr+ADsbFpWQWMRMZ35jO0bg1aQW19fV5dXQLIdjsMxQuBTfCRiaSNhMw4bOJ9CZmd5NCLCobltogWw90d1ZkRLUZ09FJnkaf8wCCc1mOw+kdT+rf8fpZzmEZ6t6b+/CFeZDogwtnbJTLBNqE9l4Ux8mdUJmCjxbSKt7cvUi+B1wA8/1D4bmkq5moF2Km3Veg8e9d4+txsCAAbkqA0PPuWDR+Xe51cYz1rg5l/guKb7hmfJbwehS1tN6G7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHO92d7KGndljACQeZ/Sx00cl4+R7rl70yEiWGIEkHM=;
 b=oe9hZaVgLiIbotatMOs3daDUW51d0jPteHZutTkMQVuVN1dfBxNAvY2nFfzSKKn/T/mRgujrLyfn2/Ala0jAfEUJ3U5us12s6csjW9yMRA/IZm5/esNPiWc3imFCL/5ekosEwJ3ufNfxeAHd9sAEWirMSqzDKvVHm5KpN/scBLc=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3165.namprd18.prod.outlook.com (10.255.236.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 6 Nov 2019 09:33:37 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6%6]) with mapi id 15.20.2430.020; Wed, 6 Nov 2019
 09:33:37 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>
Subject: [PATCH v2 16/20] EDAC, mc: Reorder functions edac_mc_alloc*()
Thread-Topic: [PATCH v2 16/20] EDAC, mc: Reorder functions edac_mc_alloc*()
Thread-Index: AQHVlIVEtGWzd75N5UyGMXXJHwKI3g==
Date:   Wed, 6 Nov 2019 09:33:37 +0000
Message-ID: <20191106093239.25517-17-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: 463f5088-f9a2-416d-bd2f-08d7629c6670
x-ms-traffictypediagnostic: MN2PR18MB3165:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB3165E37137264955814210BFD9790@MN2PR18MB3165.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(199004)(189003)(52116002)(305945005)(6486002)(76176011)(71190400001)(71200400001)(256004)(11346002)(446003)(7736002)(6436002)(4326008)(6512007)(66446008)(66556008)(66476007)(66946007)(64756008)(5660300002)(1076003)(476003)(6116002)(3846002)(110136005)(54906003)(36756003)(2906002)(8676002)(99286004)(81166006)(81156014)(316002)(8936002)(50226002)(486006)(6506007)(386003)(102836004)(66066001)(2616005)(86362001)(478600001)(25786009)(186003)(14454004)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3165;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WtJGPrew3L5TSGkTFMnq+FBzCTTe7/xIqqceEusermJf6T8m1WUgG75C+JRgnwjx5/l/CgTBpCZ7+X75DQhmcR14YApkbTbnSgT7+fhzwyQxpME/reFHLJe4eURH0HUyJtI+jSF4rB5T6kkoYLsGs0zA+EYKHoM6u/RT+BKQnNHllJml7gc+LJECLllCQ56+bwfeJCVAJTSBaRBCnAyqZaTRSIcWDyDeanE+b4cPYS1999yGGZsm8jrS/1jT8jqqm8qFYQjCB/RyowBK67e8O2FFvxhmla2t60L/HVW6Zf/fNJhWZ4wDoVjlMPns48saSjWo/mDCYvfgAmSOtSaLaUFABmCamCZ0AjNJstVSGETANOwOYP51nocKmYGN9WqVdPViqi27pOpgOX/EfdigWs7dc3At/4E60ZuvRs3Zpr84DORWZ/IeOJrYRemNwEDp
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 463f5088-f9a2-416d-bd2f-08d7629c6670
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 09:33:37.1627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uKHgLulGvfQjVYt6HLv8H+DCxEjzBbogtt8rfScv1II6Cd0dTAsw58+55CXllfEOMaS1f6gBOEk97Hddh+q0oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3165
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_02:2019-11-06,2019-11-06 signatures=0
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
 drivers/edac/edac_mc.c | 171 ++++++++++++++++++++---------------------
 1 file changed, 84 insertions(+), 87 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 042a4504bb7f..bbe37af487c3 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -305,93 +305,6 @@ static void _edac_mc_free(struct mem_ctl_info *mci)
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
-	unsigned int idx, size, tot_dimms =3D 1;
-	unsigned int tot_csrows =3D 1, tot_channels =3D 1;
-	void *pvt, *ptr =3D NULL;
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
-	mci	=3D edac_align_ptr(&ptr, sizeof(*mci), 1);
-	layer	=3D edac_align_ptr(&ptr, sizeof(*layer), n_layers);
-	pvt	=3D edac_align_ptr(&ptr, sz_pvt, 1);
-	size	=3D ((unsigned long)pvt) + sz_pvt;
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
@@ -520,6 +433,90 @@ static int edac_mc_alloc_dimms(struct mem_ctl_info *mc=
i)
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
+	unsigned int idx, size, tot_dimms =3D 1;
+	unsigned int tot_csrows =3D 1, tot_channels =3D 1;
+	void *pvt, *ptr =3D NULL;
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
+	mci	=3D edac_align_ptr(&ptr, sizeof(*mci), 1);
+	layer	=3D edac_align_ptr(&ptr, sizeof(*layer), n_layers);
+	pvt	=3D edac_align_ptr(&ptr, sz_pvt, 1);
+	size	=3D ((unsigned long)pvt) + sz_pvt;
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

