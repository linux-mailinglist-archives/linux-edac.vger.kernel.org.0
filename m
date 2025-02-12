Return-Path: <linux-edac+bounces-3050-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4582A328CC
	for <lists+linux-edac@lfdr.de>; Wed, 12 Feb 2025 15:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 777053A95D6
	for <lists+linux-edac@lfdr.de>; Wed, 12 Feb 2025 14:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5CE256C8C;
	Wed, 12 Feb 2025 14:37:51 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2519211480;
	Wed, 12 Feb 2025 14:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739371071; cv=none; b=l30QlLqj/1Hhciq9m7CAJ17TvRkaXy7LdS51uyqCUlbImBYvAb+wyjQHB5s1G4VKyDPAYVPOqJ6537/MfMS0O6/D7Wi2yeMlw1+9eOZJANU8VZLpivjSVJWHSWP0iyifeg3//co5PyOly0xC6RDvESnPPAApRkZv+8/yMr3K/Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739371071; c=relaxed/simple;
	bh=y5OaM0pA8ktXTg19wMzL1my9wxCnfCRuuZuoa5HKbns=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bJUTMcmf5LumbQgfIgtlUiSmTykguTxa/I6mNXTC5Q3CBg+JwSF29Qd9tPPdsueq/i+7WrTwJw8ulWjSAtDbHdNZQD5Kfww+eW83/B7pCG4SFOWtUvaWe68jWucU++fsPc4m5BZ1MyZgaDCU0sjzAj3ozMocydY+j/wOp1YZwjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YtLSp2WVGz6J7gf;
	Wed, 12 Feb 2025 22:35:22 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id B78A11402A4;
	Wed, 12 Feb 2025 22:37:47 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.169.206) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Feb 2025 15:37:45 +0100
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
CC: <linux-doc@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <mchehab@kernel.org>,
	<dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <david@redhat.com>, <Vilas.Sridharan@amd.com>,
	<leo.duran@amd.com>, <Yazen.Ghannam@amd.com>, <rientjes@google.com>,
	<jiaqiyan@google.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<naoya.horiguchi@nec.com>, <james.morse@arm.com>, <jthoughton@google.com>,
	<somasundaram.a@hpe.com>, <erdemaktas@google.com>, <pgonda@google.com>,
	<duenwen@google.com>, <gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<dferguson@amperecomputing.com>, <wbs@os.amperecomputing.com>,
	<nifan.cxl@gmail.com>, <yazen.ghannam@amd.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <roberto.sassu@huawei.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v20 12/15] cxl: Support for finding memory operation attributes from the current boot
Date: Wed, 12 Feb 2025 14:36:50 +0000
Message-ID: <20250212143654.1893-13-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250212143654.1893-1-shiju.jose@huawei.com>
References: <20250212143654.1893-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Certain operations on memory, such as memory repair, are permitted
only when the address and other attributes for the operation are
from the current boot. This is determined by checking whether the
memory attributes for the operation match those in the CXL gen_media
or CXL DRAM memory event records reported during the current boot.

The CXL event records must be backed up because they are cleared
in the hardware after being processed by the kernel.

Support is added for storing CXL gen_media or CXL DRAM memory event
records in xarrays. Additionally, helper functions are implemented
to find a matching record in the xarray storage based on the memory
attributes and repair type.

Add validity check, when matching attributes for sparing, using
the validity flag in the DRAM event record, to ensure that all
required attributes for a requested repair operation are valid and
set.

Presently supported only when CONFIG_CXL_RAS_FEATURES is enabled, as
this feature is specifically used for CXL RAS functionalities now.

Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/Makefile |   2 +-
 drivers/cxl/core/mbox.c   |  11 ++-
 drivers/cxl/core/memdev.c |   9 +++
 drivers/cxl/core/ras.c    | 151 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h      |  55 ++++++++++++++
 drivers/cxl/pci.c         |   3 +
 6 files changed, 228 insertions(+), 3 deletions(-)
 create mode 100644 drivers/cxl/core/ras.c

diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 582f40a12e9e..ed388c5929af 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -17,4 +17,4 @@ cxl_core-y += cdat.o
 cxl_core-$(CONFIG_TRACING) += trace.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
 cxl_core-$(CONFIG_CXL_FEATURES) += features.o
