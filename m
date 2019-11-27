Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9264C10BFF3
	for <lists+linux-edac@lfdr.de>; Wed, 27 Nov 2019 22:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfK0Vy7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 27 Nov 2019 16:54:59 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:47660 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727105AbfK0Vy6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 27 Nov 2019 16:54:58 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xARLq7Nc027003;
        Wed, 27 Nov 2019 13:54:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=VLw/rMyY0DRRcoTdhPTeXFSd28qQbBSgE+KDk2nrgWw=;
 b=kZdYYbZkMCLpz3kz/qtGuhjADLMuwt3qtjcjjio9W3095IsefqsNIiz3xEVz8BcTly5a
 YKsG0w8+lv0IKyqviVzYmye7BhzIYqwgJf0m4TpuxPeFWPZMnMU0Ses+DCQE4MD4ztSP
 PdqVVfz3ShIocuSp4yXDrOfqmp2+E9qts5ddaLuXOECTGLcoZLzx4WVoBqSXlEQRygQd
 WJ7aaBpJvxZfadrTRl4uP1+RJOGo0BZMuT5pYipNAdIRX79eMvbT25aI/+AGNl+J+eNQ
 Mc0fwPppJvXc3idWEFNuk9b3mgBroXOcFDX5ChgpOEddrkG6iL/4WLc2HkZvGed8Okvy 2w== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2whmdyb5s5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 27 Nov 2019 13:54:50 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 27 Nov
 2019 13:54:49 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.54) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 27 Nov 2019 13:54:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvAyms6j/M6gsXVOCzRrLfyy2tB2ipapCEhVI11gYAXNv0f9w7+gRXLj4VuFh9JqOsUBaNl9AafHG9cU8qijmrPKf4PhlCG0mE0+Ny0xJn7rMlqaIjG/JOL2qGdYAiFNVZvfwqAo6f3JQl+KjwzBj3AJRCOSu6vSZBUJvnwQIxiNG0uCZiVkTB1AQHPYqYeIzva8J5CkPJu46pkdv5ZUGijgpH8v3GydOENMXwcLwr+biy2q0DAIEQqt7T6X0mSqqXyvop5a2Cxjxn4QnHdTMJvBkq16dcuh8QkYfkvi4NVEDUupWtEr1PwRRRMfVYHL/fgIrwnLsi89dcJ8ItAibw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLw/rMyY0DRRcoTdhPTeXFSd28qQbBSgE+KDk2nrgWw=;
 b=aMgoDc6W+cPiznX8RL78UgJzBvsSnn6X1NhNy4lyKmjQV5Q8bSZF27ff0bgdgSypJpyMu8ZUoMoNWd6w2bad7W6pN5rr9XBmNNaD4kmQ9NyxROeckhpgWUTFP2lV4/je85Z6oAco8qcWxcGr+KpbV7LUwOLZzqX4KAq1un/owAkmeEc5sfznQK2/IMyxgIDzbYJMLQQvYtdmY+wIq7wd5I6OXyQVZPtN21hCMZ31L/DWrauVWCpePjPp8SQtt1VA1/2JyuarP4tZFW/BUU6nQJYJU9XSOEHR3cIZ4M44duf2ggtcJvlbCYiQtRiPX6j+wvihIp98+dWjcwLjO8kLYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLw/rMyY0DRRcoTdhPTeXFSd28qQbBSgE+KDk2nrgWw=;
 b=LYltI8IMZAeiJ8eQSIhCrLzjPB0YiprjLuiPDL5RpP2qK34pPl2cOYn/GsCbRUl/+lKRGMQO5Q57XPJbtEukogWlKfG+j3GOKhQSZ3MZds4qV64Ebaa6wt0SANJ9ltDTM2NpKA+BBWY1KvWXZQCk7xQ9bK3FKgEf5QGf9DwCZ1k=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2477.namprd18.prod.outlook.com (20.179.81.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.22; Wed, 27 Nov 2019 21:54:48 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::657c:6c81:859d:106%7]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 21:54:48 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>
Subject: [PATCH 02/10] EDAC/mc: Reorder functions edac_mc_alloc*()
Thread-Topic: [PATCH 02/10] EDAC/mc: Reorder functions edac_mc_alloc*()
Thread-Index: AQHVpW1J4lRhq3cBmEygQISOk20h0w==
Date:   Wed, 27 Nov 2019 21:54:47 +0000
Message-ID: <20191127215415.11230-3-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: f2073e40-f268-44c6-23c6-08d773846bd2
x-ms-traffictypediagnostic: MN2PR18MB2477:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB24775247FF15BBBA4D820E75D9440@MN2PR18MB2477.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(189003)(199004)(14454004)(305945005)(110136005)(256004)(186003)(1076003)(4326008)(86362001)(11346002)(6436002)(8676002)(6486002)(81156014)(2906002)(81166006)(386003)(6512007)(478600001)(76176011)(54906003)(99286004)(52116002)(8936002)(25786009)(7736002)(66946007)(6116002)(26005)(316002)(66066001)(50226002)(36756003)(71190400001)(3846002)(66476007)(66556008)(64756008)(66446008)(71200400001)(102836004)(2616005)(6506007)(446003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2477;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k2UG5iWNFs6oDs3XAcygm/aCEoAyWQ2qzvkRiTWm2+IsxYsciegF9AjUGH5MOsdzVOQUo4npNx6rGPXqPq7L5rOD1AFJJF98yGGzfmRUhU3QVZgPPHDH+dEkv0C+VLR74vijEhOnGZh/QYWBHFGiY6D6dtjPqS9fNvw/qO0d2viU9Y4+kFekhFoy0dQYOY4w7yMReTlS+L1dmrJAZ45LuaAeagUrYaDtfhdhWKinfxneuX2YVL7D2+GhmNN1pgd/33x/BI5KXz4a8HXD8prnRGmHjombx9PQ/vEm7TIhjAjzHIVkiBe60bqcxt0yW+ehJfOrA0akQ7DK167VluRu4mpPzZf71AvHmVceL34nPoefUk+8m9dClpA2kD9GvOgGe7vJTejshfgw2JUWezB5a5sud8HpDuC4FGrGhQ9yAABQq0OfZFc8JUB1ScdJiJg+
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f2073e40-f268-44c6-23c6-08d773846bd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 21:54:47.9454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e+kHqy9oy2jG+8SLoMtrKKe4px+M0YzAXxhLxlwECUFN0O0M5omG1Drbz9Tb7d+XRzCFWkC5OEVZzojCG8p5zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2477
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-27_04:2019-11-27,2019-11-27 signatures=0
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

