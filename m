Return-Path: <linux-edac+bounces-3975-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 847F5ABF4B2
	for <lists+linux-edac@lfdr.de>; Wed, 21 May 2025 14:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BB2F1BC1AF2
	for <lists+linux-edac@lfdr.de>; Wed, 21 May 2025 12:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E503267AF6;
	Wed, 21 May 2025 12:48:30 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A98A2673B7;
	Wed, 21 May 2025 12:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747831710; cv=none; b=ujM5edzwJrDqzmfS95GZ9l6xZeKFh2QEotmq/KMwuC53TWA/qzU3qkj6e95bePjYCJHpxWdP1jDzd9JfF3CcpSFFpSoS1O4+GsWZvaDjS8tIp/69TwriJmuLf/0ptTGHE2TSanfP1ro57rlRIsHmM/epcLe/SoXelntt595S8IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747831710; c=relaxed/simple;
	bh=5j6C5DQZHevYLZrM8t2Lqr1rHkicK9RhjjmRRUZcjVM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m73vB0EgPwbiMWK2lK9zNl9VgIv3PRIUKYYhRQSi1//Vi438pOS0HIr6V2RmKM+apoecrNrX8rAUmeI1fGYW7vgVig6Ju3kD+eOxtNq2ludPUnRrn1op3XfofRSkKqRjVrasWia2HPNzhyP/ljTiyMneCcevsGhbYcaKSddsiz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b2WLb29bQz6DB9L;
	Wed, 21 May 2025 20:43:35 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 9FDE7140390;
	Wed, 21 May 2025 20:48:26 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.151.26) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 May 2025 14:48:25 +0200
From: <shiju.jose@huawei.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>
CC: <linux-edac@vger.kernel.org>, <linux-doc@vger.kernel.org>, <bp@alien8.de>,
	<tony.luck@intel.com>, <lenb@kernel.org>, <Yazen.Ghannam@amd.com>,
	<mchehab@kernel.org>, <nifan.cxl@gmail.com>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v6 5/8] cxl/edac: Add support for PERFORM_MAINTENANCE command
Date: Wed, 21 May 2025 13:47:43 +0100
Message-ID: <20250521124749.817-6-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250521124749.817-1-shiju.jose@huawei.com>
References: <20250521124749.817-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
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
 drivers/cxl/core/edac.c | 49 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h    |  1 +
 2 files changed, 50 insertions(+)

diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
index 9c15d4ce2162..36e222dbbbf0 100644
--- a/drivers/cxl/core/edac.c
+++ b/drivers/cxl/core/edac.c
@@ -814,6 +814,55 @@ static int cxl_memdev_ecs_init(struct cxl_memdev *cxlmd,
 	return 0;
 }
 
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
+
 int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd)
 {
 	struct edac_dev_feature ras_features[CXL_NR_EDAC_DEV_FEATURES];
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 872131009e4c..1d4fe19c554d 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -531,6 +531,7 @@ enum cxl_opcode {
 	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
 	CXL_MBOX_OP_GET_FEATURE		= 0x0501,
 	CXL_MBOX_OP_SET_FEATURE		= 0x0502,
+	CXL_MBOX_OP_DO_MAINTENANCE	= 0x0600,
 	CXL_MBOX_OP_IDENTIFY		= 0x4000,
 	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
 	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
-- 
2.43.0


