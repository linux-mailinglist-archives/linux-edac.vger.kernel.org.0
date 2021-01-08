Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF6F2EFB56
	for <lists+linux-edac@lfdr.de>; Fri,  8 Jan 2021 23:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbhAHWsR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 8 Jan 2021 17:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbhAHWsR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 8 Jan 2021 17:48:17 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A59C061757;
        Fri,  8 Jan 2021 14:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y6utkV8+rnLd3kCaXRS1gntJ/Qt+RxB06NgyDB05tsQ=; b=cWZ2NApOkgotnnOjxHpSpSy41f
        QBDtpEdN6cXwaoS+nil5TbeOvdq7tGHv0fAA5n+xeWL4divsAEgYZuT9I3hjz7AsLMYZKv2VuwTdu
        EdtYBgK0jHYipoTeq3UvKbLlStfuTVu+b4OgnnmDI2ika+Ee7+a2dZg6Gfij4xdofckqeD5EOxjOb
        93vnwdD/6UnmcHpBPnSKgDcX3f9vpqqtDT4/iE5sBWH+Jkyney2V7HACZeK7VWa4A5BqdoYMnXsGN
        eWto8aD02c5iegGv1szt7ghMaD7SmGYctTFWTc3u83YnlcU2xu/EoFN1rjM85EUrEVohihkEfjMk0
        mpzXX7kw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ky0XR-0003Uq-KF; Fri, 08 Jan 2021 22:47:21 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 05F819866B1; Fri,  8 Jan 2021 23:47:15 +0100 (CET)
Date:   Fri, 8 Jan 2021 23:47:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/2] futex, x86/mce: Avoid double machine checks
Message-ID: <20210108224715.GB2453@worktop.programming.kicks-ass.net>
References: <20210108222251.14391-1-tony.luck@intel.com>
 <20210108222251.14391-3-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108222251.14391-3-tony.luck@intel.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jan 08, 2021 at 02:22:51PM -0800, Tony Luck wrote:
> futex_wait_setup() first tries to read the user value with page faults
> disabled (because it holds a lock, and so cannot sleep). If that read
> fails it drops the lock and tries again.
> 
> But there are now two reasons why the user space read can fail. Either:
> 1) legacy case of a page fault, in which case it is reasonable to retry
> 2) machine check on the user address, bad idea to re-read
> 
> Add some infrastructure to differentiate these cases.

> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -2658,6 +2658,9 @@ static int futex_wait_setup(u32 __user *uaddr, u32 val, unsigned int flags,
>  	if (ret) {
>  		queue_unlock(*hb);
>  
> +		if (arch_memory_failure(uaddr))
> +			return ret;
> +
>  		ret = get_user(uval, uaddr);
>  		if (ret)
>  			return ret;


I think this is horrid; why can't we have it return something different
then -EFAULT instead?
