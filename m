Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83F52305BE
	for <lists+linux-edac@lfdr.de>; Tue, 28 Jul 2020 10:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgG1IvB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 28 Jul 2020 04:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbgG1IvA (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 28 Jul 2020 04:51:00 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3F4C061794;
        Tue, 28 Jul 2020 01:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aEFlg03VmtZOr/NYRmyuz84VepVVyyUYcNOy0JnX5T8=; b=OEgxRW7y0wSoCYnQSUKvzfN1OH
        Q6XAKE4+evLVmDJklilk347gso//k5jl+hjwnyAY0+jRKCm2CwvRXUefBdtx/yo4gzIM71vFWzxHA
        o4clIClpbhHUkxulqyj5Y4T7prAFTrOdS+JLRai2B92/cktkIfDrTdxLIaRUSdgEMVTedDG9NEb4T
        YY5PgfRffGnYKyxOTCkzTOdFfRbOBAAuIjKH2fKlUiCRl8DmHzOvCcPb4QAUYIXs1HDQJXGmBnXal
        xFPcdcTOqFlHH57ng5gv2tWSbHVA9Fj9N4d65FfDSwOYpZDdFHuphpd4IM4DkZ9xygtnSBCq8SjJa
        Rr392w5g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0LJz-0002iJ-Nb; Tue, 28 Jul 2020 08:50:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1E410304D58;
        Tue, 28 Jul 2020 10:50:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 00B55203D4252; Tue, 28 Jul 2020 10:50:49 +0200 (CEST)
Date:   Tue, 28 Jul 2020 10:50:49 +0200
From:   peterz@infradead.org
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     hpa@zytor.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Cathy Zhang <cathy.zhang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Kyung Min Park <kyung.min.park@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-edac@vger.kernel.org, frederic@kernel.org
Subject: Re: [PATCH 4/4] x86/cpu: Use SERIALIZE in sync_core() when available
Message-ID: <20200728085049.GS119549@hirez.programming.kicks-ass.net>
References: <20200727043132.15082-1-ricardo.neri-calderon@linux.intel.com>
 <20200727043132.15082-5-ricardo.neri-calderon@linux.intel.com>
 <D51F2DC3-3C56-44E6-A1F2-434E7D27133C@zytor.com>
 <20200727083619.GF119549@hirez.programming.kicks-ass.net>
 <49251CFA-8AC3-462D-A60F-0337593BE9CD@zytor.com>
 <20200727130536.GM119549@hirez.programming.kicks-ass.net>
 <20200727133020.GN119549@hirez.programming.kicks-ass.net>
 <20200728044114.GA24129@ranerica-svr.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728044114.GA24129@ranerica-svr.sc.intel.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jul 27, 2020 at 09:41:14PM -0700, Ricardo Neri wrote:
> I think I got a little lost here.

Hehe, sorry. I got carried away, it's just that recently people
expressed interest in 'fixing' some of the text_poke_sync() issues
again.

> If I understand correctly, there are
> two alternatives to implement support for serialize better:
> 
>   a) alternative(IRET_TO_SELF, SERIALIZE, X86_FEATURE_SERIALIZE); or
>   b) asm volatile("1:.byte 0xf, 0x1, 0xe8;2:" _ASM_EXTABLE(1b:2b)
> 
> a) would be the traditional and simpler solution. b) would rely on
> causing an #UD and getting an IRET on existing hardware b) would need some
> more optimization work when handling the exception and a few reworks on
> the poke patching code.
> 
> Which option should I focus on? Which option would be more desirable/better?

I'd say go with (a) for now. We can always go overboard later ;-)
