Return-Path: <linux-edac+bounces-1803-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B229996AD92
	for <lists+linux-edac@lfdr.de>; Wed,  4 Sep 2024 03:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A6581F25C6F
	for <lists+linux-edac@lfdr.de>; Wed,  4 Sep 2024 01:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D7F63D;
	Wed,  4 Sep 2024 01:03:39 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D431FC8
	for <linux-edac@vger.kernel.org>; Wed,  4 Sep 2024 01:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725411819; cv=none; b=Hxf3+rKO3JpciDOzX8BmpDmWsPPUtd1ly/vOWRLQQ6pPu5fZU7l1qKvSQdnDmAlpPFghKVqeZ4U9CnUXGICGKeL5+gCmX06qAJfFVIHRe9y6vCJpMhR/IXzNBkf0N5exUJonk3CvFNt8b4KcMM/GUXztoR1I4YgeUsMwcS8mI88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725411819; c=relaxed/simple;
	bh=v7a7wlABZIHS12PkM0wQsHF6Nq+5LLNowLqjAWdk6mo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G5EufoTiDyewx1XS7slSspQqY75vMCn9Lhwgf9clML+H6c8n58PTjZq9/m1HJ4QuASFFBYboNWbgBUcub90w3aTAZX94oISffwCMLpWe8GuSlkrYlLCV3FuJT2r8KsXRwzKpP9EQ6EnJ7m40Qmg0Y8xyTWzmQzt3OkApb6G0rnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wz3yj4qlPz20nKk;
	Wed,  4 Sep 2024 08:58:37 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 5108A140158;
	Wed,  4 Sep 2024 09:03:34 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 4 Sep
 2024 09:03:34 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <james.morse@arm.com>,
	<mchehab@kernel.org>, <rric@kernel.org>
CC: <linux-edac@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH -next 2/2] EDAC: Constify struct kobj_type for edac_pci_sysfs
Date: Wed, 4 Sep 2024 09:12:02 +0800
Message-ID: <20240904011202.2009727-3-lihongbo22@huawei.com>
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

Constifying these structure (ktype_pci_instance and
ktype_edac_pci_main_kobj)and moving them to a read-only (text
section) section, and can increase over all security.

```
[Before]
   text   data    bss    dec    hex    filename
   4357    856     32   5245   147d    drivers/edac/edac_pci_sysfs.o

[After]
   text   data    bss    dec    hex    filename
   4485    760     32   5277   149d    drivers/edac/edac_pci_sysfs.o
```

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 drivers/edac/edac_pci_sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/edac_pci_sysfs.c b/drivers/edac/edac_pci_sysfs.c
index 7b44afcf48db..f00efb06b3dc 100644
--- a/drivers/edac/edac_pci_sysfs.c
+++ b/drivers/edac/edac_pci_sysfs.c
@@ -143,7 +143,7 @@ static struct attribute *pci_instance_attrs[] = {
 ATTRIBUTE_GROUPS(pci_instance);
 
 /* the ktype for a pci instance */
-static struct kobj_type ktype_pci_instance = {
+static const struct kobj_type ktype_pci_instance = {
 	.release = edac_pci_instance_release,
 	.sysfs_ops = &pci_instance_ops,
 	.default_groups = pci_instance_groups,
@@ -326,7 +326,7 @@ static void edac_pci_release_main_kobj(struct kobject *kobj)
 }
 
 /* ktype struct for the EDAC PCI main kobj */
-static struct kobj_type ktype_edac_pci_main_kobj = {
+static const struct kobj_type ktype_edac_pci_main_kobj = {
 	.release = edac_pci_release_main_kobj,
 	.sysfs_ops = &edac_pci_sysfs_ops,
 	.default_groups = edac_pci_groups,
-- 
2.34.1


