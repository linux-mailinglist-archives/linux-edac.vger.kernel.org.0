Return-Path: <linux-edac+bounces-4259-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3EBAE9AF5
	for <lists+linux-edac@lfdr.de>; Thu, 26 Jun 2025 12:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2618189F7EB
	for <lists+linux-edac@lfdr.de>; Thu, 26 Jun 2025 10:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA5521D3DB;
	Thu, 26 Jun 2025 10:14:06 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209D318035;
	Thu, 26 Jun 2025 10:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750932846; cv=none; b=j79GJ+nNTWxgDTVI39+xhvNu9VhoAxgE0EKrBNalFlmER19ZsF7k/LEIx8bor7iu7nuzBTcfmxlC+ovfRcm64whuPQz1hvCK6r6Qul6fh9lJGIAYi01GoGIJscnrisjifQGFCW5ybWBMoE9CKsf2jDDQFs08P8EyEt8twlYYpb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750932846; c=relaxed/simple;
	bh=rVERr3o2U/V7UYblWMD0/KIEIoPl380oaAmlEYQ6Sm4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qBTShkLSE55K5ZhlBusxC6AdlACvaX58zXdaIJB3PMi4cfC30nEAjnzcCjFfEwV1VYDDY+dAH0bOWhYFLe/hWYZ/uI+WX80xHiEKfy/QYa5Hi1oaK4DervvVeRxvYdDgNRjcRnylp9Q7DEzA1i+oOXgCDjFTysh8OcwlUDLVLUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bSZGM5F72z6K9QQ;
	Thu, 26 Jun 2025 18:11:23 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 063F7140447;
	Thu, 26 Jun 2025 18:13:59 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.171.218) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Jun 2025 12:13:58 +0200
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<lenb@kernel.org>, <leo.duran@amd.com>, <Yazen.Ghannam@amd.com>,
	<mchehab@kernel.org>, <dave.jiang@intel.com>, <jonathan.cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH v2 1/1] EDAC: Fix lockdep splat caused by edac features code
Date: Thu, 26 Jun 2025 11:13:44 +0100
Message-ID: <20250626101344.1726-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
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

Fix the lockdep splat caused by missing sysfs_attr_init() calls
for the recently added EDAC feature's sysfs attributes.

In lockdep_init_map_type(), the check for the lock-class key
if (!static_obj(key) && !is_dynamic_key(key)) causes the splat.

Backtrace:
RIP: 0010:lockdep_init_map_type+0x131/0x270
Call Trace:
 __kernfs_create_file+0x77/0xf0
sysfs_add_file_mode_ns+0x86/0x140
internal_create_group+0x1cc/0x4b0
internal_create_groups+0x42/0xa0
device_add+0x310/0x860
? __init_waitqueue_head+0x4a/0x60
edac_dev_register+0x3ff/0x480
devm_cxl_memdev_edac_register+0x509/0x640 [cxl_core]
? lock_acquire+0xc4/0x2d0
? find_held_lock+0x2b/0x80
? cxl_mem_probe+0x21e/0x360 [cxl_mem]
? cxl_mem_probe+0x21e/0x360 [cxl_mem]
? lockdep_hardirqs_on+0x78/0x100
? cxl_mem_probe+0x226/0x360 [cxl_mem]
cxl_mem_probe+0x226/0x360 [cxl_mem]

Fixes: f90b738166fe ("EDAC: Add scrub control feature")
Fixes: bcbd069b11b0 ("EDAC: Add a Error Check Scrub control feature")
Fixes: 699ea5219c4b ("EDAC: Add a memory repair control feature")
Reported-by: Dave Jiang <dave.jiang@intel.com>
Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
Changes:
v1 -> v2
1. Changes for the feedback from Jonathan.
   https://lore.kernel.org/linux-edac/aa142386d0944955b742340b2454e114@huawei.com/T/#md430a9f146794152ac45de57d0cda65caa7f765b
  - Updated commit message.
  - Called sysfs_attr_init() before put the pointer in the array
    of attribute pointers.
---
 drivers/edac/ecs.c        | 4 +++-
 drivers/edac/mem_repair.c | 1 +
 drivers/edac/scrub.c      | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/ecs.c b/drivers/edac/ecs.c
index 1d51838a60c1..51c451c7f0f0 100755
--- a/drivers/edac/ecs.c
+++ b/drivers/edac/ecs.c
@@ -170,8 +170,10 @@ static int ecs_create_desc(struct device *ecs_dev, const struct attribute_group
 		fru_ctx->dev_attr[ECS_RESET]		= EDAC_ECS_ATTR_WO(reset, fru);
 		fru_ctx->dev_attr[ECS_THRESHOLD]	= EDAC_ECS_ATTR_RW(threshold, fru);
 
-		for (i = 0; i < ECS_MAX_ATTRS; i++)
+		for (i = 0; i < ECS_MAX_ATTRS; i++) {
+			sysfs_attr_init(&fru_ctx->dev_attr[i].dev_attr.attr);
 			fru_ctx->ecs_attrs[i] = &fru_ctx->dev_attr[i].dev_attr.attr;
+		}
 
 		sprintf(fru_ctx->name, "%s%d", EDAC_ECS_FRU_NAME, fru);
 		group->name = fru_ctx->name;
diff --git a/drivers/edac/mem_repair.c b/drivers/edac/mem_repair.c
index d1a8caa85369..70a033a76233 100755
--- a/drivers/edac/mem_repair.c
+++ b/drivers/edac/mem_repair.c
@@ -333,6 +333,7 @@ static int mem_repair_create_desc(struct device *dev,
 	for (i = 0; i < MR_MAX_ATTRS; i++) {
 		memcpy(&ctx->mem_repair_dev_attr[i],
 		       &dev_attr[i], sizeof(dev_attr[i]));
+		sysfs_attr_init(&ctx->mem_repair_dev_attr[i].dev_attr.attr);
 		ctx->mem_repair_attrs[i] =
 			&ctx->mem_repair_dev_attr[i].dev_attr.attr;
 	}
diff --git a/drivers/edac/scrub.c b/drivers/edac/scrub.c
index e421d3ebd959..f9d02af2fc3a 100755
--- a/drivers/edac/scrub.c
+++ b/drivers/edac/scrub.c
@@ -176,6 +176,7 @@ static int scrub_create_desc(struct device *scrub_dev,
 	group = &scrub_ctx->group;
 	for (i = 0; i < SCRUB_MAX_ATTRS; i++) {
 		memcpy(&scrub_ctx->scrub_dev_attr[i], &dev_attr[i], sizeof(dev_attr[i]));
+		sysfs_attr_init(&scrub_ctx->scrub_dev_attr[i].dev_attr.attr);
 		scrub_ctx->scrub_attrs[i] = &scrub_ctx->scrub_dev_attr[i].dev_attr.attr;
 	}
 	sprintf(scrub_ctx->name, "%s%d", "scrub", instance);
-- 
2.43.0


