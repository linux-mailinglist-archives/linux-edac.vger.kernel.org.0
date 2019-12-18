Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38224123F7C
	for <lists+linux-edac@lfdr.de>; Wed, 18 Dec 2019 07:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbfLRGWk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 18 Dec 2019 01:22:40 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:12990 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725881AbfLRGWk (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 18 Dec 2019 01:22:40 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBI6DHwi030320;
        Tue, 17 Dec 2019 22:22:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt0818; bh=YvpeL6sla+x7RZEsbEu88TiZkol/R1rij0QdtGBnrrM=;
 b=cSSPXVOL13l8i12namosVnNGZmP4kAnZQmYYHxYXOvgfowMBClLe22tNKuP6Kzw7f41M
 7bpFKHojtcavwG2XewhznBefnoI/5FLle8IhhxbcIbyAlS3gAQa19yT7Bf5lLhpku5Fi
 WJigWrf1ajRJua8lmmXtzTn2dWXZf2CU2l1WHkK8CDt61BPPEgTl8BXP29r7c2LCEays
 Aerhm7UyHH8rj7RxenfLJaTn0dy5EJf8O/2CrcnBAhu/3+2/0vnlXxKH6qVMscHLnq1f
 FDlYYIoNKsKd2zQJD6hlDtNSs4NBK45+jE+anCvGCD1Kmh0MwND0ND1I1JzQxpkL+zd0 wA== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2wxn0wnfcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 17 Dec 2019 22:22:13 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 17 Dec
 2019 22:22:11 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.59) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 17 Dec 2019 22:22:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYpelCSWjNgybg4WeK7lUa6BG/R5Fzj1dZ3VY6tuICdForZnRKx4o6MXt9qxHGUV4EmXOxuJRyos79+TNRROIF+KdExGzvFpIZUbLS9n8J7zb2X8uwrlsWdIjtX/tfi0hvRbWskPnWtwwoicSYHIn0WR8jR98D3cvywrx6hB1sYHDSXk8wSqODmH69z2qwoiIlKlFjon3nUmmMjzyI2nSPySi71Jx0x5kNCGmt71qaRzUXSz506F8P7opG9CXZD2UXm9/SGkRm6THXwqBuIrZkty6ak37xAtxAH9H6U5F2+ZlSCUPkcSaSrB+Il4ZriLi5PuYTtwKkX89001gCCbjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvpeL6sla+x7RZEsbEu88TiZkol/R1rij0QdtGBnrrM=;
 b=BDTXs9xEbKxMf4ygdP9ZM2vy80c7mLzJSD/ge71IgqDal67hKsndNyDWmlzy5obDKWnNYViahTzIwwM0QS0DY1HyLie0oOvtB5wSx0rwhfliMxCkQUniHzA3ylo6so2zEr+qOjduUidenboEIUGXc8lt90y7OwOc92WIAydttVNy2KVBE7BY8P4/P7Tm7ukxT+/eS6gxwfpeHuWIqFSgLGmwuNQy0syWWk0irBU4rb4Tviqq2Yke1IF+L7o0rNoG0y/obz9bg4iEvcGrvwPKM0S+GNp34Rq2fz/yUFPPh2GIe+iyfC5N/iV0gL5Qem9rzA/I0iyOispqzZKyiZgUSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvpeL6sla+x7RZEsbEu88TiZkol/R1rij0QdtGBnrrM=;
 b=k0pA62eZk9h6QJTIO9UY1+8565YyqdlAdLt0OAsNvpxdmVwzc57G3Uz+V7dn7NOQY1iWtYJUjRVrolYiwsKhl8sZvHPlKn0PbuI+JLhWdTrUbA9drhNa/8ib8xJEqwFWkeaOSEDkmko0prcHP8ij6u48W7U2hrajsOtK2y0URpU=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3325.namprd18.prod.outlook.com (10.255.86.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.13; Wed, 18 Dec 2019 06:22:09 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea%7]) with mapi id 15.20.2559.012; Wed, 18 Dec 2019
 06:22:08 +0000
