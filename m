Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0275F6953A0
	for <lists+linux-edac@lfdr.de>; Mon, 13 Feb 2023 23:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjBMWQK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 13 Feb 2023 17:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBMWQJ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 13 Feb 2023 17:16:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81DB17CCF;
        Mon, 13 Feb 2023 14:16:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57A2F61307;
        Mon, 13 Feb 2023 22:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31077C433EF;
        Mon, 13 Feb 2023 22:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676326567;
        bh=R8u44Pov7pxbaplU5aT7hSJng3zVWh5ChmMdraTgJss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qN3qmFutcJQfGi9qRW91+prCvEaXFX8doNsC1q84DmscMW2q3CkKAhAtLzf4sBxwh
         AqEKjJQHEjHwF7NqsFDjYMMcxe+i0wZrtbEHIyn0PMmxroZRVZqGsfPf2cQdsWw8yl
         eHGQhUFg46rxnLmSZOvtdrrafYshJ7jAu19mcFIRkeX77B4IbTYfAmFw/P8ssKdJq6
         ePGBJfxJPw6rONb9M9sV+6LucFp/FU/vJVhHoQNQtK8Y2Euams7h/TTc8Wc7aupAwe
         esYNja8HdvATIal2oPe1Qz9S44xyYkJsmkY4sKHRcmdCk/nWXvqgIa8/RL0N4UU7e2
         ZEbxDKLRb7A6Q==
Date:   Mon, 13 Feb 2023 15:16:05 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     Tom Rix <trix@redhat.com>, Borislav Petkov <bp@alien8.de>,
        tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
        rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/amd64: remove unneeded call to
 reserve_mc_sibling_devs()
Message-ID: <Y+q2pXYI02qAje8N@dev-arch.thelio-3990X>
References: <20230213191510.2237360-1-trix@redhat.com>
 <Y+qZthCMRL1m0p4B@yaz-fattaah>
 <Y+qcU2M5gchfzbky@zn.tnic>
 <Y+qdVHidnrrKvxiD@dev-arch.thelio-3990X>
 <03b91ce8-c6d0-63e7-561c-8cada0ece2fe@redhat.com>
 <Y+q1mhrAKTobp3fa@yaz-fattaah>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+q1mhrAKTobp3fa@yaz-fattaah>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Feb 13, 2023 at 10:11:38PM +0000, Yazen Ghannam wrote:
> On Mon, Feb 13, 2023 at 01:17:51PM -0800, Tom Rix wrote:
> > 
> > On 2/13/23 12:28 PM, Nathan Chancellor wrote:
> > > On Mon, Feb 13, 2023 at 09:23:47PM +0100, Borislav Petkov wrote:
> > > > On Mon, Feb 13, 2023 at 08:12:38PM +0000, Yazen Ghannam wrote:
> > > > > These errors are encountered when extra warnings are enabled, correct?
> > > > It says so in the warning which one it is: -Werror,-Wsometimes-uninitialized
> > > > 
> > > > Don't know if we enable that one for clang with W= or Nathan adds
> > > > additional switches.
> > > -Wsometimes-uninitialized is part of clang's -Wall so it is on by
> > > default in all builds, regardless of W=
> > > 
> > > -Werror comes from CONFIG_WERROR, which is enabled with allmodconfig.
> > > 
> > > > > I think the following patch would resolve this issue. This is part of a set
> > > > > that isn't fully applied.
> > > > > https://lore.kernel.org/linux-edac/20230127170419.1824692-12-yazen.ghannam@amd.com/
> > > > > 
> > > > > Boris,
> > > > > Do you think one of these patches should be applied or just hold off until the
> > > > > entire original set is applied?
> > > > I still wanted to go through the rest but I'm not sure I'll have time
> > > > for it before the merge window. So unless this is breaking some silly
> > > > testing scenario, I'd say I'll leave things as they are.
> > > This breaks allmodconfig with clang, so it would be great if one of
> > > these solutions was applied in the meantime.
> > 
> > This happens at least on allyesconfig clang W=1,2, i do not know about
> > default, it's in a bad state as well.
> >
> 
> Yes, this breaks on a default clang build. I just used "make LLVM=1" with the
> same config I used before, and I see the error.
> 
> GCC doesn't seem to have a comparable warning to "-Wsometimes-uninitialized".
> I went back and tried W=123 and no warnings in this code.

GCC's -Wmaybe-uninitialized uses interprocedural analysis I believe,
which would allow it to see that it is not possible for these variables
to be used uninitialized. However, that type of analysis can go wrong
with optimizations pretty quickly, so it was disabled for the kernel
under normal builds and W=1; W=2 will show those instances again but
again, I would not expect there to be one here.

> Building with clang was straightforward, so I'll try to include it in my
> workflow in the future.
> 
> > It would be great if the clang build was working.
> > 
> > Nathan's patch is fine, go with that.
> >
> 
> I agree Nathan's patch is fine, but would you all be okay with a simpler
> change? Initializing the variables (as below) will silence the warnings, and
> we know this is a false positive. Eventually this function will be reworked,
> so a trivial workaround seems okay. What do y'all think?

I have no objections. Will you send the patch? Consider it

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

in advanced.

Thanks for taking a further look at this problem!

Cheers,
Nathan

> 
> Thanks,
> Yazen
> 
> ------
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 1c4bef1cdf28..5b42533f306a 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -3928,7 +3928,7 @@ static const struct attribute_group
> *amd64_edac_attr_groups[] = {
> 
>  static int hw_info_get(struct amd64_pvt *pvt)
>   {
>   -       u16 pci_id1, pci_id2;
>   +       u16 pci_id1 = 0, pci_id2 = 0;
>           int ret;
> 
> 	          if (pvt->fam >= 0x17) {
> 
> ------
