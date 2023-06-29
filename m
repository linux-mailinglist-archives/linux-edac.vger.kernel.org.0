Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407F4742510
	for <lists+linux-edac@lfdr.de>; Thu, 29 Jun 2023 13:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjF2Lka (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 29 Jun 2023 07:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbjF2Lk1 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 29 Jun 2023 07:40:27 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53773593
        for <linux-edac@vger.kernel.org>; Thu, 29 Jun 2023 04:40:24 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-40278c8e0d2so4723121cf.0
        for <linux-edac@vger.kernel.org>; Thu, 29 Jun 2023 04:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688038824; x=1690630824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HKN6y+Yme4LnNcNw5JJa1Qb1/ewFmkxJyUzKDzF0tQk=;
        b=Tb6J/Wx7LzFpfDygjRmJ79R0VTF+puET5JA3QJoGEY0AWE5jnPGr+TDJTFNcu6NSOc
         rFqoH7fxPLcPx4sj9V/o63hwx8vgL+HLiKKeroZoPvZ2cRw+URuvUI0Ftegvd1fdAxeP
         bLnPdt7z2nqhH/Pw+UhR+QMB8JCod/MnuYGZNI0hppoY4Ht/uzfdrpguTgrbEyjdQOQk
         c1F5cT2YZEwJ3p0KCavutdCafgu1s2BG34RAl2hPY2nTIrkNqO2+98qAbqoDxlBe7Rox
         IKx7e6bMiXeHbM5A8llrj0TAUiGSYuIhaLPEYZFXjuj6vxXeoxz5zrD9nVXnPhlJz6RN
         MuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688038824; x=1690630824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HKN6y+Yme4LnNcNw5JJa1Qb1/ewFmkxJyUzKDzF0tQk=;
        b=FVV6kFf+GYdsuwunzugdSRtV3Nkph44Ed+01c49XIspHSAKZXHLxlH+Yj1GC7L3REb
         qctppPxKNRJDc8qu7HIDnPuLjU38QEga0calnCs2mXaslXaxGXu+j6YoGfOh/zT8AUmw
         IuKpGz162tBye53eDk1L4emAX77InfSDkuKsOa6wtkP8gUs85hBcx9dOkbiX2FZyXp0x
         aDPRaaIcxM6j6PSw+jHebbL3Y5gvjEF8ic8Y/xy4SG0xIDuVnhF6qaFulkk7LGs/I7aF
         NOqJZF0yOxdbqabYSmfBxXx2cQbPh3t3iVNqwDPKXWrDKsF1uSp5cSc5LV6OwEOeqF4A
         ynSg==
X-Gm-Message-State: AC+VfDwMhaZ852v5eckqoQdcK+K/L3Jb4FzqJznd2aOm+2xb015ekobf
        St37YHIdjRhg5ey6rso4fAU=
X-Google-Smtp-Source: ACHHUZ4TI7hU+/EI4O1cOi0MAyRPbIeE2c7KZb63lI6pFy4dlg2LFnv6QcXUOdqt29uRgOuRS2Jglw==
X-Received: by 2002:a05:622a:1a20:b0:400:86fc:f979 with SMTP id f32-20020a05622a1a2000b0040086fcf979mr21930127qtb.58.1688038823783;
        Thu, 29 Jun 2023 04:40:23 -0700 (PDT)
Received: from chcpu17.cse.ust.hk (fc3kcs10.cse.ust.hk. [143.89.191.124])
        by smtp.googlemail.com with ESMTPSA id t2-20020ac865c2000000b003f6b58b986fsm7166728qto.41.2023.06.29.04.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 04:40:23 -0700 (PDT)
From:   Yiyuan Guo <yguoaz@gmail.com>
To:     shubhrajyoti.datta@amd.com, sai.krishna.potthuri@amd.com
Cc:     bp@alien8.de, tony.luck@intel.com, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org, michal.simek@amd.com,
        linux-edac@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        yguoaz@gmail.com
Subject: [PATCH] Fix an off-by-one buffer overrun in inject_ue_write
Date:   Thu, 29 Jun 2023 19:39:33 +0800
Message-Id: <20230629113933.4112456-1-yguoaz@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Signed-off-by: Yiyuan Guo <yguoaz@gmail.com>
---
 drivers/edac/zynqmp_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/zynqmp_edac.c b/drivers/edac/zynqmp_edac.c
index ac7d1e0b324c..bd9c1ff4b5e9 100644
--- a/drivers/edac/zynqmp_edac.c
+++ b/drivers/edac/zynqmp_edac.c
@@ -304,7 +304,7 @@ static ssize_t inject_ue_write(struct file *file, const char __user *data,
 	if (!data)
 		return -EFAULT;
 
-	len = min_t(size_t, count, sizeof(buf));
+	len = min_t(size_t, count, sizeof(buf) - 1);
 	if (copy_from_user(buf, data, len))
 		return -EFAULT;
 
-- 
2.25.1

