Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0334F43B802
	for <lists+linux-edac@lfdr.de>; Tue, 26 Oct 2021 19:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbhJZRRx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 26 Oct 2021 13:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhJZRRx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 26 Oct 2021 13:17:53 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD0AC061745;
        Tue, 26 Oct 2021 10:15:29 -0700 (PDT)
Received: from zn.tnic (p200300ec2f131c005b0c7ba9fa303376.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:1c00:5b0c:7ba9:fa30:3376])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 00EBB1EC05D6;
        Tue, 26 Oct 2021 19:15:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1635268527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FO4cs2yK2aOHZmwCs+eplkvcELqzW5qJSg1ryHvi0gA=;
        b=G3kaVMD3ZsBlYSmv6zLVGThlHAc3j4F33iKu51Di9gE1QLnj01bPSnuPShC9iTp4G1W30B
        nRUrsluxHNtOqy035nWI/jTBUygh9QOehcBE8WdLHxyrjFIL16E2BRVWTEu0eSUi+SzUjf
        XiQkUxpOOmHG0mC4cHWf5zj4NgIbneE=
Date:   Tue, 26 Oct 2021 19:15:24 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, yazen.ghannam@amd.com
Subject: Re: [PATCH v2 2/5] x86/mce/inject: Warn the user on a not set valid
 bit in MCA_STATUS
Message-ID: <YXg3rIump+CAtgs6@zn.tnic>
References: <20211019233641.140275-1-Smita.KoralahalliChannabasappa@amd.com>
 <20211019233641.140275-3-Smita.KoralahalliChannabasappa@amd.com>
 <YXfSGW1i5dLsiX84@zn.tnic>
 <00f4a0ab-f241-6674-f37f-623f3d9a8337@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00f4a0ab-f241-6674-f37f-623f3d9a8337@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Oct 26, 2021 at 11:58:58AM -0500, Koralahalli Channabasappa, Smita wrote:
> Like how it was done here?
> https://lkml.kernel.org/r/20210915232739.6367-3-Smita.KoralahalliChannabasappa@amd.com

Whoops, sorry about that.

So let's analyze this properly - there are two cases:

1. warn if VAL=0: what does that bring us? The person doing the injection
will simply have to set the valid bit and repeat the injection.

I guess "maybe the user wants to inject with Val not set" doesn't make a
whole lot of sense because nothing will happen - error will get ignored.

So we can do all the warning we want - it will be useless and in some
cases the user might not even see it.

So it sounds to me like setting the valid bit directly makes a lot more
sense.

2. Automatically set VAL=1 to correct any VAL=0 injections.

Yes, we force the VAL bit to 1 and that is not what the user injected
but the user injecting with VAL=0 will get ignored, i.e., it will be
pointless.

So we "help" here and set the valid bit.

Anything else I'm missing?

Sorry again for being back'n'forth on this.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
