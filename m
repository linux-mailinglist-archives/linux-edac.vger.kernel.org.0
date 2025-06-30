Return-Path: <linux-edac+bounces-4290-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0115AEE478
	for <lists+linux-edac@lfdr.de>; Mon, 30 Jun 2025 18:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD8181896D91
	for <lists+linux-edac@lfdr.de>; Mon, 30 Jun 2025 16:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0612BD593;
	Mon, 30 Jun 2025 16:20:54 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2AC28F925
	for <linux-edac@vger.kernel.org>; Mon, 30 Jun 2025 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751300454; cv=none; b=g3IPXOCY3BMjmKj3BgPQY6V9kgiYqkIUnd3Dv2NbPR7g4ILKMfEyLkB+VNwpbh+LpZeieiGdcEcM+6cCi44AhhJ+mobnCfhk9ZVtDEmrVlxKaVgVe87f8yAiq5jjoZwda1F7wGW4iWAvsFTA0qCIh8xs1k9AU3OD5MkZ0K6eHY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751300454; c=relaxed/simple;
	bh=AQ893Hsc6SiRQY32yksm3f+4s/WL1uqG068nPw3/sZk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HE12RYnMh8nxG/5gHt/pU8VhzMhVCaubviabQPwP5tZSIw3TVDIG7iG0Sv0Nh0teNWtCYcVECcyen5G2MaC4kyscKlmTat8ChkIvL5MqHGjI/VYdvicwf8wfZkcfpSV1VDePF39aeORplYWfx81SyC1SwcqdyTjV6T+M/y/I8Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bWBGQ2lHqz6L4tJ;
	Tue,  1 Jul 2025 00:20:30 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 564B11402F3;
	Tue,  1 Jul 2025 00:20:50 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.170.174) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Jun 2025 18:20:49 +0200
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<arnd@kernel.org>, <mchehab@kernel.org>, <rric@kernel.org>,
	<dave.jiang@intel.com>, <jonathan.cameron@huawei.com>
CC: <linuxarm@huawei.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH 2/2] EDAC/ecs: Reduce stack usage in ecs_create_desc()
Date: Mon, 30 Jun 2025 17:20:34 +0100
Message-ID: <20250630162034.1788-3-shiju.jose@huawei.com>
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

Reduce per-function stack usage by changing to an actual attribute array
allocated statically. Then, add the FRU ID number to the per-FRU copy.

In addition, rename the field 'dev_attr' in struct edac_ecs_fru_context to
'ecs_dev_attr' for better readability.

Fixes: bcbd069b11b0 ("EDAC: Add a Error Check Scrub control feature")
Suggested-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/edac/ecs.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/edac/ecs.c b/drivers/edac/ecs.c
index 51c451c7f0f0..368e01db63d3 100755
--- a/drivers/edac/ecs.c
+++ b/drivers/edac/ecs.c
@@ -26,7 +26,7 @@ struct edac_ecs_dev_attr {
 
 struct edac_ecs_fru_context {
 	char name[EDAC_FEAT_NAME_LEN];
-	struct edac_ecs_dev_attr dev_attr[ECS_MAX_ATTRS];
+	struct edac_ecs_dev_attr ecs_dev_attr[ECS_MAX_ATTRS];
 	struct attribute *ecs_attrs[ECS_MAX_ATTRS + 1];
 	struct attribute_group group;
 };
@@ -131,17 +131,12 @@ static umode_t ecs_attr_visible(struct kobject *kobj, struct attribute *a, int a
 	return 0;
 }
 
-#define EDAC_ECS_ATTR_RO(_name, _fru_id)       \
-	((struct edac_ecs_dev_attr) { .dev_attr = __ATTR_RO(_name), \
-				     .fru_id = _fru_id })
-
-#define EDAC_ECS_ATTR_WO(_name, _fru_id)       \
-	((struct edac_ecs_dev_attr) { .dev_attr = __ATTR_WO(_name), \
-				     .fru_id = _fru_id })
-
-#define EDAC_ECS_ATTR_RW(_name, _fru_id)       \
-	((struct edac_ecs_dev_attr) { .dev_attr = __ATTR_RW(_name), \
-				     .fru_id = _fru_id })
+static const struct device_attribute ecs_dev_attr[] = {
+	[ECS_LOG_ENTRY_TYPE]	= __ATTR_RW(log_entry_type),
+	[ECS_MODE]		= __ATTR_RW(mode),
+	[ECS_RESET]		= __ATTR_WO(reset),
+	[ECS_THRESHOLD]		= __ATTR_RW(threshold)
+};
 
 static int ecs_create_desc(struct device *ecs_dev, const struct attribute_group **attr_groups,
 			   u16 num_media_frus)
@@ -165,14 +160,12 @@ static int ecs_create_desc(struct device *ecs_dev, const struct attribute_group
 		struct attribute_group *group = &fru_ctx->group;
 		int i;
 
-		fru_ctx->dev_attr[ECS_LOG_ENTRY_TYPE]	= EDAC_ECS_ATTR_RW(log_entry_type, fru);
-		fru_ctx->dev_attr[ECS_MODE]		= EDAC_ECS_ATTR_RW(mode, fru);
-		fru_ctx->dev_attr[ECS_RESET]		= EDAC_ECS_ATTR_WO(reset, fru);
-		fru_ctx->dev_attr[ECS_THRESHOLD]	= EDAC_ECS_ATTR_RW(threshold, fru);
-
 		for (i = 0; i < ECS_MAX_ATTRS; i++) {
+			fru_ctx->ecs_dev_attr[i].dev_attr = ecs_dev_attr[i];
+			fru_ctx->ecs_dev_attr[i].fru_id = fru;
+
 			sysfs_attr_init(&fru_ctx->dev_attr[i].dev_attr.attr);
-			fru_ctx->ecs_attrs[i] = &fru_ctx->dev_attr[i].dev_attr.attr;
+			fru_ctx->ecs_attrs[i] = &fru_ctx->ecs_dev_attr[i].dev_attr.attr;
 		}
 
 		sprintf(fru_ctx->name, "%s%d", EDAC_ECS_FRU_NAME, fru);
-- 
2.43.0


