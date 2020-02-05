Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35A1D153A39
	for <lists+linux-edac@lfdr.de>; Wed,  5 Feb 2020 22:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgBEVZk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 5 Feb 2020 16:25:40 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:17158 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727070AbgBEVZk (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 5 Feb 2020 16:25:40 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 015LGWuT013367;
        Wed, 5 Feb 2020 13:25:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=pfpt0818; bh=sGRpxNCF9FJbk9008CgE01UK1sEkP73AKTTvHFbIcvI=;
 b=nlhcgEGiE0GxU80uugzx7yrjxdVp9EFH/9Bt3FzQo8HZtUwkLQAaxvCoFqgG8Ph8OsHq
 1wwwziNB9una9jrNMCvBYYhwAYyB4q52j1sHf1p0zNfjHAKGUz+Fzi9hyheG5nbKuwub
 MVC81/5UQZKmhHr4SQJAj7Pr5jEVTUOlBQa3XUnyYZJQlg+7nMK9CMnmEl0E8dCPsrWN
 x+mvhF2Q0k+zsB9294kU3/MNJgbj4wQZJSB4a49KCaGCJALwPdexbYC2olIQWzW0P6K9
 +ynBs1Iq4UU+UYscFZ+qKHZw1JbeuJKEf1bn9vcWwyyKkDSVIkVHWM7wn1bcT7NsmTwS iA== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2xyhn14src-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 05 Feb 2020 13:25:20 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 5 Feb
 2020 13:25:18 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 5 Feb
 2020 13:25:18 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 5 Feb 2020 13:25:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4DD+yWtb7qPUK1y7y6LuV3D9is46nKJouRq9Cq3yuL8auFjzYTJQFkkb2hpcvoNmH/s4q6Avfcw0Lpu7BS4GbrfBHnS9bU7vCMTcRxDzxR8zaK7tfFccqqmDwGdbpY9KEs1OwPwFF5qA0y6wUoTfryT+dEYsaWG6KWw2Jw6Sgz7cAFu4bfMCycDaqGfvQFA9HM35Jl523DZ7UGpzF5SH8O4NxTg/k55G8EKRLsfeSkCvsUL5Dg6Wk6wswb4atYOMJ9OpQD8MUH3qHnkxqE+jBlAKjLuJ8EIqAPjIOAeQGe83WHXFIeUIEEsg2tm3HotPVzY6dbcdkRs7Pe2fJsxXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGRpxNCF9FJbk9008CgE01UK1sEkP73AKTTvHFbIcvI=;
 b=NdTylsJuWxeSxiB/axiCyCD5I3xU/NvJRQ6j++7JZe5O1CvlGUDK7kd7IaNOmIEHwgBxqSLcjkNEB8o2RHlm+c+Q09IjtXtULmZvnygLIR0HiU5mFsnXpM/Tz0iBzUidwWrf536wuwL9jLEuUqTr3J+FEx2PMB35+BXcM/cWc743rhnXwSKG1Wv032hcXUvyeIQfw2SQOrCg8P3VHU8gbTwnxxxXQuGLn79YCBIJaWkVi00AzGQMx/1zNpAXFjul8d9pkOnOTTIdbYxlpNm9+H62LtTDBAGjYkhWdVRsjA9viBHn+V7zUfzavoTgBTiEVUPpmLEkwEbhGIVF+PYvvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGRpxNCF9FJbk9008CgE01UK1sEkP73AKTTvHFbIcvI=;
 b=C2yJEb4liDE7OkuTr4UIxvlwff0R69v1IVugcDs9sDdWlr1uAaNUP92YPPlqP+P5GybKBYeIIv9RMC8/WgaeSDEaVJhhXjNK6ZL8O++vmQMSBr9B9OD3p9EL6IWXIfa4wSYUEyQ18eWOGSktLMH5BCQ6ybsHBig0REfMCuwvvRQ=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3183.namprd18.prod.outlook.com (10.255.237.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Wed, 5 Feb 2020 21:25:16 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea%7]) with mapi id 15.20.2686.035; Wed, 5 Feb 2020
 21:25:16 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     Robert Richter <rrichter@marvell.com>,
        John Garry <john.garry@huawei.com>,
        Aristeu Rozanski <aris@redhat.com>,
        James Morse <james.morse@arm.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] EDAC/mc: Fix use-after-free and memleaks during device removal
