Return-Path: <linux-edac+bounces-5485-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8B2C72BF0
	for <lists+linux-edac@lfdr.de>; Thu, 20 Nov 2025 09:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5046534C062
	for <lists+linux-edac@lfdr.de>; Thu, 20 Nov 2025 08:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B15372AD9;
	Thu, 20 Nov 2025 08:15:42 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57877372ACC;
	Thu, 20 Nov 2025 08:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763626542; cv=none; b=ngFhCU4OeAFlLRFGCRxTt0iJ9KMPZ53tP4RlHCLhPUxMsd9zeKzkzbotYb6UjaF7WB0N43lhtD+A6JjTQhI8mFrjdwqtKI7u4aSnze89pHO0hqLOf+WH4MQgmpI09meP8lvsdepigmntZE/vrI8oIiUAlBd2I3Ykw1PZ/T/ehME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763626542; c=relaxed/simple;
	bh=0ODzMaRDuE25qB5HTVUJRDvylz28Sx0logk6L6svKbw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xe8qE2m3H4wArMqbLHI7bII0jOn/8bHlnYIPStug8NFG+rh+yRGhKMXhiS/oSvB5xh6vAYt9uo+skoobikZvGwF/euaWFmiK+3E1bIiL0kPU5oDVUkVqCniZ9hKwdam3UuNXNPRsDw/ip32VIO85MbRGC3Tc0UK5zhqeMpnJ9r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [124.16.141.245])
	by APP-03 (Coremail) with SMTP id rQCowAAnstRxzB5px5teAQ--.55437S2;
	Thu, 20 Nov 2025 16:08:19 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: tony.luck@intel.com,
	bp@alien8.de,
	qiuxu.zhuo@intel.com
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH v2] ras: cec: Fix debugfs error checking
Date: Thu, 20 Nov 2025 16:07:08 +0800
Message-ID: <20251120080708.427-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAnstRxzB5px5teAQ--.55437S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw47Kw43GrWrGw17WF4DArb_yoW5Xr4xpa
	95Crn0yr18Aw15G393Aa4jvryfJ3saqrW7ur95u395Zr45Cr1Yyw1Sk3y8Jryv9FyrWw1j
	qr15G348ZF129F7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUcBMtUUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgoMA2kemySdkgABsF

The debugfs_create_dir() and debugfs_create_file() functions return
ERR_PTR() on error, not NULL. The current null-checks fail to detect
errors because ERR_PTR() encodes error codes as non-null pointer values.

Replace the null-checks with IS_ERR() for all debugfs_create_dir() and
debugfs_create_file() and ras_get_debugfs_root calls to properly
handle errors.

Fixes: 011d82611172 ("RAS: Add a Corrected Errors Collector")
Suggested-by: Zhuo, Qiuxu <qiuxu.zhuo@intel.com>
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
Changes in v2:
  -Add fixes in create_debugfs_nodes() and ras_add_daemon_trace()
   as suggested by Zhuo, Qiuxu.
---
 drivers/ras/cec.c     | 12 ++++++------
 drivers/ras/debugfs.c |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index e440b15fbabc..25aa5f2a18b2 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -483,27 +483,27 @@ static int __init create_debugfs_nodes(void)
 	struct dentry *d, *pfn, *decay, *count, *array, *dfs;
 
 	dfs = ras_get_debugfs_root();
-	if (!dfs) {
+	if (IS_ERR(dfs)) {
 		pr_warn("Error getting RAS debugfs root!\n");
 		return -1;
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
diff --git a/drivers/ras/debugfs.c b/drivers/ras/debugfs.c
index 42afd3de68b2..8f817bd9cb09 100644
--- a/drivers/ras/debugfs.c
+++ b/drivers/ras/debugfs.c
@@ -47,7 +47,7 @@ int __init ras_add_daemon_trace(void)
 {
 	struct dentry *fentry;
 
-	if (!ras_debugfs_dir)
+	if (IS_ERR(ras_debugfs_dir))
 		return -ENOENT;
 
 	fentry = debugfs_create_file("daemon_active", S_IRUSR, ras_debugfs_dir,
-- 
2.50.1.windows.1


