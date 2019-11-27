Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B24E10BFE2
	for <lists+linux-edac@lfdr.de>; Wed, 27 Nov 2019 22:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfK0VzO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 27 Nov 2019 16:55:14 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:1364 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728027AbfK0VzO (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 27 Nov 2019 16:55:14 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xARLo1ga005174;
        Wed, 27 Nov 2019 13:55:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=InJ5N6vRnP5n3sIEIV8kG7wCRQpHrDln1wBQos3mQ9Y=;
 b=MMXW1nXt8xoU2p6vbIdOp8FyUZcbHAhfHT+69Y/7Tk4DDLxOtxfl52SFjhK+ylQyTLqo
 kKYPBhh87+Mq5C4c/O7yrSd9EF0luLqgB2OeQna7WFmA4HlA5vte1gCyuyUuYS7R7p9y
 mnRUmaEjf8HE/jEZfAKQbc0kmzyhpOZJEMbikpFyHn2h7U186wxERdtq2XWxgropA3t8
 mGTLnb062lxCxGDIgoKdi+Nk1CXZ+7A4O9ZqHhbPN82I1Hqz3drkiAyiXh6qbKMSyZ5q
 Yy5+x+dbcoyuqPi+i3NOPjEF9Ga2n75Tr0xyh0Ncey9KgXpDwhuA9rMMlzyfaj5Iu7SJ cw== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2whd08mre9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 27 Nov 2019 13:55:08 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 27 Nov
 2019 13:55:06 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.57) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 27 Nov 2019 13:55:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=geNSD0etXjNVmaRc6PofxH2ofvpm1MsEmfuhqFz7QbobH28b2I8ZBiNPkvAqdHtdfodRnYPUxPWqe5px4/8BIRbD37SowRX/UJSfHX6uEAgloFYwAF/TFY5vYgB//jYaoPFhcCqhCAq8N6oeIotXqgo/ZNU3SP5gviv7HCNThI0QoyrI7dbIko5d17Wwf/3q5zq1ZyxKAv+I/wzpNxnfFsD9m4hCb77FMmW+JbLkycXWTg19zo+XBxh51K8QZmylK42ikQdQNysVgb/1YMNRaJuHC8C4sOYvubGtTaWduKTWFsciq8lS0CGj5VrpSXIV8/M2Nuj7vR8b51/OOmkhiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InJ5N6vRnP5n3sIEIV8kG7wCRQpHrDln1wBQos3mQ9Y=;
 b=nT2gQay5rdBVZ+sLYAUIFkOADzmMAYvsmhH1gy2twNouM9bHjD8FY+sEzgi18rlumn5sAXj4urYwNt38ZAK0iAd+22CVN5u28Xa+DzpDl/Aci1PXz+vMoC39CkHgbsuLJ7dT3PEuLA3zDxkwvbqvJFjc2WlEVdLVlKRJzupOUK/8AZRiUe8WShEhgdD13zi6bKo+ix/GzN9D+/k4w3Zz5JBTJwHqqu3zMwma+oZac6hcawlPerldgoBnU0J7b0ahgPj0OiW4ELcNW/cBmcqj6Y0XqAjoh99noO5TL0OLE85F3LRNsVgvWQSrN0oL8Ya2vZCzYSGrSsZnRWE4SyKXVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InJ5N6vRnP5n3sIEIV8kG7wCRQpHrDln1wBQos3mQ9Y=;
 b=h5kplN4nhQ9+eKJSjFM8z1XJiByclrDRsKQ8YBd2gx7TCBYOIOMaSNcf69ERI90J+r48xXkwmoSasrCmD918zOdKCviBXd9zBpqR7hA/n8oKmAPf0eyXZGLskTXhB5R9dX8SircOZnl79QKvKPxkkY9ARZ53dRjEXjYurqapTbY=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3197.namprd18.prod.outlook.com (10.255.239.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Wed, 27 Nov 2019 21:55:04 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106%7]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 21:55:04 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 10/10] EDAC/mc: Remove per layer counters
