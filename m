Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC8A3C5BE2
	for <lists+linux-edac@lfdr.de>; Mon, 12 Jul 2021 14:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbhGLMMk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 12 Jul 2021 08:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbhGLMMi (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 12 Jul 2021 08:12:38 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EBDC0613DD;
        Mon, 12 Jul 2021 05:09:49 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id c17so34036543ejk.13;
        Mon, 12 Jul 2021 05:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LWC9vWw5LFhroZhy6pnYOxWW9Jdfs8ytgrsX7MK/bic=;
        b=AMdymw1m28Ue43yTNsnrtX/Xp7WScZz8ab++pF3FqYYrnYXjPoes39z/eRBwnBCQvn
         MQd2F7w4LSmb9h4SxIZFmQzgqGU+HjO1eqLnHqFb8He88LSuQ0yerZR+irSAzh4/ojyF
         gJMa4iQAdscNaRGsUKue6WMrCP6RFOOpkFHFXv1hntgmclOanPptt+o3t+fvxtldK3C5
         ql/2ZnNb+3a6jFz56l9ZpQZKpmd3qR7LIaoHA8gOS5RNhQPs1DHvR8qR5yu5PzDPUI1U
         obSdyYOelxHdBlvRMiqrAv6xE5BWTjtZRRZ3i6Yf6DBiP6dYnJwti4kOBvgix25kWLHZ
         Ov1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LWC9vWw5LFhroZhy6pnYOxWW9Jdfs8ytgrsX7MK/bic=;
        b=YfpeGP2pyH4QJb8PYSKbjdsHLOTwtpYpRTQCp1pZOQ+CN7an2CZAdSE03e5+JjAhSa
         HIHWtMlvQznkb8YwqJvcOpAyI/rxiN4jzeYeXIcOusttPQ5UGEtzmG8f6qq7R/2l4fyz
         cqLysvTrkyPUUbEI9qy83imBw7G5Uh7U7K+1xyECR0wYZj7x69Hynf0RD366YIie7gmt
         N2UUhbAgGCIVaE4zHAdMuNsfTH9uR2nuRuyljt0BLUOLFHCzRKMxyMu31CrEdn3wfW1Q
         MRXvZcHYezI2FDxqyvrp7mz5wOTnyqMQxqKueL7ezy7Bi4MXMg10r4T9Qg6x/K4j5Kau
         zX4Q==
X-Gm-Message-State: AOAM533Cs6VFPgcxAsBR7b/BIs9sGnH/eive0qRPPzoXfLcnznDcQFtz
        ooCBl7WVMmLFq7tTYCK4Kxg=
X-Google-Smtp-Source: ABdhPJzoaBRIltWR3pH1Ao00DXwI0zgNKavD2cac/UUKczGIdMDMg8ua5eWWa/X5TGRHqTyfnh4sDA==
X-Received: by 2002:a17:906:3cc:: with SMTP id c12mr50622142eja.268.1626091788363;
        Mon, 12 Jul 2021 05:09:48 -0700 (PDT)
Received: from pc ([196.235.212.194])
        by smtp.gmail.com with ESMTPSA id br4sm6403609ejb.110.2021.07.12.05.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 05:09:47 -0700 (PDT)
Date:   Mon, 12 Jul 2021 13:09:45 +0100
From:   Salah Triki <salah.triki@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND] edac: replace sprintf() by scnprintf()
Message-ID: <20210712120945.GA777994@pc>
References: <20210710163505.GA689509@pc>
 <d95595021eb8da542960fff9b40dc7c308661c9e.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d95595021eb8da542960fff9b40dc7c308661c9e.camel@perches.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sat, Jul 10, 2021 at 09:58:46AM -0700, Joe Perches wrote:
> On Sat, 2021-07-10 at 17:35 +0100, Salah Triki wrote:
> > Replace sprintf() by scnprintf() in order to avoid buffer overflows.
> 
> While of course safe, this is not strictly necessary as the
> maximum length of any edac_layer_name is 8 bytes.
> 
> drivers/edac/edac_mc.c:const char *edac_layer_name[] = {
> drivers/edac/edac_mc.c- [EDAC_MC_LAYER_BRANCH] = "branch",
> drivers/edac/edac_mc.c- [EDAC_MC_LAYER_CHANNEL] = "channel",
> drivers/edac/edac_mc.c- [EDAC_MC_LAYER_SLOT] = "slot",
> drivers/edac/edac_mc.c- [EDAC_MC_LAYER_CHIP_SELECT] = "csrow",
> drivers/edac/edac_mc.c- [EDAC_MC_LAYER_ALL_MEM] = "memory",
> drivers/edac/edac_mc.c-};
> 
> And name is:
> 
> 		char name[80];
> 
> I suppose name[80] could be changed to name[32] or so
> at the same time to reduce stack usage.
> 
> Maybe name should be moved into the loop too.
> 
> ---
>  drivers/edac/debugfs.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/edac/debugfs.c b/drivers/edac/debugfs.c
> index 4804332d99465..a41071f2ad428 100644
> --- a/drivers/edac/debugfs.c
> +++ b/drivers/edac/debugfs.c
> @@ -55,14 +55,15 @@ void edac_debugfs_exit(void)
>  void edac_create_debugfs_nodes(struct mem_ctl_info *mci)
>  {
>  	struct dentry *parent;
> -	char name[80];
>  	int i;
>  
>  	parent = debugfs_create_dir(mci->dev.kobj.name, edac_debugfs);
>  
>  	for (i = 0; i < mci->n_layers; i++) {
> -		sprintf(name, "fake_inject_%s",
> -			     edac_layer_name[mci->layers[i].type]);
> +		char name[32];
> +
> +		scnprintf(name, sizeof(name), "fake_inject_%s",
> +			  edac_layer_name[mci->layers[i].type]);
>  		debugfs_create_u8(name, S_IRUGO | S_IWUSR, parent,
>  				  &mci->fake_inject_layer[i]);
>  	}
> 
> 

I think name should be [20] since len("fake_inject_") is 12 and maximum 
length of any edac_layer_name is 7 bytes. In addition, for moving the
declaration of name inside the loop we need to compile the source in 
C99 mode.

Thanx
