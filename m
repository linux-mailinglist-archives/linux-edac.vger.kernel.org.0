Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF4EF123F
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2019 10:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfKFJdX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Nov 2019 04:33:23 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:24842 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730951AbfKFJdW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 6 Nov 2019 04:33:22 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA69VwXB027788;
        Wed, 6 Nov 2019 01:33:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=jcjtbOmJ9NrTjtGOHognQ8Dkd11UM20Z22o5XXVpwGE=;
 b=ZgMG1x6yXOBhp9xv3mnzbS9OPk7vIoT/z3uHSd/lfuojw4ZNIZq9GfkVc7AI4HxGFXGs
 4luI9iMyQnoXkucXY/s7PcHLM/FHchujZxdxNM9mliXPQHu9FeonzlDWLdPnUMPgIG8N
 wXd9n8+gWx2zP7bNAn520TYr8l2edmTwRyp4zZszGAc5VHZw9IWfN0Scd4r4vnOh60lV
 9jhwA1/XDSJ5iKPWFqmXyaEIGJ8CpurQvBf8RslnQJy8y3U+/txAJfayjrzKQqx8XrKO
 bfrN2KwhiWXFykidnE7S/9a75a34hO3shn5tdOxxpc5K8NMom6nkZrVNr/uzM6B1Sq3u Lw== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2w19amyaj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 01:33:10 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 6 Nov
 2019 01:33:08 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.50) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 6 Nov 2019 01:33:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvIK3l3DIQCyA5F9d7VQZv0BCMshL9HLuR9g6LMtFwduEXgqMzPlD4MhNy8sm+xUv7h72jZVJzB7Co++DLxv4N022FqX/2vFI1MHMUiyGteb5Xj3fy++zqmU7ANUhX/r93Y5c7pOR/BTtlqtxboCN/YwaW7sgGgxJWmVNk+0csgjP88DNkxFcmY1NkVsOe027fvftkM/jZbgBOkLIlcPJx7zm42+RnaQ4xyo4azvDfpHt+vIdHtI9edjisfXUbn4ycoACYsoYapcmHhCmBJoExdjcAH65ZdWgYC+Fiqt9ikz0QBM2RXOxUAJbE7xQd8xm2o5FfnHW2hcz2rVbB/H1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcjtbOmJ9NrTjtGOHognQ8Dkd11UM20Z22o5XXVpwGE=;
 b=AO5TlmvUm/FvyCaHyKzdYnmT65Ond/hDBJ0Gqg0rCHWbdJs/D13SNj1UxwBu+fV3YhAwJ8VPSG9w/bhGW18oEc0sqkptAHReA3ip/mLUcyjH9Zpz3GLlFFbohx1ICN0TrjQbUzlfuySqsMPFdZc+r9zVuIvmds7jPmnSIkUisv+rk4BCS9d/PNTFX+E8/xoWCR5C2eULCsZiLYCmZFj1QkjZiKZEL3dUpXAvqUArsCboaAfRHxKwLcJ+cjRtXGrdeujGB9JnuGSiIayzNFMf0/u3/qusTCCB/0G3rh4xoP4k82L1PpgfAxJ9zRBGEcQ/GljiCnHGZ7UG11OXCIZFPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcjtbOmJ9NrTjtGOHognQ8Dkd11UM20Z22o5XXVpwGE=;
 b=E7X+jlzm77sNFhL5+1J5no+Vo/kROmaVh7QwzawjW7L1EX7TWhFJLrAtzDu+yNY4zrGjjto6ZNFhsSRHY8md6d3e4i37kliqMsb/71xsmJoTMcT9hqsdkcxOl2mFwOZovB1qC2qYhGi3KZz4xlvloVx9xfMsoI7FjqKR3svb3ww=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3165.namprd18.prod.outlook.com (10.255.236.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 6 Nov 2019 09:33:07 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::c4a:cf3c:f530:fba6%6]) with mapi id 15.20.2430.020; Wed, 6 Nov 2019
 09:33:07 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>
