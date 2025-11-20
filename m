Return-Path: <linux-edac+bounces-5482-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CC01EC71EA2
	for <lists+linux-edac@lfdr.de>; Thu, 20 Nov 2025 04:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 595D228DDA
	for <lists+linux-edac@lfdr.de>; Thu, 20 Nov 2025 03:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A057D2E7F03;
	Thu, 20 Nov 2025 03:02:46 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD893C2F;
	Thu, 20 Nov 2025 03:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763607766; cv=none; b=McEOIqhd0vKBZLIVl/8ee2eKKTAax/XYk3lkAj3E05oXlZa6F/e2K3COtsQcA8cYnI7pYzl0PoeVUgHVhA+AfvPQpxdpu/kMwH806LoLRYOMoA8GkPJxafPD9b5WgAYow0fNVj8dN/tFU9CIdftDbKwvHxJsiF+LZ7zOVKFGitI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763607766; c=relaxed/simple;
	bh=OW4IuPuyuTfakH500qtBxVu9OlO5dWxgX24drd/dTv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iszsa0wyIs+b7gzZccngcJ8NU6rr/U61a47R/YeenN4FggouokTUbXAeccRM9+4QMhJVVxJGsk3FEpBBIkaw0kvAwQWVmIbUJOj/uIqaJELI6EJcp+Koasyjv8SHOkIHaUYocSd1YSizQeYLtU8xG9LwJifAK6ZjVgJjYxukFC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [124.16.141.245])
	by APP-01 (Coremail) with SMTP id qwCowADnfs7OhB5p14xQAQ--.7180S2;
	Thu, 20 Nov 2025 11:02:40 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: tony.luck@intel.com,
	bp@alien8.de
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH] ras: cec: Fix debugfs error checking
Date: Thu, 20 Nov 2025 11:02:14 +0800
Message-ID: <20251120030214.492-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADnfs7OhB5p14xQAQ--.7180S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CrW3Gr47Xr4UKr47GF1ftFb_yoW8CryDpa
	n5CwnIyr48Aw15J39aya42vryfA34vqrW7ur95u3yfZw4Y9r1Yk3W8G3y8JrWI9FyrWw1F
	qr1UG348ZF129F7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUAVWUtwCY02Avz4vE14v_Gr4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvj
	DU0xZFpf9x0JUoKZXUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBg0MA2keXySWWAAAsG

The debugfs_create_dir() and debugfs_create_file() functions return
ERR_PTR() on error, not NULL. The current null-checks fail to detect
errors because ERR_PTR() encodes error codes as non-null pointer values.

Replace the null-checks with IS_ERR() for all debugfs_create_dir() and
debugfs_create_file() calls to properly handle errors.

Fixes: 011d82611172 ("RAS: Add a Corrected Errors Collector")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 drivers/ras/cec.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index e440b15fbabc..fda289ef0610 100644
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
2.50.1.windows.1


