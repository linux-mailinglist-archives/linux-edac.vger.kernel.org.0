Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC70D3D9A
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2019 12:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfJKKl6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Oct 2019 06:41:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56330 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfJKKl6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 11 Oct 2019 06:41:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=k1UcKw5NCgATNBhPLHvYL1U8hKN/UZdfBya/2cOTcLc=; b=UhqK6/kzyZ+Yj6784BUgiZpUi
        Z7N78ANOpc3/yX19XsGiMoogCEgSVadsMMEYElShlx9zecfrAze1nLlcz3uRADHS4Sbo4ATq871tW
        xHROyBFi8tgTEpRbGZ7O0AdHJvUNX3Vh24poL1Ufcm5u0VdFd+L1AX5I54FNkpKsaCca9q8meZ26E
        itTZj4zTPG1wc8HxiDFqb7IzmoSIXInFdxH33PAczI3sv7EzVgF60kY3I9kVyr5mynlQV0LFsq0cl
        XCpmKFbgnzfOMM4/lNEnBZxTsVMTBnr3vzF8HAvwFK42u1/goTBUjkAYQE4f5ngpcCVmcOjtQeo9G
        0Q2psN0tQ==;
Received: from 177.17.141.107.dynamic.adsl.gvt.net.br ([177.17.141.107] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIsMs-00070y-FU; Fri, 11 Oct 2019 10:41:54 +0000
Date:   Fri, 11 Oct 2019 07:41:50 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/19] EDAC, mc: Rename iterator variable to idx
Message-ID: <20191011074150.4bea619a@coco.lan>
In-Reply-To: <20191010202418.25098-8-rrichter@marvell.com>
References: <20191010202418.25098-1-rrichter@marvell.com>
        <20191010202418.25098-8-rrichter@marvell.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Thu, 10 Oct 2019 20:25:18 +0000
Robert Richter <rrichter@marvell.com> escreveu:

> Rename iterator variable to idx. The name is more handy, esp. when
> searching it in the code.
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  drivers/edac/edac_mc.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index c1e142643006..a893f793be8a 100644
> --- a/drivers/edac/edac_mc.c
> +++ b/drivers/edac/edac_mc.c
> @@ -319,7 +319,7 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
>  	unsigned int idx, size, tot_dimms = 1;
>  	unsigned int tot_csrows = 1, tot_channels = 1;
>  	void *pvt, *p, *ptr = NULL;
> -	int i, j, row, chn, n, len;
> +	int j, row, chn, n, len;
>  	bool per_rank = false;
>  
>  	if (WARN_ON(n_layers > EDAC_MAX_LAYERS || n_layers == 0))
> @@ -329,14 +329,14 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
>  	 * Calculate the total amount of dimms and csrows/cschannels while
>  	 * in the old API emulation mode
>  	 */
> -	for (i = 0; i < n_layers; i++) {
> -		tot_dimms *= layers[i].size;
> -		if (layers[i].is_virt_csrow)
> -			tot_csrows *= layers[i].size;
> +	for (idx = 0; idx < n_layers; idx++) {
> +		tot_dimms *= layers[idx].size;
> +		if (layers[idx].is_virt_csrow)
> +			tot_csrows *= layers[idx].size;
>  		else
> -			tot_channels *= layers[i].size;
> +			tot_channels *= layers[idx].size;
>  
> -		if (layers[i].type == EDAC_MC_LAYER_CHIP_SELECT)
> +		if (layers[idx].type == EDAC_MC_LAYER_CHIP_SELECT)
>  			per_rank = true;
>  	}
>  



Thanks,
Mauro
