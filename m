Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3839B1B43AE
	for <lists+linux-edac@lfdr.de>; Wed, 22 Apr 2020 13:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgDVL7i (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 22 Apr 2020 07:59:38 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:1896 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728262AbgDVL7e (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 22 Apr 2020 07:59:34 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03MBpHUD031930;
        Wed, 22 Apr 2020 04:59:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=pfpt0818;
 bh=mcDQEeW2rakWfmNe9ZMrfIjiaxOcVDiG2lohL2UMB1s=;
 b=yO1hMcZIUArBL6NUHGcEO9iwseCEAJpWpJUVrG8fAUkhAeieGM0/+dyJB+yiM96RDriz
 hGRwTwvXR0c9DO2G7p01bdlx/6nVfmY6BXeVpcuR6m6uRwE9bcOfcYDGrZKRFr1eHs1J
 LRtwU50XQ/Bl+rROYIT2PTqf+h4LMo0zRCXBRtCqX/3P84QqyX9r3/7MnuJ5+5vawJbR
 Yem6ltolt2APTLgKS/QNjeRkLLx6mAqLxMcKh2O6ZUhpcXphBd+osoTDBtc9GXR7hSGy
 uXm6D6nJXmac5EW/K7dtZbx1JZfoSMmT0zuHBv+4JYGSCdwxDBp+NcMDa4C4213qj2Oy rw== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 30jd011w4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 22 Apr 2020 04:58:59 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 22 Apr
 2020 04:58:57 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 22 Apr 2020 04:58:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhUrwLp1Uj0fE785sJxWICkUXmnjXb8uCvnEUe6Sg9zGhb3J02YcgA7a4yhkLm3qTe72Q2sS0encglx/3tiYd6VWmfDOyPm4MMr9F6ITWKRk9U6ssz/lWNXCkWMCxlYPEXB3ILQg4l60K2IiPRYCeCjdX3KaPTSw7k493RuXPt0131XIW0GPVPeUDNEN/igSQf7hKaiIqiJo9oM0imR8pKfQRu6tZ4621DIsbYhl9ZEq4LkwfkSvKNyS445b7pzFzyX/li0CzmldepFHBwegTFQtRZtXjFomJlIRif/AbHAvzjrGOEka1iYhyRXb5k0cQKQ1tddDmgPY0nNs1RUzpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcDQEeW2rakWfmNe9ZMrfIjiaxOcVDiG2lohL2UMB1s=;
 b=M7kQ+gx+Dp/J5ebN3qz412foFc/2LOUSY3xo2ljFf+u9VjjKM56pnfy6OB4siu9qw8cbh4ufOd3waGRLUIunGuPQaAytlZPCJWuQwv7tbeHaUN5iE6Q2jChrDBYJpTulxHbibBUWnqLQ7RGSEPOWE9GToHllKjW7dwqllVExjB4R9NNnFlrnHqXW5EMrsERuKLi21peOzPxu+p/pN/6cuKqp36rVrwW36kQY6QFSszBhsOZH5wUSEc04LjdXtCtYBeYJ4V00COyxDbBIcq3TPz6/PjsHKFhnHExk7rQvGWWqUVVOjXmMYv2UwPFq5xayvhyCIlRcZ8qrQQvNOX6iAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcDQEeW2rakWfmNe9ZMrfIjiaxOcVDiG2lohL2UMB1s=;
 b=EfuhOnomuxIRpjVFFip9eR7fColk3vHmcjRG58KZlOgC5IL3etPcFOcs1B+RZ1Agi5nvIxR6bCI0V7WzLNmz6SGlMu+TfupIUNa2L2MYbYA7MYMGJ+hML1noMre6RWes1INUNJwj1S/qEY3MAXzCr+08rTH5tMXtetC1dlc7SIM=
Received: from BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
 by BYAPR18MB2933.namprd18.prod.outlook.com (2603:10b6:a03:10e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Wed, 22 Apr
 2020 11:58:56 +0000
Received: from BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d]) by BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d%7]) with mapi id 15.20.2921.030; Wed, 22 Apr 2020
 11:58:56 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        Matthias Brugger <mbrugger@suse.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 04/10] EDAC/ghes: Make SMBIOS handle private data to ghes
