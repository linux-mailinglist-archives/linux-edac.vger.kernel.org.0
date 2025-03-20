Return-Path: <linux-edac+bounces-3385-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5D3A6ACC4
	for <lists+linux-edac@lfdr.de>; Thu, 20 Mar 2025 19:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB6941896996
	for <lists+linux-edac@lfdr.de>; Thu, 20 Mar 2025 18:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CF122A4F3;
	Thu, 20 Mar 2025 18:05:49 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74029226D08;
	Thu, 20 Mar 2025 18:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493949; cv=none; b=qBP5AaYs9CQ0IeOuCfZrqr08V5HJGtM2irti+daKAtNWtKMj+ZJYBh1aYDSzuwZbV3SxknGR9rif43tEhNnQZorZNGR7LErkmU4zWgkq78K3SM9uWGEFwoauF4nojTVysqaThxlS0XvEzvdwGEwhts6tKZqzDjcZ+5iFsxfyRD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493949; c=relaxed/simple;
	bh=rvzK9EISyRVZGk9AkD7d1E/WfLOQ2d52vpl/ioSZjvc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PE/jy9669f3RGA51/lN5GWY3+gb4A1N/S6DkJNkTQp/BHiOmKirYaH5s69USzohHSsaJnPh7kE2qJHTIr4VcaI8YgBvuktV/UiW032ZzNQppPJfhnI9oN2EWZ1ubF6eUhNGa0gXRKTMKwUMv7u8zigAj4epgms8ydcS6iQrvh/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZJYMV5w66z6K5Yr;
	Fri, 21 Mar 2025 02:02:46 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 595351405A0;
	Fri, 21 Mar 2025 02:05:45 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.156.145) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Mar 2025 19:05:43 +0100
From: <shiju.jose@huawei.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <david@redhat.com>, <Vilas.Sridharan@amd.com>
CC: <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
	<tony.luck@intel.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<mchehab@kernel.org>, <leo.duran@amd.com>, <Yazen.Ghannam@amd.com>,
	<rientjes@google.com>, <jiaqiyan@google.com>, <Jon.Grimm@amd.com>,
	<dave.hansen@linux.intel.com>, <naoya.horiguchi@nec.com>,
	<james.morse@arm.com>, <jthoughton@google.com>, <somasundaram.a@hpe.com>,
	<erdemaktas@google.com>, <pgonda@google.com>, <duenwen@google.com>,
	<gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<dferguson@amperecomputing.com>, <wbs@os.amperecomputing.com>,
	<nifan.cxl@gmail.com>, <yazen.ghannam@amd.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <roberto.sassu@huawei.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v2 6/8] cxl: Support for finding memory operation attributes from the current boot
Date: Thu, 20 Mar 2025 18:04:43 +0000
Message-ID: <20250320180450.539-7-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250320180450.539-1-shiju.jose@huawei.com>
References: <20250320180450.539-1-shiju.jose@huawei.com>
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

Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/mbox.c   |  11 ++-
 drivers/cxl/core/memdev.c |   9 +++
 drivers/cxl/core/ras.c    | 145 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h      |  46 ++++++++++++
 drivers/cxl/pci.c         |   3 +
 5 files changed, 212 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 19d46a284650..c9328f1b6464 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -956,12 +956,19 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 				hpa_alias = hpa - cache_size;
 		}
 
-		if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
+		if (event_type == CXL_CPER_EVENT_GEN_MEDIA) {
+			if (cxl_store_rec_gen_media((struct cxl_memdev *)cxlmd, evt))
+				dev_dbg(&cxlmd->dev, "CXL store rec_gen_media failed\n");
+
 			trace_cxl_general_media(cxlmd, type, cxlr, hpa,
 						hpa_alias, &evt->gen_media);
-		else if (event_type == CXL_CPER_EVENT_DRAM)
+		} else if (event_type == CXL_CPER_EVENT_DRAM) {
+			if (cxl_store_rec_dram((struct cxl_memdev *)cxlmd, evt))
+				dev_dbg(&cxlmd->dev, "CXL store rec_dram failed\n");
+
 			trace_cxl_dram(cxlmd, type, cxlr, hpa, hpa_alias,
 				       &evt->dram);
+		}
 	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, "CXL");
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index a16a5886d40a..bd9ba50bc01e 100644
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
index 485a831695c7..c703d4e7e05b 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -7,6 +7,151 @@
 #include <cxlmem.h>
 #include "trace.h"
 
+struct cxl_event_gen_media *
+cxl_find_rec_gen_media(struct cxl_memdev *cxlmd,
+		       struct cxl_mem_repair_attrbs *attrbs)
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
+		     get_unaligned_le24(rec->nibble_mask) ==
+			     attrbs->nibble_mask) &&
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
+		     get_unaligned_le24(rec->nibble_mask) ==
+			     attrbs->nibble_mask))
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
+		     get_unaligned_le24(rec->nibble_mask) ==
+			     attrbs->nibble_mask))
+			return rec;
+		break;
+	case CXL_RANK_SPARING:
+		if (rec->media_hdr.channel == attrbs->channel &&
+		    rec->media_hdr.rank == attrbs->rank &&
+		    (!(validity_flags & CXL_DER_VALID_NIBBLE) ||
+		     get_unaligned_le24(rec->nibble_mask) ==
+			     attrbs->nibble_mask))
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
+	struct cxl_event_gen_media *rec =
+		kmemdup(&evt->gen_media, sizeof(*rec), GFP_KERNEL);
+	if (!rec)
+		return -ENOMEM;
+
+	old_rec = xa_store(&cxlmd->rec_gen_media,
+			   le64_to_cpu(rec->media_hdr.phys_addr), rec,
+			   GFP_KERNEL);
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
+	struct cxl_event_dram *rec =
+		kmemdup(&evt->dram, sizeof(*rec), GFP_KERNEL);
+
+	if (!rec)
+		return -ENOMEM;
+
+	old_rec = xa_store(&cxlmd->rec_dram,
+			   le64_to_cpu(rec->media_hdr.phys_addr), rec,
+			   GFP_KERNEL);
+	if (xa_is_err(old_rec))
+		return xa_err(old_rec);
+
+	kfree(old_rec);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_store_rec_dram, "CXL");
+
 static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
 					      struct cxl_ras_capability_regs ras_cap)
 {
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 7ab257e0c85e..24ece579a145 100644
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
@@ -877,6 +916,13 @@ static inline int devm_cxl_region_edac_register(struct cxl_region *cxlr)
 { return 0; }
 #endif
 
+struct cxl_event_gen_media *
+cxl_find_rec_gen_media(struct cxl_memdev *cxlmd, struct cxl_mem_repair_attrbs *attrbs);
+struct cxl_event_dram *cxl_find_rec_dram(struct cxl_memdev *cxlmd,
+					 struct cxl_mem_repair_attrbs *attrbs);
+int cxl_store_rec_gen_media(struct cxl_memdev *cxlmd, union cxl_event *evt);
+int cxl_store_rec_dram(struct cxl_memdev *cxlmd, union cxl_event *evt);
+
 #ifdef CONFIG_CXL_SUSPEND
 void cxl_mem_active_inc(void);
 void cxl_mem_active_dec(void);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 4288f4814cc5..51f09e685dd9 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1053,6 +1053,9 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	pci_save_state(pdev);
 
+	xa_init(&cxlmd->rec_gen_media);
+	xa_init(&cxlmd->rec_dram);
+
 	return rc;
 }
 
-- 
2.43.0


