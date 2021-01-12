Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759872F3D19
	for <lists+linux-edac@lfdr.de>; Wed, 13 Jan 2021 01:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437029AbhALVh0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 12 Jan 2021 16:37:26 -0500
Received: from mga07.intel.com ([134.134.136.100]:31105 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437054AbhALUwt (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 12 Jan 2021 15:52:49 -0500
IronPort-SDR: 2MDHTGdpGN4jXtezKKdvrIKrtSpBanrMCI52zNVmPbZ+pd1vWjAopTWbxBlTHrkZ8RVRlum+kC
 OhjB4JfyGXXw==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="242177171"
X-IronPort-AV: E=Sophos;i="5.79,342,1602572400"; 
   d="scan'208";a="242177171"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 12:52:08 -0800
IronPort-SDR: Wu6WoLc2o2d/j/ii4THsm2ucwjV0kUfST7rA1MiUlyzowea2bvapCYZNw2rQl2PSo/C2o3sWdV
 8noJcyh/p2KQ==
X-IronPort-AV: E=Sophos;i="5.79,342,1602572400"; 
   d="scan'208";a="363643267"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 12:52:08 -0800
Date:   Tue, 12 Jan 2021 12:52:07 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v2 1/3] x86/mce: Avoid infinite loop for copy from user
 recovery
Message-ID: <20210112205207.GA18195@agluck-desk2.amr.corp.intel.com>
References: <20210111214452.1826-2-tony.luck@intel.com>
 <E1FCB534-9149-437A-971E-F93C009F99C3@amacapital.net>
 <20210111222057.GA2369@agluck-desk2.amr.corp.intel.com>
 <CALCETrVhRF0H+R1aiy-rdguL3A_9M35R3roVAgRGaEAMCJVW0Q@mail.gmail.com>
 <20210112171628.GA15664@agluck-desk2.amr.corp.intel.com>
 <CALCETrWijyKoopqAHjohMbvfX191GhmMVQCQjKWx1s3+SA+-uA@mail.gmail.com>
 <20210112182357.GA16390@agluck-desk2.amr.corp.intel.com>
 <CALCETrXw59WDTwfoZHVtDrveMpFF=Eh4jaOF7vFsF02Zk54mDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXw59WDTwfoZHVtDrveMpFF=Eh4jaOF7vFsF02Zk54mDw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jan 12, 2021 at 10:57:07AM -0800, Andy Lutomirski wrote:
> On Tue, Jan 12, 2021 at 10:24 AM Luck, Tony <tony.luck@intel.com> wrote:
> >
> > On Tue, Jan 12, 2021 at 09:21:21AM -0800, Andy Lutomirski wrote:
> > > Well, we need to do *something* when the first __get_user() trips the
> > > #MC.  It would be nice if we could actually fix up the page tables
> > > inside the #MC handler, but, if we're in a pagefault_disable() context
> > > we might have locks held.  Heck, we could have the pagetable lock
> > > held, be inside NMI, etc.  Skipping the task_work_add() might actually
> > > make sense if we get a second one.
> > >
> > > We won't actually infinite loop in pagefault_disable() context -- if
> > > we would, then we would also infinite loop just from a regular page
> > > fault, too.
> >
> > Fixing the page tables inside the #MC handler to unmap the poison
> > page would indeed be a good solution. But, as you point out, not possible
> > because of locks.
> >
> > Could we take a more drastic approach? We know that this case the kernel
> > is accessing a user address for the current process. Could the machine
> > check handler just re-write %cr3 to point to a kernel-only page table[1].
> > I.e. unmap the entire current user process.
> 
> That seems scary, especially if we're in the middle of a context
> switch when this happens.  We *could* make it work, but I'm not at all
> convinced it's wise.

Scary? It's terrifying!

But we know that the fault happend in a get_user() or copy_from_user() call
(i.e. an RIP with an extable recovery address).  Does context switch
access user memory?

-Tony
