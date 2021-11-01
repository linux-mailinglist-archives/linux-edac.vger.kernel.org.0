Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48C4441F36
	for <lists+linux-edac@lfdr.de>; Mon,  1 Nov 2021 18:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbhKARa7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 1 Nov 2021 13:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhKARa6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 1 Nov 2021 13:30:58 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DCCC061714;
        Mon,  1 Nov 2021 10:28:25 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0cfa004489ab9813dd6ac7.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:fa00:4489:ab98:13dd:6ac7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 47B241EC03AD;
        Mon,  1 Nov 2021 18:28:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1635787703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=eYaoRCUmJyiH2GvVbQB2ZVepH4soF139tueZyPA8kuY=;
        b=Uzmi9atMX4XAf4R5X939yMYVD5ZZO8B2Gvu82M62QHF8Sg5TyqnySC4UlChuGL/VJZkKI3
        lX5KR19nifz848L8EGhwZKs3smTEPx+h4J/AhDRVKraLcTTgD4RZiciJlpgIdRVz0Md1n1
        SZkyIIELqDZLuBxtEpjxFOBPJeH3kpQ=
Date:   Mon, 1 Nov 2021 18:28:18 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, mchehab@kernel.org,
        yazen.ghannam@amd.com, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v6 1/5] x86/amd_nb: Add support for northbridges on
 Aldebaran
Message-ID: <YYAjssgwjBw/vkf0@zn.tnic>
References: <20211028130106.15701-1-nchatrad@amd.com>
 <20211028130106.15701-2-nchatrad@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211028130106.15701-2-nchatrad@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Oct 28, 2021 at 06:31:02PM +0530, Naveen Krishna Chatradhi wrote:
> +/* GPU Data Fabric ID Device 24 Function 1 */
> +#define PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F1 0x14d1
> +
> +/* DF18xF1 registers on Aldebaran GPU */
> +#define REG_LOCAL_NODE_TYPE_MAP		0x144
> +#define REG_RMT_NODE_TYPE_MAP		0x148

Move those defines up, along with the rest of them. While at it, you can
align them all vertically.

