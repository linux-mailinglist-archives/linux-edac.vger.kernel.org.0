Return-Path: <linux-edac+bounces-1656-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D211954113
	for <lists+linux-edac@lfdr.de>; Fri, 16 Aug 2024 07:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18AF5B20EA1
	for <lists+linux-edac@lfdr.de>; Fri, 16 Aug 2024 05:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1007711B;
	Fri, 16 Aug 2024 05:20:55 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6432EEDE;
	Fri, 16 Aug 2024 05:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723785655; cv=none; b=bz/fxg8Zo+UwkQEf+/ODvHQXwuZ20rkKfRutmfLO/5SaGl1J+Dp6wOpUHAnT7b13mUZ6hf2YgDw2QT/1l4Tw77ad4Rx5MkK6LblVYORgZyCesa2Qpj8Bq2IjCBu3pkwMdn2c6UuQfjK+OqOKOQYeYxJXCm1NyWmFB0yo/mMV+8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723785655; c=relaxed/simple;
	bh=GQ/Lzt5BJnIXCxqaXUpjDvRRgsMfTGcRoMmTbKPEdwo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GYUci+YzDlclH76gsQgajpPw+XcsM3z76R6aivrTD7DkiRoVRdI8uvM5PrnKUVeSKfRV2WPZenPljmmO9w9J5Vcg4yOMC6V6uAZri4/ZddFhln0niLwHprIkijQtk0dU5FtD9eGoCxIzaHj0dQr/ofQimYnxXypoFbKbwSb5Kso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowABXPjmW4b5mt2n2Bg--.22524S2;
	Fri, 16 Aug 2024 13:20:30 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: kristo@kernel.org,
	bp@alien8.de,
	tony.luck@intel.com,
	james.morse@arm.com,
	mchehab@kernel.org,
	rric@kernel.org
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v5] EDAC/ti: Fix possible null pointer dereference in _emif_get_id()
Date: Fri, 16 Aug 2024 13:20:21 +0800
Message-Id: <20240816052021.378832-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABXPjmW4b5mt2n2Bg--.22524S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw1DurW7Ww13uFyUWFW8Xrb_yoW8ArWxpw
	4UWFW3CryUKr129r4vva18ZFyrC3Z5JayUK3y0k39Y9w45Z34kA34093y2qFyYyrW5Kay7
	Xan8tFs8ta4UAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbQVy7UUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

In _emif_get_id(), of_get_address() may return NULL which is later
dereferenced. Fix this bug by adding NULL check.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 86a18ee21e5e ("EDAC, ti: Add support for TI keystone and DRA7xx EDAC")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202408160935.A6QFliqt-lkp@intel.com/
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v5:
- According to the developer's suggestion, added an inspection of function 
of_translate_address(). However, kernel test robot reported a build 
warning, so the inspection is removed here, reverting to the modification 
solution of patch v3.
Changes in v4:
- added the check of of_translate_address() as suggestions.
Changes in v3:
- added the patch operations omitted in PATCH v2 RESEND compared to PATCH 
v2. Sorry for my oversight.
Changes in v2:
- added Cc stable line.
---
 drivers/edac/ti_edac.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/edac/ti_edac.c b/drivers/edac/ti_edac.c
index 29723c9592f7..6f3da8d99eab 100644
--- a/drivers/edac/ti_edac.c
+++ b/drivers/edac/ti_edac.c
@@ -207,6 +207,9 @@ static int _emif_get_id(struct device_node *node)
 	int my_id = 0;
 
 	addrp = of_get_address(node, 0, NULL, NULL);
+	if (!addrp)
+		return -EINVAL;
+
 	my_addr = (u32)of_translate_address(node, addrp);
 
 	for_each_matching_node(np, ti_edac_of_match) {
@@ -214,6 +217,9 @@ static int _emif_get_id(struct device_node *node)
 			continue;
 
 		addrp = of_get_address(np, 0, NULL, NULL);
+		if (!addrp)
+			return -EINVAL;
+
 		addr = (u32)of_translate_address(np, addrp);
 
 		edac_printk(KERN_INFO, EDAC_MOD_NAME,
-- 
2.25.1


