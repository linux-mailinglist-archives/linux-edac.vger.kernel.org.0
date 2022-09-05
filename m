Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30ABD5ACDB2
	for <lists+linux-edac@lfdr.de>; Mon,  5 Sep 2022 10:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237781AbiIEIdM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 5 Sep 2022 04:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237747AbiIEIcg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 5 Sep 2022 04:32:36 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E2150045
        for <linux-edac@vger.kernel.org>; Mon,  5 Sep 2022 01:31:51 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id m2so7881957pls.4
        for <linux-edac@vger.kernel.org>; Mon, 05 Sep 2022 01:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=HegVDwbwdx7NAusLYsMykpD/qEuT4JpSnYO/rlTbGxI=;
        b=aD8U5Io3OoxXQycA2E/XrSpXhrDZWnOitDIAExLsNLwS71FDEoPQQAl6KhpjPqcLp1
         hrGHpZgt89aYD5cf8yebwHeLzegfd3Pev6ZFmtuleGtNs27UntabRVGWVEm6mS6rM6Zj
         eYc58IE43GT2FlhHAZteW/hj/bK1AZmlsNNjPUkli5IsAM/VdhnQH48MhSseV6Hqj9Gy
         A0ssJHtWErt8dNVzGQswEtmPgokxkkNrCHaLBwTTLMCQMnzHncxPCOfUA5PXCzHetMNO
         H5SBpTUSeyQ4Z66XqmYAmAUSfNyJ8mpJJwE+tpo/rcnx7ZZ6Kiv2mvmbPZfO0lueCdvu
         zsgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=HegVDwbwdx7NAusLYsMykpD/qEuT4JpSnYO/rlTbGxI=;
        b=Cw0Y6+pNrzqAGDU73/RpHw5Al1Kwz6rlaRjMGNuMKmnOgMWPOGIVIp4f9/3REPq98l
         A47SBj7RDShYi+NeZnkw54JbV1KSup5XMvpck3PopBLifGyP45RqcDqYX3WTfaRX03u7
         6vv8IpBkINSwLV+yzzTVmd6v8OoyGZKdyzFTViJnYEKR2mqtqGKG8SVjQMcWz1HqyX/f
         WEW4vgOwxfs1UC8KdyfGu9rrrjLzRfU+2j3iuCnQ655QXUHMEsUBmuVCTzTAugBobhIs
         7ItnaFyA17GdLI53CXh79/j12vJoYpIxa61g2ciCYAkUjrK9+Q8kZK/YOna3EDdWTI4J
         Mz4Q==
X-Gm-Message-State: ACgBeo02n8sOOA+GrMcnoJPFqw3fuTsXpRTtAOpN1teCoSjaUIRq9JES
        tnlwgvxh4rFP3loIhRVE/Nck6w==
X-Google-Smtp-Source: AA6agR4pHdfSbuKPjwJoHOYX5Z1xOFxftCcI/m+BGzP79RMUUHwyVC1NXoKympMNV/uj8PE+r/2RBg==
X-Received: by 2002:a17:902:d486:b0:16f:15a1:6da3 with SMTP id c6-20020a170902d48600b0016f15a16da3mr48626724plg.134.1662366710366;
        Mon, 05 Sep 2022 01:31:50 -0700 (PDT)
Received: from localhost.localdomain (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79423000000b00537dfd6e67esm7089721pfo.48.2022.09.05.01.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:31:49 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, greentime.hu@sifive.com,
        conor.dooley@microchip.com, ben.dooks@sifive.com, bp@alien8.de,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v2 6/6] EDAC/sifive: use sifive_ccache instead of sifive_l2
Date:   Mon,  5 Sep 2022 08:31:25 +0000
Message-Id: <20220905083125.29426-7-zong.li@sifive.com>
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

The sifive L2 has been renamed to sifive CCACHE, EDAC driver needs to
apply the change as well

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/edac/Kconfig       |  2 +-
 drivers/edac/sifive_edac.c | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

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
 
-- 
2.17.1

