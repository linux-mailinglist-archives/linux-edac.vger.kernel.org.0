Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03ECC696970
	for <lists+linux-edac@lfdr.de>; Tue, 14 Feb 2023 17:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjBNQ1Q (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 Feb 2023 11:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjBNQ1P (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 14 Feb 2023 11:27:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A5D93C3;
        Tue, 14 Feb 2023 08:27:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E2FB61791;
        Tue, 14 Feb 2023 16:27:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 222BBC433D2;
        Tue, 14 Feb 2023 16:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676392032;
        bh=A5H2iiVeSQ6i9nVrap8N9RgTt/AO1rS8cU67Vf+b9p0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o/WPX2ua74wIkK4ppZqvSEinZUHEEl0jhpJ/jN5EFU5PcDYyCUAcFeXOZN0gzUPVM
         Iu5ATdHnsJpISta/njzF6i48mo3ZExRzi/siM2EIKVu40KMipf5U/x8+EbrJGmusTY
         w8dZnhVmeAY9G6SNWmg/g8S7yWSTNGdaL2ff1Xs/DHl6m3A852Bge9l2b+XyozW7cH
         Ld9NgefaD+6BzWlwxlI442fX5JwvVJ0uJo+e9zOKUFQXLYsraoIBoR+HxFewExOA8v
         WwCoFlTVWWaL68yPXCU3BjQ8reWlQUWHtX7wu8UDZwLsKRud/uj5vK7bPx1cxIzoHd
         fW5MJx2JkMSrQ==
Date:   Tue, 14 Feb 2023 09:27:10 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>, Tom Rix <trix@redhat.com>,
        tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
        rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/amd64: Shut up an -Werror,-Wsometimes-uninitialized
 clang false positive
Message-ID: <Y+u2XipFSIadP3IP@dev-arch.thelio-3990X>
References: <20230213191510.2237360-1-trix@redhat.com>
 <Y+qZthCMRL1m0p4B@yaz-fattaah>
 <Y+qcU2M5gchfzbky@zn.tnic>
 <Y+qdVHidnrrKvxiD@dev-arch.thelio-3990X>
 <03b91ce8-c6d0-63e7-561c-8cada0ece2fe@redhat.com>
 <Y+q1mhrAKTobp3fa@yaz-fattaah>
 <Y+q2pXYI02qAje8N@dev-arch.thelio-3990X>
 <Y+tapzerW7h9vMvp@zn.tnic>
 <Y+ubhHlWFv4ifmGn@dev-arch.thelio-3990X>
 <Y+ujA+Kr05Adky1l@yaz-fattaah>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+ujA+Kr05Adky1l@yaz-fattaah>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Feb 14, 2023 at 03:04:35PM +0000, Yazen Ghannam wrote:
> On Tue, Feb 14, 2023 at 07:32:36AM -0700, Nathan Chancellor wrote:
> > On Tue, Feb 14, 2023 at 10:55:51AM +0100, Borislav Petkov wrote:
> > > From: Yazen Ghannam <yazen.ghannam@amd.com>
> > > 
> > > Yeah, the code's fine even without this.
> > > 
> > > What this is fixing is a compiler which is overeager to report false
> > > positives which then get automatically enabled in -Wall builds and when
> > > CONFIG_WERROR is set in allmodconfig builds, the build fails.
> > > 
> > > It doesn't happen with gcc.
> > > 
> > > Maybe clang should be more conservative when enabling such warnings
> > > under -Wall as, apparently, this has an impact beyond just noisy output.
> > 
> > For the record, this is the first false positive that I have seen from
> > this warning in quite some time. You can flip through our issue tracker
> > and see how many instances of the uninitialized warnings there have been
> > and the vast majority of the ones in 2022 at least are all true
> > positives:
> > 
> > https://github.com/ClangBuiltLinux/linux/issues?q=label%3A-Wsometimes-uninitialized%2C-Wuninitialized
> > 
> > So I disagree with the characterization that clang is "overeager to
> > report false positives" and I think the opinionated parts of the commit
> > message could be replaced with some of the technical analysis that Tom
> > and I did to show why this is a false positive but not one clang can
> > reason about with the way the code is structured (since the warning does
> > not perform interprocedural analysis). However, not my circus, not my
> > monkeys, so feel free to ignore all this :)
> > 
> > Regardless, my review still stands and thank you again for the fix.
> >
> 
> Thanks Nathan for the feedback and thanks Boris for the patch.
> 
> Nathan,
> I see there's a ClangBuiltLinux/continuous-integration2 project on github.
> Is this something developers should try to leverage? Maybe just fork it and
> update the action/workflows to use test branches?

Our continuous integration relies on TuxSuite [1], which in turn
requires access to their service. TuxMake [2] is the backend for
TuxSuite, which is what I use doing a lot of my build testing. It can
use your local toolchains or it can use Docker/Podman to build in their
curated containers, which have a wide variety of versions, if that
matters to you.

I have thought about writing a wrapper around tuxmake to build our
TuxSuite configurations (the tuxsuite/ folder within our repo) locally,
maybe this is time to do so :) it would be useful to have something like

  $ scripts/build-local.py tuxsuite/tip-clang-15.yml tuxsuite/tip-clang-16.yml

which would allow people to easily test the configurations that we
generally care about for -tip with recent/stable versions of clang/LLVM.
Otherwise, a simple

  $ tuxmake -a x86_64 -k allmodconfig -t llvm default

or

  $ make -skj"$(nproc)" ARCH=x86_64 LLVM=1 allmodconfig all

is generally good enough to catch the majority of problems visible with
clang, assuming your distribution has a version of LLVM that the kernel
supports (11.x+).

[1]: https://tuxsuite.com
[2]: https://tuxmake.org

Cheers,
Nathan
