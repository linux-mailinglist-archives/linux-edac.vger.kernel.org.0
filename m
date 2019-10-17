Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08826DB93C
	for <lists+linux-edac@lfdr.de>; Thu, 17 Oct 2019 23:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395408AbfJQVoz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 17 Oct 2019 17:44:55 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44820 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395390AbfJQVoz (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 17 Oct 2019 17:44:55 -0400
Received: from zn.tnic (p200300EC2F0EE500329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:e500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3CF791EC0C1A;
        Thu, 17 Oct 2019 23:44:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1571348694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=gnGwV92zKukvARTtIcUF/OXiJC7etedGc0TNeSv8oLE=;
        b=FrXJcpQDQHRo8Ej5Z2vB80z1sqMWrOU9V2d4rV1g895DQZ9b+J9RYN/FZt0tB1lYAb34M2
        zEVPx0mAppReB1VcbjRnnmpfMrfUuw5tzKGTyARoDmcTn5Hj0tnxPnjY8h463Q7IZrnBJI
        o6wnIvL+Y1+Xz9G2MRxf7Ni1GTv/wkY=
Date:   Thu, 17 Oct 2019 23:44:45 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
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
Message-ID: <20191017214445.GG14441@zn.tnic>
References: <2c2b65c23be3064504566c5f621c1f37bf7e7326.camel@redhat.com>
 <20191014212101.25719-1-srinivas.pandruvada@linux.intel.com>
 <20191015084833.GD2311@hirez.programming.kicks-ass.net>
 <f481b4ab6dfebbc0637c843e5f1cd4ddfd4bd60b.camel@linux.intel.com>
 <20191016081405.GO2328@hirez.programming.kicks-ass.net>
 <20191016140001.GF1138@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7F4A57D0@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F4A57D0@ORSMSX115.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Oct 17, 2019 at 09:31:30PM +0000, Luck, Tony wrote:
> That sounds like the right short term action.
> 
> Depending on what we end up with from Srinivas ... we may want
> to reconsider the severity.  The basic premise of Srinivas' patch
> is to avoid printing anything for short excursions above temperature
> threshold. But the effect of that is that when we find the core/package
> staying above temperature for an extended period of time, we are
> in a serious situation where some action may be needed. E.g.
> move the laptop off the soft surface that is blocking the air vents.

I don't think having a critical severity message is nearly enough.
There are cases where the users simply won't see that message, no shell
opened, nothing scanning dmesg, nothing pops up on the desktop to show
KERN_CRIT messages, etc.

If we really wanna handle this case then we must be much more reliable:

* we throttle the machine from within the kernel - whatever that may mean
* if that doesn't help, we stop scheduling !root tasks
* if that doesn't help, we halt
* ...

These are purely hypothetical things to do but I'm pointing them out as
an example that in a high temperature situation we should be actively
doing something and not wait for the user to do that.

Come to think of it, one can apply the same type of logic here and split
the temp severity into action-required events and action-optional events
and then depending on the type, we do things.

Now what those things are, should be determined by the severity of the
events. Which would mean, we'd need to know how severe those events are.
And since this is left in the hands of the OEMs, good luck to us. ;-\

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
