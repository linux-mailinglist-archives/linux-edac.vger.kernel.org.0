Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0136511D6
	for <lists+linux-edac@lfdr.de>; Mon, 19 Dec 2022 19:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbiLSSaR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 19 Dec 2022 13:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbiLSSaP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 19 Dec 2022 13:30:15 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC0B13DE5
        for <linux-edac@vger.kernel.org>; Mon, 19 Dec 2022 10:30:15 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so9672527pjj.4
        for <linux-edac@vger.kernel.org>; Mon, 19 Dec 2022 10:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1G3NXFW4UUz+6QtzfR/CfSJGpHyjejTUXh4e68lgT5c=;
        b=dN4u11KE96mHDW/tXYTo3zjAkaJ7vj/3wkioBiK63YT0lFCkevzo2IvHMuiIBEltyh
         N8n8Ks8ZPxMIM9YEiOoyuI3N1InmCARoktRaSwwRtkVtLZAZ1RjSsCOz6dxqL8yWrKoZ
         WSTOmWSmgUI8GxVRVNkxVdMXibod6QzSdR+etPCR803oXB9kbHBZh69NXTKV7GCbygqU
         5q0FCNnHklyejeCfzw3PRfCA9OmR/HSCE0wh0oMCjZl9kLcXQNzM19mPP2sm+2Vb0r7+
         /9YdmLVO7rS+2Qr3IroUQ7ppIW6jUYXBXo9fOwnYP/BKN7/O/INKquZxnTN1oSpO9SVe
         gvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1G3NXFW4UUz+6QtzfR/CfSJGpHyjejTUXh4e68lgT5c=;
        b=t0owsjSweRJJ/RZCuJ0v2MeKH+1ujukcfz4n/JZ26PRIFp9+7jPTOkqwTzBYLSmLIE
         uiRJFC8QSQ+MpLdfSfgD0oC9TL1fpf9G92n0c4ns1PsY7ClDDPIOnZFQ7M+lQw7Hb6sH
         8B7WZlR5XK3HtsOUrGh842LtICuTwNxwXOCMrXNnxTq7gJuPcq4NEkYCS13KLkrwsRLR
         GKFbLc+iT+/4CUE0ljrX66uEivw3yg39eQ6woZ+RK+/7xZ/sNHah9jqAtNi2ChqN2ZkB
         umsrbqXGc8xYECDfqMr0YxYUkeBHOJkfJMRh06fpY4vW1Y4Ngvu119xGmJFYwMUGgJ65
         Psfw==
X-Gm-Message-State: ANoB5pkdldeZlMhMaKeiDf5lA6hsdHRa8amxovmYXxtnvg64J6dpjrqp
        KI2wY3l/EOhWfzg6sewFLreu
X-Google-Smtp-Source: AA0mqf4jM7oInI2LCixBv5OmLx9UV712LyWWbi1Hiv6gkCpT3gusOcHo1TJpqpkalMltP4SDGN4hkg==
X-Received: by 2002:a17:902:ea86:b0:18f:a0de:6ad0 with SMTP id x6-20020a170902ea8600b0018fa0de6ad0mr33253223plb.55.1671474614460;
        Mon, 19 Dec 2022 10:30:14 -0800 (PST)
Received: from localhost.localdomain ([220.158.159.17])
        by smtp.gmail.com with ESMTPSA id d2-20020a170903230200b00186e34524e3sm7480979plh.136.2022.12.19.10.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 10:30:13 -0800 (PST)
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
Subject: [PATCH v3 00/15] Qcom: LLCC/EDAC: Fix base address used for LLCC banks
Date:   Mon, 19 Dec 2022 23:59:43 +0530
Message-Id: <20221219182958.476231-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
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

The Qualcomm LLCC/EDAC drivers were using a fixed register stride for
accessing the (Control and Status Regsiters) CSRs of each LLCC bank.
This offset only works for some SoCs like SDM845 for which driver support
was initially added.
    
But the later SoCs use different register stride that vary between the
banks with holes in-between. So it is not possible to use a single register
stride for accessing the CSRs of each bank. By doing so could result in a
crash with the current drivers. So far this crash is not reported since
EDAC_QCOM driver is not enabled in ARM64 defconfig and no one tested the
driver extensively by triggering the EDAC IRQ (that's where each bank
CSRs are accessed).
    
For fixing this issue, let's obtain the base address of each LLCC bank from
devicetree and get rid of the fixed stride.

This series affects multiple platforms but I have only tested this on
SM8250, SM8450, and SM6350. Testing on other platforms is welcomed.

Thanks,
Mani

Changes in v3:

* Brought back reg-names property for compatibility (Krzysztof)
* Removed Fixes tag and stable list as backporting the drivers/binding/dts
  patches alone would break (Krzysztof)
* Fixed the uninitialized variable issue (Kbot)
* Added a patch to make use of driver supplied polling interval (Luca)
* Added a patch for module autoloading (Andrew)
* Didn't collect Review tags from Sai as the dts patches were changed.

Changes in v2:

* Removed reg-names property and used index of reg property to parse LLCC
  bank base address (Bjorn)
* Collected Ack from Sai for binding
* Added a new patch for polling mode (Luca)
* Renamed subject of patches targeting SC7180 and SM6350

Manivannan Sadhasivam (15):
  dt-bindings: arm: msm: Update the maintainers for LLCC
  dt-bindings: arm: msm: Fix register regions used for LLCC banks
  arm64: dts: qcom: sdm845: Fix the base addresses of LLCC banks
  arm64: dts: qcom: sc7180: Fix the base addresses of LLCC banks
  arm64: dts: qcom: sc7280: Fix the base addresses of LLCC banks
  arm64: dts: qcom: sc8280xp: Fix the base addresses of LLCC banks
  arm64: dts: qcom: sm8150: Fix the base addresses of LLCC banks
  arm64: dts: qcom: sm8250: Fix the base addresses of LLCC banks
  arm64: dts: qcom: sm8350: Fix the base addresses of LLCC banks
  arm64: dts: qcom: sm8450: Fix the base addresses of LLCC banks
  arm64: dts: qcom: sm6350: Fix the base addresses of LLCC banks
  EDAC/device: Make use of poll_msec value in edac_device_ctl_info
    struct
  EDAC/qcom: Add platform_device_id table for module autoloading
  qcom: llcc/edac: Fix the base address used for accessing LLCC banks
  qcom: llcc/edac: Support polling mode for ECC handling

 .../bindings/arm/msm/qcom,llcc.yaml           | 128 ++++++++++++++++--
 arch/arm64/boot/dts/qcom/sc7180.dtsi          |   2 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi          |   5 +-
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        |  10 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |   7 +-
 arch/arm64/boot/dts/qcom/sm6350.dtsi          |   2 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi          |   7 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |   7 +-
 arch/arm64/boot/dts/qcom/sm8350.dtsi          |   7 +-
 arch/arm64/boot/dts/qcom/sm8450.dtsi          |   7 +-
 drivers/edac/edac_device.c                    |   2 +-
 drivers/edac/qcom_edac.c                      |  58 +++++---
 drivers/soc/qcom/llcc-qcom.c                  |  85 ++++++------
 include/linux/soc/qcom/llcc-qcom.h            |   6 +-
 14 files changed, 241 insertions(+), 92 deletions(-)

-- 
2.25.1

