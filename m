Return-Path: <linux-edac+bounces-1647-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F269527B0
	for <lists+linux-edac@lfdr.de>; Thu, 15 Aug 2024 03:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EBCB1F2230F
	for <lists+linux-edac@lfdr.de>; Thu, 15 Aug 2024 01:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E030228F5;
	Thu, 15 Aug 2024 01:54:30 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB9B22094;
	Thu, 15 Aug 2024 01:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723686870; cv=none; b=hxQpJUPmMwul+pkGsNXJyKcmwqv0RyIA4b04PhcHKGkXcbobvjOFK0oKv2vy/TwhT0uf8lDUarIbvZjINZ3pQ2+T+sYWDBOKSEcMThX/g4FFNOBeMgdOefBxqaZUQ7rUsubBNSZqx0ddUOtVJ6tyFvzstO4vneGkEt0fpoRwt/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723686870; c=relaxed/simple;
	bh=2XgjUA3+Jq76hc3frjNsDmVolGe3r+NnQBfF+T8bkz4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WZhwapPX+tCjmbN1lbGMttenYwcnNvEUIZbobIZcEwvZlNVsXSG4XXm7lWihdn2lbL/e5CyKOVywDsuNnno84mLGEThhAc6CpQpcK2YQQXpMyaRZgfAb/o14AOWASVfYumI2THhlpn1DZ0ZJzN6dV+ZX5yYAK/NfgC7sWH4jq/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-03 (Coremail) with SMTP id rQCowACHj0fCX71mwUKIBg--.7688S2;
	Thu, 15 Aug 2024 09:54:18 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: dinguyen@kernel.org,
	bp@alien8.de,
	tony.luck@intel.com,
	james.morse@arm.com,
	mchehab@kernel.org,
	rric@kernel.org,
	niravkumar.l.rabara@intel.com,
	akpm@linux-foundation.org
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2 RESEND] EDAC/altera: Fix possible null pointer dereference
Date: Thu, 15 Aug 2024 09:54:09 +0800
Message-Id: <20240815015409.148443-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACHj0fCX71mwUKIBg--.7688S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw1fCr17Ww4rWFWDuw45KFg_yoW8Xw4xpr
	W7W345tryUKa4UWr4vvws5XFy5C3Z3Xay0qrWIyayY93y3Xw15Jryj9FWUta4jqrW8Cay3
	tr45tw45AayUJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBS14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
	YI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82
	IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
	0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMI
	IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF
	0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
	Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUF0eHDUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

In altr_s10_sdram_check_ecc_deps(), of_get_address() may return NULL which
is later dereferenced. Fix this bug by adding NULL check.
of_translate_address() is the same.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: e1bca853dddc ("EDAC/altera: Add SDRAM ECC check for U-Boot")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v2:
- modified the check of of_translate_address() as suggestions.
---
 drivers/edac/altera_edac.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index fe89f5c4837f..4fbfa338e05f 100644
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
+	if (sdram_addr == OF_BAD_ADDR)
+		return -EINVAL;
+
 	of_node_put(np);
 	sdram_ecc_addr = (unsigned long)sdram_addr + prv->ecc_en_ofst;
 	arm_smccc_smc(INTEL_SIP_SMC_REG_READ, sdram_ecc_addr,
-- 
2.25.1


