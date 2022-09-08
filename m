Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635C95B2102
	for <lists+linux-edac@lfdr.de>; Thu,  8 Sep 2022 16:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbiIHOpE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 8 Sep 2022 10:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiIHOou (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 8 Sep 2022 10:44:50 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1D21D31F
        for <linux-edac@vger.kernel.org>; Thu,  8 Sep 2022 07:44:41 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id o126so9152225pfb.6
        for <linux-edac@vger.kernel.org>; Thu, 08 Sep 2022 07:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=wbDb2kYWAgkEIDQJ0UPQIA/ni5c6F+53yNgIrgtwFqg=;
        b=RPY6YbXBMfH6OjFQCvIy89jlsC0KuKV5tW0FbZ+TIVdlcGl3QeYd+tWC9H+HQSlah5
         MSg6DLrxaEIPFDl4i8nXe/D6YWR8XkalmkKHlO48poWzIyuls1jf+Z/bGkOxFwv7XBeM
         HF+evbgdHPBfYvxGw0fnwmSzw5jPSGU586SQAVLr/ow9mTtsIpxCb2cT8ULwLIdwhyCS
         r9FDWOU5zG5K56WgQnPYTcjpg7hCQwAHhk5GWZcuaaJ0PMLNGClwnH/m4Fpl63FExsKE
         bDfTOdiXd8+vEKpnPwZKn/dnWiuXJQO/jZFOpWbOj0kLZ7lTcUaJEADeeJpchHB/Rp4W
         rOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=wbDb2kYWAgkEIDQJ0UPQIA/ni5c6F+53yNgIrgtwFqg=;
        b=z1+Jr0BEZVQh4SrSXoqfTZxZjhrkJ6gqFaM/CKLCO07oi3nDYch6hs5NpZWpHY5bd3
         sgGcpUwJUw+KL6qtDtfGFPEvWr3PQABagmeQMYlNmdU50n0NEMLFHROyOnxVLHdy+Gjg
         okXmvEFjRDh0FRj0uM3diorx2fIX+PTOtZP9bi6qS/Tl+Qt9l8BWrnB9X0HMP/2r70pr
         EsraCMiPlBuKDsVRvVFjk6PuEj3l6APIsHB39Qm9ltVmtbrZraHGZfwkQeSChbzhfRgx
         keuHStLhIaoVTE6gEQ6BbMZtyjOdpftsy2EcxjOMbXdI1HNvsoUhpGuo2aJlWwIDgZ2v
         I8Tg==
X-Gm-Message-State: ACgBeo1hyTbptcBAad6AENDuaW3Vi4hUjWzXn1/NmCTsv47qr7qBm3TV
        lFQjib7oRFVViZF0LEZM46kwlQ==
X-Google-Smtp-Source: AA6agR663AyOqfGUkOT49zEGbKqr9aPBFRFvp4ECi5xXjdQRyEI1Zr+ZkPWMBtnpfODNRLJFqlEmng==
X-Received: by 2002:a63:5b42:0:b0:429:d283:8a51 with SMTP id l2-20020a635b42000000b00429d2838a51mr8342571pgm.610.1662648279862;
        Thu, 08 Sep 2022 07:44:39 -0700 (PDT)
Received: from localhost.localdomain (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d40400b001750361f430sm4484728ple.155.2022.09.08.07.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 07:44:39 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, greentime.hu@sifive.com,
        conor.dooley@microchip.com, ben.dooks@sifive.com, bp@alien8.de,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v3 3/6] soc: sifive: ccache: determine the cache level from dts
Date:   Thu,  8 Sep 2022 14:44:21 +0000
Message-Id: <20220908144424.4232-4-zong.li@sifive.com>
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

Composable cache could be L2 or L3 cache, use 'cache-level' property of
device node to determine the level.

Signed-off-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 drivers/soc/sifive/sifive_ccache.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/sifive/sifive_ccache.c b/drivers/soc/sifive/sifive_ccache.c
index 949b824e89ad..690c19489317 100644
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
+		return -ENODEV;
+
 	intr_num = of_property_count_u32_elems(np, "interrupts");
 	if (!intr_num) {
 		pr_err("CCACHE: no interrupts property\n");
-- 
2.17.1

