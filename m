Return-Path: <linux-edac+bounces-3812-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9124FAA6CCD
	for <lists+linux-edac@lfdr.de>; Fri,  2 May 2025 10:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA2A14A2F9F
	for <lists+linux-edac@lfdr.de>; Fri,  2 May 2025 08:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C8922A4E7;
	Fri,  2 May 2025 08:45:57 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512311F76C2;
	Fri,  2 May 2025 08:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746175557; cv=none; b=SaGevelWlezdRHCfldXuNIAxDpQ9DQFR6jWLQ5KxdNYVKhZoyKutk/C5aEkvbldvyDdg87sY8IkFpkNuF2wI4Jo4Xf5RZSsgdLioR5IRYYepqshlMnh112hYNSX3nszyUW6qzf5x0+ArCHXqTdnimQyFz062ru9rTXObhIJCj2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746175557; c=relaxed/simple;
	bh=lYT9kbIkpF/0YZJ79lQ62CUYDLHVhsYUPT5OWQiYvE4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JNWpMyBxJ1/M0UmMdxPx+4dGiBz92JL8y7H6noMcVwOh3QYeiQfDX0vTp5EShaX2+Y8vPUG90Puhi4wnZYbJ2RY+tR1GFFG68FY6iCmfTahHe0qSBcRqE64PP9KixfMtLcSjBO61n7LfQC+MMZm0NzEvPpa7o7F1yBe87W0jL6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zpkt24dg4z6M4P7;
	Fri,  2 May 2025 16:41:30 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 65E291400D9;
	Fri,  2 May 2025 16:45:53 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.168.187) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 2 May 2025 10:45:52 +0200
From: <shiju.jose@huawei.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>
CC: <linux-edac@vger.kernel.org>, <linux-doc@vger.kernel.org>, <bp@alien8.de>,
	<tony.luck@intel.com>, <lenb@kernel.org>, <Yazen.Ghannam@amd.com>,
	<mchehab@kernel.org>, <nifan.cxl@gmail.com>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v4 6/8] cxl/edac: Support for finding memory operation attributes from the current boot
Date: Fri, 2 May 2025 09:45:14 +0100
Message-ID: <20250502084517.680-7-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250502084517.680-1-shiju.jose@huawei.com>
References: <20250502084517.680-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
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
records in xarrays. Old records are deleted when they expire or when
there is an overflow and which depends on platform correctly report
Event Record Timestamp field of CXL spec Table 8-55 Common Event
Record Format.

Additionally, helper functions are implemented to find a matching
record in the xarray storage based on the memory attributes and
repair type.

Add validity check, when matching attributes for sparing, using
the validity flag in the DRAM event record, to ensure that all
required attributes for a requested repair operation are valid and
set.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/Kconfig       |   4 +
 drivers/cxl/core/edac.c   | 307 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/mbox.c   |  11 +-
 drivers/cxl/core/memdev.c |   1 +
 drivers/cxl/cxlmem.h      |  19 +++
 5 files changed, 340 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 2333f7c0b6db..48b7314afdb8 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -173,6 +173,10 @@ config CXL_EDAC_MEM_REPAIR
 	  to control the memory repair features (e.g. sparing, PPR)
 	  configurations of CXL memory expander devices.
 
+	  When enabled, the memory repair feature requires an additional
+	  memory of approximately 43KB to store CXL DRAM and CXL general
+	  media event records.
+
 	  When enabled 'cxl_mem' EDAC devices are published with memory
 	  repair control attributes as described by
 	  Documentation/ABI/testing/sysfs-edac-memory-repair.
diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
index 246a02785f1d..02bd4c675871 100644
--- a/drivers/cxl/core/edac.c
+++ b/drivers/cxl/core/edac.c
@@ -14,10 +14,12 @@
 #include <linux/cleanup.h>
 #include <linux/edac.h>
 #include <linux/limits.h>
+#include <linux/xarray.h>
 #include <cxl/features.h>
 #include <cxl.h>
 #include <cxlmem.h>
 #include "core.h"
+#include "trace.h"
 
 #define CXL_NR_EDAC_DEV_FEATURES 2
 
@@ -840,6 +842,280 @@ static int cxl_perform_maintenance(struct cxl_mailbox *cxl_mbox, u8 class,
 
 	return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 }
