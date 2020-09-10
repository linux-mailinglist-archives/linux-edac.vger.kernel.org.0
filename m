Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625CB26437B
	for <lists+linux-edac@lfdr.de>; Thu, 10 Sep 2020 12:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbgIJKPO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Sep 2020 06:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730637AbgIJKOx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 10 Sep 2020 06:14:53 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5675CC061573;
        Thu, 10 Sep 2020 03:14:52 -0700 (PDT)
Received: from zn.tnic (p200300ec2f133200fd9e4f04ab274470.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:3200:fd9e:4f04:ab27:4470])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 916231EC04C0;
        Thu, 10 Sep 2020 12:14:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1599732889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Nfhs/ikKxjcFj07w0NPIX+lSHCHW+iotJoF44hLqXtw=;
        b=fMXOIPyyo3Zl9Mgw9810U7+J+m05FzCk+T+0bGVIb4xXLlFOcqwpKRGcqHO5lzpSPB3LqM
        I4mjeZzIUrxVNJgIGC4bxDJt4h4Mpwyo/4TaudJz7lXhE/8PoNeCaYXoyDT6GGyTOuuQ6D
        sY7sJkc0hDVu4VFpzJ+IP7muMPw1t+c=
Date:   Thu, 10 Sep 2020 12:14:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 1/8] x86/CPU/AMD: Save NodeId on AMD-based systems
Message-ID: <20200910101443.GC8357@zn.tnic>
References: <20200903200144.310991-1-Yazen.Ghannam@amd.com>
 <20200903200144.310991-2-Yazen.Ghannam@amd.com>
 <20200909180647.GF12237@zn.tnic>
 <20200909201755.GB3014671@yaz-nikka.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200909201755.GB3014671@yaz-nikka.amd.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Sep 09, 2020 at 03:17:55PM -0500, Yazen Ghannam wrote:
> We need to access specific instances of hardware registers in the
> Northbridge or Data Fabric. The code in arch/x86/kernel/amd_nb.c does
> this.

So you don't need the node_id - you need the northbridge/data fabric ID?
I'm guessing NB == DF, i.e., it was NB before Zen and it is DF now.

Yes?

> Package = Socket, i.e. a field replaceable unit. Socket may not be
> useful for software, but I think it helps users identify the hardware.
> 
> I think the following could be changed in the documentation:
> 
> "In the past a socket always contained a single package (see below), but
> with the advent of Multi Chip Modules (MCM) a socket can hold more than one
> package."
> 
> Replace "package" with "die".

So first of all, we have:

"AMD nomenclature for package is 'Node'."

so we either change that because as you explain, node != package on AMD.

What you need is the ID of that northbridge or data fabric instance,
AFAIU.

> You take multiple dies from the foundry and you "package" them together
> into a single unit.

I think you're overloading the word "package" here and that leads to
more confusion. Package in our definition - Linux' - is:

"Packages contain a number of cores plus shared resources, e.g. DRAM
controller, shared caches etc." If you glue several packages together,
you get an MCM.

> They could be equal depending on the system. The values are different on
> MCM systems like Bulldozer and Naples though.
> 
> The functions and structures in amd_nb.c are indexed by the node_id.
> This is done implicitly right now by using amd_get_nb_id()/cpu_llc_id.
> But the LLC isn't always equal to the Node/Die like in Naples. So the
> patches in this set save and explicitly use the node_id when needed.
> 
> What do you think?

Sounds to me that you want to ID that data fabric instance which
logically belongs to one or multiple packages. Or can a DF a single
package?

So let's start simple: how does a DF instance map to a logical NUMA
node or package? Can a DF serve multiple packages?

You could use the examples at the end of Documentation/x86/topology.rst
to explain how those things play together. And remember to not think
about the physical aspect of the hardware structure because it doesn't
mean anything to software. All you wanna do is address the proper DF
instance so this needs to be enumerable and properly represented by sw.

Confused?

I am.

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
