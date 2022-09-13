Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0705B67C1
	for <lists+linux-edac@lfdr.de>; Tue, 13 Sep 2022 08:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiIMGTI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 13 Sep 2022 02:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiIMGSn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 13 Sep 2022 02:18:43 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0D35725A
        for <linux-edac@vger.kernel.org>; Mon, 12 Sep 2022 23:18:42 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id q15-20020a17090a304f00b002002ac83485so10373550pjl.0
        for <linux-edac@vger.kernel.org>; Mon, 12 Sep 2022 23:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=5bvvWd4WtFmP4+rZD5AyV+ZxO3T7wivPuDP2w82MTho=;
        b=jApF67DKgFFG4O14T8MMLEVYllTFfzxVxqJv0QDe0Y7gZy5P4wy4+CYiVaDwLtddlL
         OR3wCdSbFRyImrrTVtWSMPC1kEFumV2I+PLI26CZ9+VZd3LMsPb4D+Mi3Byce+1hGzKH
         0CEOu1pJP9J8A4z74Nllja0NAM/Vqqi1MX6yStEWz1yXQAEzCAzvowGS9ZT7tMjuhQNH
         Y0e1UnccGZtuBBvkj/KZFupslQYyZWFMZAaMTTfqidADyYnEhuItBVC97SLDTUrQW+r5
         RZ/hSMoIWot9KCwGt+s6YkhhGyOS3ojPelCuGG9jcfiLHk97Oc6+DPknS4NUmMmijGhV
         eJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=5bvvWd4WtFmP4+rZD5AyV+ZxO3T7wivPuDP2w82MTho=;
        b=wgsbBZdtEZHYoZDEqctQpr1S1+tRJgw/kGOP0Tp5v25PfKz2w6c2dovihkfREQiZCm
         +AHPsP+CPXbRyFmII8rLmdkTF9kQV7B1J/3ASOcbIu63qI3GJqbRaBzf5zF+TpQ8qFAu
         bJrvYCeCOEiGp3uc2UokY5Gy6WWl5iffav0yuzWCGMu/O5eOSw5CiqSBxAlepzzXuNmy
         2zR13b8ijrJHTjq3j/+uiKBRAx+ilGtzUi4ooxTKN4NPcIfsafxQRjAtqAGFZzdsvnNd
         gAGt2l+lNiaTVu6QWkApUI6PeVcHHsy4BmQnVe7lPWovlNObGChgmTf4F5rFdOQmmsiK
         1FVQ==
X-Gm-Message-State: ACgBeo30jsR3XYHWU1CDD/uaf+OgYfHIpXfRLOR4N9ZUXdWPY8sh3h7K
        OtJ3vRlTd1cv0BPGPpWMQjJY/w==
X-Google-Smtp-Source: AA6agR7ohooCghBf34n40h3VqSzgxuUDH9DmUDn6UjYI5sZtusgmGig7dwtb1cLx7HzbGSjvzgji/A==
X-Received: by 2002:a17:90a:e293:b0:202:6eab:acac with SMTP id d19-20020a17090ae29300b002026eabacacmr2229554pjz.203.1663049922048;
        Mon, 12 Sep 2022 23:18:42 -0700 (PDT)
Received: from localhost.localdomain (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id z11-20020a170902cccb00b00173cfaed233sm7296332ple.62.2022.09.12.23.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 23:18:41 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, greentime.hu@sifive.com,
        conor.dooley@microchip.com, ben.dooks@sifive.com, bp@alien8.de,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v5 6/7] soc: sifive: ccache: define the macro for the register shifts
Date:   Tue, 13 Sep 2022 06:18:16 +0000
Message-Id: <20220913061817.22564-7-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220913061817.22564-1-zong.li@sifive.com>
References: <20220913061817.22564-1-zong.li@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

