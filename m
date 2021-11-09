Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF4944B424
	for <lists+linux-edac@lfdr.de>; Tue,  9 Nov 2021 21:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244567AbhKIUn4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Nov 2021 15:43:56 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47992 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242487AbhKIUn4 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 9 Nov 2021 15:43:56 -0500
Received: from zn.tnic (p200300ec2f18aa00db849a68730b2e8f.dip0.t-ipconnect.de [IPv6:2003:ec:2f18:aa00:db84:9a68:730b:2e8f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8675B1EC0464;
        Tue,  9 Nov 2021 21:41:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636490468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lCidKXkUy1+wE1cxs+aPQJznLjMxcTrkuUQb5akSCJI=;
        b=KOBy8wbh8eVClVBktgmvEYRhxby4CMg84HQAqa2daRvd2PXVNeYsMhhfn/6XDqebgqJVJ0
        CFn12cl8Zkg6oXQahVTOpA46xryB/MSh2z7ANwNo5CcS6dxWFiS+2SNtRntfH6pvkRBMHm
        rKXnyuLNwak8sPUTzNj4naBW9J3OJxA=
Date:   Tue, 9 Nov 2021 21:41:02 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Chatradhi, Naveen Krishna" <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, mchehab@kernel.org,
        yazen.ghannam@amd.com, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v6 1/5] x86/amd_nb: Add support for northbridges on
 Aldebaran
Message-ID: <YYrc3ty9lzcwdkt1@zn.tnic>
References: <20211028130106.15701-1-nchatrad@amd.com>
 <20211028130106.15701-2-nchatrad@amd.com>
 <YYF9ei59G/OUyZqR@zn.tnic>
 <b7f3639a-e46c-25e8-270b-04860074fd3c@amd.com>
 <YYknXBpOUQtV1aZ8@zn.tnic>
 <bcf5e86c-d3f1-0dab-2bed-505b1eb95f17@amd.com>
 <YYl0l+XV/QRZieGY@zn.tnic>
 <9de7f807-32a6-b009-d8b7-28771c80bfaf@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9de7f807-32a6-b009-d8b7-28771c80bfaf@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Nov 09, 2021 at 05:00:11PM +0530, Chatradhi, Naveen Krishna wrote:
> I was trying to handle both cpu and cpu northbridge enumeration in the
> amd_cache_northbridges() itself by reusing the existing structures and APIs.
> 
> Should have seen this through more clearly. As, this is working well for the
> following reasons.

Good, that's exactly what I meant! :)

> a. Allocating the amd_northbridges.nb after identifying both the cpu and gpu
> misc devices, would extend node_to_amd_nb(node) for both cpu and gpu nodes.

Well, there's a reason those things are functions - so that you can do
the necessary computation inside them and when stuff needs to change,
users don't have to. That's why amd_northbridges is static and only the
functions are exported.

So if you want to make sure node_to_amd_nb() works for GPU nodes too,
you simply have to look at the right "container" so to speak, depending
on the number @node passed in as an argument and look it up in the
proper array of pointers:

	[ CPU_NB0, CPU_NB1, ..., CPU_NB-N]  [ GPU_NB0, ... ]

you get the idea.

>    It is used extensively in this module. However, the roots_per_misc value
> is different in case of cpus and gpus and that needed to be handled
> seperately.
> 
> b. amd_nb_num(void) is used by other modules in the kernel, returning the
> total count of CPU and GPU northbridges would break the existing code.

amd64_edac is using it too, to know how many driver instances to allocate.

The other users - amd_gart_64.c and amd64-agp.c - are old stuff so they
most certainly don't need to get the number of GPU nodes too.

> I understood your point now.

Good.

> When we create separate functions for caching cpu and gpu devices, is it
> okay to create "struct amd_gpu_nb_info" with the following fields
> 
> a. gpu_num;
> b. struct amd_northbridge *gpu_nb;
> c. gpu_node_start_id;

Makes sense. You need to put in it anything that describes the GPU NBs
on the system and that other code would use.

> While, amd_nb_num(), continues to return number of cpu NBs
> Add new API amd_gpu_nb_num(), return number of gpu NBs
> 
> and modify the node_to_amd_nb(node) to extend the same behavior for gpu
> devices also

Yap, exactly.

And since amd64_edac is going to need the full NB count, you can use
there both:

	num_nodes = amd_nb_num() + amd_gpu_nb_num();

	...

Easy, peasy. :-)

Thanks!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
