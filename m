Return-Path: <linux-edac+bounces-4289-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1834CAEE44E
	for <lists+linux-edac@lfdr.de>; Mon, 30 Jun 2025 18:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE14B165EC8
	for <lists+linux-edac@lfdr.de>; Mon, 30 Jun 2025 16:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038102BD587;
	Mon, 30 Jun 2025 16:20:54 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0D5290D83
	for <linux-edac@vger.kernel.org>; Mon, 30 Jun 2025 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751300453; cv=none; b=hbHdA+O3ZgJBz8ByuPohnCwKBVnegaSL4rDwUE38FZbL0xmEwUw1j2dAvK89pgTCh8D7WyBD7YliPDdscPxbA/39T0tNyX8hoC8GwYteha+92pFEONtHyOrCtpZwbSveBnQZ0GUXsBHWmLEfw6SDt1gVZnaayMmCDrcB1OioHxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751300453; c=relaxed/simple;
	bh=+zVrYUqoM1/4ALASwi0B5C19Y9qYVssl/pfsO0gnB7g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DHGVA4gAASvUFePv6ncPS4p4QpvRHPSTaaFCy/T80DYIfDWL7vEz+OoRCCd0RU3MY9rxd3DmctlA9EhSosx/WpE6D8rJ8jIN4YSjSZqJ0tSgoHCkF/VbYJwkDpJArKx7Zy3o0em1EGKqdSkik3PHCWn8bVp6Fmbzwud8nGw88r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bWBGP2nD0z6L4rt;
	Tue,  1 Jul 2025 00:20:29 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 571031402F0;
	Tue,  1 Jul 2025 00:20:49 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.170.174) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Jun 2025 18:20:48 +0200
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<arnd@kernel.org>, <mchehab@kernel.org>, <rric@kernel.org>,
	<dave.jiang@intel.com>, <jonathan.cameron@huawei.com>
CC: <linuxarm@huawei.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH 1/2] EDAC/scrub: Reduce stack usage in scrub_create_desc()
Date: Mon, 30 Jun 2025 17:20:33 +0100
Message-ID: <20250630162034.1788-2-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250630162034.1788-1-shiju.jose@huawei.com>
References: <20250630162034.1788-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Constructing an array on the stack can exceed the warning limit
for per-function stack usage.

Change this to have the actual attribute array allocated statically and
then add the instance number on the per-instance copy.

Fixes: f90b738166fe ("EDAC: Add scrub control feature")
Suggested-by: Borislav Petkov (AMD) <bp@alien8.de>
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


