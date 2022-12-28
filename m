Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C49657421
	for <lists+linux-edac@lfdr.de>; Wed, 28 Dec 2022 09:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbiL1Im7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 28 Dec 2022 03:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbiL1ImV (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 28 Dec 2022 03:42:21 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FDA101CE
        for <linux-edac@vger.kernel.org>; Wed, 28 Dec 2022 00:41:44 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id w37so10187915pga.5
        for <linux-edac@vger.kernel.org>; Wed, 28 Dec 2022 00:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3b0H9FlwI0cHeu/QvvhJdFruV0iaHa3piiWtATy1Lw=;
        b=kBSZ1t+GTRC3OHYUNF4styvFpo4TJhUf7z0CDD6j4ujk5g/Q1WobBQMKCew6VXvXgz
         G5xfkeHZg6fNcOtQ1KlMJ4MNYlCqLZEMDh6v9C82kmMm+/mVieUTsa2mNKm7HwyunWd1
         fuKyz2/kC/m3F90TkIKQT6YdZhLZhStrZMS/yu6fI5HlpLMf25y0LsYVQgEhhEc9FMqc
         N7nWQcFfoyBjfZ1VnltBlKWPYQm2JiySPE0iwyBX0vrldan/S5JtrM3KqhJksBJbWXqQ
         r5CmWllE3nKhCut7+hyjPUQEArO0Ux4YOWBf1gJCZgek2o+arIa6CqOWQotrkvySua4v
         FsCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3b0H9FlwI0cHeu/QvvhJdFruV0iaHa3piiWtATy1Lw=;
        b=Vpgstnb2tyoLt0Wn7Nw4eIuAPjMehh8au5j7SbEmZHepmj1ngSkzzmCFTowDxTSXr2
         6n9DSsLuWQGYDeGMBqLzTEto+66qEVp/r7NeQqvNL4DAQlsdWnLh2r0Vo9dHVR9b9/U6
         yLhAxDkKhCltkBd3G3M764iXwzVIxFW8JvZVkNZ1czC5IMEe0pFRGQ5H+jbgFSbsgzQr
         TdNABIH/y0a35+/WewFmTyMB43VKF7y+HjMdM54fuMp30CotCzB2VH/qlyDCMsLRrYHY
         V/dhldFfUbgr7pcGAnl/58jwNy+ksEsx44XoojqPeGLy5wCzB2Cp1/Zn/JOWLeogBdpp
         8b/w==
X-Gm-Message-State: AFqh2kpzfAnAFqmoFy6boPVspwyWstfyFZJMcIMPIjovDcrBa6XX3VtA
        hHMUX85S7ab63li9iNgCNP7c
X-Google-Smtp-Source: AMrXdXt3wEnaBxmKKc+THXJmZZQodrKRWEZGxG+TcvQ9deo7zYP1wV+ItZNcl0gY5TwuRP/6CiAjzA==
X-Received: by 2002:aa7:9290:0:b0:580:c8a1:70c4 with SMTP id j16-20020aa79290000000b00580c8a170c4mr14887725pfa.29.1672216903726;
        Wed, 28 Dec 2022 00:41:43 -0800 (PST)
Received: from localhost.localdomain ([117.217.178.73])
        by smtp.gmail.com with ESMTPSA id d188-20020a6236c5000000b0057a9b146592sm9786286pfa.186.2022.12.28.00.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 00:41:42 -0800 (PST)
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
Subject: [PATCH v5 08/17] arm64: dts: qcom: sc7280: Fix the base addresses of LLCC banks
Date:   Wed, 28 Dec 2022 14:10:19 +0530
Message-Id: <20221228084028.46528-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221228084028.46528-1-manivannan.sadhasivam@linaro.org>
References: <20221228084028.46528-1-manivannan.sadhasivam@linaro.org>
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

