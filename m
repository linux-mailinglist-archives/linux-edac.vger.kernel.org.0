Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C55922FE86
	for <lists+linux-edac@lfdr.de>; Tue, 28 Jul 2020 02:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgG1Agu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Jul 2020 20:36:50 -0400
Received: from mga07.intel.com ([134.134.136.100]:44770 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbgG1Agu (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 27 Jul 2020 20:36:50 -0400
IronPort-SDR: rHJ/QWobR8Dqz6I4cAx93LL6ZpH35o2M9ShTWNClKNxrNYkSsdIBaDFIJaOXZdpCDfYlq7ya5H
 KD4mnxViSE7w==
X-IronPort-AV: E=McAfee;i="6000,8403,9695"; a="215662507"
X-IronPort-AV: E=Sophos;i="5.75,404,1589266800"; 
   d="scan'208";a="215662507"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2020 17:36:49 -0700
IronPort-SDR: IxH+tGoVKPdytVZIaU6gWFsjUhs5XZzGizmV66F0YuHxiwkgVCwX7Pahf7wg3CFqjR5XAVXaPw
 GjbkN9f3WWIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,404,1589266800"; 
   d="scan'208";a="329864825"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga007.jf.intel.com with ESMTP; 27 Jul 2020 17:36:49 -0700
Date:   Mon, 27 Jul 2020 17:36:31 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     peterz@infradead.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Cathy Zhang <cathy.zhang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kyung Min Park <kyung.min.park@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH 4/4] x86/cpu: Use SERIALIZE in sync_core() when available
Message-ID: <20200728003631.GB23421@ranerica-svr.sc.intel.com>
References: <20200727043132.15082-1-ricardo.neri-calderon@linux.intel.com>
 <20200727043132.15082-5-ricardo.neri-calderon@linux.intel.com>
 <20200727082003.GD119549@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727082003.GD119549@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jul 27, 2020 at 10:20:03AM +0200, peterz@infradead.org wrote:
> On Sun, Jul 26, 2020 at 09:31:32PM -0700, Ricardo Neri wrote:
> > +static inline void serialize(void)
> > +{
> > +	asm volatile(".byte 0xf, 0x1, 0xe8");
> > +}
> 
> Can we pretty please have a comment with the binutils version that has
> the mnomic? Such that when we increase the required binutils version we
> can grep for this.

This is supported since binutils 2.35[1]. I'll add a comment with the
clarification.

Thanks and BR,
Ricardo

[1]. https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=blob_plain;f=gas/NEWS;;hb=refs/tags/binutils-2_35
