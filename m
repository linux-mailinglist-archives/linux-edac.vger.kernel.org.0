Return-Path: <linux-edac+bounces-2973-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 051C4A2C564
	for <lists+linux-edac@lfdr.de>; Fri,  7 Feb 2025 15:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41899167AF6
	for <lists+linux-edac@lfdr.de>; Fri,  7 Feb 2025 14:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0F323F290;
	Fri,  7 Feb 2025 14:31:00 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4F61F9413;
	Fri,  7 Feb 2025 14:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738938660; cv=none; b=X02XbtWdymSPLh1kV5XvDRzZmc5ZPisk/rWzuy9OqKkcB927dUFgdqrEHpGM2jpUBs1kcaTiUl/jPMnGklBPYqO3X0YELvMA2NHOhAMDi3C8sbeqdoocuL9bTjzFBJIXyM+zhoXLi8p5XpouQASfviQvGCm+vlFDeJ7z9H8gjMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738938660; c=relaxed/simple;
	bh=vNVC3Evx3GympB8CVtdKud8Q4t14jImdj81D6vl44tA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QhbQfnIWd9/4aDVzYPu10kAV6PZ3+NS61KBvz9FRBwe+K2+wmXoZyPHnQS8hXCIxQiFZPzcFSjEqiRD7r9pdhdhw7JYDduqKpyyCsHKrYPMK5sZmpWCr8F22EagdA4tW+WH1gJNHzSpsR7Y4fUJp6GSj2Tiwt4+TzcrAd3Zs7hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YqGZp0YMHz6HJZd;
	Fri,  7 Feb 2025 22:29:54 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 5DCC8140A70;
	Fri,  7 Feb 2025 22:30:55 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.173.5) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Feb 2025 15:30:54 +0100
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<mchehab@kernel.org>, <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<bp@alien8.de>, <jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH 1/4] rasdaemon: cxl: Add support for memory sparing operation
Date: Fri, 7 Feb 2025 14:30:22 +0000
Message-ID: <20250207143028.1865-2-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250207143028.1865-1-shiju.jose@huawei.com>
References: <20250207143028.1865-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

CXL spec 3.1, Section 8.2.9.2.1, Table 8-43, "Common Event Record Format"
table defines the Event Record Flags: 'Maintenance Needed' and 'Maintenance
Operation Subclass Valid Flag' flags, which indicate when these flags are
set, signaling that the memory device requires maintenance. When the device
sets the maintenance operation class and maintenance operation subclass for
memory sparing, the CXL DRAM handler sets attributes for memory sparing via
the EDAC memory repair sysfs interface, initiating the sparing operation
in the CXL memory device.

Add support for the memory sparing operation and enable for the CXL DRAM
event if auto repair is on.

Auto memory repair is disabled default.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 misc/rasdaemon.env |   4 +
 ras-cxl-handler.c  | 287 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 291 insertions(+)

diff --git a/misc/rasdaemon.env b/misc/rasdaemon.env
index 963aaa0..b3fdba7 100644
--- a/misc/rasdaemon.env
+++ b/misc/rasdaemon.env
@@ -88,3 +88,7 @@ TRIGGER_DIR=
 #   MC_UE_TRIGGER=mc_event_trigger
 MC_CE_TRIGGER=
 MC_UE_TRIGGER=
+
+# CXL memory auto repair control
+# Whether to enable CXL memory auto repair (yes|no).
+CXL_AUTO_REPAIR_ENABLE="no"
diff --git a/ras-cxl-handler.c b/ras-cxl-handler.c
index cb95fa6..3311949 100644
--- a/ras-cxl-handler.c
+++ b/ras-cxl-handler.c
@@ -4,7 +4,9 @@
  * Copyright (c) Huawei Technologies Co., Ltd. 2023. All rights reserved.
  */
 
+#include <dirent.h>
 #include <endian.h>
