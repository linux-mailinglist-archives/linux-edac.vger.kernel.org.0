Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1170422E798
	for <lists+linux-edac@lfdr.de>; Mon, 27 Jul 2020 10:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgG0IUl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Jul 2020 04:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgG0IUk (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 27 Jul 2020 04:20:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53E7C061794;
        Mon, 27 Jul 2020 01:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xrG0BU7yIGWs9jDgU0K3JJbw4oVcEokGuvUv9xL/Y+0=; b=VUKFfiR/zbbxIyGNnxZj0pzr6Z
        K/xgwWX+t2geF5XQZh0ZuwnqKTr7OSZ42+Qv8zFCHNzpdJ0wPQlgTab/9NUIvfrAxkSp0mrDpDGCR
        ji1OvOivtcDDbR/waecBHPT5mHIqLOz9lmROBF6mO0Vp6zC2UsqgVnfiVBqvS+IJBM+/f4o4LYirI
        13ylsHczcXzOdEXT9/okYDS8ZxMuOBhqDCLWfLpVC0zrtRPE0jx4+4ytJSwIkzenUInk26c32Y1nf
        TQbltQTp34CZTwI+Z0TlTeB6VgAys27Kzcvq2UxyQHn6sjUmUqxw2tgEpPEkuCJyUk9p7bFmZ7z2p
        J9/a3LjQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzyMg-0002aV-Ht; Mon, 27 Jul 2020 08:20:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8BEE8301EE3;
        Mon, 27 Jul 2020 10:20:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 762FF2BDC8D4F; Mon, 27 Jul 2020 10:20:03 +0200 (CEST)
Date:   Mon, 27 Jul 2020 10:20:03 +0200
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
Message-ID: <20200727082003.GD119549@hirez.programming.kicks-ass.net>
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
> +static inline void serialize(void)
> +{
> +	asm volatile(".byte 0xf, 0x1, 0xe8");
> +}

Can we pretty please have a comment with the binutils version that has
the mnomic? Such that when we increase the required binutils version we
can grep for this.
