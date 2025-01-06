Return-Path: <linux-edac+bounces-2801-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5362A024F7
	for <lists+linux-edac@lfdr.de>; Mon,  6 Jan 2025 13:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBEC6188276C
	for <lists+linux-edac@lfdr.de>; Mon,  6 Jan 2025 12:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F76F1DE8BD;
	Mon,  6 Jan 2025 12:11:51 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCD11DE89D;
	Mon,  6 Jan 2025 12:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736165511; cv=none; b=MA5bj6eLyvGS7GLewiyWYxB3S/fMsNAsL0XtlQdNMHrLHnz4YybVmmRmLHM1/ozPxIhaIlToY2u6dRJfJRVbiJtDHdtrRgQkY0LsfUnbEy7JJUuegkWA6eK1yiF6XYbKbsyhZlwp/G+X8wX5tbVIMhCjHXjumhtnm1wF0XT4MWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736165511; c=relaxed/simple;
	bh=FK7FPhxVYiBW5ey7Ud5EvLqiTBmVcVxOppZS5RjaSe8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V89Gy/HznMDemvaSWo5HRpC5NuxXWLZmLgDn5aZv1zz1hyJ7D44w3H7PpfpYw1xhv1DPOoks2Z1Fgw/Q4cifJ1OJQb7Og463owV5wrPOG9lmJO4bpGydWxzK8yXp4UF8w25HB1qhWDrLnEHBt+93fr+UV4dseFSrqSmP9hAhf5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YRY0R4yZSz6LD8h;
	Mon,  6 Jan 2025 20:10:15 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 7890B140CF4;
	Mon,  6 Jan 2025 20:11:47 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.170.95) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 6 Jan 2025 13:11:45 +0100
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
CC: <bp@alien8.de>, <tony.luck@intel.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <mchehab@kernel.org>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
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
Subject: [PATCH v18 09/19] cxl: Enumerate feature commands
Date: Mon, 6 Jan 2025 12:10:05 +0000
Message-ID: <20250106121017.1620-10-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250106121017.1620-1-shiju.jose@huawei.com>
References: <20250106121017.1620-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Dave Jiang <dave.jiang@intel.com>

Add feature commands enumeration code in order to detect and enumerate
the 3 feature related commands "get supported features", "get feature",
and "set feature". The enumeration will help determine whether the driver
can issue any of the 3 commands to the device.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/mbox.c | 41 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h    |  3 +++
 include/cxl/features.h  |  7 +++++++
 include/cxl/mailbox.h   |  1 +
 4 files changed, 52 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index bdb8f060f2c1..5e21ff99d70f 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -38,6 +38,21 @@ static bool cxl_raw_allow_all;
 	.flags = _flags,                                                       \
 	}
 
+#define cxl_for_each_feature_cmd(cmd)                                          \
+	for ((cmd) = &cxl_feature_commands[0];                                 \
+	     ((cmd) - cxl_feature_commands) < ARRAY_SIZE(cxl_feature_commands); (cmd)++)
+
+#define CXL_FEATURE_CMD(_id, sin, sout, _flags)                                \
+	[CXL_FEATURE_ID_##_id] = {                                             \
+	.info =	{                                                              \
+			.id = CXL_FEATURE_ID_##_id,                            \
+			.size_in = sin,                                        \
+			.size_out = sout,                                      \
+		},                                                             \
+	.opcode = CXL_MBOX_OP_##_id,                                           \
+	.flags = _flags,                                                       \
+	}
+
 #define CXL_VARIABLE_PAYLOAD	~0U
 /*
  * This table defines the supported mailbox commands for the driver. This table
@@ -69,6 +84,13 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
 	CXL_CMD(GET_TIMESTAMP, 0, 0x8, 0),
 };
 
+#define CXL_FEATURE_COMMAND_ID_MAX 3
+static struct cxl_mem_command cxl_feature_commands[CXL_FEATURE_COMMAND_ID_MAX] = {
+	CXL_FEATURE_CMD(GET_SUPPORTED_FEATURES, 0x8, CXL_VARIABLE_PAYLOAD, 0),
+	CXL_FEATURE_CMD(GET_FEATURE, 0xf, CXL_VARIABLE_PAYLOAD, 0),
+	CXL_FEATURE_CMD(SET_FEATURE, CXL_VARIABLE_PAYLOAD, 0, 0),
+};
+
 /*
  * Commands that RAW doesn't permit. The rationale for each:
  *
@@ -212,6 +234,17 @@ static struct cxl_mem_command *cxl_mem_find_command(u16 opcode)
 	return NULL;
 }
 
+static struct cxl_mem_command *cxl_find_feature_command(u16 opcode)
+{
+	struct cxl_mem_command *c;
+
+	cxl_for_each_feature_cmd(c)
+		if (c->opcode == opcode)
+			return c;
+
+	return NULL;
+}
+
 static const char *cxl_mem_opcode_to_name(u16 opcode)
 {
 	struct cxl_mem_command *c;
@@ -734,6 +767,14 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
 		if (cmd) {
 			set_bit(cmd->info.id, cxl_mbox->enabled_cmds);
 			enabled++;
+		} else {
+			struct cxl_mem_command *fcmd =
+				cxl_find_feature_command(opcode);
+
+			if (fcmd) {
+				set_bit(fcmd->info.id, cxl_mbox->feature_cmds);
+				enabled++;
+			}
 		}
 
 		if (cxl_is_poison_command(opcode)) {
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index a0a49809cd76..55c55685cb39 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -490,6 +490,9 @@ enum cxl_opcode {
 	CXL_MBOX_OP_GET_LOG_CAPS	= 0x0402,
 	CXL_MBOX_OP_CLEAR_LOG           = 0x0403,
 	CXL_MBOX_OP_GET_SUP_LOG_SUBLIST = 0x0405,
+	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
+	CXL_MBOX_OP_GET_FEATURE		= 0x0501,
+	CXL_MBOX_OP_SET_FEATURE		= 0x0502,
 	CXL_MBOX_OP_IDENTIFY		= 0x4000,
 	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
 	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
diff --git a/include/cxl/features.h b/include/cxl/features.h
index b92da1e92780..7a8be3c621a1 100644
--- a/include/cxl/features.h
+++ b/include/cxl/features.h
@@ -5,6 +5,13 @@
 
 struct cxl_mailbox;
 
+enum feature_cmds {
+	CXL_FEATURE_ID_GET_SUPPORTED_FEATURES = 0,
+	CXL_FEATURE_ID_GET_FEATURE,
+	CXL_FEATURE_ID_SET_FEATURE,
+	CXL_FEATURE_ID_MAX,
+};
+
 struct cxl_features {
 	int id;
 	struct device dev;
diff --git a/include/cxl/mailbox.h b/include/cxl/mailbox.h
index 6caab0d406ba..263fc346aeb1 100644
--- a/include/cxl/mailbox.h
+++ b/include/cxl/mailbox.h
@@ -58,6 +58,7 @@ struct cxl_mailbox {
 	struct device *host;
 	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
 	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
+	DECLARE_BITMAP(feature_cmds, CXL_FEATURE_ID_MAX);
 	size_t payload_size;
 	struct mutex mbox_mutex; /* lock to protect mailbox context */
 	struct rcuwait mbox_wait;
-- 
2.43.0


