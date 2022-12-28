Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41AD9657400
	for <lists+linux-edac@lfdr.de>; Wed, 28 Dec 2022 09:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbiL1IlA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 28 Dec 2022 03:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbiL1Ik5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 28 Dec 2022 03:40:57 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27561D3
        for <linux-edac@vger.kernel.org>; Wed, 28 Dec 2022 00:40:42 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id k19so2605840pfg.11
        for <linux-edac@vger.kernel.org>; Wed, 28 Dec 2022 00:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=upvEDusjxGXHtrTFd/h6/9Atzs+zFMDkhyOWz4mxZUs=;
        b=o/avvO6tpKj3lCeujTVVFi9HofNLe6IPJYloXe22hk7xEspCZZOvD7JnI9j7iVreB3
         gskaHrfVZMrA+7RqU3wMFXT6eWLGhDGNJftq3TgYXDwJ7tgxoCgMJXfmfQ3aPk6P0R/f
         XC9KFNNbobE5vsQkFJAmb/StNTCgmqqJhG6vmHPoca6nYMpYpMmQKJN8T+d6Z0e5PQ6y
         WbkSjo2ECT/MDIxsR0cWfTxTHq4ZdQouFykwlprQnRzAsfQi55Qrm7W3shciI2jjZIMl
         tWUnbmcweASYjXdMx9crst7vplr3AHawmPCsLpXdRMv/wYCetbFwAOBgv7Dwzx7vtTaC
         pjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=upvEDusjxGXHtrTFd/h6/9Atzs+zFMDkhyOWz4mxZUs=;
        b=P3Ifj3EbFNpx52eJyi4I8TuD5PkYxRb4+HBdH25uH5XgQvQE+87M6JZ8bl9lu+Um+7
         fiakqhAU0637XZziExw+1M0VxEpyqZenZeCFQpiSor2HEhPzAsTGoIRARNGPc7z97MnQ
         r8R3tKixZ8wqo7mhA1zAF/1vZefbtgGus4zZLRFTWwJf3vNdU8qn9SumjoRo5vCWgmrI
         phjF/41UwbO7t5Jn3iDUX3rf2tfNXl3VlI+JqAE36c5yJ8CWjXmq+P6A8O9bi8vPV0vd
         C8cRix2rqZPegbpF6ODtGviBYmYxLbueJPNUX/ykFJe0i9HN8Di8WB5jYVZ7WGGtvkND
         KcjA==
X-Gm-Message-State: AFqh2kpLWIia49LTrpa7g5Ws1B4akyutrgkcHI2yCvFLs9Jn4hYhfNSb
        qLgUA+uY1VG52da4yhU2RbQY
X-Google-Smtp-Source: AMrXdXsjo87+COX2AueXW+gEKyg8L16tQg46b7p6iFL187j5glnZ1DmSDNFhl3CXgcCDz+oyuXU4FA==
X-Received: by 2002:a62:5241:0:b0:56a:d3ff:f4b2 with SMTP id g62-20020a625241000000b0056ad3fff4b2mr25495156pfb.10.1672216842113;
        Wed, 28 Dec 2022 00:40:42 -0800 (PST)
Received: from localhost.localdomain ([117.217.178.73])
        by smtp.gmail.com with ESMTPSA id d188-20020a6236c5000000b0057a9b146592sm9786286pfa.186.2022.12.28.00.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 00:40:41 -0800 (PST)
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
Subject: [PATCH v5 00/17] Qcom: LLCC/EDAC: Fix base address used for LLCC banks
Date:   Wed, 28 Dec 2022 14:10:11 +0530
Message-Id: <20221228084028.46528-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
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

This series has been tested on SM8250, SM8450, SM6350, SC8280XP, SA8540P,
and SDM845.

Merging strategy
----------------

Patches 1/17, 2/17 and 3/17 can be merged independently to EDAC tree. Rest of
the patches should be merged to qcom tree due to LLCC dependency.

Thanks,
Mani

Changes in v5:

* Reduced the size of llcc0 to 0x45000 on SDM845 due to overlapping with BWMON
* Added a patch to disable creation of EDAC platform device on SDM845
* Rebase on top of v6.2-rc1
* Moved the EDAC specific patches to the start so that they can be applied
  independently of LLCC patches

Changes in v4:

* Added a patch that fixes the use-after-free bug in qcom_edac driver

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

Manivannan Sadhasivam (17):
  EDAC/device: Make use of poll_msec value in edac_device_ctl_info
    struct
  EDAC/qcom: Add platform_device_id table for module autoloading
  EDAC/qcom: Do not pass llcc_driv_data as edac_device_ctl_info's
    pvt_info
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
  qcom: llcc/edac: Fix the base address used for accessing LLCC banks
  qcom: llcc/edac: Support polling mode for ECC handling
  soc: qcom: llcc: Do not create EDAC platform device on SDM845

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
 drivers/edac/qcom_edac.c                      |  63 +++++----
 drivers/soc/qcom/llcc-qcom.c                  |  80 ++++++-----
 include/linux/soc/qcom/llcc-qcom.h            |   6 +-
 14 files changed, 244 insertions(+), 89 deletions(-)

-- 
2.25.1

