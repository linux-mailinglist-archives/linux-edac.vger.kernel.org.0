Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBDB5ACDAD
	for <lists+linux-edac@lfdr.de>; Mon,  5 Sep 2022 10:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237013AbiIEIcm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 5 Sep 2022 04:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237738AbiIEIcV (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 5 Sep 2022 04:32:21 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A67E6442
        for <linux-edac@vger.kernel.org>; Mon,  5 Sep 2022 01:31:45 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id x80so7580933pgx.0
        for <linux-edac@vger.kernel.org>; Mon, 05 Sep 2022 01:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=references:in-reply-to:message-id:date:subject:to:from:from:to:cc
         :subject:date;
        bh=RDrMP3xvws9OaH5g40HGBJ+ievxTdagfiswczWlZGrE=;
        b=GaEGPW0pfxra5HjSvW8DeN4YpWoDxiCA4SwjaVQvOZ3i033gVO66Ds4YdkdRFvVUya
         0Bmvj8jqNQ7QspNRcSsRmlQo8JYeVdn5pNrHy8O2USdEE1RhKHTc6rsOWqZ5Fq/9GHvJ
         O2FmKSh5S0l5UlkRbFxN9/tKFgOMa8JcVwVN7ILAYbaELD7UjIrvpbbVLs+7p33Vo4E8
         6WdWUfSvarxMXQoVdsshCZYGQAHfMgKyWY9PriMGsNn79q9T6IGu++ZnukL741KyLhen
         E0v6wZaIZd7rSuWpY7XpVzGa18Ur21XRrr3LZJjgyvOe+MXvDiuONh1fzOklInFhGJ7C
         PHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=RDrMP3xvws9OaH5g40HGBJ+ievxTdagfiswczWlZGrE=;
        b=M28h8u/9ZUDqF9FV+noBKBY4ZCc8Kf956V77nFbtKCkoawd3gyhL3lVdDsY8/7KOhg
         0dkDRiE4+/Z85NEYvlRCJ6MmnVquqE05zpx8UNjDYATf43Wnnf08G9pUH/Uiu2z4CH+/
         6UQwvgGhVmgJqPpeQDSKv+SASICIHdhON+qkv9PRbjQRfME4egilEd+LX9GjjH60tlOL
         qc3akQJseEGw7j5D4YIiEObq9dZZ+Myoqej4Gb8TWBWiceDfmYZC4y+JbMmHHU2wjeF8
         CL9LyXa/l5/Kh4VieVIlYpaih2VUNgJmgk0KyQ3llYUOyfcjpW8Mz78EaFUygMaOEL7c
         XUGA==
X-Gm-Message-State: ACgBeo31Z/qGRVJB1tFFQowMzSPBTEFeezMVwULsz675M+c9B8qSDBBk
        C+ugzcnls57KvxdewF99gHb5dg==
X-Google-Smtp-Source: AA6agR4PksOGChEzlZmHfYqVAO3icSi/6xHuDhyAO991X/YapRhAqjqHkJbNMMdn9RTr3ycRSxWiQw==
X-Received: by 2002:a05:6a00:b41:b0:52f:59dc:75 with SMTP id p1-20020a056a000b4100b0052f59dc0075mr48945533pfo.33.1662366704155;
        Mon, 05 Sep 2022 01:31:44 -0700 (PDT)
Received: from localhost.localdomain (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79423000000b00537dfd6e67esm7089721pfo.48.2022.09.05.01.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:31:43 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, greentime.hu@sifive.com,
        conor.dooley@microchip.com, ben.dooks@sifive.com, bp@alien8.de,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] soc: sifive: ccache: reduce printing on init
Date:   Mon,  5 Sep 2022 08:31:23 +0000
Message-Id: <20220905083125.29426-5-zong.li@sifive.com>
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

The driver prints out 6 lines on startup, which can easily be redcued
to two lines without losing any information.

Note, to make the types work better, uint64_t has been replaced with
ULL to make the unsigned long long match the format in the print
statement.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
 drivers/soc/sifive/sifive_ccache.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/soc/sifive/sifive_ccache.c b/drivers/soc/sifive/sifive_ccache.c
index 0e0eb85c94d8..401c67a485e2 100644
--- a/drivers/soc/sifive/sifive_ccache.c
+++ b/drivers/soc/sifive/sifive_ccache.c
@@ -81,20 +81,17 @@ static void setup_sifive_debug(void)
 
 static void ccache_config_read(void)
 {
-	u32 regval, val;
-
-	regval = readl(ccache_base + SIFIVE_CCACHE_CONFIG);
-	val = regval & 0xFF;
-	pr_info("CCACHE: No. of Banks in the cache: %d\n", val);
-	val = (regval & 0xFF00) >> 8;
-	pr_info("CCACHE: No. of ways per bank: %d\n", val);
-	val = (regval & 0xFF0000) >> 16;
-	pr_info("CCACHE: Sets per bank: %llu\n", (uint64_t)1 << val);
-	val = (regval & 0xFF000000) >> 24;
-	pr_info("CCACHE: Bytes per cache block: %llu\n", (uint64_t)1 << val);
-
-	regval = readl(ccache_base + SIFIVE_CCACHE_WAYENABLE);
-	pr_info("CCACHE: Index of the largest way enabled: %d\n", regval);
+	u32 cfg;
+
+	cfg = readl(ccache_base + SIFIVE_CCACHE_CONFIG);
+
+	pr_info("CCACHE: %u banks, %u ways, sets/bank=%llu, bytes/block=%llu\n",
+		(cfg & 0xff), (cfg >> 8) & 0xff,
+		BIT_ULL((cfg >> 16) & 0xff),
+		BIT_ULL((cfg >> 24) & 0xff));
+
+	cfg = readl(ccache_base + SIFIVE_CCACHE_WAYENABLE);
+	pr_info("CCACHE: Index of the largest way enabled: %d\n", cfg);
 }
 
 static const struct of_device_id sifive_ccache_ids[] = {
-- 
2.17.1

