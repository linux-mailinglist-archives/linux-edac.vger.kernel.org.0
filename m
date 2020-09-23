Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C7527531D
	for <lists+linux-edac@lfdr.de>; Wed, 23 Sep 2020 10:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgIWIUr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Sep 2020 04:20:47 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37984 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgIWIUr (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 23 Sep 2020 04:20:47 -0400
Received: from zn.tnic (p200300ec2f0d130076d2caf1fa3322b0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:1300:76d2:caf1:fa33:22b0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A5E831EC0380;
        Wed, 23 Sep 2020 10:20:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600849245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=r5Cd7LFhrYgz2VmAEYm36AYonaN9I3+AtkPi8xH5OWs=;
        b=CAVFc9vrp81ssTcu3hlTIYzr4Zk54r/HrRvTi+IjWXxCWc024xydgO2ck/76DNoSVd0P2s
        aLXuYlNi9HFPF3XVdPWDn3tVKU/sOObc2b/92a2t7hCa6T9UZhJJRHKdTA2utqZwhmwM/d
        KuU6txzPv3GdADhxvYW4Ritjet0puPg=
Date:   Wed, 23 Sep 2020 10:20:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 8/8] x86/MCE/AMD Support new memory interleaving modes
 during address translation
Message-ID: <20200923082039.GB28545@zn.tnic>
References: <20200903200144.310991-1-Yazen.Ghannam@amd.com>
 <20200903200144.310991-9-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200903200144.310991-9-Yazen.Ghannam@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Sep 03, 2020 at 08:01:44PM +0000, Yazen Ghannam wrote:
> From: Muralidhara M K <muralidhara.mk@amd.com>
> 
> Add support for new memory interleaving modes used in current AMD systems.
>
> Check if the system is using a current Data Fabric version or a legacy
> version as some bit and register definitions have changed.
> 
> Tested on AMD reference platforms with the following memory interleaving
> options.
> 
> Naples
> - None
> - Channel
> - Die
> - Socket
> 
> Rome (NPS = Nodes per Socket)
> - None
> - NPS0
> - NPS1
> - NPS2
> - NPS4
> 
> The fixes tag refers to the commit that allows amd64_edac_mod to load on
> Rome systems.

Err, why? This is adding new stuff to an address translation function.
How does that fix amd64_edac loading on Rome?

> The module may report an incorrect system addresses on
> Rome systems depending on the interleaving option used.

That doesn't stop it from loading, sorry.

Now, before you guys do any new features, I'd like you to split this
humongous function umc_normaddr_to_sysaddr() logically into separate
helpers and each helper does exactly one thing and one thing only.

Then use a verb in its name: umc_translate_normaddr_to_sysaddr() or so.

Also, Yazen, remind me again pls why isn't this function in
drivers/edac/amd64_edac.c, where it is needed?

If the reason is not valid anymore, let's move it there before splitting
so that it doesn't bloat the core code.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
