Return-Path: <linux-edac+bounces-5356-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C789C39A1C
	for <lists+linux-edac@lfdr.de>; Thu, 06 Nov 2025 09:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 40A2E4F0A56
	for <lists+linux-edac@lfdr.de>; Thu,  6 Nov 2025 08:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1822E8E08;
	Thu,  6 Nov 2025 08:47:57 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8DA2D978D;
	Thu,  6 Nov 2025 08:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762418877; cv=none; b=TVpynKVbdm1NmeWaLzgF5OT9oOH/3DirSPtArjdLXC3Is/OcbZrip5Sn2HzFTrCKHsR5byRY1fMKK3a4HVUuD8RIujo2ZLRHN4RZQkcdRTSmupWZNHYeDEbKOnemwxVfQoNk3GfzBF7kTDli2TY17lnYlShyoeURw/YMjJ189Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762418877; c=relaxed/simple;
	bh=CDfWwWmxlSSsuZTx+yO0gdP72XUOPWZyyWZjcZb2uDA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=lTRm6L18QzKXpGHSpQ1Kc/xwHuwbSD4C3PD0/wLoKVdt2F8VWTRNyvPVTBtTsFOWscDvCfPt86VBUU2kJwAUUvLVoSK1gEePnC0vSOqaIyyLeUC2pe8B1GnCBxtzIoKr/9W11/D4Zlu11WgYjIEaSQhAYcxlONlPETfV+IbBd2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-03 (Coremail) with SMTP id rQCowAC3MuqoYAxpcwS2AQ--.1761S2;
	Thu, 06 Nov 2025 16:47:44 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: jbaron@akamai.com,
	bp@alien8.de,
	tony.luck@intel.com,
	qiuxu.zhuo@intel.com
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>
Subject: [PATCH v3] EDAC/ie31200: Fix error handling in ie31200_register_mci
Date: Thu,  6 Nov 2025 16:47:35 +0800
Message-Id: <20251106084735.35017-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:rQCowAC3MuqoYAxpcwS2AQ--.1761S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF18Wr4Uuw13tw1DJr15CFg_yoW8XFy3pw
	sxWas8JryDtw4kCa1UZr18ZF45uw4aka1rAFWfC3y3K3ZxZryvyFyktr42yFy8Aa92yFya
	qF98X3ykAr1UAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwCY1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_GFyl42xK82IYc2Ij64vIr41l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU5xhLUUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

ie31200_register_mci() calls device_initialize() for priv->dev
unconditionally. However, in the error path, put_device() is not
called, leading to an imbalance. Similarly, in the unload path,
put_device() is missing.

Although edac_mc_free() eventually frees the memory, it does not
release the device initialized by device_initialize(). For code
readability and proper pairing of device_initialize()/put_device(),
add put_device() calls in both error and unload paths.

Found by code review.

Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v3:
- moved put_device() from fail_free to fail_unmap to avoid using uninitialized priv variable when window allocation fails.
Changes in v2:
- modified the patch, thanks for developer's suggestions;
- removed Fixes line.
---
 drivers/edac/ie31200_edac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index 5a080ab65476..8d4ddaa85ae8 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -526,6 +526,7 @@ static int ie31200_register_mci(struct pci_dev *pdev, struct res_config *cfg, in
 	ie31200_pvt.priv[mc] = priv;
 	return 0;
 fail_unmap:
+	put_device(&priv->dev);
 	iounmap(window);
 fail_free:
 	edac_mc_free(mci);
@@ -598,6 +599,7 @@ static void ie31200_unregister_mcis(void)
 		mci = priv->mci;
 		edac_mc_del_mc(mci->pdev);
 		iounmap(priv->window);
+		put_device(&priv->dev);
 		edac_mc_free(mci);
 	}
 }
-- 
2.17.1


