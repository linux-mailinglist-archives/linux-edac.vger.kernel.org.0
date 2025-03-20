Return-Path: <linux-edac+bounces-3380-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7572A6ACB3
	for <lists+linux-edac@lfdr.de>; Thu, 20 Mar 2025 19:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09F357B0D0A
	for <lists+linux-edac@lfdr.de>; Thu, 20 Mar 2025 18:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABA2226D0A;
	Thu, 20 Mar 2025 18:05:35 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F55C1DE3A8;
	Thu, 20 Mar 2025 18:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493935; cv=none; b=cF7it1hFNfD2Zk4+j7k5O1Uy01qr+oCk3XkMTn6he32IgwhatiYVd3Bi7jd75qYQxEZQPqBtfYRAN9wjr6rb2/vNHSMHwtxmMXsLYUJdMi+TKS5uCtZ4/mSdaFUV6WogWAOPUNq48vlGbiqaa5cliuBl3R35mN6NvoZS5jEcHSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493935; c=relaxed/simple;
	bh=GtKULYl0mYctQnoh3gUdY0HmdBwjuAmD9xWw0mVxGPM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YN5eWHpj03ShKbWeN7bQejlXDKyzxhCF0w6/tqp4GESJl4Xi2oxS2hdn0oIHzGdkXkOS0dtjhUhf2UQVzf7MiViJicFlBFlkoFhA1dDFtAdzOPqtLcWGFvzhG53+m1uMfX7rlg+XBqfCS8Vs8hT5/J7u5HctM3QaXrVsLUjEz0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZJYMD2qYjz6K99G;
	Fri, 21 Mar 2025 02:02:32 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id E283B14050D;
	Fri, 21 Mar 2025 02:05:30 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.156.145) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Mar 2025 19:05:28 +0100
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
Subject: [PATCH v2 1/8] cxl: Add helper function to retrieve a feature entry
Date: Thu, 20 Mar 2025 18:04:38 +0000
Message-ID: <20250320180450.539-2-shiju.jose@huawei.com>
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

Add helper function to retrieve a feature entry from the supported
features list, if supported.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/core.h     |  2 ++
 drivers/cxl/core/features.c | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 1803aedb25ca..16bc717376fc 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -123,6 +123,8 @@ int cxl_ras_init(void);
 void cxl_ras_exit(void);
 
 #ifdef CONFIG_CXL_FEATURES
+struct cxl_feat_entry *cxl_get_feature_entry(struct cxl_dev_state *cxlds,
+					     const uuid_t *feat_uuid);
 size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 		       enum cxl_get_feat_selection selection,
 		       void *feat_out, size_t feat_out_size, u16 offset,
diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index 048ba4fc3538..202c8c21930c 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -203,6 +203,29 @@ int devm_cxl_setup_features(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_features, "CXL");
 
+struct cxl_feat_entry *cxl_get_feature_entry(struct cxl_dev_state *cxlds,
+					     const uuid_t *feat_uuid)
+{
+	struct cxl_features_state *cxlfs = to_cxlfs(cxlds);
+	struct cxl_feat_entry *feat_entry;
+	int count;
+
+	if (!cxlfs || !cxlfs->entries || !cxlfs->entries->num_features)
+		return NULL;
+
+	/*
+	 * Retrieve the feature entry from the supported features list,
+	 * if the feature is supported.
+	 */
+	feat_entry = cxlfs->entries->ent;
+	for (count = 0; count < cxlfs->entries->num_features; count++, feat_entry++) {
+		if (uuid_equal(&feat_entry->uuid, feat_uuid))
+			return feat_entry;
+	}
+
+	return NULL;
+}
+
 size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 		       enum cxl_get_feat_selection selection,
 		       void *feat_out, size_t feat_out_size, u16 offset,
-- 
2.43.0


