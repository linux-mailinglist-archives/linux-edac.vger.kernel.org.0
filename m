Return-Path: <linux-edac+bounces-2988-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9736AA2C600
	for <lists+linux-edac@lfdr.de>; Fri,  7 Feb 2025 15:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45F863AD677
	for <lists+linux-edac@lfdr.de>; Fri,  7 Feb 2025 14:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9A8248198;
	Fri,  7 Feb 2025 14:45:59 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A632475D6;
	Fri,  7 Feb 2025 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738939559; cv=none; b=MMQtEtGG+1hJnVizt+GeFxD+Gk6HojRV23KsZklGFllKmcvYfOmTJUsHo2xYXFB7O09pLsBCEF46tZRdxBQmjGinrFDe8/94qqiTY2maPn+k7JpJtWIeN4c4p5rUhrUjr+jStKLtIIioUhCkWG34Htnq7EJjlLgYVkudrIRzFn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738939559; c=relaxed/simple;
	bh=RHY+70TLx7jdgyELlyitSVrrwD4iKHlNQTw5hsYhLM0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A9ITKxnMrYQ2+7hA4b1DJUPe2CCQNvkVTs9yzfb227RInE30pPfep2F025s9ZKKmymB+HCbfFCrraTjKGqDQkUJLCC/W2lfXwTV5QP/XQ/7p9SqoKpH2oj7DtajMP3gdc3/DNO0cnvOEKyl49/K/tt7EimTV/TBdZxmVFfAEyK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YqGw64LcYz6HJb1;
	Fri,  7 Feb 2025 22:44:54 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id EB0321401F4;
	Fri,  7 Feb 2025 22:45:55 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.173.5) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Feb 2025 15:45:53 +0100
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
Subject: [PATCH v19 11/15] cxl/region: Add helper function to determine memory is online
Date: Fri, 7 Feb 2025 14:44:40 +0000
Message-ID: <20250207144445.1879-12-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250207144445.1879-1-shiju.jose@huawei.com>
References: <20250207144445.1879-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Add helper function to determine a CXL memory is online.

Use case: certain memory operations are permitted when the memory
is offline only, for eg. some memory repair operations.

Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/core.h   |  9 +++++++++
 drivers/cxl/core/region.c | 10 ++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 23761340e65c..fb3b5f1229e7 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -32,8 +32,17 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port);
 struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
 u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 		   u64 dpa);
+bool cxl_are_decoders_committed(const struct cxl_memdev *cxlmd);
 
 #else
+static inline bool cxl_are_decoders_committed(const struct cxl_memdev *cxlmd)
+{
+	/*
+	 * If no driver, in absence of a way to check, assume decoders are committed.
+	 */
+	return true;
+}
+
 static inline u64 cxl_dpa_to_hpa(struct cxl_region *cxlr,
 				 const struct cxl_memdev *cxlmd, u64 dpa)
 {
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 5339237ced0f..33a3ef839f6a 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2851,6 +2851,16 @@ struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
 	return ctx.cxlr;
 }
 
+bool cxl_are_decoders_committed(const struct cxl_memdev *cxlmd)
+{
+	struct cxl_port *port = cxlmd->endpoint;
+
+	if (port && is_cxl_endpoint(port) && cxl_num_decoders_committed(port))
+		return true;
+
+	return false;
+}
+
 static bool cxl_is_hpa_in_chunk(u64 hpa, struct cxl_region *cxlr, int pos)
 {
 	struct cxl_region_params *p = &cxlr->params;
-- 
2.43.0


