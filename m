Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAC86F1C0B
	for <lists+linux-edac@lfdr.de>; Fri, 28 Apr 2023 17:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjD1P47 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 28 Apr 2023 11:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjD1P46 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 28 Apr 2023 11:56:58 -0400
X-Greylist: delayed 336 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 28 Apr 2023 08:56:57 PDT
Received: from lobo.ruivo.org (lobo.ruivo.org [173.14.175.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA0812B
        for <linux-edac@vger.kernel.org>; Fri, 28 Apr 2023 08:56:57 -0700 (PDT)
Received: by lobo.ruivo.org (Postfix, from userid 1011)
        id 4D9F352E79; Fri, 28 Apr 2023 11:51:20 -0400 (EDT)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Received: from jake.ruivo.org (bob.qemu.ruivo [192.168.72.19])
        by lobo.ruivo.org (Postfix) with ESMTPA id 0602652975;
        Fri, 28 Apr 2023 11:51:03 -0400 (EDT)
Received: by jake.ruivo.org (Postfix, from userid 1000)
        id EFC4E2200DC; Fri, 28 Apr 2023 11:51:02 -0400 (EDT)
Date:   Fri, 28 Apr 2023 11:51:02 -0400
From:   Aristeu Rozanski <aris@ruivo.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "aris@redhat.com" <aris@redhat.com>
Subject: Re: [RFC PATCH] mce: prevent concurrent polling of MCE events
Message-ID: <20230428155102.GE2449174@cathedrallabs.org>
References: <Y8WtE7BNJ0gTrqIS@cathedrallabs.org>
 <SJ1PR11MB6083410C8464DEC926C0BDB9FCC69@SJ1PR11MB6083.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083410C8464DEC926C0BDB9FCC69@SJ1PR11MB6083.namprd11.prod.outlook.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Tony,

On Tue, Jan 17, 2023 at 05:42:36PM +0000, Luck, Tony wrote:
> > +static DEFINE_RAW_SPINLOCK(timer_fn_lock);
> >
> >  static unsigned long mce_adjust_timer_default(unsigned long interval)
> >  {
> > @@ -1628,7 +1629,9 @@ static void mce_timer_fn(struct timer_list *t)
> >       iv = __this_cpu_read(mce_next_interval);
> >
> >       if (mce_available(this_cpu_ptr(&cpu_info))) {
> > +             raw_spin_lock(&timer_fn_lock);
> >               machine_check_poll(0, this_cpu_ptr(&mce_poll_banks));
> > +             raw_spin_unlock(&timer_fn_lock);
> >
> >               if (mce_intel_cmci_poll()) {
> >                       iv = mce_adjust_timer(iv);
> 
> If the CMCI polling interrupts on those large number of CPUs are
> staggered at different times, then this should be fine. But if a largish
> number of CPUs get in lockstep with each other, then this could get
> ugly.  I.e. 200 CPUs all take the "CMCI poll" interrupt together. Then
> get stuck in a convoy here as one at a time step through checking
> the machine check banks.
> 
> I'm not sure if that is just a theoretical issue, or how bad it might
> actually be if it happened.
> 
> One option to avoid this might be to change from a fixed five minute
> polling interval to "five minute plus/minus rand(50) jiffies". Then even
> if some CPUs did sync up, they'd quickly diverge again.

I did experiment different ranges including forcing a minimum difference
based on cpu number but eventually I'd see repeated events. Perhaps a
combination would be acceptable? Set the first run of each cpu spaced based on
CPU number then use a spinlock to synchronize it? That way we minimize the
chance of a big number of CPUs stuck on the same lock but at same time
guarantee we won't have duplicated events.

-- 
Aristeu

