Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3AF96541A4
	for <lists+linux-edac@lfdr.de>; Thu, 22 Dec 2022 14:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235438AbiLVNSq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 22 Dec 2022 08:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235547AbiLVNSN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 22 Dec 2022 08:18:13 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD612B638
        for <linux-edac@vger.kernel.org>; Thu, 22 Dec 2022 05:17:57 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id w20so1960252ply.12
        for <linux-edac@vger.kernel.org>; Thu, 22 Dec 2022 05:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4GFA6I79C1YmmOYQX1BIX7MOGuUjMMgmSjlJ7uhFCjc=;
        b=KyqAKH9suEnSST6nGHfrF6tiq5gOyxJrohsSocczxR2yYtSwc4itB7Rwfc7SH8NQLf
         BOPZJAR/M5OHetigMOlkHgsIEqWFC+GZdcpTBQGve1FYMPv1J3bDllxaG/kYFe48R3kZ
         rkszrwUINRgXb7Td2fzluU97ArKf/8mB1NDMjLIUKHoEEbIeT8GPsj8E4Ny3qEZBPheS
         uYLvV3c5hS6z+vjOmzfvNLSasQIo7ZLkLBKmN+fyEWCGfW90yyMw9m4HJgs6DIfQhYWn
         JzXWbNAb3RUKYta7ThAlAjFkiNAyQDrz5AndikCMq+Mdx+pYaM3bf4ikeORkaz/Rfb+k
         eOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4GFA6I79C1YmmOYQX1BIX7MOGuUjMMgmSjlJ7uhFCjc=;
        b=a/uuP52q+ms4qRiJYp2ndB3Me11e8HXHLsEEOLaHpCsy4n9jItOatlUMkdzILHTt1v
         RQatxfHAiI5ozYNAFHK25peERu4vD6JO/KM4wfPX6iGr0PtTtksdxJ/+joJOmiMXLbSr
         bqcSgrIlyjE7HNperWvsBXdUagFKg/WaP+uV18dsUU1yOvtG0y5DmGU/37vf+oHtWCpR
         qm7iCP5hvmrSEmzGCtoMhGYYDJgIQbJx1lAARtJwU6P8J55GwSnLxpzc7SC+0gwghRMt
         KX+EzdfubJN+b9yY+0c4gToa0nH4VF6wN/o0VcQIiCBywcY8llvsqfAKSekQ1uG+vrWy
         PdWw==
X-Gm-Message-State: AFqh2kptVzGwXaKZosV0+q4Op7ILbmmovybK6P3OhUdl7AhIfTRSEABg
        eHcSq9Qmac94wJvTZs5cPOnc
X-Google-Smtp-Source: AMrXdXsatbDMtdO3R2ucECYmD9QW413oKPw0txMOMDN+VIJ/fone11nOH6I7fduVKUAJ3Wo/Y3UYXg==
X-Received: by 2002:a17:903:228a:b0:191:217f:b2ea with SMTP id b10-20020a170903228a00b00191217fb2eamr8592642plh.40.1671715077246;
        Thu, 22 Dec 2022 05:17:57 -0800 (PST)
Received: from localhost.localdomain ([117.217.177.99])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902fe0c00b001896040022asm491570plj.190.2022.12.22.05.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 05:17:56 -0800 (PST)
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
Subject: [PATCH v4 04/16] arm64: dts: qcom: sc7180: Fix the base addresses of LLCC banks
Date:   Thu, 22 Dec 2022 18:46:44 +0530
Message-Id: <20221222131656.49584-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221222131656.49584-1-manivannan.sadhasivam@linaro.org>
References: <20221222131656.49584-1-manivannan.sadhasivam@linaro.org>
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

On SC7180, there is only one LLCC bank available. So let's just pass that
as "llcc0_base".

Reported-by: Parikshit Pareek <quic_ppareek@quicinc.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index f71cf21a8dd8..f861f692c9b1 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -2759,7 +2759,7 @@ dc_noc: interconnect@9160000 {
 		system-cache-controller@9200000 {
 			compatible = "qcom,sc7180-llcc";
 			reg = <0 0x09200000 0 0x50000>, <0 0x09600000 0 0x50000>;
-			reg-names = "llcc_base", "llcc_broadcast_base";
+			reg-names = "llcc0_base", "llcc_broadcast_base";
 			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-- 
2.25.1

