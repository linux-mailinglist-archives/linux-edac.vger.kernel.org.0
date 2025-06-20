Return-Path: <linux-edac+bounces-4196-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ED0AE1A28
	for <lists+linux-edac@lfdr.de>; Fri, 20 Jun 2025 13:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20F5E3A7B06
	for <lists+linux-edac@lfdr.de>; Fri, 20 Jun 2025 11:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7858D289E1B;
	Fri, 20 Jun 2025 11:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUvJ6t6h"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D6E21A425;
	Fri, 20 Jun 2025 11:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750419700; cv=none; b=Akmb+p4kHXFlKtxwFScJ8L5tsn8g5DxfVPW7bQgxunCDOSqOo6KzEDAQS1CFXd3DEr3RruzDfJK/E31A9EOCiUz6ycWmLfcVzqcSWGQUXTynhuy383nUhhkCAHxGHeqEaXrPaz4a/Zx7d6CJu64+J1zYvUG/GjetF6+Y5JCnwXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750419700; c=relaxed/simple;
	bh=7jO5EkOKHQFOUcZ4HOZ+7p+fQUAUaAut8T+zMp0e1vU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D2VNSedg3h+7NGUskJxo1RYLXt/OEHLXzk6gf62HJczNCFPdnsFIrxkU1bsOz84WPKpW9A2/x6k0wFQqTRBgugk5I2Zk2jVmxkkWHmf24gmnhJ0qhRK6Sp3gB2WGXakgp9lt/veB0iWO3QqBqju7YrEuzw8YC4WTxBs7uj0ensw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUvJ6t6h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F19C4CEE3;
	Fri, 20 Jun 2025 11:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750419699;
	bh=7jO5EkOKHQFOUcZ4HOZ+7p+fQUAUaAut8T+zMp0e1vU=;
	h=From:To:Cc:Subject:Date:From;
	b=hUvJ6t6hBmEDsdNmDlxXz6D29wVyyMBGSEsPXHI0QTZcWpo0GOr9W7vZvcosPisGL
	 deyjD9e/jWWOqtyVxpqzmeGqhUjjad7ESqLkym4JPnOCVViARjwPAdxc6VxFEWNAGN
	 nty4qjMU3O68FrGTn/aiJzzxHiIUHQ8Fdfe1w4g0G4DXYdEXz7T8EQmiBrD5kawaRX
	 m2bRgsGvVxe6lofSr/1wixBYArAi3IIV6g3uHAc+4xo/SoaXeSXYelAd6rA7lJlGon
	 k36QRTUyU/voN4r4kgQX7glDvSYksNN+4JTEBekNitZsoPnK3XOXS4i2E+Mh2i5wc1
	 S/NKHQ9Vto4Nw==
From: Arnd Bergmann <arnd@kernel.org>
To: Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	Shiju Jose <shiju.jose@huawei.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] EDAC: mem_repair: reduce stack usage in edac_mem_repair_get_desc()
Date: Fri, 20 Jun 2025 13:41:28 +0200
Message-Id: <20250620114135.4017183-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Constructing an array on the stack adds complexity and can exceed the
warning limit for per-function stack usage:

drivers/edac/mem_repair.c:361:5: error: stack frame size (1296) exceeds limit (1280) in 'edac_mem_repair_get_desc' [-Werror,-Wframe-larger-than]

Change this to have the actual attribute array allocated statically
and then just add the instance number on the per-instance copy.

Fixes: 699ea5219c4b ("EDAC: Add a memory repair control feature")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/edac/mem_repair.c | 56 +++++++++++++++------------------------
 1 file changed, 22 insertions(+), 34 deletions(-)

diff --git a/drivers/edac/mem_repair.c b/drivers/edac/mem_repair.c
index d1a8caa85369..2e4e790e0ffe 100755
--- a/drivers/edac/mem_repair.c
+++ b/drivers/edac/mem_repair.c
@@ -286,17 +286,26 @@ static umode_t mem_repair_attr_visible(struct kobject *kobj, struct attribute *a
 	return 0;
 }
 
