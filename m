Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAAEA5A081B
	for <lists+linux-edac@lfdr.de>; Thu, 25 Aug 2022 06:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbiHYEkH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 25 Aug 2022 00:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbiHYEjt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 25 Aug 2022 00:39:49 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644139E0F3
        for <linux-edac@vger.kernel.org>; Wed, 24 Aug 2022 21:39:31 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id bf22so19116640pjb.4
        for <linux-edac@vger.kernel.org>; Wed, 24 Aug 2022 21:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ev+//6osdR20vXmjWVObFi6l/lAHjsPO3JFHLib7qgk=;
        b=VbuUYXbO7e5MzGlXMzi2enXFgW1KN4hN/nL+aVWGyDW8ItLK1OiZEOIEqXagAWVRev
         +8+Vj2xgGZ0tHQLU2vVpoBg0s0sMYlF7y9ktoFJgEy1GOd56dS1tQvmSQGBD+Wwz+0mn
         ViPZYRK/fs/n2NhohftHfFvqTA0OZWPDWbmhOviAe1DAM06qoAj02iyB5sIrlR+a12vw
         w1ckz3RwjHhJBjVC1rA6qqf84ZjEVtTP5sS51YW6EPx3juwsW+OCjaWUJShdMwhn0rxI
         H+v6q+XVrIfMCpV2cA9lVzgpzwT+EZKIJTvJvtNgkC3TL2JYsR+cdCG4W1HmgQKClg9f
         7IWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ev+//6osdR20vXmjWVObFi6l/lAHjsPO3JFHLib7qgk=;
        b=C51kGiA6VtKmI/Lf2UBLZUMjLTYbpk5rnLT5/bVVcqcmMAAsnUdxvx8OJ+ifNLj7RH
         9VzJBpJa042UfGh6gq/BPJPn0xDy/Gvlk12hCuWaeElwOzgPCQenLq2o1dCwR6ir41/v
         0eNZM/k2f3IKBf0M79VgMFzMRF3pr7kMrFzInapprZBJRoRUoZpsmsUr3iwC3xjlJ4Cb
         tuiGIuBeQMihcS0Kg7sD3t+1y/z4Bvr8aJiDPXB5HHafjchyfZ3zHXlWgPhu59YXurBI
         1uSB0okb7o4tTSFdXilccwEjeR/q8fMSmtiq2bbYCrq0FlOFnzXHyABxlzQ7gsMKLbKT
         5lhA==
X-Gm-Message-State: ACgBeo1O3B59I1QZkCFMlKK3TS2lFyKJgr+jY+06oftoLmPLFeOgYSA+
        LYNAwFou6qsHbK+euOIEPmhV
X-Google-Smtp-Source: AA6agR7uSvrEL9loMv2SaYVbtilMYhslUHMb+lZ4qjEowHtxCfa+nmdlp4yNcRWxe4e/wF7QWpJ5iA==
X-Received: by 2002:a17:90b:1b4a:b0:1f5:5578:6398 with SMTP id nv10-20020a17090b1b4a00b001f555786398mr2609753pjb.122.1661402370341;
        Wed, 24 Aug 2022 21:39:30 -0700 (PDT)
Received: from localhost.localdomain ([117.207.24.28])
        by smtp.gmail.com with ESMTPSA id i11-20020a17090a64cb00b001fa9f86f20csm2294296pjm.49.2022.08.24.21.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 21:39:29 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bjorn.andersson@linaro.org, bp@alien8.de, mchehab@kernel.org
Cc:     james.morse@arm.com, rric@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_tsoni@quicinc.com,
        quic_saipraka@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 5/5] MAINTAINERS: Add myself as the maintainer for qcom_edac driver
Date:   Thu, 25 Aug 2022 10:08:59 +0530
Message-Id: <20220825043859.30066-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220825043859.30066-1-manivannan.sadhasivam@linaro.org>
References: <20220825043859.30066-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The current maintainers have left Qualcomm and their email addresses were
bouncing. Since I couldn't get hold of them now, I'm volunteering myself
to maintain this driver.

Acked-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8a5012ba6ff9..026dd33b106c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7432,8 +7432,7 @@ S:	Maintained
 F:	drivers/edac/pnd2_edac.[ch]
 
 EDAC-QCOM
-M:	Channagoud Kadabi <ckadabi@codeaurora.org>
-M:	Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
+M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 L:	linux-arm-msm@vger.kernel.org
 L:	linux-edac@vger.kernel.org
 S:	Maintained
-- 
2.25.1

