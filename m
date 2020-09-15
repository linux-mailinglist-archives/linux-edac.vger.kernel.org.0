Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6788A26A0F9
	for <lists+linux-edac@lfdr.de>; Tue, 15 Sep 2020 10:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgIOIfe (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Sep 2020 04:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbgIOIf3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 15 Sep 2020 04:35:29 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3432BC06174A;
        Tue, 15 Sep 2020 01:35:28 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0e42005bd5729a6296255f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:4200:5bd5:729a:6296:255f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 00D421EC0423;
        Tue, 15 Sep 2020 10:35:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600158922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CO0KHAmlbCueh0LdIGuepBEhMd+eVhWUqvDzPO/qBvk=;
        b=f00PbqVX3mvtuzeMSzTHvwYi0D1sLMqora7b8NDcNj82KdR1S2O7k4qxdPN0o3hr5B1QA1
        B3nn5h9OzGpaZvCNrSghIrKDhySM94vMAd0wLDEDTahokgmMKTnksj8gdYfbsg2umnSzJi
        iFC3fizjVoazhHb1OulzgQdOPEXvgEw=
Date:   Tue, 15 Sep 2020 10:35:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 1/8] x86/CPU/AMD: Save NodeId on AMD-based systems
Message-ID: <20200915083259.GC14436@zn.tnic>
References: <20200903200144.310991-1-Yazen.Ghannam@amd.com>
 <20200903200144.310991-2-Yazen.Ghannam@amd.com>
 <20200909180647.GF12237@zn.tnic>
 <20200909201755.GB3014671@yaz-nikka.amd.com>
 <20200910101443.GC8357@zn.tnic>
 <20200914192039.GA39519@yaz-nikka.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200914192039.GA39519@yaz-nikka.amd.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Sep 14, 2020 at 02:20:39PM -0500, Yazen Ghannam wrote:
> Yes, that's right.
> 
> I called it "node_id" based on the AMD documentation and what it's
> called today in the Linux code. It's called other things like nb_id and
> nid too.
> 
> I think we can call it something else to avoid confusion with NUMA nodes
> if that'll help.

Yes, whatever we end up calling it, it should be added to that
documentation file I pointed you at. Because months and years from now,
it'll be the only place we look first, before changing the topology
again.

> Yes, you're right. The AMD documentation is different, so I'll try to
> stick with the Linux documentation and qualify names with "AMD" when
> noting the usage by the AMD docs.

Thanks, yes, because Linux is trying to map its view of the topology to
the vendor's and model all vendors properly, if possible.

> There's one DF/NB per package and it's a fixed value, i.e. it shouldn't
> change based on the NUMA configuration.

Aha, so the NB kinda serves the package and is part of it. That makes a
lot of sense and clears some confusion.

> Here's an example of a 2 socket Naples system with 4 packages per socket
> and setup to have 1 NUMA node. The "node_id" value is the AMD NodeId
> from CPUID.
> 
> CPU=0 phys_proc_id=0 node_id=0 cpu_to_node()=0
> CPU=8 phys_proc_id=0 node_id=1 cpu_to_node()=0
> CPU=16 phys_proc_id=0 node_id=2 cpu_to_node()=0
> CPU=24 phys_proc_id=0 node_id=3 cpu_to_node()=0
> CPU=32 phys_proc_id=1 node_id=4 cpu_to_node()=0
> CPU=40 phys_proc_id=1 node_id=5 cpu_to_node()=0
> CPU=48 phys_proc_id=1 node_id=6 cpu_to_node()=0
> CPU=56 phys_proc_id=1 node_id=7 cpu_to_node()=0

Ok, node_id is the DF instance number in this case.

> Yeah, I think example 4b works here. The mismatch though is with
> phys_proc_id and package on AMD systems. You can see above that
> phys_proc_id gives a socket number, and the AMD NodeId gives a package
> number.

Ok, now looka here:

"  - cpuinfo_x86.logical_proc_id:

    The logical ID of the package. As we do not trust BIOSes to enumerate the
    packages in a consistent way, we introduced the concept of logical package
    ID so we can sanely calculate the number of maximum possible packages in
    the system and have the packages enumerated linearly."

Doesn't that sound like exactly what you need?

Because that DF ID *is* practically the package ID as there's 1:1
mapping between DF and a package, as you say above.

Right?

Now, it says

[    7.670791] smpboot: Max logical packages: 2

on my Rome box but what you want sounds very much like the logical
package ID and if we define that on AMD to be that and document it this
way, I guess that should work too, provided there are no caveats like
sched is using this info for proper task placement and so on. That would
need code audit, of course...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