+
+/*
+ * Support for finding a memory operation attributes
+ * are from the current boot or not.
+ */
+
+struct cxl_mem_err_rec {
+	struct xarray rec_gen_media;
+	struct xarray rec_dram;
+};
+
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
+static struct cxl_event_gen_media *
+cxl_find_rec_gen_media(struct cxl_memdev *cxlmd,
+		       struct cxl_mem_repair_attrbs *attrbs)
+{
+	struct cxl_mem_err_rec *array_rec = cxlmd->array_err_rec;
+	struct cxl_event_gen_media *rec;
+
+	if (!array_rec)
+		return NULL;
+
+	rec = xa_load(&array_rec->rec_gen_media, attrbs->dpa);
+	if (!rec)
+		return NULL;
+
+	if (attrbs->repair_type == CXL_PPR)
+		return rec;
+
+	return NULL;
+}
+
+static struct cxl_event_dram *
+cxl_find_rec_dram(struct cxl_memdev *cxlmd,
+		  struct cxl_mem_repair_attrbs *attrbs)
+{
+	struct cxl_mem_err_rec *array_rec = cxlmd->array_err_rec;
+	struct cxl_event_dram *rec;
+	u16 validity_flags;
+
+	if (!array_rec)
+		return NULL;
+
+	rec = xa_load(&array_rec->rec_dram, attrbs->dpa);
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
+
+#define CXL_MAX_STORAGE_DAYS 10
+#define CXL_MAX_STORAGE_TIME_SECS (CXL_MAX_STORAGE_DAYS * 24 * 60 * 60)
+
+static void cxl_del_expired_gmedia_recs(struct xarray *rec_xarray,
+					struct cxl_event_gen_media *cur_rec)
+{
+	u64 cur_ts = le64_to_cpu(cur_rec->media_hdr.hdr.timestamp);
+	struct cxl_event_gen_media *rec;
+	unsigned long index;
+	u64 delta_ts_secs;
+
+	xa_for_each(rec_xarray, index, rec) {
+		delta_ts_secs = (cur_ts -
+			le64_to_cpu(rec->media_hdr.hdr.timestamp)) / 1000000000ULL;
+		if (delta_ts_secs >= CXL_MAX_STORAGE_TIME_SECS) {
+			xa_erase(rec_xarray, index);
+			kfree(rec);
+		}
+	}
+}
+
+static void cxl_del_expired_dram_recs(struct xarray *rec_xarray,
+				      struct cxl_event_dram *cur_rec)
+{
+	u64 cur_ts = le64_to_cpu(cur_rec->media_hdr.hdr.timestamp);
+	struct cxl_event_dram *rec;
+	unsigned long index;
+	u64 delta_secs;
+
+	xa_for_each(rec_xarray, index, rec) {
+		delta_secs = (cur_ts -
+			le64_to_cpu(rec->media_hdr.hdr.timestamp)) / 1000000000ULL;
+		if (delta_secs >= CXL_MAX_STORAGE_TIME_SECS) {
+			xa_erase(rec_xarray, index);
+			kfree(rec);
+		}
+	}
+}
+
+#define CXL_MAX_REC_STORAGE_COUNT 200
+
+static void cxl_del_overflow_old_recs(struct xarray *rec_xarray)
+{
+	void *err_rec;
+	unsigned long index, count = 0;
+
+	xa_for_each(rec_xarray, index, err_rec)
+		count++;
+
+	if (count <= CXL_MAX_REC_STORAGE_COUNT)
+		return;
+
+	count -= CXL_MAX_REC_STORAGE_COUNT;
+	xa_for_each(rec_xarray, index, err_rec) {
+		xa_erase(rec_xarray, index);
+		kfree(err_rec);
+		count--;
+		if (!count)
+			break;
+	}
+}
+
+int cxl_store_rec_gen_media(struct cxl_memdev *cxlmd, union cxl_event *evt)
+{
+	struct cxl_mem_err_rec *array_rec = cxlmd->array_err_rec;
+	struct cxl_event_gen_media *rec;
+	void *old_rec;
+
+	if (!array_rec)
+		return 0;
+
+	rec = kmemdup(&evt->gen_media, sizeof(*rec), GFP_KERNEL);
+	if (!rec)
+		return -ENOMEM;
+
+	old_rec = xa_store(&array_rec->rec_gen_media,
+			   le64_to_cpu(rec->media_hdr.phys_addr), rec,
+			   GFP_KERNEL);
+	if (xa_is_err(old_rec))
+		return xa_err(old_rec);
+
+	kfree(old_rec);
+
+	cxl_del_expired_gmedia_recs(&array_rec->rec_gen_media, rec);
+	cxl_del_overflow_old_recs(&array_rec->rec_gen_media);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_store_rec_gen_media, "CXL");
+
+int cxl_store_rec_dram(struct cxl_memdev *cxlmd, union cxl_event *evt)
+{
+	struct cxl_mem_err_rec *array_rec = cxlmd->array_err_rec;
+	struct cxl_event_dram *rec;
+	void *old_rec;
+
+	if (!array_rec)
+		return 0;
+
+	rec = kmemdup(&evt->dram, sizeof(*rec), GFP_KERNEL);
+	if (!rec)
+		return -ENOMEM;
+
+	old_rec = xa_store(&array_rec->rec_dram,
+			   le64_to_cpu(rec->media_hdr.phys_addr), rec,
+			   GFP_KERNEL);
+	if (xa_is_err(old_rec))
+		return xa_err(old_rec);
+
+	kfree(old_rec);
+
+	cxl_del_expired_dram_recs(&array_rec->rec_dram, rec);
+	cxl_del_overflow_old_recs(&array_rec->rec_dram);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_store_rec_dram, "CXL");
 #endif /* CONFIG_CXL_EDAC_MEM_REPAIR */
 
 int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd)
