Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED65E44350D
	for <lists+linux-edac@lfdr.de>; Tue,  2 Nov 2021 19:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbhKBSGU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 2 Nov 2021 14:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbhKBSGU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 2 Nov 2021 14:06:20 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10564C061714;
        Tue,  2 Nov 2021 11:03:44 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f6200329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:6200:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 862C51EC0295;
        Tue,  2 Nov 2021 19:03:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1635876223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2cRQS7O7L2Z/48DbfCY2EPH6+yBs7CP8ey5aYVYfKQE=;
        b=Zn0eb3UQYP7NKSGIc/K4vjCS72vPOfrMz9v5IvB7Wnl0ReaNkvbBJYhON5fHRedkjqk60U
        pPPF6LBXYiCG44zEp5aBsJdyu1uun8qlsq6AXlArsPCusjIUpxDNPo6I6kn2Tczj5nH6KI
        2/2XdpCLrXLSin4JCCZ/V3yQO4bKNdM=
Date:   Tue, 2 Nov 2021 19:03:38 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, mchehab@kernel.org,
        yazen.ghannam@amd.com, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v6 1/5] x86/amd_nb: Add support for northbridges on
 Aldebaran
Message-ID: <YYF9ei59G/OUyZqR@zn.tnic>
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

Staring at this more...

> +/*
> + * Newer AMD CPUs and GPUs whose data fabrics can be connected via custom xGMI
> + * links, comes with registers to gather local and remote node type map info.
> + *
> + * "Local Node Type" refers to nodes with the same type as that from which the
> + * register is read, and "Remote Node Type" refers to nodes with a different type.
> + *
> + * This function, reads the registers from GPU DF function 1.
> + * Hence, local nodes are GPU and remote nodes are CPUs.
> + */
> +static int amd_get_node_map(void)

... so this is a generic function name...

> +{
> +	struct amd_node_map *nodemap;
> +	struct pci_dev *pdev;
> +	u32 tmp;
> +
> +	pdev = pci_get_device(PCI_VENDOR_ID_AMD,
> +			      PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F1, NULL);

... but this here is trying to get the Aldebaran PCI device function.

 So what happens if in the future, the GPU is a different one and it
gets RAS functionality and PCI device functions too? You'd probably need
to add that new GPU support too.

And then looking at that patch again, see how this new code is bolted on
and sure, it all is made to work, but it is strenuous and you have to
always pay attention to what type of devices you're dealing with.

And the next patch does:

	... if (bank_type == SMCA_UMC_V2) {

	/* do UMC v2 special stuff here. */

which begs the question: wouldn't this GPU PCI devices enumeration be a
lot cleaner if it were separate?

I.e., in amd_nb.c you'd have

init_amd_nbs:

        amd_cache_northbridges();
        amd_cache_gart();
	amd_cache_gpu_devices();

and in this last one you do your enumeration. Completely separate data
structures and all. Adding a new device support would then be trivial.

And then looking at the next patch again, you have:

+		} else if (bank_type == SMCA_UMC_V2) {
+			/*
+			 * SMCA_UMC_V2 exists on GPU nodes, extract the node id
+			 * from register MCA_IPID[47:44](InstanceIdHi).
+			 * The InstanceIdHi field represents the instance ID of the GPU.
+			 * Which needs to be mapped to a value used by Linux,
+			 * where GPU nodes are simply numerically after the CPU nodes.
+			 */
+			node_id = ((m->ipid >> 44) & 0xF) -
+				   amd_gpu_node_start_id() + amd_cpu_node_count();

where instead of exporting those functions and having the caller do the
calculations, you'd have a function in amd_nb.c which is called

	amd_get_gpu_node_id(unsigned long ipid)

which will use those separate data structures mentioned above and give
you the node id.

And those GPU node IDs are placed numerically after the CPU nodes so
your code doesn't need to do anything special - just read out registers
and cache them.

And you don't need those exports either - it is all nicely encapsulated
and a single function is used to get the callers what they wanna know.

Hmmm?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
