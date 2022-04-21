Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C307509B64
	for <lists+linux-edac@lfdr.de>; Thu, 21 Apr 2022 11:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387260AbiDUJJt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 21 Apr 2022 05:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387248AbiDUJJt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 21 Apr 2022 05:09:49 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6483A13F80;
        Thu, 21 Apr 2022 02:07:00 -0700 (PDT)
Received: from zn.tnic (p200300ea971b58ed329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:58ed:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 138A01EC0494;
        Thu, 21 Apr 2022 11:06:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1650532015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/XNPrYZHxTg+fJqCxP6Bu5DzD0BsDwIuIH78Wom1XZY=;
        b=AUcf2kulEbN6ePzzyV96IrdVGG53S2xSGV9y58AngYuKlOIU08DGcA8w8q6hvACWeV2gDE
        5ei/j/rft3vQUBLkUxvIOXcSWEs4wnXAQCVDT/q01f/e2BqhePMfaBgAsZff60KtQ4wQ6H
        Gi/X88ki37E5nEldEUEACr/0VRVPGx4=
Date:   Thu, 21 Apr 2022 11:06:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     michal.simek@xilinx.com, Shubhrajyoti.datta@xilinx.com,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com
Subject: Re: [PATCH V2 2/2] EDAC: synopsys: re-enable the interrupts in
 intr_handler for V3.X Synopsys EDAC DDR
Message-ID: <YmEerhSXM0L8cUuj@zn.tnic>
References: <20220421015313.5747-1-sherry.sun@nxp.com>
 <20220421015313.5747-3-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220421015313.5747-3-sherry.sun@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Apr 21, 2022 at 09:53:13AM +0800, Sherry Sun wrote:
> Since zynqmp_get_error_info() is called during CE/UE interrupt, at the

This also needs to be made human-readable: for example,
"zynqmp_get_error_info() reads the error information from the registers
when an interrupt for a {un-,}correctable error is raised."

> end of zynqmp_get_error_info(), it wirtes 0 to ECC_CLR_OFST, which cause

Unknown word [wirtes] in commit message.
Suggestions: ['writes',

Please introduce a spellchecker into your patch creation workflow.

> the CE/UE interrupts of V3.X Synopsys EDAC DDR been disabled, then the

"which disables the error interrupts" - make it simple - no need for the
V3.X marketing bla.

> interrupt handler will be called only once, so need to re-enable the

"Therefore, reenable the error interrupt line ..."

> interrupts at the end of intr_handler for V3.X Synopsys EDAC DDR.

I think you're catching my drift: our commit messages need to be
understandable and when read months, years from now, still to make
sense.

> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> Reviewed-by: Shubhrajyoti Datta <Shubhrajyoti.datta@xilinx.com>
> Acked-by: Michal Simek <michal.simek@xilinx.com>
> ---
> Changes in V2:
> 1. Add the Reviewed-by and Acked-by tag.
> 2. Add the newline as suggested by Michal.
> ---
>  drivers/edac/synopsys_edac.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
> index 88a481043d4c..ae1cf02a92f5 100644
> --- a/drivers/edac/synopsys_edac.c
> +++ b/drivers/edac/synopsys_edac.c
> @@ -527,6 +527,8 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
>  	memset(p, 0, sizeof(*p));
>  }
>  
> +static void enable_intr(struct synps_edac_priv *priv);

Why the forward declaration?

Why not simply move {enable,disable}_intr() upwards in that file?

Also, for both fixes: do you want them backported in stable kernels?

I think you do because they look like you'd want that v3.x support to
work with older kernels too.

If so, read the section about "Fixes:" in
Documentation/process/submitting-patches.rst

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
