Return-Path: <linux-edac+bounces-1622-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A10948AD2
	for <lists+linux-edac@lfdr.de>; Tue,  6 Aug 2024 10:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 354E31C22458
	for <lists+linux-edac@lfdr.de>; Tue,  6 Aug 2024 08:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39110165EE9;
	Tue,  6 Aug 2024 08:04:08 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2426B13D276;
	Tue,  6 Aug 2024 08:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722931448; cv=none; b=R3hNMpJkLLF5URUFIDRESiKWPu1q9zzzJ6qmYfVS4nH3SWzxIhyGo9FtTF6cxNJaYXPNJ4YEQ2OAZdWPr6eScQtZVd9yya0CTiQwu36KbiDR/t0v6J5jRsJ3cqkdHd9+7/dqv7vMZYDZDO86PZ1eNZRrBQ4klBm/TDz5EigtuTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722931448; c=relaxed/simple;
	bh=2XgjUA3+Jq76hc3frjNsDmVolGe3r+NnQBfF+T8bkz4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nuByBJosPaM72vciUqboDlfMlOKm22JaVRvwm7vKjKcepr3az15eyW03rzyt9yVX5uDJ6zGupvmU5oG2sl8aQopy/Zoqyn44NtVv5MwGDuAF8MFjBEphLn5vOQuXER2h9xt2QsRL+yMRKfOPu9lLfsM8u3XY6LCee6aFS+5O1Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-01 (Coremail) with SMTP id qwCowAC3vEjZ2LFmRoTjAw--.506S2;
	Tue, 06 Aug 2024 16:03:45 +0800 (CST)
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
Subject: [PATCH v2] EDAC/altera: Fix possible null pointer dereference
Date: Tue,  6 Aug 2024 16:03:36 +0800
Message-Id: <20240806080336.2396336-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAC3vEjZ2LFmRoTjAw--.506S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw1fCr17Ww4rWFWDuw45KFg_yoW8Xw4xpr
	W7W345tryUKa4UWr4vvws5XFy5C3Z3Xay0qrWIyayY93y3Xw15Jryj9FWUta4jqrW8Cay3
	tr45tw45AayUJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBa14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
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


