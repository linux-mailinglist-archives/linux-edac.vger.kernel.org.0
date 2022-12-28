Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8433065735F
	for <lists+linux-edac@lfdr.de>; Wed, 28 Dec 2022 07:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiL1GvJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 28 Dec 2022 01:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiL1GvF (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 28 Dec 2022 01:51:05 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3329DB6D
        for <linux-edac@vger.kernel.org>; Tue, 27 Dec 2022 22:51:03 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id o31-20020a17090a0a2200b00223fedffb30so15224152pjo.3
        for <linux-edac@vger.kernel.org>; Tue, 27 Dec 2022 22:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ssLg/7nM38bRqW33m1/YKiuBpQ1zkszVoKfNtZ2tX2A=;
        b=fKWE3HFNF7lGWlnfS33XYKt8GKNGXlF1o+2fGqZ4P/Ucg0zzJM99hPTeEhWvvVuDE8
         IHatanT+7biqyPqIf5DfzrXRpazVukILsirITwPrPGy1rcuPxGtuDhgjUFWkGJMbn+39
         DsMnBO6st8xnuLpbkpSq6NEJCS78aNh4LfFwBbMOJsno+iF1cFozDMWc6nlmgaVFi5xg
         JudMWfcdlC3D84cI/bLKh+Sslbrca2G0SL3WSjkkOlaDrf/p5WugCoN1v7yXk6U8LJLG
         qNvFzGRZwIgH01ZJ1S9635AHJ6GKgsJ6DjvY1iVG0TGGb5zWXIzq4KejMd6tSy6IDO+U
         oZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ssLg/7nM38bRqW33m1/YKiuBpQ1zkszVoKfNtZ2tX2A=;
        b=cZM57Sm2UdemReNRU+rS92l92fFCmQFDM7PpU0gGtueBHA/pVw7bB7ohRz+6IeezF8
         LfNBQFM9mRP4jeBSYmY/zZwupxTceFCMG4oFX8/KAVor7W4HwvSNvWW7TB0cql3Y4NlQ
         WBg0r/3Jqu1Z4FBHC5mUczZIP2fwJXBz3zmjQDYT0wASAPQHwtNpleqZ8iyDnfQ5xEk+
         spyUQmoZlPCKNd3VE+yWKPmZ3POp9EcYEpiH5XjmuQYAk0LaCPGFtapYMSl5/b3huLHv
         ZU/ycdQWN9HlXzbgWVcAxnwRXeWsz1jAvnJgyfGstMXdLciVycle9M771W5Nabv9h9a2
         mRlQ==
X-Gm-Message-State: AFqh2kqg7lo1L4jyBtyK8NDhBxCh2OMfdcE3LTrAfVAQIWs5fpQ5+oxr
        F66QTOvlORrTlImwa5ZcZabL
X-Google-Smtp-Source: AMrXdXsxpRL6f8Hf1uDxy0V0D6kH7/ElsDUzxYKpEDRemF1viUyhNxqoEmLTbkouwp2ya8pDQRR+rw==
X-Received: by 2002:a17:902:bf43:b0:185:441e:2d77 with SMTP id u3-20020a170902bf4300b00185441e2d77mr27235919pls.14.1672210262625;
        Tue, 27 Dec 2022 22:51:02 -0800 (PST)
Received: from thinkpad ([117.217.178.73])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902ec8200b0017f72a430adsm10262951plg.71.2022.12.27.22.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 22:51:01 -0800 (PST)
Date:   Wed, 28 Dec 2022 12:20:51 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        bp@alien8.de, tony.luck@intel.com, quic_saipraka@quicinc.com,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
        quic_ppareek@quicinc.com, luca.weiss@fairphone.com,
        ahalaney@redhat.com, steev@kali.org
Subject: Re: [PATCH v4 00/16] Qcom: LLCC/EDAC: Fix base address used for LLCC
 banks
Message-ID: <20221228065051.GA30143@thinkpad>
References: <20221222131656.49584-1-manivannan.sadhasivam@linaro.org>
 <20221228043138.2p2qtjhrfaenptpe@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221228043138.2p2qtjhrfaenptpe@builder.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Dec 27, 2022 at 10:31:38PM -0600, Bjorn Andersson wrote:
> On Thu, Dec 22, 2022 at 06:46:40PM +0530, Manivannan Sadhasivam wrote:
> > The Qualcomm LLCC/EDAC drivers were using a fixed register stride for
> > accessing the (Control and Status Regsiters) CSRs of each LLCC bank.
> > This offset only works for some SoCs like SDM845 for which driver support
> > was initially added.
> >     
> > But the later SoCs use different register stride that vary between the
> > banks with holes in-between. So it is not possible to use a single register
> > stride for accessing the CSRs of each bank. By doing so could result in a
> > crash with the current drivers. So far this crash is not reported since
> > EDAC_QCOM driver is not enabled in ARM64 defconfig and no one tested the
> > driver extensively by triggering the EDAC IRQ (that's where each bank
> > CSRs are accessed).
> >     
> > For fixing this issue, let's obtain the base address of each LLCC bank from
> > devicetree and get rid of the fixed stride.
> > 
> > This series affects multiple platforms but I have only tested this on
> > SM8250, SM8450, and SM6350. Testing on other platforms is welcomed.
> > 
> > Thanks,
> > Mani
> > 
> > Changes in v4:
> > 
> > * Added a patch that fixes the use-after-free bug in qcom_edac driver
> > 
> > Changes in v3:
> > 
> > * Brought back reg-names property for compatibility (Krzysztof)
> > * Removed Fixes tag and stable list as backporting the drivers/binding/dts
> >   patches alone would break (Krzysztof)
> > * Fixed the uninitialized variable issue (Kbot)
> > * Added a patch to make use of driver supplied polling interval (Luca)
> > * Added a patch for module autoloading (Andrew)
> > * Didn't collect Review tags from Sai as the dts patches were changed.
> > 
> > Changes in v2:
> > 
> > * Removed reg-names property and used index of reg property to parse LLCC
> >   bank base address (Bjorn)
> > * Collected Ack from Sai for binding
> > * Added a new patch for polling mode (Luca)
> > * Renamed subject of patches targeting SC7180 and SM6350
> > 
> > Manivannan Sadhasivam (16):
> >   dt-bindings: arm: msm: Update the maintainers for LLCC
> >   dt-bindings: arm: msm: Fix register regions used for LLCC banks
> >   arm64: dts: qcom: sdm845: Fix the base addresses of LLCC banks
> >   arm64: dts: qcom: sc7180: Fix the base addresses of LLCC banks
> >   arm64: dts: qcom: sc7280: Fix the base addresses of LLCC banks
> >   arm64: dts: qcom: sc8280xp: Fix the base addresses of LLCC banks
> >   arm64: dts: qcom: sm8150: Fix the base addresses of LLCC banks
> >   arm64: dts: qcom: sm8250: Fix the base addresses of LLCC banks
> >   arm64: dts: qcom: sm8350: Fix the base addresses of LLCC banks
> >   arm64: dts: qcom: sm8450: Fix the base addresses of LLCC banks
> >   arm64: dts: qcom: sm6350: Fix the base addresses of LLCC banks
> >   EDAC/device: Make use of poll_msec value in edac_device_ctl_info
> >     struct
> >   EDAC/qcom: Add platform_device_id table for module autoloading
> >   EDAC/qcom: Do not pass llcc_driv_data as edac_device_ctl_info's
> >     pvt_info
> 
> Can you clarify if these patches needs to be applied in the specific
> order, or if the EDAC changes can go in independently of the llcc driver
> changes?
> 

The EDAC/qcom and EDAC/device patches can go independently of the rest. All
other patches needs to go through qcom tree.

Steev spotted an issue on C630, so I'm going to respin the series one more
time.

Thanks,
Mani

> Thanks,
> Bjorn
> 
> >   qcom: llcc/edac: Fix the base address used for accessing LLCC banks
> >   qcom: llcc/edac: Support polling mode for ECC handling
> > 
> >  .../bindings/arm/msm/qcom,llcc.yaml           | 128 ++++++++++++++++--
> >  arch/arm64/boot/dts/qcom/sc7180.dtsi          |   2 +-
> >  arch/arm64/boot/dts/qcom/sc7280.dtsi          |   5 +-
> >  arch/arm64/boot/dts/qcom/sc8280xp.dtsi        |  10 +-
> >  arch/arm64/boot/dts/qcom/sdm845.dtsi          |   7 +-
> >  arch/arm64/boot/dts/qcom/sm6350.dtsi          |   2 +-
> >  arch/arm64/boot/dts/qcom/sm8150.dtsi          |   7 +-
> >  arch/arm64/boot/dts/qcom/sm8250.dtsi          |   7 +-
> >  arch/arm64/boot/dts/qcom/sm8350.dtsi          |   7 +-
> >  arch/arm64/boot/dts/qcom/sm8450.dtsi          |   7 +-
> >  drivers/edac/edac_device.c                    |   2 +-
> >  drivers/edac/qcom_edac.c                      |  63 +++++----
> >  drivers/soc/qcom/llcc-qcom.c                  |  85 ++++++------
> >  include/linux/soc/qcom/llcc-qcom.h            |   6 +-
> >  14 files changed, 243 insertions(+), 95 deletions(-)
> > 
> > -- 
> > 2.25.1
> > 

-- 
மணிவண்ணன் சதாசிவம்
