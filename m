Return-Path: <linux-edac+bounces-5493-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3ACC77042
	for <lists+linux-edac@lfdr.de>; Fri, 21 Nov 2025 03:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 61A5E4E03E0
	for <lists+linux-edac@lfdr.de>; Fri, 21 Nov 2025 02:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B6721D58B;
	Fri, 21 Nov 2025 02:32:40 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482881A38F9;
	Fri, 21 Nov 2025 02:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763692360; cv=none; b=rVHMgmUuI8ce722V+tCsAW3nu8y/bMGdiWw4eu38XVDww5P5daTRgjKuFcVyEn9X2/QwdyB8Q+OjEq+T7Fw6A0c7zkY17J8Ly07qDD4/UNMZPouQgXeEd3WuOGFpE8ee2CgmgeVQj/aZv90cVTkDQPu+0sKQvihhmmZD0H+lmVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763692360; c=relaxed/simple;
	bh=q2ZHh08a4BnvOmH6U2oeryxQJeOz5r6c6VkIAvHBr3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dxf1Xy7sf5KtPriO9VflYHKl4kfgdOKtupe8xeOH4i3shadkHRA76rY7i2qv9W30Vf9HdqqtEDl2XqKIaBD7ZUeo2Xlhll7IotHWpgwPcuemOFMq3hwEaBqIA/gVINNFKo6eyINEAlsfVuH27cP3xweyhhwI2e6+nejd+YnEjSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [124.16.141.245])
	by APP-03 (Coremail) with SMTP id rQCowAC3QdQ6zx9pbAB9AQ--.42901S2;
	Fri, 21 Nov 2025 10:32:29 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: tony.luck@intel.com,
	bp@alien8.de,
	qiuxu.zhuo@intel.com
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH v3] ras: cec: Fix debugfs error checking
Date: Fri, 21 Nov 2025 10:31:14 +0800
Message-ID: <20251121023114.1282-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAC3QdQ6zx9pbAB9AQ--.42901S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr17Zry3ArWUXrWxXw45GFg_yoW5tr1xpa
	93GrnxAr48Zwn8GFZakF17ZryfA3sagry7WryUu395Ar4UCr1Fv3Wak3y8tryv9F98W34Y
	qF15J348A3W2kF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUSNtxUUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgoNA2kftVZzWAAAs8

The debugfs_create_dir() and debugfs_create_file() functions return
ERR_PTR() on error, not NULL. The current null-checks fail to detect
errors because ERR_PTR() encodes error codes as non-null pointer values.

Remove all null-checks for all debugfs_create_dir() and
debugfs_create_file() since they are unnecessary.

Fixes: 011d82611172 ("RAS: Add a Corrected Errors Collector")
Suggested-by: Zhuo, Qiuxu <qiuxu.zhuo@intel.com>
Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
Changes in v3:
  -Remove all error handling as suggested by Borislav Petkov.
---
Changes in v2:
  -Also add fixes in create_debugfs_nodes() and ras_add_daemon_trace()
   as suggested by Zhuo, Qiuxu.
---
 drivers/ras/cec.c     | 42 +++++-------------------------------------
 drivers/ras/debugfs.c | 11 +----------
 2 files changed, 6 insertions(+), 47 deletions(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index e440b15fbabc..5891f30641b7 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -480,55 +480,23 @@ DEFINE_SHOW_ATTRIBUTE(array);
 
 static int __init create_debugfs_nodes(void)
 {
-	struct dentry *d, *pfn, *decay, *count, *array, *dfs;
+	struct dentry *d, *dfs;
 
 	dfs = ras_get_debugfs_root();
-	if (!dfs) {
-		pr_warn("Error getting RAS debugfs root!\n");
-		return -1;
-	}
-
 	d = debugfs_create_dir("cec", dfs);
-	if (!d) {
-		pr_warn("Error creating cec debugfs node!\n");
-		return -1;
-	}
 
-	decay = debugfs_create_file("decay_interval", S_IRUSR | S_IWUSR, d,
+	debugfs_create_file("decay_interval", S_IRUSR | S_IWUSR, d,
 				    &decay_interval, &decay_interval_ops);
-	if (!decay) {
-		pr_warn("Error creating decay_interval debugfs node!\n");
-		goto err;
-	}
-
-	count = debugfs_create_file("action_threshold", S_IRUSR | S_IWUSR, d,
+	debugfs_create_file("action_threshold", S_IRUSR | S_IWUSR, d,
 				    &action_threshold, &action_threshold_ops);
-	if (!count) {
-		pr_warn("Error creating action_threshold debugfs node!\n");
-		goto err;
-	}
 
 	if (!IS_ENABLED(CONFIG_RAS_CEC_DEBUG))
 		return 0;
 
-	pfn = debugfs_create_file("pfn", S_IRUSR | S_IWUSR, d, &dfs_pfn, &pfn_ops);
-	if (!pfn) {
-		pr_warn("Error creating pfn debugfs node!\n");
-		goto err;
-	}
-
-	array = debugfs_create_file("array", S_IRUSR, d, NULL, &array_fops);
-	if (!array) {
-		pr_warn("Error creating array debugfs node!\n");
-		goto err;
-	}
+	debugfs_create_file("pfn", S_IRUSR | S_IWUSR, d, &dfs_pfn, &pfn_ops);
+	debugfs_create_file("array", S_IRUSR, d, NULL, &array_fops);
 
 	return 0;
-
-err:
-	debugfs_remove_recursive(d);
-
-	return 1;
 }
 
 static int cec_notifier(struct notifier_block *nb, unsigned long val,
diff --git a/drivers/ras/debugfs.c b/drivers/ras/debugfs.c
index 42afd3de68b2..a1149e48b34a 100644
--- a/drivers/ras/debugfs.c
+++ b/drivers/ras/debugfs.c
@@ -45,18 +45,9 @@ static const struct file_operations trace_fops = {
 
 int __init ras_add_daemon_trace(void)
 {
-	struct dentry *fentry;
-
-	if (!ras_debugfs_dir)
-		return -ENOENT;
-
-	fentry = debugfs_create_file("daemon_active", S_IRUSR, ras_debugfs_dir,
+	debugfs_create_file("daemon_active", S_IRUSR, ras_debugfs_dir,
 				     NULL, &trace_fops);
-	if (IS_ERR(fentry))
-		return -ENODEV;
-
 	return 0;
-
 }
 
 void __init ras_debugfs_init(void)
-- 
2.50.1.windows.1


