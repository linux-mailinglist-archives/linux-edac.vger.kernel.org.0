Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647B96B8C87
	for <lists+linux-edac@lfdr.de>; Tue, 14 Mar 2023 09:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjCNIGS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 Mar 2023 04:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjCNIFs (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 14 Mar 2023 04:05:48 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D447A92E
        for <linux-edac@vger.kernel.org>; Tue, 14 Mar 2023 01:05:40 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id i5so15723392pla.2
        for <linux-edac@vger.kernel.org>; Tue, 14 Mar 2023 01:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678781140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KbEuZ8x9epY4wczXQcJX335FU4iMuAmx2Igvv4w4MY4=;
        b=Blim+bsjx7tnv55ZAmyMK4xpeetRd1ob3PM+2hfLojx4GQETr1DfWSUnWWUKg6fUWB
         aV+mvGSKBiDPcJfzfudmySE5WvreMfMr82z5e83ZVzgXWikdTAKKJW+cb7M5UqPpNVTa
         Vv3zZYi3w9waz8r4TUZeklnpybTq8ynW6Hh4+KfKYnz+a26sKLrTAVRb0CIXEq7ekf9D
         ABuCuqgprYHWWBMfU+ru4yysX7E9KHCQFAyXKnQLl6DZaqBCcNY7XJkzOvCtUxBycs9J
         2/t8NgTkaxzlCCvGG1gJ/xxL6R5UOxA/fZ3FwfRNLnATShINDVLM2B/DEXeFU6k7pU+5
         +sYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678781140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KbEuZ8x9epY4wczXQcJX335FU4iMuAmx2Igvv4w4MY4=;
        b=rVwKjzjht4M+dvnX0Gg07++TpBVec6fdwsaEpABH2tD0itiFW4VdXqWjxEDhA3CGeq
         NymzEjCjxcLVfMLiUgXIkmljS9cdcyvbK3fXd32f5R4KsQqTpSmVM77lYuaEiF6qJnlJ
         Ni088kGV0qtL5pIz2TSWJQ0x2k6Mpej7grLfX6yTepyg9ggyeXuI3fEvxHbQJUN6Ih49
         TOs/79lhdJ0SjpinK0L+NCdfp0ptD1oSgR6d5XWzhjr6b6yujnNXbaOaeBLrsKlgpv00
         hme5PMYfp8UEoo1JjtXqaJ/2orVgSm8RqGwK+Pogh2yFvStlXSONcKcKJZMFEgM15W5G
         EXvw==
X-Gm-Message-State: AO0yUKWw6V25CwgDp5GENI/Stz37oaGOSDqrRnBn2pDWIAikvrd7pPh6
        y5hIYaWKjsSCGD8yCQpUC0lB
X-Google-Smtp-Source: AK7set/DOXIH1oI5YDQIcuXZ+wY4Pk/bm/WyjYGwuD9JQbSpO3V6BW9gePdkEHh82bqspSSNBbcBQA==
X-Received: by 2002:a17:90a:19:b0:23a:ad68:25a7 with SMTP id 25-20020a17090a001900b0023aad6825a7mr29838033pja.2.1678781140382;
        Tue, 14 Mar 2023 01:05:40 -0700 (PDT)
Received: from localhost.localdomain ([117.217.177.49])
        by smtp.gmail.com with ESMTPSA id l8-20020a170902f68800b001994a0f3380sm1078022plg.265.2023.03.14.01.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 01:05:39 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
        quic_ppareek@quicinc.com, luca.weiss@fairphone.com,
        ahalaney@redhat.com, steev@kali.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v8 08/14] arm64: dts: qcom: sm8250: Fix the base addresses of LLCC banks
Date:   Tue, 14 Mar 2023 13:34:37 +0530
Message-Id: <20230314080443.64635-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230314080443.64635-1-manivannan.sadhasivam@linaro.org>
References: <20230314080443.64635-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The LLCC block has several banks each with a different base address
and holes in between. So it is not a correct approach to cover these
banks with a single offset/size. Instead, the individual bank's base
address needs to be specified in devicetree with the exact size.

Reported-by: Parikshit Pareek <quic_ppareek@quicinc.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 2f0e460acccd..a13cf98b1ac3 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -3559,8 +3559,11 @@ usb_1_dwc3: usb@a600000 {
 
 		system-cache-controller@9200000 {
 			compatible = "qcom,sm8250-llcc";
-			reg = <0 0x09200000 0 0x1d0000>, <0 0x09600000 0 0x50000>;
-			reg-names = "llcc_base", "llcc_broadcast_base";
+			reg = <0 0x09200000 0 0x50000>, <0 0x09280000 0 0x50000>,
+			      <0 0x09300000 0 0x50000>, <0 0x09380000 0 0x50000>,
+			      <0 0x09600000 0 0x50000>;
+			reg-names = "llcc0_base", "llcc1_base", "llcc2_base",
+				    "llcc3_base", "llcc_broadcast_base";
 		};
 
 		usb_2: usb@a8f8800 {
-- 
2.25.1

