Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05846541B9
	for <lists+linux-edac@lfdr.de>; Thu, 22 Dec 2022 14:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbiLVNTV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 22 Dec 2022 08:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235541AbiLVNSx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 22 Dec 2022 08:18:53 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994582B265
        for <linux-edac@vger.kernel.org>; Thu, 22 Dec 2022 05:18:49 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id t2so2009509ply.2
        for <linux-edac@vger.kernel.org>; Thu, 22 Dec 2022 05:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znASgBClq0rwhBOl4/Fw1c5T/s1foKbyxf4XPqRiKDI=;
        b=VXe+Xf10elUr+UnSO49j92OhvgPpDswCeSmg+CP9iS6mREZbL8qbFc661pe6BPRjfQ
         S3oNVU7zYqI9S1bS7I58nmbbA8es6jmQ8pwyAbsbtAM9JJNu3C53jeDKRxU7zvt1xzSS
         ZFR7zig5z3K+G8wse0/DQhpC6YKUPAVB4WSwfAxXcprqqx7YKa4ShdLkmbLNPILPPFYj
         pS0zS4x976uQd/9EIjjzzwX5G9bm8b7a91lqP78l2dYEd86dCFaIDGRFs+0TZ00WTUC3
         RgkVd4NehMkFcgHCza83ksV8+nHNj/ZIlImHcPegVB9YmotZURTeMSUfuO0CHz9Ezn0L
         Dz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=znASgBClq0rwhBOl4/Fw1c5T/s1foKbyxf4XPqRiKDI=;
        b=iXZGEdvu9vmWzqBFD8Mj34NZldbjmY5GCRmrtdf7eSzRkgurkvOjHGDwgjt0MZyXI7
         P0m8y5Jqb6efzas828memaS1tz1q1EknZjFw82uYOc8yQ1ZyxzZmVWP062JZqksTCsOX
         kRGlPcn8X8PVFcbYY3fgKmWDjL6swSfaqcONvxBl7NsT1HO4IgSat1SaWQY5EABGwdka
         9kw7YRQpOHzO8akWXd54Kx/M4iJ6wx+TKELJsDYj6KOxUQzfeZP2R7CC/vAb205JyVwa
         jexxrliw4lKGH8DD0O3JRXIXqQ+wYolWNucPD3TIV8U9YZoKwwsSYpefCUeuxfnVWlhv
         KpXA==
X-Gm-Message-State: AFqh2kqpc/Dy43Ek3Q0FElmPXXmAvSmXzvWQGEUHIQfikFhGc+JmvehI
        u4zUO1TXPjAa0HzfgaUuvjOq
X-Google-Smtp-Source: AMrXdXtjtf4dX/X47BtcJcA5+3mMzsRKeuSSmtjKeWq+FivoGU2p4egWef1dD/S8nEDd112vlehkAg==
X-Received: by 2002:a17:902:c382:b0:189:e3d0:2682 with SMTP id g2-20020a170902c38200b00189e3d02682mr6521113plg.30.1671715129086;
        Thu, 22 Dec 2022 05:18:49 -0800 (PST)
Received: from localhost.localdomain ([117.217.177.99])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902fe0c00b001896040022asm491570plj.190.2022.12.22.05.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 05:18:48 -0800 (PST)
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
Subject: [PATCH v4 11/16] arm64: dts: qcom: sm6350: Fix the base addresses of LLCC banks
Date:   Thu, 22 Dec 2022 18:46:51 +0530
Message-Id: <20221222131656.49584-12-manivannan.sadhasivam@linaro.org>
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

On SM6350, there is only one LLCC bank available. So let's just pass that
as "llcc0_base".

Reported-by: Parikshit Pareek <quic_ppareek@quicinc.com>
Tested-by: Luca Weiss <luca.weiss@fairphone.com>
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

