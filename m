Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C7541A2AA
	for <lists+linux-edac@lfdr.de>; Tue, 28 Sep 2021 00:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237963AbhI0WJ4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Sep 2021 18:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237871AbhI0WJx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 27 Sep 2021 18:09:53 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C66C05174B;
        Mon, 27 Sep 2021 15:05:37 -0700 (PDT)
Received: from zn.tnic (p200300ec2f088a00839935e3d35582f9.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:8a00:8399:35e3:d355:82f9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 34CAA1EC04E4;
        Tue, 28 Sep 2021 00:05:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632780332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=AlsOtt1HkU9FHs1jkzkGfXAXEYqguAUFS1q2I7ksodo=;
        b=Knfz4Ihnj3SPawJGXShW+AkVXIiVjF2HujWe+6V6Or/F6oYI4kxme0OQlShLrctpOKMLAX
        aVJai24kdEs8+l44exepufmGN8bkgxmmtxJnHieNaoLAXjYZUj+GDOW9Bf0j0PeVwHXBhF
        UFK1BYvepeFHbN/9S3rjd4VHLYKy9b8=
Date:   Tue, 28 Sep 2021 00:05:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Smita Koralahalli Channabasappa <skoralah@amd.com>
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, yazen.ghannam@amd.com
Subject: Re: [PATCH 1/5] x86/mce/inject: Check if a bank is unpopulated
 before error simulation
Message-ID: <YVJAIlGr5EvepsOg@zn.tnic>
References: <20210915232739.6367-1-Smita.KoralahalliChannabasappa@amd.com>
 <20210915232739.6367-2-Smita.KoralahalliChannabasappa@amd.com>
 <YU2Lm+11Pqg/RBK3@zn.tnic>
 <60d4f6be-76f7-e4b6-6fb5-2af78b01d32d@amd.com>
 <YVImVgsxyfQO7TGI@zn.tnic>
 <7e790ba1-0b31-690c-7bd3-d8361109cef5@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7e790ba1-0b31-690c-7bd3-d8361109cef5@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Sep 27, 2021 at 04:56:17PM -0500, Smita Koralahalli Channabasappa wrote:
> Yes, this makes sense to me now. But you meant to say inj_ipid_set()
> instead of inj_bank_set()..?

Yeah, I had it correct before:

"This whole thing belongs into inj_ipid_set() where you should verify... "

> 
> Something like this:
> 
> -MCE_INJECT_SET(ipid)
> 
> +static int inj_ipid_set(void *data, u64 val)
> +{
> +	struct mce *m = (struct mce*)data;
> 
> +	if cpu_feature_enabled(X86_FEATURE_SMCA)) {
> 
> +		rdmsrl_on_cpu(..
> 		..
> 		..
> +	m->ipid = val;
> +	..
> +}

Yes, and return proper error codes.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