+#include <fcntl.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -722,6 +724,140 @@ static int handle_ras_cxl_common_hdr(struct trace_seq *s,
 	return 0;
 }
 
+/* memory repair */
+/*
+ * Common Event Record Format
+ * CXL 3.1 section 8.2.9.2.1; Table 8-43
+ */
+#define CXL_MAINT_CLASS_SPARING			0x02
+#define CXL_MAINT_SUBCLASS_CACHE_SPARING	0x00
+#define CXL_MAINT_SUBCLASS_ROW_SPARING		0x01
+#define CXL_MAINT_SUBCLASS_BANK_SPARING		0x02
+#define CXL_MAINT_SUBCLASS_RANK_SPARING		0x03
+
+#define CXL_CMD_BUF_SIZE	256
+
+enum cxl_mem_sparing_type {
+	CXL_CACHE_SPARING,
+	CXL_ROW_SPARING,
+	CXL_BANK_SPARING,
+	CXL_RANK_SPARING,
+};
+
+static const char *edac_bus_path = "/sys/bus/edac/devices/";
+#define EDAC_CXL_DEV_PREFIX	"cxl_"
+
+/*
+ * Auto repair is disabled default.
+ * 'export CXL_AUTO_REPAIR_ENABLE=yes' to enable auto repair.
+ */
+static bool auto_repair;
+
+static void check_config_status(void)
+{
+	char *env = getenv("CXL_AUTO_REPAIR_ENABLE");
+
+	if (!env || strcasecmp(env, "yes"))
+		return;
+
+	auto_repair = true;
+}
+
+static int get_sysfs_data_str(const char *dir, const char *file, char *out)
+{
+	char path[CXL_CMD_BUF_SIZE];
+	char buf[CXL_CMD_BUF_SIZE];
+	int fd;
+
+	snprintf(path, CXL_CMD_BUF_SIZE, "%s/%s", dir, file);
+	fd = open(path, O_RDONLY);
+	if (fd == -1) {
+		log(TERM, LOG_ERR, "[%s]:open file: %s failed\n", __func__, path);
+		return -1;
+	}
+
+	memset(buf, 0, strlen(buf));
+	if (read(fd, buf, sizeof(buf)) <= 0)
+		goto error;
+
+	if (sscanf(buf, "%s", out) <= 0)
+		goto error;
+
+	close(fd);
+	return 0;
+
+error:
+	close(fd);
+	return -1;
+}
+
+static int set_sysfs_data_uint32(const char *dir, const char *file, uint32_t data)
+{
+	char path[CXL_CMD_BUF_SIZE];
+	int fd;
+
+	snprintf(path, CXL_CMD_BUF_SIZE, "%s/%s", dir, file);
+	fd = open(path, O_WRONLY);
+	if (fd == -1) {
+		log(TERM, LOG_ERR, "[%s]:open file: %s failed\n", __func__, path);
+		return -1;
+	}
+
+	if (dprintf(fd, "%d", data) <= 0) {
+		log(TERM, LOG_ERR, "[%s]: write data to [%s] failed, errno:%d\n",
+		    __func__, path, errno);
+		close(fd);
+		return -1;
+	}
+	close(fd);
+
+	return 0;
+}
+
+static int set_sysfs_data_uint64(const char *dir, const char *file, uint64_t data)
+{
+	char path[CXL_CMD_BUF_SIZE];
+	int fd;
+
+	snprintf(path, CXL_CMD_BUF_SIZE, "%s/%s", dir, file);
+	fd = open(path, O_WRONLY);
+	if (fd == -1) {
+		log(TERM, LOG_ERR, "[%s]:open file: %s failed\n", __func__, path);
+		return -1;
+	}
+
+	if (dprintf(fd, "0x%lx", data) <= 0) {
+		log(TERM, LOG_ERR, "[%s]: write data to [%s] failed, errno:%d\n",
+		    __func__, path, errno);
+		close(fd);
+		return -1;
+	}
+	close(fd);
+
+	return 0;
+}
+
+static int cxl_find_spare(const char *repair_dev, const char *repair_type)
+{
+	char dir[CXL_CMD_BUF_SIZE];
+	char out[CXL_CMD_BUF_SIZE];
+	int idx = 0;
+
+	while (1) {
+		snprintf(dir, CXL_CMD_BUF_SIZE, "%s%s%s/mem_repair%d",
+			 edac_bus_path, EDAC_CXL_DEV_PREFIX, repair_dev, idx);
+
+		if (get_sysfs_data_str(dir, "repair_type", out))
+			return -1;
+
+		if (!strcmp(repair_type, out))
+			return idx;
+		idx++;
+	}
+
+	return -1;
+}
+
 int ras_cxl_generic_event_handler(struct trace_seq *s,
 				  struct tep_record *record,
 				  struct tep_event *event, void *context)
