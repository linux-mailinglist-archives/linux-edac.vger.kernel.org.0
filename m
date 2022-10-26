Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A4D60EA08
	for <lists+linux-edac@lfdr.de>; Wed, 26 Oct 2022 22:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbiJZUMZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 26 Oct 2022 16:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235115AbiJZUMW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 26 Oct 2022 16:12:22 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B419A143A79;
        Wed, 26 Oct 2022 13:12:21 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7b8329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7b8:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1537A1EC06BD;
        Wed, 26 Oct 2022 22:12:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666815140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JRPU/VosrpVRR+iXu5ifunnhEheX6vmVtTupYdvcy3w=;
        b=Z9BTwCQlOjSc0gmsajldgC8unz0qOWgec9dWC8Sr2ro4ysB7DQOehw7MfQRfTGFSW/I+BX
        esaqgLhAxa0lAy4UTawwwUKyUB5FLyTXFbYueSfGBBb11icL8QVV4cLH2rNvEQXQWZzM4K
        DB8C6oDKfMGXfaIaKfVZJJR6ZbpHFYM=
Date:   Wed, 26 Oct 2022 22:12:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com, mpatocka@redhat.com
Subject: Re: [PATCH] x86/MCE/AMD: Decrement threshold_bank refcount when
 removing threshold blocks
Message-ID: <Y1mUn/xvx1RYPqAQ@zn.tnic>
References: <20220614174346.3648305-1-yazen.ghannam@amd.com>
 <Yql9TqFtebd2h9Z9@kroah.com>
 <Yqnj88FPkZ6kBU7k@yaz-fattaah>
 <Y1kJCHBtatohj/JK@zn.tnic>
 <Y1kiNBh3/XBNe6uv@kroah.com>
 <Y1lUo08UzaqIaI7r@yaz-fattaah>
 <Y1l8nx1KnTFP1xKj@zn.tnic>
 <Y1mOEfEM6MdnV8CX@yaz-fattaah>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1mOEfEM6MdnV8CX@yaz-fattaah>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Oct 26, 2022 at 07:44:17PM +0000, Yazen Ghannam wrote:
> 1) Apply the patch I submitted as a simple fix/workaround for the presented
> symptom. I tried to keep it small and well described to be a stable backport.
> Obviously I wrote it without knowing the shared kobject behavior isn't ideal.

We'll see.

> 2) Address the shared kobject thing.
>    Here are some options:
>    a. Only set up the thresholding kobject on a single CPU per "AMD Node".
>    Technically MCA Bank 4 is "shared" on legacy systems. But AFAICT from
>    looking at old BKDG docs, in practice only the "Node Base Core" can access
>    the registers. This behavior is controlled by a bit in NB which BIOS is
>    supposed to set. Maybe some BIOSes don't do this, but I think that's a
>    "broken BIOS on legacy system" issue if so.

I guess we can do that. And I even think we have some code which finds
out which the NBC is...

/me greps a bit:

ah, there it is: get_nbc_for_node() in arch/x86/kernel/cpu/mce/inject.c.


>    b. Disable the MCA Thresholding interface for Families before 0x17.

Can't. It is user-visible and you don't know for sure whether someone is
using it or not.

Believe me, I have been wanting to disable this thing forever. I've
never heard of anyone using it and all the energy we put in it was for
nothing. :-\

We could try to deprecate it, though, make it default=n in Kconfig and
see who complains. And after a couple of releases, kill it.

>    This is an undocumented interface, 

Of course it is documented - it is in the old BKDGs.

> and I don't know if anyone is using it on older systems.

Yap.

> The issue we're discussing here started because of a splat during
> suspend/resume/CPU hotplug. In disable_err_thresholding(), we disable
> MCA Thresholding for bank 4 on Family 15h, so there's some precedent.
> c. Do nothing at the moment. I *really* want to clean up the MCA
> Thresholding interface, and the shared kobject thing may get resolved
> in that.

Clean it up how exactly?

Put it behind a Kconfig item, disable it and remove it after a while?

:-)

If so, I wouldn't mind. No one's using this. At least I haven't heard of
a single bug report or of a use case. Only when CPU hotplug explodes and
that thing is involved, only then.

Might as well remove it. And then remove it in the hardware too. RAS
folks would love to get rid of some of that crap which takes up verif
resources for no good reason.

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
