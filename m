Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD822F6CD4
	for <lists+linux-edac@lfdr.de>; Thu, 14 Jan 2021 22:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbhANVFw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 14 Jan 2021 16:05:52 -0500
Received: from mga14.intel.com ([192.55.52.115]:36186 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbhANVFw (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 14 Jan 2021 16:05:52 -0500
IronPort-SDR: ea4SKUP8l9rpbX9MBFEJhiF+Zv2RVEkmd0oqI1S5zQggGWJjlj3WF4ZPSkwvwbysVC4ibLyI9K
 unK3Hk8DmMww==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="177665019"
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="177665019"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 13:05:10 -0800
IronPort-SDR: 03RvIpZ+Lb+/0ctdvuH0LibwMHA7S2WVnPFAmamgNbPWTX4ZZdXMIHObiFmiRtu9XKUYjZUXlz
 37Li9XUrMdbQ==
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="382406448"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 13:05:10 -0800
Date:   Thu, 14 Jan 2021 13:05:08 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2 1/3] x86/mce: Avoid infinite loop for copy from user
 recovery
Message-ID: <20210114210508.GA20224@agluck-desk2.amr.corp.intel.com>
References: <20210108222251.14391-1-tony.luck@intel.com>
 <20210111214452.1826-1-tony.luck@intel.com>
 <20210111214452.1826-2-tony.luck@intel.com>
 <20210114202213.GI12284@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114202213.GI12284@zn.tnic>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jan 14, 2021 at 09:22:13PM +0100, Borislav Petkov wrote:
> On Mon, Jan 11, 2021 at 01:44:50PM -0800, Tony Luck wrote:
> > @@ -1431,8 +1433,11 @@ noinstr void do_machine_check(struct pt_regs *regs)
> >  				mce_panic("Failed kernel mode recovery", &m, msg);
> >  		}
> >  
> > -		if (m.kflags & MCE_IN_KERNEL_COPYIN)
> > +		if (m.kflags & MCE_IN_KERNEL_COPYIN) {
> > +			if (current->mce_busy)
> > +				mce_panic("Multiple copyin", &m, msg);
> 
> So this: we're currently busy handling the first MCE, why do we must
> panic?
> 
> Can we simply ignore all follow-up MCEs to that page?

If we s/all/some/ you are saying the same as Andy:
> So I tend to think that the machine check code should arrange to
> survive some reasonable number of duplicate machine checks.

> I.e., the page will get poisoned eventually and that poisoning is
> currently executing so all following MCEs are simply nothing new and we
> can ignore them.
> 
> It's not like we're going to corrupt more data - we already are
> "corrupting" whole 4K.
> 
> Am I making sense?
> 
> Because if we do this, we won't have to pay attention to any get_user()
> callers and whatnot - we simply ignore and the solution is simple and
> you won't have to touch any get_user() callers...

Changing get_user() is a can of worms. I don't think its a very big can.
Perhaps two or three dozen places where code needs to change to account
for the -ENXIO return ... but touching a bunch of different subsystems
it is likley to take a while to get everyone in agreement.

I'll try out this new approach, and if it works, I'll post a v3 patch.

Thanks

-Tony
