Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF281B4E9D
	for <lists+linux-edac@lfdr.de>; Wed, 22 Apr 2020 22:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgDVUwt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 22 Apr 2020 16:52:49 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51874 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgDVUwt (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 22 Apr 2020 16:52:49 -0400
Received: from zn.tnic (p200300EC2F0DC10035D7F52705C6D57D.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:c100:35d7:f527:5c6:d57d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7E0261EC0D10;
        Wed, 22 Apr 2020 22:52:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1587588767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=u+HqmlOUses7b9oLfg+sdTbrH1hHJKz/zlSE9Ft+gjs=;
        b=Sguza6MMZRSvNRezF/I/pHCBEKrR0CjVdwrACCOtO81Npt30UPWUujWaQu2J6BGAcuE9AW
        wX/bHCHxHRsGULDBwDr00Z4M22ZSa8wnKbimhMLQwYSA4sb3tMHyO7p3XaGbPrTOMU9gDt
        ujDlxMX9JTyCQdFjZQXd09MJtvmmThQ=
Date:   Wed, 22 Apr 2020 22:52:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Matthias Brugger <mbrugger@suse.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/10] EDAC/mc: Fix usage of snprintf() and dimm
 location setup
Message-ID: <20200422205243.GH26846@zn.tnic>
References: <20200422115814.22205-1-rrichter@marvell.com>
 <20200422115814.22205-2-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200422115814.22205-2-rrichter@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Apr 22, 2020 at 01:58:05PM +0200, Robert Richter wrote:
> The setup of the dimm->location may be incomplete in case writing to
> dimm->label fails due to small buffer size. Fix this by iterating
> through all existing layers.
> 
> Also, the return value of snprintf() can be higher than the number of
> bytes written to the buffer in case it is to small. Fix usage of
> snprintf() by either porting it to scnprintf() or fixing the handling
> of the return code.
> 
> It is very unlikely the buffer is too small in practice, but fixing it
> anyway.
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---
>  drivers/edac/edac_mc.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index 75ede27bdf6a..107d7c4de933 100644
> --- a/drivers/edac/edac_mc.c
> +++ b/drivers/edac/edac_mc.c
> @@ -130,11 +130,11 @@ unsigned int edac_dimm_info_location(struct dimm_info *dimm, char *buf,
>  		n = snprintf(p, len, "%s %d ",
>  			      edac_layer_name[mci->layers[i].type],
>  			      dimm->location[i]);
> +		if (len <= n)
> +			return count + len - 1;
>  		p += n;
>  		len -= n;
>  		count += n;
> -		if (!len)
> -			break;
>  	}
>  
>  	return count;
> @@ -397,19 +397,19 @@ static int edac_mc_alloc_dimms(struct mem_ctl_info *mci)
>  		 */
>  		len = sizeof(dimm->label);
>  		p = dimm->label;
> -		n = snprintf(p, len, "mc#%u", mci->mc_idx);
> +		n = scnprintf(p, len, "mc#%u", mci->mc_idx);
>  		p += n;
>  		len -= n;
> +
>  		for (layer = 0; layer < mci->n_layers; layer++) {
> -			n = snprintf(p, len, "%s#%u",
> -				     edac_layer_name[mci->layers[layer].type],
> -				     pos[layer]);

The edac_layer_name[]'s are single words of a couple of letters and the
pos is a number. The buffer we pass in is at least 80 chars and in one
place even a PAGE_SIZE.

But in general, this is just silly with the buffers on stack and
printing into them.

It would be much better to opencode that loop in
edac_dimm_info_location() and simply dump those layer names at the call
sites. And then kill that silly edac_dimm_info_location() function. See
below for example.

And then since two call sites do edac_dbg(), you can put that in a
function edac_dbg_dump_dimm_location() or so and call it and not care
about any buffer lengths and s*printf's and so on.

Right?

---
diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 422120793a6b..7c04ef0c3536 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -91,16 +91,23 @@ static void edac_mc_dump_channel(struct rank_info *chan)
 
 static void edac_mc_dump_dimm(struct dimm_info *dimm)
 {
-	char location[80];
+	struct mem_ctl_info *mci = dimm->mci;
+	int i;
 
 	if (!dimm->nr_pages)
 		return;
 
-	edac_dimm_info_location(dimm, location, sizeof(location));
+	edac_dbg(4, "%s%i: ", dimm->mci->csbased ? "rank" : "dimm", dimm->idx);
+
+	for (i = 0; i < mci->n_layers; i++)
+		edac_dbg(4, "%s %d ",
+			 edac_layer_name[mci->layers[i].type],
+			 dimm->location[i]);
+
+	edac_dbg(4, "mapped as virtual row %d, chan %d\n",
+		 dimm->csrow, dimm->cschannel);
 
-	edac_dbg(4, "%s%i: %smapped as virtual row %d, chan %d\n",
-		 dimm->mci->csbased ? "rank" : "dimm",
-		 dimm->idx, location, dimm->csrow, dimm->cschannel);
 	edac_dbg(4, "  dimm = %p\n", dimm);
 	edac_dbg(4, "  dimm->label = '%s'\n", dimm->label);
 	edac_dbg(4, "  dimm->nr_pages = 0x%x\n", dimm->nr_pages);

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
