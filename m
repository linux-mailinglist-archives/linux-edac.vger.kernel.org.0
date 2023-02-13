Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570366951DB
	for <lists+linux-edac@lfdr.de>; Mon, 13 Feb 2023 21:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjBMU2U (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 13 Feb 2023 15:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjBMU2T (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 13 Feb 2023 15:28:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F93993F9;
        Mon, 13 Feb 2023 12:28:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D25C0612A5;
        Mon, 13 Feb 2023 20:28:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABDDFC433EF;
        Mon, 13 Feb 2023 20:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676320087;
        bh=WRsDjx6vLHYE5t7FxP3nuqc5RTyTv1xh54+zk9QTuX8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f9s9G4AUQpaz5Q4ut8lZway799vsFIQBfYlkg+G5KYZa2rQgiuK5eNKirMEA2sHyZ
         BLLatRIW/n9o4JGuavPJ4jmQqzdgDL/f2TAxK//hTwAF1pe5xwReEmqCukgrak6cnf
         Bx7zlOoXm+NLt8y+t27x3aTJ1FXaKQQycoS2BhHkamRAOdQww7GbdzeUNZANHUyb87
         GFW1i0dx6tsqgP/IGImN/xSkgYHmPMm0Qb/QyJ4fcZHzeN/E4sn4/vTj4Vov/AyP0X
         vVJXSHSdIBq3/Xfi7Q0ME7zx2Pw2PQGV06bBHCg0LnySjYBWYvA1Li8p9buHH1NKhs
         OnCe+uWvwfeUA==
Date:   Mon, 13 Feb 2023 13:28:04 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>, Tom Rix <trix@redhat.com>,
        tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
        rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/amd64: remove unneeded call to
 reserve_mc_sibling_devs()
Message-ID: <Y+qdVHidnrrKvxiD@dev-arch.thelio-3990X>
References: <20230213191510.2237360-1-trix@redhat.com>
 <Y+qZthCMRL1m0p4B@yaz-fattaah>
 <Y+qcU2M5gchfzbky@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+qcU2M5gchfzbky@zn.tnic>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Feb 13, 2023 at 09:23:47PM +0100, Borislav Petkov wrote:
> On Mon, Feb 13, 2023 at 08:12:38PM +0000, Yazen Ghannam wrote:
> > These errors are encountered when extra warnings are enabled, correct?
> 
> It says so in the warning which one it is: -Werror,-Wsometimes-uninitialized
> 
> Don't know if we enable that one for clang with W= or Nathan adds
> additional switches.

-Wsometimes-uninitialized is part of clang's -Wall so it is on by
default in all builds, regardless of W=

-Werror comes from CONFIG_WERROR, which is enabled with allmodconfig.

> > I think the following patch would resolve this issue. This is part of a set
> > that isn't fully applied.
> > https://lore.kernel.org/linux-edac/20230127170419.1824692-12-yazen.ghannam@amd.com/
> > 
> > Boris,
> > Do you think one of these patches should be applied or just hold off until the
> > entire original set is applied?
> 
> I still wanted to go through the rest but I'm not sure I'll have time
> for it before the merge window. So unless this is breaking some silly
> testing scenario, I'd say I'll leave things as they are.

This breaks allmodconfig with clang, so it would be great if one of
these solutions was applied in the meantime.

Cheers,
Nathan
