Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBE86541B0
	for <lists+linux-edac@lfdr.de>; Thu, 22 Dec 2022 14:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbiLVNTB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 22 Dec 2022 08:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235451AbiLVNSn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 22 Dec 2022 08:18:43 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1042B25C
        for <linux-edac@vger.kernel.org>; Thu, 22 Dec 2022 05:18:41 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so5671372pjr.3
        for <linux-edac@vger.kernel.org>; Thu, 22 Dec 2022 05:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6zR8ugZMMSbsUYzZxGLGG2mvpL7z7iHt3BZjr/IYFc=;
        b=fHwgLHipJ6VLjwey2U5iYiltJ/dLHCb4PBtuCTxZb/HtMgeam3PQsSSXurVr5NCoPr
         CnHT1sEm0hmoKvTrpHTb8UZM78a2rPe29dNvsfcRdX+9eugWKu0FJmO96O2AA1K/yxNz
         LdVLZRPcWdk3DS7UAj/PQRJbPHsdQvj8BUU9uA7gXujhKjixdRwaQV0PLOY+2c+fgndR
         cQSJQ16C5PuHmhhD0r5RESt7CL6pkThxaOQUlEe7IURqgl3IgFLwjSzW9EPIrrw24NjY
         oxzyZfqhQ+GrF3N2LChLB/N5dE4nAPsJ3BgmbHOPsqCMHXkryL1713vr0GEAK+QQdUPO
         3hUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6zR8ugZMMSbsUYzZxGLGG2mvpL7z7iHt3BZjr/IYFc=;
        b=3MyB6M9W7PnZlVi73BnlLMuWS68hxWZR2OV9fXNtzXhtoHcibFwd8a9CRHxrGwbynh
         eD7Hs3t/60oxvGr6IZ78rE1Y7sA2qrJScJRvcStTZJ+/CmqzC6ZFGKGFpdwCSeb/SKNk
         J8CwvXT7WFgDjDj72ddJCVyQ5VPeugucwZFO7PLqp2u4BCzWOv3+ZT66IOGDmNQAu7tr
         E1rQCGlf0rVZ2NUv1VEqv/Hdk14wBjYpJSsJa0KPAfF9LI1XuVv0CjwugwRBjOkptFc5
         1rWpUArIW7biVcsyCOlQCOwY4CF1UBEQXakwnySvBCgXod6IbaPikjHh5wGK/qWsFEng
         qYJQ==
X-Gm-Message-State: AFqh2kp51HVSH2OwjsK1yimQiIMM/Qf4CsGmpT4uKMyNsZa3j1YWM4Hd
        1fdOtNkPncfx2Nhr28VsUjMf
X-Google-Smtp-Source: AMrXdXty/zW+OP48FtSBFLMwFJcA5jtnA64QMT/URaoC+T6Jjl/h9QSTM+RuT3a6uZXE9enr+BDCFw==
X-Received: by 2002:a17:902:8f86:b0:191:282:5d6c with SMTP id z6-20020a1709028f8600b0019102825d6cmr6452823plo.61.1671715121561;
        Thu, 22 Dec 2022 05:18:41 -0800 (PST)
Received: from localhost.localdomain ([117.217.177.99])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902fe0c00b001896040022asm491570plj.190.2022.12.22.05.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 05:18:40 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com
Cc:     quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        luca.weiss@fairphone.com, ahalaney@redhat.com, steev@kali.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 10/16] arm64: dts: qcom: sm8450: Fix the base addresses of LLCC banks
Date:   Thu, 22 Dec 2022 18:46:50 +0530
Message-Id: <20221222131656.49584-11-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221222131656.49584-1-manivannan.sadhasivam@linaro.org>
References: <20221222131656.49584-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

