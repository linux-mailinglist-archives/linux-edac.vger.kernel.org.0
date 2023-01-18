Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142CA6720C0
	for <lists+linux-edac@lfdr.de>; Wed, 18 Jan 2023 16:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjARPLC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 18 Jan 2023 10:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjARPKL (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 18 Jan 2023 10:10:11 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B4032E5F
        for <linux-edac@vger.kernel.org>; Wed, 18 Jan 2023 07:10:09 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id f3so24719080pgc.2
        for <linux-edac@vger.kernel.org>; Wed, 18 Jan 2023 07:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7WUljA05hxjrMgWInu+aANTEuP2TXhzChwqlFzG2wks=;
        b=VR8yk8cQwKE0vjKVe3VXtUhppdd5/u8wgdmx/K6x1OCLgWTvaUlef55WNSjPhLRgyI
         Q5dmMt2x9vbrjCfOVHn5wlQ/DYqZ7MUgiTO/sjdVRN4UuVVQ+/eFZ/22+mqFV60K7wug
         anW0LVvjuk1/W2/NQHSW44QI4nWILiwIlMEITXXs9wIjljOsSkqdVB/VxYrHNgVreQxK
         cqdSAFIv4JDAG4msauY6MlxEqQVwGk/HjTXxkn0m+dCfMtaOZk/l1PZgXqWnfmOAqtle
         GsYU+qa0tfknMrto2AruuC9vOCHYQ/OCAI9dr4DDI7PhKZEJiCxXsZjBNbETG2px5eKK
         Z4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7WUljA05hxjrMgWInu+aANTEuP2TXhzChwqlFzG2wks=;
        b=VInP179lwsdnZkQEUqOuk1eL3xXPiuMN7Re1MJRvssNvRWpxNwrb84Ol+OJh8jLfsF
         PNdwt2R2ZuFSCefXNOofEJEKoaGY+suNu+7y+HusrutxmvaXRDwX6wDZvBvufvZzpaFr
         OSPDy+eyhjQMkjhpzF5S9TeRTxWWdL/LYUF+tWupXt+NS0180YwOXmspYE4+64ehY46W
         VCr8quWQ6d4Okx9VkOxszO5Lx1GKyojdkrpGiriqAAUk7SbNDVPvJ77pPTG1WDCaGVrX
         6wM5qbxkg2YIdgppQGrqWnnqhXv/BrVE6rJ1yuAOreyGCZoSFcZBQ9qsxSQ+9bAqwZct
         HG6Q==
X-Gm-Message-State: AFqh2kreU/xSz/YtxYz3SjkZaZbyPGPp7v3WLVVGfaLlEA3O6jN5Tn/z
        t/rp45H+ww2IqXjLJqJirOCD
X-Google-Smtp-Source: AMrXdXv4dGbRz48I94C4u/f36GkYSgZxv9G7FxDH7O/TUGN1UplLnGQ9KRzYws3OjzOyks7e9vROfQ==
X-Received: by 2002:aa7:81d4:0:b0:581:b3b3:7717 with SMTP id c20-20020aa781d4000000b00581b3b37717mr7424491pfn.26.1674054608907;
        Wed, 18 Jan 2023 07:10:08 -0800 (PST)
Received: from localhost.localdomain ([27.111.75.61])
        by smtp.gmail.com with ESMTPSA id i15-20020aa796ef000000b0058d9623e7f1sm6721544pfq.73.2023.01.18.07.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 07:10:08 -0800 (PST)
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
Subject: [PATCH v6 10/17] arm64: dts: qcom: sm8150: Fix the base addresses of LLCC banks
Date:   Wed, 18 Jan 2023 20:38:57 +0530
Message-Id: <20230118150904.26913-11-manivannan.sadhasivam@linaro.org>
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