Received: from rric.localdomain (31.208.96.227) by HE1PR08CA0057.eurprd08.prod.outlook.com (2603:10a6:7:2a::28) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Wed, 18 Dec 2019 06:22:06 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH] EDAC/mc: Fix use-after-free and memleaks during device
 removal
Thread-Topic: [PATCH] EDAC/mc: Fix use-after-free and memleaks during device
 removal
Thread-Index: AQHVtWt5ZGGyT2BLhUiTk8PdUHU8VA==
Date:   Wed, 18 Dec 2019 06:22:08 +0000
Message-ID: <20191218062129.7400-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR08CA0057.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::28) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 848d689a-3116-4779-34bb-08d783829c00
x-ms-traffictypediagnostic: MN2PR18MB3325:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB3325DF793525FC0CE88FA8C8D9530@MN2PR18MB3325.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:639;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(199004)(189003)(54906003)(110136005)(8936002)(86362001)(1076003)(5660300002)(30864003)(478600001)(2906002)(316002)(2616005)(956004)(81166006)(8676002)(6512007)(81156014)(52116002)(16526019)(186003)(53546011)(6506007)(26005)(4326008)(71200400001)(6486002)(66946007)(64756008)(66556008)(66476007)(36756003)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3325;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4DzpsGreObo+FIJhpTsXpbqLYMZHgVuUqFEHt9GuUTE7eg95T4EDY+F2ImGiN0P8QMUXXVoOnQsFpIfJtWs5vakqAFdXlFvGlkwvyoOYuP6MlWWP97zCJ2eIjMirhKWKwn5Rx+wWLEuK2Nl5bzGrjT25aNqQGKz3kJApw0/fqi4iwePMp2BnfaAukDq8np6UTJUO3/DxulavFP0/g351ntFM+Xg1ULC0uaw93ccqV/DMA/VIeLYR0Ch9qZ55mumCsHkAabgAKPqjNrGPIiAvuePqtr8fEKsu0+RDxy0Ef+qJnKGcOUNf/+ba/R/ejWlVQvP6Oyxh/mc7N4GiHuDBv8fQ6Ne4BzU022aetYVFtGTDIBMnF7FY78i9+JIu5+UtFrDjw+83nRF98PlQ+PmOOwggctII5fSHr2bs+U0idNcs7cNskdxDZDo+BBE/+t+G
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 848d689a-3116-4779-34bb-08d783829c00
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 06:22:08.6478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Jl7Rayo8d/BRMLAfH6mDAc02s2hwzCm3WxaVXkh1nePgfKogHwxJ0yuplHWK5Td+3yVesfacBLErNviPmeG1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3325
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_01:2019-12-17,2019-12-18 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

A test kernel with the options set below revealed several issues when
removing a mci device:

 DEBUG_TEST_DRIVER_REMOVE
 KASAN
 DEBUG_KMEMLEAK

Issues seen:

1) Use-after-free:

On 27.11.19 17:07:33, John Garry wrote:
> [   22.104498] BUG: KASAN: use-after-free in
> edac_remove_sysfs_mci_device+0x148/0x180

The use-after-free is triggered in edac_remove_sysfs_mci_device(). It
became an issue with commit c498afaf7df8 ("EDAC: Introduce an
mci_for_each_dimm() iterator").

The reason for it is that device_unregister(&dimm->dev) not only
removes the sysfs entry, it also frees the dimm struct in
dimm_attr_release(). When incrementing the loop in
mci_for_each_dimm(), the dimm struct is accessed again by the loop
iterator which causes the use-after-free.

In function edac_remove_sysfs_mci_device() all the mci device's
subsequent dimm and csrow objects are removed. When unregistering from
sysfs, instead of removing that data it should be kept until it is
removed together with the mci device. This keeps the data structures
intact and the mci device can be fully used until it will be removed.

2) Memory leaks:

Following memory leaks have been detected:

 # grep edac /sys/kernel/debug/kmemleak | sort | uniq -c
       1     [<000000003c0f58f9>] edac_mc_alloc+0x3bc/0x9d0      # mci->csr=
ows
      16     [<00000000bb932dc0>] edac_mc_alloc+0x49c/0x9d0      # csr->cha=
nnels
      16     [<00000000e2734dba>] edac_mc_alloc+0x518/0x9d0      # csr->cha=
