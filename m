Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBA74DD748
	for <lists+linux-edac@lfdr.de>; Sat, 19 Oct 2019 10:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfJSILB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 19 Oct 2019 04:11:01 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43956 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbfJSILB (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 19 Oct 2019 04:11:01 -0400
Received: from zn.tnic (p200300EC2F1CBC00F4835101EE48AEFC.dip0.t-ipconnect.de [IPv6:2003:ec:2f1c:bc00:f483:5101:ee48:aefc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 221661EC0691;
        Sat, 19 Oct 2019 10:11:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1571472660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=K6Jnijv0GF9GtTGOao4625yORkxoPksBDwnhh0jkkzo=;
        b=MydynZs793094o6Fk3fETBioEXYjO8YHjHFsGrN2f/QnNpGbNvRbVW0rQV+qr5P1s5EC+I
        m4PujFN3SMXZCO5CkiQVhtLWZD+Gj2ZPiB/Dr3h2FPyM3tdyP0QwRCwcoW1uAbnJicD/lC
        AuBBvuZygKeHsTsVrfOsIR5glfLe768=
Date:   Sat, 19 Oct 2019 10:10:53 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
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
Message-ID: <20191019081001.GA5571@zn.tnic>
References: <f481b4ab6dfebbc0637c843e5f1cd4ddfd4bd60b.camel@linux.intel.com>
 <20191016081405.GO2328@hirez.programming.kicks-ass.net>
 <20191016140001.GF1138@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7F4A57D0@ORSMSX115.amr.corp.intel.com>
 <20191017214445.GG14441@zn.tnic>
 <c2ce4ef128aad84616b2dc21f6230ad4db12194b.camel@linux.intel.com>
 <20191018132309.GD17053@zn.tnic>
 <20191018180257.GA23835@agluck-desk2.amr.corp.intel.com>
 <20191018194503.GF17053@zn.tnic>
 <20191018203832.GA25033@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191018203832.GA25033@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Oct 18, 2019 at 01:38:32PM -0700, Luck, Tony wrote:
> Sorry to have caused confusion.

Ditto. But us causing confusion is fine - this way we can talk about
what we really wanna do!

:-)))

> The thoughts behind that statement are that we currently have an issue
> with too many noisy high severity messages. The interim solution we
> are going with is to downgrade the severity. But if we apply a time
> based filter to remove most of the noise by not printing at all, maybe
> what we have left is a very small number of high severity messages.
>
> But that's completely up for debate.

Well, I think those messages being pr_warn are fine if one wants to
inspect dmesg for signs of overheating and the platform is hitting some
thermal limits.

And if the time-based filter is not too accurate, that's fine too, I
guess, as long as we don't flood dmesg.

What I don't like is the command line parameter and us putting the onus
on the user to decide although we have all that info in the kernel
already and we can do that decision automatically.

> I agree it is a good thing to look at. I'm not so sure we will find
> a good enough method that works all the way from tablet to server,
> so we might end up with "#define MAX_THERM_TIME 8000" ... but some
> study of options would either turn up a good heuristic, or provide
> evidence for why that is either hard, or no better than a constant.

Yeah, I still think a simple avg filter which starts from a sufficiently
high value and improves it over time, should be good enough.

Hell, even the trivial formula we use in the CMCI interrupt for polling,
might work, where we either double the interval or halve it, depending
on recent history.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
