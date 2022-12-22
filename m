Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E0E654192
	for <lists+linux-edac@lfdr.de>; Thu, 22 Dec 2022 14:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbiLVNRb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 22 Dec 2022 08:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235428AbiLVNR2 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 22 Dec 2022 08:17:28 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6162B24F
        for <linux-edac@vger.kernel.org>; Thu, 22 Dec 2022 05:17:27 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id gt4so1895075pjb.1
        for <linux-edac@vger.kernel.org>; Thu, 22 Dec 2022 05:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V3mjjY5oD2bC4wc6eiPV1Dq89HSgafk5fg8eT5Cs6OI=;
        b=TvN2wOIu2j023gt7Gr/266m7XNbgaXcfTKr8Q7WLEcuinVQUT5k6MkdYQJnlDQ71jg
         t8jCt0fFwNUE3f1zp4s9nU9py2ncUAzFTNjAOS6qQOgdmjkP4jg+QD+MyTeuJN8WLvv1
         uBRPkUZl7Ky6q984VNVrGLpqBCIjICRyHW0600RmBW8yCe6M32TkjfGmBYGqydUYuTKE
         9W3/uPni7VavdYXqRh6BoHCvabS5ixIqpXpSKkIvtzdLpz1VdjEzV1PNAz+h+0aNC9sO
         UtkKkZ5kTAwhdF41mBKlDRonD3zxcSVqTumNcJiqx2hSVpM+T1zkpY4JhdiFPuRGeKIo
         IEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V3mjjY5oD2bC4wc6eiPV1Dq89HSgafk5fg8eT5Cs6OI=;
        b=a7SA2QNr2mUDALJ4qH5ZZvXSybNIITzs5ZLtydKQZPjdpWEgABB8kPRBixXkc1XauJ
         n2v8jdvcXdcRzxw2PBcEANpPy5ufGmDN9CaJABrXJqz3q9Xgwqk1u2cTzoYPMX03L1+8
         8C+Im7oZlupM2ceHEMdxdgB9rZrDV8XiAax3uDDrmqa6dbG1RGR7outoypgELG+GdSAM
         6r3+sLZkrEJMMxluGjAVND1kW5f8kWHczrHdJdufVi6QSz2yoAQoGx8mCgS4J2Cf1RyE
         T0Qz6UpwTTExNvK16HHBvH9IdGimbACRy/gg+XSTNNKa9OrsBZRrNRgdbtJk6APYuJPj
         Cm2A==
X-Gm-Message-State: AFqh2koKs/YjG0vDIHc80aizfopqXqzAcd5l9iP54Y+Y4EIlpezkmFRc
        NTcC/pUh0c/advLn6012T2VU
X-Google-Smtp-Source: AMrXdXuN36BEUdpY92cMDd0JZE8pGcMks0DSzY5HQFsr+EB+wPIwelv0Zz/6eXbAXCGVtgELxSyacg==
X-Received: by 2002:a17:902:ea91:b0:189:c6fb:f933 with SMTP id x17-20020a170902ea9100b00189c6fbf933mr20094759plb.28.1671715046817;
        Thu, 22 Dec 2022 05:17:26 -0800 (PST)
Received: from localhost.localdomain ([117.217.177.99])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902fe0c00b001896040022asm491570plj.190.2022.12.22.05.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 05:17:25 -0800 (PST)
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
Subject: [PATCH v4 00/16] Qcom: LLCC/EDAC: Fix base address used for LLCC banks
Date:   Thu, 22 Dec 2022 18:46:40 +0530
Message-Id: <20221222131656.49584-1-manivannan.sadhasivam@linaro.org>
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

This series affects multiple platforms but I have only tested this on
SM8250, SM8450, and SM6350. Testing on other platforms is welcomed.

Thanks,
Mani

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

Manivannan Sadhasivam (16):
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
  EDAC/qcom: Do not pass llcc_driv_data as edac_device_ctl_info's
    pvt_info
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
 drivers/edac/qcom_edac.c                      |  63 +++++----
 drivers/soc/qcom/llcc-qcom.c                  |  85 ++++++------
 include/linux/soc/qcom/llcc-qcom.h            |   6 +-
 14 files changed, 243 insertions(+), 95 deletions(-)

-- 
2.25.1

