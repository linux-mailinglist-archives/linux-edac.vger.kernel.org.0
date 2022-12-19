Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551CB6511F8
	for <lists+linux-edac@lfdr.de>; Mon, 19 Dec 2022 19:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbiLSSc1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 19 Dec 2022 13:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbiLSSbp (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 19 Dec 2022 13:31:45 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E40F2616
        for <linux-edac@vger.kernel.org>; Mon, 19 Dec 2022 10:31:17 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id u5so9947254pjy.5
        for <linux-edac@vger.kernel.org>; Mon, 19 Dec 2022 10:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMev9I+ZdryrTBjzJ8tiTgJp1UwzDLK7UbgCFoQvzyA=;
        b=ISZcvgYc9T6FYAb2s2G8VhkcsIW+gZf6wwrWxwJTuadTmL8/UwfEsuKZXpfLjT+5aS
         9pJQGDzTUqhpIvbASUxiNlkCL7gmxXL5k4xgdrMABF84r2Bs2xV5ZimoEX4bU+faWkqv
         lbilaaI22QvcUgKQDFzzDaZXiUYDpcbVQ7nIILI7SHaIxA/p1RenEKqVDDxJNNQ8KQTR
         YzZI/R1dEsYcNqM2tMTwUSFyWGt/b7PSNDnS4FCEaOOShqQ13SDxbPNPolH73sjkhUSj
         B/CN9eEZejSIprUHRBfYV+b6o7gCKfcJ+xd2zea0dUmHnvjz5JjQ4jW0BtTd8OQPuDEo
         2OSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sMev9I+ZdryrTBjzJ8tiTgJp1UwzDLK7UbgCFoQvzyA=;
        b=e/JEGN4l/UgGqhV2Y6JV7fxvRzzeyLW39hzN9Un+3AjymyKyqi0HwA8U+bBqIIlBQ1
         LhOPVrRh5Qfoyf7yI71gZ7zM0871fSg3oUigz88UFvTenhV8AjrcsKAuZzRnlxTgtaM8
         9WFcl9Dbz15CGjIMPfRnjrQbhqOtD6ywCvsZF+F856jwukbtPT7SpGqjelEy8B/uoaVe
         QSle19jfehKeEMwzYqI5Kt+6h2UDrIUomsmP+PwCSwV0EZAhs7AMaR2le2wmbwX9Wizh
         +sqhkNKkeA238ZeABS143G/67hi52PJOWIPLRb+gfhqJGTdh80DjFFX7gYWWmWK40Kw+
         nTbw==
X-Gm-Message-State: ANoB5pny2mBxHjIE3pd95TgsjVMuW4KOQeqSgPjJ8VZb28DJxF3lVv/6
        9u2hd3MH13t9fVCme7G/V+jc
X-Google-Smtp-Source: AA0mqf7OeNd+vaSQ7kwiTMRnGFUztWZu465KTvzxOsKQ7TuZ4d9JATNY/D5bXSxfHat8beCw82gKFA==
X-Received: by 2002:a17:902:c206:b0:18f:6b2b:e88d with SMTP id 6-20020a170902c20600b0018f6b2be88dmr37998172pll.36.1671474676773;
        Mon, 19 Dec 2022 10:31:16 -0800 (PST)
Received: from localhost.localdomain ([220.158.159.17])
        by smtp.gmail.com with ESMTPSA id d2-20020a170903230200b00186e34524e3sm7480979plh.136.2022.12.19.10.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 10:31:15 -0800 (PST)
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
Subject: [PATCH v3 09/15] arm64: dts: qcom: sm8350: Fix the base addresses of LLCC banks
Date:   Mon, 19 Dec 2022 23:59:52 +0530
Message-Id: <20221219182958.476231-10-manivannan.sadhasivam@linaro.org>
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

Reported-by: Parikshit Pareek <quic_ppareek@quicinc.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 245dce24ec59..836732d16635 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2513,8 +2513,11 @@ gem_noc: interconnect@9100000 {
 
 		system-cache-controller@9200000 {
 			compatible = "qcom,sm8350-llcc";
-			reg = <0 0x09200000 0 0x1d0000>, <0 0x09600000 0 0x50000>;
-			reg-names = "llcc_base", "llcc_broadcast_base";
+			reg = <0 0x09200000 0 0x58000>, <0 0x09280000 0 0x58000>,
+			      <0 0x09300000 0 0x58000>, <0 0x09380000 0 0x58000>,
+			      <0 0x09600000 0 0x58000>;
+			reg-names = "llcc0_base", "llcc1_base", "llcc2_base",
+				    "llcc3_base", "llcc_broadcast_base";
 		};
 
 		usb_1: usb@a6f8800 {
-- 
2.25.1

