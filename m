Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58ADDD3DFF
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2019 13:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfJKLKm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Oct 2019 07:10:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48652 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbfJKLKl (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 11 Oct 2019 07:10:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bvsxL4xTjAxm1Qwv2DGgy5dBrsc86Kxe1/FQOYOIe2g=; b=lGwr1+YD0zPkpqFj+oom2dUzl
        WS1BbQuUbOcTP6lfZCS3w/C9df7M+NqMSGWXpknOGhI3/e0ATyDGENPSPpDi6stVHOEp7apSibBhO
        u28MeKxiEQ6K2v7mo5GSF3og5evt63NSi4rBLszDofve3S6oK9HkHSoTq3jqs0EgA9f4MWSrznlLw
        Ab19fHsNdW9PmCRcbCXFhFb1AzwsrBCX3txLySBgatc7UScH3UjuuQXcK6guHIfy8z24bG2kTYg4s
        cHZ2L5JT0Ovv0pIWrBJcNCr7G5ZrlediDwaNELdk/DbJIdMN2kvvmAy9HqruLdLR54MaxWXkhsxzR
        cYTMaZW7Q==;
Received: from 177.17.141.107.dynamic.adsl.gvt.net.br ([177.17.141.107] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIsod-0003Fr-Rc; Fri, 11 Oct 2019 11:10:36 +0000
Date:   Fri, 11 Oct 2019 08:10:31 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 15/19] EDAC, ghes: Use standard kernel macros for page
 calculations
Message-ID: <20191011081031.33d47242@coco.lan>
In-Reply-To: <20191010202418.25098-16-rrichter@marvell.com>
References: <20191010202418.25098-1-rrichter@marvell.com>
        <20191010202418.25098-16-rrichter@marvell.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Thu, 10 Oct 2019 20:25:35 +0000
Robert Richter <rrichter@marvell.com> escreveu:

> Use standard macros for page calculations.
> 
> Reviewed-by: James Morse <james.morse@arm.com>
> Signed-off-by: Robert Richter <rrichter@marvell.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  drivers/edac/ghes_edac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index 8078d4ec9631..851aad92e42d 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -309,8 +309,8 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>  
>  	/* Error address */
>  	if (mem_err->validation_bits & CPER_MEM_VALID_PA) {
> -		e->page_frame_number = mem_err->physical_addr >> PAGE_SHIFT;
> -		e->offset_in_page = mem_err->physical_addr & ~PAGE_MASK;
> +		e->page_frame_number = PHYS_PFN(mem_err->physical_addr);
> +		e->offset_in_page = offset_in_page(mem_err->physical_addr);
>  	}
>  
>  	/* Error grain */



Thanks,
Mauro