Subject: [PATCH v2 03/20] EDAC: Introduce mci_for_each_dimm() iterator
Thread-Topic: [PATCH v2 03/20] EDAC: Introduce mci_for_each_dimm() iterator
Thread-Index: AQHVlIUyV002ir1/PECNj5/y7jIwmw==
Date:   Wed, 6 Nov 2019 09:33:07 +0000
Message-ID: <20191106093239.25517-4-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: aabfff52-44b9-4390-48b2-08d7629c5491
x-ms-traffictypediagnostic: MN2PR18MB3165:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB316506A6EA428DA3587AE6C8D9790@MN2PR18MB3165.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:103;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(199004)(189003)(52116002)(305945005)(6486002)(76176011)(71190400001)(71200400001)(256004)(11346002)(446003)(7736002)(14444005)(6436002)(4326008)(6512007)(66446008)(66556008)(66476007)(66946007)(64756008)(5660300002)(1076003)(476003)(6116002)(3846002)(110136005)(54906003)(36756003)(2906002)(8676002)(99286004)(81166006)(81156014)(316002)(8936002)(50226002)(486006)(6506007)(386003)(102836004)(66066001)(2616005)(86362001)(478600001)(25786009)(186003)(14454004)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3165;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qe8yskx4IJfP88g1rdDBxVThQb5NACNOU2odbCkZ1bqHko/OiMAaATziFWkNTgsXKvwZm4+TbvD8XSBNojHtoFpd9bcorybj6jWSszP0yFI5upoDjTRYfpmoryl/3Eyg6O3Owqpb5bLYIgrh5r7aVMMqBJYrI0jYqMckB93KNR0BU/O5tYs7e4CPOfxMuwye5wt0nr9zDRlkfQN0zTV1dEQBQNuTtk6cCyKJg+Lz+Vx1hsVNM1op+WmdgYvfeUT1cN62bEAOa5QiboijeYILVH2wJfqDWuGdOiz7LCN95FT45RDwkmKS6uEtKfYHJpXdKK6P7BmkL1ITpusb1YlJrF140JthcpB/HQlwCaT3+mt/0OqjiB2eJz6yXXp77tye5dAz+AiKu+008+pUedCaynu83+nDrZ6a0nF4nWyhLC06Ld08tvzZgrcy34TcwGtL
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: aabfff52-44b9-4390-48b2-08d7629c5491
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 09:33:07.2660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y2AaES8VvWxxmHi42ygdbTT2IRh2jeNjFokpVL2Fh0+MzQNad8DJ2c/m7OYCcSRxy/RevNuQ/T5gr76SsVZIUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3165
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_02:2019-11-06,2019-11-06 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Introduce the mci_for_each_dimm() iterator. It returns a pointer to a
struct dimm_info. This makes the declaration and use of an index
obsolete and avoids access to internal data of struct mci (direct
array access etc).

Signed-off-by: Robert Richter <rrichter@marvell.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/edac/edac_mc.c       | 19 +++++++++++--------
 drivers/edac/edac_mc_sysfs.c | 29 ++++++++++++-----------------
 drivers/edac/ghes_edac.c     |  9 +++++----
 drivers/edac/i5100_edac.c    | 13 +++++--------
 include/linux/edac.h         |  7 +++++++
 5 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 72088d49b03b..c5240bb4c6c0 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -145,15 +145,18 @@ static void edac_mc_dump_channel(struct rank_info *ch=
an)
 	edac_dbg(4, "    channel->dimm =3D %p\n", chan->dimm);
 }
=20
-static void edac_mc_dump_dimm(struct dimm_info *dimm, int number)
+static void edac_mc_dump_dimm(struct dimm_info *dimm)
 {
 	char location[80];
=20
+	if (!dimm->nr_pages)
+		return;
+
 	edac_dimm_info_location(dimm, location, sizeof(location));
=20
 	edac_dbg(4, "%s%i: %smapped as virtual row %d, chan %d\n",
 		 dimm->mci->csbased ? "rank" : "dimm",
-		 number, location, dimm->csrow, dimm->cschannel);
+		 dimm->idx, location, dimm->csrow, dimm->cschannel);
 	edac_dbg(4, "  dimm =3D %p\n", dimm);
 	edac_dbg(4, "  dimm->label =3D '%s'\n", dimm->label);
 	edac_dbg(4, "  dimm->nr_pages =3D 0x%x\n", dimm->nr_pages);
