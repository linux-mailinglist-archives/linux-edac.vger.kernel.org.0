Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 170A7DC5EC
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2019 15:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408343AbfJRNXQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 18 Oct 2019 09:23:16 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40986 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729109AbfJRNXQ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 18 Oct 2019 09:23:16 -0400
Received: from zn.tnic (p200300EC2F0DFC0011F9759EEC3CB6D6.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:fc00:11f9:759e:ec3c:b6d6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 059F51EC0CDC;
        Fri, 18 Oct 2019 15:23:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1571404995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hGJH9IKQI0kAp38EPHa1zW1Ve0qBcIXzrKBpue0iOxU=;
        b=gK5ZY45vSzgvsu4HJ3sEYU4iV0N9mX64qn1bEb/sfeCSjUbo7nobIj85ceJ0bPqC6aP9M9
        fBbKoAGHZoajzMefLChs3I+XXPnJa14q8nCjeoDx4UirVardzd4t+bx7Ki2wXpBYMfF4lr
        NCKj/dHavKR/u2YAmTcXC0fSNX5y6dg=
Date:   Fri, 18 Oct 2019 15:23:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "bberg@redhat.com" <bberg@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "ckellner@redhat.com" <ckellner@redhat.com>
Subject: Re: [PATCH 1/2] x86, mce, therm_throt: Optimize logging of thermal
 throttle messages
Message-ID: <20191018132309.GD17053@zn.tnic>
References: <2c2b65c23be3064504566c5f621c1f37bf7e7326.camel@redhat.com>
 <20191014212101.25719-1-srinivas.pandruvada@linux.intel.com>
 <20191015084833.GD2311@hirez.programming.kicks-ass.net>
 <f481b4ab6dfebbc0637c843e5f1cd4ddfd4bd60b.camel@linux.intel.com>
 <20191016081405.GO2328@hirez.programming.kicks-ass.net>
 <20191016140001.GF1138@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7F4A57D0@ORSMSX115.amr.corp.intel.com>
 <20191017214445.GG14441@zn.tnic>
 <c2ce4ef128aad84616b2dc21f6230ad4db12194b.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c2ce4ef128aad84616b2dc21f6230ad4db12194b.camel@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Oct 18, 2019 at 05:26:36AM -0700, Srinivas Pandruvada wrote:
> Server/desktops generally rely on the embedded controller for FAN
> control, which  kernel have no control. For them this warning helps to
> either bring in additional cooling or fix existing cooling.

How exactly does this warning help? A detailed example please.

> If something needs to force throttle from kernel, then we should use
> some offset from the max temperature (aka TJMax), instead of this
> warning threshold. Then we can use idle injection or change duty cycle
> of CPU clocks.

Yes, as I said, all this needs to be properly defined first. That is,
*if* there's even need for reacting to thermal interrupts in the kernel.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