Date:   Wed, 22 Apr 2020 13:58:08 +0200
Message-ID: <20200422115814.22205-5-rrichter@marvell.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422115814.22205-1-rrichter@marvell.com>
References: <20200422115814.22205-1-rrichter@marvell.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0701CA0076.eurprd07.prod.outlook.com
 (2603:10a6:3:64::20) To BYAPR18MB2661.namprd18.prod.outlook.com
 (2603:10b6:a03:136::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR0701CA0076.eurprd07.prod.outlook.com (2603:10a6:3:64::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.6 via Frontend Transport; Wed, 22 Apr 2020 11:58:54 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3913935-426d-4fc6-35e1-08d7e6b4890c
X-MS-TrafficTypeDiagnostic: BYAPR18MB2933:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR18MB29332F617621C043F464205FD9D20@BYAPR18MB2933.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2661.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(366004)(396003)(39850400004)(376002)(136003)(6512007)(1076003)(6666004)(81156014)(8936002)(4326008)(6486002)(8676002)(2616005)(110136005)(52116002)(186003)(16526019)(86362001)(956004)(6506007)(66476007)(2906002)(66946007)(54906003)(26005)(66556008)(36756003)(5660300002)(478600001)(316002);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3CIqUyrj1a4OdepsfaVpnD/+3POwlW01A7HQTIpYf+IG0xN7XtZjhfgv0Ffw7ZEwnaMQGf5XFsRl3TeqxZ1v6swh4s0PLu3ZCViW6oW49wPmG5vzcNhcBdZ/Dck8u9WG6j3pV5Si2dnJor9odgOzJmXcKaqd7IUecYIsncQEfCg2fwpl7PoLxoka9JUfd2QqjoAFwD3UtH3XYRkXdaqcwczoGOho0nAo9LwtvkHh75gpZSaplVSwUcmEd0v1y3brb+81bN3BG8cr7EzooC7LcQECT7O46ck9RQYo+0Phs9dyeubyoVFoSndyCvt0HGB5MA7R9VMhyjAgRJVgr5KVpyajUcc54QvkoOZXRFl9gmn0BOjrbbM4AtewnnSfmPrF4Zu2p6pFd1wuAhoVDXfZ+EyKTU/+JHMFqf8FhQbRXP0VhGkueMyf0aJIqM90hECY
X-MS-Exchange-AntiSpam-MessageData: RGO1TdXau2xjcaNRI6PwldmELRJFkc0c8ZYoF2D9Y4hfT9aYSxPgdshPZK0GzChbEaDK3vETFst2uQfW6+ofL3kp9XWLCj4eMkIy21Rj3xSx6yhCVhajEfZfNOqgVDRIKLeusqwamrUBHGJnv3FMWQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: a3913935-426d-4fc6-35e1-08d7e6b4890c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 11:58:56.7383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y7/KhE7aGqJ6WzGw9WTuOmcwbUBJN+kCkeqf1mQULr+VDnfSvpdS0SKZDQSjj6+hl/ZyF4ILqvm64FmuO4v/uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2933
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-22_03:2020-04-22,2020-04-22 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

To identify a hw error's location, the ghes driver needs to know the
mapping between a DIMM and the used SMBIOS handle. The handle is
stored in struct dimm_info in the smbios_handle field where other
drivers carry it too. Make the SMBIOS handle private and implement an
own SMBIOS handle mapping table that is only used by the ghes
driver. As a consequence, smbios_handle is removed from struct
dimm_info.

The mapping table is implemented as a list. This makes the locking and
the allocation of table entries when adding or removing DIMMs much
easier. Since the list is accessed by the interrupt handler it must be
protected by a spinlock. Thanks to the use of a list, multiple entries
can be prepared in advance without a lock being held. Once ready, the
entries are added to an active list of DIMMs (ghes_dimm_list) by just
a single list operation that needs the locking. The same list entry is
also used for memory allocation, all entries are created at once using
a single array allocation and are put in a pool (ghes_dimm_pool) that
holds unused entries for later use.

While at it, rename struct ghes_edac_dimm_fill to struct dimm_fill.

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/ghes_edac.c | 117 ++++++++++++++++++++++++++++++++++-----
 include/linux/edac.h     |   2 -
 2 files changed, 104 insertions(+), 15 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 39efce0df881..23adb7674f9b 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -15,6 +15,12 @@
 #include "edac_module.h"
 #include <ras/ras_event.h>
 
+struct ghes_dimm {
+	struct list_head entry;
+	struct dimm_info *dimm;
+	u16 handle;
+};
+
 struct ghes_mci {
 	struct mem_ctl_info *mci;
 
@@ -42,6 +48,16 @@ static DEFINE_MUTEX(ghes_reg_mutex);
  */
 static DEFINE_SPINLOCK(ghes_lock);
 
+/*
+ * Locking:
+ *
+ *  dimms, ghes_dimm_pool:  ghes_reg_mutex
+ *  ghes_dimm_list:         ghes_lock
+ */
+static struct ghes_dimm *dimms;
+static LIST_HEAD(ghes_dimm_list);
+static LIST_HEAD(ghes_dimm_pool);
+
 /* "ghes_edac.force_load=1" skips the platform check */
 static bool __read_mostly force_load;
 module_param(force_load, bool, 0);
@@ -72,11 +88,63 @@ struct memdev_dmi_entry {
 	u16 conf_mem_clk_speed;
 } __attribute__((__packed__));
 
-struct ghes_edac_dimm_fill {
+struct dimm_fill {
+	struct list_head dimms;
 	struct mem_ctl_info *mci;
 	unsigned int count;
 };
 
+static int ghes_dimm_pool_create(int num_dimm)
+{
+	struct ghes_dimm *ghes_dimm;
+
+	if (!num_dimm)
+		return 0;
+
+	lockdep_assert_held(ghes_reg_mutex);
+
+	dimms = kcalloc(num_dimm, sizeof(*dimms), GFP_KERNEL);
+	if (!dimms)
+		return -ENOMEM;
+
+	for (ghes_dimm = dimms; ghes_dimm < dimms + num_dimm; ghes_dimm++)
+		list_add(&ghes_dimm->entry, &ghes_dimm_pool);
+
+	return 0;
+}
+
+static void ghes_dimm_pool_destroy(void)
+{
+	lockdep_assert_held(ghes_reg_mutex);
+	INIT_LIST_HEAD(&ghes_dimm_pool);
+	kfree(dimms);
+}
+
+static struct ghes_dimm *ghes_dimm_alloc(struct dimm_info *dimm, u16 handle)
+{
+	struct ghes_dimm *ghes_dimm;
+
+	lockdep_assert_held(ghes_reg_mutex);
+
+	ghes_dimm = list_first_entry_or_null(&ghes_dimm_pool,
+					struct ghes_dimm, entry);
+
+	/* should be always non-zero */
+	if (!WARN_ON_ONCE(!ghes_dimm)) {
+		ghes_dimm->dimm = dimm;
+		ghes_dimm->handle = handle;
+		list_del(&ghes_dimm->entry);
+	}
+
+	return ghes_dimm;
+}
+
+static void ghes_dimm_release(struct list_head *dimms)
+{
+	lockdep_assert_held(ghes_reg_mutex);
+	list_splice(dimms, &ghes_dimm_pool);
+}
+
 static void ghes_edac_count_dimms(const struct dmi_header *dh, void *arg)
 {
 	int *num_dimm = arg;
@@ -85,13 +153,15 @@ static void ghes_edac_count_dimms(const struct dmi_header *dh, void *arg)
 		(*num_dimm)++;
 }
 
-static int get_dimm_smbios_index(struct mem_ctl_info *mci, u16 handle)
+static int get_dimm_smbios_index(u16 handle)
 {
-	struct dimm_info *dimm;
+	struct ghes_dimm *ghes_dimm;
 
-	mci_for_each_dimm(mci, dimm) {
-		if (dimm->smbios_handle == handle)
-			return dimm->idx;
+	lockdep_assert_held(&ghes_lock);
+
+	list_for_each_entry(ghes_dimm, &ghes_dimm_list, entry) {
+		if (ghes_dimm->handle == handle)
+			return ghes_dimm->dimm->idx;
 	}
 
 	return -1;
@@ -99,8 +169,9 @@ static int get_dimm_smbios_index(struct mem_ctl_info *mci, u16 handle)
 
 static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
 {
-	struct ghes_edac_dimm_fill *dimm_fill = arg;
+	struct dimm_fill *dimm_fill = arg;
 	struct mem_ctl_info *mci = dimm_fill->mci;
+	struct ghes_dimm *ghes_dimm;
 
 	if (dh->type == DMI_ENTRY_MEM_DEVICE) {
 		struct memdev_dmi_entry *entry = (struct memdev_dmi_entry *)dh;
@@ -191,7 +262,10 @@ static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
 				entry->total_width, entry->data_width);
 		}
 
-		dimm->smbios_handle = entry->handle;
+
+		ghes_dimm = ghes_dimm_alloc(dimm, entry->handle);
+		if (ghes_dimm)
+			list_add_tail(&ghes_dimm->entry, &dimm_fill->dimms);
 
 		dimm_fill->count++;
 	}
@@ -352,7 +426,7 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 			p += sprintf(p, "DIMM DMI handle: 0x%.4x ",
 				     mem_err->mem_dev_handle);
 
-		index = get_dimm_smbios_index(mci, mem_err->mem_dev_handle);
+		index = get_dimm_smbios_index(mem_err->mem_dev_handle);
 		if (index >= 0)
 			e->top_layer = index;
 	}
@@ -457,7 +531,7 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	struct mem_ctl_info *mci;
 	struct ghes_mci *pvt;
 	struct edac_mc_layer layers[1];
-	struct ghes_edac_dimm_fill dimm_fill;
+	struct dimm_fill dimm_fill;
 	unsigned long flags;
 	int idx = -1;
 
@@ -482,6 +556,10 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	/* Get the number of DIMMs */
 	dmi_walk(ghes_edac_count_dimms, &num_dimm);
 
+	rc = ghes_dimm_pool_create(num_dimm);
+	if (rc < 0)
+		goto unlock;
+
 	/* Check if we've got a bogus BIOS */
 	if (num_dimm == 0) {
 		fake = true;
@@ -494,7 +572,6 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 
 	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, sizeof(*pvt));
 	if (!mci) {
-		pr_info("Can't allocate memory for EDAC data\n");
 		rc = -ENOMEM;
 		goto unlock;
 	}
@@ -523,6 +600,8 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 		pr_info("This system has %d DIMM sockets.\n", num_dimm);
 	}
 
+	INIT_LIST_HEAD(&dimm_fill.dimms);
+
 	if (!fake) {
 		dimm_fill.count = 0;
 		dimm_fill.mci = mci;
@@ -539,7 +618,7 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 
 	rc = edac_mc_add_mc(mci);
 	if (rc < 0) {
-		pr_info("Can't register at EDAC core\n");
+		ghes_dimm_release(&dimm_fill.dimms);
 		edac_mc_free(mci);
 		rc = -ENODEV;
 		goto unlock;
@@ -547,12 +626,18 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 
 	spin_lock_irqsave(&ghes_lock, flags);
 	ghes_pvt = pvt;
+	list_splice_tail(&dimm_fill.dimms, &ghes_dimm_list);
 	spin_unlock_irqrestore(&ghes_lock, flags);
 
 	/* only set on success */
 	refcount_set(&ghes_refcount, 1);
 
 unlock:
+	if (rc < 0) {
+		ghes_dimm_pool_destroy();
+		pr_err("Can't register at EDAC core: %d\n", rc);
+	}
+
 	mutex_unlock(&ghes_reg_mutex);
 
 	return rc;
@@ -562,6 +647,7 @@ void ghes_edac_unregister(struct ghes *ghes)
 {
 	struct mem_ctl_info *mci;
 	unsigned long flags;
+	LIST_HEAD(dimm_list);
 
 	mutex_lock(&ghes_reg_mutex);
 
@@ -574,14 +660,19 @@ void ghes_edac_unregister(struct ghes *ghes)
 	spin_lock_irqsave(&ghes_lock, flags);
 	mci = ghes_pvt ? ghes_pvt->mci : NULL;
 	ghes_pvt = NULL;
+	list_splice_init(&ghes_dimm_list, &dimm_list);
 	spin_unlock_irqrestore(&ghes_lock, flags);
 
+	ghes_dimm_release(&dimm_list);
+
 	if (!mci)
 		goto unlock;
 
 	mci = edac_mc_del_mc(mci->pdev);
-	if (mci)
+	if (mci) {
 		edac_mc_free(mci);
+		ghes_dimm_pool_destroy();
+	}
 
 unlock:
 	mutex_unlock(&ghes_reg_mutex);
diff --git a/include/linux/edac.h b/include/linux/edac.h
index 0f20b986b0ab..6b7f594782c0 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -382,8 +382,6 @@ struct dimm_info {
 
 	unsigned int csrow, cschannel;	/* Points to the old API data */
 
-	u16 smbios_handle;              /* Handle for SMBIOS type 17 */
-
 	u32 ce_count;
 	u32 ue_count;
 };
-- 
2.20.1

