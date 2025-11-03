Return-Path: <linux-edac+bounces-5295-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D2024C2BD06
	for <lists+linux-edac@lfdr.de>; Mon, 03 Nov 2025 13:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ECDEC4F75EE
	for <lists+linux-edac@lfdr.de>; Mon,  3 Nov 2025 12:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9806A311976;
	Mon,  3 Nov 2025 12:40:11 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D0830C37C;
	Mon,  3 Nov 2025 12:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173611; cv=none; b=sxP82MUxouIow/P150sSrKNgwWXXWtXkxapNA5IERKn+Ss386IbKbe6m0sAv09120Yo5tJFHwLN45UiZXoHNAGB5bixXB805jGK2gVTN1tpkUONz09503x5KmMZ6iDaf5Vu0IAIgrCHCM7IH3+TUaTBrFWFgKTJbMePYIueK+NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173611; c=relaxed/simple;
	bh=2spFbkhXHi0wUJRvAU140pKtUaTuA9ZmBdvAlYVlNuk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=dhACN+Qhs5+eC44KiXrLadSNZgbvInBHCSzVn+kbbN10s1GU9E/BX8anMO9Jeqa91jBeGG/rkkdjq52StMIHbopu/x58sLu2DTn4matSYeR/SZLAzbVTuetcwfbotrlgxR9N5vMmu2OjidYg2upJ9zktre1o1ao75NH82UIFCkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-05 (Coremail) with SMTP id zQCowABn1PKaoghprNc8AQ--.20431S2;
	Mon, 03 Nov 2025 20:39:57 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: tony.luck@intel.com,
	qiuxu.zhuo@intel.com,
	bp@alien8.de
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] EDAC/igen6: Fix error handling in igen6_edac driver
Date: Mon,  3 Nov 2025 20:39:48 +0800
Message-Id: <20251103123948.23701-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:zQCowABn1PKaoghprNc8AQ--.20431S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr13Kr4rXry7ur1xJr1UKFg_yoW8JF43pr
	Z0gas3Cr13tFZrXa1UZw1kZFyFganxGa4q9rWvk39xWFsxWFyrtFZ8ZrW3tFyDAry0vr4a
	ya15X3y5u3WDCF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9m14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7MxkF7I0En4kS14v26r126r1DMxkIecxEwVAFwVW5JwCF04k20xvY0x0EwIxGrwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUya0PUUUUU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

The igen6_edac driver fails to release reference for non-primary
memory controllers during both error handling and normal shutdown.
After device_initialize() is called in igen6_register_mci(), missing
put_device() calls in error paths and igen6_unregister_mcis() cause
reference count leaks, resulting in memory leaks and improper device
cleanup.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 10590a9d4f23 ("EDAC/igen6: Add EDAC driver for Intel client SoCs using IBECC")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/edac/igen6_edac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index 2fc59f9eed69..ee2f00b204bb 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -1300,6 +1300,8 @@ static int igen6_register_mci(int mc, void __iomem *window, struct pci_dev *pdev
 	imc->mci = mci;
 	return 0;
 fail3:
+	if (mc != 0)
+		put_device(&imc->dev);
 	mci->pvt_info = NULL;
 	kfree(mci->ctl_name);
 fail2:
@@ -1326,6 +1328,8 @@ static void igen6_unregister_mcis(void)
 		kfree(mci->ctl_name);
 		mci->pvt_info = NULL;
 		edac_mc_free(mci);
+		if (imc->mc != 0)
+			put_device(&imc->dev);
 		iounmap(imc->window);
 	}
 }
-- 
2.17.1


