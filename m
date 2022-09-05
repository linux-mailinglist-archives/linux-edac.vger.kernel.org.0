Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30275ACDD8
	for <lists+linux-edac@lfdr.de>; Mon,  5 Sep 2022 10:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237808AbiIEIcj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 5 Sep 2022 04:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237459AbiIEIcL (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 5 Sep 2022 04:32:11 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872AE646F
        for <linux-edac@vger.kernel.org>; Mon,  5 Sep 2022 01:31:38 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id b196so7526089pga.7
        for <linux-edac@vger.kernel.org>; Mon, 05 Sep 2022 01:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=CsfEFQl2WpDVzg0Sg/KSQVvJkZMTYLX/tnX+93mmizE=;
        b=Blt6gTB35zc/g0V72pG6k8orA0Y7Mnoyhu6mmL4yaK6vhznr7seFjjH+4my+jL7J9f
         KiUVf/eWuJeAjVF5oEuZNPy6U9OoaZ0Vo03Of3skKBizH1sRhuuesn6wEnhuUxibqDgZ
         NPl73eJ6TRMYaAe/WRdojlf8mVZgFpW+VIFFxjlHD7h7BIDd1GYEbARaqNgmVydp6G3w
         MQN6qgBbBYy350UrEHWBTHQfRf+3hyDwUR51xVD+oImP1LIvU2IhVp6+LyKv0jLbzU9d
         CHOsCNSiUeL7KFZDpAaW5d773PqlDWjbOWfBeTWiVj/nR2LYogDZqN0t6gKpYK9wXKp1
         RMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=CsfEFQl2WpDVzg0Sg/KSQVvJkZMTYLX/tnX+93mmizE=;
        b=ae7fNJZDXZ6y9lguJXYxCVIJB+q7OY0It3FZbl5kpPzl6XslGiS9Wx+AewHFx1ET7P
         0yDGGsWGwFVVdenla4ri/3Pj+ZJykUuu9WQi0hL2dKe/ba/cLi1UAlHU0bjV585tHXXN
         eAykIXbT8MNwFewHTfvQ9mjsaBixfo5A99PwQDkJ38p/DkqT3KyXMMqbCh8rwt28fv3i
         bztHTV2E7kEXPXKXLlQXfosYepm4M9ELGB8682UFtauOI2zkAlVGTdcHekz45j49NAFP
         wWQrj/Rq3ONQ9X+TZCwMcPMg+GiW3dfx0I0crGXSAcAD6A2ZPy6SWz/im7N2ooynyPRd
         5bMQ==
X-Gm-Message-State: ACgBeo1uYXLcMcJeqhupVL4Ha7syE7F8cr1IjUGPe8E7ynJB3qrmhVbJ
        xHguOwb66xDj4Id9yHumoBhSuw==
X-Google-Smtp-Source: AA6agR6iCZnVjTk2zdS6obh3eV+01Jh4mQqHWn0EiuKO8qZWzChYfYYDwejqxQXmSjflnnZVFhO87w==
X-Received: by 2002:a63:6a04:0:b0:430:8c54:2459 with SMTP id f4-20020a636a04000000b004308c542459mr16253075pgc.596.1662366697941;
        Mon, 05 Sep 2022 01:31:37 -0700 (PDT)
Received: from localhost.localdomain (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79423000000b00537dfd6e67esm7089721pfo.48.2022.09.05.01.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:31:37 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, greentime.hu@sifive.com,
        conor.dooley@microchip.com, ben.dooks@sifive.com, bp@alien8.de,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v2 2/6] soc: sifive: ccache: Rename SiFive L2 cache to Composable cache.
Date:   Mon,  5 Sep 2022 08:31:21 +0000
Message-Id: <20220905083125.29426-3-zong.li@sifive.com>
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

From: Greentime Hu <greentime.hu@sifive.com>

Since composable cache may be L3 cache if pL2 cache exists, we should use
its original name composable cache to prevent confusion.

Apart from renaming, we also add the compatible "sifive,ccache0" into ID
table.

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/soc/sifive/Kconfig                    |   6 +-
 drivers/soc/sifive/Makefile                   |   2 +-
 .../{sifive_l2_cache.c => sifive_ccache.c}    | 163 +++++++++---------
 .../{sifive_l2_cache.h => sifive_ccache.h}    |  16 +-
 4 files changed, 94 insertions(+), 93 deletions(-)
 rename drivers/soc/sifive/{sifive_l2_cache.c => sifive_ccache.c} (35%)
 rename include/soc/sifive/{sifive_l2_cache.h => sifive_ccache.h} (12%)

diff --git a/drivers/soc/sifive/Kconfig b/drivers/soc/sifive/Kconfig
index 58cf8c40d08d..ed4c571f8771 100644
--- a/drivers/soc/sifive/Kconfig
+++ b/drivers/soc/sifive/Kconfig
@@ -2,9 +2,9 @@
 
 if SOC_SIFIVE
 
-config SIFIVE_L2
-	bool "Sifive L2 Cache controller"
+config SIFIVE_CCACHE
+	bool "Sifive Composable Cache controller"
 	help
-	  Support for the L2 cache controller on SiFive platforms.
+	  Support for the composable cache controller on SiFive platforms.
 
 endif
diff --git a/drivers/soc/sifive/Makefile b/drivers/soc/sifive/Makefile
index b5caff77938f..1f5dc339bf82 100644
--- a/drivers/soc/sifive/Makefile
+++ b/drivers/soc/sifive/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-$(CONFIG_SIFIVE_L2)	+= sifive_l2_cache.o
+obj-$(CONFIG_SIFIVE_CCACHE)	+= sifive_ccache.o
diff --git a/drivers/soc/sifive/sifive_l2_cache.c b/drivers/soc/sifive/sifive_ccache.c
similarity index 35%
rename from drivers/soc/sifive/sifive_l2_cache.c
rename to drivers/soc/sifive/sifive_ccache.c
index 59640a1d0b28..1b16a196547f 100644
--- a/drivers/soc/sifive/sifive_l2_cache.c
+++ b/drivers/soc/sifive/sifive_ccache.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * SiFive L2 cache controller Driver
+ * SiFive composable cache controller Driver
  *
- * Copyright (C) 2018-2019 SiFive, Inc.
+ * Copyright (C) 2018-2022 SiFive, Inc.
  *
  */
 #include <linux/debugfs.h>
@@ -11,33 +11,33 @@
 #include <linux/of_address.h>
 #include <linux/device.h>
 #include <asm/cacheinfo.h>
-#include <soc/sifive/sifive_l2_cache.h>
+#include <soc/sifive/sifive_ccache.h>
 
-#define SIFIVE_L2_DIRECCFIX_LOW 0x100
-#define SIFIVE_L2_DIRECCFIX_HIGH 0x104
-#define SIFIVE_L2_DIRECCFIX_COUNT 0x108
+#define SIFIVE_CCACHE_DIRECCFIX_LOW 0x100
+#define SIFIVE_CCACHE_DIRECCFIX_HIGH 0x104
+#define SIFIVE_CCACHE_DIRECCFIX_COUNT 0x108
 
-#define SIFIVE_L2_DIRECCFAIL_LOW 0x120
-#define SIFIVE_L2_DIRECCFAIL_HIGH 0x124
-#define SIFIVE_L2_DIRECCFAIL_COUNT 0x128
+#define SIFIVE_CCACHE_DIRECCFAIL_LOW 0x120
+#define SIFIVE_CCACHE_DIRECCFAIL_HIGH 0x124
+#define SIFIVE_CCACHE_DIRECCFAIL_COUNT 0x128
 
-#define SIFIVE_L2_DATECCFIX_LOW 0x140
-#define SIFIVE_L2_DATECCFIX_HIGH 0x144
-#define SIFIVE_L2_DATECCFIX_COUNT 0x148
+#define SIFIVE_CCACHE_DATECCFIX_LOW 0x140
+#define SIFIVE_CCACHE_DATECCFIX_HIGH 0x144
+#define SIFIVE_CCACHE_DATECCFIX_COUNT 0x148
 
-#define SIFIVE_L2_DATECCFAIL_LOW 0x160
-#define SIFIVE_L2_DATECCFAIL_HIGH 0x164
-#define SIFIVE_L2_DATECCFAIL_COUNT 0x168
+#define SIFIVE_CCACHE_DATECCFAIL_LOW 0x160
+#define SIFIVE_CCACHE_DATECCFAIL_HIGH 0x164
+#define SIFIVE_CCACHE_DATECCFAIL_COUNT 0x168
 
-#define SIFIVE_L2_CONFIG 0x00
-#define SIFIVE_L2_WAYENABLE 0x08
-#define SIFIVE_L2_ECCINJECTERR 0x40
+#define SIFIVE_CCACHE_CONFIG 0x00
+#define SIFIVE_CCACHE_WAYENABLE 0x08
+#define SIFIVE_CCACHE_ECCINJECTERR 0x40
 
-#define SIFIVE_L2_MAX_ECCINTR 4
+#define SIFIVE_CCACHE_MAX_ECCINTR 4
 
-static void __iomem *l2_base;
-static int g_irq[SIFIVE_L2_MAX_ECCINTR];
-static struct riscv_cacheinfo_ops l2_cache_ops;
+static void __iomem *ccache_base;
+static int g_irq[SIFIVE_CCACHE_MAX_ECCINTR];
+static struct riscv_cacheinfo_ops ccache_cache_ops;
 
 enum {
 	DIR_CORR = 0,
@@ -49,7 +49,7 @@ enum {
 #ifdef CONFIG_DEBUG_FS
 static struct dentry *sifive_test;
 
-static ssize_t l2_write(struct file *file, const char __user *data,
+static ssize_t ccache_write(struct file *file, const char __user *data,
 			size_t count, loff_t *ppos)
 {
 	unsigned int val;
@@ -57,75 +57,76 @@ static ssize_t l2_write(struct file *file, const char __user *data,
 	if (kstrtouint_from_user(data, count, 0, &val))
 		return -EINVAL;
 	if ((val < 0xFF) || (val >= 0x10000 && val < 0x100FF))
-		writel(val, l2_base + SIFIVE_L2_ECCINJECTERR);
+		writel(val, ccache_base + SIFIVE_CCACHE_ECCINJECTERR);
 	else
 		return -EINVAL;
 	return count;
 }
 
-static const struct file_operations l2_fops = {
+static const struct file_operations ccache_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.write = l2_write
+	.write = ccache_write
 };
 
 static void setup_sifive_debug(void)
 {
-	sifive_test = debugfs_create_dir("sifive_l2_cache", NULL);
+	sifive_test = debugfs_create_dir("sifive_ccache_cache", NULL);
 
 	debugfs_create_file("sifive_debug_inject_error", 0200,
-			    sifive_test, NULL, &l2_fops);
+			    sifive_test, NULL, &ccache_fops);
 }
 #endif
 
-static void l2_config_read(void)
+static void ccache_config_read(void)
 {
 	u32 regval, val;
 
-	regval = readl(l2_base + SIFIVE_L2_CONFIG);
+	regval = readl(ccache_base + SIFIVE_CCACHE_CONFIG);
 	val = regval & 0xFF;
-	pr_info("L2CACHE: No. of Banks in the cache: %d\n", val);
+	pr_info("CCACHE: No. of Banks in the cache: %d\n", val);
 	val = (regval & 0xFF00) >> 8;
-	pr_info("L2CACHE: No. of ways per bank: %d\n", val);
+	pr_info("CCACHE: No. of ways per bank: %d\n", val);
 	val = (regval & 0xFF0000) >> 16;
-	pr_info("L2CACHE: Sets per bank: %llu\n", (uint64_t)1 << val);
+	pr_info("CCACHE: Sets per bank: %llu\n", (uint64_t)1 << val);
 	val = (regval & 0xFF000000) >> 24;
-	pr_info("L2CACHE: Bytes per cache block: %llu\n", (uint64_t)1 << val);
+	pr_info("CCACHE: Bytes per cache block: %llu\n", (uint64_t)1 << val);
 
-	regval = readl(l2_base + SIFIVE_L2_WAYENABLE);
-	pr_info("L2CACHE: Index of the largest way enabled: %d\n", regval);
+	regval = readl(ccache_base + SIFIVE_CCACHE_WAYENABLE);
+	pr_info("CCACHE: Index of the largest way enabled: %d\n", regval);
 }
 
-static const struct of_device_id sifive_l2_ids[] = {
+static const struct of_device_id sifive_ccache_ids[] = {
 	{ .compatible = "sifive,fu540-c000-ccache" },
 	{ .compatible = "sifive,fu740-c000-ccache" },
+	{ .compatible = "sifive,ccache0" },
 	{ /* end of table */ },
 };
 
-static ATOMIC_NOTIFIER_HEAD(l2_err_chain);
+static ATOMIC_NOTIFIER_HEAD(ccache_err_chain);
 
-int register_sifive_l2_error_notifier(struct notifier_block *nb)
+int register_sifive_ccache_error_notifier(struct notifier_block *nb)
 {
-	return atomic_notifier_chain_register(&l2_err_chain, nb);
+	return atomic_notifier_chain_register(&ccache_err_chain, nb);
 }
-EXPORT_SYMBOL_GPL(register_sifive_l2_error_notifier);
+EXPORT_SYMBOL_GPL(register_sifive_ccache_error_notifier);
 
-int unregister_sifive_l2_error_notifier(struct notifier_block *nb)
+int unregister_sifive_ccache_error_notifier(struct notifier_block *nb)
 {
-	return atomic_notifier_chain_unregister(&l2_err_chain, nb);
+	return atomic_notifier_chain_unregister(&ccache_err_chain, nb);
 }
-EXPORT_SYMBOL_GPL(unregister_sifive_l2_error_notifier);
+EXPORT_SYMBOL_GPL(unregister_sifive_ccache_error_notifier);
 
-static int l2_largest_wayenabled(void)
+static int ccache_largest_wayenabled(void)
 {
-	return readl(l2_base + SIFIVE_L2_WAYENABLE) & 0xFF;
+	return readl(ccache_base + SIFIVE_CCACHE_WAYENABLE) & 0xFF;
 }
 
 static ssize_t number_of_ways_enabled_show(struct device *dev,
 					   struct device_attribute *attr,
 					   char *buf)
 {
-	return sprintf(buf, "%u\n", l2_largest_wayenabled());
+	return sprintf(buf, "%u\n", ccache_largest_wayenabled());
 }
 
 static DEVICE_ATTR_RO(number_of_ways_enabled);
@@ -139,99 +140,99 @@ static const struct attribute_group priv_attr_group = {
 	.attrs = priv_attrs,
 };
 
-static const struct attribute_group *l2_get_priv_group(struct cacheinfo *this_leaf)
+static const struct attribute_group *ccache_get_priv_group(struct cacheinfo *this_leaf)
 {
-	/* We want to use private group for L2 cache only */
+	/* We want to use private group for composable cache only */
 	if (this_leaf->level == 2)
 		return &priv_attr_group;
 	else
 		return NULL;
 }
 
-static irqreturn_t l2_int_handler(int irq, void *device)
+static irqreturn_t ccache_int_handler(int irq, void *device)
 {
 	unsigned int add_h, add_l;
 
 	if (irq == g_irq[DIR_CORR]) {
-		add_h = readl(l2_base + SIFIVE_L2_DIRECCFIX_HIGH);
-		add_l = readl(l2_base + SIFIVE_L2_DIRECCFIX_LOW);
-		pr_err("L2CACHE: DirError @ 0x%08X.%08X\n", add_h, add_l);
+		add_h = readl(ccache_base + SIFIVE_CCACHE_DIRECCFIX_HIGH);
+		add_l = readl(ccache_base + SIFIVE_CCACHE_DIRECCFIX_LOW);
+		pr_err("CCACHE: DirError @ 0x%08X.%08X\n", add_h, add_l);
 		/* Reading this register clears the DirError interrupt sig */
-		readl(l2_base + SIFIVE_L2_DIRECCFIX_COUNT);
-		atomic_notifier_call_chain(&l2_err_chain, SIFIVE_L2_ERR_TYPE_CE,
+		readl(ccache_base + SIFIVE_CCACHE_DIRECCFIX_COUNT);
+		atomic_notifier_call_chain(&ccache_err_chain, SIFIVE_CCACHE_ERR_TYPE_CE,
 					   "DirECCFix");
 	}
 	if (irq == g_irq[DIR_UNCORR]) {
-		add_h = readl(l2_base + SIFIVE_L2_DIRECCFAIL_HIGH);
-		add_l = readl(l2_base + SIFIVE_L2_DIRECCFAIL_LOW);
+		add_h = readl(ccache_base + SIFIVE_CCACHE_DIRECCFAIL_HIGH);
+		add_l = readl(ccache_base + SIFIVE_CCACHE_DIRECCFAIL_LOW);
 		/* Reading this register clears the DirFail interrupt sig */
-		readl(l2_base + SIFIVE_L2_DIRECCFAIL_COUNT);
-		atomic_notifier_call_chain(&l2_err_chain, SIFIVE_L2_ERR_TYPE_UE,
+		readl(ccache_base + SIFIVE_CCACHE_DIRECCFAIL_COUNT);
+		atomic_notifier_call_chain(&ccache_err_chain, SIFIVE_CCACHE_ERR_TYPE_UE,
 					   "DirECCFail");
-		panic("L2CACHE: DirFail @ 0x%08X.%08X\n", add_h, add_l);
+		panic("CCACHE: DirFail @ 0x%08X.%08X\n", add_h, add_l);
 	}
 	if (irq == g_irq[DATA_CORR]) {
-		add_h = readl(l2_base + SIFIVE_L2_DATECCFIX_HIGH);
-		add_l = readl(l2_base + SIFIVE_L2_DATECCFIX_LOW);
-		pr_err("L2CACHE: DataError @ 0x%08X.%08X\n", add_h, add_l);
+		add_h = readl(ccache_base + SIFIVE_CCACHE_DATECCFIX_HIGH);
+		add_l = readl(ccache_base + SIFIVE_CCACHE_DATECCFIX_LOW);
+		pr_err("CCACHE: DataError @ 0x%08X.%08X\n", add_h, add_l);
 		/* Reading this register clears the DataError interrupt sig */
-		readl(l2_base + SIFIVE_L2_DATECCFIX_COUNT);
-		atomic_notifier_call_chain(&l2_err_chain, SIFIVE_L2_ERR_TYPE_CE,
+		readl(ccache_base + SIFIVE_CCACHE_DATECCFIX_COUNT);
+		atomic_notifier_call_chain(&ccache_err_chain, SIFIVE_CCACHE_ERR_TYPE_CE,
 					   "DatECCFix");
 	}
 	if (irq == g_irq[DATA_UNCORR]) {
-		add_h = readl(l2_base + SIFIVE_L2_DATECCFAIL_HIGH);
-		add_l = readl(l2_base + SIFIVE_L2_DATECCFAIL_LOW);
-		pr_err("L2CACHE: DataFail @ 0x%08X.%08X\n", add_h, add_l);
+		add_h = readl(ccache_base + SIFIVE_CCACHE_DATECCFAIL_HIGH);
+		add_l = readl(ccache_base + SIFIVE_CCACHE_DATECCFAIL_LOW);
+		pr_err("CCACHE: DataFail @ 0x%08X.%08X\n", add_h, add_l);
 		/* Reading this register clears the DataFail interrupt sig */
-		readl(l2_base + SIFIVE_L2_DATECCFAIL_COUNT);
-		atomic_notifier_call_chain(&l2_err_chain, SIFIVE_L2_ERR_TYPE_UE,
+		readl(ccache_base + SIFIVE_CCACHE_DATECCFAIL_COUNT);
+		atomic_notifier_call_chain(&ccache_err_chain, SIFIVE_CCACHE_ERR_TYPE_UE,
 					   "DatECCFail");
 	}
 
 	return IRQ_HANDLED;
 }
 
-static int __init sifive_l2_init(void)
+static int __init sifive_ccache_init(void)
 {
 	struct device_node *np;
 	struct resource res;
 	int i, rc, intr_num;
 
-	np = of_find_matching_node(NULL, sifive_l2_ids);
+	np = of_find_matching_node(NULL, sifive_ccache_ids);
 	if (!np)
 		return -ENODEV;
 
 	if (of_address_to_resource(np, 0, &res))
 		return -ENODEV;
 
-	l2_base = ioremap(res.start, resource_size(&res));
-	if (!l2_base)
+	ccache_base = ioremap(res.start, resource_size(&res));
+	if (!ccache_base)
 		return -ENOMEM;
 
 	intr_num = of_property_count_u32_elems(np, "interrupts");
 	if (!intr_num) {
-		pr_err("L2CACHE: no interrupts property\n");
+		pr_err("CCACHE: no interrupts property\n");
 		return -ENODEV;
 	}
 
 	for (i = 0; i < intr_num; i++) {
 		g_irq[i] = irq_of_parse_and_map(np, i);
-		rc = request_irq(g_irq[i], l2_int_handler, 0, "l2_ecc", NULL);
+		rc = request_irq(g_irq[i], ccache_int_handler, 0, "ccache_ecc", NULL);
 		if (rc) {
-			pr_err("L2CACHE: Could not request IRQ %d\n", g_irq[i]);
+			pr_err("CCACHE: Could not request IRQ %d\n", g_irq[i]);
 			return rc;
 		}
 	}
 
-	l2_config_read();
+	ccache_config_read();
 
-	l2_cache_ops.get_priv_group = l2_get_priv_group;
-	riscv_set_cacheinfo_ops(&l2_cache_ops);
+	ccache_cache_ops.get_priv_group = ccache_get_priv_group;
+	riscv_set_cacheinfo_ops(&ccache_cache_ops);
 
 #ifdef CONFIG_DEBUG_FS
 	setup_sifive_debug();
 #endif
 	return 0;
 }
-device_initcall(sifive_l2_init);
+device_initcall(sifive_ccache_init);
diff --git a/include/soc/sifive/sifive_l2_cache.h b/include/soc/sifive/sifive_ccache.h
similarity index 12%
rename from include/soc/sifive/sifive_l2_cache.h
rename to include/soc/sifive/sifive_ccache.h
index 92ade10ed67e..4d4ed49388a0 100644
--- a/include/soc/sifive/sifive_l2_cache.h
+++ b/include/soc/sifive/sifive_ccache.h
@@ -1,16 +1,16 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * SiFive L2 Cache Controller header file
+ * SiFive Composable Cache Controller header file
  *
  */
 
-#ifndef __SOC_SIFIVE_L2_CACHE_H
-#define __SOC_SIFIVE_L2_CACHE_H
+#ifndef __SOC_SIFIVE_CCACHE_H
+#define __SOC_SIFIVE_CCACHE_H
 
-extern int register_sifive_l2_error_notifier(struct notifier_block *nb);
-extern int unregister_sifive_l2_error_notifier(struct notifier_block *nb);
+extern int register_sifive_ccache_error_notifier(struct notifier_block *nb);
+extern int unregister_sifive_ccache_error_notifier(struct notifier_block *nb);
 
-#define SIFIVE_L2_ERR_TYPE_CE 0
-#define SIFIVE_L2_ERR_TYPE_UE 1
+#define SIFIVE_CCACHE_ERR_TYPE_CE 0
+#define SIFIVE_CCACHE_ERR_TYPE_UE 1
 
-#endif /* __SOC_SIFIVE_L2_CACHE_H */
+#endif /* __SOC_SIFIVE_CCACHE_H */
-- 
2.17.1

