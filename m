Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0B0121020
	for <lists+linux-edac@lfdr.de>; Mon, 16 Dec 2019 17:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfLPQwP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 16 Dec 2019 11:52:15 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49220 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfLPQwP (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 16 Dec 2019 11:52:15 -0500
Received: from zn.tnic (p200300EC2F07BC00D0F2C92C76B3ABC9.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:bc00:d0f2:c92c:76b3:abc9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 565DC1EC090E;
        Mon, 16 Dec 2019 17:52:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1576515133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wTN5rkr1NDxJwl1jtHOEhLLQszADtXK6VHUxDJWHbik=;
        b=WoEmvkXLmtDlSQxqinPwGvHMEIW4BoPlxoNcloeK673uGUlZnUVWT/a63YEDjK4htuUf9j
        9xZZfKwIXx4HXpQEnYPuT2tabFtpt3b0HvfYOHcXFYRSYUW+XnWCnEn8O66N0wpP+KXliY
        UheBTdTrRe0QDl+nVIP/cHCZODNVq1E=
Date:   Mon, 16 Dec 2019 17:52:07 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jan =?utf-8?Q?H=2E_Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>, linux-edac@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH 0/6] x86/mce: Various fixes and cleanups for MCE handling
Message-ID: <20191216165207.GC17380@zn.tnic>
References: <20191210000733.17979-1-jschoenh@amazon.de>
 <20191211002519.GA30513@agluck-desk2.amr.corp.intel.com>
 <d8e11387-c84a-f333-7ea5-f9043af6375e@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d8e11387-c84a-f333-7ea5-f9043af6375e@amazon.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Dec 12, 2019 at 01:25:31PM +0100, Jan H. Schönherr wrote:
> This and names like "uncorrected_memory_error_notifier()" seem to imply
> a wider scope than the function actually has. That brings me to another
> question: should the scope be wider?
> 
> Instead of filtering for usable addresses and specific severities, we
> could for example filter for (similar to cec_add_mce()):
> 
>   mce_is_memory_error(m) &&
>   !mce_is_correctable(m) &&
>   mce_usable_address(m)

There's a comment above that code which says what that function wants:

	/* We eat only correctable DRAM errors with usable addresses. */

> Would that make sense? Or does that violate anything, that I'm not aware of?

So this should be a decision of the two CPU vendors basically answering
the question: for which error severities you want the kernel to poison
pages?

Basically a question for Tony and Yazen. CCed.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
