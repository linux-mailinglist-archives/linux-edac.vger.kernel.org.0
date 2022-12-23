Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A87654BCA
	for <lists+linux-edac@lfdr.de>; Fri, 23 Dec 2022 04:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiLWDoN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 22 Dec 2022 22:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiLWDoM (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 22 Dec 2022 22:44:12 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF08F15706
        for <linux-edac@vger.kernel.org>; Thu, 22 Dec 2022 19:44:10 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id ud5so9393620ejc.4
        for <linux-edac@vger.kernel.org>; Thu, 22 Dec 2022 19:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uAg6QpfCdmOZD5L0y+vWW8hKAJS00JYx7WNIEcHc+PY=;
        b=Dyg6sM/QmgCRrzAtbGvnuW3URd404Wl3Ro4iY4FwJmjGLli6VWBYnDG6PJouC3sW07
         WOMzUpxv0aYzjVlWsIhMPSia2JP1cL2GTD7nHKLAw02nWbpYBxdBWS3UWT3Vvxg+Jm/6
         nnK3hWltjobeiiYJ3BFq7/Z0m9dl1BcUM4z4PTAtkCGuG9RAxtg6FlMuSjTQf4xFaC5d
         NzdLbjU0ZdOczYTjt3WWJB6wlVanaOK6w2KpyUM9WLezNPkOlhVCXStUq84qM7vuJSTc
         wrueSZ2THb+ELMXM19Iqi3WNpicYSPoIglXB2qhCbCb14rahgwNS1fXwsuoTwscnvocC
         FxxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uAg6QpfCdmOZD5L0y+vWW8hKAJS00JYx7WNIEcHc+PY=;
        b=ooR9EW7g53NGJ7C+UTSGHJ8G2zm34neeQ978Ka3K9EoGSwFsw20JmyOV+Lu0+ChAv5
         WMz5nmc5I2TN7AQieW+3AUpAQbfYRrXHPXyULJ7U8JnGNXD65PXO30luj35w69vZGjYs
         exSRNLRGRuGTBjXOt90lg/q6wR3sdm1eC1MQwdwHJ8Mj7WILo4aUoRzbOXHm8aTiRGnQ
         QPXQegL55of5uSQwzi6Eo5pW90jd8Z0qqL+CT2zRLNuy1gHlzRD62jyiVFltYeg5Pbvi
         +Ay677aLlZ6In7TtfR20t/zK2AZ9QmogC22ovqRuemjTnTYM/wNYiJPF5vUCDEQZQPN2
         GiTw==
X-Gm-Message-State: AFqh2kpEMTON6gwVlluSqbUINPrQG7l4O/FbagMau+7QO9qvLmJG73vt
        Ysnr+77+NI9HIVeAQjKaSwe1ykdW9HpacczwGE+X3g==
X-Google-Smtp-Source: AMrXdXvntEaGKeDSTmqq/y3JP0S4uqO72IQDMc9WdFud8sVI7E1Ioo2fH6CR8vpWVzYnmTZbb73lFREbUgG6idVlOrQ=
X-Received: by 2002:a17:906:4ad3:b0:7c0:f459:a0e4 with SMTP id
 u19-20020a1709064ad300b007c0f459a0e4mr458802ejt.155.1671767049441; Thu, 22
 Dec 2022 19:44:09 -0800 (PST)
MIME-Version: 1.0
References: <20221222131656.49584-1-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20221222131656.49584-1-manivannan.sadhasivam@linaro.org>
From:   Steev Klimaszewski <steev@kali.org>
Date:   Thu, 22 Dec 2022 21:43:58 -0600
Message-ID: <CAKXuJqg=fi2r5yiWUhtEj5-Kz-N6ejNiE1HbjtZ3ZtJ5fObVtA@mail.gmail.com>
Subject: Re: [PATCH v4 00/16] Qcom: LLCC/EDAC: Fix base address used for LLCC banks
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com, quic_saipraka@quicinc.com,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
        quic_ppareek@quicinc.com, luca.weiss@fairphone.com,
        ahalaney@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Dec 22, 2022 at 7:17 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
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

Tested-by: Steev Klimaszewski <steev@kali.org> # Thinkpad X13s

Like Andrew, tested starting, restarting, and stopping the edac
service multiple times.
edac-ctl --mainboard reports "edac-ctl: mainboard: LENOVO 21BX0015US"

Thanks Mani!
-- steev
