Return-Path: <linux-edac+bounces-1646-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 433BA95279F
	for <lists+linux-edac@lfdr.de>; Thu, 15 Aug 2024 03:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F38EE282A1D
	for <lists+linux-edac@lfdr.de>; Thu, 15 Aug 2024 01:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D76A17C9;
	Thu, 15 Aug 2024 01:45:39 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5ECA35;
	Thu, 15 Aug 2024 01:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723686339; cv=none; b=Zq4hFOBjxWcC17tlGH+91doI2jCI/KrDPvduUnEcObOfW3OE1MH8IFqOav32ze8RRSa4Ap1HEwBcQlzqZBSiMX95KtoXZ96bosM80RPFgWh8OwVSiKsMkf333UkJkIKTqbMbf15ELXeqHNaE0jqv6WyRd45wsbVvIVcAuYU7geI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723686339; c=relaxed/simple;
	bh=MzpatUKUmAcY11XbvIbLG/5RlKt1lq4ke36pTytXhLE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mipne8BajyLaMhLAvLfZ8CLQEpCpiCzN0/2Mtch0eyfpzrCz8uaBhQP+I5JBnKlTa/iibmniifwFwYbawXxiGsNlcdXCIFmUbLinkNLJSVQm5l6xIY/VE9CzIGDDx+VcSytwdpd6GQmNGkFzNMSFGAg3GYw3UwWpAEeqVWnaGks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-03 (Coremail) with SMTP id rQCowAAnTgGoXb1mesOHBg--.7529S2;
	Thu, 15 Aug 2024 09:45:20 +0800 (CST)
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
	stable@vger.kernel.org
Subject: [PATCH v4 RESEND] EDAC/ti: Fix possible null pointer dereference in _emif_get_id()
Date: Thu, 15 Aug 2024 09:45:11 +0800
Message-Id: <20240815014511.147065-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAnTgGoXb1mesOHBg--.7529S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw1fCr17Ww4rAw4DXr17GFg_yoW8Gw13pw
	47WFW3Ar1DKry2qrs2vF1rXFyrC3Z7JayDKry8K3sY93W5Xr9rA3409rZIgFyayrW8GFW3
	Xw45tFs8WFyUJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBa14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20x
	vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
	3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIx
	AIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQvtAUUUUU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

In _emif_get_id(), of_get_address() may return NULL which is later
dereferenced. Fix this bug by adding NULL check. of_translate_address() is
the same.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 86a18ee21e5e ("EDAC, ti: Add support for TI keystone and DRA7xx EDAC")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v4:
- added the check of of_translate_address() as suggestions.
Changes in v3:
- added the patch operations omitted in PATCH v2 RESEND compared to PATCH 
v2. Sorry for my oversight.
Changes in v2:
- added Cc stable line.
---
 drivers/edac/ti_edac.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/edac/ti_edac.c b/drivers/edac/ti_edac.c
index 29723c9592f7..f466f12630d3 100644
--- a/drivers/edac/ti_edac.c
+++ b/drivers/edac/ti_edac.c
@@ -207,14 +207,24 @@ static int _emif_get_id(struct device_node *node)
 	int my_id = 0;
 
 	addrp = of_get_address(node, 0, NULL, NULL);
+	if (!addrp)
+		return -EINVAL;
+
 	my_addr = (u32)of_translate_address(node, addrp);
+	if (my_addr == OF_BAD_ADDR)
+		return -EINVAL;
 
 	for_each_matching_node(np, ti_edac_of_match) {
 		if (np == node)
 			continue;
 
 		addrp = of_get_address(np, 0, NULL, NULL);
+		if (!addrp)
+			return -EINVAL;
+
 		addr = (u32)of_translate_address(np, addrp);
+		if (addr == OF_BAD_ADDR)
+			return -EINVAL;
 
 		edac_printk(KERN_INFO, EDAC_MOD_NAME,
 			    "addr=%x, my_addr=%x\n",
-- 
2.25.1


