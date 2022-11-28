Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB46563A816
	for <lists+linux-edac@lfdr.de>; Mon, 28 Nov 2022 13:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbiK1MVN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Nov 2022 07:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbiK1MUv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 28 Nov 2022 07:20:51 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807D02DE5;
        Mon, 28 Nov 2022 04:17:00 -0800 (PST)
Received: from zn.tnic (p200300ea9733e719329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e719:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0739E1EC050D;
        Mon, 28 Nov 2022 13:16:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1669637819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rAn4+EFuUUoIE6+YNOvTGPjGm9Wagb2/nVjttZ1GBfY=;
        b=fKuZ2C2ZTda/Fi8y/CD20fA9rpZTQ2ccCX6ok69LO6xWLReEpf6HkqKvQwicXozAqaTP/c
        oUnJnlRd3bVXY3SmLDlA74AT86OQ2qDpg8vqL1WzxP3VkByRcCYIV0YAojld4hUGLIzSxy
        wPhpexuKOP/yAj/j+kvAe0CjNmBZKaI=
Date:   Mon, 28 Nov 2022 13:16:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     bjorn.andersson@linaro.org, mchehab@kernel.org,
        james.morse@arm.com, rric@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_saipraka@quicinc.com
Subject: Re: [PATCH v4 1/2] EDAC/qcom: Get rid of hardcoded register offsets
Message-ID: <Y4SmtfSzLbYea+f0@zn.tnic>
References: <20221116143352.289303-1-manivannan.sadhasivam@linaro.org>
 <20221116143352.289303-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221116143352.289303-2-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Nov 16, 2022 at 08:03:51PM +0530, Manivannan Sadhasivam wrote:
> The LLCC EDAC register offsets varies between each SoC. Hardcoding the
> register offsets won't work and will often result in crash due to
> accessing the wrong locations.
> 
> Hence, get the register offsets from the LLCC driver matching the
> individual SoCs.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/edac/qcom_edac.c           | 116 ++++++++++++++---------------
>  include/linux/soc/qcom/llcc-qcom.h |   6 --
>  2 files changed, 58 insertions(+), 64 deletions(-)

It looks to me like this patch needs to go to stable?

Also, the Fixes tag should probably be:

Fixes: 27450653f1db ("drivers: edac: Add EDAC driver support for QCOM SoCs")

Yes, no?

Also, please explain to me how you've tested this patch if it doesn't
even build?!

ERROR: modpost: "__devm_regmap_init_mmio_clk" [drivers/soc/qcom/llcc-qcom.ko] undefined!
make[1]: *** [scripts/Makefile.modpost:126: Module.symvers] Error 1
make: *** [Makefile:1944: modpost] Error 2

I guess because CONFIG_QCOM_LLCC is =y in your config while I have
CONFIG_QCOM_LLCC=m.

And I reported the same build error to you the last time. Did you not
see it?

For the next version, you'd need to fix all possible Kconfig build
errors before sending.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
