Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74206649EC3
	for <lists+linux-edac@lfdr.de>; Mon, 12 Dec 2022 13:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbiLLMeX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 12 Dec 2022 07:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbiLLMdt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 12 Dec 2022 07:33:49 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F3E12632
        for <linux-edac@vger.kernel.org>; Mon, 12 Dec 2022 04:33:39 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so15543098pjj.2
        for <linux-edac@vger.kernel.org>; Mon, 12 Dec 2022 04:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DCGU+aMFvu/t7Kdt87B6ewuHaXNeU8yBLP9UTUdSuo=;
        b=gt0eqdCyD/xGUbqsYqfrngyYsrqK9QOlFwwq5V0wiyqyuVsJ0XYiJoVcs304lD79by
         nfoiBMRcqh8n8Q2vXkF2NRRRx+/FRIiKbCnmjmKTjXvJvmMiXTexA3yXUTOmWK+6RYcs
         YtiXkhb5S0aw4+vrDdbRetdp/KzmY+9B+LLSp+XRlHP/M9OWtmXmy81+mVulJvxEkzKb
         VXmc3Gk5oejNX9e+I1gLyvBNc6Ir50w6TiAFSW16DL+m0JVjFpdYt+hSchW8LM9yR1Qe
         j67tSLY38LWPfyNePkw9ilDV7uCAPNn84Qzy/PqMiNJV4YsLXYN7egHZibbWSHp3lQ9j
         yZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8DCGU+aMFvu/t7Kdt87B6ewuHaXNeU8yBLP9UTUdSuo=;
        b=aGvQWJVfgP4Go4siwJdjX2GQszjXhROBCCaKGRLTpsjOkwd461mys3YLGm5+xk806h
         LygEYt4ayM6pG+rRm36dG1XKWIYjaoeu+OnCQNqLnEZCAMIgzi2KTPI5FWHyu/Bxxql+
         gry45DuCGnN26d/Y+/y0LvQ5aDjt2ahR4mbn8RhTaTT6Zk3GiP34PGfwujWbmZCbd5jk
         6D9M14bA1qVFQT6P7k2oY0bnZxPjtx9B1PtshDlZ7QdFkwgEAqly5ObaO/s9pEBIO3DX
         ZM+2nC2zr6XH3nDM/SmAnsaYGQmd2FHq3+sGRhPcGRoksZYIV+XmieuuorAxt6NNYfYI
         0s6Q==
X-Gm-Message-State: ANoB5pnvbroWWhY3tyAOwHIbNd6wxSfg+aVxUm9B+ZCKsHqc51s1T4yg
        aJqvfKmMqXebHaUUMhr2d8bB
X-Google-Smtp-Source: AA0mqf6IfrLFwIA8ynXUBacuNjHqllcfNnQ/gFd1xeUcH7C00ttYD08/6fbvdYg+JEHAjPH1C6IWeQ==
X-Received: by 2002:a17:903:2786:b0:189:f69d:d5cc with SMTP id jw6-20020a170903278600b00189f69dd5ccmr16939456plb.58.1670848418819;
        Mon, 12 Dec 2022 04:33:38 -0800 (PST)
Received: from localhost.localdomain ([220.158.159.33])
        by smtp.gmail.com with ESMTPSA id j14-20020a170902da8e00b00189c93ce5easm6252557plx.166.2022.12.12.04.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 04:33:37 -0800 (PST)
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
Subject: [PATCH v2 03/13] arm64: dts: qcom: sdm845: Fix the base addresses of LLCC banks
Date:   Mon, 12 Dec 2022 18:03:01 +0530
Message-Id: <20221212123311.146261-4-manivannan.sadhasivam@linaro.org>
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

Cc: <stable@vger.kernel.org> # 5.4
Fixes: ba0411ddd133 ("arm64: dts: sdm845: Add device node for Last level cache controller")
Reported-by: Parikshit Pareek <quic_ppareek@quicinc.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 65032b94b46d..683b861e060d 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2132,8 +2132,9 @@ uart15: serial@a9c000 {
 
 		llcc: system-cache-controller@1100000 {
 			compatible = "qcom,sdm845-llcc";
-			reg = <0 0x01100000 0 0x31000>, <0 0x01300000 0 0x50000>;
-			reg-names = "llcc_base", "llcc_broadcast_base";
+			reg = <0 0x01100000 0 0x50000>, <0 0x01180000 0 0x50000>,
+			      <0 0x01200000 0 0x50000>, <0 0x01280000 0 0x50000>,
+			      <0 0x01300000 0 0x50000>;
 			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-- 
2.25.1

