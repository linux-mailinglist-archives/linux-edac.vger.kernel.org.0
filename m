Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22115B54CA
	for <lists+linux-edac@lfdr.de>; Mon, 12 Sep 2022 08:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiILGvP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 12 Sep 2022 02:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiILGu4 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 12 Sep 2022 02:50:56 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0132C29CB6
        for <linux-edac@vger.kernel.org>; Sun, 11 Sep 2022 23:50:55 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id s14-20020a17090a6e4e00b0020057c70943so11411794pjm.1
        for <linux-edac@vger.kernel.org>; Sun, 11 Sep 2022 23:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=5bvvWd4WtFmP4+rZD5AyV+ZxO3T7wivPuDP2w82MTho=;
        b=FP9hdz+N9C/PONsacP63b61e/uNXZATGo+NRzmt/BylcfobvcSASL5nQQa+6oOb5Lr
         kr2XyLjdEHilcKvSzSLUxyBIcjObULVXS/DfpXb/7o6LceKQ8DB6C4wrtcy/ENLG+vJA
         meM+ZRxMdNkP6sTTqADSPH1FbB1BVgiDr3uIo/3ll7E2emaSZBVOI2uSk2CcfPPYkk2p
         qSj3IhyOy5mkICecsju6GUnSQfRrn5p1FG5nOa0Pv5WIHeZmLE63bSuRv4YDHOG3bm0J
         a1vCeDqnNmQLzulII4+Bnf8jHTPrXjspXTg3Q7nIPkfHs1FSmeykmodRycRazcm7AOFc
         gG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=5bvvWd4WtFmP4+rZD5AyV+ZxO3T7wivPuDP2w82MTho=;
        b=6c9wG/8FVsars0Su+RCTP65hHp/M5+jl4+JILc4+i5NIeYolVZlxJionMedV+13vRE
         g52gwi7brM7puLwV73FSnXY/MDHlai9JzUzSEQ4AL5XXxtdrnSE4ziHPurEg4i4gnaAa
         NKs0VOxasF2PcrCKbi9w8XIWiA1uJp16MdZCCM2EvL69K6qkQUjEOOoC3rKT3viP6rz7
         7vlIBHL3WKKLhTQJShnFN1QpJCFmuWcJJnRwCs+D18/jmMjXRhKST9wGl96uplOgSuGF
         2qv2VLUwswDqvQFfEu66OTsWw2yqu6o+WtAve26d+Nr7N0y2Iw0UWYfW/AJxFdqHdnA1
         lLBg==
X-Gm-Message-State: ACgBeo08HqJvmHrbSrdEJdGuG2BG4AfJ6fUA1Nem+dHy8qrnhUCxbxRV
        3Ijh1WYnDFSf/YhV3ly6i/3BfQ==
X-Google-Smtp-Source: AA6agR7768wxpg0BWBnut+gOBLkDMgBOyzVmCR1vQg/Yp6BRsdW/kl+DoZcjtTlnwkyxI6fdXHU8tA==
X-Received: by 2002:a17:903:22cc:b0:178:18a1:d16c with SMTP id y12-20020a17090322cc00b0017818a1d16cmr11282283plg.155.1662965454516;
        Sun, 11 Sep 2022 23:50:54 -0700 (PDT)
Received: from localhost.localdomain (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id v62-20020a632f41000000b00430c6fd7ffbsm4705716pgv.84.2022.09.11.23.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 23:50:53 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, greentime.hu@sifive.com,
        conor.dooley@microchip.com, ben.dooks@sifive.com, bp@alien8.de,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v4 6/6] soc: sifive: ccache: define the macro for the register shifts
Date:   Mon, 12 Sep 2022 06:50:29 +0000
Message-Id: <20220912065029.1793-7-zong.li@sifive.com>
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

Define the macro for the register shifts, it could make the code be
more readable

Signed-off-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/soc/sifive/sifive_ccache.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/sifive/sifive_ccache.c b/drivers/soc/sifive/sifive_ccache.c
index 91f0c2b32ea2..1c171150e878 100644
--- a/drivers/soc/sifive/sifive_ccache.c
+++ b/drivers/soc/sifive/sifive_ccache.c
@@ -13,6 +13,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
 #include <linux/device.h>
+#include <linux/bitfield.h>
 #include <asm/cacheinfo.h>
 #include <soc/sifive/sifive_ccache.h>
 
@@ -33,6 +34,11 @@
 #define SIFIVE_CCACHE_DATECCFAIL_COUNT 0x168
 
 #define SIFIVE_CCACHE_CONFIG 0x00
+#define SIFIVE_CCACHE_CONFIG_BANK_MASK GENMASK_ULL(7, 0)
+#define SIFIVE_CCACHE_CONFIG_WAYS_MASK GENMASK_ULL(15, 8)
+#define SIFIVE_CCACHE_CONFIG_SETS_MASK GENMASK_ULL(23, 16)
+#define SIFIVE_CCACHE_CONFIG_BLKS_MASK GENMASK_ULL(31, 24)
+
 #define SIFIVE_CCACHE_WAYENABLE 0x08
 #define SIFIVE_CCACHE_ECCINJECTERR 0x40
 
@@ -87,11 +93,11 @@ static void ccache_config_read(void)
 	u32 cfg;
 
 	cfg = readl(ccache_base + SIFIVE_CCACHE_CONFIG);
-
-	pr_info("%u banks, %u ways, sets/bank=%llu, bytes/block=%llu\n",
-		(cfg & 0xff), (cfg >> 8) & 0xff,
-		BIT_ULL((cfg >> 16) & 0xff),
-		BIT_ULL((cfg >> 24) & 0xff));
+	pr_info("%llu banks, %llu ways, sets/bank=%llu, bytes/block=%llu\n",
+		FIELD_GET(SIFIVE_CCACHE_CONFIG_BANK_MASK, cfg),
+		FIELD_GET(SIFIVE_CCACHE_CONFIG_WAYS_MASK, cfg),
+		BIT_ULL(FIELD_GET(SIFIVE_CCACHE_CONFIG_SETS_MASK, cfg)),
+		BIT_ULL(FIELD_GET(SIFIVE_CCACHE_CONFIG_BLKS_MASK, cfg)));
 
 	cfg = readl(ccache_base + SIFIVE_CCACHE_WAYENABLE);
 	pr_info("Index of the largest way enabled: %u\n", cfg);
-- 
2.17.1

