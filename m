Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE3D3F4F7D
	for <lists+linux-edac@lfdr.de>; Mon, 23 Aug 2021 19:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbhHWRaq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 23 Aug 2021 13:30:46 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42596 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229471AbhHWRap (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 23 Aug 2021 13:30:45 -0400
Received: from zn.tnic (p200300ec2f07d9009c2198849783fa17.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:d900:9c21:9884:9783:fa17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 63E151EC0354;
        Mon, 23 Aug 2021 19:29:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629739797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=k7kW0H/f78ipggRR3pMr7cXUnVjI28dbJ/hrQ806WjA=;
        b=hDhXULFWcHFsoJBIsrfHxmwpgT3Wnl9sEleCLnWDCuz5POadrad9gy5ajW3R69VqkH+gH5
        9K0Vr0mUo/r33+mjTLFeLTpCv/rZPsIGkCo79PEIkh4IMsknG5IJuzQARW/Ns9Myjbjs+G
        dE1D547ttNlcLZzDNJGnSf6K/ahRXc0=
Date:   Mon, 23 Aug 2021 19:30:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Len Baker <len.baker@gmx.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Joe Perches <joe@perches.com>,
        David Laight <David.Laight@aculab.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] EDAC/mc: Prefer strscpy over strcpy
Message-ID: <YSPbOo90alPsv4vL@zn.tnic>
References: <20210814075527.5999-1-len.baker@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210814075527.5999-1-len.baker@gmx.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sat, Aug 14, 2021 at 09:55:27AM +0200, Len Baker wrote:
> strcpy() performs no bounds checking on the destination buffer. This
> could result in linear overflows beyond the end of the buffer, leading
> to all kinds of misbehaviors. The safe replacement is strscpy().
> 
> This is a previous step in the path to remove the strcpy() function

"previous step"?

> entirely from the kernel.
> 
> Signed-off-by: Len Baker <len.baker@gmx.com>

...

> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index f6d462d0be2d..7aea6c502316 100644
> --- a/drivers/edac/edac_mc.c
> +++ b/drivers/edac/edac_mc.c
> @@ -1032,6 +1032,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
>  	int i, n_labels = 0;
>  	struct edac_raw_error_desc *e = &mci->error_desc;
>  	bool any_memory = true;
> +	size_t len;
> 
>  	edac_dbg(3, "MC%d\n", mci->mc_idx);
> 
> @@ -1086,6 +1087,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
>  	 */
>  	p = e->label;
>  	*p = '\0';
> +	len = sizeof(e->label);
> 
>  	mci_for_each_dimm(mci, dimm) {
>  		if (top_layer >= 0 && top_layer != dimm->location[0])
> @@ -1114,10 +1116,12 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
>  			*p = '\0';
>  		} else {
>  			if (p != e->label) {
> -				strcpy(p, OTHER_LABEL);
> -				p += strlen(OTHER_LABEL);
> +				strscpy(p, OTHER_LABEL, len);

Hm, maybe I'm missing something but looking at that strscpy()
definition, why aren't you doing:

				num = strscpy(p, OTHER_LABEL, len);
				if (num < 0)
					/* just in case */
					break;

				len -= num;
				p   += num;

since that function supposedly returns the number of chars copied.

> +				len -= strlen(p);
> +				p += strlen(p);
>  			}
> -			strcpy(p, dimm->label);
> +			strscpy(p, dimm->label, len);
> +			len -= strlen(p);
>  			p += strlen(p);

Ditto.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
