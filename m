Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7CF8D699
	for <lists+linux-edac@lfdr.de>; Wed, 14 Aug 2019 16:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfHNOwJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 14 Aug 2019 10:52:09 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33424 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbfHNOwJ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 14 Aug 2019 10:52:09 -0400
Received: from zn.tnic (p200300EC2F0BD0000538F16F91702398.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:d000:538:f16f:9170:2398])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 98A761EC0554;
        Wed, 14 Aug 2019 16:52:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565794327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BskQ5DhIGKuIwHy1nktd9lNxwb4SfiRB6QlSE0m/dGg=;
        b=LdIlYROee9QJn5dmedFuc/APWt+04NVXrE7HGkSFbSMJSzIy2kPkCLhPLZLkkyphnszX+u
        hdWUayRHu3tgHxWSHq9TM24jG5/R7DHefUVi0zZGO6m5yvnv0JUwQHhlI0L2FcQz9ycjOm
        H9DXhh7GCz+dVhCHzhqiLJ9oZWFclh0=
Date:   Wed, 14 Aug 2019 16:52:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 07/24] EDAC: Kill EDAC_DIMM_OFF() macro
Message-ID: <20190814145252.GA1841@zn.tnic>
References: <20190624150758.6695-1-rrichter@marvell.com>
 <20190624150758.6695-8-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190624150758.6695-8-rrichter@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jun 24, 2019 at 03:09:09PM +0000, Robert Richter wrote:
> We do not need to calculate the offset in the mc's dimm array, let's
> just store the index in struct dimm_info and we can get rid of this
> macro.
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---
>  drivers/edac/edac_mc.c       | 13 ++++--------
>  drivers/edac/edac_mc_sysfs.c | 20 ++++--------------
>  include/linux/edac.h         | 41 ------------------------------------
>  3 files changed, 8 insertions(+), 66 deletions(-)

I like this cleanup a lot. Good!

> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index c959e8b1643c..c44bc83e8502 100644
> --- a/drivers/edac/edac_mc.c
> +++ b/drivers/edac/edac_mc.c
> @@ -318,7 +318,7 @@ struct mem_ctl_info *edac_mc_alloc(unsigned mc_num,
>  	unsigned size, tot_dimms = 1, count = 1;
>  	unsigned tot_csrows = 1, tot_channels = 1, tot_errcount = 0;
>  	void *pvt, *p, *ptr = NULL;
> -	int i, j, row, chn, n, len, off;
> +	int idx, i, j, row, chn, n, len;
>  	bool per_rank = false;
>  
>  	BUG_ON(n_layers > EDAC_MAX_LAYERS || n_layers == 0);
> @@ -426,20 +426,15 @@ struct mem_ctl_info *edac_mc_alloc(unsigned mc_num,
>  	memset(&pos, 0, sizeof(pos));
>  	row = 0;
>  	chn = 0;
> -	for (i = 0; i < tot_dimms; i++) {
> +	for (idx = 0; idx < tot_dimms; idx++) {
>  		chan = mci->csrows[row]->channels[chn];
> -		off = EDAC_DIMM_OFF(layer, n_layers, pos[0], pos[1], pos[2]);
> -		if (off < 0 || off >= tot_dimms) {
> -			edac_mc_printk(mci, KERN_ERR, "EDAC core bug: EDAC_DIMM_OFF is trying to do an illegal data access\n");
> -			goto error;
> -		}

Btw, right around here there's a comment:

        /*
         * Allocate and fill the dimm structs
         */

and since you're cleaning up all this, can you please add another patch
which takes all that code under the comment and see if you can carve it
out into a separate helper edac_alloc_dimms() or so. Because that
edac_mc_alloc() function is huuuge.

Btw, the code under

        /*
         * Alocate and fill the csrow/channels structs
         */

begs to be a separate function too :-)

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
