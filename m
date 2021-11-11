Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99B544D706
	for <lists+linux-edac@lfdr.de>; Thu, 11 Nov 2021 14:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhKKNPL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 11 Nov 2021 08:15:11 -0500
Received: from mail.skyhub.de ([5.9.137.197]:55026 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230497AbhKKNPK (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 11 Nov 2021 08:15:10 -0500
Received: from zn.tnic (p200300ec2f0fc2009b8aa8c4b7cee745.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:c200:9b8a:a8c4:b7ce:e745])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E5C1F1EC053B;
        Thu, 11 Nov 2021 14:12:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636636340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BB/5j8yp8zgZTafTr+YIfIDcdB1GvmcYy75NcA3IPWE=;
        b=FoAt07H942Ks49t/dJN7rbEGovvLpRKsd8PdA1BNLYhlrU0Vs5VZt0QNbWq25j959e9GF2
        tkef26RJNMi4vj/SoXitcc1ZgezU5dwixoWiI62q0Dzr2HZiteTCeXqGfNo/+AW6/yoMWv
        usPKFy6j+N4Gnk68RvjAFjSDUVNgS/k=
Date:   Thu, 11 Nov 2021 14:12:12 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, mchehab@kernel.org,
        yazen.ghannam@amd.com, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v6 5/5] EDAC/amd64: Enumerate memory on Aldebaran GPU
 nodes
Message-ID: <YY0WrKjnQ20IjrhB@zn.tnic>
References: <20211028130106.15701-1-nchatrad@amd.com>
 <20211028130106.15701-6-nchatrad@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211028130106.15701-6-nchatrad@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Oct 28, 2021 at 06:31:06PM +0530, Naveen Krishna Chatradhi wrote:
> On newer heterogeneous systems with AMD CPUs, the data fabrics of the GPUs
> are connected directly via custom links.
> 
> One such system, where Aldebaran GPU nodes are connected to the
> Family 19h, model 30h family of CPU nodes, the Aldebaran GPUs can report
> memory errors via SMCA banks.
> 
> Aldebaran GPU support was added to DRM framework
> https://lists.freedesktop.org/archives/amd-gfx/2021-February/059694.html
> 
> The GPU nodes comes with HBM2 memory in-built, ECC support is enabled by
> default and the UMCs on GPU node are different from the UMCs on CPU nodes.
> 
> GPU specific ops routines are defined to extend the amd64_edac
> module to enumerate HBM memory leveraging the existing edac and the
> amd64 specific data structures.
> 
> Note: The UMC Phys on GPU nodes are enumerated as csrows and the UMC
> channels connected to HBM banks are enumerated as ranks.

For all your future commit messages, from
Documentation/process/submitting-patches.rst:

 "Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
  instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
  to do frotz", as if you are giving orders to the codebase to change
  its behaviour."

Also, do not talk about what your patch does - that should hopefully be
visible in the diff itself. Rather, talk about *why* you're doing what
you're doing.

> 
> Cc: Yazen Ghannam <yazen.ghannam@amd.com>
> Co-developed-by: Muralidhara M K <muralimk@amd.com>
> Signed-off-by: Muralidhara M K <muralimk@amd.com>
> Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
> Link: https://lkml.kernel.org/r/20210823185437.94417-4-nchatrad@amd.com
> ---
> Changes since v5:
> Removed else condition in per_family_init for 19h family
> 
> Changes since v4:
>  Split "f17_addr_mask_to_cs_size" instead as did in 3rd patch earlier
> 
> Changes since v3:
> 1. Bifurcated the GPU code from v2
> 
> Changes since v2:
> 1. Restored line deletions and handled minor comments
> 2. Modified commit message and some of the function comments
> 3. variable df_inst_id is introduced instead of umc_num
> 
> Changes since v1:
> 1. Modifed the commit message
> 2. Change the edac_cap
> 3. kept sizes of both cpu and noncpu together
> 4. return success if the !F3 condition true and remove unnecessary validation
> 
>  drivers/edac/amd64_edac.c | 298 +++++++++++++++++++++++++++++++++-----
>  drivers/edac/amd64_edac.h |  27 ++++
>  2 files changed, 292 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 7953ffe9d547..b404fa5b03ce 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -1121,6 +1121,20 @@ static void debug_display_dimm_sizes_df(struct amd64_pvt *pvt, u8 ctrl)
>  	}
>  }
>  
> +static void debug_display_dimm_sizes_gpu(struct amd64_pvt *pvt, u8 ctrl)
> +{
> +	int size, cs = 0, cs_mode;
> +
> +	edac_printk(KERN_DEBUG, EDAC_MC, "UMC%d chip selects:\n", ctrl);
> +
> +	cs_mode = CS_EVEN_PRIMARY | CS_ODD_PRIMARY;
> +
> +	for_each_chip_select(cs, ctrl, pvt) {
> +		size = pvt->ops->dbam_to_cs(pvt, ctrl, cs_mode, cs);
> +		amd64_info(EDAC_MC ": %d: %5dMB\n", cs, size);
> +	}
> +}
> +
>  static void __dump_misc_regs_df(struct amd64_pvt *pvt)
>  {
>  	struct amd64_umc *umc;
> @@ -1165,6 +1179,27 @@ static void __dump_misc_regs_df(struct amd64_pvt *pvt)
>  		 pvt->dhar, dhar_base(pvt));
>  }
>  
> +static void __dump_misc_regs_gpu(struct amd64_pvt *pvt)

