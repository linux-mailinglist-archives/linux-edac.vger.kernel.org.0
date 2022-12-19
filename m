Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D156511EA
	for <lists+linux-edac@lfdr.de>; Mon, 19 Dec 2022 19:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbiLSSbN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 19 Dec 2022 13:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbiLSSax (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 19 Dec 2022 13:30:53 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B50025EF
        for <linux-edac@vger.kernel.org>; Mon, 19 Dec 2022 10:30:50 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d15so9868163pls.6
        for <linux-edac@vger.kernel.org>; Mon, 19 Dec 2022 10:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3b0H9FlwI0cHeu/QvvhJdFruV0iaHa3piiWtATy1Lw=;
        b=HmzpXW602W74dkB7Kw4cfxsccMJzLWsYo8Dh2GfPNeaWfTmFfA/VPlD9AJ2mbnOz9D
         B8ugOhfIIoVycjH3TP0GiwYh91lI9gdYIq+fVOA2OuTjBKAWpyEk2uk55/2DZflfLcI9
         D5hMSF+sCUrTxoSpOeKD7GxYNCdir7BgGm93wc61Q0DXBBlH2e6cvN2HB8sdj4XuDTWj
         iBxIxZ7iTB6of8S+tdm4Ki5NlkBSmX+5JWEYumGQPDwv1kHKFpkP/S7jNLrxhyWFSIH8
         rZKL028OZRxFW76HoCOtopOvt8KllnDxUqC1XlXDpkSJnuICamZ3epeV1kt3kgc9O0XQ
         9+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3b0H9FlwI0cHeu/QvvhJdFruV0iaHa3piiWtATy1Lw=;
        b=YrN9/0t2SJOB3ZRS+87RqDrCM5zFD/HRsDNZ1VNsZC7dAM4Z0nzvmKqC0tanhSBbQP
         XZO36rOssZqYNtZ7OxnqeP4V9U0jHwK9U6s1vuF2PN5KYiAq4aSeYlQR1u9pO6Fs9jj8
         zqi8vOwlIRMpK5qu9N8vkNRy2523fN+r3fPtFYFZLH3NNVRcgMKHU3l1pK++NKiT+iQf
         mDMUftaC0Qh/LWSYQzoJtfgNe2UyhGI1Z0b9BIA2izvSX6HqAo/xKRcEGq85EodywQjP
         +6a/MEjTyWF6Kq5d6Rf53y/mlBXD5cMMtwQY8pqhgRlRg5eCxrJLHJQbsmR+SIwC6V33
         ymkQ==
X-Gm-Message-State: AFqh2kqIueBWwpaYCpixaa98kw4fym5MYzbLoXN9PDT9N8sZXX05qHZi
        uk5/KM9/UIajc5+n6Rsz+J7I
X-Google-Smtp-Source: AMrXdXu9B7+GsS7cm8a52HEusGRsJ2QSXxJZCnq1M/0ZTtl7VF0b7lcxEyGIy+ZPZ8jwLniAONk8YQ==
X-Received: by 2002:a17:902:7786:b0:191:2181:d6e0 with SMTP id o6-20020a170902778600b001912181d6e0mr4853807pll.8.1671474649819;
        Mon, 19 Dec 2022 10:30:49 -0800 (PST)
Received: from localhost.localdomain ([220.158.159.17])
        by smtp.gmail.com with ESMTPSA id d2-20020a170903230200b00186e34524e3sm7480979plh.136.2022.12.19.10.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 10:30:49 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com
Cc:     quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        luca.weiss@fairphone.com, ahalaney@redhat.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 05/15] arm64: dts: qcom: sc7280: Fix the base addresses of LLCC banks
Date:   Mon, 19 Dec 2022 23:59:48 +0530
Message-Id: <20221219182958.476231-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221219182958.476231-1-manivannan.sadhasivam@linaro.org>
References: <20221219182958.476231-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 0adf13399e64..6c6eb6f4f650 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3579,8 +3579,9 @@ gem_noc: interconnect@9100000 {
 
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

