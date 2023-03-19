Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB716C0325
	for <lists+linux-edac@lfdr.de>; Sun, 19 Mar 2023 17:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjCSQdD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 19 Mar 2023 12:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjCSQcw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 19 Mar 2023 12:32:52 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CAC1CBD6;
        Sun, 19 Mar 2023 09:32:30 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id j6so5400448ilr.7;
        Sun, 19 Mar 2023 09:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679243550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h+S1X/wdhExoyqkKmBy94+OSsVdt6ibT+RRYnKpbjsE=;
        b=QK1x9bDF3ZAz60Q4ZXNDwPvSkgXYOb3QK3AepwEcuq3Q0hwNDE2imXNZlN3xlxmSvf
         n5Qe/+22zOxECwcPz4TB1s6UG7Q0A8IzHhyfct2IS4ndEN24scE/oYwdp+qoIa8cJ81/
         dtyDX4eTKSdsieoLbrB7KonhYcPOnGKhxIWjslmEWdeaGyUumOexMLLdr96lS/Ya3rl4
         k6g4VYxVV93PDic/8kR2NTvVyK7N96Q75tsE+Z2peQ2Nro26shuyneo1QUx0nvjknQyn
         xjxvc8S42knXdFzypzp/ETQUW0FAmhysgKdEW0X8sVHlJ6sByE1glm5rr1eoPtNjoInx
         UFuw==
X-Gm-Message-State: AO0yUKWEbTLQS8N9EMdcshSwNAvKlP2vuPaNy5Zifow67xF3lVA5QGlM
        896MHBdpjuE57oVxAswwmA==
X-Google-Smtp-Source: AK7set9RI2sDrFC2oM6eP5wb3DEU6CycbbHdimS8OvgDWu6ybqUgXlaIUgxiqms0+b1OJaoSp/1jCQ==
X-Received: by 2002:a92:7412:0:b0:314:17d4:e9f6 with SMTP id p18-20020a927412000000b0031417d4e9f6mr3350086ilc.6.1679243549804;
        Sun, 19 Mar 2023 09:32:29 -0700 (PDT)
Received: from robh_at_kernel.org ([2605:ef80:80c7:2689:137d:d795:47e4:3de1])
        by smtp.gmail.com with ESMTPSA id f5-20020a056638112500b00405a03433a0sm2427050jar.156.2023.03.19.09.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 09:32:29 -0700 (PDT)
Received: (nullmailer pid 226541 invoked by uid 1000);
        Sun, 19 Mar 2023 16:32:26 -0000
From:   Rob Herring <robh@kernel.org>
To:     Dinh Nguyen <dinguyen@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Tero Kristo <kristo@kernel.org>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] EDAC: Use of_address_to_resource()
Date:   Sun, 19 Mar 2023 11:32:23 -0500
Message-Id: <20230319163224.226479-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Replace of_get_address() and of_translate_address() calls with single
call to of_address_to_resource().

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/edac/altera_edac.c |  5 +++--
 drivers/edac/ti_edac.c     | 10 +++++-----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index e7e8e624a436..8a98512d168d 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1096,6 +1096,7 @@ static int altr_s10_sdram_check_ecc_deps(struct altr_edac_device_dev *device)
 	struct arm_smccc_res result;
 	struct device_node *np;
 	phys_addr_t sdram_addr;
+	struct resource res;
 	u32 read_reg;
 	int ret;
 
@@ -1103,8 +1104,8 @@ static int altr_s10_sdram_check_ecc_deps(struct altr_edac_device_dev *device)
 	if (!np)
 		goto sdram_err;
 
-	sdram_addr = of_translate_address(np, of_get_address(np, 0,
-							     NULL, NULL));
+	of_address_to_resource(np, 0, &res);
+	sdram_addr = res->start;
 	of_node_put(np);
 	sdram_ecc_addr = (unsigned long)sdram_addr + prv->ecc_en_ofst;
 	arm_smccc_smc(INTEL_SIP_SMC_REG_READ, sdram_ecc_addr,
diff --git a/drivers/edac/ti_edac.c b/drivers/edac/ti_edac.c
index 6971ded598de..7befcf6c6637 100644
--- a/drivers/edac/ti_edac.c
+++ b/drivers/edac/ti_edac.c
@@ -202,19 +202,19 @@ MODULE_DEVICE_TABLE(of, ti_edac_of_match);
 static int _emif_get_id(struct device_node *node)
 {
 	struct device_node *np;
-	const __be32 *addrp;
+	struct resource res;
 	u32 addr, my_addr;
 	int my_id = 0;
 
-	addrp = of_get_address(node, 0, NULL, NULL);
-	my_addr = (u32)of_translate_address(node, addrp);
+	of_address_to_resource(node, 0, &res);
+	my_addr = (u32)res.start;
 
 	for_each_matching_node(np, ti_edac_of_match) {
 		if (np == node)
 			continue;
 
-		addrp = of_get_address(np, 0, NULL, NULL);
-		addr = (u32)of_translate_address(np, addrp);
+		of_address_to_resource(np, 0, &res);
+		addr = (u32)res.start;
 
 		edac_printk(KERN_INFO, EDAC_MOD_NAME,
 			    "addr=%x, my_addr=%x\n",
-- 
2.39.2

