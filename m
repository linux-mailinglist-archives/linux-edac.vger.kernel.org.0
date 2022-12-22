Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581996541AD
	for <lists+linux-edac@lfdr.de>; Thu, 22 Dec 2022 14:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbiLVNS7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 22 Dec 2022 08:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235559AbiLVNSP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 22 Dec 2022 08:18:15 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D052B257
        for <linux-edac@vger.kernel.org>; Thu, 22 Dec 2022 05:18:12 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id v23so1877505pju.3
        for <linux-edac@vger.kernel.org>; Thu, 22 Dec 2022 05:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVKI7LzAkCeTNtN2kaZFbBM4yejfzWbEhk9TFnMYwYw=;
        b=P/a+54AgWuWXtmXW0Z8O+Z4jquZ6bjEQJYCos8CoZuhMjjTvnXhIYgjxuOmTDy32+0
         Kcr+bf3cXzVpz9f0cNhNz/XK2mJRqFhb1uSe9ZDqO/Z3IVIFE9RvTyqCTE0nHnin1tdz
         a8mBSs5XShG3YBkdgOSM7by4y/YzeqUpy5K0woYBdRb4acljtFdA9F74/EcYgA/MWG+l
         aJNv0vt9pbz9yv+E40Z+1sk6Asiw1AtA/rjyJEIC0IDakCNR6RHh/T1mJvjN3o4rl858
         F7SBp6WCIfiB74jDKsSSwH0bAyQbK7VRJ/cv+1f7WQP2u8IkfsvgrYjIpAgkl+oGA0fo
         x64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVKI7LzAkCeTNtN2kaZFbBM4yejfzWbEhk9TFnMYwYw=;
        b=vpbeaqt2D0kukx2mRK3BKZBrOmzId4D5ktrliOjiLaCvhoQqAwDsd3FhEzCiwf0vrl
         bFjsAxXvzdmR8vCFLuzgL+4K6UNHcY6ygThbPMlwAspM06m1ZiXDi1nIl73QUcdGq97V
         Su4ZBKu+w8G7SOIalv/3JtTmUb5f+MCa7lbsr6apwPtyTRKXLWG0KEyLkzkpox+1eYLe
         30kUXuirG/yeLPUz01EXHVl1tB5NX6HLfPgrSA4Uo3tAHq9+3nLxfP7WK6HRrVk8k/xC
         hMttHWteDCc6c/As+OYXOe+eOyuc0Lv5snbAMa031xPZpg4/b0/6AoxhoW7s6+pCCYKG
         QZTQ==
X-Gm-Message-State: AFqh2kpI94fRB2mBCNid3PI9ql1roXBd28K3WOZbaDwHAYUpUf1fxjsn
        TMhEA9OFTTeWs9JGmjUgQF9R
X-Google-Smtp-Source: AMrXdXs6GKa04tnmCrRCU9GMOUViTkmcx9NG4nUPCgprwzoRazOPtkyIpmoTMBILt/ItUkBQxGc6zw==
X-Received: by 2002:a17:903:210b:b0:18f:aca1:b0c9 with SMTP id o11-20020a170903210b00b0018faca1b0c9mr5058479ple.53.1671715092349;
        Thu, 22 Dec 2022 05:18:12 -0800 (PST)
Received: from localhost.localdomain ([117.217.177.99])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902fe0c00b001896040022asm491570plj.190.2022.12.22.05.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 05:18:11 -0800 (PST)
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
Subject: [PATCH v4 06/16] arm64: dts: qcom: sc8280xp: Fix the base addresses of LLCC banks
Date:   Thu, 22 Dec 2022 18:46:46 +0530
Message-Id: <20221222131656.49584-7-manivannan.sadhasivam@linaro.org>
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
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 109c9d2b684d..0510a5d510e7 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -1856,8 +1856,14 @@ opp-6 {
 
 		system-cache-controller@9200000 {
 			compatible = "qcom,sc8280xp-llcc";
-			reg = <0 0x09200000 0 0x58000>, <0 0x09600000 0 0x58000>;
-			reg-names = "llcc_base", "llcc_broadcast_base";
+			reg = <0 0x09200000 0 0x58000>, <0 0x09280000 0 0x58000>,
+			      <0 0x09300000 0 0x58000>, <0 0x09380000 0 0x58000>,
+			      <0 0x09400000 0 0x58000>, <0 0x09480000 0 0x58000>,
+			      <0 0x09500000 0 0x58000>, <0 0x09580000 0 0x58000>,
+			      <0 0x09600000 0 0x58000>;
+			reg-names = "llcc0_base", "llcc1_base", "llcc2_base",
+				    "llcc3_base", "llcc4_base", "llcc5_base",
+				    "llcc6_base", "llcc7_base",  "llcc_broadcast_base";
 			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-- 
2.25.1

