Return-Path: <linux-edac+bounces-1566-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5866093BAE7
	for <lists+linux-edac@lfdr.de>; Thu, 25 Jul 2024 04:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB3FDB231A5
	for <lists+linux-edac@lfdr.de>; Thu, 25 Jul 2024 02:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B508DE556;
	Thu, 25 Jul 2024 02:41:18 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C3B101F2;
	Thu, 25 Jul 2024 02:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721875278; cv=none; b=lzU/apXcdXXa3FMv/85xhpgYLN2ffE36MvOQMfHtaNpD1MjNZjYck7ZUBZvX4KrWX3Q1wEJpABCGZNWSRhU/dEY/QTeTbZQSW2YataX8MzP1Np/WIIQpAc3717j6ZHcjT7IrdUKXMnHlZ3IrDZ2XDo/Hgrpb0ZUO+vr3uc0Ji+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721875278; c=relaxed/simple;
	bh=tR5qH+CDKQnhLl3ghv2WT12nhh4dsdsYHHcR3zXyqh8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I5UYzmjt7eZdtHkqSIc3+iVvK56ugbcAi/If52bpARxdkLuQVK5+5/s4rDdVtnrXaVqlfOeZpEF97HlI7FcWGUQoey6UJonyJAkCNs/JdjJxc3w81cXPikcRoURPNOrEA1u0AadcFVGF43uzoFBfwqAlK+87HUff2zDbPIGbQcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowADHrjk2u6FmaVvdAA--.20694S2;
	Thu, 25 Jul 2024 10:41:00 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: kristo@kernel.org,
	bp@alien8.de,
	tony.luck@intel.com,
	james.morse@arm.com,
	mchehab@kernel.org,
	rric@kernel.org,
	avadnaik@amd.com
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v3] EDAC/ti: Fix possible null pointer dereference in _emif_get_id()
Date: Thu, 25 Jul 2024 10:40:52 +0800
Message-Id: <20240725024052.1722866-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADHrjk2u6FmaVvdAA--.20694S2
X-Coremail-Antispam: 1UD129KBjvJXoWrZr1DZrWDtrWDAFW5Zw13Jwb_yoW8JrW8pw
	47WFW5AryUtry29r4vv34kZFy5C3WkJayDK340k39Y9w15XF97Jry09ry7tFyYyrW8Gay3
	Xw4rtFs8XFWUJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBS14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
	WxJr0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
	YI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82
	IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
	0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMI
	IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF
	0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
	Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUF0eHDUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

In _emif_get_id(), of_get_address() may return NULL which is later
dereferenced. Fix this bug by adding NULL check.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 86a18ee21e5e ("EDAC, ti: Add support for TI keystone and DRA7xx EDAC")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
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


