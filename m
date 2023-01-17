Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE67966E73C
	for <lists+linux-edac@lfdr.de>; Tue, 17 Jan 2023 20:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjAQTrq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 17 Jan 2023 14:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbjAQTn5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 17 Jan 2023 14:43:57 -0500
Received: from lobo.ruivo.org (lobo.ruivo.org [173.14.175.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FDD58282
        for <linux-edac@vger.kernel.org>; Tue, 17 Jan 2023 10:44:42 -0800 (PST)
Received: by lobo.ruivo.org (Postfix, from userid 1011)
        id 1922D52C32; Tue, 17 Jan 2023 13:44:28 -0500 (EST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
Received: from jake.ruivo.org (bob.qemu.ruivo [192.168.72.19])
        by lobo.ruivo.org (Postfix) with ESMTPA id 2A89A52723;
        Tue, 17 Jan 2023 13:44:11 -0500 (EST)
Received: by jake.ruivo.org (Postfix, from userid 1000)
        id 7772D220056; Tue, 17 Jan 2023 13:44:10 -0500 (EST)
Date:   Tue, 17 Jan 2023 13:44:10 -0500
From:   Aristeu Rozanski <aris@ruivo.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "aris@redhat.com" <aris@redhat.com>
Subject: Re: [RFC PATCH] mce: prevent concurrent polling of MCE events
Message-ID: <Y8bsejfSuXZ/NaEu@cathedrallabs.org>
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

On Tue, Jan 17, 2023 at 05:42:36PM +0000, Luck, Tony wrote:
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

Yes, but could change the patch to include mce_available() into the
protection of the lock. It should cleared once machine_check_poll() clears
the bank state, no?

> One option to avoid this might be to change from a fixed five minute
> polling interval to "five minute plus/minus rand(50) jiffies". Then even
> if some CPUs did sync up, they'd quickly diverge again.

That'd be fine for me as well. Perhaps initialize the polling interval using
cpu numbers to space them then random for rescheduling?

-- 
Aristeu

