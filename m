Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D334A1C5CDC
	for <lists+linux-edac@lfdr.de>; Tue,  5 May 2020 18:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbgEEQDP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 5 May 2020 12:03:15 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37546 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728804AbgEEQDO (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 5 May 2020 12:03:14 -0400
Received: from zn.tnic (p200300EC2F2125003DC7FB5010B51445.dip0.t-ipconnect.de [IPv6:2003:ec:2f21:2500:3dc7:fb50:10b5:1445])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A35821EC02F4;
        Tue,  5 May 2020 18:03:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1588694592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=p4Y+pPdPGM5LYCrnIkx7itwYr9JPD5bhg1YHbA7YuMg=;
        b=dGpnNTTmq2kZ9AzBjJbZtEMGU0mUIlgugLiiwTruWsLayXqUx/A1LMGhUGsrWYPJpLp/RC
        niI3RbbRTJ1XP7YLz3kqNzZRleW3pxjWMD8kNfbIOaEFYoKwJqUFqgdhi7RIOb3ZVz3Ptj
        kM7RIyhGodpM5WHSAsY4FSAgxV2RNsc=
Date:   Tue, 5 May 2020 18:03:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Waiman Long <longman@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        linux-edac@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: Fix some typo errors in ras.rst
Message-ID: <20200505160308.GA25446@zn.tnic>
References: <20200505151049.11134-1-longman@redhat.com>
 <20200505154816.GH16070@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200505154816.GH16070@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, May 05, 2020 at 08:48:16AM -0700, Matthew Wilcox wrote:
> Usually a 64-bit system refers to the width of a pointer.  Here, it's
> referring to the width of the memory system, which is rather confusing.
> How about "In the above example" instead of "So, on 64 bit systems".

Yes, that should not talk about 64-bit systems but about the length of
the word the memory controller uses to create the ECC check bits out of.

That whole doc needs checking/fixing.

> The extra 8 bits which are used for error detection and correction
> are referred to as the *syndrome*\ [#f1]_\ [#f2]_.

Well, I know it as "The syndrome field uniquely identifies the failing
bit positions of a correctable ECC error." and depending on the error
severity you can have correctable and uncorrectable syndromes.

I don't think the syndrome is the ECC word but it might be, depending
on the ECC algorithm used or it might be that what I pasted above. That
would need deeper digging.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
