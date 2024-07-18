Return-Path: <linux-edac+bounces-1552-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2F4934E4A
	for <lists+linux-edac@lfdr.de>; Thu, 18 Jul 2024 15:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7A7D1F229B1
	for <lists+linux-edac@lfdr.de>; Thu, 18 Jul 2024 13:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5442213D2A9;
	Thu, 18 Jul 2024 13:36:45 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91AA9457;
	Thu, 18 Jul 2024 13:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309805; cv=none; b=qLJW0yCvULRmj5bEI/iTtE7b8YXd8mJfNA3mKDe7w5qdZRvCJsPXRzEeadSU06t6sQvShzu0tL0Iuqov8p7R7tlv7vJ6sAfnj1Zpn5C5IwW/MA4ReLa32ck0EhA+H24zJeCV+lZsQYYrqOEYOOldLbvMA8LEUAPbuZuYWW18fvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309805; c=relaxed/simple;
	bh=ObHzaO5cQ+0BpnyclW7TbzxelIA/WLZ2tkr0Tgkm5lU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kXZwp0wYW8C6dr4YiTUnxfc8mAf6KwfpyU4S8AcosVPUKRKjKR06NZuNmB4BpIhoIGFFC/JvRw90TRiV8F28OcPg/DK8Z1M0BoRoUekvxI6VODdCGX78oauWDwiZvZr5dGXA4hdQCLiWOiezxeTnQHyQmVUiMiYZKbDyQOSq9TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-01 (Coremail) with SMTP id qwCowACHjMhUGplmNUcSBA--.2034S2;
	Thu, 18 Jul 2024 21:36:28 +0800 (CST)
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
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v3] EDAC/versal: Fix possible null pointer dereference in emif_get_id()
Date: Thu, 18 Jul 2024 21:36:18 +0800
Message-Id: <20240718133618.802667-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACHjMhUGplmNUcSBA--.2034S2
X-Coremail-Antispam: 1UD129KBjvdXoWrurWUKF1DGw13tr4kuFWUtwb_yoWftrX_Gw
	18WFWfXF4qgFn0kwsFgrsxZrWSyayj9r1DXrn7K3sak345X3W3XrnagF4kAw1Dur1kuFWD
	GrnrK343Ar1UujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VU1c4S5UUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

In emif_get_id(), of_get_address() may return NULL which is later
dereferenced. Fix this bug by adding NULL check.

Cc: stable@vger.kernel.org
Fixes: 6f15b178cd63 ("EDAC/versal: Add a Xilinx Versal memory controller driver")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v3:
- added Cc stable line.
Changes in v2:
- fixed the typo according to suggestions.
---
 drivers/edac/versal_edac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/edac/versal_edac.c b/drivers/edac/versal_edac.c
index a556d23e8261..7aa9468acd53 100644
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
-- 
2.25.1


