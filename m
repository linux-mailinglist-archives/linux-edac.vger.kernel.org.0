Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B53403F2B
	for <lists+linux-edac@lfdr.de>; Wed,  8 Sep 2021 20:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346546AbhIHSnI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 8 Sep 2021 14:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235775AbhIHSnI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 8 Sep 2021 14:43:08 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4825C061575;
        Wed,  8 Sep 2021 11:41:59 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0efc00b7f29acf52797616.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:fc00:b7f2:9acf:5279:7616])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2CA691EC04E0;
        Wed,  8 Sep 2021 20:41:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631126514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=64mwiSa3Im6pBZVjlFClUkt/HUK4jUzSI5qR9jC8njI=;
        b=Zw/Gh9j4SodIEppnc9OJzKReT966ru5la4OsRZAvOgWj2XhJ0I7tE+FTPHPSoYFwgkpjqG
        09WCQ7joRx3Cfbg/G6lSMmEHHCTBssLTPPNEUs+iGffumQhkM9/45hDv1AzV58lQ1snchS
        RitveNpqOwlNPyhMFdkFXhWQvO9Tw30=
Date:   Wed, 8 Sep 2021 20:41:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     Naveen Krishna Chatradhi <nchatrad@amd.com>,
        linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v3 3/3] EDAC/amd64: Enumerate memory on noncpu nodes
Message-ID: <YTkD6iy9JhwetSYU@zn.tnic>
References: <20210806074350.114614-4-nchatrad@amd.com>
 <20210823185437.94417-1-nchatrad@amd.com>
 <20210823185437.94417-4-nchatrad@amd.com>
 <YSjM8b9vvkmRew94@zn.tnic>
 <YS/JkgWA8VreIx1R@yaz-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YS/JkgWA8VreIx1R@yaz-ubuntu>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Sep 01, 2021 at 06:42:26PM +0000, Yazen Ghannam wrote:
> err.channel still needs to be used in error_address_to_page_and_offset()
> below.

I think you mean __log_ecc_error().

> This is a good idea. But we have a global *fam_type, so this should be moved
> into struct amd64_pvt, if possible. Then each node can have its own fam_type.

per_family_init() does assign stuff to pvt members so yes, we're saying
the same thing, practically.

> Fair point. I like the idea of having unique names though. Is this possible
> with the current EDAC framework? Or is it not worth it?

We don't have unique names for the CPU nodes:

[   25.637486] EDAC MC0: Giving out device to module amd64_edac controller F17h_M30h: DEV 0000:00:18.3 (INTERRUPT)
[   25.799554] EDAC MC1: Giving out device to module amd64_edac controller F17h_M30h: DEV 0000:00:19.3 (INTERRUPT)

why does it matter to have unique names for the accelerators?

If you wanna differentiate them, you can dump the PCI devs like above.

Just to make it clear - I'm not against it per-se - I'd just need a
stronger justification for doing this than just "I like the idea".

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
