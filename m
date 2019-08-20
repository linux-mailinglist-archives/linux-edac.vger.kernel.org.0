Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C55A295A74
	for <lists+linux-edac@lfdr.de>; Tue, 20 Aug 2019 10:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbfHTI4v (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 20 Aug 2019 04:56:51 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55922 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728426AbfHTI4v (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 20 Aug 2019 04:56:51 -0400
Received: from zn.tnic (p200300EC2F0AD10001577AF918CCB8A8.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:d100:157:7af9:18cc:b8a8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DF4A61EC0419;
        Tue, 20 Aug 2019 10:56:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1566291410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=DTDawrUgs8m+8/GyOkLQsS8koeKs/F5X6jSkAeCSZm8=;
        b=JqB1d+sbB1AuxVOahhbDpPfBNKfKYKnD5JMuHWCLmgM+fxtl9FVJNT1blKpz6ybee/MBg2
        38zujtQt5i3kcei5441cdfRAadSxDB30BMBOAznXJVptBwxzciXOrn5o8Mbi/9AiZei5Hg
        rwSOtYeUCrhyvL6d7YG/uyWU5b8rEhk=
Date:   Tue, 20 Aug 2019 10:56:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 14/24] EDAC, ghes: Rework memory hierarchy detection
Message-ID: <20190820085647.GA31607@zn.tnic>
References: <20190624150758.6695-1-rrichter@marvell.com>
 <20190624150758.6695-15-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190624150758.6695-15-rrichter@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jun 24, 2019 at 03:09:24PM +0000, Robert Richter wrote:
> In a later patch we want to add more information about the memory
> hierarchy (NUMA topology, DIMM label information). Rework memory
> hierarchy detection to make the code extendable for this.
> 
> The general approach is roughly like:
> 
> 	mem_info_setup();
> 	for_each_node(nid) {
> 		mci = edac_mc_alloc(nid);
> 		mem_info_prepare_mci(mci);
> 		edac_mc_add_mc(mci);
> 	};
> 
> This patch introduces mem_info_setup() and mem_info_prepare_mci().

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

> All data of the memory hierarchy is collected in a local struct
> ghes_mem_info.
> 
> Note: Per (NUMA) node registration will be implemented in a later
> patch.

That sentence is not needed in the commit message.

> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---
>  drivers/edac/ghes_edac.c | 166 ++++++++++++++++++++++++++++++---------
>  1 file changed, 127 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index 8063996a311d..44bfb499b147 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -65,17 +65,53 @@ struct memdev_dmi_entry {
>  	u16 conf_mem_clk_speed;
>  } __attribute__((__packed__));
>  
> -struct ghes_edac_dimm_fill {
> -	struct mem_ctl_info *mci;
> -	unsigned count;

All those "dimm" and "info" words everywhere are making my head spin.
Let's make it more readable:

> +struct ghes_dimm_info {
> +	struct dimm_info dimm_info;
> +	int		idx;
> +};
> +
> +struct ghes_mem_info {
> +	int num_dimm;
> +	struct ghes_dimm_info *dimms;
>  };
>  
> +static struct ghes_mem_info mem_info;

/* A DIMM */
struct ghes_dimm {
        struct dimm_info dimm;
        int idx;
};

/* The memory layout of the system */
struct ghes_memory {
        struct ghes_dimm *dimms;
        int num_dimms;
};

static struct ghes_memory mem;

> +
> +#define for_each_dimm(dimm)				\
> +	for (dimm = mem_info.dimms;			\
> +	     dimm < mem_info.dimms + mem_info.num_dimm;	\
> +	     dimm++)
> +
>  static void ghes_edac_count_dimms(const struct dmi_header *dh, void *arg)
>  {
> -	int *num_dimm = arg;
> +	int *num = arg;
>  
>  	if (dh->type == DMI_ENTRY_MEM_DEVICE)
> -		(*num_dimm)++;
> +		(*num)++;
> +}
> +
> +static int ghes_dimm_info_init(int num)

ghes_dimm_init()

... you get the idea - let's drop the _info crap.

> +{
> +	struct ghes_dimm_info *dimm;
> +	int idx = 0;
> +
> +	memset(&mem_info, 0, sizeof(mem_info));
> +
> +	if (num <= 0)
> +		return -EINVAL;

Move that check into the caller mem_info_setup() so that you don't do
the memset unnecessarily.

> +
> +	mem_info.dimms = kcalloc(num, sizeof(*mem_info.dimms), GFP_KERNEL);
> +	if (!mem_info.dimms)
> +		return -ENOMEM;
> +
> +	mem_info.num_dimm = num;
> +
> +	for_each_dimm(dimm) {
> +		dimm->idx	= idx;
> +		idx++;
> +	}

or simply

	for_each_dimm(dimm)
		dimm->idx = idx++;

> +
> +	return 0;
>  }
>  
>  static int get_dimm_smbios_index(u16 handle)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