nnels[chn]
       1     [<00000000eb040168>] edac_mc_alloc+0x5c8/0x9d0      # mci->dim=
ms
      34     [<00000000ef737c29>] ghes_edac_register+0x1c8/0x3f8 # see edac=
_mc_alloc()

There are two implementions for device removal in the driver. One is
used before edac_mc_add_mc(), the other afterwards after the device
had been registered in sysfs. The later lacks the removal of some data
allocated in edac_mc_alloc(). All the above issues are fixed as
follows:

Unify release code in a single mci_release() function and use this one
together with put_device() to release the struct mci once there are no
users. Free all subsequent data structures of the children devices in
that release function too. An effect of this is that no data is freed
in edac_mc_sysfs.c (except the "mc" sysfs root node). All sysfs
entries have the mci device as a parent, so its refcount will keep the
struct from being removed as long as sysfs entries exist. Before
freeing struct mci, all sysfs entries are removed now in edac_remove_
sysfs_mci_device(). With the changes made the mci_for_each_dimm() loop
is now save to remove dimm devices from sysfs.

The patch has been tested with the above kernel options, no issues
seen any longer.

This patch should be marked as stable.

Reported-by: John Garry <john.garry@huawei.com>
Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/edac_mc.c       |  20 +++----
 drivers/edac/edac_mc_sysfs.c | 100 +++++++++++++----------------------
 drivers/edac/edac_module.h   |   1 -
 3 files changed, 49 insertions(+), 72 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 7243b88f81d8..058efcd9032e 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -278,6 +278,12 @@ void *edac_align_ptr(void **p, unsigned int size, int =
n_elems)
=20
 static void _edac_mc_free(struct mem_ctl_info *mci)
 {
+	put_device(&mci->dev);
+}
+
+static void mci_release(struct device *dev)
+{
+	struct mem_ctl_info *mci =3D container_of(dev, struct mem_ctl_info, dev);
 	struct csrow_info *csr;
 	int i, chn, row;
=20
@@ -371,6 +377,9 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
 	if (mci =3D=3D NULL)
 		return NULL;
=20
+	mci->dev.release =3D mci_release;
+	device_initialize(&mci->dev);
+
 	/* Adjust pointers so they point within the memory we just allocated
 	 * rather than an imaginary chunk of memory located at address 0.
 	 */
@@ -505,16 +514,9 @@ void edac_mc_free(struct mem_ctl_info *mci)
 {
 	edac_dbg(1, "\n");
=20
-	/* If we're not yet registered with sysfs free only what was allocated
-	 * in edac_mc_alloc().
-	 */
-	if (!device_is_registered(&mci->dev)) {
-		_edac_mc_free(mci);
-		return;
-	}
+	edac_remove_sysfs_mci_device(mci);
=20
-	/* the mci instance is freed here, when the sysfs object is dropped */
-	edac_unregister_sysfs(mci);
+	_edac_mc_free(mci);
 }
 EXPORT_SYMBOL_GPL(edac_mc_free);
=20
diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 0367554e7437..408bace699dc 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -274,17 +274,8 @@ static const struct attribute_group *csrow_attr_groups=
[] =3D {
 	NULL
 };
=20
-static void csrow_attr_release(struct device *dev)
-{
-	struct csrow_info *csrow =3D container_of(dev, struct csrow_info, dev);
-
-	edac_dbg(1, "device %s released\n", dev_name(dev));
-	kfree(csrow);
-}
-
 static const struct device_type csrow_attr_type =3D {
 	.groups		=3D csrow_attr_groups,
-	.release	=3D csrow_attr_release,
 };
=20
 /*
@@ -390,6 +381,14 @@ static const struct attribute_group *csrow_dev_groups[=
] =3D {
 	NULL
 };
=20
+static void csrow_release(struct device *dev)
+{
+	/*
+	 * Nothing to do. We just unregister sysfs here. The mci
+	 * device owns the data and will also release it.
+	 */
+}
+
 static inline int nr_pages_per_csrow(struct csrow_info *csrow)
 {
 	int chan, nr_pages =3D 0;
@@ -408,6 +407,7 @@ static int edac_create_csrow_object(struct mem_ctl_info=
 *mci,
=20
 	csrow->dev.type =3D &csrow_attr_type;
 	csrow->dev.groups =3D csrow_dev_groups;
+	csrow->dev.release =3D csrow_release;
 	device_initialize(&csrow->dev);
 	csrow->dev.parent =3D &mci->dev;
 	csrow->mci =3D mci;
@@ -444,11 +444,8 @@ static int edac_create_csrow_objects(struct mem_ctl_in=
fo *mci)
=20
 error:
 	for (--i; i >=3D 0; i--) {
-		csrow =3D mci->csrows[i];
-		if (!nr_pages_per_csrow(csrow))
-			continue;
-
-		device_del(&mci->csrows[i]->dev);
+		if (device_is_registered(&mci->csrows[i]->dev))
+			device_unregister(&mci->csrows[i]->dev);
 	}
=20
 	return err;
@@ -457,15 +454,13 @@ static int edac_create_csrow_objects(struct mem_ctl_i=
nfo *mci)
 static void edac_delete_csrow_objects(struct mem_ctl_info *mci)
 {
 	int i;
-	struct csrow_info *csrow;
=20
-	for (i =3D mci->nr_csrows - 1; i >=3D 0; i--) {
-		csrow =3D mci->csrows[i];
-		if (!nr_pages_per_csrow(csrow))
-			continue;
-		device_unregister(&mci->csrows[i]->dev);
+	for (i =3D 0; i < mci->nr_csrows; i++) {
+		if (device_is_registered(&mci->csrows[i]->dev))
+			device_unregister(&mci->csrows[i]->dev);
 	}
 }
+
 #endif
=20
 /*
@@ -606,19 +601,18 @@ static const struct attribute_group *dimm_attr_groups=
[] =3D {
 	NULL
 };
=20
-static void dimm_attr_release(struct device *dev)
-{
-	struct dimm_info *dimm =3D container_of(dev, struct dimm_info, dev);
-
-	edac_dbg(1, "device %s released\n", dev_name(dev));
-	kfree(dimm);
-}
-
 static const struct device_type dimm_attr_type =3D {
 	.groups		=3D dimm_attr_groups,
-	.release	=3D dimm_attr_release,
 };
=20
+static void dimm_release(struct device *dev)
+{
+	/*
+	 * Nothing to do. We just unregister sysfs here. The mci
+	 * device owns the data and will also release it.
+	 */
+}
+
 /* Create a DIMM object under specifed memory controller device */
 static int edac_create_dimm_object(struct mem_ctl_info *mci,
 				   struct dimm_info *dimm)
@@ -627,6 +621,7 @@ static int edac_create_dimm_object(struct mem_ctl_info =
*mci,
 	dimm->mci =3D mci;
=20
 	dimm->dev.type =3D &dimm_attr_type;
+	dimm->dev.release =3D dimm_release;
 	device_initialize(&dimm->dev);
=20
 	dimm->dev.parent =3D &mci->dev;
@@ -891,17 +886,8 @@ static const struct attribute_group *mci_attr_groups[]=
 =3D {
 	NULL
 };
=20
-static void mci_attr_release(struct device *dev)
-{
-	struct mem_ctl_info *mci =3D container_of(dev, struct mem_ctl_info, dev);
-
-	edac_dbg(1, "device %s released\n", dev_name(dev));
-	kfree(mci);
-}
-
 static const struct device_type mci_attr_type =3D {
 	.groups		=3D mci_attr_groups,
-	.release	=3D mci_attr_release,
 };
=20
 /*
@@ -920,8 +906,6 @@ int edac_create_sysfs_mci_device(struct mem_ctl_info *m=
ci,
=20
 	/* get the /sys/devices/system/edac subsys reference */
 	mci->dev.type =3D &mci_attr_type;
-	device_initialize(&mci->dev);
-
 	mci->dev.parent =3D mci_pdev;
 	mci->dev.groups =3D groups;
 	dev_set_name(&mci->dev, "mc%d", mci->mc_idx);
@@ -931,7 +915,7 @@ int edac_create_sysfs_mci_device(struct mem_ctl_info *m=
ci,
 	err =3D device_add(&mci->dev);
 	if (err < 0) {
 		edac_dbg(1, "failure: create device %s\n", dev_name(&mci->dev));
-		put_device(&mci->dev);
+		/* no put_device() here, free mci with _edac_mc_free() */
 		return err;
 	}
=20
@@ -947,24 +931,20 @@ int edac_create_sysfs_mci_device(struct mem_ctl_info =
*mci,
=20
 		err =3D edac_create_dimm_object(mci, dimm);
 		if (err)
-			goto fail_unregister_dimm;
+			goto fail;
 	}
=20
 #ifdef CONFIG_EDAC_LEGACY_SYSFS
 	err =3D edac_create_csrow_objects(mci);
 	if (err < 0)
-		goto fail_unregister_dimm;
+		goto fail;
 #endif
=20
 	edac_create_debugfs_nodes(mci);
 	return 0;
=20
-fail_unregister_dimm:
-	mci_for_each_dimm(mci, dimm) {
-		if (device_is_registered(&dimm->dev))
-			device_unregister(&dimm->dev);
-	}
-	device_unregister(&mci->dev);
+fail:
+	edac_remove_sysfs_mci_device(mci);
=20
 	return err;
 }
@@ -976,6 +956,9 @@ void edac_remove_sysfs_mci_device(struct mem_ctl_info *=
mci)
 {
 	struct dimm_info *dimm;
=20
+	if (!device_is_registered(&mci->dev))
+		return;
+
 	edac_dbg(0, "\n");
=20
 #ifdef CONFIG_EDAC_DEBUG
@@ -986,17 +969,14 @@ void edac_remove_sysfs_mci_device(struct mem_ctl_info=
 *mci)
 #endif
=20
 	mci_for_each_dimm(mci, dimm) {
-		if (dimm->nr_pages =3D=3D 0)
+		if (!device_is_registered(&dimm->dev))
 			continue;
 		edac_dbg(1, "unregistering device %s\n", dev_name(&dimm->dev));
 		device_unregister(&dimm->dev);
 	}
-}
=20
-void edac_unregister_sysfs(struct mem_ctl_info *mci)
-{
-	edac_dbg(1, "unregistering device %s\n", dev_name(&mci->dev));
-	device_unregister(&mci->dev);
+	/* only remove the device, but keep mci */
+	device_del(&mci->dev);
 }
=20
 static void mc_attr_release(struct device *dev)
@@ -1010,9 +990,6 @@ static void mc_attr_release(struct device *dev)
 	kfree(dev);
 }
=20
-static const struct device_type mc_attr_type =3D {
-	.release	=3D mc_attr_release,
-};
 /*
  * Init/exit code for the module. Basically, creates/removes /sys/class/rc
  */
@@ -1025,11 +1002,10 @@ int __init edac_mc_sysfs_init(void)
 		return -ENOMEM;
=20
 	mci_pdev->bus =3D edac_get_sysfs_subsys();
-	mci_pdev->type =3D &mc_attr_type;
-	device_initialize(mci_pdev);
-	dev_set_name(mci_pdev, "mc");
+	mci_pdev->release =3D mc_attr_release;
+	mci_pdev->init_name =3D "mc";
=20
-	err =3D device_add(mci_pdev);
+	err =3D device_register(mci_pdev);
 	if (err < 0) {
 		edac_dbg(1, "failure: create device %s\n", dev_name(mci_pdev));
 		put_device(mci_pdev);
diff --git a/drivers/edac/edac_module.h b/drivers/edac/edac_module.h
index 388427d378b1..aa1f91688eb8 100644
--- a/drivers/edac/edac_module.h
+++ b/drivers/edac/edac_module.h
@@ -28,7 +28,6 @@ void edac_mc_sysfs_exit(void);
 extern int edac_create_sysfs_mci_device(struct mem_ctl_info *mci,
 					const struct attribute_group **groups);
 extern void edac_remove_sysfs_mci_device(struct mem_ctl_info *mci);
-void edac_unregister_sysfs(struct mem_ctl_info *mci);
 extern int edac_get_log_ue(void);
 extern int edac_get_log_ce(void);
 extern int edac_get_panic_on_ue(void);
--=20
2.20.1

