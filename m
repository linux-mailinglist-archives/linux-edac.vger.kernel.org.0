Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC5A479287
	for <lists+linux-edac@lfdr.de>; Fri, 17 Dec 2021 18:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239698AbhLQRNl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 17 Dec 2021 12:13:41 -0500
Received: from mga05.intel.com ([192.55.52.43]:14809 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239702AbhLQRNl (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 17 Dec 2021 12:13:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639761221; x=1671297221;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SX/r6niEbIpbvqmzbfR8jaqmQcZv+84O1KgVGiU0qww=;
  b=lU0G+nzYf2GDTudqJm4a0miIsKKjxOP9KWGx14tfqlX633xLq9QYfaB6
   BDCe9n4MyLwEpw7klnNNNYRKlJHwZlrifMFWH9MIJ55c/3ZbffXobrvtJ
   V50qUp4QNGchVPSTxgBkQqkZNb5EbEaAdjMxgudkQEYhtAbZsNH2U0IxO
   3iQg3k3hH77aQFj+UUccoZCwynWPmII1EoSxkSH++bvC6L8uMUh6pd6CM
   938uT+R5B1i0pGZY6zHjG26A8n9g630qNSagbOHj4mX5QZoyBi5fvmeLH
   Bs9eU1/7Rb8l4RZ0wJ+TFD+E4kHi2/nmhK4Jn4OeJCVbkRWmci0cSEg1v
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="326083627"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="326083627"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 09:13:40 -0800
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="683451552"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 09:13:40 -0800
Date:   Fri, 17 Dec 2021 09:13:39 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-edac@vger.kernel.org
Subject: Re: [bug report] x86/mce: Prevent severity computation from being
 instrumented
Message-ID: <YbzFQ40JUftkpeKi@agluck-desk2.amr.corp.intel.com>
References: <20211217102029.GA29708@kili>
 <Ybx0qV3S61Hjj+jw@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ybx0qV3S61Hjj+jw@zn.tnic>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Dec 17, 2021 at 12:29:45PM +0100, Borislav Petkov wrote:
> + Tony.
> 
> On Fri, Dec 17, 2021 at 01:20:29PM +0300, Dan Carpenter wrote:
> > Hello Borislav Petkov,
> > 
> > This is a semi-automatic email about new static checker warnings.
> > 
> > The patch 0a5b288e85bb: "x86/mce: Prevent severity computation from
> > being instrumented" from Oct 13, 2021, leads to the following Smatch
> > complaint:
> > 
> >     arch/x86/kernel/cpu/mce/severity.c:286 error_context()
> >     warn: variable dereferenced before check 'regs' (see line 280)
> > 
> > arch/x86/kernel/cpu/mce/severity.c
> >    279		fixup_type = ex_get_fixup_type(m->ip);
> >    280		copy_user  = is_copy_from_user(regs);
> >                                                ^^^^
> > New unchecked dereference
> > 
> >    281		instrumentation_end();
> >    282	
> >    283		switch (fixup_type) {
> >    284		case EX_TYPE_UACCESS:
> >    285		case EX_TYPE_COPY:
> >    286			if (!regs || !copy_user)
> >                              ^^^^
> > Old code checked for NULL
> > 
> >    287				return IN_KERNEL;
> >    288			m->kflags |= MCE_IN_KERNEL_COPYIN;
> 
> Good catch, thanks!
> 
> I guess we can do something like this:
> 
> ---
> diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
> index a32646769705..7aa2bda93cbb 100644
> --- a/arch/x86/kernel/cpu/mce/severity.c
> +++ b/arch/x86/kernel/cpu/mce/severity.c
> @@ -222,6 +222,9 @@ static bool is_copy_from_user(struct pt_regs *regs)
>  	struct insn insn;
>  	int ret;
>  
> +	if (!regs)
> +		return false;
> +
>  	if (copy_from_kernel_nofault(insn_buf, (void *)regs->ip, MAX_INSN_SIZE))
>  		return false;
>  
> @@ -283,7 +286,7 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
>  	switch (fixup_type) {
>  	case EX_TYPE_UACCESS:
>  	case EX_TYPE_COPY:
> -		if (!regs || !copy_user)
> +		if (!copy_user)
>  			return IN_KERNEL;
>  		m->kflags |= MCE_IN_KERNEL_COPYIN;
>  		fallthrough;
> 

Looks good to me.

Reviewed-by: Tony Luck <tony.luck@intel.com>

-Tony
