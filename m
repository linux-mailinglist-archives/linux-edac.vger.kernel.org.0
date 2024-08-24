Return-Path: <linux-edac+bounces-1730-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4B495DD87
	for <lists+linux-edac@lfdr.de>; Sat, 24 Aug 2024 13:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 076AE2833C8
	for <lists+linux-edac@lfdr.de>; Sat, 24 Aug 2024 11:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF12E15D5D9;
	Sat, 24 Aug 2024 11:27:15 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3CB15688E;
	Sat, 24 Aug 2024 11:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724498835; cv=none; b=WNpWCY7O+FnrePNpAQrihrmFNi7xxaZXRuDrX3EyyB0oTWPjKJOfnFXtSr5CZciilapNsanZXyhowqj9g6rGB0SLEHfqHYoFuZ9jMPqQc5fVdui7vJ/3GjPGsgsxon+YFpPiHvm/13JYw6bVoNhhCWPrO93rcrqiu4BEmaQVa1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724498835; c=relaxed/simple;
	bh=GQ/Lzt5BJnIXCxqaXUpjDvRRgsMfTGcRoMmTbKPEdwo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NzRTVZys0/2nHERDYLRItn/O9QDqNWmFP6zv+ftM3Fo2E+ziikTk1iuM5abu8OOExi1omUy5M7vdoa8qf0cPjET12UdovnSUrNLRiRQUKiflcglL38R78Wp8uttbUGRWpOHDJQKwUHq3oz+hmviwyRPl+C6a7GZW3arbspFSr2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-01 (Coremail) with SMTP id qwCowAAnLEh0w8lmM7j_CQ--.56870S2;
	Sat, 24 Aug 2024 19:26:51 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: kristo@kernel.org,
	bp@alien8.de,
	tony.luck@intel.com,
	james.morse@arm.com,
	mchehab@kernel.org,
	rric@kernel.org,
	akpm@linux-foundation.org
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v5 RESEND] EDAC/ti: Fix possible null pointer dereference in _emif_get_id()
Date: Sat, 24 Aug 2024 19:26:43 +0800
Message-Id: <20240824112643.2143250-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAnLEh0w8lmM7j_CQ--.56870S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw1DurW7Ww13uFyUWFW8Xrb_yoW8ArWxpw
	4UWFW3CryUKr129r4vva18ZFyrC3Z5JayUK3y0k39Y9w45Z34kA34093y2qFyYyrW5Kay7
	Xan8tFs8ta4UAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOmhFUUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

In _emif_get_id(), of_get_address() may return NULL which is later
dereferenced. Fix this bug by adding NULL check.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 86a18ee21e5e ("EDAC, ti: Add support for TI keystone and DRA7xx EDAC")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202408160935.A6QFliqt-lkp@intel.com/
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v5:
- According to the developer's suggestion, added an inspection of function 
of_translate_address(). However, kernel test robot reported a build 
warning, so the inspection is removed here, reverting to the modification 
solution of patch v3.
Changes in v4:
- added the check of of_translate_address() as suggestions.
Changes in v3:
- added the patch operations omitted in PATCH v2 RESEND compared to PATCH 
v2. Sorry for my oversight.
Changes in v2:
- added Cc stable line.
---
 drivers/edac/ti_edac.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/edac/ti_edac.c b/drivers/edac/ti_edac.c
index 29723c9592f7..6f3da8d99eab 100644
--- a/drivers/edac/ti_edac.c
+++ b/drivers/edac/ti_edac.c
@@ -207,6 +207,9 @@ static int _emif_get_id(struct device_node *node)
 	int my_id = 0;
 
 	addrp = of_get_address(node, 0, NULL, NULL);
+	if (!addrp)
+		return -EINVAL;
+
 	my_addr = (u32)of_translate_address(node, addrp);
 
 	for_each_matching_node(np, ti_edac_of_match) {
@@ -214,6 +217,9 @@ static int _emif_get_id(struct device_node *node)
 			continue;
 
 		addrp = of_get_address(np, 0, NULL, NULL);
+		if (!addrp)
+			return -EINVAL;
+
 		addr = (u32)of_translate_address(np, addrp);
 
 		edac_printk(KERN_INFO, EDAC_MOD_NAME,
-- 
2.25.1


