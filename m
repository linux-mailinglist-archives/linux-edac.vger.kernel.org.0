Return-Path: <linux-edac+bounces-4497-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD35B18678
	for <lists+linux-edac@lfdr.de>; Fri,  1 Aug 2025 19:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92E8A1AA55D7
	for <lists+linux-edac@lfdr.de>; Fri,  1 Aug 2025 17:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBE71E25EF;
	Fri,  1 Aug 2025 17:21:10 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13F51DFE12;
	Fri,  1 Aug 2025 17:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754068870; cv=none; b=Y+4UJRW2VKWlmH9ea2Js2XGct5v6PyWEIQcnYLvX/nPJT3mTr9whysIgWuItJAOq/DPqgE7ytcz1TqoKUkVJzst18+I+dHqDz61l8KnOkaC1Gt+btDpg0fOVwct6iJUX6HlWHLcGhHeu/dxTeN9cGZXTqWLuqEbgvHFlfAENtLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754068870; c=relaxed/simple;
	bh=0bdHk25mef6Hzi8vhzThl6ct099Af8DmVI83In+LGhA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KLH4NebZrshOpfziLLUPXkY4CroRP9JOHcTIt2o3/ITN4xQ+gaJmdJ/y3LphRgyK0nIOk7AsCpCkjiEz3lMJVrcgHcpM/iZVDeLnDuU5Y+wKy0zTbE7KMBE1vuVzxfFm/lzr8s3K278cPngXYpeyBUOqLhBG5/pLlWat2naF1iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4btt3B6q3Vz6L5BD;
	Sat,  2 Aug 2025 01:19:02 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id A50E51400D4;
	Sat,  2 Aug 2025 01:21:05 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.32.206) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Aug 2025 19:21:02 +0200
From: <shiju.jose@huawei.com>
To: <rafael@kernel.org>, <bp@alien8.de>, <akpm@linux-foundation.org>,
	<rppt@kernel.org>, <dferguson@amperecomputing.com>,
	<linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-doc@vger.kernel.org>, <tony.luck@intel.com>,
	<lenb@kernel.org>, <leo.duran@amd.com>, <Yazen.Ghannam@amd.com>,
	<mchehab@kernel.org>
CC: <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>,
	<rientjes@google.com>, <jiaqiyan@google.com>, <Jon.Grimm@amd.com>,
	<dave.hansen@linux.intel.com>, <naoya.horiguchi@nec.com>,
	<james.morse@arm.com>, <jthoughton@google.com>, <somasundaram.a@hpe.com>,
	<erdemaktas@google.com>, <pgonda@google.com>, <duenwen@google.com>,
	<gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<wbs@os.amperecomputing.com>, <nifan.cxl@gmail.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <roberto.sassu@huawei.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<shiju.jose@huawei.com>
Subject: [PATCH v10 1/3] mm: Add node_to_range lookup facility to numa_memblks
Date: Fri, 1 Aug 2025 18:20:27 +0100
Message-ID: <20250801172040.2175-2-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250801172040.2175-1-shiju.jose@huawei.com>
References: <20250801172040.2175-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Lookup facility to retrieve memory phys lowest continuous range for
a NUMA node is required in the numa_memblks for the ACPI RAS2 memory
scrub use case.

Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 include/linux/numa.h         | 10 ++++++++++
 include/linux/numa_memblks.h |  2 ++
 mm/numa.c                    | 10 ++++++++++
 mm/numa_memblks.c            | 23 +++++++++++++++++++++++
 4 files changed, 45 insertions(+)

diff --git a/include/linux/numa.h b/include/linux/numa.h
index e6baaf6051bc..d41e583a902d 100644
--- a/include/linux/numa.h
+++ b/include/linux/numa.h
@@ -41,6 +41,10 @@ int memory_add_physaddr_to_nid(u64 start);
 int phys_to_target_node(u64 start);
 #endif
 
+#ifndef node_to_phys_lowest_continuous_range
+int node_to_phys_lowest_continuous_range(int nid, u64 *start, u64 *end);
+#endif
+
 int numa_fill_memblks(u64 start, u64 end);
 
 #else /* !CONFIG_NUMA */
@@ -63,6 +67,12 @@ static inline int phys_to_target_node(u64 start)
 	return 0;
 }
 
+static inline int node_to_phys_lowest_continuous_range(int nid, u64 *start,
+						       u64 *end)
+{
+	return 0;
+}
+
 static inline void alloc_offline_node_data(int nid) {}
 #endif
 
diff --git a/include/linux/numa_memblks.h b/include/linux/numa_memblks.h
index 991076cba7c5..ccc53029de8b 100644
--- a/include/linux/numa_memblks.h
+++ b/include/linux/numa_memblks.h
@@ -55,6 +55,8 @@ extern int phys_to_target_node(u64 start);
 #define phys_to_target_node phys_to_target_node
 extern int memory_add_physaddr_to_nid(u64 start);
 #define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
+extern int node_to_phys_lowest_continuous_range(int nid, u64 *start, u64 *end);
+#define node_to_phys_lowest_continuous_range node_to_phys_lowest_continuous_range
 #endif /* CONFIG_NUMA_KEEP_MEMINFO */
 
 #endif /* CONFIG_NUMA_MEMBLKS */
diff --git a/mm/numa.c b/mm/numa.c
index 7d5e06fe5bd4..0affb56ef4f2 100644
--- a/mm/numa.c
+++ b/mm/numa.c
@@ -59,3 +59,13 @@ int phys_to_target_node(u64 start)
 }
 EXPORT_SYMBOL_GPL(phys_to_target_node);
 #endif
+
+#ifndef node_to_phys_lowest_continuous_range
+int node_to_phys_lowest_continuous_range(int nid, u64 *start, u64 *end)
+{
+	pr_info_once("Unknown target phys addr range for node=%d\n", nid);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(node_to_phys_lowest_continuous_range);
+#endif
diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c
index 541a99c4071a..9cbaa38cb92d 100644
--- a/mm/numa_memblks.c
+++ b/mm/numa_memblks.c
@@ -590,4 +590,27 @@ int memory_add_physaddr_to_nid(u64 start)
 }
 EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
 
+static int nid_to_meminfo(struct numa_meminfo *mi, int nid, u64 *start, u64 *end)
+{
+	int i;
+
+	if (!numa_valid_node(nid))
+		return -EINVAL;
+
+	for (i = 0; i < mi->nr_blks; i++) {
+		if (mi->blk[i].nid == nid) {
+			*start = mi->blk[i].start;
+			*end = mi->blk[i].end;
+			return 0;
+		}
+	}
+
+	return -ENODEV;
+}
+
+int node_to_phys_lowest_continuous_range(int nid, u64 *start, u64 *end)
+{
+	return nid_to_meminfo(&numa_meminfo, nid, start, end);
+}
+EXPORT_SYMBOL_GPL(node_to_phys_lowest_continuous_range);
 #endif /* CONFIG_NUMA_KEEP_MEMINFO */
-- 
2.43.0


