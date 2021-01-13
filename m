Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6152F415C
	for <lists+linux-edac@lfdr.de>; Wed, 13 Jan 2021 02:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbhAMBvh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 12 Jan 2021 20:51:37 -0500
Received: from mga06.intel.com ([134.134.136.31]:54932 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbhAMBvg (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 12 Jan 2021 20:51:36 -0500
IronPort-SDR: 22a7g0/OVPrRpryXfWGqSOsa5epF8a/kTulnE0Ocvz5EiKMo79Zht7xoSN0kQmdpxYw3C1675T
 OsPuYMyVj+4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="239677222"
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400"; 
   d="scan'208";a="239677222"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 17:50:55 -0800
IronPort-SDR: ZFOkMzVU33jKa2RmLCRY0kRI4IaMNxOhu7eCj80pScZgPfEYxXJmRAHq+wZT5WNP/ndSisrTsM
 AJeGenWJBL6w==
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400"; 
   d="scan'208";a="424384839"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 17:50:54 -0800
Date:   Tue, 12 Jan 2021 17:50:53 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v2 1/3] x86/mce: Avoid infinite loop for copy from user
 recovery
Message-ID: <20210113015053.GA21587@agluck-desk2.amr.corp.intel.com>
References: <20210112205207.GA18195@agluck-desk2.amr.corp.intel.com>
 <38AF04BE-7F39-450F-8C26-879C9934E3D6@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38AF04BE-7F39-450F-8C26-879C9934E3D6@amacapital.net>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jan 12, 2021 at 02:04:55PM -0800, Andy Lutomirski wrote:
> > But we know that the fault happend in a get_user() or copy_from_user() call
> > (i.e. an RIP with an extable recovery address).  Does context switch
> > access user memory?
> 
> No, but NMI can.
> 
> The case that would be very very hard to deal with is if we get an NMI just before IRET/SYSRET and get #MC inside that NMI.
> 
> What we should probably do is have a percpu list of pending memory failure cleanups and just accept that we’re going to sometimes get a second MCE (or third or fourth) before we can get to it.
> 
> Can we do the cleanup from an interrupt?  IPI-to-self might be a credible approach, if so.

You seem to be looking for a solution that is entirely contained within
the machine check handling code. Willing to allow for repeated machine
checks from the same poison address in order to achieve that.

I'm opposed to mutliple machine checks.  Willing to make some changes
in core code to avoid repeated access to the same poison location.

We need a tie-breaker.

-Tony
