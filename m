Return-Path: <linux-edac+bounces-5339-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8616BC33C1E
	for <lists+linux-edac@lfdr.de>; Wed, 05 Nov 2025 03:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AF853BD753
	for <lists+linux-edac@lfdr.de>; Wed,  5 Nov 2025 02:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371E7212548;
	Wed,  5 Nov 2025 02:22:19 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1663515667D;
	Wed,  5 Nov 2025 02:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762309339; cv=none; b=dfutY5TAYfUN4PTdyqq/akqpg1E4VmqbjJCZj2rGINXXwv+saEbGKoLC8PafcOgtR7fkna2m9+3NGgx/07kspFwUeioQGnIjix+wtzeTmZKHsFJBTiQH7ZQXFim/AfrYlGJ+9G/pdn/wQ4Hk2pQ5lT1reE9hOJSOMarFP8bGPIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762309339; c=relaxed/simple;
	bh=jcyZCyiQ7gewPuCpVaJy9bKOKxzxJIXCuOhjXBHr0+M=;
	h=From:To:Cc:Subject:Date:Message-Id; b=e6T+KIDnrk4RRZV1EImlS5EfkMJu/TMWDwCwteQHBsPOPPfG+oWr0sniDfG2OtUW3wkaoyXAt05Noi0eyNVDuYx+ml89brH/y5SvV2f+M+nA1emqDMRIGA93GrfvWOEvkGQv+6fZsJebuBmPxKA0drxTe+3f6dTRNglxg0gD6aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-05 (Coremail) with SMTP id zQCowABn1PK8tAppNWWQAQ--.8867S2;
	Wed, 05 Nov 2025 10:21:58 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: jbaron@akamai.com,
	bp@alien8.de,
	tony.luck@intel.com,
	qiuxu.zhuo@intel.com
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>
Subject: [PATCH v2] EDAC/ie31200: Fix error handling in ie31200_register_mci
Date: Wed,  5 Nov 2025 10:21:46 +0800
Message-Id: <20251105022146.22105-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:zQCowABn1PK8tAppNWWQAQ--.8867S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF18Wr4Uuw13tw1DJr15CFg_yoW8Gryxpw
	sxWas8AryDtw4vka18Zr18ZFy5uwsIka15AFWfC3y3GwnxZryvyFyktrWayFy8Aa92yFWa
	qr98J3ykAr1UAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9C14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwCY1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_Gr1l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUkHUDUUUUU=
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
Changes in v2:
- modified the patch, thanks for developer's suggestions;
- removed Fixes line.
---
 drivers/edac/ie31200_edac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index 5a080ab65476..ea8fc0d5f347 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -528,6 +528,7 @@ static int ie31200_register_mci(struct pci_dev *pdev, struct res_config *cfg, in
 fail_unmap:
 	iounmap(window);
 fail_free:
+	put_device(&priv->dev);
 	edac_mc_free(mci);
 	return ret;
 }
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


