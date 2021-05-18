Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0417A387BAF
	for <lists+linux-edac@lfdr.de>; Tue, 18 May 2021 16:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241919AbhEROw7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 18 May 2021 10:52:59 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44990 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235888AbhEROw7 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 18 May 2021 10:52:59 -0400
Received: from zn.tnic (p200300ec2f0ae2009a42d70f2967689e.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:e200:9a42:d70f:2967:689e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E0BAE1EC030E;
        Tue, 18 May 2021 16:51:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1621349500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=vmuROq0D6YxXIDCZICAwW6w0g0CakT1xbJQQIamFFkM=;
        b=Vl7feaHxOFuwEGBUqtyn3LL2j859bfwfE7YHSlokhy5IGT6MkaA2BvjZuPXlilS/aR/SHa
        nZmYFRa841b2vEV3TNGAKEq4oze701YWm7x0mkoncV+eRocfUYWGS2dzBwCdOZZMPJcMSR
        MOHjp4p/ct0+TtuVpoqaTEVvIcFsbqs=
Date:   Tue, 18 May 2021 16:51:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Stefan Schaeckeler <sschaeck@cisco.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Joel Stanley <joel@jms.id.au>,
        Troy Lee <troy_lee@aspeedtech.com>,
        Arnd Bergmann <arnd@arndb.de>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Liu Shixin <liushixin2@huawei.com>, linux-edac@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/aspeed: use proper format string for printing
 resource
Message-ID: <YKPUdhSE+kepi10j@zn.tnic>
References: <20210421135500.3518661-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210421135500.3518661-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Apr 21, 2021 at 03:54:53PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> On ARMv7, resource_size_t can be 64-bit, which breaks printing
> it as %x:
> 
> drivers/edac/aspeed_edac.c: In function 'init_csrows':
> drivers/edac/aspeed_edac.c:257:28: error: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t' {aka 'long long unsigned int'} [-Werror=format=]
>   257 |         dev_dbg(mci->pdev, "dt: /memory node resources: first page r.start=0x%x, resource_size=0x%x, PAGE_SHIFT macro=0x%x\n",
> 
> Use the special %pR format string to pretty-print the entire
> resource instead.
> 
> Fixes: edfc2d73ca45 ("EDAC/aspeed: Add support for AST2400 and AST2600")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/edac/aspeed_edac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
> index a46da56d6d54..6bd5f8815919 100644
> --- a/drivers/edac/aspeed_edac.c
> +++ b/drivers/edac/aspeed_edac.c
> @@ -254,8 +254,8 @@ static int init_csrows(struct mem_ctl_info *mci)
>  		return rc;
>  	}
>  
> -	dev_dbg(mci->pdev, "dt: /memory node resources: first page r.start=0x%x, resource_size=0x%x, PAGE_SHIFT macro=0x%x\n",
> -		r.start, resource_size(&r), PAGE_SHIFT);
> +	dev_dbg(mci->pdev, "dt: /memory node resources: first page %pR, PAGE_SHIFT macro=0x%x\n",
> +		&r, PAGE_SHIFT);
>  
>  	csrow->first_page = r.start >> PAGE_SHIFT;
>  	nr_pages = resource_size(&r) >> PAGE_SHIFT;
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
