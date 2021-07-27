Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36763D752C
	for <lists+linux-edac@lfdr.de>; Tue, 27 Jul 2021 14:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbhG0Miw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 27 Jul 2021 08:38:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:43700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231971AbhG0Miw (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 27 Jul 2021 08:38:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7FAC360F51;
        Tue, 27 Jul 2021 12:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627389532;
        bh=AD5ouT9mvfsgZly5z4aHDSb6lt2hRORpdoAEEVzrNJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X9Az5WbEXmubiisPgGnKHk6YCaXrl7wTE5leoHtHKsDEDVi/+frp1wTvRDwTGZJYo
         mWldMMacFsfG72w/YqxNgd96jO02R7xUY1Vnzi2VPrRTRU4gkCs9mCirOmRStAA95j
         Z/CXrkZxXF+vsLwKDjVX9EkwbdFjr4kCI8raU7EjmARXsNjZtqHaRaYh+MhKNhVuVq
         4eFRa0hbNMvlPjItvWCzsQnV7SqxpDizc1ORTkMx9C3ByuuUGCiGdAnOrpniivsQty
         LeWL/6ORtbfOHQrL5B8EtS74pPv2gZOUkR1C6M/QbjSrcCmT9uuUF92XD0joSVpY7R
         S4/eQ1mgWeR+w==
Date:   Tue, 27 Jul 2021 14:38:47 +0200
From:   Robert Richter <rric@kernel.org>
To:     Len Baker <len.baker@gmx.com>
Cc:     Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        linux-hardening@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/edac/edac_mc: Remove all strcpy() uses
Message-ID: <YP/+V90D6zyxnSyU@rric.localdomain>
References: <20210725162954.9861-1-len.baker@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210725162954.9861-1-len.baker@gmx.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 25.07.21 18:29:54, Len Baker wrote:
> strcpy() performs no bounds checking on the destination buffer. This
> could result in linear overflows beyond the end of the buffer, leading
> to all kinds of misbehaviors. The safe replacement is strscpy().
> 
> However, to add labels is better to use the scnprintf to simplify the
> arithmetic.
> 
> This is a previous step in the path to remove the strcpy() function
> entirely from the kernel.
> 
> Signed-off-by: Len Baker <len.baker@gmx.com>
> ---
> This is a task of the KSPP [1]
> 
> [1] https://github.com/KSPP/linux/issues/88
> 
>  drivers/edac/edac_mc.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index f6d462d0be2d..1286364f0e48 100644
> --- a/drivers/edac/edac_mc.c
> +++ b/drivers/edac/edac_mc.c
> @@ -1027,6 +1027,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
>  {
>  	struct dimm_info *dimm;
>  	char *p;
> +	size_t p_size = 0;

I would rather use a 'left' variable which is initialized with
sizeof(e->label) close to there p = e->label is.

>  	int row = -1, chan = -1;
>  	int pos[EDAC_MAX_LAYERS] = { top_layer, mid_layer, low_layer };
>  	int i, n_labels = 0;
> @@ -1113,12 +1114,11 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
>  			p = e->label;
>  			*p = '\0';
>  		} else {
> -			if (p != e->label) {
> -				strcpy(p, OTHER_LABEL);
> -				p += strlen(OTHER_LABEL);
> -			}
> -			strcpy(p, dimm->label);
> -			p += strlen(p);
> +			const char *or = (p != e->label) ? OTHER_LABEL : "";
> +
> +			p_size += scnprintf(p + p_size,
> +					    sizeof(e->label) - p_size,
> +					    "%s%s", or, dimm->label);

My preference is to advance p here (and decrement 'left'). This is the
pattern how p is used throughout the code. I also don't see a benefit
of using scnprintf() here compared to the previous implementation.

Thanks,

-Robert

>  		}
> 
>  		/*
> @@ -1140,9 +1140,9 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
>  	}
> 
>  	if (any_memory)
> -		strcpy(e->label, "any memory");
> +		strscpy(e->label, "any memory", sizeof(e->label));
>  	else if (!*e->label)
> -		strcpy(e->label, "unknown memory");
> +		strscpy(e->label, "unknown memory", sizeof(e->label));
> 
>  	edac_inc_csrow(e, row, chan);
> 
> --
> 2.25.1
> 