-cxl_core-$(CONFIG_CXL_RAS_FEATURES) += memfeatures.o
+cxl_core-$(CONFIG_CXL_RAS_FEATURES) += memfeatures.o ras.o
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 9984a0c8b531..71832639597c 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -950,11 +950,18 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 		if (cxlr)
 			hpa = cxl_dpa_to_hpa(cxlr, cxlmd, dpa);
 
-		if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
+		if (event_type == CXL_CPER_EVENT_GEN_MEDIA) {
+			if (cxl_store_rec_gen_media((struct cxl_memdev *)cxlmd, evt))
+				dev_warn(&cxlmd->dev, "CXL store rec_gen_media failed\n");
+
 			trace_cxl_general_media(cxlmd, type, cxlr, hpa,
 						&evt->gen_media);
-		else if (event_type == CXL_CPER_EVENT_DRAM)
+		} else if (event_type == CXL_CPER_EVENT_DRAM) {
+			if (cxl_store_rec_dram((struct cxl_memdev *)cxlmd, evt))
+				dev_warn(&cxlmd->dev, "CXL store rec_dram failed\n");
+
 			trace_cxl_dram(cxlmd, type, cxlr, hpa, &evt->dram);
+		}
 	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, "CXL");
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 2e2e035abdaa..99cfc7c70876 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -25,8 +25,17 @@ static DEFINE_IDA(cxl_memdev_ida);
 static void cxl_memdev_release(struct device *dev)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_event_gen_media *rec_gen_media;
+	struct cxl_event_dram *rec_dram;
+	unsigned long index;
 
 	ida_free(&cxl_memdev_ida, cxlmd->id);
