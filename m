Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D23336D3E5
	for <lists+linux-edac@lfdr.de>; Wed, 28 Apr 2021 10:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbhD1I1j (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 28 Apr 2021 04:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbhD1I1j (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 28 Apr 2021 04:27:39 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56A1C061574;
        Wed, 28 Apr 2021 01:26:54 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0c17008308f228c3da0e92.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:1700:8308:f228:c3da:e92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 789411EC030F;
        Wed, 28 Apr 2021 10:26:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1619598413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6QLJ84BEqH6pg6keQJFyDrwvGJncmGtdigES8LiCe4o=;
        b=iU0y6g5hxfoIh6zs4gbLkJDGPLeqU0s6B2V5sBVeYzDdJP1DAC+KAToe05vlxxy8V8qeXu
        79SE5fIJShK38LtTBVwr8vPPbb6rDFmdglnIeVxVcUBijH8KAofOEoV5XiEXNrznKW/Xuk
        luh3KUMkMRsnnLPgPH4aD0fzqvnU5Uo=
Date:   Wed, 28 Apr 2021 10:26:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sanjana Srinidhi <sanjanasrinidhi1810@gmail.com>
Cc:     mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, linux-edac@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add blank line after declarations
Message-ID: <YIkbtllJ65MF55wg@zn.tnic>
References: <20210428081412.dyxwuh3soluhd4h6@sanjana-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210428081412.dyxwuh3soluhd4h6@sanjana-VirtualBox>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Apr 28, 2021 at 01:44:12PM +0530, Sanjana Srinidhi wrote:
> Blank line is added after declarations to maintain code uniformity.
> 
> Signed-off-by: Sanjana Srinidhi <sanjanasrinidhi1810@gmail.com>
> ---
>  drivers/edac/edac_mc.c | 3 +++
>  1 file changed, 3 insertions(+)

Before you send a patch, do:

git log -p -1 | ./scripts/get_maintainer.pl

that'll give you who to Cc. Then you'll see that there's no

edac@vger.kernel.org

mailing list but

linux-edac@vger.kernel.org

I've fixed up that now.

There's no

kernel@vger.kernel.org

either.

> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index f6d462d0be2d..6b776bebd83f 100644
> --- a/drivers/edac/edac_mc.c
> +++ b/drivers/edac/edac_mc.c
> @@ -674,6 +674,7 @@ int edac_mc_add_mc_with_groups(struct mem_ctl_info *mci,
>  			       const struct attribute_group **groups)
>  {
>  	int ret = -EINVAL;
> +
>  	edac_dbg(0, "\n");
>  
>  #ifdef CONFIG_EDAC_DEBUG
> @@ -833,9 +834,11 @@ int edac_mc_find_csrow_by_page(struct mem_ctl_info *mci, unsigned long page)
>  
>  	for (i = 0; i < mci->nr_csrows; i++) {
>  		struct csrow_info *csrow = csrows[i];
> +
>  		n = 0;
>  		for (j = 0; j < csrow->nr_channels; j++) {
>  			struct dimm_info *dimm = csrow->channels[j]->dimm;
> +
>  			n += dimm->nr_pages;
>  		}
>  		if (n == 0)
> -- 

Please no, this is adding useless churn.

Such stylistic changes - if they would make sense at all - should be
done as part of other fixes - not as a standalone patch.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
