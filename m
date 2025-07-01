Return-Path: <linux-edac+bounces-4297-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EDAAEEDF9
	for <lists+linux-edac@lfdr.de>; Tue,  1 Jul 2025 07:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09ABC1892CFD
	for <lists+linux-edac@lfdr.de>; Tue,  1 Jul 2025 05:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A601B3937;
	Tue,  1 Jul 2025 05:50:56 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8736F1E7C32
	for <linux-edac@vger.kernel.org>; Tue,  1 Jul 2025 05:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751349056; cv=none; b=LS9Ds8wAJ/wAlRaJIMYnhGZvMO9Xq/ZLGATVJlCPrYKr0DW36lTk2r67W4+MUdjQyUZwBFQFfCmRWY4oLEimPemc4rj7ddRSgGEddOEQTDOo9uX0e59T61B6dYy7m0uMpYUNYrmAWIkhG85UOvYphtk9bgI6etbJcvtgav2qWEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751349056; c=relaxed/simple;
	bh=MY2vFM0AlgxK5wGGgp4qrOKHdJ0Wd0IX8P7UFBFgCFU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AR+XSZgwKyHm6cT2O9krW4+VRFx8qSj3q9kDnj4LudaEckvbkIxX7mcrBxQsj+NBZpBed9h1FyMuiFnemnoY54cU/IRXDZ+Vl+QDrO6K+Q+aYDadEICWmxHUliBLg0L7/O4k2c9HORjHo0SlMrO+LzwGu5JtSdiD1GUoYxjyNUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bWXF13mZNz6L5p1;
	Tue,  1 Jul 2025 13:50:29 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 46BF414027A;
	Tue,  1 Jul 2025 13:50:51 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.33.96) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 1 Jul 2025 07:50:50 +0200
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<arnd@kernel.org>, <mchehab@kernel.org>, <rric@kernel.org>,
	<dave.jiang@intel.com>, <jonathan.cameron@huawei.com>
CC: <linuxarm@huawei.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH v2 1/2] EDAC/scrub: Reduce stack usage in scrub_create_desc()
Date: Tue, 1 Jul 2025 06:50:34 +0100
Message-ID: <20250701055036.1802-2-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250701055036.1802-1-shiju.jose@huawei.com>
References: <20250701055036.1802-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Constructing an array on the stack can exceed the warning limit
for per-function stack usage.

Change this to have the actual attribute array allocated statically and
then add the instance number on the per-instance copy.

Fixes: f90b738166fe ("EDAC: Add scrub control feature")
Suggested-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/edac/scrub.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/edac/scrub.c b/drivers/edac/scrub.c
index f9d02af2fc3a..850347d274e8 100755
--- a/drivers/edac/scrub.c
+++ b/drivers/edac/scrub.c
@@ -142,17 +142,14 @@ static umode_t scrub_attr_visible(struct kobject *kobj, struct attribute *a, int
 	return 0;
 }
 
-#define EDAC_SCRUB_ATTR_RO(_name, _instance)       \
-	((struct edac_scrub_dev_attr) { .dev_attr = __ATTR_RO(_name), \
-					.instance = _instance })
-
-#define EDAC_SCRUB_ATTR_WO(_name, _instance)       \
-	((struct edac_scrub_dev_attr) { .dev_attr = __ATTR_WO(_name), \
-					.instance = _instance })
-
-#define EDAC_SCRUB_ATTR_RW(_name, _instance)       \
-	((struct edac_scrub_dev_attr) { .dev_attr = __ATTR_RW(_name), \
-					.instance = _instance })
+static const struct device_attribute scrub_dev_attr[] = {
+	[SCRUB_ADDRESS]		    = __ATTR_RW(addr),
+	[SCRUB_SIZE]		    = __ATTR_RW(size),
+	[SCRUB_ENABLE_BACKGROUND]   = __ATTR_RW(enable_background),
+	[SCRUB_MIN_CYCLE_DURATION]  = __ATTR_RO(min_cycle_duration),
+	[SCRUB_MAX_CYCLE_DURATION]  = __ATTR_RO(max_cycle_duration),
+	[SCRUB_CUR_CYCLE_DURATION]  = __ATTR_RW(current_cycle_duration)
+};
 
 static int scrub_create_desc(struct device *scrub_dev,
 			     const struct attribute_group **attr_groups, u8 instance)
@@ -160,14 +157,6 @@ static int scrub_create_desc(struct device *scrub_dev,
 	struct edac_scrub_context *scrub_ctx;
 	struct attribute_group *group;
 	int i;
-	struct edac_scrub_dev_attr dev_attr[] = {
-		[SCRUB_ADDRESS] = EDAC_SCRUB_ATTR_RW(addr, instance),
-		[SCRUB_SIZE] = EDAC_SCRUB_ATTR_RW(size, instance),
-		[SCRUB_ENABLE_BACKGROUND] = EDAC_SCRUB_ATTR_RW(enable_background, instance),
-		[SCRUB_MIN_CYCLE_DURATION] = EDAC_SCRUB_ATTR_RO(min_cycle_duration, instance),
-		[SCRUB_MAX_CYCLE_DURATION] = EDAC_SCRUB_ATTR_RO(max_cycle_duration, instance),
-		[SCRUB_CUR_CYCLE_DURATION] = EDAC_SCRUB_ATTR_RW(current_cycle_duration, instance)
-	};
 
 	scrub_ctx = devm_kzalloc(scrub_dev, sizeof(*scrub_ctx), GFP_KERNEL);
 	if (!scrub_ctx)
@@ -175,7 +164,9 @@ static int scrub_create_desc(struct device *scrub_dev,
 
 	group = &scrub_ctx->group;
 	for (i = 0; i < SCRUB_MAX_ATTRS; i++) {
-		memcpy(&scrub_ctx->scrub_dev_attr[i], &dev_attr[i], sizeof(dev_attr[i]));
+		scrub_ctx->scrub_dev_attr[i].dev_attr = scrub_dev_attr[i];
+		scrub_ctx->scrub_dev_attr[i].instance = instance;
+
 		sysfs_attr_init(&scrub_ctx->scrub_dev_attr[i].dev_attr.attr);
 		scrub_ctx->scrub_attrs[i] = &scrub_ctx->scrub_dev_attr[i].dev_attr.attr;
 	}
-- 
2.43.0


