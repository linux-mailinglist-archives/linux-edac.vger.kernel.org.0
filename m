Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D343F2E49
	for <lists+linux-edac@lfdr.de>; Fri, 20 Aug 2021 16:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238509AbhHTOny (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 20 Aug 2021 10:43:54 -0400
Received: from mga09.intel.com ([134.134.136.24]:60146 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235976AbhHTOny (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 20 Aug 2021 10:43:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="216781798"
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="216781798"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 07:43:16 -0700
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="523630465"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 07:43:15 -0700
Date:   Fri, 20 Aug 2021 07:43:14 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sumanth Kamatala <skamatala@juniper.net>
Subject: Re: [PATCH] x86/mce/dev-mcelog: Call mce_register_decode_chain()
 much earlier
Message-ID: <20210820144314.GA1622759@agluck-desk2.amr.corp.intel.com>
References: <20210819224452.1619400-1-tony.luck@intel.com>
 <YR+f/fdGIxWcLTP2@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YR+f/fdGIxWcLTP2@zn.tnic>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Aug 20, 2021 at 02:28:45PM +0200, Borislav Petkov wrote:
> On Thu, Aug 19, 2021 at 03:44:52PM -0700, Tony Luck wrote:
> > which made sure that the logs were not lost completely by printing
> > to the console. But parsing console logs is error prone. Users
> > of /dev/mcelog should expect to find any early errors logged to
> > standard places.
> 
> Yes, and for that matter, *all* consumers which register on the decoding
> chain should get a chance to look at those records...
> 
> > Split the initialization code in dev-mcelog.c into:
> > 1) an "early" part that registers for mce notifications. Call this
> > directly from mcheck_init() because early_initcall() is still too late.
> > This allocation is too early for kzalloc() so use memblock_alloc().
> > 2) "late" part that registers the /dev/mcelog character device.
> 
> ... but this looks like a hack to me: why aren't we adding those early
> records to the gen_pool and kick the work to consume them *only* *after*
> all consumers have been registered properly and everything is up and
> running?

How can the kernel tell that all consumers have registered? Is there
some new kernel crystal ball functionality that can predict that an
EDAC driver module is going to be loaded at some point in the future
when user space is up and running :-)

I think the best we could do would be to set a timer for some point
far enough out (one minute?, two minutes?) to give a chance for
modules to load. But this seems even more hacky ... I have no idea
how much time is enough? In this particular case we know that the
system crashed before ... maybe the file systems are going to need
a fsck(8) before modules are loaded?

-Tony
