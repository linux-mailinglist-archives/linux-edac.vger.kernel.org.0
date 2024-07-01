Return-Path: <linux-edac+bounces-1438-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B2091D8D6
	for <lists+linux-edac@lfdr.de>; Mon,  1 Jul 2024 09:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23CEB1F21BDA
	for <lists+linux-edac@lfdr.de>; Mon,  1 Jul 2024 07:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A3E7D08D;
	Mon,  1 Jul 2024 07:21:40 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4785064CEC;
	Mon,  1 Jul 2024 07:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719818500; cv=none; b=Z5KqzSuCvZ2OM+NE5Vqe/TzhpcyulkXz4dxwllk6dPw9jmHnEs8h4DcmZ6tMJxpXBR1RYNBIMf52IMFdprAE9UEf1TXLFV/ftE5PuqllDNHaRZ/+vED62GkVOLfJOtKfBaFPckMLNLoLuTat1clNZlOdEvR7SAdtIKHfG5fajB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719818500; c=relaxed/simple;
	bh=YfENndAYVYsTGyzKorJAdO4GPFG+Scgf3TSW9rtgTVo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V+YHtHeRI/PeVS5KSD1FbcHAC/lSor/gcy1xxyLdNNsMkoIr3s4O341bS4CMJqtDM5h7F3ZM7LWp8EHj6qwFbVMsISWkmbTyt4V/Bi9/94voZZyXEDR3g8FX2P+ZmPZnQkj9M6ZM4Ixg5DTjYc0vUA40LfWrYBaT8rAsnWea8ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowACnreX2WIJm4fPvAA--.58012S2;
	Mon, 01 Jul 2024 15:21:26 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: Yazen.Ghannam@amd.com,
	tony.luck@intel.com,
	bp@alien8.de
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] RAS/AMD/ATL: Remove unneeded semicolon
Date: Mon,  1 Jul 2024 15:21:18 +0800
Message-Id: <20240701072118.846277-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACnreX2WIJm4fPvAA--.58012S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFW7Gr18JF1DGr1kKF4fGrg_yoWxurg_uw
	13Aw4fXFykXw1F9wnIv3ZYvwnFyw4kWrn5urs0gF4fC342qryrJa4DWF1DW3WxWFWxAFy3
	KF13Jr13Ja97ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbcxFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4x
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjVc_3UUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Remove unneeded semicolon.
This is detected by coccinelle.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/ras/amd/atl/denormalize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ras/amd/atl/denormalize.c b/drivers/ras/amd/atl/denormalize.c
index 1a525cfa983c..d45ce753e636 100644
--- a/drivers/ras/amd/atl/denormalize.c
+++ b/drivers/ras/amd/atl/denormalize.c
@@ -683,7 +683,7 @@ static int denorm_addr_df4_np2(struct addr_ctx *ctx)
 	default:
 		atl_debug_on_bad_intlv_mode(ctx);
 		return -EINVAL;
-	};
+	}
 
 	if (ctx->map.num_intlv_sockets == 1) {
 		hash_pa8	= BIT_ULL(shift_value) & ctx->ret_addr;
-- 
2.25.1


