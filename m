Return-Path: <linux-edac+bounces-1472-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B1992BC73
	for <lists+linux-edac@lfdr.de>; Tue,  9 Jul 2024 16:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A0DB281C59
	for <lists+linux-edac@lfdr.de>; Tue,  9 Jul 2024 14:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E4119CCE1;
	Tue,  9 Jul 2024 14:05:16 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D0C19B5B6;
	Tue,  9 Jul 2024 14:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720533916; cv=none; b=aG0q9RMTuYrPNYYSk+vJGyshXr1uT0zqPdB4fzlD44hOaLlgp8BRYzsiG/zXCc1dDpzMMSAGO73KyQx5wSVJi0AX5Sju2a66cniM5LYT97YwEDL4BA/CScXIoP4/JLmbQSrPYWcSx8DIcPAxH8qTnKvOZEdGytjc+0BQJrF3l0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720533916; c=relaxed/simple;
	bh=aT9KxpR/5yygMSydYfDfbgl0RR3g7jLPoGITwLJc9FE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ErsosmRmOkAfF52SrmemOmAV8wg0f2Xitgey25NnomFYBvCs7yU3euSBkndbEX4c3CFpkVPE35++5vNE8sMS+ZEZwi3fwLtmoKtmFtaHTzY3fZIzdOh4qfg6rwBW6uPOAywTaiPaAxM2yY5FQx2DmWJ+Ls+dxkdsEjuw9ftw/rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowACnr+eHQ41mXppiAg--.14867S2;
	Tue, 09 Jul 2024 22:05:03 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: kristo@kernel.org,
	bp@alien8.de,
	tony.luck@intel.com,
	james.morse@arm.com,
	mchehab@kernel.org,
	rric@kernel.org
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>
Subject: [PATCH] EDAC/ti: Fix possible null pointer dereference in _emif_get_id()
Date: Tue,  9 Jul 2024 22:04:54 +0800
Message-Id: <20240709140454.1222094-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACnr+eHQ41mXppiAg--.14867S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZrWxAw45Gr4DJF17JFy5urg_yoWDCwb_KF
	1rWFy7Xr1vgF97GwsIqw13Z34Iy3yj9w1qgrs2g39aqry5Xa43XrsaqF1DZrZrWrW09Fy5
	KrWqk34rAr1UujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUAkucUUU
	UU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

In _emif_get_id(), of_get_address() may return NULL which is later
dereferenced. Fix this bug by adding NULL check.

Fixes: 86a18ee21e5e ("EDAC, ti: Add support for TI keystone and DRA7xx EDAC")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
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


