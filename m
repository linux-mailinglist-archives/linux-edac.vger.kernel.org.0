Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0ACDD07F
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2019 22:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731326AbfJRUid (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 18 Oct 2019 16:38:33 -0400
Received: from mga12.intel.com ([192.55.52.136]:52439 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389932AbfJRUid (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 18 Oct 2019 16:38:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Oct 2019 13:38:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,312,1566889200"; 
   d="scan'208";a="196302348"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga007.fm.intel.com with ESMTP; 18 Oct 2019 13:38:32 -0700
Date:   Fri, 18 Oct 2019 13:38:32 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "bberg@redhat.com" <bberg@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "ckellner@redhat.com" <ckellner@redhat.com>
Subject: Re: [PATCH 1/2] x86, mce, therm_throt: Optimize logging of thermal
 throttle messages
Message-ID: <20191018203832.GA25033@agluck-desk2.amr.corp.intel.com>
References: <20191015084833.GD2311@hirez.programming.kicks-ass.net>
 <f481b4ab6dfebbc0637c843e5f1cd4ddfd4bd60b.camel@linux.intel.com>
 <20191016081405.GO2328@hirez.programming.kicks-ass.net>
 <20191016140001.GF1138@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7F4A57D0@ORSMSX115.amr.corp.intel.com>
 <20191017214445.GG14441@zn.tnic>
 <c2ce4ef128aad84616b2dc21f6230ad4db12194b.camel@linux.intel.com>
 <20191018132309.GD17053@zn.tnic>
 <20191018180257.GA23835@agluck-desk2.amr.corp.intel.com>
 <20191018194503.GF17053@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018194503.GF17053@zn.tnic>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Oct 18, 2019 at 09:45:03PM +0200, Borislav Petkov wrote:
> On Fri, Oct 18, 2019 at 11:02:57AM -0700, Luck, Tony wrote:
> > So what should we do next?
> 
> I was simply keying off this statement of yours:
> 
> "Depending on what we end up with from Srinivas ... we may want to
> reconsider the severity."
> 
> and I don't think that having KERN_CRIT severity for those messages
> makes any sense. That's why I was hinting at us organizing and defining
> our handling of thermal interrupt events properly so that we handle
> those things correctly and not have people look at dmesg.

Sorry to have caused confusion. The thoughts behind that statement
are that we currently have an issue with too many noisy high severity
messages.  The interim solution we are going with is to downgrade
the severity.  But if we apply a time based filter to remove most of
the noise by not printing at all, maybe what we have left is a very
small number of high severity messages.

But that's completely up for debate.

> I think we agree on doing the dynamic threshold determination, no?

I agree it is a good thing to look at. I'm not so sure we will find
a good enough method that works all the way from tablet to server,
so we might end up with "#define MAX_THERM_TIME 8000" ... but some
study of options would either turn up a good heuristic, or provide
evidence for why that is either hard, or no better than a constant.

> Does that make more sense?

Yes. Thanks for the clarifications.

-Tony
