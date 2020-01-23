Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2711147158
	for <lists+linux-edac@lfdr.de>; Thu, 23 Jan 2020 20:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgAWTCF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Jan 2020 14:02:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:49418 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbgAWTCF (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 23 Jan 2020 14:02:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 01FE2ABF6;
        Thu, 23 Jan 2020 19:02:02 +0000 (UTC)
Subject: Re: [PATCH v3 02/10] EDAC/mc: Reorder functions edac_mc_alloc*()
To:     Robert Richter <rrichter@marvell.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
Cc:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
References: <20200123090210.26933-1-rrichter@marvell.com>
 <20200123090210.26933-3-rrichter@marvell.com>
From:   Matthias Brugger <mbrugger@suse.com>
Message-ID: <45ce6d35-6e07-8ff4-5f67-84adfcb44f14@suse.com>
Date:   Thu, 23 Jan 2020 20:02:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200123090210.26933-3-rrichter@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 23/01/2020 10:02, Robert Richter wrote:
> Reorder the new created functions edac_mc_alloc_csrows() and
> edac_mc_alloc_dimms() and move them before edac_mc_alloc(). No further
> code changes.
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Acked-by: Aristeu Rozanski <aris@redhat.com>
> ---
>  drivers/edac/edac_mc.c | 209 ++++++++++++++++++++---------------------
>  1 file changed, 103 insertions(+), 106 deletions(-)
> 
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index d71006a4f07b..1e227e69e216 100644
> --- a/drivers/edac/edac_mc.c
> +++ b/drivers/edac/edac_mc.c
> @@ -311,112 +311,6 @@ static void mci_release(struct device *dev)
>  	kfree(mci);
>  }
>  
> -static int edac_mc_alloc_csrows(struct mem_ctl_info *mci);
> -static int edac_mc_alloc_dimms(struct mem_ctl_info *mci);
> -
> -struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
> -				   unsigned int n_layers,
> -				   struct edac_mc_layer *layers,
> -				   unsigned int sz_pvt)
> -{
[...]
> -	edac_dbg(1, "allocating %u bytes for mci data (%d %s, %d csrows/channels)\n",
> -		 size,
> -		 tot_dimms,
> -		 per_rank ? "ranks" : "dimms",
> -		 tot_csrows * tot_channels);
> -
> -	mci = kzalloc(size, GFP_KERNEL);
> -	if (mci == NULL)
> -		return NULL;
> -
> -	mci->dev.release = mci_release;
> -	device_initialize(&mci->dev);

Seems like some leftovers in your working tree. Are you sure you created the
patches against a clean upstream tree?

Regards,
Matthias

