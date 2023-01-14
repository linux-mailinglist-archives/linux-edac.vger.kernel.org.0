Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967A466AB9D
	for <lists+linux-edac@lfdr.de>; Sat, 14 Jan 2023 14:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjANN2o (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 14 Jan 2023 08:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjANN2Z (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 14 Jan 2023 08:28:25 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307B0525E;
        Sat, 14 Jan 2023 05:27:56 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 62D9A1EC03D6;
        Sat, 14 Jan 2023 14:27:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673702874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QExdCMPc2a4sr9vLuhoA9Llfo3bR+UWXoUMB0tZ9og8=;
        b=XzCkg7+6SyvQCwn+oK/G3fbB5JUNLcxiOtmLHYLR0b8QJhfrcCFEX7CY8ruHbZpuQ3QYMS
        mgLynCZIsSTql4aBM3kaeGlP0jFh8Vlaz0HlnhxYqnfxIGKxYSH+ZUK/B1ZPhh7xUCa9Fw
        9rW7paqClE8CYP7o6r7hHL4eIealyWo=
Date:   Sat, 14 Jan 2023 14:27:50 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tony.luck@intel.com,
        quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        luca.weiss@fairphone.com, ahalaney@redhat.com, steev@kali.org
Subject: Re: [PATCH v5 15/17] qcom: llcc/edac: Fix the base address used for
 accessing LLCC banks
Message-ID: <Y8Kt1uKAIPyl0y+d@zn.tnic>
References: <20221228084028.46528-1-manivannan.sadhasivam@linaro.org>
 <20221228084028.46528-16-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221228084028.46528-16-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Dec 28, 2022 at 02:10:26PM +0530, Manivannan Sadhasivam wrote:
> The Qualcomm LLCC/EDAC drivers were using a fixed register stride for
> accessing the (Control and Status Registers) CSRs of each LLCC bank.
> This stride only works for some SoCs like SDM845 for which driver
> support was initially added.
> 
> But the later SoCs use different register stride that vary between the
> banks with holes in-between. So it is not possible to use a single register
> stride for accessing the CSRs of each bank. By doing so could result in a
> crash.

If this patch fixes a crash, then it should be

Cc: <stable@kernel.org>

If there are prerequisites to it, they should be CC:stable too.

So looking at the urgent stuff: patches 1, 3, I'm thinking I can take them
through the EDAC tree and send them to Linus now, after you've addressed the
review comments.

This one can go through some other tree, I presume, but since it fixes a crash
it should go in now too...

> For fixing this issue, let's obtain the base address of each LLCC bank from
> devicetree and get rid of the fixed stride. This also means, we no longer

Please use passive voice in your commit message: no "we" or "I", etc,
and describe your changes in imperative mood.

Personal pronouns are ambiguous in text, especially with so many
parties/companies/etc developing the kernel so let's avoid them please.

> need to rely on reg-names property and get the base addresses using index.
> 
> First index is LLCC bank 0 and last index is LLCC broadcast. If the SoC
> supports more than one bank, then those needs to be defined in devicetree

s/needs/need/

> for index from 1..N-1.
> 
> Reported-by: Parikshit Pareek <quic_ppareek@quicinc.com>
> Tested-by: Luca Weiss <luca.weiss@fairphone.com>
> Tested-by: Steev Klimaszewski <steev@kali.org> # Thinkpad X13s
> Tested-by: Andrew Halaney <ahalaney@redhat.com> # sa8540p-ride
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

With the above addressed, for the EDAC bits:

Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
