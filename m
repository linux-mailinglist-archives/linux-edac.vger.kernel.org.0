Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09403646BBF
	for <lists+linux-edac@lfdr.de>; Thu,  8 Dec 2022 10:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiLHJSI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 8 Dec 2022 04:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiLHJRr (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 8 Dec 2022 04:17:47 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FE76DCEA
        for <linux-edac@vger.kernel.org>; Thu,  8 Dec 2022 01:16:29 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id n21so2374333ejb.9
        for <linux-edac@vger.kernel.org>; Thu, 08 Dec 2022 01:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elLETLSwT7VH5/W4TgvYIEFkfudJUq+gajumeb0E6/U=;
        b=Xl8lOWPuf4BgoDd/DR8s1V45KSGql1YN70Pv5eJQ/LXtaGwoWHadHCKIlwDL6S3v4e
         3XUIT3PgBdyik1lIe4RPpyMZKrqUuNAgd1/adXZ5ktp1QEdq3r5akAXTRrFwSZEibo6H
         N4VPKByeukXcn3IRw4Qs70d9PMhIVYW3DFe0GgPzVHT1nZF4SeNunQ9IwTvKvE+uVYwx
         mjW57fmwrHNLjt3LkDhHANcQYSRZcfKJDq3fI0bB2p80CZJM6+DW1dun0AYyK1qMQQLq
         nX6ap/pjzA0gP7ZYgULa85ZZJ0n4TWr3PKg7gdWsL2EnMPLT7c/fESFvR0TLokhNzSmI
         IEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=elLETLSwT7VH5/W4TgvYIEFkfudJUq+gajumeb0E6/U=;
        b=podu6elUry4l2XmKSvzFTIsemNHhK6kKvZZB+HfR0sFTnDSAWPYhkfpHeTcTSjuYn1
         5+4IW1rJIP2Pr6HS43Z1/fu38HUAgTMy9oCHUKO00W4x0Wz0NxCAxVDEA+igHS/Agk6z
         SJ4PkXC7ezoN+1FYVQ2PVK+HdJp+1Gtj2YrWWj4f2/nVj6pmuY9HekrSRwyaxs5WINCx
         JpwwYQnDJnuz/nH4hdn0Lz8dvtQz1SZRUP3CpWrFaNmQsSOJolHQphEuhCEpaFm9yJI3
         7kgQ6QPTTibS5qYMJ1fz1Za8BeSdf5Bvgd94LKjtvD74UYrP5D8Fjv/J2OhOkvfFU0D6
         zjYg==
X-Gm-Message-State: ANoB5pnBQHqbjF2kXiBzIDCzbLNOCjoj70SKjhsWLA5BgjLU9xXfRvMs
        zsk54ldXCcIRoL+zVfsk6na8hw==
X-Google-Smtp-Source: AA0mqf5y9Eg/nNQNOVImTYmfbgy6DdU3Rw24mCguzwK/vdn477+84Aesq43eDYwB4GHXXvu7NYvbkQ==
X-Received: by 2002:a17:907:cb83:b0:7a7:3f0c:e99b with SMTP id un3-20020a170907cb8300b007a73f0ce99bmr2022155ejc.6.1670490988109;
        Thu, 08 Dec 2022 01:16:28 -0800 (PST)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id kv22-20020a17090778d600b007c0be4861e8sm5018404ejc.23.2022.12.08.01.16.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 01:16:27 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 08 Dec 2022 10:16:27 +0100
Message-Id: <COWBMT72Y57W.2W8G3XDNT3T34@otso>
Cc:     <quic_saipraka@quicinc.com>, <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <james.morse@arm.com>, <mchehab@kernel.org>, <rric@kernel.org>,
        <linux-edac@vger.kernel.org>, <quic_ppareek@quicinc.com>
Subject: Re: [PATCH 00/12] Qcom: LLCC/EDAC: Fix base address used for LLCC
 banks
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <bp@alien8.de>,
        <tony.luck@intel.com>
X-Mailer: aerc 0.13.0
References: <20221207135922.314827-1-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20221207135922.314827-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Manivannan,

On Wed Dec 7, 2022 at 2:59 PM CET, Manivannan Sadhasivam wrote:
> The Qualcomm LLCC/EDAC drivers were using a fixed register stride for
> accessing the (Control and Status Regsiters) CSRs of each LLCC bank.
> This offset only works for some SoCs like SDM845 for which driver support
> was initially added.
>    =20
> But the later SoCs use different register stride that vary between the
> banks with holes in-between. So it is not possible to use a single regist=
er
> stride for accessing the CSRs of each bank. By doing so could result in a
> crash with the current drivers. So far this crash is not reported since
> EDAC_QCOM driver is not enabled in ARM64 defconfig and no one tested the
> driver extensively by triggering the EDAC IRQ (that's where each bank
> CSRs are accessed).
>    =20
> For fixing this issue, let's obtain the base address of each LLCC bank fr=
om
> devicetree and get rid of the fixed stride.
>
> This series affects multiple platforms but I have only tested this on
> SM8250 and SM8450. Testing on other platforms is welcomed.

If you can tell me *how* I can test it, I'd be happy to test the series
on sm6350, like how to trigger the EDAC IRQ.

So far without any extra patches I don't even see the driver probing,
with this in kconfig

  +CONFIG_EDAC=3Dy
  +CONFIG_EDAC_QCOM=3Dy

I do have /sys/bus/platform/drivers/qcom_llcc_edac at runtime but
nothing in there (except bind, uevent and unbind), and also nothing
interesting in dmesg with "llcc", with edac there's just this message:

  [    0.064800] EDAC MC: Ver: 3.0.0

From what I'm seeing now the edac driver is only registered if the
interrupt is specified but it doesn't seem like sm6350 (=3Dlagoon) has
this irq? Downstream dts is just this:

	cache-controller@9200000 {
		compatible =3D "lagoon-llcc-v1";
		reg =3D <0x9200000 0x50000> , <0x9600000 0x50000>;
		reg-names =3D "llcc_base", "llcc_broadcast_base";
		cap-based-alloc-and-pwr-collapse;
	};

From looking at the downstream code, perhaps it's using the polling mode
there?

	/* Request for ecc irq */
	ecc_irq =3D llcc_driv_data->ecc_irq;
	if (ecc_irq < 0) {
		dev_info(dev, "No ECC IRQ; defaulting to polling mode\n");

Let me know what you think.

Regards
Luca

>
> Thanks,
> Mani
>
> Manivannan Sadhasivam (12):
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
>   qcom: llcc/edac: Fix the base address used for accessing LLCC banks
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
>  drivers/edac/qcom_edac.c                      |  14 +-
>  drivers/soc/qcom/llcc-qcom.c                  |  64 +++++----
>  include/linux/soc/qcom/llcc-qcom.h            |   4 +-
>  13 files changed, 197 insertions(+), 67 deletions(-)
>
> --=20
> 2.25.1

