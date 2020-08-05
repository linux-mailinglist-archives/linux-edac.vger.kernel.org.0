Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1339823C4EA
	for <lists+linux-edac@lfdr.de>; Wed,  5 Aug 2020 07:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgHEFIf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 5 Aug 2020 01:08:35 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43620 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgHEFIe (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 5 Aug 2020 01:08:34 -0400
Received: from nazgul.tnic (unknown [78.130.214.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3ADE11EC011B;
        Wed,  5 Aug 2020 07:08:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1596604113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1u26XeRiQkxkUBVyq1C3UUK8HOmJUYiFSDMJ8RBojNE=;
        b=GG177QaJonWAuUC13SR3y4ds2cnXadbPEM2YBqg3gbVe4APx1/ZqJxFvqeBQ429E56gssp
        hnXDUzgMZByTf4j+W575pNkPeQKZqZgMibU04gt1TV9zIVpPW3WqNAm3a0qlQ0W5/OorFV
        ta4ilidH/Xn1hV0nEokEGV9fcYhEfRs=
Date:   Wed, 5 Aug 2020 07:08:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     hpa@zytor.com
Cc:     Borislav Petkov <bp@suse.de>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
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
        linux-edac@vger.kernel.org
Subject: Re: [PATCH v2] x86/cpu: Use SERIALIZE in sync_core() when available
Message-ID: <20200805050808.GC9127@nazgul.tnic>
References: <20200805021059.1331-1-ricardo.neri-calderon@linux.intel.com>
 <20200805044840.GA9127@nazgul.tnic>
 <47A60E6A-0742-45FB-B707-175E87C58184@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <47A60E6A-0742-45FB-B707-175E87C58184@zytor.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Aug 04, 2020 at 09:58:25PM -0700, hpa@zytor.com wrote:
> Because why use an alternative to jump over one instruction?
>
> I personally would prefer to have the IRET put out of line

Can't yet - SERIALIZE CPUs are a minority at the moment.

> and have the call/jmp replaced by SERIALIZE inline.

Well, we could do:

	alternative_io("... IRET bunch", __ASM_SERIALIZE, X86_FEATURE_SERIALIZE, ...);

and avoid all kinds of jumping. Alternatives get padded so there
would be a couple of NOPs following when SERIALIZE gets patched in
but it shouldn't be a problem. I guess one needs to look at what gcc
generates...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
