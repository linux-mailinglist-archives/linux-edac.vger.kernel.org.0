Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CD35B67BD
	for <lists+linux-edac@lfdr.de>; Tue, 13 Sep 2022 08:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiIMGTD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 13 Sep 2022 02:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiIMGSe (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 13 Sep 2022 02:18:34 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9213D5725A
        for <linux-edac@vger.kernel.org>; Mon, 12 Sep 2022 23:18:33 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id q3so10256958pjg.3
        for <linux-edac@vger.kernel.org>; Mon, 12 Sep 2022 23:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=viUsGW+Zs7kQMJlix4q594CqGsU1OFW3HynVNHA2iG8=;
        b=bFFEcnl9GlVMuRvNsEeFKpPtnPkLtYPNOLwDpmNghQf1y4tyfewadzjyK2i2z30JdS
         6uRB6cn7wK7cGWkU5WSDP2Zob0KONnKqSbcxE0cQCnXsBFhZdzm7M6Sbw4/BOMSZ5jXE
         dRBi1T0zQHsL4YI5RhEnOxgTGNyZPCmkq9yy+5fBuBurilD0eCeWCsVQnSlj2Eq05Scb
         7s4i2Mvuct3albarrpaRaDtzwJNNaJw8THouke2Z5UUK2XxCn6CNUn6B5m5w5/kNmaSx
         7FhRFVonvhpdTNfL70koPBwS3/VQ3yUQmN+vWEynUEhGr80etfTsYwuYjhKDc1BNI00E
         ZD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=viUsGW+Zs7kQMJlix4q594CqGsU1OFW3HynVNHA2iG8=;
        b=myFpFPleIjt1rw2uBafmf8VHVftxYK93pXHCgNR7UIQbmpcCl/WJikbEclYrxTFDyp
         SI2cWdsIhEBNWjTVCTsk6YYy6e/DIZi9teid26KXrLqWyIQehaOI6WojwEw7Z5tYW6Al
         q1ajtF5xGAW+hPtS+G73ieeU/hhKv4wVomyqJpJ6vLZ3HYHed9oYAC1z1pAXuLNtUUOW
         33lREctOfvqaQx1vlOn7mZjfJqcasM+2jlpBgViKp5RwODvjpBpm+jQgX0tT3RPA72yu
         NU61gGJ7y4pezs+h8PUyAgdrO9VnvrlTqEzymC+/oCMP8vgXWGYNqw8vGaCnJCnO21pl
         XYhw==
X-Gm-Message-State: ACgBeo1TQXA4cqWBIxuYJWzZyATX8g8CDITCIp1ZCoFPLJc3uJv5cXRR
        rKxpQKTdvEKcDMhJ4PjqUywXtA==
X-Google-Smtp-Source: AA6agR7/o9dIDnH1RZM4XVMGUT0tpGsW6QtShNVPvZNx9Gmgd6Z53HFEC1/Ub6/GFAVuka4GUvyfEA==
X-Received: by 2002:a17:90b:33cf:b0:202:5183:c1ab with SMTP id lk15-20020a17090b33cf00b002025183c1abmr2236619pjb.117.1663049913123;
        Mon, 12 Sep 2022 23:18:33 -0700 (PDT)
Received: from localhost.localdomain (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id z11-20020a170902cccb00b00173cfaed233sm7296332ple.62.2022.09.12.23.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 23:18:32 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, greentime.hu@sifive.com,
        conor.dooley@microchip.com, ben.dooks@sifive.com, bp@alien8.de,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v5 3/7] soc: sifive: ccache: determine the cache level from dts
Date:   Tue, 13 Sep 2022 06:18:13 +0000
Message-Id: <20220913061817.22564-4-zong.li@sifive.com>
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

Composable cache could be L2 or L3 cache, use 'cache-level' property of
device node to determine the level.

Signed-off-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/soc/sifive/sifive_ccache.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/sifive/sifive_ccache.c b/drivers/soc/sifive/sifive_ccache.c
index 949b824e89ad..b361b661ea09 100644
--- a/drivers/soc/sifive/sifive_ccache.c
+++ b/drivers/soc/sifive/sifive_ccache.c
@@ -38,6 +38,7 @@
 static void __iomem *ccache_base;
 static int g_irq[SIFIVE_CCACHE_MAX_ECCINTR];
 static struct riscv_cacheinfo_ops ccache_cache_ops;
+static int level;
 
 enum {
 	DIR_CORR = 0,
@@ -144,7 +145,7 @@ static const struct attribute_group *ccache_get_priv_group(struct cacheinfo
 							   *this_leaf)
 {
 	/* We want to use private group for composable cache only */
-	if (this_leaf->level == 2)
+	if (this_leaf->level == level)
 		return &priv_attr_group;
 	else
 		return NULL;
@@ -215,6 +216,9 @@ static int __init sifive_ccache_init(void)
 	if (!ccache_base)
 		return -ENOMEM;
 
+	if (of_property_read_u32(np, "cache-level", &level))
+		return -ENOENT;
+
 	intr_num = of_property_count_u32_elems(np, "interrupts");
 	if (!intr_num) {
 		pr_err("CCACHE: no interrupts property\n");
-- 
2.17.1

