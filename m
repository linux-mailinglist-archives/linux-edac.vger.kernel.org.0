Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121286B8C86
	for <lists+linux-edac@lfdr.de>; Tue, 14 Mar 2023 09:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjCNIGM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 Mar 2023 04:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjCNIFo (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 14 Mar 2023 04:05:44 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2AD8237D
        for <linux-edac@vger.kernel.org>; Tue, 14 Mar 2023 01:05:30 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id cn6so1986847pjb.2
        for <linux-edac@vger.kernel.org>; Tue, 14 Mar 2023 01:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678781129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FI19SzWU19Jvwkg3ef2zRaEcka9BD7PAMWjZH4lQqmU=;
        b=qCnt+YG+qSCaRi++SQygc4LCMyUIQsxhksIdbvNciJyOVAeYykxxs4ROH0hhxvE57E
         QuaZ+ecJcx/P7AQqaoMNSEK3RutjcmXZdn1GlRlUha9fYBb2j4GVrs2WzfgALjIRGEwG
         u7m7iyLjATF5PMDivCktX/K3zQlGAIrn72F78AhCjjNofQd8e4oH0k7l2Hcge0p1npPC
         wMUS8z5W2Ofc6NxtslNY6WWtAauHalb1SpXHXX6OHfI+cUOltmlOt3bgpq/3PUPFoOmS
         hr7iXvJfzjqNVT4p/v8HaK19oMNnyLpJJECozQqNyaPrbESvtrajCpP4dJ1J69Wut8D5
         +cqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678781129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FI19SzWU19Jvwkg3ef2zRaEcka9BD7PAMWjZH4lQqmU=;
        b=gFZq3XRJWwyIdKVLWYOvrZbNDrRpAHXcCMTXlNcLTg5EqELmp/8jyFOm9mIjng/AZa
         JNihUOoDVqoDjaxmOaAnlBHXAB+0Eygw5N7bRTx2vG66Y0EvjQg/ZR17tMsr6I4QjEii
         PsgHAXgELFKQIzygieyUWHISr0jIA/9Y/yZgI6X/IefLgP5eRxJm6OdVE+zekkU1kEzM
         jEbQtxQuEpR61hZWw4Kbt99ag3etcCy8u1JDxjRaU4kSa/f2oZC+wAB3W4ncL8iPHmFE
         9RgSgKsYbmzbewBLQfp03vJG2224SaRJzxC8kSe2HDjPQNtQDGJQU9sEyzASWt9Q0/BA
         McUQ==
X-Gm-Message-State: AO0yUKXI/toQfRrLH3ROhhm35fiMty+ZmmvLkBocv97uFoaySQfSTar7
        LYLq2HzIrRX9A8UGx8vCIfsI
X-Google-Smtp-Source: AK7set9ahRcqSzmMuTWPUwwKEQQs0DkjVKyIH86u9FkvGD/p55MmA5aua1BQ+w63Ue4Pp4Fmbz0P9A==
X-Received: by 2002:a17:90b:1645:b0:236:a4bc:222 with SMTP id il5-20020a17090b164500b00236a4bc0222mr37579028pjb.38.1678781129601;
        Tue, 14 Mar 2023 01:05:29 -0700 (PDT)
Received: from localhost.localdomain ([117.217.177.49])
        by smtp.gmail.com with ESMTPSA id l8-20020a170902f68800b001994a0f3380sm1078022plg.265.2023.03.14.01.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 01:05:29 -0700 (PDT)
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
Subject: [PATCH v8 06/14] arm64: dts: qcom: sc8280xp: Fix the base addresses of LLCC banks
Date:   Tue, 14 Mar 2023 13:34:35 +0530
Message-Id: <20230314080443.64635-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230314080443.64635-1-manivannan.sadhasivam@linaro.org>
References: <20230314080443.64635-1-manivannan.sadhasivam@linaro.org>
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
Tested-by: Steev Klimaszewski <steev@kali.org> # Thinkpad X13s
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sa8540p-ride
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 0d02599d8867..f5262ac64a36 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -2983,8 +2983,14 @@ opp-6 {
 
 		system-cache-controller@9200000 {
 			compatible = "qcom,sc8280xp-llcc";
-			reg = <0 0x09200000 0 0x58000>, <0 0x09600000 0 0x58000>;
-			reg-names = "llcc_base", "llcc_broadcast_base";
+			reg = <0 0x09200000 0 0x58000>, <0 0x09280000 0 0x58000>,
+			      <0 0x09300000 0 0x58000>, <0 0x09380000 0 0x58000>,
+			      <0 0x09400000 0 0x58000>, <0 0x09480000 0 0x58000>,
+			      <0 0x09500000 0 0x58000>, <0 0x09580000 0 0x58000>,
+			      <0 0x09600000 0 0x58000>;
+			reg-names = "llcc0_base", "llcc1_base", "llcc2_base",
+				    "llcc3_base", "llcc4_base", "llcc5_base",
+				    "llcc6_base", "llcc7_base",  "llcc_broadcast_base";
 			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-- 
2.25.1

