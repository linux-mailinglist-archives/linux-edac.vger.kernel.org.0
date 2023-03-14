Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD776B8A9A
	for <lists+linux-edac@lfdr.de>; Tue, 14 Mar 2023 06:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjCNFiv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 Mar 2023 01:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjCNFip (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 14 Mar 2023 01:38:45 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C03F7BA08
        for <linux-edac@vger.kernel.org>; Mon, 13 Mar 2023 22:38:20 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id cn6so1699049pjb.2
        for <linux-edac@vger.kernel.org>; Mon, 13 Mar 2023 22:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678772300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WM/W3mGHWee04PiGhWaePDSEFLq+5Xz9JBoWs5RSs+4=;
        b=JzMSob1P4e3VwB0wL6lNs4Pa+MXu0mZYABvUByRuQD9G3tRF3fed1F70Df/U+C5rnt
         /vjrHfiOXf0cnrJUD+3UiCGbQdM3S2nSrUVZ70QaRO5cUW/xSpS6M9VGjlrB5Hx5txG6
         GjZI+B78ehVktIWhsjYQfYVYNVl8jOp01zhoy5wi+7EkchQkvQ18ZabH5aF2H83kTezH
         ixGX4dRqpYzid8VAn395TqP3IpDv5GdfePsNFytWEnddGeUB5TVWwyEQIBXrDFNQY6G4
         gCzNU2WgUtbhG1pYKg5B7CPJLStTgaDmGHqeSDO9LYsBut6u1qzK9eqbUifxkUNY+1oi
         bZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678772300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WM/W3mGHWee04PiGhWaePDSEFLq+5Xz9JBoWs5RSs+4=;
        b=sBMfMLYoDasqClleQVL2t6isHJwI3Bkxett4pkkle25/Gr3zkd/CVd9lzPJOjdgW6b
         cK3GcmeW+JwNP6bDOGBR2m7Oh+nzQ8qx7tljY6Qtc2EZtWUX2WV6Qqj8ma0zKYPLwph/
         4W4uZPyJ8v4u1n8o9eYSMxiuOzYxx//zcKokbjRVcCRg+1zUlak+Zkg6Bs5szFtRmezQ
         HKJdT9DfUQ2B9zikFe7ytRlZGGl7sQlghH8KSuBpw+FsDJqmDievKVWvgNsVx7uu4I81
         owSK89SMeX3P6NzScsw3QitIG+YCHW+R7wgCKmGMCBlNht7+sCauynpMIV4cbFMTI8Ar
         NllQ==
X-Gm-Message-State: AO0yUKUlrPtQMgbbqf1sb++jp6FylYB8d64um2/sPFk5xHHGxtOMhjq0
        Dm0ge7jQXZ4BEo8MDHGyO9bn
X-Google-Smtp-Source: AK7set+O3FjaSdx4s856WeTSbgqP2xfnipXrZ4jwl5Xpb6TCluAKJ//9cVKxjpInG9aYEZvNf5mARw==
X-Received: by 2002:a17:90b:1b52:b0:22b:b82a:f3a2 with SMTP id nv18-20020a17090b1b5200b0022bb82af3a2mr37908027pjb.11.1678772300272;
        Mon, 13 Mar 2023 22:38:20 -0700 (PDT)
Received: from localhost.localdomain ([117.217.177.49])
        by smtp.gmail.com with ESMTPSA id n126-20020a634084000000b005034a46fbf7sm675093pga.28.2023.03.13.22.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 22:38:19 -0700 (PDT)
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
Subject: [PATCH v7 09/13] arm64: dts: qcom: sm8350: Fix the base addresses of LLCC banks
Date:   Tue, 14 Mar 2023 11:07:21 +0530
Message-Id: <20230314053725.13623-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230314053725.13623-1-manivannan.sadhasivam@linaro.org>
References: <20230314053725.13623-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 1c97e28da6ad..3fefd8cbba6d 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2204,8 +2204,11 @@ gem_noc: interconnect@9100000 {
 
 		system-cache-controller@9200000 {
 			compatible = "qcom,sm8350-llcc";
-			reg = <0 0x09200000 0 0x1d0000>, <0 0x09600000 0 0x50000>;
-			reg-names = "llcc_base", "llcc_broadcast_base";
+			reg = <0 0x09200000 0 0x58000>, <0 0x09280000 0 0x58000>,
+			      <0 0x09300000 0 0x58000>, <0 0x09380000 0 0x58000>,
+			      <0 0x09600000 0 0x58000>;
+			reg-names = "llcc0_base", "llcc1_base", "llcc2_base",
+				    "llcc3_base", "llcc_broadcast_base";
 		};
 
 		compute_noc: interconnect@a0c0000 {
-- 
2.25.1

