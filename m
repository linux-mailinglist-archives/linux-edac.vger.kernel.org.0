Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 414BD15A8B8
	for <lists+linux-edac@lfdr.de>; Wed, 12 Feb 2020 13:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgBLMEj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 12 Feb 2020 07:04:39 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:65008 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727860AbgBLMEj (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 12 Feb 2020 07:04:39 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01CC0XRB008156;
        Wed, 12 Feb 2020 04:04:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=pfpt0818;
 bh=zRW39pdfvVU/VZSxrN8MhBFxcE6XufYRgiKMVH6kxpM=;
 b=xwhN96O3T9nKOtcpUSaHwRvO1mHrrrVWlB4OmL6Qggxi1Jolvg+LzfU472VozPNPEv3r
 PSToLkaIZcbUfG00Y7o8QnVfAqrysDmzMjJs7zD7wY++Bb4iY8Mn+I5VxZouJvZWH5bi
 HNsxPYa7eCNjh0G0fyTXsPGgqjd0GSYrz822MTaXRyr+YUIGi2afDHc4fylM1gKVADle
 ip3/dlCp+ebpRCx19xJJTRZf+gCwXrFx8Kt+keJcufzDpVZMb488l4AHAoh3c2bjpVnx
 jW6vxOg7/2ifK6q0SjJXw5gu+48/JlQc4QrxbtAPCLcDlmMZRCyBgR4huM8f0Enws3H5 jw== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2y1wcsqywj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 12 Feb 2020 04:04:28 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 12 Feb
 2020 04:04:26 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 12 Feb
 2020 04:04:25 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 12 Feb 2020 04:04:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xsd5qhx1spKQs1vMXwbVE0zvOvqo2QuBODJ99ICCFI/tYDzOeDPnjtR+J9kaAB/97ww7LqnkJ24vfgD7wzXx6NaMgtUtZlkX2cBsbsVoZvZDTzcjiQ5fPsy4Z/PJ57y1Mw0/D8nixUMbYtJH0zA2yEfOAZbKmNRtzLRuJhxiOgahY8/UyLf0g9rYD1NIBIltXY8LJFWjKq1GLiKmeEc7pEw/qt0KEz/RUDpMv17xlczvrv0tnez97u/q1vhseXE4LPBPCTzJxh8k9XgGHCML4zxZ9pf+ZGh1bFT9+/qs4dhsYUkkYAI6BeLUxHZlLYs6szjHId2eOyF7Hyy1u6BzAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRW39pdfvVU/VZSxrN8MhBFxcE6XufYRgiKMVH6kxpM=;
 b=TpGp6EQ0OcvyoETXz9E0eujhjwr3CrWukEGj6/9ePSLdh2oJSLVdqr5r2UP0YHtsFvCG9bi2oWBTYWXhFG47+zqiT+yuvAu1/iUDg2+VcrQY9J1bpfUAdzoqDqFDBgmtPco6hd1rwp+qsHdheeOZIhEHyQcWRlXEWRKhrfXFzTSu8NetzmSpOEXvljtLAc65wCtQ4OnKDFhceZtbpBobt6YmVRnZUwyOgIgVX+JXsCFBkBD9NNHswnUlLbAPCOZ9RIW1A+ipRkjYc7gTXXW5yTspb3sp4zKhlX4D5M3S6DngY1/zeQ+8xvkYEhQc7bnZz7RrXHcyz985tiS/bUNtXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRW39pdfvVU/VZSxrN8MhBFxcE6XufYRgiKMVH6kxpM=;
 b=B49OeBvK2lrF98wAW8M8dBVIwxU7EhauGlxd9Ykrqnl/N9En4q6UOzaB8wwhTJezx78aSB+fAH6uRJEfZ9+lxLgUhuvyPFtfEheYNp4sPeiFoYibUJH1RuDAT3ZNHn1ih0KPvJx1im23ENMLcRXp998K+EbzCtkYNU5vdkncMI8=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3512.namprd18.prod.outlook.com (20.180.247.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.27; Wed, 12 Feb 2020 12:04:24 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea%7]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 12:04:24 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 4/4] EDAC/mc: Change mci device removal to use put_device()
