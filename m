Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AB3654196
	for <lists+linux-edac@lfdr.de>; Thu, 22 Dec 2022 14:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbiLVNRv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 22 Dec 2022 08:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235423AbiLVNRm (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 22 Dec 2022 08:17:42 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C682B25D
        for <linux-edac@vger.kernel.org>; Thu, 22 Dec 2022 05:17:35 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so1836999pjm.2
        for <linux-edac@vger.kernel.org>; Thu, 22 Dec 2022 05:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USFa3vv6r3M6at72+GYbrAEuQqTIcmw3cLL2W4/Vhuk=;
        b=n7aSVFF/XLTOv6FrKLmFAXkYEpQlwu5xvBMfaF/KeAVsnD9B8sRvW9jIGMlI4kpfRZ
         29+RZt6RYVECcvyqzdWeS73J0pFr2puJUtokcq7CF/XJ69QKKTNErmZGJQzvpJTJ6mqb
         Or8YsDrbocMGp1YqlXneOKPUvl6U+gm52uBmOgqGsWrbf5SiQ3GQt37FYDlgdm3Rr8ti
         CWODXN45P21Bz27lpM4J28cV/oZwZTii4DfUqC6VWkM6ZREGXiGBYAaKuSusRxcU2o9z
         xzQnWFnf9mHmiMEFyQWnBxVJj8AX6axnfsKJDtpMWTlRngoszvw/uSNiLa+LghTniuiA
         L1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=USFa3vv6r3M6at72+GYbrAEuQqTIcmw3cLL2W4/Vhuk=;
        b=R/hHNoocIZgbPb+YCxLAmnioSW0hD/hyWjy0qewYgOJq+pC8uAwIno0VInkQoIUhqm
         zP/hjk8GyTv6INv04x4euRsktmjwqMgJZIyH/ZMf7s3x3Vj6B23A1sU2jNgdzLHCBVt0
         RAV8CqXHV7uaEWkaH0gs8LlRZ8hrJCcS23Mi8S/Ip/krPDscYip60JAjSv8wrZKGFwoS
         UGY6NFuABGfl7s874rIuDcK6IF5FG+5czBwhnmjz0BOFi3EH94lRmC/pLip+ABUsROtf
         wkKDjEU+q8X7yesvpcQuQJYoFZtE1FHm08zFJBwq/8fmFjcJ8ePzmH5bSG7Z91/yo6Db
         cOMw==
X-Gm-Message-State: AFqh2kpexlLS2OUsnq2RuLircXECBhxxUVxp23Ul5pkI6OS4pYDy1r8s
        tZ/RlJxfNmdIOmK5UVriYuZt
X-Google-Smtp-Source: AMrXdXuQ+EqK/3gOMscN/wnCEi/fM+XH7w5vmRz7TDRzrianSyLuaXhMJIDGmfkpZ0U2BhNZdDDBgw==
X-Received: by 2002:a05:6a20:a6a8:b0:9d:efd3:66bf with SMTP id ba40-20020a056a20a6a800b0009defd366bfmr7065991pzb.6.1671715054802;
        Thu, 22 Dec 2022 05:17:34 -0800 (PST)
Received: from localhost.localdomain ([117.217.177.99])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902fe0c00b001896040022asm491570plj.190.2022.12.22.05.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 05:17:33 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com
Cc:     quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        luca.weiss@fairphone.com, ahalaney@redhat.com, steev@kali.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 01/16] dt-bindings: arm: msm: Update the maintainers for LLCC
Date:   Thu, 22 Dec 2022 18:46:41 +0530
Message-Id: <20221222131656.49584-2-manivannan.sadhasivam@linaro.org>
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

Rishabh Bhatnagar has left Qualcomm, and there is no evidence of him
maintaining with a new identity. So his entry needs to be removed.

Also, Sai Prakash Ranjan's email address should be updated to use
quicinc domain.

Cc: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Acked-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
index 38efcad56dbd..d1df49ffcc1b 100644
--- a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
@@ -7,8 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Last Level Cache Controller
 
 maintainers:
-  - Rishabh Bhatnagar <rishabhb@codeaurora.org>
-  - Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
+  - Sai Prakash Ranjan <quic_saipraka@quicinc.com>
 
 description: |
   LLCC (Last Level Cache Controller) provides last level of cache memory in SoC,
-- 
2.25.1

