Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B960D146412
	for <lists+linux-edac@lfdr.de>; Thu, 23 Jan 2020 10:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgAWJDW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Jan 2020 04:03:22 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:59964 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726194AbgAWJDW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 23 Jan 2020 04:03:22 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00N90NZo023654;
        Thu, 23 Jan 2020 01:03:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=1/1VyE4qVDic/12zoZ+vjTpTbyAl+zvDAL2VC6Q92g8=;
 b=kvImLrsh3FQsYBcjeiMuGCzrsECr1QYwbI8LDa3n6gUPkfxukylOQStZ6y+IdVuZpJnc
 pOR2l2ICnyah9WwiC+MemdUmfBxpz0Ds58/c6e929QFDxsZeBf4osyeuqTlVAY5u/GI6
 B9+MGch7hNuNHaXN3Y2LeUXjB2Haq3Uj1WpPKiUOxl01qNU5p2nwDFxrLTwEXZEXtcq4
 cKG2v5/grnsdb6DGZsJVqg9M0BefSS074UM0CRoLsf1ldY9Erp7A75cdR+2aUoIUjM0W
 4GT8fwhkB/sentDHH8331BwScgQKgidF1qAdEE2yNbauoFDNRHbUKS4KNVNdjBUFdpAV Xg== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2xq4x4gqwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 23 Jan 2020 01:03:11 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 23 Jan
 2020 01:03:10 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 23 Jan 2020 01:03:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1lYc1HhrdgRCtWC+TNvK2DBxKLDxAw3Qy8j5d0MMC1cjPui1pByKPRGd/OaEMBig+Xkp/XKeSS/g0kCX4yg+knlfM6LaXa4N5WDQWPJwUexduymYj5T8/xz42ssL2DaoZE6XfE0PIQcioCvvXO6io4ujIUHdrod0GHCq4nSirSolRKCXZ1F8yzX5gVe61xmtSd7g8qWX8x/nFsWXb/ZexVq1OO0Ra83priXqWWPhKNc/FXsoTZcErVRqdaedqKwRHfBYxfl5/k1/TcxYZxage+52LgPFF8izEQ76/H89OzTh3RKQ77575ImHY4jyGna7ADnTwTmKU9aEccZflSHqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/1VyE4qVDic/12zoZ+vjTpTbyAl+zvDAL2VC6Q92g8=;
 b=NRwAHqwOizTW/SItT00eSQzAZS1Lile51IdMv224FnYpCxctsrILVtrPzq/51l5dyeVmamUbclt4M0W2ycS1wjeOavkeKiqL4S6kzqnV0IzTAU2vx5lPdMyMy+Zui1FBxiLz3OdTdv3ZwosXNYwOISc+Cvr6v7PKnm/u543Y653m2I3cPLWqNdCpgPyax4/XFuo0TrKwiPeRmhoDt8VLO7Q+w2EEMxKK6pkeBoqgBs++JjyNmaAYbJqz4RoQqsZWc3st/g8lh8/bardi4yoAwu7BCHLgw0OxhulaBOpg6CD4zYVKxLDfxHtwvDWPIq5YUrq0pZpMRvgAbxFCHuQM5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/1VyE4qVDic/12zoZ+vjTpTbyAl+zvDAL2VC6Q92g8=;
 b=sj4vEiOHYWLOzRKLb4Na3TwwL5CUthujFpbccXUNAMPVi5k/VG8ymu4nZcxep/W+g6qPlEjaZfoQGpQ+usMHNGZf1bXVZp78o8ZR7ammsmCQ5wzewxcD6Br6ZsFKVJygO+d2nlUm1iSKZuJvX/bXGBVnScEHiSz9/ozp/SkYqRk=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3247.namprd18.prod.outlook.com (10.255.237.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Thu, 23 Jan 2020 09:03:09 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea%7]) with mapi id 15.20.2644.028; Thu, 23 Jan 2020
 09:03:09 +0000
