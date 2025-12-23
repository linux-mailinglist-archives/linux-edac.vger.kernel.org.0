Return-Path: <linux-edac+bounces-5586-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 014D3CD942F
	for <lists+linux-edac@lfdr.de>; Tue, 23 Dec 2025 13:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9DD7E3012AD4
	for <lists+linux-edac@lfdr.de>; Tue, 23 Dec 2025 12:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6F029DB64;
	Tue, 23 Dec 2025 12:32:24 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211842BCF5;
	Tue, 23 Dec 2025 12:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766493144; cv=none; b=Vyg0GlfOTrjomvwGg4dBgehaUmtYt0Cyk5pDtsR3HNAEXALM82nTKqz0UW7Lf6v1vBKn9GDj8Hx6IKUaZsHBzqGG9DztginLU9u24aLXyGhRw6zbOo7eupKJpwS4GXrHV0zU9W2YlyYtr/nnD/3f5/I1mqDUWzXuKfan8aEdf6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766493144; c=relaxed/simple;
	bh=F4Zbt6BFiUEwCI6lB5nhMMjYRUrVsBiuMfR8skdvWYk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QllDaQ+sXJAUSGrsCYtIBh1yZJQFNUbgjdMiHps1ct1KzKSm4TInB3wC110mBt/I92g/s1cktq4/n+wrtdj4ZsDGB4XyBEzXwPTQCD4TPjX0ueaFMnvZ8LzrDxMPto9Zoow9LvdUmRqMaGq0k/hqJAQ9v7MucybhMyFXCDK/cdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.209])
	by APP-03 (Coremail) with SMTP id rQCowACXs9rDi0ppe+yzAQ--.3070S2;
	Tue, 23 Dec 2025 20:32:03 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: bp@alien8.de,
	tony.luck@intel.com,
	dougthompson@xmission.com,
	akpm@linux-foundation.org,
	juhlenko@akamai.com
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] edac: fix a resource leak in i3200_probe1()
Date: Tue, 23 Dec 2025 20:32:02 +0800
Message-Id: <20251223123202.1492038-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACXs9rDi0ppe+yzAQ--.3070S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JF1fJw1fAF48ArWxuw13XFb_yoWfWrc_ua
	y0qF17XF4qkrWqkr4xJr4fZry0kFnY9r93WF4Ig343AryxWwn2q39IgFZ8Zw1xXay3CryD
	tw1qqF93AF12gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbckFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_
	Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Jr0_Gr
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_Jw0_
	GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiDAgFE2lKdbQ1SwAAsO

If edac_mc_alloc() fails, also unmap the window.
Add a goto to do so.

Found by code review and compiled on ubuntu 20.04

Fixes: dd8ef1db87a4 ("edac: i3200 memory controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
---
 drivers/edac/i3200_edac.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/i3200_edac.c b/drivers/edac/i3200_edac.c
index afccdebf5ac1..fd5dc33c406f 100644
--- a/drivers/edac/i3200_edac.c
+++ b/drivers/edac/i3200_edac.c
@@ -360,8 +360,10 @@ static int i3200_probe1(struct pci_dev *pdev, int dev_idx)
 	layers[1].is_virt_csrow = false;
 	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers,
 			    sizeof(struct i3200_priv));
-	if (!mci)
-		return -ENOMEM;
+	if (!mci) {
+		rc = -ENOMEM;
+		goto fail;
+	}
 
 	edac_dbg(3, "MC: init mci\n");
 
-- 
2.25.1


