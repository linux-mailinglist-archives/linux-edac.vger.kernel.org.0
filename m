Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662E21B62A8
	for <lists+linux-edac@lfdr.de>; Thu, 23 Apr 2020 19:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbgDWRtl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Apr 2020 13:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729802AbgDWRtl (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 23 Apr 2020 13:49:41 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC59C09B042;
        Thu, 23 Apr 2020 10:49:41 -0700 (PDT)
Received: from zn.tnic (p200300EC2F0D2E00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:2e00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 21A3B1EC0D2B;
        Thu, 23 Apr 2020 19:49:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1587664179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=OvdL2EnC1XGchLmoU3JyFalyZK03IwfgrdUs09gNkZ4=;
        b=iYTLICJqgEIZDtFuqkPcFsHvapP1JTkkQOjRkOMrceIBjacNubtsQW/8LhBHa6Qj7ZrNi9
        D58agPINzetx0j9oAdZdhpFcvNDe29FuUsSq7p/vEyFoeBtZk+OtXYZQd3sVdNTJ9fcFfz
        Pw7qSD6p7KnHxBEW1+UmGaQqUagf5ZA=
Date:   Thu, 23 Apr 2020 19:49:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Matthias Brugger <mbrugger@suse.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/10] EDAC/mc: Use int type for parameters of
 edac_mc_alloc()
Message-ID: <20200423174934.GF26021@zn.tnic>
References: <20200422115814.22205-1-rrichter@marvell.com>
 <20200422115814.22205-3-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200422115814.22205-3-rrichter@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Apr 22, 2020 at 01:58:06PM +0200, Robert Richter wrote:
> Most iterators use int type as index. mci->mc_idx is also type int. So
> use int type for parameters of edac_mc_alloc(). Extend the range check
> to check for negative values. There is a type cast now when assigning
> variable n_layers to mci->n_layer, it is safe due to the range check.
> 
> While at it, rename the users of edac_mc_alloc() to mc_idx as this
> fits better here.
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---
>  drivers/edac/edac_mc.c | 7 +++----
>  drivers/edac/edac_mc.h | 6 +++---
>  2 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index 107d7c4de933..57d1d356d69c 100644
> --- a/drivers/edac/edac_mc.c
> +++ b/drivers/edac/edac_mc.c
> @@ -444,8 +444,7 @@ static int edac_mc_alloc_dimms(struct mem_ctl_info *mci)
>  	return 0;
>  }
>  
> -struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
> -				   unsigned int n_layers,
> +struct mem_ctl_info *edac_mc_alloc(int mc_idx, int n_layers,
>  				   struct edac_mc_layer *layers,
>  				   unsigned int sz_pvt)
>  {
> @@ -456,7 +455,7 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
>  	void *pvt, *ptr = NULL;
>  	bool per_rank = false;
>  
> -	if (WARN_ON(n_layers > EDAC_MAX_LAYERS || n_layers == 0))
> +	if (WARN_ON(mc_idx < 0 || n_layers < 1 || n_layers > EDAC_MAX_LAYERS))
>  		return NULL;

Yeah, no, this doesn't make sense to me. The memory controller number
and the number of layers can never ever be negative and thus signed.

And some drivers supply unsigned types and some signed. So if anything,
this should be fixing all the callers to supply unsigned quantities.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
