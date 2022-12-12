Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA18649EBC
	for <lists+linux-edac@lfdr.de>; Mon, 12 Dec 2022 13:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbiLLMdw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 12 Dec 2022 07:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiLLMd2 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 12 Dec 2022 07:33:28 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E153F59B
        for <linux-edac@vger.kernel.org>; Mon, 12 Dec 2022 04:33:26 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id gt4so10221486pjb.1
        for <linux-edac@vger.kernel.org>; Mon, 12 Dec 2022 04:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alhK3ndi55Pn+UAZvehWSr5HT0WJYLohN8j26G14+mg=;
        b=qQu0KWtTsFZWdV2sgVCoDF3kIQeVcPNBTz1gprS37Trlf5kvhITuKFb77t0cE2+p0X
         ZrHStY317cD6gGjT64Jv9Hs+NJC1Kt8FMbQrJLmJWO+fbzjSkIXQj4xIq9171qJfb54c
         /bgEAeuR1jxftiiHNG961TjiKDzHELKKP9LIiGhP0K5hOgSWbjV/J84RAqRsuVahWzpD
         cKlgfh4+JAHYm+nmzxDZBhw1ELNJ+kyoIdFNUzbRbaAmGuuWf0w6b/1M/Fr2faKOzeJQ
         nIaYxdQQ9WtePfcI2YFxuOIbpk2pzKi59X4wy53mqLHUnp4cx4WVHYitfVc697GcFkYP
         FJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=alhK3ndi55Pn+UAZvehWSr5HT0WJYLohN8j26G14+mg=;
        b=WyyMNLfQP8xC6lI9w4XYGeH3AX3cjxx4M2wB0dLNSHjtTw0LQ3xsY5s8t8MQjGHemz
         4HJ3BkMuSEBqzuIBpDWi0HIUvwg5IuQ6P7H2zOS2dxkc5bFHpJU+ozhtLbO91ntNYvim
         OPUHXyo7CvGJLbNF6d0IGWD2KLg6SVfwv0Fn07sRjKD7JnqVTaEAybOthINdA8rvRLZz
         Eaz4Fq28U7HFVUpwrlaopf5J5c4Umeea6JTbGhdKihMqqnTocT7Zv9ieiNJasUdSebg2
         +dIKKatIeVqn6lP8ICHveU399G7XcERvOYo7yJ/9uIhHLmr6RcSV+81tps+rmJPpqSuB
         dNFg==
X-Gm-Message-State: ANoB5pn5L8oT3SfGc+IDBDwvsxs/Javlrm+CP4M7aassKQbYFdRZKYR/
        /0INMPptOA/QnLdg+wthUGuY
X-Google-Smtp-Source: AA0mqf76W0vYctaP4uQGyTxz6lzA6fM+RGW0zYYAEweKJgILQ/VqIjWxTs1rUO32oLY1EHGDhJaxmA==
X-Received: by 2002:a17:902:9b97:b0:189:9e91:762e with SMTP id y23-20020a1709029b9700b001899e91762emr15738614plp.57.1670848406037;
        Mon, 12 Dec 2022 04:33:26 -0800 (PST)
Received: from localhost.localdomain ([220.158.159.33])
        by smtp.gmail.com with ESMTPSA id j14-20020a170902da8e00b00189c93ce5easm6252557plx.166.2022.12.12.04.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 04:33:25 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com
Cc:     quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        luca.weiss@fairphone.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 01/13] dt-bindings: arm: msm: Update the maintainers for LLCC
Date:   Mon, 12 Dec 2022 18:02:59 +0530
Message-Id: <20221212123311.146261-2-manivannan.sadhasivam@linaro.org>
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

Rishabh Bhatnagar has left Qualcomm, and there is no evidence of him
maintaining with a new identity. So his entry needs to be removed.

Also, Sai Prakash Ranjan's email address should be updated to use
quicinc domain.

Cc: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Acked-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
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

