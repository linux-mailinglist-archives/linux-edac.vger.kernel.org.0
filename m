Return-Path: <linux-edac+bounces-1482-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8C992C7C2
	for <lists+linux-edac@lfdr.de>; Wed, 10 Jul 2024 03:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 125521C21CFD
	for <lists+linux-edac@lfdr.de>; Wed, 10 Jul 2024 01:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEE21C32;
	Wed, 10 Jul 2024 01:08:16 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B3C4C6B;
	Wed, 10 Jul 2024 01:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720573696; cv=none; b=aj5YUkpIH7pbFM6YokonJn3x2G7J6S2DnWjfcrc1t/sO/Kxd5/REeQCV7G9mHhv+CqGbbc2vQ7F4wtcMv8+XZ5nsVV56zOXVHwpAtJAGj6rG9EEygK8ikFKhF1qVhMa46VFJKiDJLHi5j1PwZo0yTrV+XWXdeVMkYlb026zqZvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720573696; c=relaxed/simple;
	bh=4QzTcAu3+1KRXwwsgq9iuObNy/GQtA1vHbtbx5obFS0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FDgjbbiCsPynU8+lW6CAyYCic4FbybGvLv9UWigSgQ03mf54jxCQ8nayJcGEUd/lk2GukNoPJbqaIN583gldtvdnWRhR5GJZTuQB2oHVHs9/PMIrXOCjIMpiEyfY9Bzp2HcqpP9UZOX2iAJxMQbJv2zrx5nvumX262xuCpVFa4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-01 (Coremail) with SMTP id qwCowAAXHsrk3o1mYa2MAg--.15259S2;
	Wed, 10 Jul 2024 09:07:55 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: shubhrajyoti.datta@amd.com,
	sai.krishna.potthuri@amd.com,
	bp@alien8.de,
	tony.luck@intel.com,
	james.morse@arm.com,
	mchehab@kernel.org,
	rric@kernel.org
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>
Subject: [PATCH v2] EDAC/versal: Fix possible null pointer dereference in emif_get_id()
Date: Wed, 10 Jul 2024 09:07:46 +0800
Message-Id: <20240710010746.1741228-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAXHsrk3o1mYa2MAg--.15259S2
X-Coremail-Antispam: 1UD129KBjvdXoWrurWUKF1DGw13tr4kuFWUtwb_yoWkWFg_Gw
	18WFy7XF4kK3Z0kwsF9rnxZrySyayq9r4DWrn7Kasakry5X3WUXrnaqF1DZw1DWr1j9FWD
	Kryqk343Ar1UujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJV
	WxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIda
	VFxhVjvjDU0xZFpf9x0JUQZ23UUUUU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

In emif_get_id(), of_get_address() may return NULL which is later
dereferenced. Fix this bug by adding NULL check.

Fixes: 6f15b178cd63 ("EDAC/versal: Add a Xilinx Versal memory controller driver")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v2:
- fixed the typo according to suggestions.
---
 drivers/edac/versal_edac.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/edac/versal_edac.c b/drivers/edac/versal_edac.c
index a556d23e8261..d837edac30e7 100644
--- a/drivers/edac/versal_edac.c
+++ b/drivers/edac/versal_edac.c
@@ -1053,6 +1053,9 @@ static u32 emif_get_id(struct device_node *node)
 	const __be32 *addrp;
 
 	addrp = of_get_address(node, 0, NULL, NULL);
+	if (!addrp)
+		return -EINVAL;
+
 	my_addr = (u32)of_translate_address(node, addrp);
 
 	for_each_matching_node(np, xlnx_edac_match) {
@@ -1060,6 +1063,9 @@ static u32 emif_get_id(struct device_node *node)
 			continue;
 
 		addrp = of_get_address(np, 0, NULL, NULL);
+		if (!addrp)
+			return -EINVAL;
+
 		addr = (u32)of_translate_address(np, addrp);
 
 		edac_printk(KERN_INFO, EDAC_MC,
-- 
2.25.1


