Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D45172A858B
	for <lists+linux-edac@lfdr.de>; Thu,  5 Nov 2020 19:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731591AbgKESBt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 5 Nov 2020 13:01:49 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2060 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKESBt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 5 Nov 2020 13:01:49 -0500
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CRrSg73zhz67HHg;
        Fri,  6 Nov 2020 01:42:27 +0800 (CST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 5 Nov 2020 18:44:02 +0100
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.87.221) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 5 Nov 2020 17:44:01 +0000
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <james.morse@arm.com>,
        <bp@alien8.de>, <tony.luck@intel.com>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>, <rrichter@marvell.com>
CC:     <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
        <shiju.jose@huawei.com>
Subject: [RFC PATCH 2/4] ACPI: PPTT: Add function acpi_find_cache_info
Date:   Thu, 5 Nov 2020 17:42:31 +0000
Message-ID: <20201105174233.1146-3-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20201105174233.1146-1-shiju.jose@huawei.com>
References: <20201105174233.1146-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.47.87.221]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml715-chm.china.huawei.com (10.201.108.66)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add function acpi_find_cache_info() to find the
information of the caches found in a CPU hierarchy
represented in the PPTT.

Co-developed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/acpi/pptt.c       | 62 +++++++++++++++++++++++++++++++++++++++
 include/linux/cacheinfo.h | 12 ++++++++
 2 files changed, 74 insertions(+)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index de1dd605d3ad..5f46e6257e6b 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -670,6 +670,68 @@ int acpi_find_last_cache_level(unsigned int cpu)
 	return number_of_levels;
 }
 
+/**
+ * acpi_find_cache_info() - Find the information of CPU caches
+ * represented in the PPTT.
+ * @cpu: Kernel logical CPU number.
+ * @cacheinfo: array of struct acpi_cacheinfo.
+ * @size: dimension of the array.
+ *
+ * Given a logical CPU number, returns the info of caches
+ * represented in the PPTT.
+ * Errors caused by lack of a PPTT table, or otherwise, return 0
+ * indicating we didn't find any cache levels.
+ *
+ * Return: total number of caches found in the CPU hierarchy or error.
+ */
+int acpi_find_cache_info(unsigned int cpu, struct acpi_cacheinfo *cacheinfo,
+			 size_t size)
+{
+	u32 acpi_cpu_id;
+	acpi_status status;
+	struct acpi_table_header *table_hdr;
+	struct acpi_pptt_processor *cpu_node = NULL;
+	struct acpi_pptt_cache *found_cache;
+	int i, number_of_caches = 0;
+	int max_level, level = 1;
+	enum cache_type type[] = {
+		CACHE_TYPE_DATA,
+		CACHE_TYPE_INST,
+		CACHE_TYPE_UNIFIED,
+	};
+
+	if (!cacheinfo || !size)
+		return -ENOMEM;
+
+	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table_hdr);
+	if (ACPI_FAILURE(status)) {
+		acpi_pptt_warn_missing();
+		return -ENOENT;
+	}
+
+	acpi_cpu_id = get_acpi_id_for_cpu(cpu);
+	max_level = acpi_find_cache_levels(table_hdr, acpi_cpu_id);
+	while (level <= max_level) {
+		for (i = 0; i < ARRAY_SIZE(type); i++) {
+			found_cache = acpi_find_cache_node(table_hdr, acpi_cpu_id,
+							   type[i], level, &cpu_node);
+			if (found_cache) {
+				cacheinfo[number_of_caches].level = level;
+				cacheinfo[number_of_caches].type = acpi_cache_type(type[i]);
+				number_of_caches++;
+				if (number_of_caches >= size) {
+					acpi_put_table(table_hdr);
+					return -ENOMEM;
+				}
+			}
+		}
+		level++;
+	}
+	acpi_put_table(table_hdr);
+
+	return number_of_caches;
+}
+
 /**
  * cache_setup_acpi() - Override CPU cache topology with data from the PPTT
  * @cpu: Kernel logical CPU number
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index 4f72b47973c3..7d37945d2650 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -79,6 +79,11 @@ struct cpu_cacheinfo {
 	bool cpu_map_populated;
 };
 
+struct acpi_cacheinfo {
+	u8 level;
+	u8 type;
+};
+
 /*
  * Helpers to make sure "func" is executed on the cpu whose cache
  * attributes are being detected
@@ -114,8 +119,15 @@ static inline int acpi_find_last_cache_level(unsigned int cpu)
 {
 	return 0;
 }
+static inline int acpi_find_cache_info(unsigned int cpu, struct acpi_cacheinfo *cacheinfo,
+				       size_t size)
+{
+	return 0;
+}
 #else
 int acpi_find_last_cache_level(unsigned int cpu);
+int acpi_find_cache_info(unsigned int cpu, struct acpi_cacheinfo *cacheinfo,
+			 size_t size);
 #endif
 
 const struct attribute_group *cache_get_priv_group(struct cacheinfo *this_leaf);
-- 
2.17.1

