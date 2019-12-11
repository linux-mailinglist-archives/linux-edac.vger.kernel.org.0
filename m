Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1E9A119FE0
	for <lists+linux-edac@lfdr.de>; Wed, 11 Dec 2019 01:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfLKAZV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 10 Dec 2019 19:25:21 -0500
Received: from mga18.intel.com ([134.134.136.126]:52541 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbfLKAZU (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 10 Dec 2019 19:25:20 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2019 16:25:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,301,1571727600"; 
   d="scan'208";a="215740418"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga003.jf.intel.com with ESMTP; 10 Dec 2019 16:25:19 -0800
Date:   Tue, 10 Dec 2019 16:25:19 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Jan =?iso-8859-1?Q?H=2E_Sch=F6nherr?= <jschoenh@amazon.de>
Cc:     Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH 0/6] x86/mce: Various fixes and cleanups for MCE handling
Message-ID: <20191211002519.GA30513@agluck-desk2.amr.corp.intel.com>
References: <20191210000733.17979-1-jschoenh@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191210000733.17979-1-jschoenh@amazon.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Dec 10, 2019 at 01:07:27AM +0100, Jan H. Schönherr wrote:
> Hi.
> 
> Here is a series of smallish fixes/cleanups for the handling of MCEs.
> 
> Note, that except for patches 2 and 4, the patches are just compile tested.

I tried some UC injections with these patches applied. Stuff
still works. But thanks to the UCN/Deferred patch I see:

	Memory failure: 0x5fe3284: already hardware poisoned

which is expected because on Intel we see an SRAR error in bank 1
and the machine check takes the page offline.  Then we see a UCNA
from another bank for the same address and try to take the same
page offline again.

This is a return to the old behavior, but might surprise some folks.

One nit-pick - I think we should rename the srao_decode_notifier()
function since it now handles both SRAO and UCNA. Not sure what a
good name is ... something like "uc_decode_notifier()" since it takes
action for multiple classes of uncorrected errors?

All the patches look OK to me (modulo the above rename suggestion).
So consider this a "Reviewed-by" for all six.

Thanks in particular for hunting down what happened to the UCNA
action ... I was looking for it a couple of months ago and didn't
have time to complete the search.

-Tony
