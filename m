Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7205739573D
	for <lists+linux-edac@lfdr.de>; Mon, 31 May 2021 10:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhEaInI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 31 May 2021 04:43:08 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40282 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231263AbhEaImU (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 31 May 2021 04:42:20 -0400
Received: from zn.tnic (p200300ec2f080f006c0d0ceb240e6208.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:f00:6c0d:ceb:240e:6208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AC8BE1EC0489;
        Mon, 31 May 2021 10:40:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622450439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=KoQphbyuo1/nKVZ7OXCY8vZ8trKuzaVJ0+007WK774E=;
        b=N9fVxbFksZfdYLZfuKCOZ50uvndPclGsmM/ftiqS3Pv0QBQ2s/gsqNinQmlM+CvGSJhkSJ
        BKS/CN02XnSAgK8X0qsUXx4mH14Tdx6sCoEJ3cJT/3pi3Z/Yv8Dr1o1iCkPiXgbN0KM2qc
        wkzM9PAz0CgMFJ6kwewLKtceWIOHloA=
Date:   Mon, 31 May 2021 10:40:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Johannes Thumshirn <morbidrsa@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Doug Thompson <dougthompson@xmission.com>,
        Dave Jiang <djiang@mvista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] EDAC, mpc85xx: Fix error return code in two functions
Message-ID: <YLSg/8REPQoX8HL7@zn.tnic>
References: <20210528032637.9231-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210528032637.9231-1-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, May 28, 2021 at 11:26:37AM +0800, Zhen Lei wrote:
> Fix to return -EFAULT from the error handling case instead of 0, as done
> elsewhere in its function.
> 
> Fixes: a9a753d53204 ("drivers-edac: add freescale mpc85xx driver")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/edac/mpc85xx_edac.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
> index 67f7bc3fe5b3..b2eaa62c9412 100644
> --- a/drivers/edac/mpc85xx_edac.c
> +++ b/drivers/edac/mpc85xx_edac.c
> @@ -248,6 +248,7 @@ static int mpc85xx_pci_err_probe(struct platform_device *op)
>  
>  	if (edac_pci_add_device(pci, pdata->edac_idx) > 0) {
>  		edac_dbg(3, "failed edac_pci_add_device()\n");
> +		res = -EFAULT;

>  		goto err;
>  	}
>  
> @@ -552,6 +553,7 @@ static int mpc85xx_l2_err_probe(struct platform_device *op)
>  
>  	if (edac_device_add_device(edac_dev) > 0) {
>  		edac_dbg(3, "failed edac_device_add_device()\n");
> +		res = -EFAULT;
>  		goto err;
>  	}
>  
> -- 

EFAULT means

#define EFAULT          14      /* Bad address */

Does it make sense to you when the probe function returns a "bad
address" upon failure to add a device?

hint 1: you might wanna audit how the other drivers are calling this for
better ideas.

hint 2: while doing hint 1, you might find some more broken cases which
you could fix too.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