> +
> +/*
> + * Newer AMD CPUs and GPUs whose data fabrics can be connected via custom xGMI

"Newer" is a commit message type of adjective and doesn't belong in
permanent comments because when years pass, they won't be "newer"
anymore. IOW, you can simply drop it here.

> + * links, comes with registers to gather local and remote node type map info.

"come"

> + *
> + * "Local Node Type" refers to nodes with the same type as that from which the
> + * register is read, and "Remote Node Type" refers to nodes with a different type.

This sure sounds weird.

With my simplistic thinking I'd assume "local" is the CPU and "remote"
is the GPU...

> + * This function, reads the registers from GPU DF function 1.
> + * Hence, local nodes are GPU and remote nodes are CPUs.
> + */
> +static int amd_get_node_map(void)
> +{
> +	struct amd_node_map *nodemap;
> +	struct pci_dev *pdev;
> +	u32 tmp;
> +
> +	pdev = pci_get_device(PCI_VENDOR_ID_AMD,
> +			      PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F1, NULL);
> +	if (!pdev) {
> +		pr_debug("DF Func1 PCI device not found on this node.\n");
> +		return -ENODEV;
> +	}
> +
> +	nodemap = kmalloc(sizeof(*nodemap), GFP_KERNEL);

You allocate a whopping 4 bytes? Just do

	struct amd_node_map nodemap;

in the nb info descriptor.

I still need to see whether those node maps and functions you're adding
and exporting even make sense but that will happen later.

> +	if (!nodemap)
> +		return -ENOMEM;
> +
> +	pci_read_config_dword(pdev, REG_LOCAL_NODE_TYPE_MAP, &tmp);

Check retval.

> +	nodemap->gpu_node_start_id = tmp & 0xFFF;
> +
> +	pci_read_config_dword(pdev, REG_RMT_NODE_TYPE_MAP, &tmp);

Ditto.

> +	nodemap->cpu_node_count = tmp >> 16 & 0xFFF;
> +
> +	amd_northbridges.nodemap = nodemap;
> +	return 0;
> +}
> +
>  static struct pci_dev *next_northbridge(struct pci_dev *dev,
>  					const struct pci_device_id *ids)
>  {
> @@ -230,6 +297,27 @@ int amd_df_indirect_read(u16 node, u8 func, u16 reg, u8 instance_id, u32 *lo)
>  }
>  EXPORT_SYMBOL_GPL(amd_df_indirect_read);
>  
> +struct pci_dev *get_root_devs(struct pci_dev *root,

static

> +			      const struct pci_device_id *root_ids,
> +			      u16 roots_per_misc)
> +{
> +	u16 j;
> +
> +	/*
> +	 * If there are more PCI root devices than data fabric/
> +	 * system management network interfaces, then the (N)
> +	 * PCI roots per DF/SMN interface are functionally the
> +	 * same (for DF/SMN access) and N-1 are redundant.  N-1
> +	 * PCI roots should be skipped per DF/SMN interface so
> +	 * the following DF/SMN interfaces get mapped to
> +	 * correct PCI roots.
> +	 */
> +	for (j = 0; j < roots_per_misc; j++)
> +		root = next_northbridge(root, root_ids);
> +
> +	return root;
> +}
> +
>  int amd_cache_northbridges(void)
>  {
>  	const struct pci_device_id *misc_ids = amd_nb_misc_ids;
> @@ -237,10 +325,10 @@ int amd_cache_northbridges(void)
>  	const struct pci_device_id *root_ids = amd_root_ids;
>  	struct pci_dev *root, *misc, *link;
>  	struct amd_northbridge *nb;
> -	u16 roots_per_misc = 0;
> -	u16 misc_count = 0;
> -	u16 root_count = 0;
> -	u16 i, j;
> +	u16 roots_per_misc = 0, gpu_roots_per_misc = 0;
> +	u16 misc_count = 0, gpu_misc_count = 0;
> +	u16 root_count = 0, gpu_root_count = 0;
> +	u16 i;
>  
>  	if (amd_northbridges.num)
>  		return 0;
> @@ -252,15 +340,23 @@ int amd_cache_northbridges(void)
>  	}
>  
>  	misc = NULL;
> -	while ((misc = next_northbridge(misc, misc_ids)) != NULL)
> -		misc_count++;
> +	while ((misc = next_northbridge(misc, misc_ids)) != NULL) {

Just remove that redundant "!= NULL" at the end, while at it.

> +		if (misc->device == PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F3)
> +			gpu_misc_count++;
> +		else
> +			misc_count++;
> +	}
>  
>  	if (!misc_count)
>  		return -ENODEV;
>  
>  	root = NULL;
> -	while ((root = next_northbridge(root, root_ids)) != NULL)
> -		root_count++;
> +	while ((root = next_northbridge(root, root_ids)) != NULL) {
> +		if (root->device == PCI_DEVICE_ID_AMD_ALDEBARAN_ROOT)
> +			gpu_root_count++;
> +		else
> +			root_count++;
> +	}
>  
>  	if (root_count) {
>  		roots_per_misc = root_count / misc_count;
> @@ -275,33 +371,37 @@ int amd_cache_northbridges(void)
>  		}
>  	}
>  
> -	nb = kcalloc(misc_count, sizeof(struct amd_northbridge), GFP_KERNEL);
> +	/*
> +	 * The number of miscs, roots and roots_per_misc might vary on different
> +	 * nodes of a heterogeneous system.
> +	 * Calculate roots_per_misc accordingly in order to skip the redundant
> +	 * roots and map the DF/SMN interfaces to correct PCI roots.
> +	 */

Reflow that comment so that it is a block.

> +	if (gpu_root_count && gpu_misc_count) {
> +		int ret = amd_get_node_map();
> +

^ Superfluous newline.

> +		if (ret)
> +			return ret;
> +
> +		gpu_roots_per_misc = gpu_root_count / gpu_misc_count;
> +	}
> +

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
