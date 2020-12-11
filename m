Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333CD2D8051
	for <lists+linux-edac@lfdr.de>; Fri, 11 Dec 2020 22:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394742AbgLKVAA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Dec 2020 16:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394678AbgLKU7g (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 11 Dec 2020 15:59:36 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239D9C0613D3
        for <linux-edac@vger.kernel.org>; Fri, 11 Dec 2020 12:58:56 -0800 (PST)
Received: from zn.tnic (p200300ec2f124300ff68b353476082ac.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:4300:ff68:b353:4760:82ac])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 854DB1EC038E;
        Fri, 11 Dec 2020 21:58:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1607720334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=VoygTq/Y+Bxg6S6D08rggOMa7xGIWur7eN+ClT4unSY=;
        b=PyHxgPHaDP3Yl8wxNt/xtOJ1DFbkUfn0wy+yCnvxwzO3awRqOANsyD+zTNJAtJREKa7uB2
        s/kkQdXEpzmHs6JF2+I2rVQzabMJyXn6o43XnQ4etzZ9krYPGNGNZBQBzcVhbW5RfdWnKG
        Eq1bBnBxKAL63of9iKJsyhZM0qcaNxo=
Date:   Fri, 11 Dec 2020 21:58:50 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     Tony Luck <tony.luck@intel.com>,
        linux-edac <linux-edac@vger.kernel.org>
Subject: Re: EDAC instances probing
Message-ID: <20201211205850.GH25974@zn.tnic>
References: <20201211181915.GD25974@zn.tnic>
 <20201211203520.GA2128@yaz-nikka.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201211203520.GA2128@yaz-nikka.amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Dec 11, 2020 at 02:35:20PM -0600, Yazen Ghannam wrote:
> I think it's okay. But it could even be a single boolean rather than a
> bitmap. At least for amd64_edac_mod, the driver will probe all the
> Northbridge/Data Fabric instances even if some fail.

Ah, I see what you mean. amd64_edac does the all-or-nothing thing where
when it fails probing an instance, it unwinds. Yeah, I guess we can make
this a bool to say "we probed already".

> I don't know if the same applies to other EDAC modules.

I'll have to have a look.

> Does this issue affect other modules?

Those:

$ git grep x86_match_cpu drivers/edac/
drivers/edac/amd64_edac.c:3662: if (!x86_match_cpu(amd64_cpuids))
drivers/edac/i10nm_base.c:281:  id = x86_match_cpu(i10nm_cpuids);
drivers/edac/pnd2_edac.c:1557:  id = x86_match_cpu(pnd2_cpuids);
drivers/edac/sb_edac.c:3513:    id = x86_match_cpu(sbridge_cpuids);
drivers/edac/skx_base.c:659:    id = x86_match_cpu(skx_cpuids);

> Also, would it make sense to go back to PCI device probing? We've still
> needed to add PCI IDs for almost every model group. Probing by PCI
> device should help us avoid this issue and also prevent some messages
> where PCI IDs aren't found for supported families. For example, we had
> that problem when Family 17h Models 30h-3Fh came out. The module would
> load because it recognized Family 17h, but it would fail because the new
> PCI IDs for Models 30h-3Fh were not recognized.

Just like in the other mail I just sent you.

So that's the thing - we converted to x86_match_cpu() because adding
all those PCI IDs was tedious and using f/m/s would need a lot less
enablement so that the drivers work out of the box most of the time.

It's a tradeoff.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
