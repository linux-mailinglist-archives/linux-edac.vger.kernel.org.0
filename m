Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E327303CCF
	for <lists+linux-edac@lfdr.de>; Tue, 26 Jan 2021 13:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391617AbhAZMU0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 26 Jan 2021 07:20:26 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45494 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404808AbhAZLED (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 26 Jan 2021 06:04:03 -0500
Received: from zn.tnic (p200300ec2f0d1100bcf83db545f09974.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:1100:bcf8:3db5:45f0:9974])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E5C5B1EC0489;
        Tue, 26 Jan 2021 12:03:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611659002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tiQkhcnWuZdn5X9oPDPW3rCwLMKMfMLwbCk6VKHAF2I=;
        b=AhNXt0XHrQH42H8ykgj6NEbys6yGfw4nO/wk2778ysY3EG/dlS4SZoXqK1OQskhDzRmRvg
        tWbQl7k+NieG2iA9G6IzW9mnsH50M6Phancy2LdSzoEgOk4+aUfgfkNgT0z0myUnQlMdLz
        zjQH4MYuSvOqtXINl5nIuZmMMqH5pB8=
Date:   Tue, 26 Jan 2021 12:03:14 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v5] x86/mce: Avoid infinite loop for copy from user
 recovery
Message-ID: <20210126110314.GC6514@zn.tnic>
References: <20210115003817.23657-1-tony.luck@intel.com>
 <20210115152754.GC9138@zn.tnic>
 <20210115193435.GA4663@agluck-desk2.amr.corp.intel.com>
 <20210115205103.GA5920@agluck-desk2.amr.corp.intel.com>
 <20210115232346.GA7967@agluck-desk2.amr.corp.intel.com>
 <20210119105632.GF27433@zn.tnic>
 <20210119235759.GA9970@agluck-desk2.amr.corp.intel.com>
 <20210120121812.GF825@zn.tnic>
 <20210121210959.GA10304@agluck-desk2.amr.corp.intel.com>
 <20210125225509.GA7149@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210125225509.GA7149@agluck-desk2.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jan 25, 2021 at 02:55:09PM -0800, Luck, Tony wrote:
> And now I've changed it back to non-atomic (but keeping the
> slightly cleaner looking code style that I used for the atomic
> version).  This one also works for thousands of injections and
> recoveries.  Maybe take it now before it stops working again :-)

Hmm, so the only differences I see between your v4 and this are:

-@@ -1238,6 +1238,7 @@ static void __mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *fin
+@@ -1238,6 +1238,9 @@ static void __mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *fin
  
  static void kill_me_now(struct callback_head *ch)
  {
++	struct task_struct *p = container_of(ch, struct task_struct, mce_kill_me);
++
 +	p->mce_count = 0;
  	force_sig(SIGBUS);
  }

Could the container_of() macro have changed something?

Because we don't know yet (right?) why would it fail? Would it read
stale ->mce_count data? If so, then a barrier is missing somewhere.

Or what is the failure exactly?

Because if I take it now without us knowing what the issue is, it will
start failing somewhere - Murphy's our friend - and then we'll have to
deal with breaking people's boxes. Not fun.

The other difference is:

@@ -76,8 +71,10 @@ index 13d3f1cbda17..5460c146edb5 100644
 -	current->mce_kflags = m->kflags;
 -	current->mce_ripv = !!(m->mcgstatus & MCG_STATUS_RIPV);
 -	current->mce_whole_page = whole_page(m);
++	int count = ++current->mce_count;
++
 +	/* First call, save all the details */
-+	if (current->mce_count++ == 0) {
++	if (count == 1) {
 +		current->mce_addr = m->addr;
 +		current->mce_kflags = m->kflags;
 +		current->mce_ripv = !!(m->mcgstatus & MCG_STATUS_RIPV);

Hmm, a local variable and a pre-increment. Can that have an effect somehow?

> +	/* Ten is likley overkill. Don't expect more than two faults before task_work() */

Typo: likely.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
