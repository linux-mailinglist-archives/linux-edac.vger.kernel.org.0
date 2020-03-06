Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD90117C179
	for <lists+linux-edac@lfdr.de>; Fri,  6 Mar 2020 16:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgCFPOM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 6 Mar 2020 10:14:12 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:36422 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727286AbgCFPOK (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 6 Mar 2020 10:14:10 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 026F6JCX006235;
        Fri, 6 Mar 2020 07:14:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=pfpt0818;
 bh=WyEsVUdfegU/+xkzwxcKiWbP84ejy1XU449EzvjftUk=;
 b=NXByvL/PQL7YJgZMYUdT/GpPw5JQOBpjuwFDcZvMZvyTBo/1QiUz0H863DCCgdJGSpVL
 gCJkfsUD0N+qCb3eRakWhfUXzYn/Abkmmk6CP0JXOSQuGOP7TOWsm86WKqL2Ee/2tVVL
 XPtm3BKfVjVf4wDgkSInHKs/l7O9XAQp0Bpe1eiDYZCjSbw7+0lJpAfyoFSG/nwTiKZe
 SGey9AFzBqLhopeNaZSAVFJpC6gXo4u8R/s15ImpWY+2MAy7tnw4JMmT7Ex1DO6butK9
 qU9IZ1bmBVHAhYdk2dAslW+kH2Rjecbucoky0uX1MolV16Iql9tlhCmLM1i3sLwIe2QA Rw== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2yhn0ydfwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 06 Mar 2020 07:14:00 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 6 Mar
 2020 07:13:58 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 6 Mar 2020 07:13:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTRen1PaORZcOV7JG0nVAxfm3/F2s2INdnQIJCHsCxosGKAxClmwTQJjRi3amBKjZphSXqjWLcvspLtBWTv3r2zvgAzqPp8SRnWL1tFp7OXhLA6L+6Dzq03RVDjiN4wkoR6uJdEy25fH8sIuMiJ4cGZWNDci+T4M5EJjTcbS5vcd7AjFOkbKU3LfPVyP5KToWLVOPL3lN62/rjIhdDUO6pr/zi3he826PDGNzQnDkyhPAUR2lOL9OrNCAbGURNP3ljzqxyBLYdAE+uNg1IiasGHCry3TcR/KAjJXL3b+r6q1wP+AsAYjFf3wFFnj6y/PtaE/qGrZg8yARVNsD0xaDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyEsVUdfegU/+xkzwxcKiWbP84ejy1XU449EzvjftUk=;
 b=aswz8kZjXFUJkVEawQTRg4ZrcrUlKeghLV3UVLAmpZJvFNFelSRPMgRQipF4bDy7JEbmq+U0XabllfGvWtXLbpNCBkG104LAp83ztwbsDB/ZT0mhL5IM8ZHAOx8BioN5fog7yIxUeL0vn+SxVpCskdqithXlgOD5/g8GPfuzcGi7FqI9wbxwG8SzA7j7EgYrM5Mwv2VblVW0ihHEoY4guOlsc2hT+F1aqvhb1apXJwcFZ2nOwijb8qDZH6GS6z3VsX1YjZ6aSqWKAIq6WbuXqFQcy7yTnpGmhwkjPr/wcqy+qbQZopjsLTsqfTwV4woktNODw1uw8ixM3C0yu93JHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyEsVUdfegU/+xkzwxcKiWbP84ejy1XU449EzvjftUk=;
 b=iVIjOkU0+hypkWdjDzIvBxUVoghTFQiYukDfbJt2WqOgUAGDcp92XyWPiRR9gn2noR06hmTkqqZHdVGeNJe7J4IOCrgOPRFdLiJKYgTS8bIc71dZfdRb/t2oLhv+HSEfPCn++KdU+oCy5FOWRbCAaFTOBfZGvTY9YbiO3k5JC3A=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (2603:10b6:208:165::10)
 by MN2PR18MB2400.namprd18.prod.outlook.com (2603:10b6:208:ab::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14; Fri, 6 Mar
 2020 15:13:57 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::30c4:52fe:fdf8:faff]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::30c4:52fe:fdf8:faff%7]) with mapi id 15.20.2793.013; Fri, 6 Mar 2020
 15:13:57 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 09/11] EDAC/ghes: Implement DIMM mapping table for SMBIOS handles
