Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4FF3F50A1
	for <lists+linux-edac@lfdr.de>; Mon, 23 Aug 2021 20:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhHWSqc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 23 Aug 2021 14:46:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:7614 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231695AbhHWSqb (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 23 Aug 2021 14:46:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10085"; a="204360206"
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="204360206"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 11:45:48 -0700
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="535472897"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 11:45:48 -0700
Date:   Mon, 23 Aug 2021 11:45:47 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sumanth Kamatala <skamatala@juniper.net>
Subject: Re: [PATCH] x86/mce/dev-mcelog: Call mce_register_decode_chain()
 much earlier
Message-ID: <20210823184547.GA1638691@agluck-desk2.amr.corp.intel.com>
References: <20210819224452.1619400-1-tony.luck@intel.com>
 <YR+f/fdGIxWcLTP2@zn.tnic>
 <20210820144314.GA1622759@agluck-desk2.amr.corp.intel.com>
 <YR/Oxark0bhLlona@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YR/Oxark0bhLlona@zn.tnic>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Aug 20, 2021 at 05:48:21PM +0200, Borislav Petkov wrote:
> On Fri, Aug 20, 2021 at 07:43:14AM -0700, Luck, Tony wrote:
> > How can the kernel tell that all consumers have registered? Is there
> > some new kernel crystal ball functionality that can predict that an
> > EDAC driver module is going to be loaded at some point in the future
> > when user space is up and running :-)
> 
> The crystal ball is called mcheck_late_init(). There's even:
> 
>         /*
>          * Flush out everything that has been logged during early boot, now that
>          * everything has been initialized (workqueues, decoders, ...).
>          */
>         mce_schedule_work();
> 
> in there. That thing is late_initcall() and by that time mcelog should
> have been registered. And I wonder why isn't that working as expected...
> 
> > I think the best we could do would be to set a timer for some point
> > far enough out (one minute?, two minutes?) to give a chance for
> > modules to load.
> 
> Forget modules - only the built-in stuff. We cannot be waiting
> indefinitely until someone loads mcelog for decoding.

I added some traces:

$ dmesg | grep mce:
[    0.033648] mce: mce_register_decode_chain fn=mce_early_notifier+0x0/0x50 pri=6
[    0.033655] mce: mce_register_decode_chain fn=uc_decode_notifier+0x0/0xd0 pri=5
[    0.033659] mce: mce_register_decode_chain fn=mce_default_notifier+0x0/0x30 pri=0
[    4.392631] mce: [Hardware Error]: Machine check events logged
[    4.393356] mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 0: a000000000004321
[    4.395352] mce: [Hardware Error]: TSC 0
[    4.396352] mce: [Hardware Error]: PROCESSOR 0:406f1 TIME 1629743651 SOCKET 0 APIC 0 microcode b000019
[   15.172861] mce: mce_register_decode_chain fn=dev_mce_log+0x0/0x110 pri=1
[   15.192101] mce: mcheck_late_init: calling mce_schedule_work()
[   31.618245] mce: mce_register_decode_chain fn=sbridge_mce_check_error+0x0/0x92 [sb_edac] pri=2

So you are right that mcheck_late_init() is called after dev_mce_log()
is registered.  But it seems someone kicks the queue long before that
happens.  Probably this:

void mce_log(struct mce *m)
{
        if (!mce_gen_pool_add(m))
                irq_work_queue(&mce_irq_work);
}

Could we add a flag:

static bool mce_ready_to_rock; // better name needed :-)

Which gets set in mcheck_late_init(). Then mce_log() becomes:

void mce_log(struct mce *m)
{
        if (!mce_gen_pool_add(m) && mce_ready_to_rock)
                irq_work_queue(&mce_irq_work);
}

-Tony