Thread-Topic: [PATCH 10/10] EDAC/mc: Remove per layer counters
Thread-Index: AQHVpW1T0iJ1g8BX90a0UOYHABW8HQ==
Date:   Wed, 27 Nov 2019 21:55:04 +0000
Message-ID: <20191127215415.11230-11-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: c6ea83aa-a3bc-423f-3410-08d7738475da
x-ms-traffictypediagnostic: MN2PR18MB3197:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB319775680C81B9D5CA964B35D9440@MN2PR18MB3197.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(189003)(199004)(52116002)(3846002)(66556008)(66476007)(6436002)(36756003)(11346002)(4326008)(102836004)(386003)(6506007)(316002)(54906003)(6512007)(2616005)(6486002)(99286004)(446003)(110136005)(6116002)(86362001)(25786009)(14454004)(1076003)(478600001)(256004)(66946007)(305945005)(7736002)(66066001)(76176011)(81156014)(8676002)(186003)(8936002)(50226002)(81166006)(2906002)(26005)(5660300002)(66446008)(64756008)(71200400001)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3197;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Oil/lCuQJkOrsauDaxiFzWZEts33fPfLVCvSDW52geveLUQC7eQt3ftv/BisXqxzOtynE8S33NNzmFY8bciSAhfXG+PwVob/auXwuEZZdl5AX454Ika3hYYuJc4+WwgzABUalFR/n/WUKkCZvZJKi0/uJcZb883ZY6I6ClGjkJJEshMF7tub9i4rDHWzYQRtZF9s17aElL4l3ue5sdb5ZXOtKapmurzC/qUH8GpURhZMu4uwx6hmA2bqXkKu24TMCz++m1XGJOt3p7hYE3OD+mIcieq0Bhsoj+3653Imo1LL8dT+8PtgvqYdGqG9BomzCH8qiB9IhkLGViK/1GjUCwyhLUO7wURna+2sTSHZE0fZ1SVY3Mi/zMwoTmlKb65qhKFUyCqLF2XbYPpe3uqul6VcfbxQx1yArXv9RIXyplzfviqJ8cH0JKfailXdzJYf
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ea83aa-a3bc-423f-3410-08d7738475da
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 21:55:04.7605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dX9KCRmSEtjL97SYIoX1wztixqrmsG2GzYz3b2Sd8X67m79ZSwYnFXPjUAbEAcF8E1z6VvhGRCqEyJkc6nSQ9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3197
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-27_04:2019-11-27,2019-11-27 signatures=0
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
---
 drivers/edac/edac_mc.c       | 65 +++++++++---------------------------
 drivers/edac/edac_mc_sysfs.c | 20 +++++------
 include/linux/edac.h         |  4 ++-
 3 files changed, 26 insertions(+), 63 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 5ea834fceb50..3d43b9fe8171 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -445,11 +445,9 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num=
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
@@ -476,19 +474,10 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_nu=
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
@@ -504,10 +493,6 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num=
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
@@ -949,48 +934,28 @@ static void edac_inc_ce_error(struct edac_raw_error_d=
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
@@ -1137,7 +1102,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
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
index 0367554e7437..8682df2f7f4f 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -556,10 +556,8 @@ static ssize_t dimmdev_ce_count_show(struct device *de=
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
@@ -567,10 +565,8 @@ static ssize_t dimmdev_ue_count_show(struct device *de=
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
@@ -666,7 +662,9 @@ static ssize_t mci_reset_counters_store(struct device *=
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
@@ -682,11 +680,9 @@ static ssize_t mci_reset_counters_store(struct device =
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
index d441026eeb1c..76e2c099463b 100644
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
@@ -558,7 +561,6 @@ struct mem_ctl_info {
 	 */
 	u32 ce_noinfo_count, ue_noinfo_count;
 	u32 ue_mc, ce_mc;
-	u32 *ce_per_layer[EDAC_MAX_LAYERS], *ue_per_layer[EDAC_MAX_LAYERS];
=20
 	struct completion complete;
=20
--=20
2.20.1

