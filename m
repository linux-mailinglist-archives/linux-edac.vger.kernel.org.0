Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F253F7389
	for <lists+linux-edac@lfdr.de>; Wed, 25 Aug 2021 12:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238967AbhHYKnA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 25 Aug 2021 06:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240089AbhHYKm7 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 25 Aug 2021 06:42:59 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DC5C0613CF;
        Wed, 25 Aug 2021 03:42:13 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0ea70011deeb88edc9ec25.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:a700:11de:eb88:edc9:ec25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7651D1EC01FC;
        Wed, 25 Aug 2021 12:42:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629888126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=muIsawE1QGyeLgd3aCLPhMgNbL0H6rVJ+T3H0FTgaZk=;
        b=pDhv8u8Aos86pfceBCFp6CZr4/VZTLWhXwXt9Dvu1meqXgOszQSbCpSgGxZIWma5zzByWI
        eOI1NFhaJx7CC9YG3Xnf1GG9zK+Y5m5/pAxm3zD8KU5NtHAWK679mRJ8liww0W9EibnWbr
        PUNGbsrnVz5mujD7FKezPSZjcbBRFjU=
Date:   Wed, 25 Aug 2021 12:42:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        Yazen.Ghannam@amd.com, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v3 1/3] x86/amd_nb: Add support for northbridges on
 Aldebaran
Message-ID: <YSYeo6S2OSZbBpb4@zn.tnic>
References: <20210806074350.114614-4-nchatrad@amd.com>
 <20210823185437.94417-1-nchatrad@amd.com>
 <20210823185437.94417-2-nchatrad@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210823185437.94417-2-nchatrad@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Aug 24, 2021 at 12:24:35AM +0530, Naveen Krishna Chatradhi wrote:
> From: Muralidhara M K <muralimk@amd.com>
> 
> On newer systems the CPUs manage MCA errors reported from the GPUs.
> Enumerate the GPU nodes with the AMD NB framework to support EDAC.
> 
> This patch adds necessary code to manage the Aldebaran nodes along with

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

Also, what are the "Aldebaran nodes"?

Something on a star which is 65 light years away?

> the CPU nodes.
> 
> The GPU nodes are enumerated in sequential order based on the
> PCI hierarchy, and the first GPU node is assumed to have an "AMD Node
> ID" value of 8 (the second GPU node has 9, etc.).

What does that mean? The GPU nodes are simply numerically after the CPU
nodes or how am I to understand this nomenclature?

