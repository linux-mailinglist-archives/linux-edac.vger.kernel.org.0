Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43716FFD66
	for <lists+linux-edac@lfdr.de>; Fri, 12 May 2023 01:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239420AbjEKXjA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 11 May 2023 19:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239401AbjEKXjA (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 11 May 2023 19:39:00 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7BAB3
        for <linux-edac@vger.kernel.org>; Thu, 11 May 2023 16:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683848339; x=1715384339;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KpzkTy+x0adWk4unnzBJDkgPpCm5yDwGIU4V+iXxl0c=;
  b=bQY6AqZPDbkuvmOvxHGZI0gG9eVdZ/vMMKCifEzGvCLeJpFSN0Id/t/L
   0J4jnknz2SgfpKFld1qBWNahvNKxFluZ5ftogC+vgdF+61f4z4tMNDRDG
   P/i4fU0hr4WN+yTvbe2mA3TMy9O5Y9scFLJxthIs6/7/8Ijhohe7NLG8+
   SW78aunQc51/fztEWk2mhMNfxANNu+AaAVKr4ZxOowvPhrn0kI56UUvim
   tkHEuT7MFNfpwUsKzklz35xZt0lZqCkZtXBE0O0c45g3hplJJY4da9dH7
   SeqDhaAYxqmcJ1cuFPH6YFPT6Ave5ruyqEMBt3UCBrBDRK0J0k4V3GFu9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="436994367"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="436994367"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 16:38:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="732802164"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="732802164"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 16:38:58 -0700
Date:   Thu, 11 May 2023 16:38:57 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Aristeu Rozanski <aris@ruivo.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "aris@redhat.com" <aris@redhat.com>
Subject: Re: [RFC PATCH] mce: prevent concurrent polling of MCE events
Message-ID: <ZF18kdWCWKqFc23p@agluck-desk3.sc.intel.com>
References: <Y8WtE7BNJ0gTrqIS@cathedrallabs.org>
 <SJ1PR11MB6083410C8464DEC926C0BDB9FCC69@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230428155102.GE2449174@cathedrallabs.org>
 <SJ1PR11MB6083083A8C72CAC6E39DF924FC6B9@SJ1PR11MB6083.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083083A8C72CAC6E39DF924FC6B9@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Apr 28, 2023 at 04:43:46PM +0000, Luck, Tony wrote:
> > One option to avoid this might be to change from a fixed five minute
> > > polling interval to "five minute plus/minus rand(50) jiffies". Then even
> > > if some CPUs did sync up, they'd quickly diverge again.
> >
> > I did experiment different ranges including forcing a minimum difference
> > based on cpu number but eventually I'd see repeated events. Perhaps a
> > combination would be acceptable? Set the first run of each cpu spaced based on
> > CPU number then use a spinlock to synchronize it? That way we minimize the
> > chance of a big number of CPUs stuck on the same lock but at same time
> > guarantee we won't have duplicated events.
> 
> Aristeu,
> 
> Yes. A variable poll interval (to avoid CPUs all bunching together) with
> the spinlock to serialize the cases where some CPUs do line up their
> polling would work.

I just ran a test on a system booted with mce=no_cmci and saw the
duplicate reporting.  Digging into the code I see that I'm not the
first to think that a little randomness in timers on different CPUs
would be a good idea. The MCE code starts/restarts timers with:

	mod_timer(t, round_jiffies(when));

Looking at the round_jiffies() function I sw that it is grabbing
the current CPU number.

unsigned long round_jiffies(unsigned long j)
{
        return round_jiffies_common(j, raw_smp_processor_id(), false);
}

And round_jiffies_common() explains with this comment:

        /*
         * We don't want all cpus firing their timers at once hitting the
         * same lock or cachelines, so we skew each extra cpu with an extra
         * 3 jiffies. This 3 jiffies came originally from the mm/ code which
         * already did this.
         * The skew is done by adding 3*cpunr, then round, then subtract this
         * extra offset again.
         */
        j += cpu * 3;

	rem = j % HZ;

So your original patch https://lore.kernel.org/all/Y8WtE7BNJ0gTrqIS@cathedrallabs.org/
that just added the spinlock should be fine!

-Tony



