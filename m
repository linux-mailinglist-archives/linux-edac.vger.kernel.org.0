Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D65700DE6
	for <lists+linux-edac@lfdr.de>; Fri, 12 May 2023 19:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbjELRdN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 12 May 2023 13:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjELRdM (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 12 May 2023 13:33:12 -0400
Received: from lobo.ruivo.org (lobo.ruivo.org [173.14.175.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E871B8
        for <linux-edac@vger.kernel.org>; Fri, 12 May 2023 10:33:10 -0700 (PDT)
Received: by lobo.ruivo.org (Postfix, from userid 1011)
        id 0305A52E27; Fri, 12 May 2023 13:33:08 -0400 (EDT)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Received: from jake.ruivo.org (bob.qemu.ruivo [192.168.72.19])
        by lobo.ruivo.org (Postfix) with ESMTPA id AA0425299B;
        Fri, 12 May 2023 13:32:51 -0400 (EDT)
Received: by jake.ruivo.org (Postfix, from userid 1000)
        id 9C0E72200DF; Fri, 12 May 2023 13:32:51 -0400 (EDT)
Date:   Fri, 12 May 2023 13:32:51 -0400
From:   Aristeu Rozanski <aris@ruivo.org>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "aris@redhat.com" <aris@redhat.com>
Subject: Re: [RFC PATCH] mce: prevent concurrent polling of MCE events
Message-ID: <20230512173251.GB4090740@cathedrallabs.org>
References: <Y8WtE7BNJ0gTrqIS@cathedrallabs.org>
 <SJ1PR11MB6083410C8464DEC926C0BDB9FCC69@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230428155102.GE2449174@cathedrallabs.org>
 <SJ1PR11MB6083083A8C72CAC6E39DF924FC6B9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ZF18kdWCWKqFc23p@agluck-desk3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZF18kdWCWKqFc23p@agluck-desk3.sc.intel.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, May 11, 2023 at 04:38:57PM -0700, Tony Luck wrote:
> I just ran a test on a system booted with mce=no_cmci and saw the
> duplicate reporting.  Digging into the code I see that I'm not the
> first to think that a little randomness in timers on different CPUs
> would be a good idea. The MCE code starts/restarts timers with:
> 
> 	mod_timer(t, round_jiffies(when));
> 
> Looking at the round_jiffies() function I sw that it is grabbing
> the current CPU number.
> 
> unsigned long round_jiffies(unsigned long j)
> {
>         return round_jiffies_common(j, raw_smp_processor_id(), false);
> }
> 
> And round_jiffies_common() explains with this comment:
> 
>         /*
>          * We don't want all cpus firing their timers at once hitting the
>          * same lock or cachelines, so we skew each extra cpu with an extra
>          * 3 jiffies. This 3 jiffies came originally from the mm/ code which
>          * already did this.
>          * The skew is done by adding 3*cpunr, then round, then subtract this
>          * extra offset again.
>          */
>         j += cpu * 3;
> 
> 	rem = j % HZ;
> 
> So your original patch https://lore.kernel.org/all/Y8WtE7BNJ0gTrqIS@cathedrallabs.org/
> that just added the spinlock should be fine!

Thanks Tony. You want me to resend it or the original is enough?

-- 
Aristeu