Date:   Fri,  6 Mar 2020 16:13:16 +0100
Message-ID: <20200306151318.17422-10-rrichter@marvell.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200306151318.17422-1-rrichter@marvell.com>
References: <20200306151318.17422-1-rrichter@marvell.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0102CA0059.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::36) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR0102CA0059.eurprd01.prod.exchangelabs.com (2603:10a6:7:7d::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend Transport; Fri, 6 Mar 2020 15:13:55 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7f19eff-0e22-4f80-c9e6-08d7c1e0fd92
X-MS-TrafficTypeDiagnostic: MN2PR18MB2400:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR18MB2400A0BA15990800CACDB451D9E30@MN2PR18MB2400.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 0334223192
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(199004)(189003)(81156014)(81166006)(5660300002)(8676002)(6666004)(54906003)(26005)(956004)(2616005)(4326008)(16526019)(316002)(110136005)(186003)(2906002)(8936002)(86362001)(6512007)(36756003)(478600001)(6486002)(1076003)(30864003)(66556008)(52116002)(66946007)(66476007)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2400;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CRKevz8M0eTgKSzrKwTpogUtVNt7aB5FquA5cOp5iW9MENSXYzvf8VNjdduJ1o8SiDkdnXslOTgoFR5bB+H9Ft0BvILJccnqaPl9CoHVYbZkjsTpR2nsefw1jWYheo4tD718bXKJtpz9G+sSBOMWBT7zXXBNTWfKBfN/hOtCnNYbX9iR6/HQDNk8O9u2wJeZJlb/i1rihTG+pGkkhMpt8RH+XJxHi/fOTL2wfnXnflaVHNtcBzLFrRkQUXbtfeCFT7qw2zU2J0hzyvb77H0kBNU4HWWVZRMNJ/Eha0CEejNU4F1wg1nGlPc3JFTRuOcjZk5PAczSckqGke5d8KPj/d8vhNdWBDGvLd6ueK4VKIA8seMMnHh7Om2GfugLO+QPb3d+7dk7S9AfCVb+LOS7PYKnQmsdKyc3OKQ75WMwu35VdW8Jh1rs+emXQ/MzDFeU
X-MS-Exchange-AntiSpam-MessageData: Xtc0EaLAAEnU7P1Zd9jz2s8D+D5AI34/yltK2a3uifum+1ikAZ5KIk4oeiklSyl/9VGuC5alZqjIJnhCktrR3suWTh+9W97w/9ZzCLJrhPqNi6I4ni4oj8yInoC2Vfrvt7dGRvyxm28YEkl4decYYA==
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f19eff-0e22-4f80-c9e6-08d7c1e0fd92
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2020 15:13:56.9733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xWAhYg0a91NrU+clZoWyHcAiH1qxp/6Li3V8K21rxTLZEKxJEvuKnJ2XdK0qqsq4LKKw6P+6x7Nb/HD+JeRK2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2400
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-06_04:2020-03-06,2020-03-06 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

GHES uses SMBIOS handles to identify the DIMM that was causing a hw
error. Currently this is stored in smbios_handle of struct dimm_info.
This implementation has several drawbacks. The information is private
to the ghes driver, but struct dimm_info is for general use. The DIMMs
are tied to a *mci struct, which makes a lockup inefficient. It is
hard to dynamically allocate DIMMs and also to meet locking
constraints when adding or removing them. This becomes even more
challenging when having multiple MC instances that group a set of
DIMMs, so the change is needed also to later support multiple MC
instances.

Add an own mapping table for the ghes driver to solve these issues.
The DIMM data is collected in struct ghes_dimm. A data array exists
for all DIMMs found in the system. Lists are used to maintain the DIMM
entries, during initialization they are all added to a pool of
available data structs. Using list entries makes locking easy as only
list operations need to be locked by either the ghes_reg_mutex or
ghes_lock.

There are a couple of helper functions to maintain the dimm list:

 ghes_dimm_init()/ghes_dimm_free():       create/remove the list
 ghes_dimm_alloc()/ghes_dimm_release():   add/remove list entries
 get_default_mci()/find_dimm_by_handle(): lockup a MC or DIMM

The lists are used to identify the corresponding *mci and *dimm_info
structs in the hw error interrupt handler. Esp. the *ghes_pvt pointer
is obsolete now, so *mci can be removed from struct ghes_mci.

The mapping table of the ghes driver makes smbios_handle in struct
dimm_info also obsolete, remove it too.

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/ghes_edac.c | 172 +++++++++++++++++++++++++++++++--------
 include/linux/edac.h     |   2 -
 2 files changed, 136 insertions(+), 38 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 0af7f6a988a9..cd61b8ae49f6 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -15,9 +15,13 @@
 #include "edac_module.h"
 #include <ras/ras_event.h>
 
-struct ghes_mci {
-	struct mem_ctl_info *mci;
+struct ghes_dimm {
+	struct list_head entry;
+	struct dimm_info *dimm;
+	u16 handle;
+};
 
+struct ghes_mci {
 	/* Buffers for the error handling routine */
 	char other_detail[400];
 	char msg[80];
@@ -26,22 +30,25 @@ struct ghes_mci {
 static refcount_t ghes_refcount = REFCOUNT_INIT(0);
 
 /*
- * Access to ghes_pvt must be protected by ghes_lock. The spinlock
- * also provides the necessary (implicit) memory barrier for the SMP
- * case to make the pointer visible on another CPU.
+ * GHES registration mutex: Serialize registration/unregistration
+ * code, protect ghes_dimm_pool and *dimms.
+ *
  */
-static struct ghes_mci *ghes_pvt;
-
-/* GHES registration mutex */
 static DEFINE_MUTEX(ghes_reg_mutex);
 
 /*
  * Sync with other, potentially concurrent callers of
  * ghes_edac_report_mem_error(). We don't know what the
  * "inventive" firmware would do.
+ *
+ * ghes_dimm_list must be protected by ghes_lock.
  */
 static DEFINE_SPINLOCK(ghes_lock);
 
+static struct ghes_dimm *dimms;
+static LIST_HEAD(ghes_dimm_list);
+static LIST_HEAD(ghes_dimm_pool);
+
 /* "ghes_edac.force_load=1" skips the platform check */
 static bool __read_mostly force_load;
 module_param(force_load, bool, 0);
@@ -72,6 +79,52 @@ struct memdev_dmi_entry {
 	u16 conf_mem_clk_speed;
 } __attribute__((__packed__));
 
+/* ghes_reg_mutex must be held. */
+static int ghes_dimm_init(int num_dimm)
+{
+	struct ghes_dimm *ghes_dimm;
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
+/* ghes_reg_mutex must be held. */
+static void ghes_dimm_free(void)
+{
+	INIT_LIST_HEAD(&ghes_dimm_pool);
+	kfree(dimms);
+}
+
+/* ghes_reg_mutex must be held. */
+static struct ghes_dimm *ghes_dimm_alloc(struct dimm_info *dimm, u16 handle)
+{
+	struct ghes_dimm *ghes_dimm;
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
+/* ghes_reg_mutex must be held. */
+static void ghes_dimm_release(struct list_head *dimms)
+{
+	list_splice(dimms, &ghes_dimm_pool);
+}
+
 static void ghes_edac_count_dimms(const struct dmi_header *dh, void *arg)
 {
 	int *num_dimm = arg;
@@ -80,14 +133,30 @@ static void ghes_edac_count_dimms(const struct dmi_header *dh, void *arg)
 		(*num_dimm)++;
 }
 
-static struct dimm_info *find_dimm_by_handle(struct mem_ctl_info *mci,
-					u16 handle)
+/*
+ * Make first DIMM's MC the default to report errors in case
+ * no DIMM for the mem device handle is found.
+ *
+ * ghes_lock must be held.
+ */
+static struct mem_ctl_info *get_default_mci(void)
 {
-	struct dimm_info *dimm;
+	struct ghes_dimm *ghes_dimm;
+
+	ghes_dimm = list_first_entry_or_null(&ghes_dimm_list,
+					struct ghes_dimm, entry);
+
+	return ghes_dimm ? ghes_dimm->dimm->mci : NULL;
+}
+
+/* ghes_lock must be held as long as struct ghes_info is used */
+static struct dimm_info *find_dimm_by_handle(u16 handle)
+{
+	struct ghes_dimm *ghes_dimm;
 
-	mci_for_each_dimm(mci, dimm) {
-		if (dimm->smbios_handle == handle)
-			return dimm;
+	list_for_each_entry(ghes_dimm, &ghes_dimm_list, entry) {
+		if (ghes_dimm->handle == handle)
+			return ghes_dimm->dimm;
 	}
 
 	return NULL;
@@ -109,6 +178,7 @@ static void ghes_dimm_setup_label(struct dimm_info *dimm, u16 handle)
 }
 
 struct ghes_dimm_fill {
+	struct list_head dimms;
 	struct mem_ctl_info *mci;
 	int index;
 };
@@ -121,6 +191,11 @@ static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
 	if (dh->type == DMI_ENTRY_MEM_DEVICE) {
 		struct memdev_dmi_entry *entry = (struct memdev_dmi_entry *)dh;
 		struct dimm_info *dimm = edac_get_dimm(mci, dimm_fill->index, 0, 0);
+		struct ghes_dimm *ghes_dimm;
+
+		ghes_dimm = ghes_dimm_alloc(dimm, entry->handle);
+		if (ghes_dimm)
+			list_add_tail(&ghes_dimm->entry, &dimm_fill->dimms);
 
 		if (entry->size == 0xffff) {
 			pr_info("Can't get DIMM%i size\n",
@@ -205,8 +280,6 @@ static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
 				entry->total_width, entry->data_width);
 		}
 
-		dimm->smbios_handle = entry->handle;
-
 		dimm_fill->index++;
 	}
 }
@@ -214,6 +287,7 @@ static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
 void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 {
 	struct edac_raw_error_desc *e;
+	struct dimm_info *dimm = NULL;
 	struct mem_ctl_info *mci;
 	struct ghes_mci *pvt;
 	unsigned long flags;
@@ -229,11 +303,14 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 
 	spin_lock_irqsave(&ghes_lock, flags);
 
-	pvt = ghes_pvt;
-	if (!pvt)
+	if (mem_err->validation_bits & CPER_MEM_VALID_MODULE_HANDLE)
+		dimm = find_dimm_by_handle(mem_err->mem_dev_handle);
+
+	mci = dimm ? dimm->mci : get_default_mci();
+	if (!mci)
 		goto unlock;
 
-	mci = pvt->mci;
+	pvt = mci->pvt_info;
 	e = &mci->error_desc;
 
 	/* Cleans the error report buffer */
@@ -356,9 +433,6 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 	if (mem_err->validation_bits & CPER_MEM_VALID_BIT_POSITION)
 		p += sprintf(p, "bit_pos:%d ", mem_err->bit_pos);
 	if (mem_err->validation_bits & CPER_MEM_VALID_MODULE_HANDLE) {
-		struct dimm_info *dimm;
-
-		dimm = find_dimm_by_handle(mci, mem_err->mem_dev_handle);
 		if (dimm) {
 			e->top_layer = dimm->idx;
 			strcpy(e->label, dimm->label);
@@ -477,8 +551,7 @@ static struct mem_ctl_info *ghes_mc_create(struct device *dev, int mc_idx,
 	if (!mci)
 		return NULL;
 
-	pvt		= mci->pvt_info;
-	pvt->mci	= mci;
+	pvt = mci->pvt_info;
 
 	mci->pdev = dev;
 	mci->mtype_cap = MEM_FLAG_EMPTY;
@@ -491,19 +564,21 @@ static struct mem_ctl_info *ghes_mc_create(struct device *dev, int mc_idx,
 	return mci;
 }
 
-static int ghes_mc_add_or_free(struct mem_ctl_info *mci)
+static int ghes_mc_add_or_free(struct mem_ctl_info *mci,
+			struct list_head *dimms)
 {
 	unsigned long flags;
 	int rc;
 
 	rc = edac_mc_add_mc(mci);
 	if (rc < 0) {
+		ghes_dimm_release(dimms);
 		edac_mc_free(mci);
 		return rc;
 	}
 
 	spin_lock_irqsave(&ghes_lock, flags);
-	ghes_pvt = mci->pvt_info;
+	list_splice_tail(dimms, &ghes_dimm_list);
 	spin_unlock_irqrestore(&ghes_lock, flags);
 
 	return 0;
@@ -511,17 +586,25 @@ static int ghes_mc_add_or_free(struct mem_ctl_info *mci)
 
 static void ghes_mc_free(void)
 {
-	struct mem_ctl_info *mci;
+	struct ghes_dimm *ghes_dimm, *tmp;
+	struct mem_ctl_info *mci = NULL;
+	LIST_HEAD(dimm_list);
 	unsigned long flags;
 
-	/*
-	 * Wait for the irq handler being finished.
-	 */
 	spin_lock_irqsave(&ghes_lock, flags);
-	mci = ghes_pvt ? ghes_pvt->mci : NULL;
-	ghes_pvt = NULL;
+
+	list_for_each_entry_safe(ghes_dimm, tmp, &ghes_dimm_list, entry) {
+		mci = mci ?: ghes_dimm->dimm->mci;
+		WARN_ON_ONCE(mci != ghes_dimm->dimm->mci);
+		list_move_tail(&ghes_dimm->entry, &dimm_list);
+	}
+
+	WARN_ON_ONCE(!list_empty(&ghes_dimm_list));
+
 	spin_unlock_irqrestore(&ghes_lock, flags);
 
+	ghes_dimm_release(&dimm_list);
+
 	if (!mci)
 		return;
 
@@ -532,8 +615,10 @@ static void ghes_mc_free(void)
 
 static int ghes_edac_register_fake(struct device *dev)
 {
+	struct ghes_dimm *ghes_dimm;
 	struct mem_ctl_info *mci;
 	struct dimm_info *dimm;
+	LIST_HEAD(dimm_list);
 
 	mci = ghes_mc_create(dev, 0, 1);
 	if (!mci)
@@ -549,7 +634,11 @@ static int ghes_edac_register_fake(struct device *dev)
 
 	snprintf(dimm->label, sizeof(dimm->label), "unknown memory");
 
-	return ghes_mc_add_or_free(mci);
+	ghes_dimm = ghes_dimm_alloc(dimm, 0xffff);
+	if (ghes_dimm)
+		list_add_tail(&ghes_dimm->entry, &dimm_list);
+
+	return ghes_mc_add_or_free(mci, &dimm_list);
 }
 
 static int ghes_edac_register_one(struct device *dev, int mc_idx, int num_dimm)
@@ -563,9 +652,11 @@ static int ghes_edac_register_one(struct device *dev, int mc_idx, int num_dimm)
 
 	dimm_fill.index = 0;
 	dimm_fill.mci = mci;
+	INIT_LIST_HEAD(&dimm_fill.dimms);
+
 	dmi_walk(ghes_edac_dmidecode, &dimm_fill);
 
-	return ghes_mc_add_or_free(mci);
+	return ghes_mc_add_or_free(mci, &dimm_fill.dimms);
 }
 
 int ghes_edac_register(struct ghes *ghes, struct device *dev)
@@ -594,6 +685,10 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	/* Get the number of DIMMs */
 	dmi_walk(ghes_edac_count_dimms, &num_dimm);
 
+	rc = ghes_dimm_init(num_dimm ?: 1);
+	if (rc)
+		goto unlock;
+
 	if (!num_dimm) {
 		/*
 		 * Bogus BIOS: Ignore DMI topology and use a single MC
@@ -629,8 +724,11 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	refcount_set(&ghes_refcount, 1);
 
 unlock:
-	if (rc)
+	if (rc) {
+		ghes_mc_free();
+		ghes_dimm_free();
 		pr_err("Can't register at EDAC core: %d\n", rc);
+	}
 
 	mutex_unlock(&ghes_reg_mutex);
 
@@ -641,8 +739,10 @@ void ghes_edac_unregister(struct ghes *ghes)
 {
 	mutex_lock(&ghes_reg_mutex);
 
-	if (refcount_dec_and_test(&ghes_refcount))
+	if (refcount_dec_and_test(&ghes_refcount)) {
 		ghes_mc_free();
+		ghes_dimm_free();
+	}
 
 	mutex_unlock(&ghes_reg_mutex);
 }
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

