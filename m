Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51E0D41B35
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2019 06:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbfFLEeS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 12 Jun 2019 00:34:18 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58108 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbfFLEeS (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 12 Jun 2019 00:34:18 -0400
Received: from zn.tnic (p200300EC2F0A6800EC6A653BF86B372A.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:6800:ec6a:653b:f86b:372a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CD5081EC0985;
        Wed, 12 Jun 2019 06:34:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560314057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4wdmF5v70+FZcs+sqWKM5Lxnhk+mJCMfROaaOTNV2m4=;
        b=UgQIB1EfweGipI0w2l5z97jLULK08BUZYAC60VO3S1KffrkBafh9dYKpbnctWu6zPtnVCA
        yxj76vaTdQeyMULb4w6xrazlDPVdbKoP9nldf8CvlvS5KbKpzo6+LSoNFubyMHVgJ8jzON
        Ml4BRB4lZu090xlQPlQrWjOJOybRunU=
Date:   Wed, 12 Jun 2019 06:34:10 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     James Morse <james.morse@arm.com>
Cc:     linux-edac@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rrichter@marvell.com>,
        Toshi Kani <toshi.kani@hpe.com>
Subject: Re: [PATCH] EDAC, ghes: Fix grain calculation
Message-ID: <20190612043410.GE32652@zn.tnic>
References: <20190529152232.187580-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190529152232.187580-1-james.morse@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, May 29, 2019 at 04:22:32PM +0100, James Morse wrote:
> ghes_edac_report_mem_error() attempts to calculate the 'grain' or
> granule affected by the error from the firmware-provided 'physical address
> mask'. This mask tells us which bits of the physical address are valid.
> 
> The current calculation:
> | e->grain = ~(mem_err->physical_addr_mask & ~PAGE_MASK);
> will always cause the top bits to be set as they are cleared by &,
> then set again by ~. For a hypervisor reporting its page-size as the
> region affected by the error:
> | {1}[Hardware Error]:   physical_address: 0x00000000deadbeef
> | {1}[Hardware Error]:   physical_address_mask: 0xfffffffffffff000
> | {1}[Hardware Error]:   error_type: 6, master abort
> | EDAC MC0: 1 CE Master abort on unknown label ( page:0xdead offset:0xbeef
> | grain:-61441 syndrome:0x0 - status(0x0000000000000001): reserved)
> 
> Here the grain has been miscalculated as the hypervisor reported a 4K
> size granule, due to its page size, whereas the guest kernel uses 64K.
> This gives us e->grain of 0xffffffffffff0fff
> 
> Fix this, calculating grain_bits directly from ~physical_address_mask,
> and setting e->grain from that. In the same example we now get:
> | EDAC MC0: 1 CE Master abort on unknown label ( page:0xdead offset:0xbeef
> | grain:4096 syndrome:0x0 - status(0x0000000000000001): reserved)
> 
> Cc: Robert Richter <rrichter@marvell.com>
> Cc: Toshi Kani <toshi.kani@hpe.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> This has always been broken, so I suspect no-one cares about this, it was
> added by:
> Fixes: f04c62a7036a ("ghes_edac: add support for reporting errors via EDAC")
> 
> I've only tested this with firmware I've written.
> 
>  drivers/edac/ghes_edac.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index 49396bf6ad88..fac96ff45b7e 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -202,8 +202,8 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>  	struct mem_ctl_info *mci;
>  	struct ghes_edac_pvt *pvt = ghes_pvt;
>  	unsigned long flags;
> +	u8 grain_bits = 0;
>  	char *p;
> -	u8 grain_bits;
>  
>  	if (!pvt)
>  		return;
> @@ -318,8 +318,10 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>  	}
>  
>  	/* Error grain */
> -	if (mem_err->validation_bits & CPER_MEM_VALID_PA_MASK)
> -		e->grain = ~(mem_err->physical_addr_mask & ~PAGE_MASK);
> +	if (mem_err->validation_bits & CPER_MEM_VALID_PA_MASK) {
> +		grain_bits = fls_long(~mem_err->physical_addr_mask);
> +		e->grain = 1UL<<grain_bits;

Do we need to set that e->grain at all?

I mean, we set it now so that grain_bits can be computed but since
you're doing that directly...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
