Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFF92FC398
	for <lists+linux-edac@lfdr.de>; Tue, 19 Jan 2021 23:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389600AbhASOhv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 19 Jan 2021 09:37:51 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39556 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732603AbhASK5T (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 19 Jan 2021 05:57:19 -0500
Received: from zn.tnic (p200300ec2f0bca00c2aa0e949335efb7.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:ca00:c2aa:e94:9335:efb7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 91FEF1EC05DD;
        Tue, 19 Jan 2021 11:56:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611053792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rCir/nAqMuATcSo3nza+fGR+2FWhLGn2xxPdAjuV8tE=;
        b=fB0hmIsZJxjjgz1H87jtFUaF+J4zpP0lN4z551FDlWXQWl88afoJXgJdKH8fLaFem1IBAN
        eCvZJnB/T8SSneqQkPdNpcezGYy7gBbe0PpaR6KvE/EF3lryYyIG47t/HvEhJSCSpi61TJ
        CwQn7IZ9YkFwV8nipIEOmcQtfKuG5nU=
Date:   Tue, 19 Jan 2021 11:56:32 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v4] x86/mce: Avoid infinite loop for copy from user
 recovery
Message-ID: <20210119105632.GF27433@zn.tnic>
References: <20210111214452.1826-1-tony.luck@intel.com>
 <20210115003817.23657-1-tony.luck@intel.com>
 <20210115152754.GC9138@zn.tnic>
 <20210115193435.GA4663@agluck-desk2.amr.corp.intel.com>
 <20210115205103.GA5920@agluck-desk2.amr.corp.intel.com>
 <20210115232346.GA7967@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210115232346.GA7967@agluck-desk2.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jan 15, 2021 at 03:23:46PM -0800, Luck, Tony wrote:
> On Fri, Jan 15, 2021 at 12:51:03PM -0800, Luck, Tony wrote:
> >  static void kill_me_now(struct callback_head *ch)
> >  {
> > +	p->mce_count = 0;
> >  	force_sig(SIGBUS);
> >  }
> 
> Brown paper bag time ... I just pasted that line from kill_me_maybe()
> and I thought I did a re-compile ... but obviously not since it gives
> 
> error: ‘p’ undeclared (first use in this function)
> 
> Option a) (just like kill_me_maybe)
> 
> struct task_struct *p = container_of(cb, struct task_struct, mce_kill_me);
> 
> Option b) (simpler ... not sure why PeterZ did the container_of thing
> 
> 	current->mce_count = 0;

Right, he says it is the canonical way to get it out of callback_head.
I don't think current will change while the #MC handler runs but we can
adhere to the design pattern here and do container_of() ...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
