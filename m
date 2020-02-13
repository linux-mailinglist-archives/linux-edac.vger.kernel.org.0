Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0BD15BEA7
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2020 13:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbgBMMrS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 13 Feb 2020 07:47:18 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37530 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729544AbgBMMrS (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 13 Feb 2020 07:47:18 -0500
Received: from zn.tnic (p200300EC2F07F600746843EFEB191E44.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:f600:7468:43ef:eb19:1e44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C980E1EC0CE8;
        Thu, 13 Feb 2020 13:47:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1581598036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=StBqtZPvE79wkxXiJ2x4Gd/HEg3noCDpRx9TLJvtPSc=;
        b=FXIQhekrypKY0KlO1GErh3yyKsdic272qs+rjQDs61gbfIgDJfzAGCFYGClcG4CQlf4zJy
        2FHZWd2oD7IJrqgv2wZN3k3/43m4/UEYmslZInS0SQaVlCaB5un2KQWbUaCjzmp5xBww3b
        HLaFNxcYMptxyvLzhebxI4RYpBH54Dw=
Date:   Thu, 13 Feb 2020 13:47:08 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 05/10] EDAC/mc: Create new function edac_inc_csrow()
Message-ID: <20200213124708.GJ31799@zn.tnic>
References: <20200123090210.26933-1-rrichter@marvell.com>
 <20200123090210.26933-6-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200123090210.26933-6-rrichter@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jan 23, 2020 at 09:02:58AM +0000, Robert Richter wrote:
> Have a separate function to count errors in csrow/channel. This better
> separates code and reduces the indentation level. No functional
> changes.
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> Acked-by: Aristeu Rozanski <aris@redhat.com>
> ---
>  drivers/edac/edac_mc.c | 40 +++++++++++++++++++++++++---------------
>  1 file changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index 3c00c046acc9..e75cb7a9c454 100644
> --- a/drivers/edac/edac_mc.c
> +++ b/drivers/edac/edac_mc.c
> @@ -1091,6 +1091,26 @@ static void edac_ue_error(struct mem_ctl_info *mci,
>  	edac_inc_ue_error(mci, enable_per_layer_report, pos, error_count);
>  }
>  
> +static void edac_inc_csrow(struct edac_raw_error_desc *e, int row, int chan)
> +{
> +	struct mem_ctl_info *mci = error_desc_to_mci(e);
> +	u16 count = e->error_count;
> +	enum hw_event_mc_err_type type = e->type;

Please sort function local variables declaration in a reverse christmas
tree order:

	<type A> longest_variable_name;
	<type B> shorter_var_name;
	<type C> even_shorter;
	<type D> i;

> +
> +	if (row < 0)
> +		return;
> +
> +	edac_dbg(4, "csrow/channel to increment: (%d,%d)\n", row, chan);
> +
> +	if (type == HW_EVENT_ERR_CORRECTED) {
> +		mci->csrows[row]->ce_count += count;
> +		if (chan >= 0)
> +			mci->csrows[row]->channels[chan]->ce_count += count;
> +	} else {
> +		mci->csrows[row]->ue_count += count;
> +	}
> +}
> +
>  void edac_raw_mc_handle_error(struct edac_raw_error_desc *e)
>  {
>  	struct mem_ctl_info *mci = error_desc_to_mci(e);
> @@ -1258,22 +1278,12 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
>  			chan = -2;
>  	}
>  
> -	if (!e->enable_per_layer_report) {
> +	if (!e->enable_per_layer_report)
>  		strcpy(e->label, "any memory");
> -	} else {
> -		edac_dbg(4, "csrow/channel to increment: (%d,%d)\n", row, chan);
> -		if (p == e->label)
> -			strcpy(e->label, "unknown memory");
> -		if (type == HW_EVENT_ERR_CORRECTED) {
> -			if (row >= 0) {
> -				mci->csrows[row]->ce_count += error_count;
> -				if (chan >= 0)
> -					mci->csrows[row]->channels[chan]->ce_count += error_count;
> -			}
> -		} else
> -			if (row >= 0)
> -				mci->csrows[row]->ue_count += error_count;
> -	}
> +	else if (!*e->label)
> +		strcpy(e->label, "unknown memory");
> +
> +	edac_inc_csrow(e, row, chan);

Err, but this has functional changes: the !e->enable_per_layer_report
case sets only the e->label and the else branch only does increment
->ce_count.

Your change gets ->ce_count incremented in both cases.

Why?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
