Return-Path: <linux-edac+bounces-2569-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 470CD9D37C2
	for <lists+linux-edac@lfdr.de>; Wed, 20 Nov 2024 11:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E89441F23126
	for <lists+linux-edac@lfdr.de>; Wed, 20 Nov 2024 10:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0901A08C6;
	Wed, 20 Nov 2024 10:00:29 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CA219F46D;
	Wed, 20 Nov 2024 10:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732096828; cv=none; b=dAAr8Co6q0AWaLOHcvJKiT7T6cfoytMnn+0RS42ysHNBIyJSRKiz82onVvIFno1TEzd8IgPY3f3wdETGky5WCxS+hpL3gPTLVyXmYHEQ8ZHfB7i1WY/66cHlt3OVKcKmUrAEINEvlK4FnXMnltA5uo9ff/MuApazFkSi+Ey0tg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732096828; c=relaxed/simple;
	bh=18A4qVqah5nZX5/kqkMBKLYmiZOBSZB4bPHEHDxopL8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pGXmObY9qfy7Qg3xF+j+k6UnXgK2qdpIlR4Wkze4TDn/fkXa1VUUxOmEz+BVs2fpMCi8Vf79l3xQar3syYRVrlGUiq5opo9hbu+p4u4T6LlLkzPEsWpw5PXHB6WNOTZi1OLFRKuL3GjAkC4LlalA3B7JR5juwYJARynmPFAcTRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XtcHg40VFz6K94r;
	Wed, 20 Nov 2024 17:58:07 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 1F6431400DB;
	Wed, 20 Nov 2024 18:00:24 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.247.212) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 20 Nov 2024 11:00:23 +0100
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<mchehab@kernel.org>, <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<nifan.cxl@gmail.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dave@stgolabs.net>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH 05/13] rasdaemon: cxl: Add Component Identifier formatting for CXL spec rev 3.1
Date: Wed, 20 Nov 2024 09:59:15 +0000
Message-ID: <20241120095923.1891-6-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20241120095923.1891-1-shiju.jose@huawei.com>
References: <20241120095923.1891-1-shiju.jose@huawei.com>
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

Add Component Identifier formatting for CXL spec rev 3.1, Section
8.2.9.2.1, Table 8-44.

Add helper function to print component ID, parse and log PLDM entity ID
and resource ID.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 ras-cxl-handler.c | 41 +++++++++++++++++++++++++++++++++++++++++
 ras-record.h      |  3 +++
 2 files changed, 44 insertions(+)

diff --git a/ras-cxl-handler.c b/ras-cxl-handler.c
index d16eaef..80afa9f 100644
--- a/ras-cxl-handler.c
+++ b/ras-cxl-handler.c
@@ -573,6 +573,47 @@ int ras_cxl_overflow_event_handler(struct trace_seq *s,
 	return 0;
 }
 
+/*
+ * Component ID Format
+ * CXL 3.1 section 8.2.9.2.1; Table 8-44
+ */
+#define CXL_PLDM_COMPONENT_ID_ENTITY_VALID	BIT(0)
+#define CXL_PLDM_COMPONENT_ID_RES_VALID		BIT(1)
+static const struct  cxl_event_flags cxl_pldm_comp_id_flags[] = {
+	{ .bit = CXL_PLDM_COMPONENT_ID_ENTITY_VALID, .flag = "PLDM Entity ID" },
+	{ .bit = CXL_PLDM_COMPONENT_ID_RES_VALID, .flag = "Resource ID" },
+};
+
+static int ras_cxl_print_component_id(struct trace_seq *s, uint8_t *comp_id,
+				      uint8_t *entity_id, uint8_t *res_id)
+{
+	int i;
+
+	if (comp_id[0] & CXL_PLDM_COMPONENT_ID_ENTITY_VALID) {
+		if (trace_seq_printf(s, "PLDM Entity ID:") <= 0)
+			return -1;
+		for (i = 1; i < 7; i++) {
+			if (trace_seq_printf(s, "%02x ", comp_id[i]) <= 0)
+				return -1;
+		}
+		if (entity_id)
+			memcpy(entity_id, &comp_id[1], CXL_PLDM_ENTITY_ID_LEN);
+	}
+
+	if (comp_id[0] & CXL_PLDM_COMPONENT_ID_RES_VALID) {
+		if (trace_seq_printf(s, "Resource ID:") <= 0)
+			return -1;
+		for (i = 7; i < 11; i++) {
+			if (trace_seq_printf(s, "%02x ", comp_id[i]) <= 0)
+				return -1;
+		}
+		if (res_id)
+			memcpy(res_id, &comp_id[7], CXL_PLDM_RES_ID_LEN);
+	}
+
+	return 0;
+}
+
 /*
  * Common Event Record Format
  * CXL 3.1 section 8.2.9.2.1; Table 8-43
diff --git a/ras-record.h b/ras-record.h
index 2a0124a..a3a88eb 100644
--- a/ras-record.h
+++ b/ras-record.h
@@ -137,6 +137,9 @@ struct ras_cxl_poison_event {
 #define CXL_EVENT_GEN_MED_COMP_ID_SIZE	0x10
 #define CXL_EVENT_DER_CORRECTION_MASK_SIZE	0x20
 
+#define CXL_PLDM_ENTITY_ID_LEN	6
+#define CXL_PLDM_RES_ID_LEN	4
+
 struct ras_cxl_aer_ue_event {
 	char timestamp[64];
 	const char *memdev;
-- 
2.43.0


