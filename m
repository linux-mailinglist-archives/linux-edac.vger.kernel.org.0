Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3E3F121C41
	for <lists+linux-edac@lfdr.de>; Mon, 16 Dec 2019 22:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfLPV7b (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 16 Dec 2019 16:59:31 -0500
Received: from mga09.intel.com ([134.134.136.24]:38375 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbfLPV7b (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 16 Dec 2019 16:59:31 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 13:59:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,323,1571727600"; 
   d="scan'208";a="221590880"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga001.fm.intel.com with ESMTP; 16 Dec 2019 13:59:28 -0800
Date:   Mon, 16 Dec 2019 13:59:24 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jan =?iso-8859-1?Q?H=2E_Sch=F6nherr?= <jschoenh@amazon.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        linux-edac@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH 0/6] x86/mce: Various fixes and cleanups for MCE handling
Message-ID: <20191216215924.GA27474@agluck-desk2.amr.corp.intel.com>
References: <20191210000733.17979-1-jschoenh@amazon.de>
 <20191211002519.GA30513@agluck-desk2.amr.corp.intel.com>
 <d8e11387-c84a-f333-7ea5-f9043af6375e@amazon.de>
 <20191216165207.GC17380@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191216165207.GC17380@zn.tnic>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Dec 16, 2019 at 05:52:07PM +0100, Borislav Petkov wrote:
> On Thu, Dec 12, 2019 at 01:25:31PM +0100, Jan H. Schönherr wrote:
> > This and names like "uncorrected_memory_error_notifier()" seem to imply
> > a wider scope than the function actually has. That brings me to another
> > question: should the scope be wider?
> > 
> > Instead of filtering for usable addresses and specific severities, we
> > could for example filter for (similar to cec_add_mce()):
> > 
> >   mce_is_memory_error(m) &&
> >   !mce_is_correctable(m) &&
> >   mce_usable_address(m)
> 
> There's a comment above that code which says what that function wants:
> 
> 	/* We eat only correctable DRAM errors with usable addresses. */
> 
> > Would that make sense? Or does that violate anything, that I'm not aware of?
> 
> So this should be a decision of the two CPU vendors basically answering
> the question: for which error severities you want the kernel to poison
> pages?
> 
> Basically a question for Tony and Yazen. CCed.

Using Intel naming, I'd like the SRAO and UCNA severity uncorrected
errors to take the soft offline path to stop using pages.

-Tony
