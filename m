Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34A61A7B22
	for <lists+linux-edac@lfdr.de>; Tue, 14 Apr 2020 14:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502182AbgDNMrn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 Apr 2020 08:47:43 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34574 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502181AbgDNMrl (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 14 Apr 2020 08:47:41 -0400
Received: from zn.tnic (p200300EC2F0C1D0021F05AC4D60C335F.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:1d00:21f0:5ac4:d60c:335f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8FF3E1EC0CDE;
        Tue, 14 Apr 2020 14:47:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1586868456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vP4PbFC2Ql0uKPjbBVGyLCqT4YXRCyjqKtYPNE0k1+U=;
        b=kbzpx2bD9bU7020BOrk7rhM9RaEK4j4gkgGAAdw+xoI82QHY5EPcneTPrNsr67rtlQ0D8L
        ilzLeGKq2VM9IrLsqwjzmyqSHkpLC1eCPGhc1rt3fwcYMMrRk9o7TJiuXiuF6dTr57mIEE
        hSh31XhQW/1XV4liU2uL6zPiJAv9jV8=
Date:   Tue, 14 Apr 2020 14:47:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     khuong@os.amperecomputing.com, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rrichter@marvell.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] EDAC, xgene: remove set but not used 'address'
Message-ID: <20200414124731.GB31737@zn.tnic>
References: <20200409093259.20069-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200409093259.20069-1-yanaijie@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Apr 09, 2020 at 05:32:59PM +0800, Jason Yan wrote:
> Fix the following gcc warning:
> 
> drivers/edac/xgene_edac.c:1486:7: warning: variable ‘address’ set but
> not used [-Wunused-but-set-variable]
>    u32 address;
>        ^~~~~~~
> And remove the unused macro RBERRADDR_RD after that.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  drivers/edac/xgene_edac.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/edac/xgene_edac.c b/drivers/edac/xgene_edac.c
> index e4a1032ba0b5..1d2c27a00a4a 100644
> --- a/drivers/edac/xgene_edac.c
> +++ b/drivers/edac/xgene_edac.c
> @@ -1349,7 +1349,6 @@ static int xgene_edac_l3_remove(struct xgene_edac_dev_ctx *l3)
>  #define WORD_ALIGNED_ERR_MASK		BIT(28)
>  #define PAGE_ACCESS_ERR_MASK		BIT(27)
>  #define WRITE_ACCESS_MASK		BIT(26)
> -#define RBERRADDR_RD(src)		((src) & 0x03FFFFFF)
>  
>  static const char * const soc_mem_err_v1[] = {
>  	"10GbE0",
> @@ -1483,13 +1482,11 @@ static void xgene_edac_rb_report(struct edac_device_ctl_info *edac_dev)
>  		return;
>  	if (reg & STICKYERR_MASK) {
>  		bool write;
> -		u32 address;
>  
>  		dev_err(edac_dev->dev, "IOB bus access error(s)\n");
>  		if (regmap_read(ctx->edac->rb_map, RBEIR, &reg))
>  			return;
>  		write = reg & WRITE_ACCESS_MASK ? 1 : 0;
> -		address = RBERRADDR_RD(reg);
>  		if (reg & AGENT_OFFLINE_ERR_MASK)
>  			dev_err(edac_dev->dev,
>  				"IOB bus %s access to offline agent error\n",
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
