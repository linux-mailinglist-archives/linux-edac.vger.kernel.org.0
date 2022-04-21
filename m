Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66253509B01
	for <lists+linux-edac@lfdr.de>; Thu, 21 Apr 2022 10:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385732AbiDUItS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 21 Apr 2022 04:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242134AbiDUItR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 21 Apr 2022 04:49:17 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF0B9FC6;
        Thu, 21 Apr 2022 01:46:28 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id ke5so965570qvb.5;
        Thu, 21 Apr 2022 01:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UZh4MY/2R5eISAmSfJVUbQVxZvSpTsAmRbo12lyNp+Y=;
        b=JSUjsJwNN9Bd+GoVlRLzunG1TIxSiRaMaWWAKRSiuHUWyH+6qzuvJ3msCWpeRdR9Cd
         se/THwi9Jxuun82VOfeIQr3JCyIBGjxnJmmwp3sF9OKu1bMNHvg2b7Uqk2gLKHjlPQra
         fbvwsTtpd9qxHcTU0lGoendt7Cq+bRNpZO3uBRldh6WsQPw0B9LaFtWtuVGPgXvrfXi3
         xCD9pc1/9bUd5CZ5VD7ftOYdANzCCEZhHZAA8u/DL9vuoPRpnY4Sip8O+NKbGCsB/KbA
         W8YJSIKRymeUl533cEZQpI+FqclI7j4SeqpW5O4xkMTXsCL3hMaIzXUpDPZ/fFXMG8BM
         4nXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UZh4MY/2R5eISAmSfJVUbQVxZvSpTsAmRbo12lyNp+Y=;
        b=RfJCbj4sodzG9eIFYqMepDdU8wLgoaA41sUf5b+R8GpjwynLXUD/2XFxXOL8WzOjbX
         5i7HbDAkomMJOW8keXHzKY5Tx0MwJNAdWwSxSzTzY7CshZMMsafBWLbr3znGvj22QUuz
         budzfLIUyioNgA24yxjtqZILSSZAjKrucuy71haXNB1FH0TpfSLtywYdNWj+eQ5/7ZEb
         wrA3MJUDVhhrM8dR+DMzvIawK8Dh1ibuXnytEo7DQvK4ejDQf5ItAm6qhLsQT9jSr0Jd
         Mi8xLNGzPhJd+0EtW05pXD9r8h53ecSbeMYUNeI1AGW9T8kO4MVpl6E332HR5eanTOE7
         IjVg==
X-Gm-Message-State: AOAM531+2EE/lYLNr8vwz5u67XPGU1LL6CMhEc1kYwMMlXEyBiebcI5n
        It5DkO8nrCbDjKZwk3OiESc=
X-Google-Smtp-Source: ABdhPJz/uZjNWpGGJwPoCcwggoSkBKIRATg/aOwju0Nfxyu4JqMQTCluCcaY3mV9rzj990NEAjl/HA==
X-Received: by 2002:ad4:5c64:0:b0:446:3bf6:f116 with SMTP id i4-20020ad45c64000000b004463bf6f116mr18237533qvh.115.1650530787708;
        Thu, 21 Apr 2022 01:46:27 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id k189-20020a3788c6000000b0069c10860b10sm2547183qkd.107.2022.04.21.01.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 01:46:27 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     jlu@pengutronix.de, bp@alien8.de, mchehab@kernel.org
Cc:     tony.luck@intel.com, james.morse@arm.com, rric@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] edac: Make use of the helper function devm_platform_ioremap_resource()
Date:   Thu, 21 Apr 2022 08:46:21 +0000
Message-Id: <20220421084621.2615517-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Lv Ruyi <lv.ruyi@zte.com.cn>

Use the devm_platform_ioremap_resource() helper instead of calling
platform_get_resource() and devm_ioremap_resource() separately.Make the
code simpler without functional changes.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/edac/armada_xp_edac.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/edac/armada_xp_edac.c b/drivers/edac/armada_xp_edac.c
index b1f46a974b9e..038abbb83f4b 100644
--- a/drivers/edac/armada_xp_edac.c
+++ b/drivers/edac/armada_xp_edac.c
@@ -286,17 +286,10 @@ static int axp_mc_probe(struct platform_device *pdev)
 	struct edac_mc_layer layers[1];
 	const struct of_device_id *id;
 	struct mem_ctl_info *mci;
-	struct resource *r;
 	void __iomem *base;
 	uint32_t config;
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!r) {
-		dev_err(&pdev->dev, "Unable to get mem resource\n");
-		return -ENODEV;
-	}
-
-	base = devm_ioremap_resource(&pdev->dev, r);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base)) {
 		dev_err(&pdev->dev, "Unable to map regs\n");
 		return PTR_ERR(base);
@@ -516,15 +509,8 @@ static int aurora_l2_probe(struct platform_device *pdev)
 	const struct of_device_id *id;
 	uint32_t l2x0_aux_ctrl;
 	void __iomem *base;
-	struct resource *r;
-
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!r) {
-		dev_err(&pdev->dev, "Unable to get mem resource\n");
-		return -ENODEV;
-	}
 
-	base = devm_ioremap_resource(&pdev->dev, r);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base)) {
 		dev_err(&pdev->dev, "Unable to map regs\n");
 		return PTR_ERR(base);
-- 
2.25.1


