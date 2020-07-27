Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED4622E7E5
	for <lists+linux-edac@lfdr.de>; Mon, 27 Jul 2020 10:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgG0Igf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Jul 2020 04:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgG0Igf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 27 Jul 2020 04:36:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35293C061794;
        Mon, 27 Jul 2020 01:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3jHDYPNEyZSDNf8t0KwCcgaWouvTTdLYFPAan9XpiKk=; b=lZUCBhCdH3I6A6wocrCmJymCJP
        Fkb1/ZtOrqdP7f+wjkm51CuCM55nKeuek7tPVOf0F/G86vyUCb4ivpVLrzze+e/Tetrd1q6pxGLX2
        KpnoCQ1LBM7CsEWFUeuJIwdKSSvKrYgK94wISM+s1KD2+0VMUJYYPoGQl4+LfWo55RqoBUSYFJp7b
        Y/tTjW7zFdAuYcWRcGciwN6B8wXRJmshlcvShtzQs3EIk78TxBilCNwFAuBqcfmFYRA9Nv2a84qDF
        tMYs5w0u9G7sz+yZT7/QRlO9oLJWMWw/gJNi5ZYWL46fBrO5CitPmos/2nnn5oZQQzpNL+EvGeGWi
        oBy3TJ4w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzycP-0003Lm-5n; Mon, 27 Jul 2020 08:36:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3B81530411F;
        Mon, 27 Jul 2020 10:36:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F0CB52B73BB17; Mon, 27 Jul 2020 10:36:19 +0200 (CEST)
Date:   Mon, 27 Jul 2020 10:36:19 +0200
From:   peterz@infradead.org
To:     hpa@zytor.com
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Cathy Zhang <cathy.zhang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Kyung Min Park <kyung.min.park@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH 4/4] x86/cpu: Use SERIALIZE in sync_core() when available
Message-ID: <20200727083619.GF119549@hirez.programming.kicks-ass.net>
References: <20200727043132.15082-1-ricardo.neri-calderon@linux.intel.com>
 <20200727043132.15082-5-ricardo.neri-calderon@linux.intel.com>
 <D51F2DC3-3C56-44E6-A1F2-434E7D27133C@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D51F2DC3-3C56-44E6-A1F2-434E7D27133C@zytor.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Jul 26, 2020 at 10:55:15PM -0700, hpa@zytor.com wrote:
> For a really overenginered solution, but which might perform
> unnecessary poorly on existing hardware:
> 
> asm volatile("1: .byte 0xf, 0x1, 0xe8; 2:"
>                         _ASM_EXTABLE(1b,2b));

Ha! cute, you take an #UD ?

We could optimize the #UD exception handler for this I suppose, but that
makes it an even worse hack. The simple alternative() seems like a much
simpler approach.
