Return-Path: <linux-edac+bounces-3481-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D676A7E906
	for <lists+linux-edac@lfdr.de>; Mon,  7 Apr 2025 19:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A28A17A054
	for <lists+linux-edac@lfdr.de>; Mon,  7 Apr 2025 17:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690E8217663;
	Mon,  7 Apr 2025 17:50:11 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CC12101BD;
	Mon,  7 Apr 2025 17:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744048211; cv=none; b=OhSAcQp7rMXVu8QISmgr/IEPlIeaMqYy08gDCgoL0rI1K47As/kFH1h27SryA6MIQ3Y9fIAicKQAmQ6iVv0DWZT+M7l3gysa9Qh3VWU2FNtpRcQn/xygX6gIcGKKjlHEKoJdN7Q46eO2QVxW91kvWJ6lNJbCGmSlghHYgHIuRyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744048211; c=relaxed/simple;
	bh=v6z8u7IiWm91UbuW4GAmAXfYUPj53OtZDRfJqljoJ6E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mfSfM8bUNyY+/oaFk8q6s1A5BRfBfZ3FTq99ve0PuqR/xL42nDWEcCPyFmGFxLaU4aSuMJOxA9a/Pp58sUEyHm4fciNblKUweSxdouNVAc0N79zLGWBWcPbXx838uNG7YXxrPOGCUjjLoKOjhWzLWkJxmolYpsVs1QJGN2IN0fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZWc8F3hr5z6M4XQ;
	Tue,  8 Apr 2025 01:46:21 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 8BBDC1400F4;
	Tue,  8 Apr 2025 01:50:07 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.154.56) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 7 Apr 2025 19:50:06 +0200
From: <shiju.jose@huawei.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>
CC: <linux-edac@vger.kernel.org>, <linux-doc@vger.kernel.org>, <bp@alien8.de>,
	<tony.luck@intel.com>, <lenb@kernel.org>, <leo.duran@amd.com>,
	<Yazen.Ghannam@amd.com>, <mchehab@kernel.org>, <nifan.cxl@gmail.com>,
	<linuxarm@huawei.com>, <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v3 5/8] cxl/edac: Add support for PERFORM_MAINTENANCE command
Date: Mon, 7 Apr 2025 18:49:16 +0100
Message-ID: <20250407174920.625-6-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250407174920.625-1-shiju.jose@huawei.com>
References: <20250407174920.625-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Add support for PERFORM_MAINTENANCE command.

CXL spec 3.2 section 8.2.10.7.1 describes the Perform Maintenance command.
This command requests the device to execute the maintenance operation
specified by the maintenance operation class and the maintenance operation
subclass.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/Kconfig     | 17 ++++++++++++++
 drivers/cxl/core/edac.c | 51 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h    |  1 +
 3 files changed, 69 insertions(+)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 51987f2a2548..2333f7c0b6db 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -164,6 +164,23 @@ config CXL_EDAC_ECS
 	  of a memory ECS feature established by the platform/device.
 	  Otherwise say 'n'.
 
+config CXL_EDAC_MEM_REPAIR
+	bool "Enable CXL Memory Repair"
+	depends on CXL_EDAC_MEM_FEATURES
+	depends on EDAC_MEM_REPAIR
+	help
+	  The CXL EDAC memory repair control is optional and allows host
+	  to control the memory repair features (e.g. sparing, PPR)
+	  configurations of CXL memory expander devices.
+
+	  When enabled 'cxl_mem' EDAC devices are published with memory
+	  repair control attributes as described by
+	  Documentation/ABI/testing/sysfs-edac-memory-repair.
+
+	  Say 'y' if you have an expert need to change default settings
+	  of a memory repair feature established by the platform/device.
+	  Otherwise say 'n'.
+
 config CXL_PORT
 	default CXL_BUS
 	tristate
diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
index a624fc90caf9..246a02785f1d 100644
--- a/drivers/cxl/core/edac.c
+++ b/drivers/cxl/core/edac.c
@@ -791,6 +791,57 @@ static int cxl_memdev_ecs_init(struct cxl_memdev *cxlmd,
 }
 #endif /* CONFIG_CXL_EDAC_ECS */
 
+#ifdef CONFIG_CXL_EDAC_MEM_REPAIR
+/*
+ * Perform Maintenance CXL 3.2 Spec 8.2.10.7.1
+ */
+
+/*
+ * Perform Maintenance input payload
+ * CXL rev 3.2 section 8.2.10.7.1 Table 8-117
+ */
+struct cxl_mbox_maintenance_hdr {
+	u8 op_class;
+	u8 op_subclass;
+} __packed;
+
+static int cxl_perform_maintenance(struct cxl_mailbox *cxl_mbox, u8 class,
+				   u8 subclass, void *data_in,
+				   size_t data_in_size)
+{
+	struct cxl_memdev_maintenance_pi {
+		struct cxl_mbox_maintenance_hdr hdr;
+		u8 data[];
+	} __packed;
+	struct cxl_mbox_cmd mbox_cmd;
+	size_t hdr_size;
+
+	struct cxl_memdev_maintenance_pi *pi __free(kvfree) =
+		kvzalloc(cxl_mbox->payload_size, GFP_KERNEL);
+	if (!pi)
+		return -ENOMEM;
+
+	pi->hdr.op_class = class;
+	pi->hdr.op_subclass = subclass;
+	hdr_size = sizeof(pi->hdr);
+	/*
+	 * Check minimum mbox payload size is available for
+	 * the maintenance data transfer.
+	 */
+	if (hdr_size + data_in_size > cxl_mbox->payload_size)
+		return -ENOMEM;
+
+	memcpy(pi->data, data_in, data_in_size);
+	mbox_cmd = (struct cxl_mbox_cmd){
+		.opcode = CXL_MBOX_OP_DO_MAINTENANCE,
+		.size_in = hdr_size + data_in_size,
+		.payload_in = pi,
+	};
+
+	return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
+}
+#endif /* CONFIG_CXL_EDAC_MEM_REPAIR */
+
 int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd)
 {
 	struct edac_dev_feature ras_features[CXL_NR_EDAC_DEV_FEATURES];
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 685957b312ea..1b9bf6b42521 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -533,6 +533,7 @@ enum cxl_opcode {
 	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
 	CXL_MBOX_OP_GET_FEATURE		= 0x0501,
 	CXL_MBOX_OP_SET_FEATURE		= 0x0502,
+	CXL_MBOX_OP_DO_MAINTENANCE	= 0x0600,
 	CXL_MBOX_OP_IDENTIFY		= 0x4000,
 	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
 	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
-- 
2.43.0


