Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDD330AFE6
	for <lists+linux-edac@lfdr.de>; Mon,  1 Feb 2021 19:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhBAS65 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 1 Feb 2021 13:58:57 -0500
Received: from mga18.intel.com ([134.134.136.126]:6649 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229525AbhBAS65 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 1 Feb 2021 13:58:57 -0500
IronPort-SDR: ND+JUAAq/NXObHbjQ2C3T56i91o5HTdqmiijjVNVWURLw6PA9KWsE7JNtCNvLZyhZxbqN0hGbe
 4CsBBW6vvFug==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="168416070"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="168416070"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 10:58:14 -0800
IronPort-SDR: mFCnqgrFuZMebcpZHoL5TJBZXYtUQmrYnBnXWFsNcJDi+zpaRIvoqXbnuPVNBNTAz0/krOjbvW
 K27HBSXRh24A==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="355881295"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 10:58:13 -0800
Date:   Mon, 1 Feb 2021 10:58:12 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v5] x86/mce: Avoid infinite loop for copy from user
 recovery
Message-ID: <20210201185812.GA54867@agluck-desk2.amr.corp.intel.com>
References: <20210115205103.GA5920@agluck-desk2.amr.corp.intel.com>
 <20210115232346.GA7967@agluck-desk2.amr.corp.intel.com>
 <20210119105632.GF27433@zn.tnic>
 <20210119235759.GA9970@agluck-desk2.amr.corp.intel.com>
 <20210120121812.GF825@zn.tnic>
 <20210121210959.GA10304@agluck-desk2.amr.corp.intel.com>
 <20210125225509.GA7149@agluck-desk2.amr.corp.intel.com>
 <20210126110314.GC6514@zn.tnic>
 <20210126223605.GA14355@agluck-desk2.amr.corp.intel.com>
 <20210128175735.GB2120@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128175735.GB2120@zn.tnic>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jan 28, 2021 at 06:57:35PM +0100, Borislav Petkov wrote:
> Crazy idea: if you still can reproduce on -rc3, you could bisect: i.e.,
> if you apply the patch on -rc3 and it explodes and if you apply the same
> patch on -rc5 and it works, then that could be a start... Yeah, don't
> have a better idea here. :-\

I tried reporoducing (applied the original patch I posted back to -rc3) and
the same issue stubbornly refused to show up again.

But I did hit something with the same signature (overflow bit set in
bank 1) while running my futex test (which has two processes mapping
the poison page).  This time I *do* understand what happened.  The test
failed when the two processes were running on the two hyperhtreads of
the same core. Seeing overflow in this case is understandable because
bank 1 MSRs on my test machine are shared between the HT threads. When
I run the test again using taskset(1) to only allowing running on
thread 0 of each core, it keeps going for hunderds of iterations.

I'm not sure I can stitch together how this overflow also happened for
my single process test. Maybe a migration from one HT thread to the
other at an awkward moment?

-Tony