Received: from rric.localdomain (31.208.96.227) by HE1PR0902CA0010.eurprd09.prod.outlook.com (2603:10a6:3:e5::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend Transport; Thu, 23 Jan 2020 09:03:07 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 10/10] EDAC/mc: Remove per layer counters
Thread-Topic: [PATCH v3 10/10] EDAC/mc: Remove per layer counters
Thread-Index: AQHV0cvu7j4bgx3XFUyxLBDaaQwKHw==
Date:   Thu, 23 Jan 2020 09:03:09 +0000
Message-ID: <20200123090210.26933-11-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: 1e4a2c63-a88d-4ac9-9c53-08d79fe3111e
x-ms-traffictypediagnostic: MN2PR18MB3247:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB32473F18FED01997A374666ED90F0@MN2PR18MB3247.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(199004)(189003)(110136005)(66946007)(52116002)(6512007)(66476007)(66556008)(64756008)(66446008)(54906003)(478600001)(1076003)(5660300002)(956004)(2616005)(6486002)(6506007)(36756003)(2906002)(81156014)(8676002)(86362001)(26005)(81166006)(8936002)(71200400001)(4326008)(186003)(316002)(16526019);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3247;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qNwX18BAkh82gGBMjvwiFHfFp1mtdIyfs93igOK31PG3Ag5cR05SmIqgdHWJOF8dlT2qGvzTR7kua+RgaYkOKpFS7o+UmNbIXKEuPvtoFHG2yHZRtN1aQMXReD6PkN1inI9n8aE/XT6LPMveWMuUtfa24lqStANip7J4/wS+9oTuYaNO1uUMD70p3zb2hqnPe35DOQA9By0eZoq2j/q2JWppLCboNca0kJ7OxVFrdSMLEEyy9hD5KrDnCfZid7edPpIqyfoE6D4r+luz87of8TxrWmaMs4dG77n+2+Y2pVa/06iN6ePgwjMk5QIpGVv1w4+hsUOzEJVTYZ1+N46u4HE3S2FHW2R3U+m5VTGOADopm6DGGAej7dIvNi1zBxUTrRXM3ava4Bj1ICLyeyym8znfjSzyxKbsPZx3JzVWmlqx72rw/k33vvZ8mz+C2bYi
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e4a2c63-a88d-4ac9-9c53-08d79fe3111e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 09:03:09.2364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kLTF2r+UtY/Xh1yf2cM4xPHbUKUEXZ1Hrkd+nM9l/yjgmbJdAWCcVQQzpsgbjjc4pRidC6bjk1SH30+WIhYctQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3247
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-22_08:2020-01-22,2020-01-22 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Looking at how mci->{ue,ce}_per_layer[EDAC_MAX_LAYERS] is used, it
turns out that only the leaves in the memory hierarchy are consumed
(in sysfs), but not the intermediate layers, e.g.:

 count =3D dimm->mci->ce_per_layer[dimm->mci->n_layers-1][dimm->idx];

These unused counters only add complexity, remove them. The error
counter values are directly stored in struct dimm_info now.

Signed-off-by: Robert Richter <rrichter@marvell.com>
Acked-by: Aristeu Rozanski <aris@redhat.com>
---
 drivers/edac/edac_mc.c       | 65 +++++++++---------------------------
 drivers/edac/edac_mc_sysfs.c | 20 +++++------
 include/linux/edac.h         |  4 ++-
 3 files changed, 26 insertions(+), 63 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 60639def8697..fbd9faa5c0f9 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -451,11 +451,9 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num=
