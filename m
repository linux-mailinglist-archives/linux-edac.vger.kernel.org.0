Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE096720B7
	for <lists+linux-edac@lfdr.de>; Wed, 18 Jan 2023 16:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjARPKU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 18 Jan 2023 10:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbjARPJ5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 18 Jan 2023 10:09:57 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43945222E4
        for <linux-edac@vger.kernel.org>; Wed, 18 Jan 2023 07:09:47 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so1807102pjq.0
        for <linux-edac@vger.kernel.org>; Wed, 18 Jan 2023 07:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9QXXi64w5AkU0+SlZ8zyP2UpGIuUHr0Btt1KBRAP8A=;
        b=obtgJhJLbF4zWUDolIBzQPaWeCJD4k73tplZA2oseQtFWjew9LCQd9iWssEKhC60G4
         QJZouobxHZsRUV+v0NgrkDrkrLtepNVemS1x+00LcFX2iwGozOuS5MWLRVWFbm6PHNge
         zNWmWkn/r8C4zdZGguEztP6KTdOFRZUT/jVj0vkG7PUgoBRnDGOkEB3adUea/U9aoC6S
         TvzZFiX/zZT4DfkhlMUFl2BOZ9f0djgiAYYVIy/QbIlH3aCgQLr2n7ZBsNctRMe9YHDb
         Z1Sq6rFOmmXIh/xS7PPsaCNNktEq2XJPBkcZ759uigRjj9AlCi1Bz96CYp0HiV/Cf1rb
         ZyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e9QXXi64w5AkU0+SlZ8zyP2UpGIuUHr0Btt1KBRAP8A=;
        b=IZiOlQbNUFyfwainBLrRJDYQsOsXOXgBRphBSQwtTXQMSh0RZyEX7xSnjtlnubnDRx
         YKVniPolJUjNNJT75Fx8MZFoffO/eg5ySROiGwZaxFtbk1Wkc0qfPaXGKlnlS2jINNnO
         hUp/hpSuMBzmJzU3QTY8BQPzcg3xKcb3tJm7EA9XBZrMyPkHVuO3ySvqcSbAqxkjmTiQ
         +trzPMTwpobiSnxSZlw+/eGoZYU170O74uElz8gLlNt3GEzjeHBxPiLVwqoCf3NynZBA
         nlatIr4ZJnlbyTC3DNIpFws7kOOmyr385+NNvB9KncZ89gNYoYkKP+NcpNl/X3XbXewJ
         9d8g==
X-Gm-Message-State: AFqh2kpj+DNnMBZA0lkSGugG435F2gqlVgLJwWNi0Z+rFwC9p3lfNU68
        8gZnrr4+1/dr2bdiF9SrmqA/
X-Google-Smtp-Source: AMrXdXudo2SgQfYV2NRx9IPy1Dx4CtZVDyyWiTYIZ8R4pxcG4AMOnDrL8NF4HyzKb/JjyMl+KsOmYA==
X-Received: by 2002:a05:6a20:9e0e:b0:ac:7a44:db55 with SMTP id ms14-20020a056a209e0e00b000ac7a44db55mr6345038pzb.39.1674054587110;
        Wed, 18 Jan 2023 07:09:47 -0800 (PST)
Received: from localhost.localdomain ([27.111.75.61])
        by smtp.gmail.com with ESMTPSA id i15-20020aa796ef000000b0058d9623e7f1sm6721544pfq.73.2023.01.18.07.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 07:09:46 -0800 (PST)
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
Subject: [PATCH v6 06/17] arm64: dts: qcom: sdm845: Fix the base addresses of LLCC banks
Date:   Wed, 18 Jan 2023 20:38:53 +0530
Message-Id: <20230118150904.26913-7-manivannan.sadhasivam@linaro.org>
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

On SDM845, the size of the LLCC bank 0 needs to be reduced to 0x4500 as
there are LLCC BWMON registers located after this range.

Reported-by: Parikshit Pareek <quic_ppareek@quicinc.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 65032b94b46d..4db68d4d78df 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2132,8 +2132,11 @@ uart15: serial@a9c000 {
 
 		llcc: system-cache-controller@1100000 {
 			compatible = "qcom,sdm845-llcc";
-			reg = <0 0x01100000 0 0x31000>, <0 0x01300000 0 0x50000>;
-			reg-names = "llcc_base", "llcc_broadcast_base";
+			reg = <0 0x01100000 0 0x45000>, <0 0x01180000 0 0x50000>,
+			      <0 0x01200000 0 0x50000>, <0 0x01280000 0 0x50000>,
+			      <0 0x01300000 0 0x50000>;
+			reg-names = "llcc0_base", "llcc1_base", "llcc2_base",
+				    "llcc3_base", "llcc_broadcast_base";
 			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-- 
2.25.1

