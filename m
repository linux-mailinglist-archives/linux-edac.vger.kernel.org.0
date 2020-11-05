Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9672A858E
	for <lists+linux-edac@lfdr.de>; Thu,  5 Nov 2020 19:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731799AbgKESBt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 5 Nov 2020 13:01:49 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2061 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgKESBt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 5 Nov 2020 13:01:49 -0500
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CRrS12JZbz67Dkr;
        Fri,  6 Nov 2020 01:41:53 +0800 (CST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 5 Nov 2020 18:43:28 +0100
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.87.221) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 5 Nov 2020 17:43:26 +0000
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <james.morse@arm.com>,
        <bp@alien8.de>, <tony.luck@intel.com>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>, <rrichter@marvell.com>
CC:     <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
        <shiju.jose@huawei.com>
Subject: [RFC PATCH 1/4] ACPI: PPTT: Fix for a high level cache node detected in the low level
Date:   Thu, 5 Nov 2020 17:42:30 +0000
Message-ID: <20201105174233.1146-2-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20201105174233.1146-1-shiju.jose@huawei.com>
References: <20201105174233.1146-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.87.221]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml715-chm.china.huawei.com (10.201.108.66)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Jonathan Cameron <jonathan.cameron@huawei.com>

According to the following sections of the PPTT definition in the
ACPI specification(V6.3), a high level cache node( For example L2 cache)
could be represented simultaneously both in the private resource
of a CPU node and via the next_level_of_cache pointer of a low level
cache node.
1. Section 5.2.29.1 Processor hierarchy node structure (Type 0)
"Each processor node includes a list of resources that are private
to that node. Resources are described in other PPTT structures such as
Type 1 cache structures. The processor node’s private resource list
includes a reference to each of the structures that represent private
resources to a given processor node. For example, an SoC level processor
node might contain two references, one pointing to a Level 3 cache
resource and another pointing to an ID structure."

2. Section 5.2.29.2 Cache Type Structure - Type 1
   Figure 5-26 Cache Type Structure - Type 1 Example

For the use case of creating EDAC device blocks for the CPU caches,
we need to search for cache node types in all levels using
acpi_find_cache_node(), as a platform independent solution to
retrieve the cache info from the ACPI PPTT. The reason is that
cacheinfo in the drivers/base/cacheinfo.c would not be populated
in this stage. In this case, we found acpi_find_cache_node()
mistakenly detecting high level cache as low level cache, when
the cache node is in the processor node’s private resource list.

To fix this issue add duplication check in the acpi_find_cache_level(),
for a cache node found in the private resource of a CPU node
with all the next level of caches present in the other cache nodes.

Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Co-developed-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/acpi/pptt.c | 61 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index 4ae93350b70d..de1dd605d3ad 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -132,21 +132,80 @@ static unsigned int acpi_pptt_walk_cache(struct acpi_table_header *table_hdr,
 	return local_level;
 }
 
+/**
+ * acpi_pptt_walk_check_duplicate() - Find the cache resource to check,
+ * is a duplication in the next_level_of_cache pointer of other cache.
+ * @table_hdr: Pointer to the head of the PPTT table
+ * @res: cache resource in the PPTT we want to walk
+ * @res_check: cache resource in the PPTT we want to check for duplication.
+ *
+ * Given both PPTT resource, verify that they are cache nodes, then walk
+ * down each level of cache @res, and check for the duplication.
+ *
+ * Return: true if duplication found, false otherwise.
+ */
+static bool acpi_pptt_walk_check_duplicate(struct acpi_table_header *table_hdr,
+					   struct acpi_subtable_header *res,
+					   struct acpi_subtable_header *res_check)
+{
+	struct acpi_pptt_cache *cache;
+	struct acpi_pptt_cache *check;
+
+	if (res->type != ACPI_PPTT_TYPE_CACHE ||
+	    res_check->type != ACPI_PPTT_TYPE_CACHE)
+		return false;
+
+	cache = (struct acpi_pptt_cache *)res;
+	check = (struct acpi_pptt_cache *)res_check;
+	while (cache) {
+		if (cache == check)
+			return true;
+		cache = fetch_pptt_cache(table_hdr, cache->next_level_of_cache);
+	}
+
+	return false;
+}
+
 static struct acpi_pptt_cache *
 acpi_find_cache_level(struct acpi_table_header *table_hdr,
 		      struct acpi_pptt_processor *cpu_node,
 		      unsigned int *starting_level, unsigned int level,
 		      int type)
 {
-	struct acpi_subtable_header *res;
+	struct acpi_subtable_header *res, *res2;
 	unsigned int number_of_levels = *starting_level;
 	int resource = 0;
+	int resource2 = 0;
+	bool duplicate = false;
 	struct acpi_pptt_cache *ret = NULL;
 	unsigned int local_level;
 
 	/* walk down from processor node */
 	while ((res = acpi_get_pptt_resource(table_hdr, cpu_node, resource))) {
 		resource++;
+		/*
+		 * PPTT definition in the ACPI specification allows a high level cache
+		 * node would be represented simultaneously both in the private resource
+		 * of a CPU node and via the next_level_of_cache pointer of another cache node,
+		 * within the same CPU hierarchy. This resulting acpi_find_cache_level()
+		 * mistakenly detects a higher level cache node in the low level as well.
+		 *
+		 * Check a cache node in the private resource of the CPU node for any
+		 * duplication.
+		 */
+		resource2 = 0;
+		duplicate = false;
+		while ((res2 = acpi_get_pptt_resource(table_hdr, cpu_node, resource2))) {
+			resource2++;
+			if (res2 == res)
+				continue;
+			if (acpi_pptt_walk_check_duplicate(table_hdr, res2, res)) {
+				duplicate = true;
+				break;
+			}
+		}
+		if (duplicate)
+			continue;
 
 		local_level = acpi_pptt_walk_cache(table_hdr, *starting_level,
 						   res, &ret, level, type);
-- 
2.17.1

