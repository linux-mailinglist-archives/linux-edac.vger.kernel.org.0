Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485486CAFAB
	for <lists+linux-edac@lfdr.de>; Mon, 27 Mar 2023 22:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbjC0UO3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Mar 2023 16:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjC0UO3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 27 Mar 2023 16:14:29 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F2D1BF9;
        Mon, 27 Mar 2023 13:14:22 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id f24-20020a4aeb18000000b0053b78077c9dso1537180ooj.12;
        Mon, 27 Mar 2023 13:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679948062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FH+KWtses1ELBCX/gQ2si6h7qatJwS5KpqqqOPXEVFs=;
        b=DDi04BWVM52dH/EVde9Da5BHVvajmJmeC1FFSLRpOXawHKst5XMOesUBodmFZekeZO
         QL+oNZZHyJ383szMG8Hlw6gx3ACxHdONizl5Q18Gl258/5Dd9nYp+ZYIzrjKzYcSHLuh
         R/Vd7EPwgjPoTnrAAV6BlEngPCCM8Aq4CBhRL7P65i3F+AhQcSUqAH7/sRMPxjg3jew2
         eqK60q+Kj3q5SLxtpUxbQkBiAwsdzc0hRc2nM7Mkpc4m/hdnMJaG/4xJN4rbhc3Qkt6v
         xG5hn1ByfAO4AMZPGWUvtQR1HKU8a+6/FAZ983NONtDy8aoEzIOCvj2cUQjcUBDDz6HJ
         TJgw==
X-Gm-Message-State: AO0yUKUgRyKoNHkUEaqiKadEirEay8fTl8kfuZA1K/hny1KQ/owdHGZ4
        /mecyah1Htlg+FcRrX1ZTg==
X-Google-Smtp-Source: AK7set+iWdMGpMmuirwcIZm+sFuxoc3KyyjdsVVWE5HtsZcnH7w2z4rjZN5L0REVu/yulBVaw49guA==
X-Received: by 2002:a4a:370f:0:b0:53b:66a3:452a with SMTP id r15-20020a4a370f000000b0053b66a3452amr6472871oor.3.1679948062208;
        Mon, 27 Mar 2023 13:14:22 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j41-20020a4a88ac000000b0053e3da7f810sm1565959ooa.25.2023.03.27.13.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 13:14:21 -0700 (PDT)
Received: (nullmailer pid 530144 invoked by uid 1000);
        Mon, 27 Mar 2023 20:14:21 -0000
From:   Rob Herring <robh@kernel.org>
To:     Dinh Nguyen <dinguyen@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Tero Kristo <kristo@kernel.org>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] EDAC: Use of_address_to_resource()
Date:   Mon, 27 Mar 2023 15:14:11 -0500
Message-Id: <20230327201411.529948-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Replace of_get_address() and of_translate_address() calls with single
call to of_address_to_resource().

Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Fix compile error
---
 drivers/edac/altera_edac.c |  5 +++--
 drivers/edac/ti_edac.c     | 10 +++++-----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index e7e8e624a436..be33329c6f18 100644
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
+	sdram_addr = res.start;
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

