Return-Path: <linux-edac+bounces-1802-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3030496AD91
	for <lists+linux-edac@lfdr.de>; Wed,  4 Sep 2024 03:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC04C1F25AEA
	for <lists+linux-edac@lfdr.de>; Wed,  4 Sep 2024 01:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35A8173;
	Wed,  4 Sep 2024 01:03:38 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7C963D
	for <linux-edac@vger.kernel.org>; Wed,  4 Sep 2024 01:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725411818; cv=none; b=OUSkyA592DNE1ykn3EbwTKkx3Ebw9OM8pHBArfw/lsUxA7IOcI1p9uaEahx0HQf4kY52EiOAM4Z5JfNwXQhZ/grlqg7VgzLsHyJVU3FtVuc7po8Kt7P0OBSY3kI3lBqZiYKL8c7tcxq8rw+BXYxp5JSKTn8Ywn1IzKo7YouLjqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725411818; c=relaxed/simple;
	bh=1o3YnR2PbXy92G70R+2eaDUx/Rqcw1icaTtkoUiwrLI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q5FJfE7qCt1YMHy7T7aScqZ/8uqwfXXDUoS4HLiwI5ACOlS49VtwIEdfB/brTu6DxJF6MMYT/0f7NGJXexG3fl9Tb190xWriI5PssTtQLStFfsMeqtXGapz2ptnWfrSrOI67ipqy+AAfHKCKwtlbGZBZLV1kY51LVysHqOVt12I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wz42G1JRDzpVQF;
	Wed,  4 Sep 2024 09:01:42 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 388781800D2;
	Wed,  4 Sep 2024 09:03:34 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 4 Sep
 2024 09:03:33 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <james.morse@arm.com>,
	<mchehab@kernel.org>, <rric@kernel.org>
CC: <linux-edac@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH -next 1/2] EDAC: Constify struct kobj_type for edac_device_sysfs
Date: Wed, 4 Sep 2024 09:12:01 +0800
Message-ID: <20240904011202.2009727-2-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240904011202.2009727-1-lihongbo22@huawei.com>
References: <20240904011202.2009727-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500022.china.huawei.com (7.185.36.66)

These 'struct kobj_type' are not modified. They are only used in
kobject_init_and_add() which takes a 'const struct kobj_type *ktype'
parameter.

Constifying these structure and moving them to a read-only
section (from data --> text), and can increase over all security.

```
[Before]
   text   data    bss    dec    hex    filename
   3913    768      0   4681   1249    drivers/edac/edac_device_sysfs.o

[After]
   text   data    bss    dec    hex    filename
   4105    640      0   4745   1289    drivers/edac/edac_device_sysfs.o
```

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 drivers/edac/edac_device_sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/edac_device_sysfs.c b/drivers/edac/edac_device_sysfs.c
index fcebc4ffea26..9149e03f9d67 100644
--- a/drivers/edac/edac_device_sysfs.c
+++ b/drivers/edac/edac_device_sysfs.c
@@ -212,7 +212,7 @@ static void edac_device_ctrl_master_release(struct kobject *kobj)
 }
 
 /* ktype for the main (master) kobject */
-static struct kobj_type ktype_device_ctrl = {
+static const struct kobj_type ktype_device_ctrl = {
 	.release = edac_device_ctrl_master_release,
 	.sysfs_ops = &device_ctl_info_ops,
 	.default_groups = device_ctrl_groups,
@@ -397,7 +397,7 @@ static struct attribute *device_instance_attrs[] = {
 ATTRIBUTE_GROUPS(device_instance);
 
 /* The 'ktype' for each edac_dev 'instance' */
-static struct kobj_type ktype_instance_ctrl = {
+static const struct kobj_type ktype_instance_ctrl = {
 	.release = edac_device_ctrl_instance_release,
 	.sysfs_ops = &device_instance_ops,
 	.default_groups = device_instance_groups,
@@ -480,7 +480,7 @@ static struct attribute *device_block_attrs[] = {
 ATTRIBUTE_GROUPS(device_block);
 
 /* The 'ktype' for each edac_dev 'block' */
-static struct kobj_type ktype_block_ctrl = {
+static const struct kobj_type ktype_block_ctrl = {
 	.release = edac_device_ctrl_block_release,
 	.sysfs_ops = &device_block_ops,
 	.default_groups = device_block_groups,
-- 
2.34.1


