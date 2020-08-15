Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A142453BC
	for <lists+linux-edac@lfdr.de>; Sun, 16 Aug 2020 00:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbgHOWEv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 15 Aug 2020 18:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbgHOVuy (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 15 Aug 2020 17:50:54 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B00C00458C;
        Sat, 15 Aug 2020 11:33:17 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1c7a00329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f1c:7a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 56E951EC0277;
        Sat, 15 Aug 2020 20:33:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1597516391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8BbZ63rk7VbMiYUQjJkYGKszCEMN5l41jgUUhvTPAOk=;
        b=EhozzWmk+kL2/U5KxxkPgUx8K6UAmTLI1ZgR5AZbJMI0He/t8OVM5L7Ts1xYNrnz+/7MSc
        0C4CT36Ji2ATnv3EboiqKdUzO3rBwwtyNqbKX5CQHqNvc/B1R9rOhQjFAbB9nwlgZyxNMR
        zUQhBg+Jw9qsx/NC+CjSH9XlmeIKjbY=
Date:   Sat, 15 Aug 2020 20:33:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Talel Shenhar <talel@amazon.com>
Cc:     mchehab@kernel.org, james.morse@arm.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will@kernel.org, linux-edac@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, hhhawa@amazon.com,
        ronenk@amazon.com, jonnyc@amazon.com, hanochu@amazon.com,
        eitan@amazon.com
Subject: Re: [PATCH v9 2/2] EDAC: al-mc-edac: Introduce Amazon's Annapurna
 Labs Memory Controller EDAC
Message-ID: <20200815183358.GE25814@zn.tnic>
References: <20200728095155.18506-1-talel@amazon.com>
 <20200728095155.18506-3-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200728095155.18506-3-talel@amazon.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jul 28, 2020 at 12:51:55PM +0300, Talel Shenhar wrote:
> +static void al_mc_edac_check(struct mem_ctl_info *mci)
> +{
> +	struct al_mc_edac *al_mc = mci->pvt_info;
> +
> +	if (al_mc->irq_ue <= 0)
> +		handle_ue(mci);
> +
> +	if (al_mc->irq_ce <= 0)
> +		handle_ce(mci);
> +}
> +
> +static irqreturn_t al_mc_edac_irq_handler_ue(int irq, void *info)
> +{
> +	struct platform_device *pdev = info;
> +	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
> +
> +	if (handle_ue(mci))
> +		return IRQ_HANDLED;
> +	return IRQ_NONE;
> +}
> +
> +static irqreturn_t al_mc_edac_irq_handler_ce(int irq, void *info)
> +{
> +	struct platform_device *pdev = info;
> +	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
> +
> +	if (handle_ce(mci))
> +		return IRQ_HANDLED;
> +	return IRQ_NONE;
> +}
> +
> +static enum scrub_type al_mc_edac_get_scrub_mode(void __iomem *mmio_base)
> +{
> +	u32 ecccfg0;
> +
> +	ecccfg0 = readl(mmio_base + AL_MC_ECC_CFG);
> +
> +	if (FIELD_GET(AL_MC_ECC_CFG_SCRUB_DISABLED, ecccfg0))
> +		return SCRUB_NONE;
> +	else
> +		return SCRUB_HW_SRC;
> +}
> +
> +static void devm_al_mc_edac_free(void *data)
> +{
> +	edac_mc_free(data);
> +}
> +
> +static void devm_al_mc_edac_del(void *data)
> +{
> +	edac_mc_del_mc(data);
> +}

From a previous review:

I said:

> Drop the "al_mc_edac_" prefix from most of the static functions. You can
> leave it in the probe function or the IRQ handler so that it is visible
> in stack traces but all those small functions don't need that prefix.

You replied with:

> Shall be part of v7.

and yet it ain't part of any v<num>.

Why?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
