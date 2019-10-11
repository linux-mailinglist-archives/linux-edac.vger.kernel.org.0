Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC4ED3E48
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2019 13:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfJKLWI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Oct 2019 07:22:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33844 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbfJKLWI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 11 Oct 2019 07:22:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/8Id3ugL0O8RKpYToVrLYrKK03KtyD4dKKaWqFDdBWU=; b=EBvEVfbOOtR5yjCP2cFOZZqem
        X39yfTuFdhsPxutnGElu7I8hqGw/wLL+UeDTZsCAVi8Yrm4cJ5DcdkuQW+2+oLWsdqNCHB5xlbRtI
        gr/R54GTAF2nOS5XIDZUQnfGHsNdukDDXbaV/muifi5E92HqXv82VkBdmcYaX3UXWUQi65jsPaWay
        3M9A8g8/nQo8O+lzf0queAmHBGB0pwN6HAYGZY5r2V9bvGLjLzmn9Ukctt6XXmtEyCJLEfLZap/wl
        CIpVTRvfgLSWbwewHRj6CNHOkkv0tueagDACg7lgtanPWnZ/QyrHR5z9GdZ8diaz9Kj0bjWYS1eKO
        CzhnIbN7g==;
Received: from 177.17.141.107.dynamic.adsl.gvt.net.br ([177.17.141.107] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIszl-0008Sl-Fk; Fri, 11 Oct 2019 11:22:05 +0000
Date:   Fri, 11 Oct 2019 08:22:01 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 16/19] EDAC, ghes: Fix grain calculation
Message-ID: <20191011082201.1b7c26ce@coco.lan>
In-Reply-To: <20191010202418.25098-17-rrichter@marvell.com>
References: <20191010202418.25098-1-rrichter@marvell.com>
        <20191010202418.25098-17-rrichter@marvell.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Thu, 10 Oct 2019 20:25:37 +0000
Robert Richter <rrichter@marvell.com> escreveu:

> The current code to convert a physical address mask to a grain
> (defined as granularity in bytes) is:
> 
> 	e->grain = ~(mem_err->physical_addr_mask & ~PAGE_MASK);
> 
> This is broken in several ways:
> 
> 1) It calculates to wrong grain values. E.g., a physical address mask
> of ~0xfff should give a grain of 0x1000. Without considering
> PAGE_MASK, there is an off-by-one. Things are worse when also
> filtering it with ~PAGE_MASK. This will calculate to a grain with the
> upper bits set. In the example it even calculates to ~0.
> 
> 2) The grain does not depend on and is unrelated to the kernel's
> page-size. The page-size only matters when unmapping memory in
> memory_failure(). Smaller grains are wrongly rounded up to the
> page-size, on architectures with a configurable page-size (e.g. arm64)
> this could round up to the even bigger page-size of the hypervisor.
> 
> Fix this with:
> 
> 	e->grain = ~mem_err->physical_addr_mask + 1;
> 
> The grain_bits are defined as:
> 
> 	grain = 1 << grain_bits;
> 
> Change also the grain_bits calculation accordingly, it is the same
> formula as in edac_mc.c now and the code can be unified.
> 
> The value in ->physical_addr_mask coming from firmware is assumed to
> be contiguous, but this is not sanity-checked. However, in case the
> mask is non-contiguous, a conversion to grain_bits effectively
> converts the grain bit mask to a power of 2 by rounding up.
> 
> Suggested-by: James Morse <james.morse@arm.com>
> Signed-off-by: Robert Richter <rrichter@marvell.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  drivers/edac/ghes_edac.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index 851aad92e42d..97242cf18a88 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -220,6 +220,7 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>  	/* Cleans the error report buffer */
>  	memset(e, 0, sizeof (*e));
>  	e->error_count = 1;
> +	e->grain = 1;
>  	strcpy(e->label, "unknown label");
>  	e->msg = pvt->msg;
>  	e->other_detail = pvt->other_detail;
> @@ -315,7 +316,7 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>  
>  	/* Error grain */
>  	if (mem_err->validation_bits & CPER_MEM_VALID_PA_MASK)
> -		e->grain = ~(mem_err->physical_addr_mask & ~PAGE_MASK);
> +		e->grain = ~mem_err->physical_addr_mask + 1;
>  
>  	/* Memory error location, mapped on e->location */
>  	p = e->location;
> @@ -428,8 +429,13 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>  	if (p > pvt->other_detail)
>  		*(p - 1) = '\0';
>  
> +	/* Sanity-check driver-supplied grain value. */
> +	if (WARN_ON_ONCE(!e->grain))
> +		e->grain = 1;
> +
> +	grain_bits = fls_long(e->grain - 1);
> +
>  	/* Generate the trace event */
> -	grain_bits = fls_long(e->grain);
>  	snprintf(pvt->detail_location, sizeof(pvt->detail_location),
>  		 "APEI location: %s %s", e->location, e->other_detail);
>  	trace_mc_event(e->type, e->msg, e->label, e->error_count,



Thanks,
Mauro
