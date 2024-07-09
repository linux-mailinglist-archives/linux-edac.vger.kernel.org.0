Return-Path: <linux-edac+bounces-1471-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F112A92BC4A
	for <lists+linux-edac@lfdr.de>; Tue,  9 Jul 2024 15:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E7A21C215D0
	for <lists+linux-edac@lfdr.de>; Tue,  9 Jul 2024 13:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA76518FC8C;
	Tue,  9 Jul 2024 13:58:55 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7506A181D0D;
	Tue,  9 Jul 2024 13:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720533535; cv=none; b=Xw4bt0dxImjUM+9Lp3xKyJ9qgyOqvwBWd23mu8UbYK30HrccjZLGZ1OlUri/ZJ3dyuBfK23EaxgA80rtFG1EXPxS7ApwJ2kV6LYGi6pq24gZIYcp1u5wjLy/X8fYL6RZUNSZZxpkoWXLrQloWWD7+iFXKKVO9/xa+e7HkDOQvas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720533535; c=relaxed/simple;
	bh=22cG5llQtF8LwxSlednl5ESTJKtEK/9dkFrkNUEnIP4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iLGrcxc0PXWMgpfhyccSgs+MDLBqxDHVn3evchQBNrIHuM8OSBpzf+jRlGFNwiWyy+iYbAUdWd9n1lnNRybqZPE4ayJYffysMPnbDIsHLohIeMlLB1rNOwt9rnxKqo7uTCDPfX9tozI68ygVi63TGPKr99na5DR9isKlFY4rtYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowAD3_7cHQo1m9kZiAg--.40139S2;
	Tue, 09 Jul 2024 21:58:38 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: shubhrajyoti.datta@amd.com,
	sai.krishna.potthuri@amd.com,
	bp@alien8.de,
	tony.luck@intel.com,
	james.morse@arm.com,
	mchehab@kernel.org,
	rric@kernel.org
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>
Subject: [PATCH] EDAC/versal: Fix possible null pointer dereference in emif_get_id()
Date: Tue,  9 Jul 2024 21:58:30 +0800
Message-Id: <20240709135830.1172936-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAD3_7cHQo1m9kZiAg--.40139S2
X-Coremail-Antispam: 1UD129KBjvdXoWrurWUKF1DGFWDuF1kZrWkZwb_yoWDtFc_Gw
	48WFy7XF4kW3Z0kwsF9wnxZrySyw4qvr4DuFn7K3sakry5Zay3XrnaqFsrZw1DWr109FWD
	GryDK343Ar1UujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUQZ23UUUUU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

In emif_get_id(), of_get_address() may return NULL which is later
dereferenced. Fix this bug by adding NULL check.

Fixes: 6f15b178cd63 ("EDAC/versal: Add a Xilinx Versal memory controller driver")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/edac/versal_edac.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/edac/versal_edac.c b/drivers/edac/versal_edac.c
index a556d23e8261..6ab87277d439 100644
--- a/drivers/edac/versal_edac.c
+++ b/drivers/edac/versal_edac.c
@@ -1053,6 +1053,9 @@ static u32 emif_get_id(struct device_node *node)
 	const __be32 *addrp;
 
 	addrp = of_get_address(node, 0, NULL, NULL);
+	if (!addrp)
+		return -EINVAL;
+
 	my_addr = (u32)of_translate_address(node, addrp);
 
 	for_each_matching_node(np, xlnx_edac_match) {
@@ -1060,6 +1063,9 @@ static u32 emif_get_id(struct device_node *node)
 			continue;
 
 		addrp = of_get_address(np, 0, NULL, NULL);
+		if (!addrp)
+			return _EINVAL;
+
 		addr = (u32)of_translate_address(np, addrp);
 
 		edac_printk(KERN_INFO, EDAC_MC,
-- 
2.25.1


