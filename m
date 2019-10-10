Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9372D3212
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2019 22:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfJJU0a (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Oct 2019 16:26:30 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:58572 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726533AbfJJU03 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 10 Oct 2019 16:26:29 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9AKKdOw030238;
        Thu, 10 Oct 2019 13:25:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=N2uqu+Qnba3IswTa1pnNNPslszam59IMkKuf3/phQfM=;
 b=B+6aWpCbgDkjKX5zsddxVEMSXfEiUEASxna7auJdpfbi7U5Ctuhotk8vjqLXJZBDuExn
 EIrFLntFOAmTTHAVBmV0xlnZzA1US58r5zTzfEQiy1CkVTB/caJFDrS5BmwTXGcrCgF/
 ynLHeEo4t5DxmgNbQYZgELooW9oJL49FdP3gQq32PgQ0X20TgVgPoAWNB85gvFcuFL5j
 YgGVPapzpQwL2y2n/wW9HyTea9ZdM1nvtDrd0UhYpEhXT8OGH9sQxv3AtFCMBag029yR
 tjDVD/xIlcEolkZOnIiGUuyhRZEoMtDdVyreNBE1F0EmzOdgwfCMbaNkMPqrNljUcDAx kg== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2vj66h1gd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 10 Oct 2019 13:25:25 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 10 Oct
 2019 13:25:24 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.59) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 10 Oct 2019 13:25:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ov5rqz2kQndidzt1QgGLwk734nsPdzgVRSX3uIlc9NpfnKqKz7Xfj+Xk+QQqJ4qM6fUjSuPlOcIQaegEQR6Xyb3fqAMudkjrVRK38Sq2koaa6qeBvmrdI6Om8CsCFkcSyULLDVv6ZIkmBhmJSNKGaKE+VVYfRxMWE0u9aToyTT4vqHha5D1WpNnWSCrFek534lZH0IjYJ9xv/gdWlPVwEyjjWcfs0rqZmO9QO38qOVfGNvWEARHPW+o1UzEHLd346N5bKwyirkBsMy9NMzDc699Dbh6x6FYMn4Jw49aWoINh05U4zPzgFA0mCUA2RZNmY/UgIbgtHHUK/D9MYtPTYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2uqu+Qnba3IswTa1pnNNPslszam59IMkKuf3/phQfM=;
 b=C3kbCJEkE72G04tMOJigbWVcLtdULTH05SxwZwfif5ykqyCyxxFGk+Y15pr0iJnOUfWIfO7PRswoTn/lWhXsU9tv6RXIqjRi9Wz4nlrg5iGlJbFEkcLTtbD/eqZe8RdILSkWk4wDY3jEyZiTKW8M7CdA9jUHPguEjAQOU0TrmalAOlJTXpr0zcHPvDjcw7rnIH+rkPKAi2TTWYbm74qHrqQPhsPAOjpIjecLVV08M6VVWOv9JvQGzhMsXXkuDQ07IR21CKWaQWSTcGgP/aalYyLAZgCCakmt+dQ713+C91K+37u/uSqoydlkBYXs7H7pq8gmCmQMB9vRQFSqvvL7tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2uqu+Qnba3IswTa1pnNNPslszam59IMkKuf3/phQfM=;
 b=vbt0vgKcekfcdnBzfq0ynUWZ2USYaZD9CkmrKyorL6wl7hq5RoIQmu1oGZzVrTr+48kKN2sQXjjJJoaMsbKFFAxZMVF9aoTIQqC2R/4p1kZOSJFhuD4DrlPcEWJXpNDTwRSDiTApXrYX8le7MYWmhlSAS6CL5GyYfZgUv4jmvig=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2447.namprd18.prod.outlook.com (20.179.82.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 10 Oct 2019 20:25:22 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763%3]) with mapi id 15.20.2327.026; Thu, 10 Oct 2019
 20:25:22 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 09/19] EDAC, mc: Reorder functions edac_mc_alloc*()
Thread-Topic: [PATCH 09/19] EDAC, mc: Reorder functions edac_mc_alloc*()
Thread-Index: AQHVf6jX2nV+CnUHXEebQWDfti6qOQ==
Date:   Thu, 10 Oct 2019 20:25:22 +0000
Message-ID: <20191010202418.25098-10-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: cad8a9fa-0e9d-4960-9223-08d74dbff9dd
x-ms-traffictypediagnostic: MN2PR18MB2447:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB244712A612B76638A7939A4BD9940@MN2PR18MB2447.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 018632C080
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(199004)(189003)(6512007)(476003)(8936002)(25786009)(50226002)(8676002)(81156014)(81166006)(7736002)(305945005)(256004)(486006)(14454004)(2616005)(6436002)(86362001)(66066001)(36756003)(66946007)(66476007)(66556008)(64756008)(66446008)(11346002)(446003)(71190400001)(71200400001)(6486002)(186003)(478600001)(5660300002)(386003)(316002)(3846002)(26005)(4326008)(6116002)(2906002)(52116002)(76176011)(99286004)(54906003)(110136005)(6506007)(102836004)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2447;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zR7AhDaRQvSuL6E5NbQYDh4jCzINr/jzLlHlmyMejgsmi9SyQZzYMlf6emcNqrDfAtiRDd6L6OB8yr7XC0OkdNorHT3Pcm9I/vAwa1obE0gxLwJ7WftGQfMOMPNccON2r9reg5X/l5DR6v/iy8d4hSTmZ5l774qNFSLNem1o/Mw8Erbn23VT9S76mQ6Gs6SRfQ7yHMVAR36Zf3ZZCfPtGYBdCDw5mHoSb/UmHllhxwrswegipXGjyBPEau2THw4a17XF+nCBHkpbkXAC02glOHObnoXGYABW/jEXwbUO6IWBnAvQw6vLnAFXP3/FWooOAT6srDcZOpuzza9ApGK8LC/PnM+53AGx6CqPJlvECsNHmFoydXbDjgupvTL2km+njKliXfs4TM3vmeOa8snA7/iFeb+0ouPWN2vNQvO4swQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cad8a9fa-0e9d-4960-9223-08d74dbff9dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 20:25:22.6312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hllZnEMuLvDy8RbggeKLJBVOwTei8PcxV3c1ypaxqs0HUoBNWBF4hFC5MMXMd8m1cuOTaoLYyPloMovlVPtyhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2447
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-10_07:2019-10-10,2019-10-10 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Reorder the new created functions edac_mc_alloc_csrows() and
edac_mc_alloc_dimms() and move them before edac_mc_alloc(). No further
code changes.

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/edac_mc.c | 171 ++++++++++++++++++++---------------------
 1 file changed, 84 insertions(+), 87 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 0db504cb3419..6d880cf4d599 100644
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

