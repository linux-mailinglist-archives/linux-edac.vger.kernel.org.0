Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19E45B67B9
	for <lists+linux-edac@lfdr.de>; Tue, 13 Sep 2022 08:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiIMGTF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 13 Sep 2022 02:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiIMGSj (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 13 Sep 2022 02:18:39 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E8C57547
        for <linux-edac@vger.kernel.org>; Mon, 12 Sep 2022 23:18:36 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id s206so10407262pgs.3
        for <linux-edac@vger.kernel.org>; Mon, 12 Sep 2022 23:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=6Xe3R/apOfj9yPTgHstXk1duLFBJjDM/Rtwt0f9H5Eo=;
        b=IgoMd+u3Sm/bJS7kCMLfQkYbB0LDum24SEmPzf81Dli83n/7DWclAijuMnc2ag70Dj
         C8p4BqoBvQuAuLEz6gUs8vSbA5gGTEafAglSpKreyZuFw2ZX63tqtZ8U/dHkSyygD5fG
         Yfo0PXzP7PvU5CVP8Ddfrlgksld0VirTSAP30glA91Q7ZhFXwsMMUkR+d+JY/qB5+GQL
         qIYUs5FVpgRIWY72xdriOzcJKiXQ4/I12hNhcpWveBIPHQRhS/psJkE7lT/37q9dZy0R
         fmI1kyNum/HPtVCrJwaXU+M8o9K8EWxGWltQfz24RbeL/+YS/FYNF9qYVxz9lESgCbWr
         yu/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=6Xe3R/apOfj9yPTgHstXk1duLFBJjDM/Rtwt0f9H5Eo=;
        b=urOvY+u5nRTZJ0pm8ZXW7TCNYZAFSXI/yt95uQwMhR/r7xN7xu7z7yXEMKHUSHW6zL
         GbMFpT9WSXF5JwY4WuLnH2N8Bz2sLpT2bgIOEq2jOiivRiCiRFm61G8rCD+UALduTJZB
         LYyE74XAXz/c5bJFjxNzLLewsrOToo+pwYqUDJUcvnOU1SLAObRl+fcsQ40h2RGYigbY
         kwPcQ88p/mA1cPY+MPIbWOSJnOdFsGZ7Rrt7L8D2iz9AZ+3b9in7lGJzw8WWXQc5pNpv
         XH91YEWFcc3+tXMUnb/jvrhU2yNBtHdwuk8cGafxepYuRhyf/7RKAFZc3hagaT6sfa4U
         fFWg==
X-Gm-Message-State: ACgBeo3VqE+DWUxHc55fVv/NSetlC9J78qWQQG39ME8AihLyS97x3Q2r
        8u1ABoph4kbeX7iFcs4vyuYFkQ==
X-Google-Smtp-Source: AA6agR4wJMWC1gO3gMaes8hVyStuNQfqovIqF+q7yPPAeBfyztWmRp9gIz2JfroB/V12MFPD76hGfQ==
X-Received: by 2002:a05:6a00:2181:b0:51b:560b:dd30 with SMTP id h1-20020a056a00218100b0051b560bdd30mr31748430pfi.44.1663049916137;
        Mon, 12 Sep 2022 23:18:36 -0700 (PDT)
Received: from localhost.localdomain (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id z11-20020a170902cccb00b00173cfaed233sm7296332ple.62.2022.09.12.23.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 23:18:35 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, greentime.hu@sifive.com,
        conor.dooley@microchip.com, ben.dooks@sifive.com, bp@alien8.de,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v5 4/7] soc: sifive: ccache: reduce printing on init
Date:   Tue, 13 Sep 2022 06:18:14 +0000
Message-Id: <20220913061817.22564-5-zong.li@sifive.com>
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

From: Ben Dooks <ben.dooks@sifive.com>

The driver prints out 6 lines on startup, which can easily be redcued
to two lines without losing any information.

Note, to make the types work better, uint64_t has been replaced with
ULL to make the unsigned long long match the format in the print
statement.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
Signed-off-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/soc/sifive/sifive_ccache.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/soc/sifive/sifive_ccache.c b/drivers/soc/sifive/sifive_ccache.c
index b361b661ea09..17080af7dfa0 100644
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
+	pr_info("CCACHE: Index of the largest way enabled: %u\n", cfg);
 }
 
 static const struct of_device_id sifive_ccache_ids[] = {
-- 
2.17.1

