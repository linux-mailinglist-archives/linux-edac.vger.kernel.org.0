Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E0D6720C7
	for <lists+linux-edac@lfdr.de>; Wed, 18 Jan 2023 16:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjARPMH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 18 Jan 2023 10:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjARPKT (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 18 Jan 2023 10:10:19 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CA838EAC
        for <linux-edac@vger.kernel.org>; Wed, 18 Jan 2023 07:10:14 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id x4so22263555pfj.1
        for <linux-edac@vger.kernel.org>; Wed, 18 Jan 2023 07:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYoJy3okzdnngL6TcLmeGykcAQcBXE1fb+mKXu1bB1c=;
        b=IQPIE/eXydmZ3f4OORjsxJU3PrDJNNWBD5X3faQZsETILHHrwW+fCkgS9LGofsk6L/
         kg6ThppKwQ38Dzy095MzkDh+hzytj8rp1hLOn7YhbnwP2m0bvwGPlvIWRLeiJWTF+ElK
         M1vkwKc9Y8KjPB5l5yb7XrOATb3dnn1SQW9GiMqfT0oyqpOAPJywOh2sHvRp5ioG2yn9
         1HjXoIpsY+WlRaTlSMwyT0RZoqtJIPrNUAkwWhfZ7Xtv0DaRmC+p44YjD+u90EvxQiXJ
         vNRv1cI+M7q6kgKfypF16XBMAE22IG0NHKKTDJX5zGJNuuA2N/IGN7JaIbkaWobi9Z3G
         RbHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYoJy3okzdnngL6TcLmeGykcAQcBXE1fb+mKXu1bB1c=;
        b=LOGsTpCSVTa+ozmCHWfHciHpTdZYSXfYLQou1RCghxguRdFPAElBrjrvfWYSxKkmFE
         a9/suxm2CUn3tNi0GMnF5Of9SDyL2tRVRYxbrcMm1iq2gUHtcV6vVCqvtKolIwLh6D+z
         eYBsMMzyn8bgzGUygpf5fzKbo2A9VNWaaorMAFWM1K2F51QHVeBC3nzuLl+MOwvt+8o9
         QL1Uaj/haqVQQjjrccMpiIZpk7k0K++4Oks7ChhG7aqa8kHHnNS6CfY5vLgEkObtVo/H
         3ZyzoD8kAi5cO0qTnGc/1kYbnU4CQMvHSZhbFcFtAlNnYzRh1yWko4YlDhyNQ1Ez1rJT
         Y95A==
X-Gm-Message-State: AFqh2kq8bbBPdjGi/ulh+hjnUlIL2aehB8Javpn6TMExSvgDF8LmRbKk
        sxPbpqi9wiFkDaEd+wLlrL6N
X-Google-Smtp-Source: AMrXdXtgMsSHESMDsUTy6/2cPHBnkiBlkcscfB2U0QnjfKoDHaYmD4yfNA3PHoAYHvrGI8x9va/LFQ==
X-Received: by 2002:a05:6a00:1887:b0:588:cb81:9274 with SMTP id x7-20020a056a00188700b00588cb819274mr11486900pfh.32.1674054614292;
        Wed, 18 Jan 2023 07:10:14 -0800 (PST)
Received: from localhost.localdomain ([27.111.75.61])
        by smtp.gmail.com with ESMTPSA id i15-20020aa796ef000000b0058d9623e7f1sm6721544pfq.73.2023.01.18.07.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 07:10:13 -0800 (PST)
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
Subject: [PATCH v6 11/17] arm64: dts: qcom: sm8250: Fix the base addresses of LLCC banks
Date:   Wed, 18 Jan 2023 20:38:58 +0530
Message-Id: <20230118150904.26913-12-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230118150904.26913-1-manivannan.sadhasivam@linaro.org>
References: <20230118150904.26913-1-manivannan.sadhasivam@linaro.org>
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

Reported-by: Parikshit Pareek <quic_ppareek@quicinc.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index dab5579946f3..d1b65fb3f3f3 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -3545,8 +3545,11 @@ usb_1_dwc3: usb@a600000 {
 
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

