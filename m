Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE0523E47F
	for <lists+linux-edac@lfdr.de>; Fri,  7 Aug 2020 01:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgHFXjY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 6 Aug 2020 19:39:24 -0400
Received: from mga18.intel.com ([134.134.136.126]:33140 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbgHFXjX (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 6 Aug 2020 19:39:23 -0400
IronPort-SDR: WxImU8HKevawQsvWAAy8RPClL4sPTbQfxQsSdB4fOJVzpGfc+LYIibsLG+kA+us0OoPanuGZaa
 eQcDPtymJWDA==
X-IronPort-AV: E=McAfee;i="6000,8403,9705"; a="140546952"
X-IronPort-AV: E=Sophos;i="5.75,443,1589266800"; 
   d="scan'208";a="140546952"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 16:39:22 -0700
IronPort-SDR: li0Zvboit1nDjrVaU53I/yfcJlRuBf8AuGwmO7gp3Q+8SO0OtZaKFEmtR1Ad803PgyAwVTC5hQ
 UPwAdr0LeSqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,443,1589266800"; 
   d="scan'208";a="333366457"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga007.jf.intel.com with ESMTP; 06 Aug 2020 16:39:21 -0700
Date:   Thu, 6 Aug 2020 16:39:06 -0700
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
Message-ID: <20200806233906.GA27118@ranerica-svr.sc.intel.com>
References: <20200806192531.25136-1-ricardo.neri-calderon@linux.intel.com>
 <a6ab438e-8ca8-999f-9eb9-c43fe1b9f128@intel.com>
 <20200806230455.GA25599@ranerica-svr.sc.intel.com>
 <929b76df-7da8-9147-3939-5e044f9d7728@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <929b76df-7da8-9147-3939-5e044f9d7728@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Aug 06, 2020 at 04:08:47PM -0700, Dave Hansen wrote:
> On 8/6/20 4:04 PM, Ricardo Neri wrote:
> > 	 * CPUID is the conventional way, but it's nasty: it doesn't
> > 	 * exist on some 486-like CPUs, and it usually exits to a
> > 	 * hypervisor.
> > 	 *
> >  	 * The SERIALIZE instruction is the most straightforward way to
> >  	 * do this as it does not clobber registers or exit to a
> > 	 * hypervisor. However, it is not universally available.
> >  	 *
> > 	 * Like all of Linux's memory ordering operations, this is a
> > 	 * compiler barrier as well.
> > 	 */
> > 
> > What do you think?
> 
> I like what I suggested.  :)
> 
> SERIALIZE is best where available.  Do it first, comment it by itself.
> 
> Then, go into the long discussion of the other alternatives.  They only
> make sense when SERIALIZE isn't there, and the logic for selection there
> is substantially more complicated.

Sure Dave, I think this layout makes sense. I will rework the comments.

Thanks and BR,
Ricardo
