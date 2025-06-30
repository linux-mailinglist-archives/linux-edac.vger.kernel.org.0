Return-Path: <linux-edac+bounces-4284-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AACAEDCC3
	for <lists+linux-edac@lfdr.de>; Mon, 30 Jun 2025 14:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8F7C18892DB
	for <lists+linux-edac@lfdr.de>; Mon, 30 Jun 2025 12:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5C427FB0D;
	Mon, 30 Jun 2025 12:29:30 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0C525BEE8;
	Mon, 30 Jun 2025 12:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751286570; cv=none; b=qAnJ+V0mf4Ew3jVY54uPxHCMP1ZNAU7Z+cbUFlcrFePIDcWhH02Z6HBv5NknD6X9wo2BwqH/fTkrOUwAT09ZCMdx4SvfvVkSNljhSRLKGWKbGGsRn8zxJI4W62Nygro3KInjWCas/IYwxtnylg5SbyRCFgla362kxwqh5Bez/+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751286570; c=relaxed/simple;
	bh=/i9egio95Bx06U/iIP9MFYqlD2hAJ6hhxZw8tSnbl5c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Iu3J3AGE6n+0p9HT6BvzxWZj7DtuTDlc0qb/9csZdtU+N2Q5POkFrqS+N87s54Cl7GLurXkl2dR+RcbgxTji+eY8mTF0tMmBRgzEC6wLL7+ideSi2XDP5v1p5s2EZBIWJynhySTupExgIVjc7q4YedQRzrVSKwzMhjzdIM+JN20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bW54Y0qHKz6L5PT;
	Mon, 30 Jun 2025 20:26:37 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 95FD51402EC;
	Mon, 30 Jun 2025 20:29:24 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Jun 2025 14:29:24 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 30 Jun 2025 14:29:24 +0200
From: Shiju Jose <shiju.jose@huawei.com>
To: Arnd Bergmann <arnd@kernel.org>, Borislav Petkov <bp@alien8.de>, Tony Luck
	<tony.luck@intel.com>
CC: Arnd Bergmann <arnd@arndb.de>, James Morse <james.morse@arm.com>, "Mauro
 Carvalho Chehab" <mchehab@kernel.org>, Robert Richter <rric@kernel.org>,
	"Dave Jiang" <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] EDAC: mem_repair: reduce stack usage in
 edac_mem_repair_get_desc()
Thread-Topic: [PATCH] EDAC: mem_repair: reduce stack usage in
 edac_mem_repair_get_desc()
Thread-Index: AQHb4dhPRsv0qIv9s0aOmor2xoQzHbQbsD0Q
Date: Mon, 30 Jun 2025 12:29:24 +0000
Message-ID: <ff6cdc5223664c53a269a5c259c156bd@huawei.com>
References: <20250620114135.4017183-1-arnd@kernel.org>
In-Reply-To: <20250620114135.4017183-1-arnd@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

