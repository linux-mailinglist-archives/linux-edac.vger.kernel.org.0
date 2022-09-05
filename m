Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8017A5ACDB0
	for <lists+linux-edac@lfdr.de>; Mon,  5 Sep 2022 10:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237432AbiIEIdE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 5 Sep 2022 04:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236977AbiIEIc2 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 5 Sep 2022 04:32:28 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4334F1B6
        for <linux-edac@vger.kernel.org>; Mon,  5 Sep 2022 01:31:48 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id s14-20020a17090a6e4e00b0020057c70943so2277633pjm.1
        for <linux-edac@vger.kernel.org>; Mon, 05 Sep 2022 01:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=references:in-reply-to:message-id:date:subject:to:from:from:to:cc
         :subject:date;
        bh=kIMP7EgZ8iiUz1BDKoIQmsGMSo/q9OgC/PJgsgpnXAM=;
        b=HCYNmSw/Rwe/rv62Parwo5Iwch03PYqWJlT/Tbova0G4i4dIuv34pCqtEQ1ToptIT6
         +FgsUAogbaJ4L4gB4r2pV8TpxW/y25nObQAH+FvzY1xnrXySldzlIb7TbRV5D+csr2FA
         Nsy0cy4RMRtefuyBt9ew7D75oTBROuLw0GSrYDslXC4HwPnLDLHv2/hN0Id7jPpdDn89
         PO9CGMGyMSkqXYL1RlwZJzuh4LXa+j02GdgR+MbbQ+z6nuDM0VjIcaAqp1+z2Whn2LPs
         FGWQEYN+nfzDcgaj9ohHouM9D55VYIJUHjfW6v9wLwpFIHxcbo8OyiptJCDCLxc8zKNO
         jjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=kIMP7EgZ8iiUz1BDKoIQmsGMSo/q9OgC/PJgsgpnXAM=;
        b=C43kTtd532jSqCFFT2pW6Q0OTTCoc3FgOZ1aKUjhoRxoQbKC/oWyX0Uxr53vhBgaxw
         jjv87zyu5Zma6Oao3BRO/jTgpuFmjXNDPLVQndYThOPdrehWQOH9BqC3MRlDy8ptLU3w
         IjTX0Hb+ufwhaAToxoY865oa+f+McbEW/o/LsIvZ0UjluJXa6ofOr+8g+1Cd3FoFxw+P
         gfHb/waS3kWTFlHhI7iBH6l8lZqNDPhZt5+Gf031fxKZGPMBbqOA6yRWv/Kd4qzR9bQM
         wYDTj6UZfkM1ucZjYMWn7RmKJzhcnTPVc85FjGHmh9Fl+aqoEbXfwDaz8iK1KX1wRcOU
         sB9w==
X-Gm-Message-State: ACgBeo0uiugrsE0/yeuHLO0cqxM50eeSnQd3VV2COG3wxRD44MtbrfTc
        LlqpNt4bHvNeACQmHJcV+6eodw==
X-Google-Smtp-Source: AA6agR4huqam+O0d2qJ40XvTardsBwMj9RA3ypp7V6bueGYUhu7D+eSLzjGaN5v1A3eThHZzNuTk1A==
X-Received: by 2002:a17:902:7242:b0:171:398d:9e66 with SMTP id c2-20020a170902724200b00171398d9e66mr48506021pll.19.1662366707243;
        Mon, 05 Sep 2022 01:31:47 -0700 (PDT)
Received: from localhost.localdomain (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79423000000b00537dfd6e67esm7089721pfo.48.2022.09.05.01.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:31:46 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, greentime.hu@sifive.com,
        conor.dooley@microchip.com, ben.dooks@sifive.com, bp@alien8.de,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] soc: sifive: ccache: use pr_fmt() to remove CCACHE: prefixes
Date:   Mon,  5 Sep 2022 08:31:24 +0000
Message-Id: <20220905083125.29426-6-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220905083125.29426-1-zong.li@sifive.com>
References: <20220905083125.29426-1-zong.li@sifive.com>
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
---
 drivers/soc/sifive/sifive_ccache.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/sifive/sifive_ccache.c b/drivers/soc/sifive/sifive_ccache.c
index 401c67a485e2..d749600c0bf8 100644
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
-	pr_info("CCACHE: Index of the largest way enabled: %d\n", cfg);
+	pr_info("Index of the largest way enabled: %d\n", cfg);
 }
 
 static const struct of_device_id sifive_ccache_ids[] = {
@@ -154,7 +157,7 @@ static irqreturn_t ccache_int_handler(int irq, void *device)
 	if (irq == g_irq[DIR_CORR]) {
 		add_h = readl(ccache_base + SIFIVE_CCACHE_DIRECCFIX_HIGH);
 		add_l = readl(ccache_base + SIFIVE_CCACHE_DIRECCFIX_LOW);
-		pr_err("CCACHE: DirError @ 0x%08X.%08X\n", add_h, add_l);
+		pr_err("DirError @ 0x%08X.%08X\n", add_h, add_l);
 		/* Reading this register clears the DirError interrupt sig */
 		readl(ccache_base + SIFIVE_CCACHE_DIRECCFIX_COUNT);
 		atomic_notifier_call_chain(&ccache_err_chain, SIFIVE_CCACHE_ERR_TYPE_CE,
@@ -172,7 +175,7 @@ static irqreturn_t ccache_int_handler(int irq, void *device)
 	if (irq == g_irq[DATA_CORR]) {
 		add_h = readl(ccache_base + SIFIVE_CCACHE_DATECCFIX_HIGH);
 		add_l = readl(ccache_base + SIFIVE_CCACHE_DATECCFIX_LOW);
-		pr_err("CCACHE: DataError @ 0x%08X.%08X\n", add_h, add_l);
+		pr_err("DataError @ 0x%08X.%08X\n", add_h, add_l);
 		/* Reading this register clears the DataError interrupt sig */
 		readl(ccache_base + SIFIVE_CCACHE_DATECCFIX_COUNT);
 		atomic_notifier_call_chain(&ccache_err_chain, SIFIVE_CCACHE_ERR_TYPE_CE,
@@ -181,7 +184,7 @@ static irqreturn_t ccache_int_handler(int irq, void *device)
 	if (irq == g_irq[DATA_UNCORR]) {
 		add_h = readl(ccache_base + SIFIVE_CCACHE_DATECCFAIL_HIGH);
 		add_l = readl(ccache_base + SIFIVE_CCACHE_DATECCFAIL_LOW);
-		pr_err("CCACHE: DataFail @ 0x%08X.%08X\n", add_h, add_l);
+		pr_err("DataFail @ 0x%08X.%08X\n", add_h, add_l);
 		/* Reading this register clears the DataFail interrupt sig */
 		readl(ccache_base + SIFIVE_CCACHE_DATECCFAIL_COUNT);
 		atomic_notifier_call_chain(&ccache_err_chain, SIFIVE_CCACHE_ERR_TYPE_UE,
@@ -221,7 +224,7 @@ static int __init sifive_ccache_init(void)
 		g_irq[i] = irq_of_parse_and_map(np, i);
 		rc = request_irq(g_irq[i], ccache_int_handler, 0, "ccache_ecc", NULL);
 		if (rc) {
-			pr_err("CCACHE: Could not request IRQ %d\n", g_irq[i]);
+			pr_err("Could not request IRQ %d\n", g_irq[i]);
 			return rc;
 		}
 	}
-- 
2.17.1

