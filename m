Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1246112FE69
	for <lists+linux-edac@lfdr.de>; Fri,  3 Jan 2020 22:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbgACVmb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 3 Jan 2020 16:42:31 -0500
Received: from mga11.intel.com ([192.55.52.93]:35860 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728664AbgACVmb (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 3 Jan 2020 16:42:31 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2020 13:42:31 -0800
X-IronPort-AV: E=Sophos;i="5.69,392,1571727600"; 
   d="scan'208";a="421549597"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2020 13:42:31 -0800
Date:   Fri, 3 Jan 2020 13:42:29 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Jan =?iso-8859-1?Q?H=2E_Sch=F6nherr?= <jschoenh@amazon.de>
Cc:     Borislav Petkov <bp@alien8.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH v2 6/6] x86/mce: Dynamically register default MCE handler
Message-ID: <20200103214229.GA10677@agluck-desk2.amr.corp.intel.com>
References: <20200103150722.20313-1-jschoenh@amazon.de>
 <20200103150722.20313-7-jschoenh@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200103150722.20313-7-jschoenh@amazon.de>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jan 03, 2020 at 04:07:22PM +0100, Jan H. Schönherr wrote:
> The default MCE handler takes action, when no external MCE handler is
> registered. Instead of checking for external handlers within the default
> MCE handler, only register the default MCE handler when there are no
> external handlers in the first place.
> 
> Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
> ---
> New in v2. This is something that became possible due to patch 4.
> I'm not entirely happy with it.
> 
> One the one hand, I'm wondering whether there's a nicer way to handle
> (de-)registration races.
> 

Instead of unregistering/registering the default notifier depending
on whether there are other notifiers, couldn't you just make the
default notifier check to see if it should print. E.g.

static int mce_default_notifier(struct notifier_block *nb, unsigned long val,
			void *data)
{
	struct mce *m = (struct mce *)data;

	if (m && !atomic_read(&num_notifiers))
		__print_mce(m);

	return NOTIFY_DONE;
}

> On the other hand, I'm starting to question the whole logic to "only print
> the MCE if nothing else in the kernel has a handler registered". Is that
> really how it should be? For example, there are handlers that filter for a
> specific subset of MCEs. If one of those is registered, we're losing all
> information for MCEs that don't match.

Maybe put control of this into the hands of the notifiers ... if
a notifier thinks that it does something useful with the log
that makes the console log redundant, then it could call a function
to bump the count to suppress the __print_mce(). Simple filter functions
on the chain wouldn't do that.

If we go this path the variable should be named something like
"suppress_console_mce" rather than num_notifiers.

Might also be useful to have some command line option or debugfs knob
to force printing for those cases where bad stuff is happening and we
don't see what was logged before a crash drops all the bits on the floor.

-Tony
