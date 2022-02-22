Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66F04BFD07
	for <lists+linux-edac@lfdr.de>; Tue, 22 Feb 2022 16:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbiBVPgq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 22 Feb 2022 10:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbiBVPg2 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 22 Feb 2022 10:36:28 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FE116307C;
        Tue, 22 Feb 2022 07:35:49 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 298FC1EC053C;
        Tue, 22 Feb 2022 16:35:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1645544144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2a4MMuFTNxjhQiCqxEjybhzusRfnc7p6n/cb/C5lpOA=;
        b=PfeIMI9ocvfjFEcOI3SzzRkKbcAOcPH5ei+5N8bovdeOZV3r1xEW9x3tYpDO6seM5u2vGN
        AyYeF2ex4LFSnqs4li238N4ok9BKuwQwUyxD/qo/SOOAoR9Bsse165mVQ/Y+DgtAZgJtSu
        f+6/aSXRX3AkZb69kQu7Yvbf+9k/xYE=
Date:   Tue, 22 Feb 2022 16:35:51 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v3 3/4] x86/mce, EDAC/mce_amd: Cache MCA_CONFIG[McaX] in
 struct mce_bank
Message-ID: <YhUC1wW0mxC/Dmpv@zn.tnic>
References: <20220211223442.254489-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220211223442.254489-4-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220211223442.254489-4-Smita.KoralahalliChannabasappa@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Feb 11, 2022 at 04:34:41PM -0600, Smita Koralahalli wrote:
> Cache the value of MCA_CONFIG[McaX] in the existing mce_bank struct
> similar to MCA_CONFIG[McaLsbInStatusSupported].
> 
> This simplifies and eliminates the need to read MCA_CONFIG register each
> time to check McaX.

I don't see the point for this change, frankly.

I doubt it is speed because those are not really hot paths.

Code savings ain't either: 5 files changed, 36 insertions(+), 22 deletions(-)

Having yet another exported function to modules if not really necessary
doesn't make it prettier too.

So if there's no point for it, you can simply drop it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
