Return-Path: <linux-edac+bounces-1608-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFC09456BD
	for <lists+linux-edac@lfdr.de>; Fri,  2 Aug 2024 05:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D53E1F22175
	for <lists+linux-edac@lfdr.de>; Fri,  2 Aug 2024 03:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5CB1B7F4;
	Fri,  2 Aug 2024 03:46:12 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337562C9D;
	Fri,  2 Aug 2024 03:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722570372; cv=none; b=KrLFb0JIFm44vyvStsU4cr/ClQpiZDfuNsQDVYzi1wXVUiHw0vL5rd+ie4nUn5YHrXdVGVv/QIlfpYE6vk12o7lPd7Y3FNDOI1CHR1z4rHnl6j3sF/4BiHEQeLfivKIeUXAlq69BLnBSKroIOZMJc4t5VwbGC983E3t2PYyvRZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722570372; c=relaxed/simple;
	bh=+Npn2ARSeScntu6PPTnz0FNM0maOuRq69uO3r2huVj4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=psr+Xw4bBOfQZ2BDygLhD2XVGrSdIWIigm8mPJJgHg8N1ULCjFavn4bsLlewxqTQdHbpPafdwESLH249911Sm4qR/vzg6mQkG4gMW1T5ltsC4KUkb0fwSmsb9FebWNo4cPnHbTBCAIWZ1Xv5bGpt/ahi1jhWDWXtjbz9oWBjP+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-03 (Coremail) with SMTP id rQCowACnzQDSVKxmR+HpAg--.51096S2;
	Fri, 02 Aug 2024 11:39:01 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: dinguyen@kernel.org,
	bp@alien8.de,
	tony.luck@intel.com,
	james.morse@arm.com,
	mchehab@kernel.org,
	rric@kernel.org,
	niravkumar.l.rabara@intel.com
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH RESEND] EDAC/altera: Fix possible null pointer dereference
Date: Fri,  2 Aug 2024 11:38:49 +0800
Message-Id: <20240802033849.1560017-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACnzQDSVKxmR+HpAg--.51096S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF47GF13XF1kCr48Xr1DKFg_yoW8GFyrpF
	47W34YyFyUKa48Gr4qvwn5XFy5Cwn3XayxWrWIya4Y93y3X345JryUZFWjya4jqrW8Cay3
	tr45tw45Aay8JaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBS14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
	YI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82
	IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
	0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMI
	IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF
	0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
	Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOmhFUUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

In altr_s10_sdram_check_ecc_deps(), of_get_address() may return NULL which
is later dereferenced. Fix this bug by adding NULL check.

Cc: stable@vger.kernel.org
Fixes: e1bca853dddc ("EDAC/altera: Add SDRAM ECC check for U-Boot")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/edac/altera_edac.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index fe89f5c4837f..d6bf0eebeb41 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1086,6 +1086,7 @@ static int altr_s10_sdram_check_ecc_deps(struct altr_edac_device_dev *device)
 	struct arm_smccc_res result;
 	struct device_node *np;
 	phys_addr_t sdram_addr;
+	const __be32 *sdram_addrp;
 	u32 read_reg;
 	int ret;
 
@@ -1093,8 +1094,14 @@ static int altr_s10_sdram_check_ecc_deps(struct altr_edac_device_dev *device)
 	if (!np)
 		goto sdram_err;
 
-	sdram_addr = of_translate_address(np, of_get_address(np, 0,
-							     NULL, NULL));
+	sdram_addrp = of_get_address(np, 0, NULL, NULL);
+	if (!sdram_addrp)
+		return -EINVAL;
+
+	sdram_addr = of_translate_address(np, sdram_addrp);
+	if (!sdram_addr)
+		return -EINVAL;
+
 	of_node_put(np);
 	sdram_ecc_addr = (unsigned long)sdram_addr + prv->ecc_en_ofst;
 	arm_smccc_smc(INTEL_SIP_SMC_REG_READ, sdram_ecc_addr,
-- 
2.25.1


