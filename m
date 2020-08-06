Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0816E23E449
	for <lists+linux-edac@lfdr.de>; Fri,  7 Aug 2020 01:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgHFXFM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 6 Aug 2020 19:05:12 -0400
Received: from mga14.intel.com ([192.55.52.115]:27306 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbgHFXFM (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 6 Aug 2020 19:05:12 -0400
IronPort-SDR: vXCBGlEmPU9IxCx5iWvEKZqDBlU18EkAL/TjOaOKmgtoCJv7BGFvTxXCdA8VDgM/6ajkaW+s0Z
 iCjc/ZnIuGKw==
X-IronPort-AV: E=McAfee;i="6000,8403,9705"; a="152191017"
X-IronPort-AV: E=Sophos;i="5.75,443,1589266800"; 
   d="scan'208";a="152191017"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 16:05:10 -0700
IronPort-SDR: uUTn6CHU7je2ajS68CQoj2YLjkr/1MCldGbXYW6F3YT4knCs9GgIsaQzrIUWzAKLloL+v10rQZ
 nZPx79bBmmXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,443,1589266800"; 
   d="scan'208";a="323591859"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga008.jf.intel.com with ESMTP; 06 Aug 2020 16:05:10 -0700
Date:   Thu, 6 Aug 2020 16:04:55 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Cathy Zhang <cathy.zhang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kyung Min Park <kyung.min.park@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH v3] x86/cpu: Use SERIALIZE in sync_core() when available
Message-ID: <20200806230455.GA25599@ranerica-svr.sc.intel.com>
References: <20200806192531.25136-1-ricardo.neri-calderon@linux.intel.com>
 <a6ab438e-8ca8-999f-9eb9-c43fe1b9f128@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6ab438e-8ca8-999f-9eb9-c43fe1b9f128@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Aug 06, 2020 at 12:57:26PM -0700, Dave Hansen wrote:
> On 8/6/20 12:25 PM, Ricardo Neri wrote:
> >  static inline void sync_core(void)
> >  {
> >  	/*
> > -	 * There are quite a few ways to do this.  IRET-to-self is nice
> > +	 * Hardware can do this for us if SERIALIZE is available. Otherwise,
> > +	 * there are quite a few ways to do this.  IRET-to-self is nice
> 
> This seems to imply that things other than SERIALIZE aren't the hardware
> doing this.  All of these methods are equally architecturally
> serializing *and* provided by the hardware.

Indeed, I can see how the wording may imply that.

> 
> I also don't quite get the point of separating the comments from the
> code.  Shouldn't this be:
> 
> 	/*
> 	 * The SERIALIZE instruction is the most straightforward way to
> 	 * do this but it not universally available.
> 	 */

I regard the comment as describing all the considered options to for
architectural serialization. What about if I add SERIALIZE as another
option? I propose to discuss it towards the end of the comment:

	/*
	 * There are quite a few ways to do this.  IRET-to-self is nice
	 * because it works on every CPU, at any CPL (so it's compatible
	 * with paravirtualization), and it never exits to a hypervisor.
	 * The only down sides are that it's a bit slow (it seems to be
	 * a bit more than 2x slower than the fastest options) and that
	 * it unmasks NMIs.  The "push %cs" is needed because, in
	 * paravirtual environments, __KERNEL_CS may not be a valid CS
	 * value when we do IRET directly.
	 *
	 * In case NMI unmasking or performance ever becomes a problem,
	 * the next best option appears to be MOV-to-CR2 and an
	 * unconditional jump.  That sequence also works on all CPUs,
	 * but it will fault at CPL3 (i.e. Xen PV).
	 *
	 * CPUID is the conventional way, but it's nasty: it doesn't
	 * exist on some 486-like CPUs, and it usually exits to a
	 * hypervisor.
	 *
 	 * The SERIALIZE instruction is the most straightforward way to
 	 * do this as it does not clobber registers or exit to a
	 * hypervisor. However, it is not universally available.
 	 *
	 * Like all of Linux's memory ordering operations, this is a
	 * compiler barrier as well.
	 */

What do you think?

> 	if (static_cpu_has(X86_FEATURE_SERIALIZE)) {
> 		asm volatile(__ASM_SERIALIZE ::: "memory");
> 		return;
> 	}
> 
> 	/*
> 	 * For all other processors, IRET-to-self is nice ...
> 	 */
> 	iret_to_self();

