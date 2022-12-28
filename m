Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD11065728C
	for <lists+linux-edac@lfdr.de>; Wed, 28 Dec 2022 05:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiL1Ebo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 27 Dec 2022 23:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiL1Ebn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 27 Dec 2022 23:31:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF7D10EF;
        Tue, 27 Dec 2022 20:31:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46A9C612E7;
        Wed, 28 Dec 2022 04:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B416C433EF;
        Wed, 28 Dec 2022 04:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672201901;
        bh=ZkG1Exf4xkV04v9dJDH1Pi4nWr9tw+L2yNWka7Wy67Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q7BowHevQk8FgUpwyRGNTMCdcBV1HZTAnZlV+mMb4IDxiLHtB87UFNRy0N41QD9Mv
         e7WgAEInf4zc2lF40ci3TiZ2KUw7rOaq55h1/YDFYPWYvwmM1wxZm/JPppxk4YLKGG
         ETADFVePUjW8qyTI4txSE6qu1csEi7y6auRXmef2eJGY4EqNf7JnsPdOo9qAt7mZ06
         GfhQ3hKxTGUxJK2rxKrYZfqwsrjAy3/3p+egoEBJ1iof/EqncwrkdlH12sH9s3ZBsp
         RnscTsgTBr99WrMEsJD0AdDXrWH+uesNrBp9fPyUIOf25Vu/MpVK2E0kdHUZeiwFZb
         6uBL7qC9evj4A==
Date:   Tue, 27 Dec 2022 22:31:38 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        bp@alien8.de, tony.luck@intel.com, quic_saipraka@quicinc.com,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
        quic_ppareek@quicinc.com, luca.weiss@fairphone.com,
        ahalaney@redhat.com, steev@kali.org
Subject: Re: [PATCH v4 00/16] Qcom: LLCC/EDAC: Fix base address used for LLCC
 banks
Message-ID: <20221228043138.2p2qtjhrfaenptpe@builder.lan>
References: <20221222131656.49584-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222131656.49584-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Dec 22, 2022 at 06:46:40PM +0530, Manivannan Sadhasivam wrote:
> The Qualcomm LLCC/EDAC drivers were using a fixed register stride for
> accessing the (Control and Status Regsiters) CSRs of each LLCC bank.
> This offset only works for some SoCs like SDM845 for which driver support
> was initially added.
>     
> But the later SoCs use different register stride that vary between the
> banks with holes in-between. So it is not possible to use a single register
> stride for accessing the CSRs of each bank. By doing so could result in a
> crash with the current drivers. So far this crash is not reported since
> EDAC_QCOM driver is not enabled in ARM64 defconfig and no one tested the
> driver extensively by triggering the EDAC IRQ (that's where each bank
> CSRs are accessed).
>     
> For fixing this issue, let's obtain the base address of each LLCC bank from
> devicetree and get rid of the fixed stride.
> 
> This series affects multiple platforms but I have only tested this on
> SM8250, SM8450, and SM6350. Testing on other platforms is welcomed.
> 
> Thanks,
> Mani
> 
> Changes in v4:
> 
> * Added a patch that fixes the use-after-free bug in qcom_edac driver
> 
> Changes in v3:
> 
> * Brought back reg-names property for compatibility (Krzysztof)
> * Removed Fixes tag and stable list as backporting the drivers/binding/dts
>   patches alone would break (Krzysztof)
> * Fixed the uninitialized variable issue (Kbot)
> * Added a patch to make use of driver supplied polling interval (Luca)
> * Added a patch for module autoloading (Andrew)
> * Didn't collect Review tags from Sai as the dts patches were changed.
> 
> Changes in v2:
> 
> * Removed reg-names property and used index of reg property to parse LLCC
>   bank base address (Bjorn)
> * Collected Ack from Sai for binding
> * Added a new patch for polling mode (Luca)
> * Renamed subject of patches targeting SC7180 and SM6350
> 
> Manivannan Sadhasivam (16):
>   dt-bindings: arm: msm: Update the maintainers for LLCC
>   dt-bindings: arm: msm: Fix register regions used for LLCC banks
>   arm64: dts: qcom: sdm845: Fix the base addresses of LLCC banks
>   arm64: dts: qcom: sc7180: Fix the base addresses of LLCC banks
>   arm64: dts: qcom: sc7280: Fix the base addresses of LLCC banks
>   arm64: dts: qcom: sc8280xp: Fix the base addresses of LLCC banks
>   arm64: dts: qcom: sm8150: Fix the base addresses of LLCC banks
>   arm64: dts: qcom: sm8250: Fix the base addresses of LLCC banks
>   arm64: dts: qcom: sm8350: Fix the base addresses of LLCC banks
>   arm64: dts: qcom: sm8450: Fix the base addresses of LLCC banks
>   arm64: dts: qcom: sm6350: Fix the base addresses of LLCC banks
>   EDAC/device: Make use of poll_msec value in edac_device_ctl_info
>     struct
>   EDAC/qcom: Add platform_device_id table for module autoloading
>   EDAC/qcom: Do not pass llcc_driv_data as edac_device_ctl_info's
>     pvt_info

Can you clarify if these patches needs to be applied in the specific
order, or if the EDAC changes can go in independently of the llcc driver
changes?

Thanks,
Bjorn

>   qcom: llcc/edac: Fix the base address used for accessing LLCC banks
>   qcom: llcc/edac: Support polling mode for ECC handling
> 
>  .../bindings/arm/msm/qcom,llcc.yaml           | 128 ++++++++++++++++--
>  arch/arm64/boot/dts/qcom/sc7180.dtsi          |   2 +-
>  arch/arm64/boot/dts/qcom/sc7280.dtsi          |   5 +-
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi        |  10 +-
>  arch/arm64/boot/dts/qcom/sdm845.dtsi          |   7 +-
>  arch/arm64/boot/dts/qcom/sm6350.dtsi          |   2 +-
>  arch/arm64/boot/dts/qcom/sm8150.dtsi          |   7 +-
>  arch/arm64/boot/dts/qcom/sm8250.dtsi          |   7 +-
>  arch/arm64/boot/dts/qcom/sm8350.dtsi          |   7 +-
>  arch/arm64/boot/dts/qcom/sm8450.dtsi          |   7 +-
>  drivers/edac/edac_device.c                    |   2 +-
>  drivers/edac/qcom_edac.c                      |  63 +++++----
>  drivers/soc/qcom/llcc-qcom.c                  |  85 ++++++------
>  include/linux/soc/qcom/llcc-qcom.h            |   6 +-
>  14 files changed, 243 insertions(+), 95 deletions(-)
> 
> -- 
> 2.25.1
> 
