Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD1D645BE4
	for <lists+linux-edac@lfdr.de>; Wed,  7 Dec 2022 15:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiLGOCa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 7 Dec 2022 09:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiLGOBZ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 7 Dec 2022 09:01:25 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D4E5CD20
        for <linux-edac@vger.kernel.org>; Wed,  7 Dec 2022 06:00:43 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id w37so16457865pga.5
        for <linux-edac@vger.kernel.org>; Wed, 07 Dec 2022 06:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HXFRaipNAA/3SVXX4rMylP7rXb8WAB5NgKEFsbHAGk=;
        b=mIbtkx5ZYYnroshvQ2t9MPgSjjE3QsY4ZeLxclpuzT+W76Iwc3E11RHLejCqci1+D9
         9WtB0A54+LWedD3UwQkLkB7LEmqvAY19WypkTGi+TXwbf/fjH/kk4nLeRLs7zVaYUvbA
         t23Qsx47tB0Fi00bZVv6ftKAJpO+PHeY+S218JUg5vGPFUYP0/ZAfmKzO4vuBt+5nohQ
         kDZLJJN+R/wPCeKIRBKNg3Z4/aCacZsBCsm2lZSKTbEG+tunELjGU+pfhRlSfAvJqoJj
         MEBna6VUxY/BmXsUnS8lGe8zjELxJoq3DwXBJkJSvs85ARPApD8fxgKplvqbznD442t4
         AedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4HXFRaipNAA/3SVXX4rMylP7rXb8WAB5NgKEFsbHAGk=;
        b=PiTMxxo10aHZZ3AIwZ3ChKBzaSKWI67XIuy120IcqxjYoyiWC4pjBI94R31YB90xtU
         AgNG9DPyLiVLL8TjLDVMntUtlT/KrhmXCjUHLh8o3akitYsm1Tj2SkEj0+1Lc28rvcc9
         b5RhHx0YfPw3MI/UglWItVkiNc8or8uXLWDvpd9Ee/jb4HUaXkdSGJh/BATO+quVAYzM
         oUeH/6WXm7Oi0cOUMdi7HDd7cxUSQdRTOp1B1+67UHchWoYr4nhEsn16FSFMZA8knErf
         1fFdgV8BfXKKgkb+etki+hq8HQt4/1QVQKl0yo4o6p6kijgYl897fRES9wIgjWAHQcdN
         xTEA==
X-Gm-Message-State: ANoB5pmYaDDXpAudK4eb7nopobdvJsb52Zg+Nj6WII027Fu7CabSmBc2
        ae7h4YzWZBVgj2ATh9Omc5xP
X-Google-Smtp-Source: AA0mqf6PkeIpX8wdc7FSgLEftKEzJvmNEAp1iukvNMuqhE5V8GCSkPkULyLzQqbsPZY9MO2mkEQy8w==
X-Received: by 2002:a63:eb16:0:b0:477:6fe1:cd6d with SMTP id t22-20020a63eb16000000b004776fe1cd6dmr69810826pgh.334.1670421639019;
        Wed, 07 Dec 2022 06:00:39 -0800 (PST)
Received: from localhost.localdomain ([117.216.123.5])
        by smtp.gmail.com with ESMTPSA id c18-20020a170902d49200b00186b69157ecsm14720160plg.202.2022.12.07.06.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 06:00:38 -0800 (PST)
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
Subject: [PATCH 10/12] arm64: dts: qcom: sm8450: Fix the base addresses of LLCC banks
Date:   Wed,  7 Dec 2022 19:29:19 +0530
Message-Id: <20221207135922.314827-11-manivannan.sadhasivam@linaro.org>
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

Cc: <stable@vger.kernel.org> # 5.18
Fixes: 1dc3e50eb680 ("arm64: dts: qcom: sm8450: Add LLCC/system-cache-controller node")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 570475040d95..12549a2912c6 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -3640,8 +3640,11 @@ gem_noc: interconnect@19100000 {
 
 		system-cache-controller@19200000 {
 			compatible = "qcom,sm8450-llcc";
-			reg = <0 0x19200000 0 0x580000>, <0 0x19a00000 0 0x80000>;
-			reg-names = "llcc_base", "llcc_broadcast_base";
+			reg = <0 0x19200000 0 0x80000>, <0 0x19600000 0 0x80000>,
+			      <0 0x19300000 0 0x80000>, <0 0x19700000 0 0x80000>,
+			      <0 0x19a00000 0 0x80000>;
+			reg-names = "llcc0_base", "llcc1_base", "llcc2_base",
+				    "llcc3_base", "llcc_broadcast_base";
 			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-- 
2.25.1

