Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659BF22E7A4
	for <lists+linux-edac@lfdr.de>; Mon, 27 Jul 2020 10:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgG0IX4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Jul 2020 04:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgG0IX4 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 27 Jul 2020 04:23:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CAAC061794;
        Mon, 27 Jul 2020 01:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eVJ7iMLYvYBztQgI6lzk7PXnjd4f0FDCuiAwyc2KUMU=; b=Ld5F/2GObxGjYm8R5RCxUuQYt/
        1FH1UvnOqVuIbFrhkDFL+Ja2v1A7KYYjW7eNlyEnc6PmN7qeJ5m6ZWUroYpkEeLF5x1IYdSsJ1qR+
        3m+kQhs7UtxlWvc5JUyY+lRQOrUadghJ6CHgyyTHnomFXp1J1WbQLZ++4ajnRpzv2QT8RvGdYPCYc
        AkGf42Zow+YcodrMuuv44N9PzIZKTRJKPkDdOzkQIbmtxyapl+G2qpH5MooyhG50+nr9ZrIXY73aN
        Q3MNpXxGvQ77yND9pjoJNkKzqPaujuIA8bwt/iF+iIoS7avN2fPxJKLvOxfNv1WoXKvvc8repx2fF
        ubfRyEfQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzyQE-0002iI-27; Mon, 27 Jul 2020 08:23:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4331D30411F;
        Mon, 27 Jul 2020 10:23:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CEE302BDC8D50; Mon, 27 Jul 2020 10:23:44 +0200 (CEST)
Date:   Mon, 27 Jul 2020 10:23:44 +0200
From:   peterz@infradead.org
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Cathy Zhang <cathy.zhang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kyung Min Park <kyung.min.park@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH 4/4] x86/cpu: Use SERIALIZE in sync_core() when available
Message-ID: <20200727082344.GE119549@hirez.programming.kicks-ass.net>
References: <20200727043132.15082-1-ricardo.neri-calderon@linux.intel.com>
 <20200727043132.15082-5-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727043132.15082-5-ricardo.neri-calderon@linux.intel.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Jul 26, 2020 at 09:31:32PM -0700, Ricardo Neri wrote:
> @@ -75,6 +77,12 @@ static inline void sync_core(void)
>  	 * Like all of Linux's memory ordering operations, this is a
>  	 * compiler barrier as well.
>  	 */
> +
> +	if (boot_cpu_has(X86_FEATURE_SERIALIZE)) {
> +		serialize();
> +		return;
> +	}
> +
>  	iret_to_self();

I was sorta expecting something like:

	alternative(IRET_TO_SELF, SERIALIZE, X86_FEATURE_SERIALIZE);

But instead you used boot_cpu_has() which is a dynamic test.
