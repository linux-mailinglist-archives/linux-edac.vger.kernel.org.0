Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0B15B54C7
	for <lists+linux-edac@lfdr.de>; Mon, 12 Sep 2022 08:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiILGvM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 12 Sep 2022 02:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiILGuy (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 12 Sep 2022 02:50:54 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD8729824
        for <linux-edac@vger.kernel.org>; Sun, 11 Sep 2022 23:50:52 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso7217367pjm.5
        for <linux-edac@vger.kernel.org>; Sun, 11 Sep 2022 23:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=KI8GGOYVJ30lpXYNmzlWaq92ei+up8qB7deF01pAkE4=;
        b=GMSuU6wrb4gbfYf/Vc0tM7RnsBejNC2gtIIk2Qqm496IkB0U2XSIRA7/Jc4ugHnvJs
         OjneuLH3F3Tt6TL+fqiz9ZTMfWhaKcV8kS+Ks+EnFKBo9g/JouaqfyJYIgRBbtNcARKx
         TSXTQUnz4KJ0Ot9xsMK5tE25NnaQ5FR1FKCBlzmQEkAi7CY6TUQqxkaP1cuwrKiuK8gO
         WvbVra2LCBBnXAph5GtB+6dwcB9ZESeRqDMp90+XJi4IXC3bjqUICagf5lSjyhQxXrix
         +DVTC69T1Ux9AQNu1LPgcguNE5wRhBuCY30SLbS4F05NmeRNLvqBYo0Da8WUeWCnllaa
         ixmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=KI8GGOYVJ30lpXYNmzlWaq92ei+up8qB7deF01pAkE4=;
        b=j/y/Ergc/psvMfI1y9Fy2/iphZ7COOGmaF0Iu9fYYZwKNTWQjGhxkNk0QGCku+N4TP
         X4vQPVjOW/cxHjp40X36EClLkWzvA+vFbQf+kMWKqkH2OY8UYCDR0YLO5ApIUuwJpb0X
         gV/kT14/kCXIGp9bDBy6YQdkdIzxiMF6cNGaqqhNm+O7gB7N/usW1o+k18YY/1LjmzoE
         2h00DLksEbuV5OK9FK/sdLS+fEZKv8nnrKmc/X0DLFkt90vuqxOS/ihNX58hHj2trRJk
         0zmakkiqA8mgj4SqefCyQkPnU9xMb8YBQFhL5o7sLNYS6zfJY9E30vxPUPX9a6JFinew
         lvGA==
X-Gm-Message-State: ACgBeo38yHX3rjAF0O1aMWwQauv5Cl6IE0aXQJCjbj5mQJsVDdyqztUQ
        07jyVSCIxIbbh8m7CJazafe35g==
X-Google-Smtp-Source: AA6agR6nGrzvFOlvlGJ8qouQVgLOiB7yFHWl4qEw+wEQhb08Q+u4R9GUJDn3p2gGJylOnOwQcAnDDQ==
X-Received: by 2002:a17:90a:6a83:b0:200:9da5:d0e7 with SMTP id u3-20020a17090a6a8300b002009da5d0e7mr21960464pjj.187.1662965451415;
        Sun, 11 Sep 2022 23:50:51 -0700 (PDT)
Received: from localhost.localdomain (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id v62-20020a632f41000000b00430c6fd7ffbsm4705716pgv.84.2022.09.11.23.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 23:50:50 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, greentime.hu@sifive.com,
        conor.dooley@microchip.com, ben.dooks@sifive.com, bp@alien8.de,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v4 5/6] soc: sifive: ccache: use pr_fmt() to remove CCACHE: prefixes
Date:   Mon, 12 Sep 2022 06:50:28 +0000
Message-Id: <20220912065029.1793-6-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220912065029.1793-1-zong.li@sifive.com>
References: <20220912065029.1793-1-zong.li@sifive.com>
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

