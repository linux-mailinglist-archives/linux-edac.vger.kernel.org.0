Return-Path: <linux-edac+bounces-2974-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 830ABA2C568
	for <lists+linux-edac@lfdr.de>; Fri,  7 Feb 2025 15:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAE87167E2C
	for <lists+linux-edac@lfdr.de>; Fri,  7 Feb 2025 14:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66BD2451E8;
	Fri,  7 Feb 2025 14:31:00 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E33E20B817;
	Fri,  7 Feb 2025 14:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738938660; cv=none; b=qHuz71J+wVEsv9JBbm0Y25leD3clCJPtFtgjAU1h7oAhbzc8jhEH34cbvrIrbSAaX0j2ulSutDw6HcbLo9GikXmbuPLLsgoit6IAgl7AMAqIgnNNhQtDWy/fL9kPcdRhQgh0m68LDMPDDWILOMzZAHxL5ojbMTWHqOjTdO2g6d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738938660; c=relaxed/simple;
	bh=JPGQWfCGfHcibenALWxkM4pdFRT55xRV1cpvh0S04P4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oai+vf7AnOXc9YOg55PQ4ex74T8yz6OoiuhfplaU9qxkP8QR9/UG6h0m5hR/xAHSby0TLN7iflDjVtMH2zfTidy2Oe8h0OeqmuZIpEu3MsVdn09IrtnM5xDXs1pQYoukRzHbEELPUwvlutwLLhfJkSxqRfjIRv9wf385BvXAZq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YqGZq1g7Zz6HJZg;
	Fri,  7 Feb 2025 22:29:55 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 8489C1406AC;
	Fri,  7 Feb 2025 22:30:56 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.173.5) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Feb 2025 15:30:55 +0100
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<mchehab@kernel.org>, <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<bp@alien8.de>, <jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH 2/4] rasdaemon: cxl: Add support for memory soft PPR operation
Date: Fri, 7 Feb 2025 14:30:23 +0000
Message-ID: <20250207143028.1865-3-shiju.jose@huawei.com>
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
memory soft PPR(Post Package Repair), the CXL DRAM event handler and CXL
general media handler sets attributes for memory PPR via the EDAC memory
repair sysfs interface, initiating the soft PPR operation in the CXL memory
device.

Add support for the memory soft PPR operation and enable for the CXL DRAM
event and CXL general media event if auto repair is on.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 ras-cxl-handler.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/ras-cxl-handler.c b/ras-cxl-handler.c
index 3311949..ae49740 100644
--- a/ras-cxl-handler.c
+++ b/ras-cxl-handler.c
@@ -735,6 +735,10 @@ static int handle_ras_cxl_common_hdr(struct trace_seq *s,
 #define CXL_MAINT_SUBCLASS_BANK_SPARING		0x02
 #define CXL_MAINT_SUBCLASS_RANK_SPARING		0x03
 
+#define CXL_MAINT_CLASS_PPR		0x01
+#define CXL_MAINT_SUBCLASS_SPPR		0x00
+#define CXL_MAINT_SUBCLASS_HPPR		0x01
+
 #define CXL_CMD_BUF_SIZE	256
 
 enum cxl_mem_sparing_type {
@@ -791,6 +795,34 @@ error:
 	return -1;
 }
 
+static int get_sysfs_data_uint32(const char *dir, const char *file)
+{
+	char path[CXL_CMD_BUF_SIZE];
+	char buf[2] = "";
+	int fd, num;
+
+	snprintf(path, CXL_CMD_BUF_SIZE, "%s/%s", dir, file);
+	fd = open(path, O_RDONLY);
+	if (fd == -1) {
+		log(TERM, LOG_ERR, "[%s]:open file: %s failed\n", __func__, path);
+		return -1;
+	}
+
+	if (read(fd, buf, 1) <= 0)
+		goto error;
+
+	if (sscanf(buf, "%d", &num) <= 0)
+		goto error;
+
+	close(fd);
+
+	return num;
+
+error:
+	close(fd);
+	return -1;
+}
+
 static int set_sysfs_data_uint32(const char *dir, const char *file, uint32_t data)
 {
 	char path[CXL_CMD_BUF_SIZE];
@@ -858,6 +890,34 @@ static int cxl_find_spare(const char *repair_dev, const char *repair_type)
 	return -1;
 }
 
+static int cxl_find_ppr(const char *repair_dev, const char *repair_type)
+{
+	char dir[CXL_CMD_BUF_SIZE];
+	char out[CXL_CMD_BUF_SIZE];
+	int idx = 0;
+	int persist;
+
+	while (1) {
+		snprintf(dir, CXL_CMD_BUF_SIZE, "%s%s%s/mem_repair%d",
+			 edac_bus_path, EDAC_CXL_DEV_PREFIX, repair_dev, idx);
+
+		persist = get_sysfs_data_uint32(dir, "persist_mode");
+		if (persist < 0)
+			return -1;
+		if (persist)
+			continue;
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
@@ -973,6 +1033,36 @@ static const char * const cxl_gmer_trans_type[] = {
 	"Media Initialization",
 };
 
+static int cxl_ppr(struct ras_cxl_event_common_hdr *hdr, uint64_t dpa, uint32_t nibble_mask)
+{
+	char dir[CXL_CMD_BUF_SIZE];
+	int idx = 0;
+
+	if (!(hdr->hdr_flags & CXL_EVENT_RECORD_FLAG_MAINT_NEEDED) ||
+	    !(hdr->hdr_flags & CXL_EVENT_RECORD_FLAG_MAINT_OP_SUB_CLASS_VALID) ||
+	    hdr->hdr_maint_op_class != CXL_MAINT_CLASS_PPR ||
+	    hdr->hdr_maint_op_sub_class != CXL_MAINT_SUBCLASS_SPPR)
+		return -1;
+
+	idx = cxl_find_ppr(hdr->memdev, "ppr");
+	if (idx < 0)
+		return -1;
+
+	snprintf(dir, CXL_CMD_BUF_SIZE, "%s%s%s/mem_repair%d",
+		 edac_bus_path, EDAC_CXL_DEV_PREFIX, hdr->memdev, idx);
+
+	if (set_sysfs_data_uint64(dir, "dpa", dpa))
+		return -1;
+
+	if (set_sysfs_data_uint32(dir, "nibble_mask", nibble_mask))
+		return -1;
+
+	if (set_sysfs_data_uint32(dir, "repair", 1))
+		return -1;
+
+	return 0;
+}
+
 int ras_cxl_general_media_event_handler(struct trace_seq *s,
 					struct tep_record *record,
 					struct tep_event *event, void *context)
@@ -1133,6 +1223,9 @@ int ras_cxl_general_media_event_handler(struct trace_seq *s,
 	ras_report_cxl_general_media_event(ras, &ev);
 #endif
 
+	if (!(ev.dpa_flags & CXL_DPA_NOT_REPAIRABLE))
+		cxl_ppr(&ev.hdr, ev.dpa, 0);
+
 	return 0;
 }
 
@@ -1518,6 +1611,9 @@ int ras_cxl_dram_event_handler(struct trace_seq *s,
 
 	cxl_dram_sparing(&ev);
 
+	if (!(ev.dpa_flags & CXL_DPA_NOT_REPAIRABLE))
+		cxl_ppr(&ev.hdr, ev.dpa, ev.nibble_mask);
+
 	/* Insert data into the SGBD */
 #ifdef HAVE_SQLITE3
 	ras_store_cxl_dram_event(ras, &ev);
-- 
2.43.0


