Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6881A658991
	for <lists+linux-edac@lfdr.de>; Thu, 29 Dec 2022 06:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiL2Fsi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 29 Dec 2022 00:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiL2Fsh (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 29 Dec 2022 00:48:37 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6151275A;
        Wed, 28 Dec 2022 21:48:35 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so18014833pjj.4;
        Wed, 28 Dec 2022 21:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4W0s6Vcwe3tgxRphK3rNr3wMCLErEs9BbnZK8mgAHes=;
        b=jo5SgIpWKjfwxooVy7t329MfTXrDhgKnkSHOOLgLeY2b9CFSJ81opr6jvlDvDFtPao
         cPWb3MNDVeyz5o2Dt01tyLD1AKzmaZxG75eSXWbOV/VrdM3ldyQpTm3Xwq7uLjLkja9P
         nSt2nt7zhAT5fOZ7xrWP0uhwgkAny6zzh+PUXhGgbieovFgAATQ/M4xE8X+aBNdfGk0D
         oL1nXLYW0MGSaugA7JtdJS3A8RgEI/VFFrnTYxieFq62+pc4zlgirC/gRDQoS2Sll69h
         sGyv7+0sM8/8nh2w28G01+E0Bk+IDII/Xobz1jYpU4MxGOkN45n/a3lTg+hiQf1+Se6j
         WDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4W0s6Vcwe3tgxRphK3rNr3wMCLErEs9BbnZK8mgAHes=;
        b=KXU84YiARrEH33FOIQHsQ0tEFhqEFwnOBaDUtIHi6pcgnSwlm7rrk0pdWTT18w4MY1
         OuXjOgnOVH0MTla9rSOTCp6hi21cx9J5Hio+TrXrhE+GZuinQr441yPGB/S+OusrLrO6
         ez7MxG9jqb22XO8U7EGn2AyKOP1t6Koq7DhshRWGw/fUnBFCQrVAbQ+wqki2jIug51zI
         pEfJEZ0abS9JnJOWmKUV2pjpNCwL+JIvR3cnoAH2cjq/rcOHXaevPQTTXwyhQrpOY/LU
         oVVo4uykWWd9bCDTISE/0fMTdOxgXhbw8eYiEtm6ylvKJ9Em0proodKWwdT1olJezyaE
         JvpA==
X-Gm-Message-State: AFqh2kohPD9o2yXLJHhAUES15wIPo+ImjG5zT2L/teMwZAf9PsdsysLo
        ZdeV3DCxOrqjZLWPpOwjmcI=
X-Google-Smtp-Source: AMrXdXuI4gReujWBOjsXlS/Y8uekhUDShEClQW43vE4X0/gfunRcrnapmR1UA5Q306CRVSk9m708kA==
X-Received: by 2002:a17:902:ab4d:b0:189:d0e1:4fcd with SMTP id ij13-20020a170902ab4d00b00189d0e14fcdmr33476734plb.55.1672292914910;
        Wed, 28 Dec 2022 21:48:34 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id l2-20020a170902f68200b00177faf558b5sm11888274plg.250.2022.12.28.21.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 21:48:34 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Andre Przywara <andre.przywara@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Rob Herring <rob.herring@calxeda.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] EDAC: highbank: Fix memory leak in highbank_mc_probe
Date:   Thu, 29 Dec 2022 09:48:24 +0400
Message-Id: <20221229054825.1361993-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

edac_mc_alloc() allocates memory. The memory are not released
when devres_open_group() fails, which causes memory leak.
Call edac_mc_free() in the error handling to fix this.

Fixes: a1b01edb2745 ("edac: add support for Calxeda highbank memory controller")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
altr_sdram_probe() performs similar operations,
I take it as reference.
---
 drivers/edac/highbank_mc_edac.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/highbank_mc_edac.c b/drivers/edac/highbank_mc_edac.c
index 61b76ec226af..19fba258ae10 100644
--- a/drivers/edac/highbank_mc_edac.c
+++ b/drivers/edac/highbank_mc_edac.c
@@ -174,8 +174,10 @@ static int highbank_mc_probe(struct platform_device *pdev)
 	drvdata = mci->pvt_info;
 	platform_set_drvdata(pdev, mci);
 
-	if (!devres_open_group(&pdev->dev, NULL, GFP_KERNEL))
-		return -ENOMEM;
+	if (!devres_open_group(&pdev->dev, NULL, GFP_KERNEL)) {
+		res = -ENOMEM;
+		goto free;
+	}
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!r) {
@@ -243,6 +245,7 @@ static int highbank_mc_probe(struct platform_device *pdev)
 	edac_mc_del_mc(&pdev->dev);
 err:
 	devres_release_group(&pdev->dev, NULL);
+free:
 	edac_mc_free(mci);
 	return res;
 }
-- 
2.25.1

