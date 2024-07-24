Return-Path: <linux-edac+bounces-1561-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AD793ACF1
	for <lists+linux-edac@lfdr.de>; Wed, 24 Jul 2024 09:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B7FB1F237DC
	for <lists+linux-edac@lfdr.de>; Wed, 24 Jul 2024 07:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D590554670;
	Wed, 24 Jul 2024 07:05:52 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA2D4C84;
	Wed, 24 Jul 2024 07:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721804752; cv=none; b=tXm9TzEYxRB7CWb1Z0zldqgEkIUa2kiRnT0Z74yGspy1iEGsHuBoPjrxRwJuNrNEN65Ghu5oRtJiDBMgVfyYXtMlzoCxFPOZeiT0bnmciiyQhOqgpPffV7PgqBo2A5X0/Pb9DGcxAVIPbqois7aOuSKv36+8WuPpDQoVwl0w4uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721804752; c=relaxed/simple;
	bh=+Npn2ARSeScntu6PPTnz0FNM0maOuRq69uO3r2huVj4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jFqfQIaqnJLyHPepjIo1pDWV9Qg7tS69Q7VTgYqDHrN7ZycU5XRtOmDhf0OIbFUkQbsBoL70ccaMzXT2OYrNqKLwXoob1kC991x/zodRULlAMnoOqr+e5E9OFF7ea6bXc8Pa9rQe37OqbOb0ZYkYsxT7n8C+VQVNmTr4T1sTinA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowADHrTi7p6Bmjw+1AA--.41640S2;
	Wed, 24 Jul 2024 15:05:39 +0800 (CST)
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
Date: Wed, 24 Jul 2024 15:05:29 +0800
Message-Id: <20240724070529.1493072-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADHrTi7p6Bmjw+1AA--.41640S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF47GF13XF1kCr48Xr1DKFg_yoW8GFyrpF
	47W34YyFyUKa48Gr4qvwn5XFy5Cwn3XayxWrWIya4Y93y3X345JryUZFWjya4jqrW8Cay3
	tr45tw45Aay8JaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU122NtUUUUU==
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