+	xa_for_each(&cxlmd->rec_dram, index, rec_dram)
+		kfree(rec_dram);
+	xa_destroy(&cxlmd->rec_dram);
+	xa_for_each(&cxlmd->rec_gen_media, index, rec_gen_media)
+		kfree(rec_gen_media);
+	xa_destroy(&cxlmd->rec_gen_media);
 	kfree(cxlmd);
 }
 
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
new file mode 100644
index 000000000000..65994eec1037
--- /dev/null
+++ b/drivers/cxl/core/ras.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * CXL RAS driver.
+ *
+ * Copyright (c) 2025 HiSilicon Limited.
+ *
+ */
+
+#include <linux/unaligned.h>
+#include <cxlmem.h>
+
+#include "trace.h"
+
+struct cxl_event_gen_media *cxl_find_rec_gen_media(struct cxl_memdev *cxlmd,
+						   struct cxl_mem_repair_attrbs *attrbs)
+{
+	struct cxl_event_gen_media *rec;
+
+	rec = xa_load(&cxlmd->rec_gen_media, attrbs->dpa);
+	if (!rec)
+		return NULL;
+
+	if (attrbs->repair_type == CXL_PPR)
+		return rec;
+
+	return NULL;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_find_rec_gen_media, "CXL");
+
+struct cxl_event_dram *cxl_find_rec_dram(struct cxl_memdev *cxlmd,
+					 struct cxl_mem_repair_attrbs *attrbs)
+{
+	struct cxl_event_dram *rec;
+	u16 validity_flags;
+
+	rec = xa_load(&cxlmd->rec_dram, attrbs->dpa);
+	if (!rec)
+		return NULL;
+
+	validity_flags = get_unaligned_le16(rec->media_hdr.validity_flags);
+	if (!(validity_flags & CXL_DER_VALID_CHANNEL) ||
+	    !(validity_flags & CXL_DER_VALID_RANK))
+		return NULL;
+
+	switch (attrbs->repair_type) {
+	case CXL_PPR:
+		if (!(validity_flags & CXL_DER_VALID_NIBBLE) ||
+		    get_unaligned_le24(rec->nibble_mask) == attrbs->nibble_mask)
+			return rec;
+		break;
+	case CXL_CACHELINE_SPARING:
+		if (!(validity_flags & CXL_DER_VALID_BANK_GROUP) ||
+		    !(validity_flags & CXL_DER_VALID_BANK) ||
+		    !(validity_flags & CXL_DER_VALID_ROW) ||
+		    !(validity_flags & CXL_DER_VALID_COLUMN))
+			return NULL;
+
+		if (rec->media_hdr.channel == attrbs->channel &&
+		    rec->media_hdr.rank == attrbs->rank &&
+		    rec->bank_group == attrbs->bank_group &&
+		    rec->bank == attrbs->bank &&
+		    get_unaligned_le24(rec->row) == attrbs->row &&
+		    get_unaligned_le16(rec->column) == attrbs->column &&
+		    (!(validity_flags & CXL_DER_VALID_NIBBLE) ||
+		     get_unaligned_le24(rec->nibble_mask) == attrbs->nibble_mask) &&
+		    (!(validity_flags & CXL_DER_VALID_SUB_CHANNEL) ||
+		     rec->sub_channel == attrbs->sub_channel))
+			return rec;
+		break;
+	case CXL_ROW_SPARING:
+		if (!(validity_flags & CXL_DER_VALID_BANK_GROUP) ||
+		    !(validity_flags & CXL_DER_VALID_BANK) ||
+		    !(validity_flags & CXL_DER_VALID_ROW))
+			return NULL;
+
+		if (rec->media_hdr.channel == attrbs->channel &&
+		    rec->media_hdr.rank == attrbs->rank &&
+		    rec->bank_group == attrbs->bank_group &&
+		    rec->bank == attrbs->bank &&
+		    get_unaligned_le24(rec->row) == attrbs->row &&
+		    (!(validity_flags & CXL_DER_VALID_NIBBLE) ||
+		     get_unaligned_le24(rec->nibble_mask) == attrbs->nibble_mask))
+			return rec;
+		break;
+	case CXL_BANK_SPARING:
+		if (!(validity_flags & CXL_DER_VALID_BANK_GROUP) ||
+		    !(validity_flags & CXL_DER_VALID_BANK))
+			return NULL;
+
+		if (rec->media_hdr.channel == attrbs->channel &&
+		    rec->media_hdr.rank == attrbs->rank &&
+		    rec->bank_group == attrbs->bank_group &&
+		    rec->bank == attrbs->bank &&
+		    (!(validity_flags & CXL_DER_VALID_NIBBLE) ||
+		     get_unaligned_le24(rec->nibble_mask) == attrbs->nibble_mask))
+			return rec;
+		break;
+	case CXL_RANK_SPARING:
+		if (rec->media_hdr.channel == attrbs->channel &&
+		    rec->media_hdr.rank == attrbs->rank &&
+		    (!(validity_flags & CXL_DER_VALID_NIBBLE) ||
+		     get_unaligned_le24(rec->nibble_mask) == attrbs->nibble_mask))
+			return rec;
+		break;
+	default:
+		return NULL;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_find_rec_dram, "CXL");
+
+int cxl_store_rec_gen_media(struct cxl_memdev *cxlmd, union cxl_event *evt)
+{
+	void *old_rec;
+	struct cxl_event_gen_media *rec = kmemdup(&evt->gen_media,
+						  sizeof(*rec), GFP_KERNEL);
+	if (!rec)
+		return -ENOMEM;
+
+	old_rec = xa_store(&cxlmd->rec_gen_media,
+			   le64_to_cpu(rec->media_hdr.phys_addr),
+			   rec, GFP_KERNEL);
+	if (xa_is_err(old_rec))
+		return xa_err(old_rec);
+
+	kfree(old_rec);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_store_rec_gen_media, "CXL");
+
+int cxl_store_rec_dram(struct cxl_memdev *cxlmd, union cxl_event *evt)
+{
+	void *old_rec;
+	struct cxl_event_dram *rec = kmemdup(&evt->dram, sizeof(*rec), GFP_KERNEL);
+
+	if (!rec)
+		return -ENOMEM;
+
+	old_rec = xa_store(&cxlmd->rec_dram,
+			   le64_to_cpu(rec->media_hdr.phys_addr),
+			   rec, GFP_KERNEL);
+	if (xa_is_err(old_rec))
+		return xa_err(old_rec);
+
+	kfree(old_rec);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_store_rec_dram, "CXL");
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 657dc203d2fb..07d1efc580af 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -34,6 +34,41 @@
 	(FIELD_GET(CXLMDEV_RESET_NEEDED_MASK, status) !=                       \
 	 CXLMDEV_RESET_NEEDED_NOT)
 
+enum cxl_mem_repair_type {
+	CXL_PPR,
+	CXL_CACHELINE_SPARING,
+	CXL_ROW_SPARING,
+	CXL_BANK_SPARING,
+	CXL_RANK_SPARING,
+	CXL_REPAIR_MAX,
+};
+
+/**
+ * struct cxl_mem_repair_attrbs - CXL memory repair attributes
+ * @dpa: DPA of memory to repair
+ * @nibble_mask: nibble mask, identifies one or more nibbles on the memory bus
+ * @row: row of memory to repair
+ * @column: column of memory to repair
+ * @channel: channel of memory to repair
+ * @sub_channel: sub channel of memory to repair
+ * @rank: rank of memory to repair
+ * @bank_group: bank group of memory to repair
+ * @bank: bank of memory to repair
+ * @repair_type: repair type. For eg. PPR, memory sparing etc.
+ */
+struct cxl_mem_repair_attrbs {
+	u64 dpa;
+	u32 nibble_mask;
+	u32 row;
+	u16 column;
+	u8 channel;
+	u8 sub_channel;
+	u8 rank;
+	u8 bank_group;
+	u8 bank;
+	enum cxl_mem_repair_type repair_type;
+};
+
 /**
  * struct cxl_memdev - CXL bus object representing a Type-3 Memory Device
  * @dev: driver core device object
@@ -45,6 +80,8 @@
  * @endpoint: connection to the CXL port topology for this memory device
  * @id: id number of this memdev instance.
  * @depth: endpoint port depth
+ * @rec_gen_media: xarray to store CXL general media records
+ * @rec_dram: xarray to store CXL DRAM records
  */
 struct cxl_memdev {
 	struct device dev;
@@ -56,6 +93,8 @@ struct cxl_memdev {
 	struct cxl_port *endpoint;
 	int id;
 	int depth;
+	struct xarray rec_gen_media;
+	struct xarray rec_dram;
 };
 
 static inline struct cxl_memdev *to_cxl_memdev(struct device *dev)
@@ -821,11 +860,27 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
 #if IS_ENABLED(CONFIG_CXL_RAS_FEATURES)
 int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd);
 int devm_cxl_region_edac_register(struct cxl_region *cxlr);
+struct cxl_event_gen_media *
+cxl_find_rec_gen_media(struct cxl_memdev *cxlmd, struct cxl_mem_repair_attrbs *attrbs);
+struct cxl_event_dram *cxl_find_rec_dram(struct cxl_memdev *cxlmd,
+					 struct cxl_mem_repair_attrbs *attrbs);
+int cxl_store_rec_gen_media(struct cxl_memdev *cxlmd, union cxl_event *evt);
+int cxl_store_rec_dram(struct cxl_memdev *cxlmd, union cxl_event *evt);
 #else
 static inline int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd)
 { return 0; }
 static inline int devm_cxl_region_edac_register(struct cxl_region *cxlr)
 { return 0; }
+static inline struct cxl_event_gen_media *
+cxl_find_rec_gen_media(struct cxl_memdev *cxlmd, struct cxl_mem_repair_attrbs *attrbs)
+{ return 0; }
+static inline struct cxl_event_dram *cxl_find_rec_dram(struct cxl_memdev *cxlmd,
+						       struct cxl_mem_repair_attrbs *attrbs)
+{ return 0; }
+static inline int cxl_store_rec_gen_media(struct cxl_memdev *cxlmd, union cxl_event *evt)
+{ return 0; }
+static inline int cxl_store_rec_dram(struct cxl_memdev *cxlmd, union cxl_event *evt)
+{ return 0; }
 #endif
 
 #ifdef CONFIG_CXL_SUSPEND
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 993fa60fe453..26f7ad1d9e21 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1052,6 +1052,9 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	pci_save_state(pdev);
 
+	xa_init(&cxlmd->rec_gen_media);
+	xa_init(&cxlmd->rec_dram);
+
 	return rc;
 }
 
-- 
2.43.0


