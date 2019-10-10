Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84191D31EE
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2019 22:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfJJUZ0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Oct 2019 16:25:26 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:22530 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726533AbfJJUZZ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 10 Oct 2019 16:25:25 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9AKJtpB025224;
        Thu, 10 Oct 2019 13:25:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=PbiTKjBv+GvgBhzbCoXdSUHSbvOXcSIXFrsTD8XzAdU=;
 b=rLpGKEIrmku3YchEZIqK4PQS1mVpHdL1Uykpsh42MeWjwLiQf5JQfuESGSfmXkT4A4Hy
 EUtpYXbK9EjsA9N0KrMpp413wv8b2CvVAi0vDRXbsfRQtva7gb3L1+8D5+ypECCuAqLT
 oE7Kxj5QkCGj5PW0dSFv0PbOpGgalwxKOb/2pKQbFuCWTRKNdZp00kh+DXA87/kHp/Do
 x3opGGxZkFY0Bq9kllaQ4N4Z6n4R1sNOqkY3a1BCOnAdYxyYkw96uHTBOtve5j4wrq8c
 HVtnv8c2ViGEb8Nyp387Jxr+9Iah+G786jKco+iEzP88wTYDoPmdk4dfJFfFIENQ+YhW 6A== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2vhdxbxqfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 10 Oct 2019 13:25:13 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 10 Oct
 2019 13:25:11 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.54) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 10 Oct 2019 13:25:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5xRNNT9qFcHOLZthZPRdPsTOfZiqx/yf3P0almGAiKzq2YNSc8vKDyn2nsrqAMTuIDyujS9OEg8ijfyt5mAznhUHOqPIWiSn4ZGRCfNs4afz28vEXjbxk2n5RWxYrBjVisjr6b0PBv3Pckkn/Te3pmUx+pZ0AWqGgpnElulVz08uaEN3As0PvbbmdLSPH/0mpiIuvK7iaSEuBpyzZRfpOkZv/kX4QoSkyVUdMLz82R6cGA4eDosB8ERkuZWGplYtmEN0D40b7q2miVzl14JYDCAwvg30Tu3R+dbPpne36zASh90Dh1867H9KVpOkHTbhFoJGNuoZNNhnI6LltdKxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbiTKjBv+GvgBhzbCoXdSUHSbvOXcSIXFrsTD8XzAdU=;
 b=aKLRbWMVXl1b7H+KVySVUfo3/UtXmEyQwVGpHSUvPdw0M0quEBSmCF3JjKzCokSMMiw8dpduVN1AHM3iPtKg4UeK0cTQSaxrFeOpu9P4x0qnuo/iFLQxcWX0/BS0xB1JQU0ieAQJncJ2yyS/64VxOGXuo4dEWNeomu+eJ06BxBQu58zQdcPcIf5pgeCj28xeBvnafTyYruzQEn3tSN7I5Cz4oLgr4DMOsTQ0vCVnOQSDRRkFbq2hFUC4G0nRnBSx4iunA8htMl97FTXdvUzSL0qngMiqwvtgDG7fnnejB8Rm0FuvDa+LI7vRTS+7mzbTlvQ6+OFETMEHofJo04MEWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbiTKjBv+GvgBhzbCoXdSUHSbvOXcSIXFrsTD8XzAdU=;
 b=A8uK2oETGHNanKtbEpgvV+xgmFYlUzE5sphkE/XiAkn9w/aTmf87ySIQ6uU+AOaRAYlaqcgnU0YB//+dkg4DM8f+HRgceNyaL1bBon1ScmHTL+HfdEfYqnhbVekuY4tmi32INi3DrDcfept6WPige0wDC14ojkYUgrjty9ti9lM=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2701.namprd18.prod.outlook.com (20.179.22.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Thu, 10 Oct 2019 20:25:10 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763%3]) with mapi id 15.20.2327.026; Thu, 10 Oct 2019
 20:25:10 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 03/19] EDAC: Introduce mci_for_each_dimm() iterator
Thread-Topic: [PATCH 03/19] EDAC: Introduce mci_for_each_dimm() iterator
Thread-Index: AQHVf6jQImmw1gEcOUyKbN2Eh+EskQ==
Date:   Thu, 10 Oct 2019 20:25:10 +0000
Message-ID: <20191010202418.25098-4-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: f201c158-4c3b-42e6-af9a-08d74dbff285
x-ms-traffictypediagnostic: MN2PR18MB2701:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB2701462860C45E75EE4EC11DD9940@MN2PR18MB2701.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:103;
x-forefront-prvs: 018632C080
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39850400004)(346002)(136003)(366004)(376002)(189003)(199004)(6436002)(6512007)(54906003)(71190400001)(110136005)(14454004)(316002)(6486002)(86362001)(71200400001)(5660300002)(2906002)(66066001)(25786009)(50226002)(478600001)(11346002)(446003)(476003)(486006)(3846002)(6116002)(2616005)(99286004)(1076003)(6506007)(76176011)(4326008)(14444005)(386003)(7736002)(305945005)(52116002)(26005)(256004)(102836004)(81166006)(66946007)(36756003)(186003)(81156014)(66446008)(66556008)(8936002)(64756008)(8676002)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2701;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sy/+nLUkxm1RANXAQ2dtMns+eEbdnMQy8KeCRyECgJl/N/mNXa3+cuk+OZsVJGXdkBzpLNTu4gvSkUBn0tTDhaiGouW5nT/9f4I5l+vtNS/axsOhqB5soKX+e1vhpCpPIJkIsrI5sHMUJG3p1nzt8606BDqlBGkKvTZ11zxmVw8YLtZMd+tmSfQNcy5767YPmCbG/rau+69b7bPssSk+wznwhtov1EYU1vL3NdMIFTVPPF3EjjJpUCTkhCaRO3D6+9kGVRMUb80YYC3aQmVGfSAHWzlk/1QTKOKuMxy9rPBXlPm0oeWXLhLuxRV30bgq9Tu0LGRkvlGXgiOtAOKYlsSJpcnwXBa3Fmd94xVGyYE/cb3OIx9YUD+bvZaGAbpt+2YnIJSbl57bm38VVEJXOUOUydT6S5EJjbU9rkbheW8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f201c158-4c3b-42e6-af9a-08d74dbff285
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 20:25:10.0623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W9yUOWiLbHxn/YMx2we5oYplzZtLqqJBhOMbE23S5anVnIJjOOemYqHlKkuSn07lrp3y1RRZeACj3lf18AvC1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2701
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-10_07:2019-10-10,2019-10-10 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Introduce the mci_for_each_dimm() iterator. It returns a pointer to a
struct dimm_info. This makes the declaration and use of an index
obsolete and avoids access to internal data of struct mci (direct
array access etc).

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/edac_mc.c       | 19 +++++++++++--------
 drivers/edac/edac_mc_sysfs.c | 29 ++++++++++++-----------------
 drivers/edac/ghes_edac.c     |  8 ++++----
 drivers/edac/i5100_edac.c    | 13 +++++--------
 include/linux/edac.h         |  7 +++++++
 5 files changed, 39 insertions(+), 37 deletions(-)

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
index fb31e80dfe94..842080d7b33a 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -82,11 +82,11 @@ static void ghes_edac_count_dimms(const struct dmi_head=
er *dh, void *arg)
 static int get_dimm_smbios_index(u16 handle)
 {
 	struct mem_ctl_info *mci =3D ghes_pvt->mci;
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
 	return -1;
 }
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

