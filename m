Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC2B11867E2
	for <lists+linux-edac@lfdr.de>; Mon, 16 Mar 2020 10:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbgCPJ3D (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 16 Mar 2020 05:29:03 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33714 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730410AbgCPJ3C (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 16 Mar 2020 05:29:02 -0400
Received: from zn.tnic (p200300EC2F06AB0069F33882ABEAD541.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:ab00:69f3:3882:abea:d541])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 137981EC0CAA;
        Mon, 16 Mar 2020 10:29:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1584350941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/6yYehhfRXpxa7Ic3XPedzuJ3VLB8PO82LBvRLGi1HY=;
        b=BOC94vEbR3zgncFkMS7aJVBMCERwbHiZ/IqOlJ392YobgaF4CDpN0qRrw8GBpW97tB6Sv6
        phCLHwQgg8y9MTalMInKENhrmDIiCASkSjmI/HjeheTM1ysazEjHlrQfmZRBrzqGMUoX5q
        Zo2hNQS3acRgXWYksoy2TsQZezU4dBc=
Date:   Mon, 16 Mar 2020 10:29:03 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] EDAC/ghes: Cleanup struct ghes_edac_dimm_fill,
 rename it to ghes_dimm_fill
Message-ID: <20200316092903.GA26126@zn.tnic>
References: <20200306151318.17422-1-rrichter@marvell.com>
 <20200306151318.17422-6-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200306151318.17422-6-rrichter@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Mar 06, 2020 at 04:13:12PM +0100, Robert Richter wrote:
> The struct is used to store temporary data for the dmidecode callback.
> Clean this up a bit:
> 
>  1) Rename it to something shorter and more reasonable.
> 
>  2) Rename member count to index since this is what it is used for.
> 
>  3) Move code close to ghes_edac_dmidecode() where it is used.
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---
>  drivers/edac/ghes_edac.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index 438972dfea09..358519e8c2e9 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -72,11 +72,6 @@ struct memdev_dmi_entry {
>  	u16 conf_mem_clk_speed;
>  } __attribute__((__packed__));
>  
> -struct ghes_edac_dimm_fill {
> -	struct mem_ctl_info *mci;
> -	unsigned int count;
> -};
> -
>  static void ghes_edac_count_dimms(const struct dmi_header *dh, void *arg)
>  {
>  	int *num_dimm = arg;
> @@ -113,18 +108,23 @@ static void ghes_dimm_setup_label(struct dimm_info *dimm, u16 handle)
>  			"unknown memory (handle: 0x%.4x)", handle);
>  }
>  
> +struct ghes_dimm_fill {

Locally used only so it can be just "dimm_fill" since you're shortening
it.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
