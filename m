Return-Path: <linux-edac+bounces-2198-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C59449ABFE6
	for <lists+linux-edac@lfdr.de>; Wed, 23 Oct 2024 09:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70DAD1F22ECB
	for <lists+linux-edac@lfdr.de>; Wed, 23 Oct 2024 07:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EFD14D2AC;
	Wed, 23 Oct 2024 07:13:50 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91D6136345
	for <linux-edac@vger.kernel.org>; Wed, 23 Oct 2024 07:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729667630; cv=none; b=e1W4mpj5UcK3foW3091aslI0BDASn4leS8UqrF6xemIc8G2sZiBLT/zR4vDW6RFN6nunAMxOdEMD7kW/kUbtJRGIateqojRbTHX64XzzYdK4Fc4VXysKelKiDclE106oc5PmPOQCcc87RzCx7ssZV04ZeQACPrHVizDNlmTdW7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729667630; c=relaxed/simple;
	bh=HKgTA6akBaFm0/MGL+qV9mm1pBOJCq0QmOUKOeNkQMc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gy2xl8o7AD0iG7Km1fuHtaM1YpYZ7UhzDgy730SvZnXasUN8BzZx5MfiMA8UkughElI/VISCPVG0/jPSz/mLXuoYwUqw2hfGRteK0n3dsKIE3Th6KhSKTgJ3MQ3BE5L+msImO82Edg2LXA3j/fbwN/wddX7qBkCbaJsK0a41Y4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XYKw15R3DzfdHb
	for <linux-edac@vger.kernel.org>; Wed, 23 Oct 2024 15:11:13 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 0DD321400D8
	for <linux-edac@vger.kernel.org>; Wed, 23 Oct 2024 15:13:44 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 23 Oct 2024 15:13:43 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	<linux-edac@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] RAS: Fix return value check in create_debugfs_nodes()
Date: Wed, 23 Oct 2024 15:13:25 +0800
Message-ID: <20241023071325.292-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf100006.china.huawei.com (7.185.36.228)

Fix the incorrect return value check for debugfs_create_dir() and
debugfs_create_file(), which returns ERR_PTR(-ERROR) instead of NULL
when it fails.

Fixes: 011d82611172 ("RAS: Add a Corrected Errors Collector")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/ras/cec.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index e440b15fbabccbb..fda289ef06105ba 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -489,21 +489,21 @@ static int __init create_debugfs_nodes(void)
 	}
 
 	d = debugfs_create_dir("cec", dfs);
-	if (!d) {
+	if (IS_ERR(d)) {
 		pr_warn("Error creating cec debugfs node!\n");
 		return -1;
 	}
 
 	decay = debugfs_create_file("decay_interval", S_IRUSR | S_IWUSR, d,
 				    &decay_interval, &decay_interval_ops);
-	if (!decay) {
+	if (IS_ERR(decay)) {
 		pr_warn("Error creating decay_interval debugfs node!\n");
 		goto err;
 	}
 
 	count = debugfs_create_file("action_threshold", S_IRUSR | S_IWUSR, d,
 				    &action_threshold, &action_threshold_ops);
-	if (!count) {
+	if (IS_ERR(count)) {
 		pr_warn("Error creating action_threshold debugfs node!\n");
 		goto err;
 	}
@@ -512,13 +512,13 @@ static int __init create_debugfs_nodes(void)
 		return 0;
 
 	pfn = debugfs_create_file("pfn", S_IRUSR | S_IWUSR, d, &dfs_pfn, &pfn_ops);
-	if (!pfn) {
+	if (IS_ERR(pfn)) {
 		pr_warn("Error creating pfn debugfs node!\n");
 		goto err;
 	}
 
 	array = debugfs_create_file("array", S_IRUSR, d, NULL, &array_fops);
-	if (!array) {
+	if (IS_ERR(array)) {
 		pr_warn("Error creating array debugfs node!\n");
 		goto err;
 	}
-- 
2.34.1


