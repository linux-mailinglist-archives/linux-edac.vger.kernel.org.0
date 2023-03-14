Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956EB6B8A8F
	for <lists+linux-edac@lfdr.de>; Tue, 14 Mar 2023 06:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjCNFiW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 Mar 2023 01:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjCNFiT (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 14 Mar 2023 01:38:19 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086EC1E2B4
        for <linux-edac@vger.kernel.org>; Mon, 13 Mar 2023 22:38:00 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so6537146pjb.0
        for <linux-edac@vger.kernel.org>; Mon, 13 Mar 2023 22:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678772280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3jjAvyClxqCSaG5sOi6OveXFyY33UJ9o9fFaRGOIoU=;
        b=pTopKsVkrmcnJWqtjzZETiBVVfzs36mxPQet1SSc4HmcKIl/9QrxEYG8b3LT4J9hxb
         S++6m5piyCfxh/s+J3V0YdwSE7c+YYV23iZ0mGgr/YL01LCbOCZMEo0vcy/0O/xlytSc
         LagXJ0g5iUX9DCWADWV+i3Zk/rk+wLcMSsytrT5KbHQvuHvToADbxLtkT7wJM4EprV58
         HTOVaBE6y7rMUumLYRa/w/fNNySH2+SlPtDX3hI+f8x5aDoIBVak6k0JWY74QCeore1g
         2gHtZjtXDBo0bmCMlmh4B2iQnapr2JSJss5eKGyKGfIgjDxJ3I/lxtYx4ZRTXx2zTiFk
         lVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678772280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H3jjAvyClxqCSaG5sOi6OveXFyY33UJ9o9fFaRGOIoU=;
        b=D0lurnegOxs9w2sp+THqRRf654uA9UynIZDlJqiOsNdZH6y5hLgju450zcIzsNrNES
         AwjkpHPeW4qnAzJNDq8VdmoA1G7kU+seSjNYaPGxoNzRWC8KjJST/mv4YaHw6p2Ng5KY
         NCGYFXMPb2gS82ewhYiQtoRMCw0N+TEskFzwY3w5CwQcD7FJb+PibCKm2kMIdDEgEeWf
         wQb0xYrIssxplyL6qJzKAawnPE45Lm787P9UE0pc0qQ3vCRAluSPKix4OmmIgkFfGnNH
         YSuylSCNGG8RkOxi8mtHzn67zYiXFo9PfA1cozgIvGJ6ev00Qx/5rL3O6q3p3m69CO64
         pu4Q==
X-Gm-Message-State: AO0yUKWwY9dKFGoer/IfnZqvfaVpCkqzrhUGO+Gn9bfAaGk50/n3tO+o
        3GdLUUt3i7q2brSUh4cqVIRK
X-Google-Smtp-Source: AK7set+JWC2Y4o/tgD3y+UbDf7MYlD1NuQyiIJm43pesdd21YA1LiY3m1EAQuGngccI30EH6k6HKbA==
X-Received: by 2002:a05:6a20:b919:b0:cc:7f86:a804 with SMTP id fe25-20020a056a20b91900b000cc7f86a804mr32705451pzb.6.1678772280120;
        Mon, 13 Mar 2023 22:38:00 -0700 (PDT)
Received: from localhost.localdomain ([117.217.177.49])
        by smtp.gmail.com with ESMTPSA id n126-20020a634084000000b005034a46fbf7sm675093pga.28.2023.03.13.22.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 22:37:59 -0700 (PDT)
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
Subject: [PATCH v7 05/13] arm64: dts: qcom: sc7280: Fix the base addresses of LLCC banks
Date:   Tue, 14 Mar 2023 11:07:17 +0530
Message-Id: <20230314053725.13623-6-manivannan.sadhasivam@linaro.org>
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

While at it, let's also fix the size of the llcc_broadcast_base to cover
the whole region.

Reported-by: Parikshit Pareek <quic_ppareek@quicinc.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index bdcb74925313..afe74db1f5ae 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3582,8 +3582,9 @@ gem_noc: interconnect@9100000 {
 
 		system-cache-controller@9200000 {
 			compatible = "qcom,sc7280-llcc";
-			reg = <0 0x09200000 0 0xd0000>, <0 0x09600000 0 0x50000>;
-			reg-names = "llcc_base", "llcc_broadcast_base";
+			reg = <0 0x09200000 0 0x58000>, <0 0x09280000 0 0x58000>,
+			      <0 0x09600000 0 0x58000>;
+			reg-names = "llcc0_base", "llcc1_base", "llcc_broadcast_base";
 			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-- 
2.25.1

