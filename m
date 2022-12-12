Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D902649ED9
	for <lists+linux-edac@lfdr.de>; Mon, 12 Dec 2022 13:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbiLLMfp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 12 Dec 2022 07:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbiLLMfK (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 12 Dec 2022 07:35:10 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0048412637
        for <linux-edac@vger.kernel.org>; Mon, 12 Dec 2022 04:34:31 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so15543097pjr.3
        for <linux-edac@vger.kernel.org>; Mon, 12 Dec 2022 04:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZ3me+mcNSacplSG7BmxN9uUD75qHevGLumn9ggiZjk=;
        b=Da9bwkmekbWk4IMIUkh88ZGsnj0KJGtXfDc1AWs0hK2XuiZj7jIKdfGvqnFHOM05L1
         xR6JxwyCeCelvoW9qSumYDNeBnxnJVaUQ2S68T1zhtqGUQjg/cJC+dOYYP5g9THGora5
         SDGBIqU2dYDoe2zPD73pcDBSKsbc+dREy3JgCmBwvtC+q7jJjRMvczc/0073uvJejuwC
         ajKJaapp4r8hMGUnvmiHYJtCEmDgLdZZUwUBez/Svg6YHD5jLJnN67iaiK+F+8GdxAcD
         fOIVwnxt/IIv7hVxyv5RESNOEGJRRe4D2svwqcttfGbyePU33mqv1f49V5zCr4l1aqfT
         jTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZ3me+mcNSacplSG7BmxN9uUD75qHevGLumn9ggiZjk=;
        b=DPVtURi+5binVF8X6M69fLeeS/xMIjiqRSWlE9duIPs7GJKfMIkiPRzF6ko2zJ29bu
         N18TQZqeZk1HhAlyQRpbMWl96NuOKrmFn5aFrougQs8vSG6vqb3i8J3xIgYdveizvNQO
         KSe3ySfyURB+jxYX94DAklmKXNFvcY/b1oY3SlxmdThsdHsWwEuz/JvNP1a1CyO/drMO
         qiRxVYxjYbjTMHFIxavngz8Vqcpb6tjEJH4ZD+giZIx44NxrrXVE7KqFLvjDEJL/J2SK
         8rA0ObWH0Nm9Za+fZKhxXN1EODSWHSn/tYKJhPJ4I4QqWVm/clrclnhnbDnUgVxthi4M
         E5FA==
X-Gm-Message-State: ANoB5pnsBw5gp4Lv4KsgpGw2kqMXuWw7tM5Z1JnLDJEqRXgsE3sXadCw
        FMST80JRYwoi3qkh0Sjf7WlS
X-Google-Smtp-Source: AA0mqf5oz4xPavmtcpkaaihKxi2KT6i0eyqqiNNAYWS76y+0yOB1iu5CKW4I5DkFxH+YhyRV2K57Ag==
X-Received: by 2002:a17:902:9b8d:b0:186:605b:7527 with SMTP id y13-20020a1709029b8d00b00186605b7527mr15250039plp.48.1670848443991;
        Mon, 12 Dec 2022 04:34:03 -0800 (PST)
Received: from localhost.localdomain ([220.158.159.33])
        by smtp.gmail.com with ESMTPSA id j14-20020a170902da8e00b00189c93ce5easm6252557plx.166.2022.12.12.04.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 04:34:03 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com
Cc:     quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        luca.weiss@fairphone.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH v2 07/13] arm64: dts: qcom: sm8150: Fix the base addresses of LLCC banks
Date:   Mon, 12 Dec 2022 18:03:05 +0530
Message-Id: <20221212123311.146261-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221212123311.146261-1-manivannan.sadhasivam@linaro.org>
References: <20221212123311.146261-1-manivannan.sadhasivam@linaro.org>
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

Also, let's get rid of reg-names property as it is not needed anymore.
The driver is expected to parse the reg field based on index to get the
addresses of each LLCC banks.

Cc: <stable@vger.kernel.org> # 5.11
Fixes: bb1f7cf68a2d ("arm64: dts: qcom: sm8150: Add LLC support for sm8150")
Reported-by: Parikshit Pareek <quic_ppareek@quicinc.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index a0c57fb798d3..958655bf5b1a 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -1762,8 +1762,9 @@ mmss_noc: interconnect@1740000 {
 
 		system-cache-controller@9200000 {
 			compatible = "qcom,sm8150-llcc";
-			reg = <0 0x09200000 0 0x200000>, <0 0x09600000 0 0x50000>;
-			reg-names = "llcc_base", "llcc_broadcast_base";
+			reg = <0 0x09200000 0 0x50000>, <0 0x09280000 0 0x50000>,
+			      <0 0x09300000 0 0x50000>, <0 0x09380000 0 0x50000>,
+			      <0 0x09600000 0 0x50000>;
 			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-- 
2.25.1