@@ -868,6 +1144,16 @@ int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd)
 		num_ras_features++;
 #endif
 
+#ifdef CONFIG_CXL_EDAC_MEM_REPAIR
+	struct cxl_mem_err_rec *array_rec =
+		devm_kzalloc(&cxlmd->dev, sizeof(*array_rec), GFP_KERNEL);
+	if (!array_rec)
+		return -ENOMEM;
+
+	cxlmd->array_err_rec = array_rec;
+	xa_init(&array_rec->rec_gen_media);
+	xa_init(&array_rec->rec_dram);
+#endif
 	char *cxl_dev_name __free(kfree) =
 		kasprintf(GFP_KERNEL, "cxl_%s", dev_name(&cxlmd->dev));
 	if (!cxl_dev_name)
@@ -903,3 +1189,24 @@ int devm_cxl_region_edac_register(struct cxl_region *cxlr)
 #endif
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_region_edac_register, "CXL");
+
+void devm_cxl_memdev_edac_release(struct cxl_memdev *cxlmd)
+{
+#ifdef CONFIG_CXL_EDAC_MEM_REPAIR
+	struct cxl_mem_err_rec *array_rec = cxlmd->array_err_rec;
+	struct cxl_event_gen_media *rec_gen_media;
+	struct cxl_event_dram *rec_dram;
+	unsigned long index;
+
+	if (!array_rec)
+		return;
+
+	xa_for_each(&array_rec->rec_dram, index, rec_dram)
+		kfree(rec_dram);
+	xa_destroy(&array_rec->rec_dram);
+	xa_for_each(&array_rec->rec_gen_media, index, rec_gen_media)
+		kfree(rec_gen_media);
+	xa_destroy(&array_rec->rec_gen_media);
+#endif
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_memdev_edac_release, "CXL");
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index d72764056ce6..2689e6453c5a 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -922,12 +922,19 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
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
index a16a5886d40a..953d8407d0dd 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -27,6 +27,7 @@ static void cxl_memdev_release(struct device *dev)
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 
 	ida_free(&cxl_memdev_ida, cxlmd->id);
+	devm_cxl_memdev_edac_release(cxlmd);
 	kfree(cxlmd);
 }
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 1b9bf6b42521..6f808809f7c0 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -47,6 +47,9 @@
  * @depth: endpoint port depth
  * @cur_scrub_cycle: current scrub cycle set for this device
  * @cur_region_id: id number of a backed region (if any) for which current scrub cycle set
+ * @array_err_rec: List of xarrarys to store the memdev error records to
+ *		   check attributes for a memory repair operation are from
+ *		   current boot.
  */
 struct cxl_memdev {
 	struct device dev;
@@ -62,6 +65,7 @@ struct cxl_memdev {
 	u8 cur_scrub_cycle;
 	int cur_region_id;
 #endif
+	void *array_err_rec;
 };
 
 static inline struct cxl_memdev *to_cxl_memdev(struct device *dev)
@@ -863,11 +867,26 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
 #if IS_ENABLED(CONFIG_CXL_EDAC_MEM_FEATURES)
 int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd);
 int devm_cxl_region_edac_register(struct cxl_region *cxlr);
+void devm_cxl_memdev_edac_release(struct cxl_memdev *cxlmd);
 #else
 static inline int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd)
 { return 0; }
 static inline int devm_cxl_region_edac_register(struct cxl_region *cxlr)
 { return 0; }
+static inline void devm_cxl_memdev_edac_release(struct cxl_memdev *cxlmd)
+{ return; }
+#endif
+
+#ifdef CONFIG_CXL_EDAC_MEM_REPAIR
+int cxl_store_rec_gen_media(struct cxl_memdev *cxlmd, union cxl_event *evt);
+int cxl_store_rec_dram(struct cxl_memdev *cxlmd, union cxl_event *evt);
+#else
+static inline int cxl_store_rec_gen_media(struct cxl_memdev *cxlmd,
+					  union cxl_event *evt)
+{ return 0; }
+static inline int cxl_store_rec_dram(struct cxl_memdev *cxlmd,
+				     union cxl_event *evt)
+{ return 0; }
 #endif
 
 #ifdef CONFIG_CXL_SUSPEND
-- 
2.43.0