Date:   Wed,  5 Feb 2020 22:24:43 +0100
Message-ID: <20200205212444.10382-1-rrichter@marvell.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR05CA0234.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::34) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
MIME-Version: 1.0
Received: from rric.localdomain (31.208.96.227) by HE1PR05CA0234.eurprd05.prod.outlook.com (2603:10a6:3:fa::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.33 via Frontend Transport; Wed, 5 Feb 2020 21:25:14 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca51f784-eb70-4c80-1816-08d7aa81e46b
X-MS-TrafficTypeDiagnostic: MN2PR18MB3183:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR18MB31838AA77FEA4B6EC834198BD9020@MN2PR18MB3183.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:538;
X-Forefront-PRVS: 0304E36CA3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(189003)(199004)(110136005)(2906002)(8936002)(316002)(86362001)(36756003)(81166006)(8676002)(81156014)(52116002)(66946007)(54906003)(66556008)(66476007)(1076003)(30864003)(2616005)(956004)(5660300002)(6512007)(478600001)(6486002)(186003)(26005)(6666004)(6506007)(16526019)(53546011)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3183;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jxQv8A8TLRl4FmOYCCGO5MqRkt+ScmWDukWbURR5gc/UoVKdNlEn8oAKo+Z1heDXKRdgc0stsoE+zbLoP3dFJIkVAO+kpPwlnF0YafVY9RONJzGRGjP57e4TzpVxUMDh7SSM2AoKJdwbhxzQpfxjq8c1bEJAbNizKX0ZhMNv2ZekzqchMjZS4GlLnKmEEjJxVxCcKHbBILqOULU/GPNivIngtUnhuFtG8tYF5Ce6iJWmHK+OzC6C/Xklmf3Bl1kXL+WfyHkQKwtMNG1OLC14qdIm5+04Ct4hkCbGdALMnvXYseTpwmirpAvj5sCJv0MUKZ9XEpwQVq1nYbdjisa00YCH+m6gPPAenF9vKAkrhw+ygMOwZYetreUSjKezrDFegAcqvztO/ScozL6EfTnEutC9NPdZcXuJyPW2H/eNu6xccLWuxGXTbVGtfRXSNq2b
X-MS-Exchange-AntiSpam-MessageData: x+loebmM+XQehIJrlX92TqN2siiNKXiBdFoZsjo1tCysEbu/Uu51MG2szEELjoh8EIle645A0CIOpu0nmDBW5G7MC814XYi8lMmZGuxoCWScE2Obs/9daanuncHpVRYXzGIzPvI0EZyQz5KWikCvpQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: ca51f784-eb70-4c80-1816-08d7aa81e46b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2020 21:25:16.0029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uBidGRW+6I51bfFEeRBJAfh2bFTZEAvNJ1AxcNpRNoeOkm07gLYpr6L2CVR3OlmGF+CLTjJ7fxT6QmjUYV0bIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3183
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-05_06:2020-02-04,2020-02-05 signatures=0
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

The use-after-free is caused by the mci_for_each_dimm() iterator that
is called in edac_remove_sysfs_mci_device(). The iterator was
introduced with commit c498afaf7df8 ("EDAC: Introduce an
mci_for_each_dimm() iterator"). The iterator loop calls function
device_unregister(&dimm->dev), which removes the sysfs entry of the
device, but also frees the dimm struct in dimm_attr_release(). When
incrementing the loop in mci_for_each_dimm(), the dimm struct is
accessed again, but it is already freed.

The fix is to free all the mci device's subsequent dimm and csrow
objects at a later point when the mci device is freed. This keeps the
data structures intact and the mci device can be fully used until its
removal.

2) Memory leaks:

Following memory leaks have been detected:

 # grep edac /sys/kernel/debug/kmemleak | sort | uniq -c
       1     [<000000003c0f58f9>] edac_mc_alloc+0x3bc/0x9d0      # mci->csrows
      16     [<00000000bb932dc0>] edac_mc_alloc+0x49c/0x9d0      # csr->channels
      16     [<00000000e2734dba>] edac_mc_alloc+0x518/0x9d0      # csr->channels[chn]
       1     [<00000000eb040168>] edac_mc_alloc+0x5c8/0x9d0      # mci->dimms
      34     [<00000000ef737c29>] ghes_edac_register+0x1c8/0x3f8 # see edac_mc_alloc()

All leaks are from memory created by edac_mc_alloc().

Note: The test above shows that edac_mc_alloc() was called here from
ghes_edac_register(), thus both functions show up in the stack dump,
but the driver causing the leaks is edac_mc. The comments with the
data structures involved were made manually by analyzing the objdump.

The data structures listed above and created by edac_mc_alloc() are
not properly removed during device removal, which is done in
edac_mc_free(). There are two paths implemented to remove the device
depending on device registration, _edac_mc_free() is called if the
device is not registered and edac_unregister_sysfs() otherwise. The
implemenations differ. For the sysfs case the mci device removal lacks
the removal of subsequent data structures (csrows, channels, dimms).
This causes the memory leaks (see mci_attr_release()).

Fixing this as follows:

Unify code and implement a mci_release() function which is used to
remove a struct mci regardless of the device registration status. Use
put_device() to release the struct. Free all subsequent data structs
of the mci's children in that release function. An effect of this is
that no data is freed in edac_mc_sysfs.c (except the "mc" sysfs root
node). All sysfs entries have the mci device as a parent, so its
refcount will keep the mci parent as long as sysfs entries exist. This
prevents struct mci from being freed until all sysfs entries have been
removed which is done in edac_remove_sysfs_mci_device(). With the
changes made the mci_for_each_dimm() loop is now save to release dimm
devices from sysfs.

The patch has been tested with the above kernel options, no issues
seen any longer.

Reported-by: John Garry <john.garry@huawei.com>
Fixes: c498afaf7df8 ("EDAC: Introduce an mci_for_each_dimm() iterator")
Fixes: faa2ad09c01c ("edac_mc: edac_mc_free() cannot assume mem_ctl_info is registered in sysfs.")
Fixes: 7a623c039075 ("edac: rewrite the sysfs code to use struct device")
Signed-off-by: Robert Richter <rrichter@marvell.com>
Acked-by: Aristeu Rozanski <aris@redhat.com>
Signed-off-by: Robert Richter <rrichter@marvell.com>
---
V2:
 * added Fixes tags,
 * added Aristeu's ACK,
 * reworded patch description,
 * no code changes
---
 drivers/edac/edac_mc.c       |  20 +++----
 drivers/edac/edac_mc_sysfs.c | 100 +++++++++++++----------------------
 drivers/edac/edac_module.h   |   1 -
 3 files changed, 49 insertions(+), 72 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 7243b88f81d8..058efcd9032e 100644
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
@@ -505,16 +514,9 @@ void edac_mc_free(struct mem_ctl_info *mci)
 {
 	edac_dbg(1, "\n");
 
-	/* If we're not yet registered with sysfs free only what was allocated
-	 * in edac_mc_alloc().
-	 */
-	if (!device_is_registered(&mci->dev)) {
-		_edac_mc_free(mci);
-		return;
-	}
+	edac_remove_sysfs_mci_device(mci);
 
-	/* the mci instance is freed here, when the sysfs object is dropped */
-	edac_unregister_sysfs(mci);
+	_edac_mc_free(mci);
 }
 EXPORT_SYMBOL_GPL(edac_mc_free);
 
diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 0367554e7437..408bace699dc 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -274,17 +274,8 @@ static const struct attribute_group *csrow_attr_groups[] = {
 	NULL
 };
 
-static void csrow_attr_release(struct device *dev)
-{
-	struct csrow_info *csrow = container_of(dev, struct csrow_info, dev);
-
-	edac_dbg(1, "device %s released\n", dev_name(dev));
-	kfree(csrow);
-}
-
 static const struct device_type csrow_attr_type = {
 	.groups		= csrow_attr_groups,
-	.release	= csrow_attr_release,
 };
 
 /*
@@ -390,6 +381,14 @@ static const struct attribute_group *csrow_dev_groups[] = {
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
@@ -408,6 +407,7 @@ static int edac_create_csrow_object(struct mem_ctl_info *mci,
 
 	csrow->dev.type = &csrow_attr_type;
 	csrow->dev.groups = csrow_dev_groups;
+	csrow->dev.release = csrow_release;
 	device_initialize(&csrow->dev);
 	csrow->dev.parent = &mci->dev;
 	csrow->mci = mci;
@@ -444,11 +444,8 @@ static int edac_create_csrow_objects(struct mem_ctl_info *mci)
 
 error:
 	for (--i; i >= 0; i--) {
-		csrow = mci->csrows[i];
-		if (!nr_pages_per_csrow(csrow))
-			continue;
-
-		device_del(&mci->csrows[i]->dev);
+		if (device_is_registered(&mci->csrows[i]->dev))
+			device_unregister(&mci->csrows[i]->dev);
 	}
 
 	return err;
@@ -457,15 +454,13 @@ static int edac_create_csrow_objects(struct mem_ctl_info *mci)
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
@@ -606,19 +601,18 @@ static const struct attribute_group *dimm_attr_groups[] = {
 	NULL
 };
 
-static void dimm_attr_release(struct device *dev)
-{
-	struct dimm_info *dimm = container_of(dev, struct dimm_info, dev);
-
-	edac_dbg(1, "device %s released\n", dev_name(dev));
-	kfree(dimm);
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
@@ -627,6 +621,7 @@ static int edac_create_dimm_object(struct mem_ctl_info *mci,
 	dimm->mci = mci;
 
 	dimm->dev.type = &dimm_attr_type;
+	dimm->dev.release = dimm_release;
 	device_initialize(&dimm->dev);
 
 	dimm->dev.parent = &mci->dev;
@@ -891,17 +886,8 @@ static const struct attribute_group *mci_attr_groups[] = {
 	NULL
 };
 
-static void mci_attr_release(struct device *dev)
-{
-	struct mem_ctl_info *mci = container_of(dev, struct mem_ctl_info, dev);
-
-	edac_dbg(1, "device %s released\n", dev_name(dev));
-	kfree(mci);
-}
-
 static const struct device_type mci_attr_type = {
 	.groups		= mci_attr_groups,
-	.release	= mci_attr_release,
 };
 
 /*
@@ -920,8 +906,6 @@ int edac_create_sysfs_mci_device(struct mem_ctl_info *mci,
 
 	/* get the /sys/devices/system/edac subsys reference */
 	mci->dev.type = &mci_attr_type;
-	device_initialize(&mci->dev);
-
 	mci->dev.parent = mci_pdev;
 	mci->dev.groups = groups;
 	dev_set_name(&mci->dev, "mc%d", mci->mc_idx);
@@ -931,7 +915,7 @@ int edac_create_sysfs_mci_device(struct mem_ctl_info *mci,
 	err = device_add(&mci->dev);
 	if (err < 0) {
 		edac_dbg(1, "failure: create device %s\n", dev_name(&mci->dev));
-		put_device(&mci->dev);
+		/* no put_device() here, free mci with _edac_mc_free() */
 		return err;
 	}
 
@@ -947,24 +931,20 @@ int edac_create_sysfs_mci_device(struct mem_ctl_info *mci,
 
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
@@ -976,6 +956,9 @@ void edac_remove_sysfs_mci_device(struct mem_ctl_info *mci)
 {
 	struct dimm_info *dimm;
 
+	if (!device_is_registered(&mci->dev))
+		return;
+
 	edac_dbg(0, "\n");
 
 #ifdef CONFIG_EDAC_DEBUG
@@ -986,17 +969,14 @@ void edac_remove_sysfs_mci_device(struct mem_ctl_info *mci)
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
@@ -1010,9 +990,6 @@ static void mc_attr_release(struct device *dev)
 	kfree(dev);
 }
 
-static const struct device_type mc_attr_type = {
-	.release	= mc_attr_release,
-};
 /*
  * Init/exit code for the module. Basically, creates/removes /sys/class/rc
  */
@@ -1025,11 +1002,10 @@ int __init edac_mc_sysfs_init(void)
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