,
 {
 	struct mem_ctl_info *mci;
 	struct edac_mc_layer *layer;
-	u32 *ce_per_layer[EDAC_MAX_LAYERS], *ue_per_layer[EDAC_MAX_LAYERS];
-	unsigned int idx, size, tot_dimms =3D 1, count =3D 1;
-	unsigned int tot_csrows =3D 1, tot_channels =3D 1, tot_errcount =3D 0;
+	unsigned int idx, size, tot_dimms =3D 1;
+	unsigned int tot_csrows =3D 1, tot_channels =3D 1;
 	void *pvt, *ptr =3D NULL;
-	int i;
 	bool per_rank =3D false;
=20
 	if (WARN_ON(n_layers > EDAC_MAX_LAYERS || n_layers =3D=3D 0))
@@ -482,19 +480,10 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_nu=
m,
 	 * stringent as what the compiler would provide if we could simply
 	 * hardcode everything into a single struct.
 	 */
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
+	mci	=3D edac_align_ptr(&ptr, sizeof(*mci), 1);
+	layer	=3D edac_align_ptr(&ptr, sizeof(*layer), n_layers);
+	pvt	=3D edac_align_ptr(&ptr, sz_pvt, 1);
+	size	=3D ((unsigned long)pvt) + sz_pvt;
=20
 	edac_dbg(1, "allocating %u bytes for mci data (%d %s, %d csrows/channels)=
\n",
 		 size,
@@ -513,10 +502,6 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num=
,
 	 * rather than an imaginary chunk of memory located at address 0.
 	 */
 	layer =3D (struct edac_mc_layer *)(((char *)mci) + ((unsigned long)layer)=
);
-	for (i =3D 0; i < n_layers; i++) {
-		mci->ce_per_layer[i] =3D (u32 *)((char *)mci + ((unsigned long)ce_per_la=
yer[i]));
-		mci->ue_per_layer[i] =3D (u32 *)((char *)mci + ((unsigned long)ue_per_la=
yer[i]));
-	}
 	pvt =3D sz_pvt ? (((char *)mci) + ((unsigned long)pvt)) : NULL;
=20
 	/* setup index and various internal pointers */
@@ -951,48 +936,28 @@ static void edac_inc_ce_error(struct edac_raw_error_d=
esc *e)
 {
 	struct mem_ctl_info *mci =3D error_desc_to_mci(e);
 	int pos[EDAC_MAX_LAYERS] =3D { e->top_layer, e->mid_layer, e->low_layer }=
;
-	int i, index =3D 0;
+	struct dimm_info *dimm =3D edac_get_dimm(mci, pos[0], pos[1], pos[2]);
=20
 	mci->ce_mc +=3D e->error_count;
=20
-	if (pos[0] < 0) {
+	if (dimm)
+		dimm->ce_count +=3D e->error_count;
+	else
 		mci->ce_noinfo_count +=3D e->error_count;
-		return;
-	}
-
-	for (i =3D 0; i < mci->n_layers; i++) {
-		if (pos[i] < 0)
-			break;
-		index +=3D pos[i];
-		mci->ce_per_layer[i][index] +=3D e->error_count;
-
-		if (i < mci->n_layers - 1)
-			index *=3D mci->layers[i + 1].size;
-	}
 }
=20
 static void edac_inc_ue_error(struct edac_raw_error_desc *e)
 {
 	struct mem_ctl_info *mci =3D error_desc_to_mci(e);
 	int pos[EDAC_MAX_LAYERS] =3D { e->top_layer, e->mid_layer, e->low_layer }=
;
-	int i, index =3D 0;
+	struct dimm_info *dimm =3D edac_get_dimm(mci, pos[0], pos[1], pos[2]);
=20
 	mci->ue_mc +=3D e->error_count;
=20
-	if (pos[0] < 0) {
+	if (dimm)
+		dimm->ue_count +=3D e->error_count;
+	else
 		mci->ue_noinfo_count +=3D e->error_count;
-		return;
-	}
-
-	for (i =3D 0; i < mci->n_layers; i++) {
-		if (pos[i] < 0)
-			break;
-		index +=3D pos[i];
-		mci->ue_per_layer[i][index] +=3D e->error_count;
-
-		if (i < mci->n_layers - 1)
-			index *=3D mci->layers[i + 1].size;
-	}
 }
=20
 static void edac_ce_error(struct edac_raw_error_desc *e)
@@ -1139,7 +1104,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
type type,
 	/*
 	 * Check if the event report is consistent and if the memory
 	 * location is known. If it is known, the DIMM(s) label info
-	 * will be filled and the per-layer error counters will be
+	 * will be filled and the DIMM's error counters will be
 	 * incremented.
 	 */
 	for (i =3D 0; i < mci->n_layers; i++) {
diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 408bace699dc..20657530a108 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -551,10 +551,8 @@ static ssize_t dimmdev_ce_count_show(struct device *de=
v,
 				      char *data)
 {
 	struct dimm_info *dimm =3D to_dimm(dev);
-	u32 count;
=20
-	count =3D dimm->mci->ce_per_layer[dimm->mci->n_layers-1][dimm->idx];
-	return sprintf(data, "%u\n", count);
+	return sprintf(data, "%u\n", dimm->ce_count);
 }
=20
 static ssize_t dimmdev_ue_count_show(struct device *dev,
@@ -562,10 +560,8 @@ static ssize_t dimmdev_ue_count_show(struct device *de=
v,
 				      char *data)
 {
 	struct dimm_info *dimm =3D to_dimm(dev);
-	u32 count;
=20
-	count =3D dimm->mci->ue_per_layer[dimm->mci->n_layers-1][dimm->idx];
-	return sprintf(data, "%u\n", count);
+	return sprintf(data, "%u\n", dimm->ue_count);
 }
=20
 /* dimm/rank attribute files */
@@ -661,7 +657,9 @@ static ssize_t mci_reset_counters_store(struct device *=
dev,
 					const char *data, size_t count)
 {
 	struct mem_ctl_info *mci =3D to_mci(dev);
-	int cnt, row, chan, i;
+	struct dimm_info *dimm;
+	int row, chan;
+
 	mci->ue_mc =3D 0;
 	mci->ce_mc =3D 0;
 	mci->ue_noinfo_count =3D 0;
@@ -677,11 +675,9 @@ static ssize_t mci_reset_counters_store(struct device =
*dev,
 			ri->channels[chan]->ce_count =3D 0;
 	}
=20
-	cnt =3D 1;
-	for (i =3D 0; i < mci->n_layers; i++) {
-		cnt *=3D mci->layers[i].size;
-		memset(mci->ce_per_layer[i], 0, cnt * sizeof(u32));
-		memset(mci->ue_per_layer[i], 0, cnt * sizeof(u32));
+	mci_for_each_dimm(mci, dimm) {
+		dimm->ue_count =3D 0;
+		dimm->ce_count =3D 0;
 	}
=20
 	mci->start_time =3D jiffies;
diff --git a/include/linux/edac.h b/include/linux/edac.h
index 815f246e0abd..0f20b986b0ab 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -383,6 +383,9 @@ struct dimm_info {
 	unsigned int csrow, cschannel;	/* Points to the old API data */
=20
 	u16 smbios_handle;              /* Handle for SMBIOS type 17 */
+
+	u32 ce_count;
+	u32 ue_count;
 };
=20
 /**
@@ -559,7 +562,6 @@ struct mem_ctl_info {
 	 */
 	u32 ce_noinfo_count, ue_noinfo_count;
 	u32 ue_mc, ce_mc;
-	u32 *ce_per_layer[EDAC_MAX_LAYERS], *ue_per_layer[EDAC_MAX_LAYERS];
=20
 	struct completion complete;
=20
--=20
2.20.1

