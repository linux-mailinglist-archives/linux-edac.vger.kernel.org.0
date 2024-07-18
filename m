Return-Path: <linux-edac+bounces-1551-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80386934E2E
	for <lists+linux-edac@lfdr.de>; Thu, 18 Jul 2024 15:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 194751F237E2
	for <lists+linux-edac@lfdr.de>; Thu, 18 Jul 2024 13:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71ECA13DB90;
	Thu, 18 Jul 2024 13:30:13 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5077081745;
	Thu, 18 Jul 2024 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309413; cv=none; b=MYvaekPzhezns63NGYkVfZZZu7rGMZfQazE8ohtXxzx8bzUhCGrG5x3QkNZL4hyniLqqVVsMftVBSk8C0SUpuv7MjnbkB48MOYXyeaDHaIHzEzreC6utf1SsJF4cGO1hFPxyJ+OcKnhsdLARFn+/mYsCLpGJa9WMzteFywZuPhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309413; c=relaxed/simple;
	bh=+Npn2ARSeScntu6PPTnz0FNM0maOuRq69uO3r2huVj4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DqzrilOMFz2VhSAgR74gN0bjJwrcNkMHQoyX+i+zun6g/LA98rnKV3eDZudur4liM8GY1QswLM0dL4kbNWDozAbhMntyV0XNXRtFNpSnlttDM8/3U3Nkl7igDHIGtzxPG6LNyuO7eUz4UjjHV72XI+t94GFqTUd302ay9uKFOoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-01 (Coremail) with SMTP id qwCowACXd0zTGJlmdAMSBA--.2984S2;
	Thu, 18 Jul 2024 21:30:00 +0800 (CST)
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
Date: Thu, 18 Jul 2024 21:29:53 +0800
Message-Id: <20240718132953.789690-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACXd0zTGJlmdAMSBA--.2984S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF47GF13XF1kCr48Xr1DKFg_yoW8GFyrpF
	47W34YyFyUKa48Gr4qvwn5XFy5Cwn3XayxWrWIya4Y93y3X345JryUZFWjya4jqrW8Cay3
	tr45tw45Aay8JaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUAkucUUUUU=
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


