Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63F16A795C
	for <lists+linux-edac@lfdr.de>; Thu,  2 Mar 2023 03:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjCBCMD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 1 Mar 2023 21:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjCBCMC (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 1 Mar 2023 21:12:02 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56BC4ECC6;
        Wed,  1 Mar 2023 18:11:57 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id ce7so9201738pfb.9;
        Wed, 01 Mar 2023 18:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677723117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=24xhtn5pOGlNyXauP9v8s38FVO7Lz36wZKCTgeWwtN4=;
        b=A1puC179kyNF2Wi5naOSf/hbfXO+twruywzION9SF7H8pNqSHT3jeLCNFAYpSw3Aog
         dpfrktB9xB+QH23IXEOXUlWzTNneV0B4Fy8PiLrRQcKpS4z6yCf6YecRgdG8mKXuH7iv
         0vagJLMM5QAOsqtP6ZCVHLRvuHI83j+FimPNVSdlvFRp0TsIXgWVR0sr36hh7wupyJGe
         1nXj6cbPcRInL3JzTOS/dkC03hIElT/4Bw8rbbCbZ17OpvayzuvPOQJuan9ZoX09dUzr
         t+Wj/p3bFXXV8hQR6mE2VLZuy/F62VQcoY9EiIgrt9ytT5NNQPrbLUBfC4QY3+38TZZB
         CaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677723117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=24xhtn5pOGlNyXauP9v8s38FVO7Lz36wZKCTgeWwtN4=;
        b=6Kffs3JDjaxIFsxUkLPCynh1oKF/nOzjSaU528HMI9zDATD8ZRfcez8hoLez5NejFf
         OLdcqQ0nAWmc0FSHFMCGGqzfQOdQFlp5phRpNpdXRN3TPqxwfERL8BvnoZXvzTshcR4y
         wI0N6mgVbpsTc5uRwuyCcKAqbO4gmaPVbwl40e4qS7B0b5R99VQPEuAvxWkhD3fRAifz
         opHj/uIc6/SLsNWIH479o8LbgCUBTbp4LtOFIzjNdLJhmml22V1yxMXLuNnout1o2L76
         i6G5PXfgnO4N0EA7RYUjfQ1vkKwR1NTcg25XuGbSp3/kmR+mnWKBvmB747GWt+uenEyp
         wy9g==
X-Gm-Message-State: AO0yUKX0/RSjaZWfv0WC0aU999ecxHyDvRZRnP52um4qdX1vYTWRY7BO
        d0NY4sZ3+3FViA9zJccEhyA=
X-Google-Smtp-Source: AK7set9Jqp6pjTROlUSuAzL5Ondds55aDqug14UYNOrL+KL0YpHWUm1qtHvSA58NeeZYpLKcDTlFfA==
X-Received: by 2002:a62:25c4:0:b0:5ec:702c:5880 with SMTP id l187-20020a6225c4000000b005ec702c5880mr6585839pfl.32.1677723117167;
        Wed, 01 Mar 2023 18:11:57 -0800 (PST)
Received: from localhost.localdomain ([61.72.178.125])
        by smtp.gmail.com with ESMTPSA id b1-20020a6567c1000000b00502ea3898a7sm8093777pgs.31.2023.03.01.18.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 18:11:56 -0800 (PST)
From:   Jongwoo Han <jongwooo.han@gmail.com>
To:     bp@alien8.de, tony.luck@intel.com, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jongwoo Han <jongwooo.han@gmail.com>
Subject: [PATCH] EDAC/i5100: Fix typo in comment
Date:   Thu,  2 Mar 2023 11:11:20 +0900
Message-Id: <20230302021120.56794-1-jongwooo.han@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Correct typo from 'preform' to 'perform' in comment.

Signed-off-by: Jongwoo Han <jongwooo.han@gmail.com>
---
 drivers/edac/i5100_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/i5100_edac.c b/drivers/edac/i5100_edac.c
index f5d82518c..8db680b6a 100644
--- a/drivers/edac/i5100_edac.c
+++ b/drivers/edac/i5100_edac.c
@@ -909,7 +909,7 @@ static void i5100_do_inject(struct mem_ctl_info *mci)
 	 *
 	 * The injection code don't work without setting this register.
 	 * The register needs to be flipped off then on else the hardware
-	 * will only preform the first injection.
+	 * will only perform the first injection.
 	 *
 	 * Stop condition bits 7:4
 	 * 1010 - Stop after one injection
-- 
2.34.1

