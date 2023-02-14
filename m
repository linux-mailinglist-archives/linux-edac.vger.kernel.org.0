Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C3B6966EB
	for <lists+linux-edac@lfdr.de>; Tue, 14 Feb 2023 15:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbjBNOco (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 Feb 2023 09:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbjBNOcn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 14 Feb 2023 09:32:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA8A44AB;
        Tue, 14 Feb 2023 06:32:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 639D2B81DB2;
        Tue, 14 Feb 2023 14:32:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97616C433D2;
        Tue, 14 Feb 2023 14:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676385159;
        bh=2j1yddz7e+UyYpNIbmJnV3nMOh+2cWKubLfhy1kieJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qanz0tC22zE8fU2PwN2MMUxAsh7o/mNaaT+XaAcFsEtyUB/K8t3sOPwkBMlaoIb+0
         CbGv0/xrZi/24ZnT4c08LyAOg7fqPghmnC/nAvv61amJ9GgoN/8CjjkeZGtbA+febM
         QnYJbAn74U/3ee12uT44DqhOcdPAoDhYocahDRIvp9jCl3lWndw/4+mcqkM2sMa72k
         wVXLr7QURV+Zb7XRhxqFe9dcmrSjETySRrx0u8D7rLPM2dABcRryUy9DpY5vxtMcoT
         0kno/ChxWHn6Ypyr4992GaQlvuXaqLig4Lh6JQLiJfgmZBA4xo6OhQEq5INR1Ah8Wy
         3vxTwyH8hLrzA==
Date:   Tue, 14 Feb 2023 07:32:36 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>, Tom Rix <trix@redhat.com>,
        tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
        rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/amd64: Shut up an -Werror,-Wsometimes-uninitialized
 clang false positive
Message-ID: <Y+ubhHlWFv4ifmGn@dev-arch.thelio-3990X>
References: <20230213191510.2237360-1-trix@redhat.com>
 <Y+qZthCMRL1m0p4B@yaz-fattaah>
 <Y+qcU2M5gchfzbky@zn.tnic>
 <Y+qdVHidnrrKvxiD@dev-arch.thelio-3990X>
 <03b91ce8-c6d0-63e7-561c-8cada0ece2fe@redhat.com>
 <Y+q1mhrAKTobp3fa@yaz-fattaah>
 <Y+q2pXYI02qAje8N@dev-arch.thelio-3990X>
 <Y+tapzerW7h9vMvp@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+tapzerW7h9vMvp@zn.tnic>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Feb 14, 2023 at 10:55:51AM +0100, Borislav Petkov wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Yeah, the code's fine even without this.
> 
> What this is fixing is a compiler which is overeager to report false
> positives which then get automatically enabled in -Wall builds and when
> CONFIG_WERROR is set in allmodconfig builds, the build fails.
> 
> It doesn't happen with gcc.
> 
> Maybe clang should be more conservative when enabling such warnings
> under -Wall as, apparently, this has an impact beyond just noisy output.

For the record, this is the first false positive that I have seen from
this warning in quite some time. You can flip through our issue tracker
and see how many instances of the uninitialized warnings there have been
and the vast majority of the ones in 2022 at least are all true
positives:

https://github.com/ClangBuiltLinux/linux/issues?q=label%3A-Wsometimes-uninitialized%2C-Wuninitialized

So I disagree with the characterization that clang is "overeager to
report false positives" and I think the opinionated parts of the commit
message could be replaced with some of the technical analysis that Tom
and I did to show why this is a false positive but not one clang can
reason about with the way the code is structured (since the warning does
not perform interprocedural analysis). However, not my circus, not my
monkeys, so feel free to ignore all this :)

Regardless, my review still stands and thank you again for the fix.

Cheers,
Nathan

>   [ bp: Write a commit message. ]
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Link: https://lore.kernel.org/r/Y%2BqdVHidnrrKvxiD@dev-arch.thelio-3990X
> ---
>  drivers/edac/amd64_edac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 1c4bef1cdf28..5b42533f306a 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -3928,7 +3928,7 @@ static const struct attribute_group *amd64_edac_attr_groups[] = {
>  
>  static int hw_info_get(struct amd64_pvt *pvt)
>  {
> -	u16 pci_id1, pci_id2;
> +	u16 pci_id1 = 0, pci_id2 = 0;
>  	int ret;
>  
>  	if (pvt->fam >= 0x17) {
> -- 
> 2.35.1
> 
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
