Return-Path: <linux-edac+bounces-5587-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 195CCCD95D3
	for <lists+linux-edac@lfdr.de>; Tue, 23 Dec 2025 13:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 87C0230019C0
	for <lists+linux-edac@lfdr.de>; Tue, 23 Dec 2025 12:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E4D33D6D0;
	Tue, 23 Dec 2025 12:44:11 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B30933D6C0;
	Tue, 23 Dec 2025 12:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766493851; cv=none; b=cy+BVJmndnAGjJ/zx/6trrfVpv06tJr3yayKm5m2QU+VICl1FlJra+NQtjLH66Etklncv8V1Q5JB8kzsvWTc7d6q0UeZRObBf1EpZg8Ro5N/OyjxMdnfg6eHmy6n/WopFtxlvDRTCD44ey5iRnyZLTQ8BCCjt7jcFUy6bRt+ZAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766493851; c=relaxed/simple;
	bh=RflW/XRqW7ToX9KElMNZcWf5Hxa5RUUdWgSZTPqpSxU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c2+a5THo3EOfXMyRMixTCG8gPJFi9Y14eX+DXTAUF6iOs6eT6mc9YUg0yA6CG5RVRmO19g2VqcQIjgOh9kwoPwtsC4vh4c8W7h6EKaQO9EuI0q5j5viWgM4MlhB7O3jb6MAEeeJIz79H+MnLMzYVFb1wni4mok6uggCfTqJ2PEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.209])
	by APP-03 (Coremail) with SMTP id rQCowAD3D9eIjkppxTq0AQ--.2487S2;
	Tue, 23 Dec 2025 20:43:52 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: bp@alien8.de,
	tony.luck@intel.com,
	akpm@linux-foundation.org,
	dougthompson@xmission.com,
	mitake@clustcom.com
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] edac x38: fix a resource leak in x38_probe1()
Date: Tue, 23 Dec 2025 20:43:50 +0800
Message-Id: <20251223124350.1496325-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAD3D9eIjkppxTq0AQ--.2487S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JF1xWF1xAr4kXrW8Zw45trb_yoWfXrc_CF
	WIvF1xXrsrKr97tr47Jwn3ZryI9F1Y9r1kWFn2g3yaqryUZ34kX39IgF90y3WxWan8CryD
	Ja4Dt3s7Ar17WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb48FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q
	6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU13ku3UUUU
	U==
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiBwsFE2lKdUo9fQAAsG

If edac_mc_alloc() fails, also unmap the window.
Add a goto to do so.

Found by code review and compiled on ubuntu 20.04.

Fixes: df8bc08c192f ("edac x38: new MC driver module")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
---
 drivers/edac/x38_edac.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/x38_edac.c b/drivers/edac/x38_edac.c
index 49ab5721aab2..09889b615584 100644
--- a/drivers/edac/x38_edac.c
+++ b/drivers/edac/x38_edac.c
@@ -342,8 +342,10 @@ static int x38_probe1(struct pci_dev *pdev, int dev_idx)
 	layers[1].size = x38_channel_num;
 	layers[1].is_virt_csrow = false;
 	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, 0);
-	if (!mci)
-		return -ENOMEM;
+	if (!mci) {
+		rc = -ENOMEM;
+		goto fail;
+	}
 
 	edac_dbg(3, "MC: init mci\n");
 
-- 
2.25.1


