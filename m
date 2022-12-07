Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F39A645BE2
	for <lists+linux-edac@lfdr.de>; Wed,  7 Dec 2022 15:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiLGOC3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 7 Dec 2022 09:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiLGOB3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 7 Dec 2022 09:01:29 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A485D68C
        for <linux-edac@vger.kernel.org>; Wed,  7 Dec 2022 06:00:45 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id g1so9470630pfk.2
        for <linux-edac@vger.kernel.org>; Wed, 07 Dec 2022 06:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGwgSnOhYi02xVu+IbkUS49u1T5vi+3uXVqLwkjF92c=;
        b=RelowFhh6oDnHAyNKyX5GbA0mViEyG82HTuOCWYZ5qrEcSdJzwUBvwFBBkWMWJVLJS
         XQ3r67OTKq+d0YJ+zYjUP+DwVXu6cA4OsIXmXxXwuJz0ZYIEj2jbu7bUdy/uIB64TN/B
         3wp1Jd1vmyS5dBY19RdVefXiyHrbBtesuuq5FyzuRz0fd3ZAWF+Mbz0rRWgrPWxl2EWt
         DDesFiVgla6qIu4YzL9mosel0xcmbHZQ4Q913AxLMXeXPl67p9ko9DuQWmDMSrp9yxgt
         5kM9BPICjX/IMuGDeziQRWvE5dnp7fZGCifql6pp8otxSixvDtscV77RApqMb76xzJc8
         +Kag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGwgSnOhYi02xVu+IbkUS49u1T5vi+3uXVqLwkjF92c=;
        b=vGowCf7Z0k6ThnYKkVjybnQxD7I1h5Zk6CHgi253Bnqod1DqQd4DBn/TS3qf3hVUuG
         MABU9I6hx4qSmqnBmPJsKSMFLICiAvT7mBC1NpmKZ7q0u/nRb2JMFsm1Jp5fkJmmOjfW
         P+v5aHaQeTXHAwXu7RZv4qDw4kt0vTwPj/58vK33mbVmZxSzAiloJc4WblrDkHLzq4kV
         NNhjT3T/03/eGChlpXzOxAg9qn6naU8rKZ3wsJWULeUwFAIZYaS7XJpUJTmhHgIg9f0W
         fVI/WZEh2hTYxqsZxn/NSFCweXlqnkAl1jSZz4lA0POpeUi6iWmpFtM3elxMGAiPsayO
         e0oQ==
X-Gm-Message-State: ANoB5pmz+7HDdUnNKr9pJ1wgSH5K5r68kZ+KA9EzCzSmaUynKSWMCkqX
        w6eKblXsk4vqPCsn3T2RJvHDdpTKf/kMXDA=
X-Google-Smtp-Source: AA0mqf4xthVb9iLjHkSf+QcyPhznIdyUnH2woOTMyd/m/Su3Q10nTYhwPFoFW3QGv3znCqBN5a1TjQ==
X-Received: by 2002:a62:ee0f:0:b0:56c:8dbc:f83e with SMTP id e15-20020a62ee0f000000b0056c8dbcf83emr73052440pfi.41.1670421645105;
        Wed, 07 Dec 2022 06:00:45 -0800 (PST)
Received: from localhost.localdomain ([117.216.123.5])
        by smtp.gmail.com with ESMTPSA id c18-20020a170902d49200b00186b69157ecsm14720160plg.202.2022.12.07.06.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 06:00:44 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com
Cc:     quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH 11/12] arm64: dts: qcom: sm6350: Fix the base addresses of LLCC banks
Date:   Wed,  7 Dec 2022 19:29:20 +0530
Message-Id: <20221207135922.314827-12-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221207135922.314827-1-manivannan.sadhasivam@linaro.org>
References: <20221207135922.314827-1-manivannan.sadhasivam@linaro.org>
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

On SM6350, there is only one LLCC bank available. So let's just pass that
as "llcc0_base".

Cc: <stable@vger.kernel.org> # 5.16
Fixes: ced2f0d75e13 ("arm64: dts: qcom: sm6350: Add LLCC node")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 43324bf291c3..c7701f5e4af6 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -1174,7 +1174,7 @@ dc_noc: interconnect@9160000 {
 		system-cache-controller@9200000 {
 			compatible = "qcom,sm6350-llcc";
 			reg = <0 0x09200000 0 0x50000>, <0 0x09600000 0 0x50000>;
-			reg-names = "llcc_base", "llcc_broadcast_base";
+			reg-names = "llcc0_base", "llcc_broadcast_base";
 		};
 
 		gem_noc: interconnect@9680000 {
-- 
2.25.1

