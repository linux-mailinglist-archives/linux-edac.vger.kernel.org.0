Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3DC19F4D7
	for <lists+linux-edac@lfdr.de>; Mon,  6 Apr 2020 13:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgDFLiv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 6 Apr 2020 07:38:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:55218 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727192AbgDFLiv (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 6 Apr 2020 07:38:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C68BFAE2D;
        Mon,  6 Apr 2020 11:38:48 +0000 (UTC)
Subject: Re: [PATCH 01/11] EDAC/mc: Use int type for parameters of
 edac_mc_alloc()
To:     Robert Richter <rrichter@marvell.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
Cc:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200306151318.17422-1-rrichter@marvell.com>
 <20200306151318.17422-2-rrichter@marvell.com>
From:   Matthias Brugger <mbrugger@suse.com>
Message-ID: <b87a569d-8170-2b8b-d7c8-60bc782f5f2e@suse.com>
Date:   Mon, 6 Apr 2020 13:38:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200306151318.17422-2-rrichter@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 06/03/2020 16:13, Robert Richter wrote:
> Most iterators use int type as index. mci->mc_idx is also type int. So
> use int type for parameters of edac_mc_alloc(). Extend the range check
> to check for negative values. There is a type cast now when assigning
> variable n_layers to mci->n_layer, it is safe due to the range check.
> 
> While at it, rename the users of edac_mc_alloc() to mc_idx as this
> fits better here.
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
>  drivers/edac/edac_mc.c | 7 +++----
>  drivers/edac/edac_mc.h | 6 +++---
>  2 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index 75ede27bdf6a..8bd3d00b4385 100644
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
>  
>  	/*
> @@ -505,7 +504,7 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
>  	pvt = sz_pvt ? (((char *)mci) + ((unsigned long)pvt)) : NULL;
>  
>  	/* setup index and various internal pointers */
> -	mci->mc_idx = mc_num;
> +	mci->mc_idx = mc_idx;
>  	mci->tot_dimms = tot_dimms;
>  	mci->pvt_info = pvt;
>  	mci->n_layers = n_layers;
> diff --git a/drivers/edac/edac_mc.h b/drivers/edac/edac_mc.h
> index 881b00eadf7a..4815f50afea0 100644
> --- a/drivers/edac/edac_mc.h
> +++ b/drivers/edac/edac_mc.h
> @@ -98,7 +98,7 @@ do {									\
>  /**
>   * edac_mc_alloc() - Allocate and partially fill a struct &mem_ctl_info.
>   *
> - * @mc_num:		Memory controller number
> + * @mc_idx:		Memory controller number
>   * @n_layers:		Number of MC hierarchy layers
>   * @layers:		Describes each layer as seen by the Memory Controller
>   * @sz_pvt:		size of private storage needed
> @@ -122,8 +122,8 @@ do {									\
>   *	On success, return a pointer to struct mem_ctl_info pointer;
>   *	%NULL otherwise
>   */
> -struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
> -				   unsigned int n_layers,
> +struct mem_ctl_info *edac_mc_alloc(int mc_idx,
> +				   int n_layers,
>  				   struct edac_mc_layer *layers,
>  				   unsigned int sz_pvt);
>  
> 

