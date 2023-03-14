Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89F76B8A89
	for <lists+linux-edac@lfdr.de>; Tue, 14 Mar 2023 06:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjCNFiI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 Mar 2023 01:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjCNFiH (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 14 Mar 2023 01:38:07 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C2E5708E
        for <linux-edac@vger.kernel.org>; Mon, 13 Mar 2023 22:37:55 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id z11so9003807pfh.4
        for <linux-edac@vger.kernel.org>; Mon, 13 Mar 2023 22:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678772275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/ORW+ZG5QT+TPocYHNFiE88/XBOJZ36UEuAeSGiS3k=;
        b=KgC3W5IDzN4LUdbRT3iFN7d0cAncrE4n8ln/gf+4ncvZddm2JS9mfUvfgLPL/FXDH0
         YQpXC5an/SOmxd+w9D63Th+6q0X2rbD8JRL9W8t6Bs8TRsqcZF+UaneG/qXuxKngLkjT
         0c65N4SjLlCgGEsmbgUOll4b54vbIFmkTjmwJ3ZVkR2NWnspsczsGtkTdjw9Hg/9Yb2O
         ijJuyLzi7FEoConmYfLnmjSxknrXksP6K2RDG/Yi8SIia2xyTqHx37ppbXvU01sr45Jq
         +UO6gJgBexQ6SnagtqQp7cKP+6K/KE8UbRktjMinGIsmWmlAz2sEEduIJ+zMu0RuX+7M
         mYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678772275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/ORW+ZG5QT+TPocYHNFiE88/XBOJZ36UEuAeSGiS3k=;
        b=xzznjvku2kVzusmZ3ocMj0s3HUoERzsKP1fC7gXjWcmWVRuhFd+NhARR2GyykBd9rW
         hzyS5LTc7L0+2nvSUDDHJNWViwXaC34Yj5V4z7pANrwQlqEFx0S4v3X7HEDX/YgWdQmU
         20U/wz4N9FPKqdS+NBe5P+IXWlsY070GmKvBAOApGReKqVjqFrPdUWrTTY/oFm+JWghC
         Ja90kf42qnWfXMowv2/EpeBZU6i3igOTrH5I3uHrOQub5PJbp1aHJbDUbkwrADKOhwQS
         Tn8V5QB9K1K9SwjNPgDzSJiO5p6rNYdm3tgobcAsZTaMSelnfsnXofL8FpIEmwrKV0Ig
         pNHQ==
X-Gm-Message-State: AO0yUKVywd8HyxPG60FNwqH221adjjPSKxBtm2BDuiLwW40qZPCeauI2
        7EE4A5grEFAALc16seMkTOUNd3y0xPB9IP856Q==
X-Google-Smtp-Source: AK7set9Fuyifr5nJGCwVnScD/xsLUCrzuCB4Xh9lAxf7L1n3LAu3JaOKm6JqLiJs2lfcX2ghWLxPDg==
X-Received: by 2002:a62:3142:0:b0:5dc:ecea:f650 with SMTP id x63-20020a623142000000b005dceceaf650mr27802545pfx.19.1678772274844;
        Mon, 13 Mar 2023 22:37:54 -0700 (PDT)
Received: from localhost.localdomain ([117.217.177.49])
        by smtp.gmail.com with ESMTPSA id n126-20020a634084000000b005034a46fbf7sm675093pga.28.2023.03.13.22.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 22:37:54 -0700 (PDT)
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
Subject: [PATCH v7 04/13] arm64: dts: qcom: sc7180: Fix the base addresses of LLCC banks
Date:   Tue, 14 Mar 2023 11:07:16 +0530
Message-Id: <20230314053725.13623-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230314053725.13623-1-manivannan.sadhasivam@linaro.org>
References: <20230314053725.13623-1-manivannan.sadhasivam@linaro.org>
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

On SC7180, there is only one LLCC bank available. So let's just pass that
as "llcc0_base".

Reported-by: Parikshit Pareek <quic_ppareek@quicinc.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index ebfa21e9ed8a..62cc9eb4882d 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -2760,7 +2760,7 @@ dc_noc: interconnect@9160000 {
 		system-cache-controller@9200000 {
 			compatible = "qcom,sc7180-llcc";
 			reg = <0 0x09200000 0 0x50000>, <0 0x09600000 0 0x50000>;
-			reg-names = "llcc_base", "llcc_broadcast_base";
+			reg-names = "llcc0_base", "llcc_broadcast_base";
 			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-- 
2.25.1