-#define MR_ATTR_RO(_name, _instance)       \
-	((struct edac_mem_repair_dev_attr) { .dev_attr = __ATTR_RO(_name), \
-					     .instance = _instance })
-
-#define MR_ATTR_WO(_name, _instance)       \
-	((struct edac_mem_repair_dev_attr) { .dev_attr = __ATTR_WO(_name), \
-					     .instance = _instance })
-
-#define MR_ATTR_RW(_name, _instance)       \
-	((struct edac_mem_repair_dev_attr) { .dev_attr = __ATTR_RW(_name), \
-					     .instance = _instance })
+static const struct device_attribute mem_repair_dev_attr[] = {
+	[MR_TYPE]	  = __ATTR_RO(repair_type),
+	[MR_PERSIST_MODE] = __ATTR_RW(persist_mode),
+	[MR_SAFE_IN_USE]  = __ATTR_RO(repair_safe_when_in_use),
+	[MR_HPA]	  = __ATTR_RW(hpa),
+	[MR_MIN_HPA]	  = __ATTR_RO(min_hpa),
+	[MR_MAX_HPA]	  = __ATTR_RO(max_hpa),
+	[MR_DPA]	  = __ATTR_RW(dpa),
+	[MR_MIN_DPA]	  = __ATTR_RO(min_dpa),
+	[MR_MAX_DPA]	  = __ATTR_RO(max_dpa),
+	[MR_NIBBLE_MASK]  = __ATTR_RW(nibble_mask),
+	[MR_BANK_GROUP]   = __ATTR_RW(bank_group),
+	[MR_BANK]	  = __ATTR_RW(bank),
+	[MR_RANK]	  = __ATTR_RW(rank),
+	[MR_ROW]	  = __ATTR_RW(row),
+	[MR_COLUMN]	  = __ATTR_RW(column),
+	[MR_CHANNEL]	  = __ATTR_RW(channel),
+	[MR_SUB_CHANNEL]  = __ATTR_RW(sub_channel),
+	[MEM_DO_REPAIR]	  = __ATTR_WO(repair)
+};
 
 static int mem_repair_create_desc(struct device *dev,
 				  const struct attribute_group **attr_groups,
@@ -305,34 +314,13 @@ static int mem_repair_create_desc(struct device *dev,
 	struct edac_mem_repair_context *ctx;
 	struct attribute_group *group;
 	int i;
-	struct edac_mem_repair_dev_attr dev_attr[] = {
-		[MR_TYPE]	  = MR_ATTR_RO(repair_type, instance),
-		[MR_PERSIST_MODE] = MR_ATTR_RW(persist_mode, instance),
-		[MR_SAFE_IN_USE]  = MR_ATTR_RO(repair_safe_when_in_use, instance),
-		[MR_HPA]	  = MR_ATTR_RW(hpa, instance),
-		[MR_MIN_HPA]	  = MR_ATTR_RO(min_hpa, instance),
-		[MR_MAX_HPA]	  = MR_ATTR_RO(max_hpa, instance),
-		[MR_DPA]	  = MR_ATTR_RW(dpa, instance),
-		[MR_MIN_DPA]	  = MR_ATTR_RO(min_dpa, instance),
-		[MR_MAX_DPA]	  = MR_ATTR_RO(max_dpa, instance),
-		[MR_NIBBLE_MASK]  = MR_ATTR_RW(nibble_mask, instance),
-		[MR_BANK_GROUP]   = MR_ATTR_RW(bank_group, instance),
-		[MR_BANK]	  = MR_ATTR_RW(bank, instance),
-		[MR_RANK]	  = MR_ATTR_RW(rank, instance),
-		[MR_ROW]	  = MR_ATTR_RW(row, instance),
-		[MR_COLUMN]	  = MR_ATTR_RW(column, instance),
-		[MR_CHANNEL]	  = MR_ATTR_RW(channel, instance),
-		[MR_SUB_CHANNEL]  = MR_ATTR_RW(sub_channel, instance),
-		[MEM_DO_REPAIR]	  = MR_ATTR_WO(repair, instance)
-	};
-
 	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
 
 	for (i = 0; i < MR_MAX_ATTRS; i++) {
-		memcpy(&ctx->mem_repair_dev_attr[i],
-		       &dev_attr[i], sizeof(dev_attr[i]));
+		ctx->mem_repair_dev_attr[i].dev_attr = mem_repair_dev_attr[i];
+		ctx->mem_repair_dev_attr[i].instance = instance;
 		ctx->mem_repair_attrs[i] =
 			&ctx->mem_repair_dev_attr[i].dev_attr.attr;
 	}
-- 
2.39.5


