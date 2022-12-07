Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB17645BD1
	for <lists+linux-edac@lfdr.de>; Wed,  7 Dec 2022 15:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiLGOA5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 7 Dec 2022 09:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiLGOAW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 7 Dec 2022 09:00:22 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A81E5C74B
        for <linux-edac@vger.kernel.org>; Wed,  7 Dec 2022 06:00:20 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so1510725pjs.4
        for <linux-edac@vger.kernel.org>; Wed, 07 Dec 2022 06:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9kOWESGCOm8k/3B3plmWY9NGaRObo69+HdB8YdZ+wA=;
        b=ivP8EYKN1u/E0xlDkmB/S5OFTYeLn8a9LknTldtd6Cg9xUvnFhbCgJS0L5obXwqn/f
         /AUy9wHbUde2X4wqCDm4w164McIGh4ESzgfwXidJxLPTgSsZm9pdFjg7G3MjQmGpgQO1
         dJ0JmO4IpNY39aqw2hUMqWp9lrdc9uqObpCcs5DnC6UeXUrkzqanCG2qgTw1ReaXsUYK
         6ToT5MCElWbUNXspiD9RXk8nRiySKATCBrtOCGX+rTH8FsO5nfG5lKklW1W42bC30r2q
         nv0YE3LUUBV3LjstJPikWZtS+BEIfSOE7q0JpE6a1h8maHEi7U5QDAgqyHQxwCGK6quO
         +OZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9kOWESGCOm8k/3B3plmWY9NGaRObo69+HdB8YdZ+wA=;
        b=rE8EyLexnSE/BkHyyvI1TX5rpkEHTvtrYwYSs23JsGnht28DWJ7XzD+Qavngh1pZrC
         1QKlhKJDv8zWwO7sfkKrDJ053Ck6YFNpM9eyHe3kry42D9C03w/dCk5fXFZwkQHVAUbt
         YDTjJl5r+qpB6zLZ+x3NrSlfFGnm06mylby5Z2r4t5DGVT/2QP4ic5vcNNNSg3A/YB02
         SZtbfchb5MRCynjMEMYJGNPpkhBIMrddIsTrhmv2JZlOOZJTm3jqDFxNYVkpt7z6xQq/
         cET7AesmThZync5+NydqdNrhE8h3qAKHBSIW1o65T2zYr3joGDvWbKJ+5vp5bfD9S1AX
         Cp2g==
X-Gm-Message-State: ANoB5pmS/nlI86kOe0DE/fF8ZZUvS6rLJg4H0FJKmWIlhsYGP5lQ5PID
        vLsQmwbNzcSpdJOA2qRNIZEj
X-Google-Smtp-Source: AA0mqf4AwPe9fpzGQfibTSxhA18PxtWBruP5oMgZ2woMAV5AASuFCCVCuNhELzdGEdbDpb8bM2efIg==
X-Received: by 2002:a17:902:a589:b0:189:7a0f:703b with SMTP id az9-20020a170902a58900b001897a0f703bmr54474585plb.103.1670421619724;
        Wed, 07 Dec 2022 06:00:19 -0800 (PST)
Received: from localhost.localdomain ([117.216.123.5])
        by smtp.gmail.com with ESMTPSA id c18-20020a170902d49200b00186b69157ecsm14720160plg.202.2022.12.07.06.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 06:00:18 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com
Cc:     quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH 07/12] arm64: dts: qcom: sm8150: Fix the base addresses of LLCC banks
Date:   Wed,  7 Dec 2022 19:29:16 +0530
Message-Id: <20221207135922.314827-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221207135922.314827-1-manivannan.sadhasivam@linaro.org>
References: <20221207135922.314827-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
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

Cc: <stable@vger.kernel.org> # 5.11
Fixes: bb1f7cf68a2d ("arm64: dts: qcom: sm8150: Add LLC support for sm8150")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index a0c57fb798d3..7fd2291b2638 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -1762,8 +1762,11 @@ mmss_noc: interconnect@1740000 {
 
 		system-cache-controller@9200000 {
 			compatible = "qcom,sm8150-llcc";
-			reg = <0 0x09200000 0 0x200000>, <0 0x09600000 0 0x50000>;
-			reg-names = "llcc_base", "llcc_broadcast_base";
+			reg = <0 0x09200000 0 0x50000>, <0 0x09280000 0 0x50000>,
+			      <0 0x09300000 0 0x50000>, <0 0x09380000 0 0x50000>,
+			      <0 0x09600000 0 0x50000>;
+			reg-names = "llcc0_base", "llcc1_base", "llcc2_base",
+				    "llcc3_base", "llcc_broadcast_base";
 			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-- 
2.25.1

