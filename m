Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A45E8FED6
	for <lists+linux-edac@lfdr.de>; Fri, 16 Aug 2019 11:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfHPJYB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 16 Aug 2019 05:24:01 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49130 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbfHPJYB (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 16 Aug 2019 05:24:01 -0400
Received: from zn.tnic (p200300EC2F0A920014AE47D987991812.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:9200:14ae:47d9:8799:1812])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A73951EC067D;
        Fri, 16 Aug 2019 11:23:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565947439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=cygAj/2KeoXPUrfXfBK12mcmYpE6aLde83uSyzIMb0w=;
        b=DRYCBg1pOzz4Hg5+hYpeC8vfN1VRSyA41igLJ3kSFnBCEYKX/udaByrO777XrleI6b//ep
        XLKNWs/PXwQBq/XEDxy4/OGtHeIXJYgCtGJKhfdlu2rEgJWSsd89y/fWxQZGLNBtSVYuMW
        SiuDPpWaB7BuIlAZdHhYEEeX0aMRRIc=
Date:   Fri, 16 Aug 2019 11:24:49 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 10/24] EDAC, mc: Remove per layer counters
Message-ID: <20190816092449.GK18980@zn.tnic>
References: <20190624150758.6695-1-rrichter@marvell.com>
 <20190624150758.6695-11-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190624150758.6695-11-rrichter@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jun 24, 2019 at 03:09:15PM +0000, Robert Richter wrote:
> Looking at how mci->{ue,ce}_per_layer[EDAC_MAX_LAYERS] is used, it
> turns out that only the leaves in the memory hierarchy are consumed
> (in sysfs), but not the intermediate layers, e.g.:
> 
>  count = dimm->mci->ce_per_layer[dimm->mci->n_layers-1][dimm->idx];
> 
> So let's get rid of the unused counters that just add complexity.
> 
> Error counter values are directly stored in struct dimm_info now.
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---
>  drivers/edac/edac_mc.c       | 98 ++++++++++++------------------------
>  drivers/edac/edac_mc_sysfs.c | 20 +++-----
>  drivers/edac/ghes_edac.c     |  5 +-
>  include/linux/edac.h         |  7 ++-
>  4 files changed, 44 insertions(+), 86 deletions(-)
> 
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index f2acdab34eb7..bce39b2e10c9 100644
> --- a/drivers/edac/edac_mc.c
> +++ b/drivers/edac/edac_mc.c
> @@ -313,10 +313,9 @@ struct mem_ctl_info *edac_mc_alloc(unsigned mc_num,
>  	struct csrow_info *csr;
>  	struct rank_info *chan;
>  	struct dimm_info *dimm;
> -	u32 *ce_per_layer[EDAC_MAX_LAYERS], *ue_per_layer[EDAC_MAX_LAYERS];
>  	unsigned pos[EDAC_MAX_LAYERS];
> -	unsigned size, tot_dimms = 1, count = 1;
> -	unsigned tot_csrows = 1, tot_channels = 1, tot_errcount = 0;
> +	unsigned size, tot_dimms = 1;
> +	unsigned tot_csrows = 1, tot_channels = 1;

Pls fix those while touching this:

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
#48: FILE: drivers/edac/edac_mc.c:317:
+       unsigned size, tot_dimms = 1;

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
#49: FILE: drivers/edac/edac_mc.c:318:
+       unsigned tot_csrows = 1, tot_channels = 1;

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
