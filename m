Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B86E149D00D
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jan 2022 17:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243284AbiAZQwX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 26 Jan 2022 11:52:23 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37606 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243311AbiAZQwX (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 26 Jan 2022 11:52:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3ECB61AA2
        for <linux-edac@vger.kernel.org>; Wed, 26 Jan 2022 16:52:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B004BC340E3;
        Wed, 26 Jan 2022 16:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643215942;
        bh=n9mPrQSnGNofqh8bcoqh7TSgKfh4CBVKrMDWP6T1tas=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=SqGZcX3/54JjJRnbC65X3RJx5/+/SFDZSTY4LlXyqCPtXK2P7tN6+lWpl1gtV0+4B
         dZwtoSIaW9aljKzfZ26scw6Qj2r2aytMniK86bDhn9+V2iIZ5YCpHA9Gez22RGtG9l
         F/xEtp3BJbym2+eIv1E4kWSBwss61d57lxALCJIVFNCUXsB1/UpAanvxYUyfk7xzED
         XEqtLEhc0T7nLtCubHNmNPkii3luB9eWgdVnNV7NsdpDHOLcCprYkHgsFibilt6p8e
         o5wBMesrJRIRi9neKVwUD4ODwHFKjAvefAdSrsbGkXnyOe+ccmiS/leG8Jw9qXFyAB
         ISWWJjnzooPzw==
Message-ID: <7b964ac0-6356-9330-a745-b43e620d051b@kernel.org>
Date:   Wed, 26 Jan 2022 10:52:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] edac: altera: fix deferred probing
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org
References: <20220124185503.6720-1-s.shtylyov@omp.ru>
 <20220124185503.6720-2-s.shtylyov@omp.ru>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20220124185503.6720-2-s.shtylyov@omp.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 1/24/22 12:55, Sergey Shtylyov wrote:
> The driver overrides the error codes returned by platform_get_irq() to
> -ENODEV for some strange reason, so if it returns -EPROBE_DEFER, the
> driver will fail the probe permanently instead of the deferred probing.
> Switch to propagating the error codes upstream.
> 
> Fixes: 71bcada88b0f ("edac: altera: Add Altera SDRAM EDAC support")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> ---
>   drivers/edac/altera_edac.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> index 3a6d2416cb0f..5dd29789f97d 100644
> --- a/drivers/edac/altera_edac.c
> +++ b/drivers/edac/altera_edac.c
> @@ -350,7 +350,7 @@ static int altr_sdram_probe(struct platform_device *pdev)
>   	if (irq < 0) {
>   		edac_printk(KERN_ERR, EDAC_MC,
>   			    "No irq %d in DT\n", irq);
> -		return -ENODEV;
> +		return irq;
>   	}
>   
>   	/* Arria10 has a 2nd IRQ */


Acked-by: Dinh Nguyen <dinguyen@kernel.org>