>-----Original Message-----
>From: Arnd Bergmann <arnd@kernel.org>
>Sent: 20 June 2025 12:41
>To: Borislav Petkov <bp@alien8.de>; Tony Luck <tony.luck@intel.com>; Shiju
>Jose <shiju.jose@huawei.com>
>Cc: Arnd Bergmann <arnd@arndb.de>; James Morse <james.morse@arm.com>;
>Mauro Carvalho Chehab <mchehab@kernel.org>; Robert Richter
><rric@kernel.org>; Dave Jiang <dave.jiang@intel.com>; Alison Schofield
><alison.schofield@intel.com>; linux-edac@vger.kernel.org; linux-
>kernel@vger.kernel.org
>Subject: [PATCH] EDAC: mem_repair: reduce stack usage in
>edac_mem_repair_get_desc()
>
>From: Arnd Bergmann <arnd@arndb.de>
>
>Constructing an array on the stack adds complexity and can exceed the warn=
ing
>limit for per-function stack usage:
>
>drivers/edac/mem_repair.c:361:5: error: stack frame size (1296) exceeds li=
mit
>(1280) in 'edac_mem_repair_get_desc' [-Werror,-Wframe-larger-than]
>
>Change this to have the actual attribute array allocated statically and th=
en just
>add the instance number on the per-instance copy.
>
>Fixes: 699ea5219c4b ("EDAC: Add a memory repair control feature")
>Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Sorry, I missed this patch.
Tested-by: Shiju Jose <shiju.jose@huawei.com>
Reviewed-by: Shiju Jose <shiju.jose@huawei.com>
>---
> drivers/edac/mem_repair.c | 56 +++++++++++++++------------------------
> 1 file changed, 22 insertions(+), 34 deletions(-)
>
>diff --git a/drivers/edac/mem_repair.c b/drivers/edac/mem_repair.c index
>d1a8caa85369..2e4e790e0ffe 100755
>--- a/drivers/edac/mem_repair.c
>+++ b/drivers/edac/mem_repair.c
>@@ -286,17 +286,26 @@ static umode_t mem_repair_attr_visible(struct
>kobject *kobj, struct attribute *a
> 	return 0;
> }
>
>-#define MR_ATTR_RO(_name, _instance)       \
>-	((struct edac_mem_repair_dev_attr) { .dev_attr =3D __ATTR_RO(_name),
>\
>-					     .instance =3D _instance })
>-
>-#define MR_ATTR_WO(_name, _instance)       \
>-	((struct edac_mem_repair_dev_attr) { .dev_attr =3D __ATTR_WO(_name),
>\
>-					     .instance =3D _instance })
>-
>-#define MR_ATTR_RW(_name, _instance)       \
>-	((struct edac_mem_repair_dev_attr) { .dev_attr =3D __ATTR_RW(_name),
>\
>-					     .instance =3D _instance })
>+static const struct device_attribute mem_repair_dev_attr[] =3D {
>+	[MR_TYPE]	  =3D __ATTR_RO(repair_type),
>+	[MR_PERSIST_MODE] =3D __ATTR_RW(persist_mode),
>+	[MR_SAFE_IN_USE]  =3D __ATTR_RO(repair_safe_when_in_use),
>+	[MR_HPA]	  =3D __ATTR_RW(hpa),
>+	[MR_MIN_HPA]	  =3D __ATTR_RO(min_hpa),
>+	[MR_MAX_HPA]	  =3D __ATTR_RO(max_hpa),
>+	[MR_DPA]	  =3D __ATTR_RW(dpa),
>+	[MR_MIN_DPA]	  =3D __ATTR_RO(min_dpa),
>+	[MR_MAX_DPA]	  =3D __ATTR_RO(max_dpa),
>+	[MR_NIBBLE_MASK]  =3D __ATTR_RW(nibble_mask),
>+	[MR_BANK_GROUP]   =3D __ATTR_RW(bank_group),
>+	[MR_BANK]	  =3D __ATTR_RW(bank),
>+	[MR_RANK]	  =3D __ATTR_RW(rank),
>+	[MR_ROW]	  =3D __ATTR_RW(row),
>+	[MR_COLUMN]	  =3D __ATTR_RW(column),
>+	[MR_CHANNEL]	  =3D __ATTR_RW(channel),
>+	[MR_SUB_CHANNEL]  =3D __ATTR_RW(sub_channel),
>+	[MEM_DO_REPAIR]	  =3D __ATTR_WO(repair)
>+};
>
> static int mem_repair_create_desc(struct device *dev,
> 				  const struct attribute_group **attr_groups,
>@@ -305,34 +314,13 @@ static int mem_repair_create_desc(struct device
>*dev,
> 	struct edac_mem_repair_context *ctx;
> 	struct attribute_group *group;
> 	int i;
>-	struct edac_mem_repair_dev_attr dev_attr[] =3D {
>-		[MR_TYPE]	  =3D MR_ATTR_RO(repair_type, instance),
>-		[MR_PERSIST_MODE] =3D MR_ATTR_RW(persist_mode, instance),
>-		[MR_SAFE_IN_USE]  =3D MR_ATTR_RO(repair_safe_when_in_use,
>instance),
>-		[MR_HPA]	  =3D MR_ATTR_RW(hpa, instance),
>-		[MR_MIN_HPA]	  =3D MR_ATTR_RO(min_hpa, instance),
>-		[MR_MAX_HPA]	  =3D MR_ATTR_RO(max_hpa, instance),
>-		[MR_DPA]	  =3D MR_ATTR_RW(dpa, instance),
>-		[MR_MIN_DPA]	  =3D MR_ATTR_RO(min_dpa, instance),
>-		[MR_MAX_DPA]	  =3D MR_ATTR_RO(max_dpa, instance),
>-		[MR_NIBBLE_MASK]  =3D MR_ATTR_RW(nibble_mask, instance),
>-		[MR_BANK_GROUP]   =3D MR_ATTR_RW(bank_group, instance),
>-		[MR_BANK]	  =3D MR_ATTR_RW(bank, instance),
>-		[MR_RANK]	  =3D MR_ATTR_RW(rank, instance),
>-		[MR_ROW]	  =3D MR_ATTR_RW(row, instance),
>-		[MR_COLUMN]	  =3D MR_ATTR_RW(column, instance),
>-		[MR_CHANNEL]	  =3D MR_ATTR_RW(channel, instance),
>-		[MR_SUB_CHANNEL]  =3D MR_ATTR_RW(sub_channel, instance),
>-		[MEM_DO_REPAIR]	  =3D MR_ATTR_WO(repair, instance)
>-	};
>-
> 	ctx =3D devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> 	if (!ctx)
> 		return -ENOMEM;
>
> 	for (i =3D 0; i < MR_MAX_ATTRS; i++) {
>-		memcpy(&ctx->mem_repair_dev_attr[i],
>-		       &dev_attr[i], sizeof(dev_attr[i]));
>+		ctx->mem_repair_dev_attr[i].dev_attr =3D
>mem_repair_dev_attr[i];
>+		ctx->mem_repair_dev_attr[i].instance =3D instance;
> 		ctx->mem_repair_attrs[i] =3D
> 			&ctx->mem_repair_dev_attr[i].dev_attr.attr;
> 	}
>--
>2.39.5
>