Date:   Wed, 12 Feb 2020 13:03:40 +0100
Message-ID: <20200212120340.4764-5-rrichter@marvell.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200212120340.4764-1-rrichter@marvell.com>
References: <20200212120340.4764-1-rrichter@marvell.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR05CA0226.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::26) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
MIME-Version: 1.0
Received: from rric.localdomain (31.208.96.227) by HE1PR05CA0226.eurprd05.prod.outlook.com (2603:10a6:3:fa::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22 via Frontend Transport; Wed, 12 Feb 2020 12:04:22 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4a859b6-1bcd-41aa-a3dc-08d7afb3b34b
X-MS-TrafficTypeDiagnostic: MN2PR18MB3512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR18MB35128776F7CF7A296713CA82D91B0@MN2PR18MB3512.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0311124FA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(189003)(199004)(8676002)(66476007)(66556008)(36756003)(66946007)(1076003)(6506007)(81156014)(81166006)(6666004)(186003)(2906002)(478600001)(52116002)(8936002)(16526019)(5660300002)(26005)(6512007)(4326008)(6486002)(110136005)(54906003)(86362001)(316002)(2616005)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3512;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g81x1N57+IiX7d3j0hx3raaDP6Jl+pC+B4gt/QmiND+ZrBrb+dMnczWecVab5FV0wMn/VFe/nZotm1Ve2avchQlstFoTJwDJR1hQzu6Lk/4eIg7BWee50tKOHgBmb8MrG9CQB2Ac54HjLoAAu/3Xdh+EVcNXsL8mdHpWZ2V8skUGmg3LsuC3xoE0c6VZlWLaPcrZS+976D+tnk9QdJUZHgwYYZNMdXF6sjdDO3fomCK0nvz8hqZ1gLXquqC26vho9ykQLQsSmikQKy344Nf6pGsrKQ/FHUbaU1PQQ6pEm+dqgjcygG2efPBS3BlUYSBKNBNhBqilL+mM13TW5umP1sPS9LTB1FRTCqWUZSLGUiuTN2TnQZ/jpfDpdDAV/kle3hbih6EQ9i077+c65xZIWHbVnSjau7sxWirssuNhBK0WPVjdyJ9oNybeT3jYUSU+
X-MS-Exchange-AntiSpam-MessageData: 3wUTp3aEBEj7N1xVXyFVz/GMbXkO3JKWIO5SWfw3aYUiIUYkoD4JG258Jn/d6BUahnZzW4Kc+7g9/aLr5xbYU9bUfRn+QyIk7v+mmyHWJmnB11iasV5lL9F3+QCx2vZsxuGF2j91O3bKnUl2PgLInA==
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a859b6-1bcd-41aa-a3dc-08d7afb3b34b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2020 12:04:23.9929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uG6sBaVHVDX2/FbXvcMOQg0meJindsEspL0BuOHAoUA5XxHkO1f0QN3CksxP5XU65XWEbFZOkApPIYMejsxIzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3512
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-12_06:2020-02-11,2020-02-12 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

There are dimm and csrow devices linked to the mci device esp. to show
up in sysfs. It must be granted that children devices are removed
before its mci parent. Thus, the release functions must be called in
the correct order and may not miss any child before releasing its
parent. In current implementation this is only granted by the correct
order of release functions.

A much better approach is to use put_device() that releases the device
only after all users are gone. It is the recommended way to release a
device and free its memory. The function uses the device's refcount
and only frees it if there are no users of it anymore such as
children.

So implement a mci_release() function to remove mci devices, use
put_device() to free it and early initialize the mci device right
after its struct was allocated. Change the release function so that it
can be universally used no matter if the device is registered or not.
Since subsequent dimm and csrow sysfs links are implemented as
children devices, their refcounts will keep the parent mci device from
being removed as long as sysfs entries exist and until all users have
been unregistered in edac_remove_sysfs_mci_device().

Remove edac_unregister_sysfs() and merge mci sysfs removal into
edac_remove_sysfs_mci_device(). There is only a single instance now
that removes the sysfs entries. The function can now being used in the
error paths for cleanup.

Also, create device release functions for all involved devices
(dev->release), remove device_type release functions (dev_type->
release) and also use dev->init_name instead of dev_set_name().

Signed-off-by: Robert Richter <rrichter@marvell.com>
Acked-by: Aristeu Rozanski <aris@redhat.com>
---
 drivers/edac/edac_mc.c       | 12 +++--
 drivers/edac/edac_mc_sysfs.c | 90 +++++++++++++++---------------------
 drivers/edac/edac_module.h   |  1 -
 3 files changed, 47 insertions(+), 56 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 69e0d90460e6..64785e644482 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -278,6 +278,12 @@ void *edac_align_ptr(void **p, unsigned int size, int n_elems)
 
 static void _edac_mc_free(struct mem_ctl_info *mci)
 {
+	put_device(&mci->dev);
+}
+
+static void mci_release(struct device *dev)
+{
+	struct mem_ctl_info *mci = container_of(dev, struct mem_ctl_info, dev);
 	struct csrow_info *csr;
 	int i, chn, row;
 
@@ -371,6 +377,9 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
 	if (mci == NULL)
 		return NULL;
 
+	mci->dev.release = mci_release;
+	device_initialize(&mci->dev);
+
 	/* Adjust pointers so they point within the memory we just allocated
 	 * rather than an imaginary chunk of memory located at address 0.
 	 */
@@ -505,9 +514,6 @@ void edac_mc_free(struct mem_ctl_info *mci)
 {
 	edac_dbg(1, "\n");
 
-	if (device_is_registered(&mci->dev))
-		edac_unregister_sysfs(mci);
-
 	_edac_mc_free(mci);
 }
 EXPORT_SYMBOL_GPL(edac_mc_free);
diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index c70ec0a306d8..408bace699dc 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -274,14 +274,8 @@ static const struct attribute_group *csrow_attr_groups[] = {
 	NULL
 };
 
-static void csrow_attr_release(struct device *dev)
-{
-	/* release device with _edac_mc_free() */
-}
-
 static const struct device_type csrow_attr_type = {
 	.groups		= csrow_attr_groups,
-	.release	= csrow_attr_release,
 };
 
 /*
@@ -387,6 +381,14 @@ static const struct attribute_group *csrow_dev_groups[] = {
 	NULL
 };
 
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
 	int chan, nr_pages = 0;
@@ -405,6 +407,7 @@ static int edac_create_csrow_object(struct mem_ctl_info *mci,
 
 	csrow->dev.type = &csrow_attr_type;
 	csrow->dev.groups = csrow_dev_groups;
+	csrow->dev.release = csrow_release;
 	device_initialize(&csrow->dev);
 	csrow->dev.parent = &mci->dev;
 	csrow->mci = mci;
@@ -441,10 +444,8 @@ static int edac_create_csrow_objects(struct mem_ctl_info *mci)
 
 error:
 	for (--i; i >= 0; i--) {
-		csrow = mci->csrows[i];
-		if (!nr_pages_per_csrow(csrow))
-			continue;
-		device_unregister(&mci->csrows[i]->dev);
+		if (device_is_registered(&mci->csrows[i]->dev))
+			device_unregister(&mci->csrows[i]->dev);
 	}
 
 	return err;
@@ -453,15 +454,13 @@ static int edac_create_csrow_objects(struct mem_ctl_info *mci)
 static void edac_delete_csrow_objects(struct mem_ctl_info *mci)
 {
 	int i;
-	struct csrow_info *csrow;
 
-	for (i = mci->nr_csrows - 1; i >= 0; i--) {
-		csrow = mci->csrows[i];
-		if (!nr_pages_per_csrow(csrow))
-			continue;
-		device_unregister(&mci->csrows[i]->dev);
+	for (i = 0; i < mci->nr_csrows; i++) {
+		if (device_is_registered(&mci->csrows[i]->dev))
+			device_unregister(&mci->csrows[i]->dev);
 	}
 }
+
 #endif
 
 /*
@@ -602,16 +601,18 @@ static const struct attribute_group *dimm_attr_groups[] = {
 	NULL
 };
 
-static void dimm_attr_release(struct device *dev)
-{
-	/* release device with _edac_mc_free() */
-}
-
 static const struct device_type dimm_attr_type = {
 	.groups		= dimm_attr_groups,
-	.release	= dimm_attr_release,
 };
 
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
@@ -620,6 +621,7 @@ static int edac_create_dimm_object(struct mem_ctl_info *mci,
 	dimm->mci = mci;
 
 	dimm->dev.type = &dimm_attr_type;
+	dimm->dev.release = dimm_release;
 	device_initialize(&dimm->dev);
 
 	dimm->dev.parent = &mci->dev;
@@ -884,14 +886,8 @@ static const struct attribute_group *mci_attr_groups[] = {
 	NULL
 };
 
-static void mci_attr_release(struct device *dev)
-{
-	/* release device with _edac_mc_free() */
-}
-
 static const struct device_type mci_attr_type = {
 	.groups		= mci_attr_groups,
-	.release	= mci_attr_release,
 };
 
 /*
@@ -910,8 +906,6 @@ int edac_create_sysfs_mci_device(struct mem_ctl_info *mci,
 
 	/* get the /sys/devices/system/edac subsys reference */
 	mci->dev.type = &mci_attr_type;
-	device_initialize(&mci->dev);
-
 	mci->dev.parent = mci_pdev;
 	mci->dev.groups = groups;
 	dev_set_name(&mci->dev, "mc%d", mci->mc_idx);
@@ -921,7 +915,7 @@ int edac_create_sysfs_mci_device(struct mem_ctl_info *mci,
 	err = device_add(&mci->dev);
 	if (err < 0) {
 		edac_dbg(1, "failure: create device %s\n", dev_name(&mci->dev));
-		put_device(&mci->dev);
+		/* no put_device() here, free mci with _edac_mc_free() */
 		return err;
 	}
 
@@ -937,24 +931,20 @@ int edac_create_sysfs_mci_device(struct mem_ctl_info *mci,
 
 		err = edac_create_dimm_object(mci, dimm);
 		if (err)
-			goto fail_unregister_dimm;
+			goto fail;
 	}
 
 #ifdef CONFIG_EDAC_LEGACY_SYSFS
 	err = edac_create_csrow_objects(mci);
 	if (err < 0)
-		goto fail_unregister_dimm;
+		goto fail;
 #endif
 
 	edac_create_debugfs_nodes(mci);
 	return 0;
 
-fail_unregister_dimm:
-	mci_for_each_dimm(mci, dimm) {
-		if (device_is_registered(&dimm->dev))
-			device_unregister(&dimm->dev);
-	}
-	device_unregister(&mci->dev);
+fail:
+	edac_remove_sysfs_mci_device(mci);
 
 	return err;
 }
@@ -966,6 +956,9 @@ void edac_remove_sysfs_mci_device(struct mem_ctl_info *mci)
 {
 	struct dimm_info *dimm;
 
+	if (!device_is_registered(&mci->dev))
+		return;
+
 	edac_dbg(0, "\n");
 
 #ifdef CONFIG_EDAC_DEBUG
@@ -976,17 +969,14 @@ void edac_remove_sysfs_mci_device(struct mem_ctl_info *mci)
 #endif
 
 	mci_for_each_dimm(mci, dimm) {
-		if (dimm->nr_pages == 0)
+		if (!device_is_registered(&dimm->dev))
 			continue;
 		edac_dbg(1, "unregistering device %s\n", dev_name(&dimm->dev));
 		device_unregister(&dimm->dev);
 	}
-}
 
-void edac_unregister_sysfs(struct mem_ctl_info *mci)
-{
-	edac_dbg(1, "unregistering device %s\n", dev_name(&mci->dev));
-	device_unregister(&mci->dev);
+	/* only remove the device, but keep mci */
+	device_del(&mci->dev);
 }
 
 static void mc_attr_release(struct device *dev)
@@ -1000,9 +990,6 @@ static void mc_attr_release(struct device *dev)
 	kfree(dev);
 }
 
-static const struct device_type mc_attr_type = {
-	.release	= mc_attr_release,
-};
 /*
  * Init/exit code for the module. Basically, creates/removes /sys/class/rc
  */
@@ -1015,11 +1002,10 @@ int __init edac_mc_sysfs_init(void)
 		return -ENOMEM;
 
 	mci_pdev->bus = edac_get_sysfs_subsys();
-	mci_pdev->type = &mc_attr_type;
-	device_initialize(mci_pdev);
-	dev_set_name(mci_pdev, "mc");
+	mci_pdev->release = mc_attr_release;
+	mci_pdev->init_name = "mc";
 
-	err = device_add(mci_pdev);
+	err = device_register(mci_pdev);
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
-- 
2.20.1

