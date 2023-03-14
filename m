Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995AF6B8A97
	for <lists+linux-edac@lfdr.de>; Tue, 14 Mar 2023 06:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjCNFim (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 Mar 2023 01:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjCNFii (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 14 Mar 2023 01:38:38 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9D39608D
        for <linux-edac@vger.kernel.org>; Mon, 13 Mar 2023 22:38:16 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id u3-20020a17090a450300b00239db6d7d47so13994223pjg.4
        for <linux-edac@vger.kernel.org>; Mon, 13 Mar 2023 22:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678772295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KbEuZ8x9epY4wczXQcJX335FU4iMuAmx2Igvv4w4MY4=;
        b=yA43PiAKeBNB8a9B6Y9lwaxQHQDbCrpQuXRvkAKWd3GnsAjpNQLvvd86Sw3jpAlIhi
         YUAWNcQJYsrpiLBRZWuxQyGFY3pSGoOvbzw30iINyA2iZrPnYCfJOvYXewyxt6a+A208
         hnNdiJcdBR27i3K9Ght+Hhyklf08p/yrCdUGTkf3QtH5VKEA52Hme4euS81EWeXotQWH
         sEkIRZZgcLbbj0rMN66m9CGeUAAd2Yf1pehASAvozn328yR9qNbUYZ9GS6djpHNuO/Mf
         xdzzzp2nn5hss7+A65tSlr0czbPvOKcY6r72hg9RxqDYEqe19zXQV+uKZWUfUVrPYCS8
         2jsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678772295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KbEuZ8x9epY4wczXQcJX335FU4iMuAmx2Igvv4w4MY4=;
        b=DokozxIx2p/PkZlRvw7I2oKfDvZF6DrQu5nkJKCMJ3W1VsvOSNBaHAD6yBl7JdclAo
         vKp3SE3/LmPwD/dX9J827D4uXG5KTHFt1LtHsucKgBfZ2oHdis7Po/3tM/y/AfqWfkCW
         Yp3+D/VqFrgYVIoh+t2YgAkubkBrnfagN8xBUX8n/Upo3t2s3b+1xmv71SnmaAvTmClh
         9m4w5YKLTeh7GyqSIqB1CuTG2y69EAiHW3J98YOVlKbGnRBtl/6GYpijvTGYrzL4o+i7
         9SeDc1yhzL7BG2eCSNYTa+FeEDTSy7TnLt49ROp0Vvwk18ObRT4KUyEs9YjVxLDXZNhq
         gfRA==
X-Gm-Message-State: AO0yUKXp6RNCqd2d3TMmtbqGOeabRPcFNb8bbfKUJSfse3k+lbisuCQG
        ZM/5217IYKj+k92g66ERf2VZ
X-Google-Smtp-Source: AK7set9H6xnqZ0On6L7Kyi90nbJH7+hMfh4yWgx7eNUysp95rLxfqxE7afD+EGpzhePwKw7STUsm9g==
X-Received: by 2002:a05:6a21:6da6:b0:cb:e8c6:26a0 with SMTP id wl38-20020a056a216da600b000cbe8c626a0mr48838687pzb.11.1678772295257;
        Mon, 13 Mar 2023 22:38:15 -0700 (PDT)
Received: from localhost.localdomain ([117.217.177.49])
        by smtp.gmail.com with ESMTPSA id n126-20020a634084000000b005034a46fbf7sm675093pga.28.2023.03.13.22.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 22:38:14 -0700 (PDT)
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
Subject: [PATCH v7 08/13] arm64: dts: qcom: sm8250: Fix the base addresses of LLCC banks
Date:   Tue, 14 Mar 2023 11:07:20 +0530
Message-Id: <20230314053725.13623-9-manivannan.sadhasivam@linaro.org>
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

Reported-by: Parikshit Pareek <quic_ppareek@quicinc.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 2f0e460acccd..a13cf98b1ac3 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -3559,8 +3559,11 @@ usb_1_dwc3: usb@a600000 {
 
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

