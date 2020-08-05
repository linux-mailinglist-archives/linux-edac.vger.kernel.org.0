Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF2F23CF17
	for <lists+linux-edac@lfdr.de>; Wed,  5 Aug 2020 21:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbgHETNu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 5 Aug 2020 15:13:50 -0400
Received: from mga17.intel.com ([192.55.52.151]:40671 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727915AbgHETLq (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 5 Aug 2020 15:11:46 -0400
IronPort-SDR: qKX/ElW97fakr3JPsGtRORLgay4GLsxsHmianTeKpbmcvse2HSjsa2LrUTsaFSiJQq52pY06wl
 BHzHcCNgLGvA==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="132713644"
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="132713644"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 12:11:45 -0700
IronPort-SDR: gMtDv2wkDCrBFAxkgWEqDl3k5FFjBnx432Tkp7OHaGlY0qBEc7kSWXLpFuba6aQYFJUUSHKTnj
 sNu4wS1fmExQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="289026130"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga003.jf.intel.com with ESMTP; 05 Aug 2020 12:11:44 -0700
Date:   Wed, 5 Aug 2020 12:11:26 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Cathy Zhang <cathy.zhang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Kyung Min Park <kyung.min.park@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-edac <linux-edac@vger.kernel.org>
Subject: Re: [PATCH v2] x86/cpu: Use SERIALIZE in sync_core() when available
Message-ID: <20200805191126.GA27509@ranerica-svr.sc.intel.com>
References: <20200805021059.1331-1-ricardo.neri-calderon@linux.intel.com>
 <20200805044840.GA9127@nazgul.tnic>
 <47A60E6A-0742-45FB-B707-175E87C58184@zytor.com>
 <20200805050808.GC9127@nazgul.tnic>
 <20200805170717.GB26661@ranerica-svr.sc.intel.com>
 <CALCETrWByBugaunKPz52sdOGJpEdNNMK2kcp-wXgjFpFZuoOmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWByBugaunKPz52sdOGJpEdNNMK2kcp-wXgjFpFZuoOmQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Aug 05, 2020 at 11:28:31AM -0700, Andy Lutomirski wrote:
> On Wed, Aug 5, 2020 at 10:07 AM Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> >
> > On Wed, Aug 05, 2020 at 07:08:08AM +0200, Borislav Petkov wrote:
> > > On Tue, Aug 04, 2020 at 09:58:25PM -0700, hpa@zytor.com wrote:
> > > > Because why use an alternative to jump over one instruction?
> > > >
> > > > I personally would prefer to have the IRET put out of line
> > >
> > > Can't yet - SERIALIZE CPUs are a minority at the moment.
> > >
> > > > and have the call/jmp replaced by SERIALIZE inline.
> > >
> > > Well, we could do:
> > >
> > >       alternative_io("... IRET bunch", __ASM_SERIALIZE, X86_FEATURE_SERIALIZE, ...);
> > >
> > > and avoid all kinds of jumping. Alternatives get padded so there
> > > would be a couple of NOPs following when SERIALIZE gets patched in
> > > but it shouldn't be a problem. I guess one needs to look at what gcc
> > > generates...
> >
> > But the IRET-TO-SELF code has instruction which modify the stack. This
> > would violate stack invariance in alternatives as enforced in commit
> > 7117f16bf460 ("objtool: Fix ORC vs alternatives"). As a result, objtool
> > gives warnings as follows:
> >
> > arch/x86/kernel/alternative.o: warning: objtool: do_sync_core()+0xe:
> > alternative modifies stack
> >
> > Perhaps in this specific case it does not matter as the changes in the
> > stack will be undone by IRET. However, using alternative_io would require
> > adding the macro STACK_FRAME_NON_STANDARD to functions using sync_core().
> > IMHO, it wouldn't look good.
> >
> > So maybe the best approach is to implement as you suggested using
> > static_cpu_has()?
> 
> I agree.  Let's keep it simple.
> 
> Honestly, I think the right solution is to have iret_to_self() in
> actual asm and invoke it from C as needed. 

Do you mean anything different from what we have already [1]? If I
understand your comment correctly, we have exactly that: an
iret_to_self() asm implementation invoked from C.

Thanks and BR,
Ricardo

[1]. https://lore.kernel.org/lkml/20200727043132.15082-4-ricardo.neri-calderon@linux.intel.com/

Thanks and BR,
Ricardo
