Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE5D2FC540
	for <lists+linux-edac@lfdr.de>; Wed, 20 Jan 2021 01:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730954AbhASX6r (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 19 Jan 2021 18:58:47 -0500
Received: from mga14.intel.com ([192.55.52.115]:14052 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730605AbhASX6p (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 19 Jan 2021 18:58:45 -0500
IronPort-SDR: ha3Lu4+1c8q4WW2nA7oTVwwe51MloQfA7aK55VsQukr8wNdPmwOLuSFCWEN/k5VIknRmKDU7Hm
 6zFmqFHz+aww==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="178237128"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="178237128"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 15:58:00 -0800
IronPort-SDR: Cr3m4y5okOrq1yhbLaWhhnHnH+hvpjKVUwfhFjIKslEtcuL+l6rDtnvmJFbtoRCs02T/kPK94B
 lS6RZYBCqJJQ==
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="402548004"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 15:58:00 -0800
Date:   Tue, 19 Jan 2021 15:57:59 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v4] x86/mce: Avoid infinite loop for copy from user
 recovery
Message-ID: <20210119235759.GA9970@agluck-desk2.amr.corp.intel.com>
References: <20210111214452.1826-1-tony.luck@intel.com>
 <20210115003817.23657-1-tony.luck@intel.com>
 <20210115152754.GC9138@zn.tnic>
 <20210115193435.GA4663@agluck-desk2.amr.corp.intel.com>
 <20210115205103.GA5920@agluck-desk2.amr.corp.intel.com>
 <20210115232346.GA7967@agluck-desk2.amr.corp.intel.com>
 <20210119105632.GF27433@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210119105632.GF27433@zn.tnic>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jan 19, 2021 at 11:56:32AM +0100, Borislav Petkov wrote:
> On Fri, Jan 15, 2021 at 03:23:46PM -0800, Luck, Tony wrote:
> > On Fri, Jan 15, 2021 at 12:51:03PM -0800, Luck, Tony wrote:
> > >  static void kill_me_now(struct callback_head *ch)
> > >  {
> > > +	p->mce_count = 0;
> > >  	force_sig(SIGBUS);
> > >  }
> > 
> > Brown paper bag time ... I just pasted that line from kill_me_maybe()
> > and I thought I did a re-compile ... but obviously not since it gives
> > 
> > error: ‘p’ undeclared (first use in this function)
> > 
> > Option a) (just like kill_me_maybe)
> > 
> > struct task_struct *p = container_of(cb, struct task_struct, mce_kill_me);
> > 
> > Option b) (simpler ... not sure why PeterZ did the container_of thing
> > 
> > 	current->mce_count = 0;
> 
> Right, he says it is the canonical way to get it out of callback_head.
> I don't think current will change while the #MC handler runs but we can
> adhere to the design pattern here and do container_of() ...

Ok ... I'll use the canonical way.

But now I've run into a weird issue. I'd run some basic tests with a
dozen machine checks in each of:
1) user access
2) kernel copyin
3) futex (multiple accesses from kernel before task_work())

and it passed my tests before I posted.

But the real validation folks took my patch and found that it has
destabilized cases 1 & 2 (and case 3 also chokes if you repeat a few
more times). System either hangs or panics. Generally before 100
injection/conumption cycles.

Their tests are still just doing one at a time (i.e. complete recovery
of one machine cehck before injecting the next error). So there aren't
any complicated race conditions.

So if you see anything obviously broken, let me know. Otherwise I'll
be poking around at the patch to figure out what is wrong.

-Tony
