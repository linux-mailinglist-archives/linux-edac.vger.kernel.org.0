Return-Path: <linux-edac+bounces-5343-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 72996C34A7A
	for <lists+linux-edac@lfdr.de>; Wed, 05 Nov 2025 10:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1D9AE349A94
	for <lists+linux-edac@lfdr.de>; Wed,  5 Nov 2025 09:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B9E2F363B;
	Wed,  5 Nov 2025 09:03:17 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2C92F363A;
	Wed,  5 Nov 2025 09:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762333397; cv=none; b=P5bjP/a/Jiqpf440/dbMk0hia5DQlRHEGLrnQMQmkKoA3baWmaDTE6X/jjHff23YmS+rliNjYd8+8/sK2nSgOmxtv6dyY5wpULBYDTQVrBQb3bF88gj4iM4RJ0mACJgDlZpG8u3Ve+tVyT/YsCerxVWLcClwMCGSns1e7I7nAg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762333397; c=relaxed/simple;
	bh=1z0E1EqV54kBm5lPnndQe9topYrOFX9VD5Q5Pr4k0XE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=aCwvHw5JgGDUlDpAVVFAcz9rC68Dyqp+pYc/hCqUDzw7XXCEow5+l10R1cOlpLV5dGkPc+8L31Dcw8+zDSI0Wk4aB/aJtUSnhJRqVl3EXHELnkFaZ3L1ukLLzxuMHTKem8Be7AuAFzA9O6Ee87jKa75vuIymqrzfNWHH4G0lXGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-05 (Coremail) with SMTP id zQCowAAXg_G1EgtpNtOdAQ--.11647S2;
	Wed, 05 Nov 2025 17:02:54 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: tony.luck@intel.com,
	qiuxu.zhuo@intel.com,
	bp@alien8.de
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>
Subject: [PATCH v2] EDAC/igen6: Fix error handling in igen6_edac driver
Date: Wed,  5 Nov 2025 17:02:44 +0800
Message-Id: <20251105090244.23327-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:zQCowAAXg_G1EgtpNtOdAQ--.11647S2
X-Coremail-Antispam: 1UD129KBjvJXoWruw4kCw4kXr1kXF1fAw4DXFb_yoW8Jr4Upr
	4Ygas7Cr43trZ2ga18Awn5ZFyYganxta4qv3yqy393GFy3ZF9YqFWvyFWUtFyDArWv9F4a
	ya15X3yruF1DCF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwCY1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_GFWl42xK82IYc2Ij64vIr41l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU0_-BDUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

The igen6_edac driver calls device_initialize() for all memory
controllers in igen6_register_mci(), but misses corresponding
put_device() calls in error paths and during normal shutdown in
igen6_unregister_mcis().

Adding the missing put_device() calls improves code readability and
ensures proper reference counting for the device structure.

Found by code review.

Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v2:
- modified the patch, thanks for developer's suggestions;
- removed Fixes line.
---
 drivers/edac/igen6_edac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index 2fc59f9eed69..553c31a2d922 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -1300,6 +1300,7 @@ static int igen6_register_mci(int mc, void __iomem *window, struct pci_dev *pdev
 	imc->mci = mci;
 	return 0;
 fail3:
+	put_device(&imc->dev);
 	mci->pvt_info = NULL;
 	kfree(mci->ctl_name);
 fail2:
@@ -1326,6 +1327,7 @@ static void igen6_unregister_mcis(void)
 		kfree(mci->ctl_name);
 		mci->pvt_info = NULL;
 		edac_mc_free(mci);
+		put_device(&imc->dev);
 		iounmap(imc->window);
 	}
 }
-- 
2.17.1


