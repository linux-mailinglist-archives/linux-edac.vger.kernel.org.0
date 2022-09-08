Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59845B2106
	for <lists+linux-edac@lfdr.de>; Thu,  8 Sep 2022 16:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbiIHOpI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 8 Sep 2022 10:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbiIHOpB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 8 Sep 2022 10:45:01 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CB02EF36
        for <linux-edac@vger.kernel.org>; Thu,  8 Sep 2022 07:44:46 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id c24so16952601pgg.11
        for <linux-edac@vger.kernel.org>; Thu, 08 Sep 2022 07:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=xgOVXlD8a/2jMrK0U5RpTDdtMTpvUxrpu5XPMup9bGg=;
        b=ONOszZz3dussBKvbMTqNSh9IzzGWE5GlOwkJnbDUw2WvYamxUjF38P/DTJhPYjiZkk
         qp3u1SJcJXsK9ShklIGQoYbFwsr2iR+Ss+l5PHVlHLCVKRRoQaVcS7jLi/5WFmrLVH6+
         yweamAw9LnOPGic8x4d8l0szyjR8TUNdQtz5nw5ZmjsUkjQwy5mx1tjSeloBYArSDSLE
         wrvWR5B3RFBt+h+2goofZgvlSf09WdI6qokNbOTICj98abj7+hmCvuJJFM+Ma6dLmB0b
         ZlKbbAenKUF5k8w26rc/tNCCwbAuQzJ0LVKhW9wPFcOgh7wJZH/T+vgHdEYlPVrjwytp
         Fv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=xgOVXlD8a/2jMrK0U5RpTDdtMTpvUxrpu5XPMup9bGg=;
        b=xAkfnvyST+KL/5NXoe+HK5IvRX0eQqabjdLBr9hzkJwB/c3eygJQdU3cl7pZA3jcre
         hntVFKEq8MEPWIt/qOzKArYhb9OIFhG4L9dErxmm0GYzP+9ZxHsvL42AgFAVGUkgFMwm
         EM6K1yCrNhr/lGRhKObtYoK/57nxbUXle1EGFbMONRz4ncytbPe87Z7lcZU8fVEDc77B
         H1P0g8sGhLJv9FGj4VBgtlaj3Y0y9dH/ITVC+UCIFW9ejmlV/NaX6WHxHFj5ygpl6hr6
         gny/gSr+gw6eJkadpL6m/LlTcIgX4+Fam+iWmuBoNMZmGXi11lOVyMSyXPRhAWJYzTzE
         6LTQ==
X-Gm-Message-State: ACgBeo2RDpLQ61QQa4Kz6jxxKBUwoEoIwqZZBAlKsyaZBuDaztj+Wb9m
        KC1XCKQGtSRhgN2DAYQFme4a6Q==
X-Google-Smtp-Source: AA6agR7yJ1si3K0yPA4aYKqpeD0253YNER3hIWQO6vc5O7b1sN3VgiAM1tIqaUreW8JvZUsD/PcdOw==
X-Received: by 2002:a62:1795:0:b0:53e:6cb3:31ee with SMTP id 143-20020a621795000000b0053e6cb331eemr9093750pfx.63.1662648286205;
        Thu, 08 Sep 2022 07:44:46 -0700 (PDT)
Received: from localhost.localdomain (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d40400b001750361f430sm4484728ple.155.2022.09.08.07.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 07:44:45 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, greentime.hu@sifive.com,
        conor.dooley@microchip.com, ben.dooks@sifive.com, bp@alien8.de,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v3 5/6] soc: sifive: ccache: use pr_fmt() to remove CCACHE: prefixes
Date:   Thu,  8 Sep 2022 14:44:23 +0000
Message-Id: <20220908144424.4232-6-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220908144424.4232-1-zong.li@sifive.com>
References: <20220908144424.4232-1-zong.li@sifive.com>
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
 drivers/soc/sifive/sifive_ccache.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/sifive/sifive_ccache.c b/drivers/soc/sifive/sifive_ccache.c
index 58d14f11a63a..b3929c4d6d5b 100644
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