@@ -702,6 +705,7 @@ EXPORT_SYMBOL_GPL(edac_get_owner);
 int edac_mc_add_mc_with_groups(struct mem_ctl_info *mci,
 			       const struct attribute_group **groups)
 {
+	struct dimm_info *dimm;
 	int ret =3D -EINVAL;
 	edac_dbg(0, "\n");
=20
@@ -726,9 +730,9 @@ int edac_mc_add_mc_with_groups(struct mem_ctl_info *mci=
,
 				if (csrow->channels[j]->dimm->nr_pages)
 					edac_mc_dump_channel(csrow->channels[j]);
 		}
-		for (i =3D 0; i < mci->tot_dimms; i++)
-			if (mci->dimms[i]->nr_pages)
-				edac_mc_dump_dimm(mci->dimms[i], i);
+
+		mci_for_each_dimm(mci, dimm)
+			edac_mc_dump_dimm(dimm);
 	}
 #endif
 	mutex_lock(&mem_ctls_mutex);
@@ -1086,6 +1090,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
type type,
 			  const char *msg,
 			  const char *other_detail)
 {
+	struct dimm_info *dimm;
 	char *p;
 	int row =3D -1, chan =3D -1;
 	int pos[EDAC_MAX_LAYERS] =3D { top_layer, mid_layer, low_layer };
@@ -1146,9 +1151,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
type type,
 	p =3D e->label;
 	*p =3D '\0';
=20
-	for (i =3D 0; i < mci->tot_dimms; i++) {
-		struct dimm_info *dimm =3D mci->dimms[i];
-
+	mci_for_each_dimm(mci, dimm) {
 		if (top_layer >=3D 0 && top_layer !=3D dimm->location[0])
 			continue;
 		if (mid_layer >=3D 0 && mid_layer !=3D dimm->location[1])
diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 91e4c8f155af..0367554e7437 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -621,8 +621,7 @@ static const struct device_type dimm_attr_type =3D {
=20
 /* Create a DIMM object under specifed memory controller device */
 static int edac_create_dimm_object(struct mem_ctl_info *mci,
-				   struct dimm_info *dimm,
-				   int index)
+				   struct dimm_info *dimm)
 {
 	int err;
 	dimm->mci =3D mci;
@@ -632,9 +631,9 @@ static int edac_create_dimm_object(struct mem_ctl_info =
*mci,
=20
 	dimm->dev.parent =3D &mci->dev;
 	if (mci->csbased)
-		dev_set_name(&dimm->dev, "rank%d", index);
+		dev_set_name(&dimm->dev, "rank%d", dimm->idx);
 	else
-		dev_set_name(&dimm->dev, "dimm%d", index);
+		dev_set_name(&dimm->dev, "dimm%d", dimm->idx);
 	dev_set_drvdata(&dimm->dev, dimm);
 	pm_runtime_forbid(&mci->dev);
=20
@@ -916,7 +915,8 @@ static const struct device_type mci_attr_type =3D {
 int edac_create_sysfs_mci_device(struct mem_ctl_info *mci,
 				 const struct attribute_group **groups)
 {
-	int i, err;
+	struct dimm_info *dimm;
+	int err;
=20
 	/* get the /sys/devices/system/edac subsys reference */
 	mci->dev.type =3D &mci_attr_type;
@@ -940,13 +940,12 @@ int edac_create_sysfs_mci_device(struct mem_ctl_info =
*mci,
 	/*
 	 * Create the dimm/rank devices
 	 */
-	for (i =3D 0; i < mci->tot_dimms; i++) {
-		struct dimm_info *dimm =3D mci->dimms[i];
+	mci_for_each_dimm(mci, dimm) {
 		/* Only expose populated DIMMs */
 		if (!dimm->nr_pages)
 			continue;
=20
-		err =3D edac_create_dimm_object(mci, dimm, i);
+		err =3D edac_create_dimm_object(mci, dimm);
 		if (err)
 			goto fail_unregister_dimm;
 	}
@@ -961,12 +960,9 @@ int edac_create_sysfs_mci_device(struct mem_ctl_info *=
mci,
 	return 0;
=20
 fail_unregister_dimm:
-	for (i--; i >=3D 0; i--) {
-		struct dimm_info *dimm =3D mci->dimms[i];
-		if (!dimm->nr_pages)
-			continue;
-
-		device_unregister(&dimm->dev);
+	mci_for_each_dimm(mci, dimm) {
+		if (device_is_registered(&dimm->dev))
+			device_unregister(&dimm->dev);
 	}
 	device_unregister(&mci->dev);
=20
@@ -978,7 +974,7 @@ int edac_create_sysfs_mci_device(struct mem_ctl_info *m=
ci,
  */
 void edac_remove_sysfs_mci_device(struct mem_ctl_info *mci)
 {
-	int i;
+	struct dimm_info *dimm;
=20
 	edac_dbg(0, "\n");
=20
@@ -989,8 +985,7 @@ void edac_remove_sysfs_mci_device(struct mem_ctl_info *=
mci)
 	edac_delete_csrow_objects(mci);
 #endif
=20
-	for (i =3D 0; i < mci->tot_dimms; i++) {
-		struct dimm_info *dimm =3D mci->dimms[i];
+	mci_for_each_dimm(mci, dimm) {
 		if (dimm->nr_pages =3D=3D 0)
 			continue;
 		edac_dbg(1, "unregistering device %s\n", dev_name(&dimm->dev));
diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index d92cd99081d2..af27f8063891 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -90,12 +90,13 @@ static void ghes_edac_count_dimms(const struct dmi_head=
er *dh, void *arg)
=20
 static int get_dimm_smbios_index(struct mem_ctl_info *mci, u16 handle)
 {
-	int i;
+	struct dimm_info *dimm;
=20
-	for (i =3D 0; i < mci->tot_dimms; i++) {
-		if (mci->dimms[i]->smbios_handle =3D=3D handle)
-			return i;
+	mci_for_each_dimm(mci, dimm) {
+		if (dimm->smbios_handle =3D=3D handle)
+			return dimm->idx;
 	}
+
 	return -1;
 }
=20
diff --git a/drivers/edac/i5100_edac.c b/drivers/edac/i5100_edac.c
index 134586753311..0ddc41e47a96 100644
--- a/drivers/edac/i5100_edac.c
+++ b/drivers/edac/i5100_edac.c
@@ -846,20 +846,17 @@ static void i5100_init_interleaving(struct pci_dev *p=
dev,
=20
 static void i5100_init_csrows(struct mem_ctl_info *mci)
 {
-	int i;
 	struct i5100_priv *priv =3D mci->pvt_info;
+	struct dimm_info *dimm;
=20
-	for (i =3D 0; i < mci->tot_dimms; i++) {
-		struct dimm_info *dimm;
-		const unsigned long npages =3D i5100_npages(mci, i);
-		const unsigned int chan =3D i5100_csrow_to_chan(mci, i);
-		const unsigned int rank =3D i5100_csrow_to_rank(mci, i);
+	mci_for_each_dimm(mci, dimm) {
+		const unsigned long npages =3D i5100_npages(mci, dimm->idx);
+		const unsigned int chan =3D i5100_csrow_to_chan(mci, dimm->idx);
+		const unsigned int rank =3D i5100_csrow_to_rank(mci, dimm->idx);
=20
 		if (!npages)
 			continue;
=20
-		dimm =3D edac_get_dimm(mci, chan, rank, 0);
-
 		dimm->nr_pages =3D npages;
 		dimm->grain =3D 32;
 		dimm->dtype =3D (priv->mtr[chan][rank].width =3D=3D 4) ?
diff --git a/include/linux/edac.h b/include/linux/edac.h
index 79c5564ee314..8beb6e834be9 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -599,6 +599,13 @@ struct mem_ctl_info {
 	u16 fake_inject_count;
 };
=20
+#define mci_for_each_dimm(mci, dimm)				\
+	for ((dimm) =3D (mci)->dimms[0];				\
+	     (dimm);						\
+	     (dimm) =3D (dimm)->idx + 1 < (mci)->tot_dimms	\
+		     ? (mci)->dimms[(dimm)->idx + 1]		\
+		     : NULL)
+
 /**
  * edac_get_dimm_by_index - Get DIMM info from a memory controller
  *                          given by an index
--=20
2.20.1

