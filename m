Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD0E6720B2
	for <lists+linux-edac@lfdr.de>; Wed, 18 Jan 2023 16:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjARPKO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 18 Jan 2023 10:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbjARPJ7 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 18 Jan 2023 10:09:59 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01BD302A4
        for <linux-edac@vger.kernel.org>; Wed, 18 Jan 2023 07:09:52 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id s67so24720328pgs.3
        for <linux-edac@vger.kernel.org>; Wed, 18 Jan 2023 07:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4GFA6I79C1YmmOYQX1BIX7MOGuUjMMgmSjlJ7uhFCjc=;
        b=F9kKv6buxOU5Im8R6aHB0PFWZ/FXExIZ8ZaDgwt5k8VDOOIwtnBfmZxGR0TZxcjTpL
         /DKUIVp96tTBZyYFeFB2+XfArqK9Ugu+5xmH1COagG0gyhsE9F8Dx4NlHHujD0k0X7dY
         oGDLCyLiVcLdlHDIQJYjGId2jV9TBZ9o3yiJ1XIgN5xTnazav+/UJHdo6FlVAuMni/l3
         8C4b4AK+H/bcqH711QjPXaLPLL0FZBz44KVSWz8Nq2tR4e1FMN46U8MWlFDAupu8R2rv
         PbvGbNeMfDiqcAaIRCvMAQwzCIzR8Ms3CnQ1WoRmfH5oN1yTQ4PBEsqEHsrmBE5OG6x/
         3N0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4GFA6I79C1YmmOYQX1BIX7MOGuUjMMgmSjlJ7uhFCjc=;
        b=v5PrVwMUTM1jPBpAyufEev963505pi2C7CINTkQHhz4UZGzoHrrFmkyKrbebypSggs
         XNd3YHriU0Gu2MAZvSUYsy3xOwunCYplXu/diGYpQO7f1bAu6AGmMsmYjxpgosoRIfHr
         8BRGvcT4IjZyxM+irwffS1CFS0Ak40u86qqDOLXfW6exkIbCtS3LLtphXha8Og6ZWWRi
         4vRtSP/tGhZlhcOIhPBlmP9uqzbebL2J2co3RLcFjiCMoGnUjZ/vRIjDJ8LnzMlHgFi5
         iS6bnNH5T3BOIVMYJxX7r7NyfXrrSzvANqmXAVnjmvyOGHSA8tEgQmTYycfl4miHPxcu
         /VRw==
X-Gm-Message-State: AFqh2kquK/YULIOBvBxauX17aFN4FJD4ZjHxvV3mEythDlIUl6kC/eLC
        KIiOEXtYYSHEfSgJLM9OO3wN
X-Google-Smtp-Source: AMrXdXt+3Qs7UO8zkUQYgy7ddY4gAvvWByLhnlOSea+JmBNYxQsNPuuqGkF9FiQWd9ELlXUqUO+9iQ==
X-Received: by 2002:aa7:8a0e:0:b0:58d:9850:d55f with SMTP id m14-20020aa78a0e000000b0058d9850d55fmr7381028pfa.21.1674054592431;
        Wed, 18 Jan 2023 07:09:52 -0800 (PST)
Received: from localhost.localdomain ([27.111.75.61])
        by smtp.gmail.com with ESMTPSA id i15-20020aa796ef000000b0058d9623e7f1sm6721544pfq.73.2023.01.18.07.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 07:09:51 -0800 (PST)
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
Subject: [PATCH v6 07/17] arm64: dts: qcom: sc7180: Fix the base addresses of LLCC banks
Date:   Wed, 18 Jan 2023 20:38:54 +0530
Message-Id: <20230118150904.26913-8-manivannan.sadhasivam@linaro.org>
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