@@ -1027,6 +1163,155 @@ static const char * const cxl_der_mem_event_type[] = {
 	"CKID Violation",
 };
 
+/*
+ * Each type of sparing requires a superset of the info needed for
+ * coarser grained sparing.
+ */
+static int fill_rank_sparing_attrs(struct ras_cxl_dram_event *ev,
+				   const char *dir)
+{
+	if (set_sysfs_data_uint64(dir, "dpa", ev->dpa))
+		return -1;
+
+	if (set_sysfs_data_uint32(dir, "channel", ev->channel))
+		return -1;
+
+	if (set_sysfs_data_uint32(dir, "rank", ev->rank))
+		return -1;
+
+	if (ev->validity_flags & CXL_DER_VALID_NIBBLE) {
+		if (set_sysfs_data_uint32(dir, "nibble_mask", ev->nibble_mask))
+			return -1;
+	}
+
+	return 0;
+}
+
+static int fill_bank_sparing_attrs(struct ras_cxl_dram_event *ev,
+				   const char *dir)
+{
+	if (fill_rank_sparing_attrs(ev, dir))
+		return -1;
+
+	if (set_sysfs_data_uint32(dir, "bank_group", ev->bank_group))
+		return -1;
+
+	if (set_sysfs_data_uint32(dir, "bank", ev->bank))
+		return -1;
+
+	return 0;
+}
+
+static int fill_row_sparing_attrs(struct ras_cxl_dram_event *ev,
+				  const char *dir)
+{
+	if (fill_bank_sparing_attrs(ev, dir))
+		return -1;
+
+	if (set_sysfs_data_uint32(dir, "row", ev->row))
+		return -1;
+
+	return 0;
+}
+
+static int fill_cacheline_sparing_attrs(struct ras_cxl_dram_event *ev,
+					const char *dir)
+{
+	if (fill_row_sparing_attrs(ev, dir))
+		return -1;
+
+	if (set_sysfs_data_uint32(dir, "column", ev->column))
+		return -1;
+
+	if (ev->validity_flags & CXL_DER_VALID_SUB_CHANNEL) {
+		if (set_sysfs_data_uint32(dir, "sub_channel", ev->sub_channel))
+			return -1;
+	}
+
+	return 0;
+}
+
+static int cxl_dram_sparing(struct ras_cxl_dram_event *ev)
+{
+	struct ras_cxl_event_common_hdr *hdr = &ev->hdr;
+	char dir[CXL_CMD_BUF_SIZE];
+	char repair_type[256];
+	uint8_t sparing_type;
+	int idx;
+
+	check_config_status();
+	if (!auto_repair)
+		return -1;
+
+	if (!(ev->hdr.hdr_flags & CXL_EVENT_RECORD_FLAG_MAINT_NEEDED) ||
+	    !(ev->hdr.hdr_flags & CXL_EVENT_RECORD_FLAG_MAINT_OP_SUB_CLASS_VALID) ||
+	    ev->hdr.hdr_maint_op_class != CXL_MAINT_CLASS_SPARING ||
+	    ev->dpa_flags & CXL_DPA_NOT_REPAIRABLE)
+		return -1;
+
+	if (!(ev->validity_flags & CXL_DER_VALID_CHANNEL) ||
+	    !(ev->validity_flags & CXL_DER_VALID_RANK))
+		return -1;
+
+	/*
+	 * CXL device reports the type of the repair in the event record.
+	 */
+	switch (hdr->hdr_maint_op_sub_class) {
+	case CXL_MAINT_SUBCLASS_CACHE_SPARING:
+		if (!(ev->validity_flags & CXL_DER_VALID_BANK_GROUP) ||
+		    !(ev->validity_flags & CXL_DER_VALID_BANK) ||
+		    !(ev->validity_flags & CXL_DER_VALID_ROW) ||
+		    !(ev->validity_flags & CXL_DER_VALID_COLUMN))
+			return -1;
+		snprintf(repair_type, CXL_CMD_BUF_SIZE, "cacheline-sparing");
+		sparing_type = CXL_CACHE_SPARING;
+		break;
+	case CXL_MAINT_SUBCLASS_ROW_SPARING:
+		if (!(ev->validity_flags & CXL_DER_VALID_BANK_GROUP) ||
+		    !(ev->validity_flags & CXL_DER_VALID_BANK) ||
+		    !(ev->validity_flags & CXL_DER_VALID_ROW))
+			return -1;
+		snprintf(repair_type, CXL_CMD_BUF_SIZE, "row-sparing");
+		sparing_type = CXL_ROW_SPARING;
+		break;
+	case CXL_MAINT_SUBCLASS_BANK_SPARING:
+		if (!(ev->validity_flags & CXL_DER_VALID_BANK_GROUP) ||
+		    !(ev->validity_flags & CXL_DER_VALID_BANK))
+			return -1;
+		snprintf(repair_type, CXL_CMD_BUF_SIZE, "bank-sparing");
+		sparing_type = CXL_CACHE_SPARING;
+		break;
+	case CXL_MAINT_SUBCLASS_RANK_SPARING:
+		snprintf(repair_type, CXL_CMD_BUF_SIZE, "rank-sparing");
+		sparing_type = CXL_CACHE_SPARING;
+		break;
+	default:
+		return -1;
+	}
+
+	idx = cxl_find_spare(hdr->memdev, repair_type);
+	if (idx < 0)
+		return -1;
+
+	snprintf(dir, CXL_CMD_BUF_SIZE, "%s%s%s/mem_repair%d",
+		 edac_bus_path, EDAC_CXL_DEV_PREFIX, ev->hdr.memdev, idx);
+
+	if (sparing_type == CXL_CACHE_SPARING)
+		fill_cacheline_sparing_attrs(ev, dir);
+	else if (sparing_type == CXL_ROW_SPARING)
+		fill_row_sparing_attrs(ev, dir);
+	else if (sparing_type == CXL_BANK_SPARING)
+		fill_bank_sparing_attrs(ev, dir);
+	else if (sparing_type == CXL_RANK_SPARING)
+		fill_rank_sparing_attrs(ev, dir);
+	else
+		return -1;
+
+	set_sysfs_data_uint32(dir, "repair", 1);
+
+	return 0;
+}
+
 int ras_cxl_dram_event_handler(struct trace_seq *s,
 			       struct tep_record *record,
 			       struct tep_event *event, void *context)
@@ -1231,6 +1516,8 @@ int ras_cxl_dram_event_handler(struct trace_seq *s,
 	if (trace_seq_printf(s, "CVME Count:%u ", ev.cvme_count) <= 0)
 		return -1;
 
+	cxl_dram_sparing(&ev);
+
 	/* Insert data into the SGBD */
 #ifdef HAVE_SQLITE3
 	ras_store_cxl_dram_event(ras, &ev);
-- 
2.43.0


