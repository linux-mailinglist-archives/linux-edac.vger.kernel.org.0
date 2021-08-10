Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC573E53A3
	for <lists+linux-edac@lfdr.de>; Tue, 10 Aug 2021 08:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbhHJGjO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 10 Aug 2021 02:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbhHJGjN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 10 Aug 2021 02:39:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18792C0613D3;
        Mon,  9 Aug 2021 23:38:52 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628577527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bSnzBs68VhjDQ3u78tqjUyQJhwzdf88dCvELM4pNA2Q=;
        b=uqmqUId9lCIImeFKZg4WDPF8nF0evgk1x6FInFYKkm18Zycnzmpj5pEr4DhNNz2INmH7KW
        GbX/7uWwYT5PGkW8CsjGn5Cuc1NvrxDQxCv4jwErQGUUnPp2xKyTqXvTSb/C10JT3vsQap
        l3UV4GxFOEZS0VL3kUFb1KQa3+LCN2xzSNuqQx9ucjv2Rd4SrLG81EXowR9KNFzW33G6a3
        83Bt27m1TMuQnumpcsn6rQYMj7SMV01ksbKSmhTXq0AM5JgiJIsN6MvNGVCsicP9WjhYld
        W0pFNBzpYWRxugJF/xM6qGlgANJ172GVu3mKtMgk1XunpvCibOix8o0HhCN+8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628577527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bSnzBs68VhjDQ3u78tqjUyQJhwzdf88dCvELM4pNA2Q=;
        b=b9av0Nd34hog4yyxX9E+8vqOvNpEjZl3IiKG8E4g+Bm+ck63sLPzGl/uuA7Qf7eH5j3U5l
        /t9DfkNG9il8IfDA==
To:     Jeff Moyer <jmoyer@redhat.com>, dan.j.williams@intel.com
Cc:     Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch] x86/pat: pass correct address to sanitize_phys
In-Reply-To: <x49tuknmosl.fsf@segfault.boston.devel.redhat.com>
References: <x49tuknmosl.fsf@segfault.boston.devel.redhat.com>
Date:   Tue, 10 Aug 2021 08:38:46 +0200
Message-ID: <87wnotst1l.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Jeff,

On Wed, Jul 21 2021 at 15:48, Jeff Moyer wrote:

Please write function names with brackets, i.e. sanitize_phys().

> memtype_reserve takes an address range of the form [start, end).  It

[start, end]


> then passes the start and end addresses to sanitize_phys, which is meant
> to operate on the inclusive addresses.  If end falls at the end of the
> physical address space, sanitize_phys will return 0.  This can result in
> drivers failing to load:
>
> [   10.000087] mpt3sas_cm0: unable to map adapter memory! or resource not found
> [   10.000334] mpt3sas_cm0: failure at drivers/scsi/mpt3sas/mpt3sas_scsih.c:10597/_scsih_probe()!

Doesn't this trigger the WARN() right below that offending line?

> Fix this by passing the inclusive end address to sanitize_phys.
>
> Fixes: 510ee090abc3 ("x86/mm/pat: Prepare {reserve, free}_memtype() for "decoy" addresses")
> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
> --
> It might be worth adding a comment, here.  If there are any suggestions
> on what a sane wording would be, I'm all ears.

See below.

> diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
> index 3112ca7786ed..482557905294 100644
> --- a/arch/x86/mm/pat/memtype.c
> +++ b/arch/x86/mm/pat/memtype.c
> @@ -583,7 +583,7 @@ int memtype_reserve(u64 start, u64 end, enum page_cache_mode req_type,
>  	int err = 0;
>  
>  	start = sanitize_phys(start);
> -	end = sanitize_phys(end);

        /*
         * [start, end] is an exclusive address range, but
         * sanitize_phys() expects an inclusive end address
         */

> +	end = sanitize_phys(end - 1) + 1;
>  	if (start >= end) {
>  		WARN(1, "%s failed: [mem %#010Lx-%#010Lx], req %s\n", __func__,
>  				start, end - 1, cattr_name(req_type));

Thanks,

        tglx