The function pointer this gets assigned to is called *get*_misc_regs.
But this function is is doing *dump*.

When I see __dump_misc_regs_gpu() I'd expect this function to be called
by a higher level dump_misc_regs() as the "__" denotes layering usually.

There is, in fact, dump_misc_regs() but that one calls
->get_misc_regs().

So this all needs fixing - right now I see a mess.

Also, there's <function_name>_gpu and gpu_<function_name> with the "gpu"
being either prefix or suffix. You need to fix the current ones to be
only prefixes - in a pre-patch - and then add yours as prefixes only too.

And in talking about pre-patches - this one is doing a bunch of things
at once and needs splitting. You do the preparatory work like carving
out common functionality and other refactoring in pre-patches, and then
you add the new functionality ontop.

Also, I don't like ->is_gpu one bit, it being sprinkled like that around
the code. This says that the per-family attrs and ops assignment is
lacking.


> @@ -2982,7 +3132,17 @@ static void decode_umc_error(int node_id, struct mce *m)
>  
>  	pvt->ops->get_umc_err_info(m, &err);
>  
> -	if (umc_normaddr_to_sysaddr(m->addr, pvt->mc_node_id, err.channel, &sys_addr)) {
> +	/*
> +	 * GPU node has #phys[X] which has #channels[Y] each.
> +	 * On GPUs, df_inst_id = [X] * num_ch_per_phy + [Y].
> +	 * On CPUs, "Channel"="UMC Number"="DF Instance ID".
> +	 */

This comment doesn't look like it is destined for human beings to read
but maybe to be parsed by programs?

> +	if (pvt->is_gpu)
> +		df_inst_id = (err.csrow * pvt->channel_count / mci->nr_csrows) + err.channel;

I'm not sure we want to log ECCs from the GPUs: what is going to happen
to them, how does the further error recovery look like?

Also, EDAC sysfs structure currently has only DIMMs, below's from my
box.

I don't see how that structure fits the GPUs so here's the $10^6
question: why does EDAC need to know about GPUs?

What is the strategy here?

Your 0th message talks about the "what" but what gets added is not
important - the "why" is.

$ grep -r . /sys/devices/system/edac/mc/ 2>/dev/null
/sys/devices/system/edac/mc/power/runtime_active_time:0
/sys/devices/system/edac/mc/power/runtime_status:unsupported
/sys/devices/system/edac/mc/power/runtime_suspended_time:0
/sys/devices/system/edac/mc/power/control:auto
/sys/devices/system/edac/mc/mc0/ce_count:0
/sys/devices/system/edac/mc/mc0/rank7/dimm_ue_count:0
/sys/devices/system/edac/mc/mc0/rank7/dimm_mem_type:Unbuffered-DDR4
/sys/devices/system/edac/mc/mc0/rank7/power/runtime_active_time:0
/sys/devices/system/edac/mc/mc0/rank7/power/runtime_status:unsupported
/sys/devices/system/edac/mc/mc0/rank7/power/runtime_suspended_time:0
/sys/devices/system/edac/mc/mc0/rank7/power/control:auto
/sys/devices/system/edac/mc/mc0/rank7/dimm_dev_type:Unknown
/sys/devices/system/edac/mc/mc0/rank7/size:8192
/sys/devices/system/edac/mc/mc0/rank7/dimm_ce_count:0
/sys/devices/system/edac/mc/mc0/rank7/dimm_label:mc#0csrow#3channel#1
/sys/devices/system/edac/mc/mc0/rank7/dimm_location:csrow 3 channel 1 
/sys/devices/system/edac/mc/mc0/rank7/dimm_edac_mode:SECDED
/sys/devices/system/edac/mc/mc0/topmem:0x00000000e0000000
/sys/devices/system/edac/mc/mc0/mc_name:F17h
/sys/devices/system/edac/mc/mc0/rank5/dimm_ue_count:0
/sys/devices/system/edac/mc/mc0/rank5/dimm_mem_type:Unbuffered-DDR4
/sys/devices/system/edac/mc/mc0/rank5/power/runtime_active_time:0
/sys/devices/system/edac/mc/mc0/rank5/power/runtime_status:unsupported
/sys/devices/system/edac/mc/mc0/rank5/power/runtime_suspended_time:0
/sys/devices/system/edac/mc/mc0/rank5/power/control:auto
/sys/devices/system/edac/mc/mc0/rank5/dimm_dev_type:Unknown
/sys/devices/system/edac/mc/mc0/rank5/size:8192
/sys/devices/system/edac/mc/mc0/rank5/dimm_ce_count:0
/sys/devices/system/edac/mc/mc0/rank5/dimm_label:mc#0csrow#2channel#1
/sys/devices/system/edac/mc/mc0/rank5/dimm_location:csrow 2 channel 1 
/sys/devices/system/edac/mc/mc0/rank5/dimm_edac_mode:SECDED
/sys/devices/system/edac/mc/mc0/dram_hole:0 0 0
/sys/devices/system/edac/mc/mc0/ce_noinfo_count:0
...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
