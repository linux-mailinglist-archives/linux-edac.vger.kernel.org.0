Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C22665742D
	for <lists+linux-edac@lfdr.de>; Wed, 28 Dec 2022 09:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbiL1Inm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 28 Dec 2022 03:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiL1InH (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 28 Dec 2022 03:43:07 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB66FD06
        for <linux-edac@vger.kernel.org>; Wed, 28 Dec 2022 00:42:14 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id f3so10194906pgc.2
        for <linux-edac@vger.kernel.org>; Wed, 28 Dec 2022 00:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMev9I+ZdryrTBjzJ8tiTgJp1UwzDLK7UbgCFoQvzyA=;
        b=hy4nC4E4al+dabRomp+OPrVVRBkiPqSdQSNvbzvr0h9pg+JqKsvvABpx/N94VxyQKO
         4Fc9F9yhAarvh4qVPjwL49Va/Ac8LACS+2UrPgzNKEoRKEyei1Ug5YubxpWyOCNIadU0
         uNwihQdr3mimAIBAXbUNUpnJAQ3Y7Y3DNCDiyAGV3QW14AYYG8Uk4fFWlFj05fBMMT2j
         apC3V24LXwNTLaQgHg3JUOn0541oMPFbmXp44QRI3TXZ6t7oANDyGRU/cIhzgWytqQ6V
         qRBmMAyP9p4ZxshXyE9BgRIAbMua0AaTzPpsNoNvYI2J1hHHpkpHBbXfo/9019QWhk3C
         A90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sMev9I+ZdryrTBjzJ8tiTgJp1UwzDLK7UbgCFoQvzyA=;
        b=DlMgSQxCeyvuO3HwoKLUDUAbrnMFEV6IoJHhk3FsQrs7nClGQuGxizuWIpTrQc/Fbi
         gIFit9qpVZF/GgkX/VK5tWp2aPoojlIGpmPcj6vy7jW/FD4mSXbUvM+I1HzdT8o3AmQV
         kDOkiShyEsteHEKk7WWkIiCSYDCKQbKLCUTnDozx5P2ZE4p3h3xfgVwLSSduYDA+oQKi
         mt0NRheucWB4AS+L/ayprriGqb7ewhLChP1eNFFOy9BFCb6kOgS8Ns2TiH7IFICWH91w
         Be6Jah9cDMM4zygiGpoeT1mlp5SE425A3uxVnam8B2Dp2vkCiYzbtI4acltMzg5R1t2X
         fbWA==
X-Gm-Message-State: AFqh2kqDK0/ABsNJlkmo2HDCXPEDHSImdN6qCWHjTX7xKIqOhOtUCHc0
        fI6My82pa9lmcVE9/P+G3bxh
X-Google-Smtp-Source: AMrXdXsdA71Nl1ydxefCHwsDLE8v0TrPoU4ByklG2203hhg+wQHNjtGUxESyx7kelBtm4Aeie4h7LA==
X-Received: by 2002:a62:1c84:0:b0:576:e4c7:97bf with SMTP id c126-20020a621c84000000b00576e4c797bfmr24944004pfc.15.1672216933591;
        Wed, 28 Dec 2022 00:42:13 -0800 (PST)
Received: from localhost.localdomain ([117.217.178.73])
        by smtp.gmail.com with ESMTPSA id d188-20020a6236c5000000b0057a9b146592sm9786286pfa.186.2022.12.28.00.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 00:42:12 -0800 (PST)
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
Subject: [PATCH v5 12/17] arm64: dts: qcom: sm8350: Fix the base addresses of LLCC banks
Date:   Wed, 28 Dec 2022 14:10:23 +0530
Message-Id: <20221228084028.46528-13-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221228084028.46528-1-manivannan.sadhasivam@linaro.org>
References: <20221228084028.46528-1-manivannan.sadhasivam@linaro.org>
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

