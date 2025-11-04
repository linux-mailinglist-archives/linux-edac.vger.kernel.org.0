Return-Path: <linux-edac+bounces-5304-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4E5C2EBC7
	for <lists+linux-edac@lfdr.de>; Tue, 04 Nov 2025 02:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5A35934C48B
	for <lists+linux-edac@lfdr.de>; Tue,  4 Nov 2025 01:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE12212548;
	Tue,  4 Nov 2025 01:23:50 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED5E1A5BB4;
	Tue,  4 Nov 2025 01:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762219430; cv=none; b=YOTNpeuiLiE49d6s/UI7cMH71m/RmJmVodkxyKdF4T9J1JLSUazXiw1QNCnUdUX5FuKts8rwjHIc7Q77Z1fmWAtR8PjXR3li9n74Xc5I+aXu0MejFdrZPUNYsIOaDhPON7mcQpFeX/5CJ6NdYAkzQeEBd2avtJtcaKHzZedM8po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762219430; c=relaxed/simple;
	bh=5Zm4kec9TgBkqZ7eh13MO0AlfoPfVZq8y6OXDMWw8Jg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=teFguBp33vgTS+mGRcMW6aavtbsX1y64RBlyR87uFR3cxyhlyuNThkAlpHTAGtLb3lCyhzfbFXauK5F3ow/PvqT5k0yHJsZRxNht4T2LEwV5OT68MA4zdS/7x8idw0bSSH8Vms82uU0n3xpjt1GQsBmfjDVnWDxMe+wr9p7MOY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-05 (Coremail) with SMTP id zQCowADHcO+GVQlpw8paAQ--.25136S2;
	Tue, 04 Nov 2025 09:23:28 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: jbaron@akamai.com,
	bp@alien8.de,
	tony.luck@intel.com,
	qiuxu.zhuo@intel.com
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] EDAC/ie31200: Fix error handling in ie31200_register_mci
Date: Tue,  4 Nov 2025 09:23:17 +0800
Message-Id: <20251104012317.34637-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:zQCowADHcO+GVQlpw8paAQ--.25136S2
X-Coremail-Antispam: 1UD129KBjvdXoWruw47ZF43try8Jr4kZFyrWFg_yoWfuFb_W3
	WFv3y7Xr1qgr1vyr17Jw43urySkF9F9rn3GFW2gFy3J3W3ZF4DXw4DWFyUtr429a9rWFyD
	Ja4jgry7Jr1xKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbTxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
	4UJVW0owAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_KwCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUb9mitUUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

When mc > 0, ie31200_register_mci() initializes priv->dev but fails to
call put_device() on it in the error path, causing a memory leak. Add
proper put_device() call for priv->dev in the error handling path to
balance device_initialize().

Found by code review.

Cc: stable@vger.kernel.org
Fixes: d0742284ec6d ("EDAC/ie31200: Add Intel Raptor Lake-S SoCs support")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/edac/ie31200_edac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index 5a080ab65476..a5a4bb24b72a 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -528,6 +528,8 @@ static int ie31200_register_mci(struct pci_dev *pdev, struct res_config *cfg, in
 fail_unmap:
 	iounmap(window);
 fail_free:
+	if (mc > 0)
+		put_device(&priv->dev);
 	edac_mc_free(mci);
 	return ret;
 }
-- 
2.17.1


