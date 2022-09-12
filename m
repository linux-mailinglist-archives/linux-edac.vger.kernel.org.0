Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811205B54BF
	for <lists+linux-edac@lfdr.de>; Mon, 12 Sep 2022 08:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiILGux (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 12 Sep 2022 02:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiILGur (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 12 Sep 2022 02:50:47 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CCB1BE9F
        for <linux-edac@vger.kernel.org>; Sun, 11 Sep 2022 23:50:43 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id h188so7363931pgc.12
        for <linux-edac@vger.kernel.org>; Sun, 11 Sep 2022 23:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=5SuaG6Ukq0CemB7A8qUbJlhfLaxFef4FQZrGHxKHG2c=;
        b=YohP9yojEQcCRdLCat24x5Mj+IkjNQarsonI/1qPPwuLLmzv6sel9Y++kT6xXUu0Rm
         jq5tIXoHGn8iHLpkwMzfK5GVYmYmrDDWSRnDEKYDcT/XOdLr5LwLd2W1RT7f8PSaElV7
         JAQty2nUjARKFLuOvvlsTdZhWYYG+/kcoUh4/znraCVqgH/5HpaW+FFagCvAHWz06Yyg
         JsdSO2Naw7fd8IflC3KmKwtHlPrfnuCrRLVHxoZrswePXQFhqPP8SlhogIllZcq6HEJd
         tDa9wNsw9E8vCZwFpLC72Ql/LgJ5NWa4XmoFxqN7bYYSjL23FVKut+LCpQvDOju2+6nz
         b3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=5SuaG6Ukq0CemB7A8qUbJlhfLaxFef4FQZrGHxKHG2c=;
        b=bQnZKthTop8jpKblqlG3NTdKZCnLRJBjL07Z/VilEneE3j4O2e3CosYN7x5ADCSpQ0
         +5e8tL8yNs5A8QYsNcd+FwKrb5YkSKjrD9YWycaM6S1nWsi/gCjrdqxTseF9kV6P0PlO
         7l+jGy3xZ1TGv1N917EpjRPGSA9+G/RbFLtq0yc8PFpbFk5Y78UtvC2MjQ2bMk/d69PG
         pggq6tM7H7jFv1+rMJsG4XLQWLtNS6S5GN2FvL2Gpcun6LVk3Dzi8H4n6vT7qtO1bGdW
         y8oZ0Z8UgeIy75gRZscaIg4vTnKtE7g1hnUnO8nui9/lg9tW2tksNVA34A0wlYs81Upa
         LuHA==
X-Gm-Message-State: ACgBeo04OXg0Rk3Ro6wRlCCng/YQzHyQFtXxK/I1fzMyVe+AgY+1AkOY
        wq58qeHGetBmF3xBjcuMeCiw2Q==
X-Google-Smtp-Source: AA6agR5nbTXjpyILRFiRpPCefxdAB20Q7gXw4UZs9EWUdNMmOm1UJImwpvvIOiunYcDZVySVsEryWw==
X-Received: by 2002:a05:6a00:2385:b0:544:c42d:8a72 with SMTP id f5-20020a056a00238500b00544c42d8a72mr834219pfc.84.1662965442181;
        Sun, 11 Sep 2022 23:50:42 -0700 (PDT)
Received: from localhost.localdomain (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id v62-20020a632f41000000b00430c6fd7ffbsm4705716pgv.84.2022.09.11.23.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 23:50:41 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, greentime.hu@sifive.com,
        conor.dooley@microchip.com, ben.dooks@sifive.com, bp@alien8.de,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v4 2/6] soc: sifive: ccache: Rename SiFive L2 cache to Composable cache.
Date:   Mon, 12 Sep 2022 06:50:25 +0000
Message-Id: <20220912065029.1793-3-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220912065029.1793-1-zong.li@sifive.com>
References: <20220912065029.1793-1-zong.li@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Greentime Hu <greentime.hu@sifive.com>

Since composable cache may be L3 cache if there is a L2 cache, we should
use its original name composable cache to prevent confusion.

There are some new lines were generated due to adding the compatible
"sifive,ccache0" into ID table and indent requirement.

The sifive L2 has been renamed to sifive CCACHE, EDAC driver needs to
apply the change as well.

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Signed-off-by: Zong Li <zong.li@sifive.com>
Co-developed-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/edac/Kconfig                          |   2 +-
 drivers/edac/sifive_edac.c                    |  12 +-
 drivers/soc/sifive/Kconfig                    |   6 +-
 drivers/soc/sifive/Makefile                   |   2 +-
 .../{sifive_l2_cache.c => sifive_ccache.c}    | 174 +++++++++---------
 .../{sifive_l2_cache.h => sifive_ccache.h}    |  16 +-
 6 files changed, 110 insertions(+), 102 deletions(-)
 rename drivers/soc/sifive/{sifive_l2_cache.c => sifive_ccache.c} (34%)
 rename include/soc/sifive/{sifive_l2_cache.h => sifive_ccache.h} (12%)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 17562cf1fe97..456602d373b7 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -473,7 +473,7 @@ config EDAC_ALTERA_SDMMC
 
 config EDAC_SIFIVE
 	bool "Sifive platform EDAC driver"
-	depends on EDAC=y && SIFIVE_L2
+	depends on EDAC=y && SIFIVE_CCACHE
 	help
 	  Support for error detection and correction on the SiFive SoCs.
 
diff --git a/drivers/edac/sifive_edac.c b/drivers/edac/sifive_edac.c
index ee800aec7d47..b844e2626fd5 100644
--- a/drivers/edac/sifive_edac.c
+++ b/drivers/edac/sifive_edac.c
@@ -2,7 +2,7 @@
 /*
  * SiFive Platform EDAC Driver
  *
- * Copyright (C) 2018-2019 SiFive, Inc.
+ * Copyright (C) 2018-2022 SiFive, Inc.
  *
  * This driver is partially based on octeon_edac-pc.c
  *
@@ -10,7 +10,7 @@
 #include <linux/edac.h>
 #include <linux/platform_device.h>
 #include "edac_module.h"
-#include <soc/sifive/sifive_l2_cache.h>
+#include <soc/sifive/sifive_ccache.h>
 
 #define DRVNAME "sifive_edac"
 
@@ -32,9 +32,9 @@ int ecc_err_event(struct notifier_block *this, unsigned long event, void *ptr)
 
 	p = container_of(this, struct sifive_edac_priv, notifier);
 
-	if (event == SIFIVE_L2_ERR_TYPE_UE)
+	if (event == SIFIVE_CCACHE_ERR_TYPE_UE)
 		edac_device_handle_ue(p->dci, 0, 0, msg);
-	else if (event == SIFIVE_L2_ERR_TYPE_CE)
+	else if (event == SIFIVE_CCACHE_ERR_TYPE_CE)
 		edac_device_handle_ce(p->dci, 0, 0, msg);
 
 	return NOTIFY_OK;
@@ -67,7 +67,7 @@ static int ecc_register(struct platform_device *pdev)
 		goto err;
 	}
 
-	register_sifive_l2_error_notifier(&p->notifier);
+	register_sifive_ccache_error_notifier(&p->notifier);
 
 	return 0;
 
@@ -81,7 +81,7 @@ static int ecc_unregister(struct platform_device *pdev)
 {
 	struct sifive_edac_priv *p = platform_get_drvdata(pdev);
 
-	unregister_sifive_l2_error_notifier(&p->notifier);
+	unregister_sifive_ccache_error_notifier(&p->notifier);
 	edac_device_del_device(&pdev->dev);
 	edac_device_free_ctl_info(p->dci);
 
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
similarity index 34%
rename from drivers/soc/sifive/sifive_l2_cache.c
rename to drivers/soc/sifive/sifive_ccache.c
index 59640a1d0b28..949b824e89ad 100644
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
@@ -49,83 +49,84 @@ enum {
 #ifdef CONFIG_DEBUG_FS
 static struct dentry *sifive_test;
 
-static ssize_t l2_write(struct file *file, const char __user *data,
-			size_t count, loff_t *ppos)
+static ssize_t ccache_write(struct file *file, const char __user *data,
+			    size_t count, loff_t *ppos)
 {
 	unsigned int val;
 
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
-	{ /* end of table */ },
+	{ .compatible = "sifive,ccache0" },
+	{ /* end of table */ }
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
@@ -139,99 +140,106 @@ static const struct attribute_group priv_attr_group = {
 	.attrs = priv_attrs,
 };
 
-static const struct attribute_group *l2_get_priv_group(struct cacheinfo *this_leaf)
+static const struct attribute_group *ccache_get_priv_group(struct cacheinfo
+							   *this_leaf)
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
+		atomic_notifier_call_chain(&ccache_err_chain,
+					   SIFIVE_CCACHE_ERR_TYPE_CE,
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
+		atomic_notifier_call_chain(&ccache_err_chain,
+					   SIFIVE_CCACHE_ERR_TYPE_UE,
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
+		atomic_notifier_call_chain(&ccache_err_chain,
+					   SIFIVE_CCACHE_ERR_TYPE_CE,
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
+		atomic_notifier_call_chain(&ccache_err_chain,
+					   SIFIVE_CCACHE_ERR_TYPE_UE,
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
+		rc = request_irq(g_irq[i], ccache_int_handler, 0, "ccache_ecc",
+				 NULL);
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
+
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

