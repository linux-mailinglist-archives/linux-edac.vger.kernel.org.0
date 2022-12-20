Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F249A652A0D
	for <lists+linux-edac@lfdr.de>; Wed, 21 Dec 2022 00:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiLTXzM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 20 Dec 2022 18:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLTXzL (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 20 Dec 2022 18:55:11 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BC81EACF;
        Tue, 20 Dec 2022 15:55:10 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 397DB1EC050B;
        Wed, 21 Dec 2022 00:55:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1671580508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=yqHNIrU0xaikislz2gkyHInSWpcTcMQ38gGBY0sinkk=;
        b=rY6gCnlFJU5S4XAri+5JYTJBVg16o1i1gHF7dzH+met5Lp5PoF43F69OVEaJj0F9+gaPFl
        1mZULJz6PjdUhN48SMzC9g5yHfMxyKyoPpq4x/nd+SO2xAuhSJIA1l2ZzjEhcTicQk+kYO
        Zbbjhkp7IjbzTsErs2B5VxZzPPrt8IE=
Date:   Wed, 21 Dec 2022 00:55:03 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Steev Klimaszewski <steev@kali.org>, andersson@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tony.luck@intel.com, quic_saipraka@quicinc.com,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
        quic_ppareek@quicinc.com, luca.weiss@fairphone.com,
        ahalaney@redhat.com
Subject: Re: [PATCH v3 06/15] arm64: dts: qcom: sc8280xp: Fix the base
 addresses of LLCC banks
Message-ID: <Y6JLV4XG/6xDFrN/@zn.tnic>
References: <20221219182958.476231-1-manivannan.sadhasivam@linaro.org>
 <20221219182958.476231-7-manivannan.sadhasivam@linaro.org>
 <CAKXuJqgL5GsyjaNpkeMf4=72sjw+6ytFUm+yt1WjLyoFLrgm3g@mail.gmail.com>
 <20221220095207.GA38609@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221220095207.GA38609@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Dec 20, 2022 at 03:22:07PM +0530, Manivannan Sadhasivam wrote:
> This is a genuine use-after-free bug that happens because the edac core frees
> the memory assigned to "llcc_driv_data" pointer that gets passed as "pvt_info".
> 
> Here, the LLCC driver is one creating the "qcom_llcc_edac" platform device and
> also allocating memory for "llcc_driv_data". But since during qcom_edac driver
> removal, we are just unregistering the driver and the platform device still
> stays around, the edac driver is not supposed to free any memory associated
> with the platform device.

If you mean

__edac_device_free_ctl_info()

it is very well supposed to free it as it allocates it in
edac_device_alloc_ctl_info().

If qcom_llcc_edac_probe() simply goes and assigns something of its own
to edev_ctl->pvt_info, then that driver gets to keep the pieces ofc.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
