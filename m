Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B039165419F
	for <lists+linux-edac@lfdr.de>; Thu, 22 Dec 2022 14:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235455AbiLVNSc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 22 Dec 2022 08:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235525AbiLVNSG (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 22 Dec 2022 08:18:06 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1F32B625
        for <linux-edac@vger.kernel.org>; Thu, 22 Dec 2022 05:17:50 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id s7so1993080plk.5
        for <linux-edac@vger.kernel.org>; Thu, 22 Dec 2022 05:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ny8LRDxtkCbzVPxZcMEK/2xCa3Cj3hxgheO6Po9c4/Y=;
        b=dhMQGBmR06G9CatEmwe+v1F0+trf5UQoHfDvkucAjtc26GNdGjq0Mmqd3P8/l8e2lK
         j786FeOg6gLzai89na4eEqUrq5EPxCmKugelr6TGJ4doyO0njRznbdKs31Jc1oVwXTRb
         A1rZaEsO9STSnQ6vC6bpfPiDtyKFXi+Amq7vxoqvJNgEBx9agHOu3jd2Vt66p10rFzXL
         816uQsS0YIusOOBr1wkkbgCudts0SFCyXkBtNRn0J/bRIoqRw4ocVVUOrii7XrWZF+EV
         ZAWISg78ZvUvnApxbF+wnyadkb8QLFGVE7v7tScsnKYkBnUVUhrE3S7t2oUpLJFbEa9+
         AYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ny8LRDxtkCbzVPxZcMEK/2xCa3Cj3hxgheO6Po9c4/Y=;
        b=S+2+QYWuXTAu/47Qh1dUPP3Z+KPzO8VkXC7N+PL1TXxBDmpv0QyJg0LOt/H3P+30aU
         ejj6IjbuCuxTRGar6sMx4pP86EfH/hgFDejpdVGBeocWAu1dIDS7JlqmI6I5qfqsmrnG
         23tlArr8yNq2Ts+aicpGn/GavUrvwRAfpeHX8jxT5cNbxIFaj3KUYVr3rpbwkd0GthK/
         +d2NmiOE7CX2DvtbF7SHLHT9ZAYfANoJXZnfgXj/OSL7KxCiVhlgd7RglOPriD0G5ykH
         n89/7uyuerD6QRCup3Ot5TITNKwJDF6wWeZYW5kcGtQPBlfIBpGf1HPOQGzIVx6WRjzV
         Oi/A==
X-Gm-Message-State: AFqh2kokNmRd0Zo58lKms46C61JkMecKxz/Xyxeb6XR9GsT7AIxy8Swg
        XSCtLzPv7sdaEtyjP01r7k/6
X-Google-Smtp-Source: AMrXdXtdlLhBbT/Lo06+N7ABRxG2EOW4Dg+4lppus3WpcowYBMBT8zKC6wfC2dxBDs+Sr7SmovSWNQ==
X-Received: by 2002:a17:903:10c:b0:192:5838:afaa with SMTP id y12-20020a170903010c00b001925838afaamr621172plc.25.1671715069820;
        Thu, 22 Dec 2022 05:17:49 -0800 (PST)
Received: from localhost.localdomain ([117.217.177.99])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902fe0c00b001896040022asm491570plj.190.2022.12.22.05.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 05:17:48 -0800 (PST)
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
Subject: [PATCH v4 03/16] arm64: dts: qcom: sdm845: Fix the base addresses of LLCC banks
Date:   Thu, 22 Dec 2022 18:46:43 +0530
Message-Id: <20221222131656.49584-4-manivannan.sadhasivam@linaro.org>
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

Reported-by: Parikshit Pareek <quic_ppareek@quicinc.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 65032b94b46d..e1c0d9faf46e 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2132,8 +2132,11 @@ uart15: serial@a9c000 {
 
 		llcc: system-cache-controller@1100000 {
 			compatible = "qcom,sdm845-llcc";
-			reg = <0 0x01100000 0 0x31000>, <0 0x01300000 0 0x50000>;
-			reg-names = "llcc_base", "llcc_broadcast_base";
+			reg = <0 0x01100000 0 0x50000>, <0 0x01180000 0 0x50000>,
+			      <0 0x01200000 0 0x50000>, <0 0x01280000 0 0x50000>,
+			      <0 0x01300000 0 0x50000>;
+			reg-names = "llcc0_base", "llcc1_base", "llcc2_base",
+				    "llcc3_base", "llcc_broadcast_base";
 			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-- 
2.25.1

