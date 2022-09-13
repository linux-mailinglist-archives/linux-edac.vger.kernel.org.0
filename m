Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAB45B67C0
	for <lists+linux-edac@lfdr.de>; Tue, 13 Sep 2022 08:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiIMGTG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 13 Sep 2022 02:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiIMGSk (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 13 Sep 2022 02:18:40 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E76757554
        for <linux-edac@vger.kernel.org>; Mon, 12 Sep 2022 23:18:39 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id b23so10776207pfp.9
        for <linux-edac@vger.kernel.org>; Mon, 12 Sep 2022 23:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=KI8GGOYVJ30lpXYNmzlWaq92ei+up8qB7deF01pAkE4=;
        b=CZ+teBhlhis5wFUYdxdcaWhEgOEww+/Db4CC4fbPu9/xi2buOMzifHhDyLjViSrSW1
         4LEDGvKRsB2t1fX4qyDlRaKfszPSOC/JDYqLVU13V9CibT1P5fsjYuhA8wnc/mELjdpQ
         p3R2r+ZZ363BoLJp8AxyyyDCp47W1fDmTPKVMvLjTjR/IEUss0jXx0A3DUjNgiR9hxM6
         TizW5hVag/yLzs2dSsnA8MGIZOwz4mXxfAYXQedGlQHwoj4Fjs5WlhZXxPI9UJ9bKaTu
         ovjYEDVdshxcAJ8+0xgV58BiFJAuLTX1xNFPtSerANdu5gbUK0BBkdJVMbOvLrXPUAVb
         Y4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=KI8GGOYVJ30lpXYNmzlWaq92ei+up8qB7deF01pAkE4=;
        b=VoAHs+BHaI3oTi1q0iCsQ16kTBwuFXErw2c4YKZPFyxQKzw71Nth4oD4PaMvEt77Fe
         nhu407IosVueSUfbgqrzluo6I07usSwhW+lhzayItoSFIEJEDcAerpJlftbSWNzwZEQR
         0be8w3puGS5qpHxOjHniltY+rcZy3inYQjbUGYVqlljOixWRc3rTgskCCZfdLy9ubIEI
         DU5sYaihhRpdd9AEkW33qnoIdsQKecd19ZBMwJWOWpZvuxiRUWCW1UebqHZWXeBMyGQO
         J+IXCVwdrDuqMsqTDqVKN+IM3gD+HNVpvsiIeCtUdxLJuFJZFyAaftBG7pFHKg0CzbMX
         ot0Q==
X-Gm-Message-State: ACgBeo2QWqYD886Hbb5rVmUlX+OLy9030bztOn/34EQxmlDaqdQxrYgY
        cmLDd/ct9sWJjWyyw6lSY6PJTA==
X-Google-Smtp-Source: AA6agR5lAPSERiuwyxmqPgFoLJ1TQBeoJcDfyodPk4tCaG6Q3ueHdqIL7Mw7gf8jctkZyHhapVK8Tw==
X-Received: by 2002:a05:6a00:1ac7:b0:537:4186:c106 with SMTP id f7-20020a056a001ac700b005374186c106mr31355839pfv.76.1663049919084;
        Mon, 12 Sep 2022 23:18:39 -0700 (PDT)
Received: from localhost.localdomain (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id z11-20020a170902cccb00b00173cfaed233sm7296332ple.62.2022.09.12.23.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 23:18:38 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, greentime.hu@sifive.com,
        conor.dooley@microchip.com, ben.dooks@sifive.com, bp@alien8.de,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v5 5/7] soc: sifive: ccache: use pr_fmt() to remove CCACHE: prefixes
Date:   Tue, 13 Sep 2022 06:18:15 +0000
Message-Id: <20220913061817.22564-6-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220913061817.22564-1-zong.li@sifive.com>
References: <20220913061817.22564-1-zong.li@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Ben Dooks <ben.dooks@sifive.com>

Use the pr_fmt() macro to prefix all the output with "CCACHE:"
to avoid having to write it out each time, or make a large diff
when the next change comes along.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
Signed-off-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/soc/sifive/sifive_ccache.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/sifive/sifive_ccache.c b/drivers/soc/sifive/sifive_ccache.c
index 17080af7dfa0..91f0c2b32ea2 100644
--- a/drivers/soc/sifive/sifive_ccache.c
+++ b/drivers/soc/sifive/sifive_ccache.c
@@ -5,6 +5,9 @@
  * Copyright (C) 2018-2022 SiFive, Inc.
  *
  */
+
+#define pr_fmt(fmt) "CCACHE: " fmt
+
 #include <linux/debugfs.h>
 #include <linux/interrupt.h>
 #include <linux/of_irq.h>
@@ -85,13 +88,13 @@ static void ccache_config_read(void)
 
 	cfg = readl(ccache_base + SIFIVE_CCACHE_CONFIG);
 
-	pr_info("CCACHE: %u banks, %u ways, sets/bank=%llu, bytes/block=%llu\n",
+	pr_info("%u banks, %u ways, sets/bank=%llu, bytes/block=%llu\n",
 		(cfg & 0xff), (cfg >> 8) & 0xff,
 		BIT_ULL((cfg >> 16) & 0xff),
 		BIT_ULL((cfg >> 24) & 0xff));
 
 	cfg = readl(ccache_base + SIFIVE_CCACHE_WAYENABLE);
-	pr_info("CCACHE: Index of the largest way enabled: %u\n", cfg);
+	pr_info("Index of the largest way enabled: %u\n", cfg);
 }
 
 static const struct of_device_id sifive_ccache_ids[] = {
@@ -155,7 +158,7 @@ static irqreturn_t ccache_int_handler(int irq, void *device)
 	if (irq == g_irq[DIR_CORR]) {
 		add_h = readl(ccache_base + SIFIVE_CCACHE_DIRECCFIX_HIGH);
 		add_l = readl(ccache_base + SIFIVE_CCACHE_DIRECCFIX_LOW);
-		pr_err("CCACHE: DirError @ 0x%08X.%08X\n", add_h, add_l);
+		pr_err("DirError @ 0x%08X.%08X\n", add_h, add_l);
 		/* Reading this register clears the DirError interrupt sig */
 		readl(ccache_base + SIFIVE_CCACHE_DIRECCFIX_COUNT);
 		atomic_notifier_call_chain(&ccache_err_chain,
@@ -175,7 +178,7 @@ static irqreturn_t ccache_int_handler(int irq, void *device)
 	if (irq == g_irq[DATA_CORR]) {
 		add_h = readl(ccache_base + SIFIVE_CCACHE_DATECCFIX_HIGH);
 		add_l = readl(ccache_base + SIFIVE_CCACHE_DATECCFIX_LOW);
-		pr_err("CCACHE: DataError @ 0x%08X.%08X\n", add_h, add_l);
+		pr_err("DataError @ 0x%08X.%08X\n", add_h, add_l);
 		/* Reading this register clears the DataError interrupt sig */
 		readl(ccache_base + SIFIVE_CCACHE_DATECCFIX_COUNT);
 		atomic_notifier_call_chain(&ccache_err_chain,
@@ -185,7 +188,7 @@ static irqreturn_t ccache_int_handler(int irq, void *device)
 	if (irq == g_irq[DATA_UNCORR]) {
 		add_h = readl(ccache_base + SIFIVE_CCACHE_DATECCFAIL_HIGH);
 		add_l = readl(ccache_base + SIFIVE_CCACHE_DATECCFAIL_LOW);
-		pr_err("CCACHE: DataFail @ 0x%08X.%08X\n", add_h, add_l);
+		pr_err("DataFail @ 0x%08X.%08X\n", add_h, add_l);
 		/* Reading this register clears the DataFail interrupt sig */
 		readl(ccache_base + SIFIVE_CCACHE_DATECCFAIL_COUNT);
 		atomic_notifier_call_chain(&ccache_err_chain,
@@ -218,7 +221,7 @@ static int __init sifive_ccache_init(void)
 
 	intr_num = of_property_count_u32_elems(np, "interrupts");
 	if (!intr_num) {
-		pr_err("CCACHE: no interrupts property\n");
+		pr_err("No interrupts property\n");
 		return -ENODEV;
 	}
 
@@ -227,7 +230,7 @@ static int __init sifive_ccache_init(void)
 		rc = request_irq(g_irq[i], ccache_int_handler, 0, "ccache_ecc",
 				 NULL);
 		if (rc) {
-			pr_err("CCACHE: Could not request IRQ %d\n", g_irq[i]);
+			pr_err("Could not request IRQ %d\n", g_irq[i]);
 			return rc;
 		}
 	}
-- 
2.17.1