> Each Aldebaran GPU
> package has 2 Data Fabrics, which are enumerated as 2 nodes.
> With this implementation detail, the Data Fabric on the GPU nodes can be
> accessed the same way as the Data Fabric on CPU nodes.
> 
> Signed-off-by: Muralidhara M K <muralimk@amd.com>
> Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> Changes since v2: Added Reviewed-by Yazen Ghannam
> 
>  arch/x86/include/asm/amd_nb.h | 10 ++++++
>  arch/x86/kernel/amd_nb.c      | 63 ++++++++++++++++++++++++++++++++---
>  include/linux/pci_ids.h       |  1 +
>  3 files changed, 69 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
> index 455066a06f60..09905f6c7218 100644
> --- a/arch/x86/include/asm/amd_nb.h
> +++ b/arch/x86/include/asm/amd_nb.h
> @@ -80,6 +80,16 @@ struct amd_northbridge_info {
>  
>  #ifdef CONFIG_AMD_NB
>  
> +/*
> + * On newer heterogeneous systems the data fabrics of the CPUs and GPUs
> + * are connected directly via a custom links, like is done with

s/ a //

> + * 2 socket CPU systems and also within a socket for Multi-chip Module
> + * (MCM) CPUs like Naples.
> + * The first GPU node(non cpu) is assumed to have an "AMD Node ID" value

In all your text:

s/cpu/CPU/g

> + * of 8 (the second GPU node has 9, etc.).
> + */
> +#define NONCPU_NODE_INDEX	8

Why is this assumed? Can it instead be read from the hardware somewhere?
Or there simply won't be more than 8 CPU nodes anyway? Not at least in
the near future?

I'd prefer stuff to be read out directly from the hardware so that when
the hardware changes, the code just works instead of doing assumptions
which get invalidated later.

> +
>  u16 amd_nb_num(void);
>  bool amd_nb_has_feature(unsigned int feature);
>  struct amd_northbridge *node_to_amd_nb(int node);
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index 23dda362dc0f..6ad5664a18aa 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -26,6 +26,8 @@
>  #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4 0x1444
>  #define PCI_DEVICE_ID_AMD_19H_DF_F4	0x1654
>  #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
> +#define PCI_DEVICE_ID_AMD_ALDEBARAN_ROOT	0x14bb
> +#define PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F4	0x14d4

You see how those defines are aligned vertically, right?

If your new defines don't fit, you realign them all vertically too - you
don't just slap them there.

And if it wasn't clear above, that Aldebaran GPU chip name means
something only to AMD folks. If this is correct

https://en.wikipedia.org/wiki/Video_Core_Next

then that Aldebaran thing is VCN 2.6 although this is only the video
encoding stuff and GPU I guess is more than that.

IOW, what I'm trying to say is, just like we name the CPUs using their
families, you should name the GPUs nomenclature with GPU families (I
guess there's stuff like that) and not use the marketing crap.

If you need an example, here's how we did it for the Intel marketing
pile of bullsh*t:

arch/x86/include/asm/intel-family.h

Please provide a similar way of referring to the GPU chips.

>  /* Protect the PCI config register pairs used for SMN and DF indirect access. */
>  static DEFINE_MUTEX(smn_mutex);
> @@ -94,6 +96,21 @@ static const struct pci_device_id hygon_nb_link_ids[] = {
>  	{}
>  };
>  
> +static const struct pci_device_id amd_noncpu_root_ids[] = {

Why is that "noncpu" thing everywhere? Is this thing going to be
anything else besides a GPU?

If not, you can simply call it

	amd_gpu_root_ids

to mean *exactly* what they are. PCI IDs on the GPU.

> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_ALDEBARAN_ROOT) },
> +	{}
> +};
> +
> +static const struct pci_device_id amd_noncpu_nb_misc_ids[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F3) },
> +	{}
> +};
> +
> +static const struct pci_device_id amd_noncpu_nb_link_ids[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F4) },
> +	{}
> +};
> +
>  const struct amd_nb_bus_dev_range amd_nb_bus_dev_ranges[] __initconst = {
>  	{ 0x00, 0x18, 0x20 },
>  	{ 0xff, 0x00, 0x20 },
> @@ -230,11 +247,16 @@ int amd_cache_northbridges(void)
>  	const struct pci_device_id *misc_ids = amd_nb_misc_ids;
>  	const struct pci_device_id *link_ids = amd_nb_link_ids;
>  	const struct pci_device_id *root_ids = amd_root_ids;
> +
> +	const struct pci_device_id *noncpu_misc_ids = amd_noncpu_nb_misc_ids;
> +	const struct pci_device_id *noncpu_link_ids = amd_noncpu_nb_link_ids;
> +	const struct pci_device_id *noncpu_root_ids = amd_noncpu_root_ids;
> +
>  	struct pci_dev *root, *misc, *link;
>  	struct amd_northbridge *nb;
>  	u16 roots_per_misc = 0;
> -	u16 misc_count = 0;
> -	u16 root_count = 0;
> +	u16 misc_count = 0, misc_count_noncpu = 0;
> +	u16 root_count = 0, root_count_noncpu = 0;
>  	u16 i, j;
>  
>  	if (amd_northbridges.num)
> @@ -253,10 +275,16 @@ int amd_cache_northbridges(void)
>  	if (!misc_count)
>  		return -ENODEV;
>  
> +	while ((misc = next_northbridge(misc, noncpu_misc_ids)) != NULL)
> +		misc_count_noncpu++;
> +
>  	root = NULL;
>  	while ((root = next_northbridge(root, root_ids)) != NULL)
>  		root_count++;
>  
> +	while ((root = next_northbridge(root, noncpu_root_ids)) != NULL)
> +		root_count_noncpu++;
> +
>  	if (root_count) {
>  		roots_per_misc = root_count / misc_count;
>  
> @@ -270,15 +298,28 @@ int amd_cache_northbridges(void)
>  		}
>  	}
>  
> -	nb = kcalloc(misc_count, sizeof(struct amd_northbridge), GFP_KERNEL);
> +	if (misc_count_noncpu) {
> +		/*
> +		 * The first non-CPU Node ID starts at 8 even if there are fewer
> +		 * than 8 CPU nodes. To maintain the AMD Node ID to Linux amd_nb
> +		 * indexing scheme, allocate the number of GPU nodes plus 8.
> +		 * Some allocated amd_northbridge structures will go unused when
> +		 * the number of CPU nodes is less than 8, but this tradeoff is to
> +		 * keep things relatively simple.

Why simple?

What's wrong with having

[node IDs][GPU node IDs]

i.e., the usual nodes come first and the GPU ones after it.

You enumerate everything properly here so you can control what goes
where. Which means, you don't need this NONCPU_NODE_INDEX non-sense at
all.

Hmmm?

> +		 */
> +		amd_northbridges.num = NONCPU_NODE_INDEX + misc_count_noncpu;
> +	} else {
> +		amd_northbridges.num = misc_count;
> +	}
> +
> +	nb = kcalloc(amd_northbridges.num, sizeof(struct amd_northbridge), GFP_KERNEL);
>  	if (!nb)
>  		return -ENOMEM;
>  
>  	amd_northbridges.nb = nb;
> -	amd_northbridges.num = misc_count;
>  
>  	link = misc = root = NULL;
> -	for (i = 0; i < amd_northbridges.num; i++) {
> +	for (i = 0; i < misc_count; i++) {
>  		node_to_amd_nb(i)->root = root =
>  			next_northbridge(root, root_ids);
>  		node_to_amd_nb(i)->misc = misc =
> @@ -299,6 +340,18 @@ int amd_cache_northbridges(void)
>  			root = next_northbridge(root, root_ids);
>  	}
>  
> +	if (misc_count_noncpu) {
> +		link = misc = root = NULL;
> +		for (i = NONCPU_NODE_INDEX; i < NONCPU_NODE_INDEX + misc_count_noncpu; i++) {

So this is not keeping things relatively simple - this is making you
jump to the GPU nodes to prepare them too which is making them special.

> +			node_to_amd_nb(i)->root = root =
> +				next_northbridge(root, noncpu_root_ids);
> +			node_to_amd_nb(i)->misc = misc =
> +				next_northbridge(misc, noncpu_misc_ids);
> +			node_to_amd_nb(i)->link = link =
> +				next_northbridge(link, noncpu_link_ids);

And seeing how you put those pointers in ->root, ->misc and ->link,
you can just as well drop those noncpu_*_ids and put the aldebaran
PCI IDs simply in amd_root_ids, amd_nb_misc_ids and amd_nb_link_ids
respectively.

Because to this code, the RAS functionality is no different than any
other CPU because, well, the interface is those PCI devices. So the
thing doesn't care if it is GPU or not.

So you don't need any of that separation between GPU and CPU nodes when
it comes to the RAS code.

Makes sense?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
