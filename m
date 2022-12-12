Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4202A649EE3
	for <lists+linux-edac@lfdr.de>; Mon, 12 Dec 2022 13:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbiLLMf7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 12 Dec 2022 07:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbiLLMfR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 12 Dec 2022 07:35:17 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C429C02
        for <linux-edac@vger.kernel.org>; Mon, 12 Dec 2022 04:34:39 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so12031514pjd.5
        for <linux-edac@vger.kernel.org>; Mon, 12 Dec 2022 04:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apPGFedAv3uAmQAp6xD4tNC7N1DZdKzki801rLgGfFs=;
        b=rvpNc8D4tUlWJjtdcx6r2kqPUvDpcCZXEVp8rHRZOdG2ZylbdXSlA8X1WBvN3Dcze+
         AqowEJ/9OFPO3NuyEVu89W2Orgo1iLJY3jmbYAXE6QvpdTh4I4ctkJMUq90CF/BX7lfL
         wad84Nmgs7J6W8BRaaSM5GcgN8dmrcwRN9QPNACcBPyZOqhO7pziTJPcx+ht4ft6YBwc
         i/BcTPWVq4YlLIw/zLf4Ilk/vQEByu5A9DwIWXQ8PkZpSs4Yqg7HOBoJl9OGUjgEvTPj
         Bcxhyv2FEGNfVvupN4jXpr/eQVVFIgLWmSC16XdVCZQXba6uXFWN1upJfaCW4yOhXL4Q
         v8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=apPGFedAv3uAmQAp6xD4tNC7N1DZdKzki801rLgGfFs=;
        b=69HZyuHFYP5CtlslOYbCM0TafEhcTzAKSBpazr2eOIRujb+WrakUS6f+coYLYm+DJd
         7dKUkZVNj5i6sj5eshPQkfWcF30Lud0r7yZ0Fl6UZTe076CSqOlazza6w0ioWYV4cYqP
         0noNuZqJjmn8w1hRpkxRH/c4ZauNP15n6PnMsVq9RigtrU/H2Qo0kmV1aWftme+wXa2x
         2Nb901bh1J9jneWW62/mz5kX2y+3XKkZw8sfxSX0N5/utZukUjQzhdlZTIL/tS19s3Ie
         FnQqCZSD0CGY9fAEgrthpW0iiTqACgbqI7tD2NzWmsmrupPikqGz/VlGi9NtezLhM0OO
         4Pfg==
X-Gm-Message-State: ANoB5pn+rn46+KuE2PGfPiWlSuh6xp3coplo6msal7dpCLnDAf5oAEq2
        Zqa8hw5V1m9rzn1wauO5K8fH
X-Google-Smtp-Source: AA0mqf6+LShJsPN+/zqNTsvXdXBN/B4lMNcCK1WC0YzDvfRhwPh9u2OTOAPd9dPQ9F4U87PLHnaagw==
X-Received: by 2002:a17:902:a70b:b0:187:ede:e014 with SMTP id w11-20020a170902a70b00b001870edee014mr15848859plq.44.1670848456668;
        Mon, 12 Dec 2022 04:34:16 -0800 (PST)
Received: from localhost.localdomain ([220.158.159.33])
        by smtp.gmail.com with ESMTPSA id j14-20020a170902da8e00b00189c93ce5easm6252557plx.166.2022.12.12.04.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 04:34:15 -0800 (PST)
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
Subject: [PATCH v2 09/13] arm64: dts: qcom: sm8350: Fix the base addresses of LLCC banks
Date:   Mon, 12 Dec 2022 18:03:07 +0530
Message-Id: <20221212123311.146261-10-manivannan.sadhasivam@linaro.org>
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

Cc: <stable@vger.kernel.org> # 5.17
Fixes: 9ac8999e8d6c ("arm64: dts: qcom: sm8350: Add LLCC node")
Reported-by: Parikshit Pareek <quic_ppareek@quicinc.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 245dce24ec59..7f76778e1bc8 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2513,8 +2513,9 @@ gem_noc: interconnect@9100000 {
 
 		system-cache-controller@9200000 {
 			compatible = "qcom,sm8350-llcc";
-			reg = <0 0x09200000 0 0x1d0000>, <0 0x09600000 0 0x50000>;
-			reg-names = "llcc_base", "llcc_broadcast_base";
+			reg = <0 0x09200000 0 0x58000>, <0 0x09280000 0 0x58000>,
+			      <0 0x09300000 0 0x58000>, <0 0x09380000 0 0x58000>,
+			      <0 0x09600000 0 0x58000>;
 		};
 
 		usb_1: usb@a6f8800 {
-- 
2.25.1

