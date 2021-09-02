Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117C23FF24E
	for <lists+linux-edac@lfdr.de>; Thu,  2 Sep 2021 19:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346570AbhIBRax (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 2 Sep 2021 13:30:53 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36968 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346499AbhIBRaw (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 2 Sep 2021 13:30:52 -0400
Received: from zn.tnic (p200300ec2f0ed100e05ac297e005b15d.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:d100:e05a:c297:e005:b15d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3E6801EC04D6;
        Thu,  2 Sep 2021 19:29:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630603789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8jz11g2rh2be97czWSqZKBVYE/Qs9622Pmm5Hucy2gg=;
        b=dU9E2KhX1Bg4xhlBf/FH7bPpVKj7xCeUmLVmCkmkWWhd4drcEDNZcASDwVPElCvGy38J7f
        A7Ca1SnGMR6KyjXKcuNlWBBNZA662l+n0eCwzgP3ni8sRxy1K9bwxaWXeXETtRwbEy9rbC
        nDdM2SX8Frvf5f41MAEpo6ISd98OvdY=
Date:   Thu, 2 Sep 2021 19:30:24 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     Naveen Krishna Chatradhi <nchatrad@amd.com>,
        linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v3 1/3] x86/amd_nb: Add support for northbridges on
 Aldebaran
Message-ID: <YTEKMHqjY/IUBfgl@zn.tnic>
References: <20210806074350.114614-4-nchatrad@amd.com>
 <20210823185437.94417-1-nchatrad@amd.com>
 <20210823185437.94417-2-nchatrad@amd.com>
 <YSYeo6S2OSZbBpb4@zn.tnic>
 <YS/Dsc2gWGGCWnbs@yaz-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YS/Dsc2gWGGCWnbs@yaz-ubuntu>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Sep 01, 2021 at 06:17:21PM +0000, Yazen Ghannam wrote:
> These devices aren't officially GPUs, since they don't have graphics/video
> capabilities. Can we come up with a new term for this class of devices? Maybe
> accelerators or something?
> 
> In any case, GPU is still used throughout documentation and code, so it's fair
> to just stick with "gpu".

Hmm, yeah, everybody is talking about special-purpose processing units
now, i.e., accelerators or whatever they call them. I guess this is the
new fancy thing since sliced bread.

Well, what are those PCI IDs going to represent? Devices which have RAS
capabilities on them?

We have this nomenclature called "uncore" in the perf subsystem for
counters which are not part of the CPU core or whatever. But there we
use that term on AMD already so that might cause confusion.

But I guess the type of those devices doesn't matter for amd_nb.c,
right?

All that thing cares for is having an array of northbridges, each with
the respective PCI devices and that's it. So for amd_nb.c I think that
differentiation doesn't matter... but keep reading...

> We use the Node ID to index into the amd_northbridge.nb array, e.g. in
> node_to_amd_nb().
> 
> We can get the Node ID of a GPU node when processing an MCA error as in Patch
> 2 of this set. The hardware is going to give us a value of 8 or more.
> 
> So, for example, if we set up the "nb" array like this for 1 CPU and 2 GPUs:
> [ID:Type] : [0: CPU], [8: GPU], [9: GPU]
>  
> Then I think we'll need some more processing at runtime to map, for example,
> an error from GPU Node 9 to NB array Index 2, etc.
> 
> Or we can manage this at init time like this:
> [0: CPU], [1: NULL], [2: NULL], [3: NULL], [4: NULL], [5: NULL], [6: NULL],
> [7, NULL], [8: GPU], [9: GPU]
> 
> And at runtime, the code which does Node ID to NB entry just works. This
> applies to node_to_amd_nb(), places where we loop over amd_nb_num(), etc.
> 
> What do you think?

Ok, looking at patch 2, it does:

	node_id = ((m->ipid >> 44) & 0xF);

So how ugly would it become if you do here:

	node_id = ((m->ipid >> 44) & 0xF);
	node_id -= accel_id_offset;

where that accel_id_offset is the thing you've read out from one of the
Data Fabric registers before?

This way, the gap between CPU IDs and accel IDs is gone and in the
software view, there is none.

Or are we reading other hardware registers which are aware of that gap
and we would have to remove it again to get the proper index? And if so,
and if it becomes real ugly, maybe we will have to bite the bullet and
do the gap in the array but that would be yucky...

Hmmm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
