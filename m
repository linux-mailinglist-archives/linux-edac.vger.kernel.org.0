Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26D5EDCF88
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2019 21:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394967AbfJRTpG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 18 Oct 2019 15:45:06 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51604 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390538AbfJRTpG (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 18 Oct 2019 15:45:06 -0400
Received: from zn.tnic (p200300EC2F0DFC00B10F655CBDDB26D7.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:fc00:b10f:655c:bddb:26d7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 38D341EC0CE2;
        Fri, 18 Oct 2019 21:45:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1571427905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bqqMYBGGMf2TyWw1T2TB93J5v/cN7UWzlq77s4/kdIk=;
        b=BIR8VSbtU1LQQuslMHrzpIZV0kYwWUnop0056+Z6JWV4tegrtlMwlOWdFxGVnGdKHyIgs5
        CqgfY7irKwxnWiTdjDvEK3jc5dBCqhYPJ8eMlQxnVt2XkQYtCBv2OFE5C7WTlzF0tP4Fk4
        c4MqudItEJeUArCuI9DvwbaM9uw8pkA=
Date:   Fri, 18 Oct 2019 21:45:03 +0200
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
Message-ID: <20191018194503.GF17053@zn.tnic>
References: <20191014212101.25719-1-srinivas.pandruvada@linux.intel.com>
 <20191015084833.GD2311@hirez.programming.kicks-ass.net>
 <f481b4ab6dfebbc0637c843e5f1cd4ddfd4bd60b.camel@linux.intel.com>
 <20191016081405.GO2328@hirez.programming.kicks-ass.net>
 <20191016140001.GF1138@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7F4A57D0@ORSMSX115.amr.corp.intel.com>
 <20191017214445.GG14441@zn.tnic>
 <c2ce4ef128aad84616b2dc21f6230ad4db12194b.camel@linux.intel.com>
 <20191018132309.GD17053@zn.tnic>
 <20191018180257.GA23835@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191018180257.GA23835@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Oct 18, 2019 at 11:02:57AM -0700, Luck, Tony wrote:
> So what should we do next?

I was simply keying off this statement of yours:

"Depending on what we end up with from Srinivas ... we may want to
reconsider the severity."

and I don't think that having KERN_CRIT severity for those messages
makes any sense. That's why I was hinting at us organizing and defining
our handling of thermal interrupt events properly so that we handle
those things correctly and not have people look at dmesg.

> I don't think there is much by way of actions that the kernel should
> take. While we could stop scheduling processes, the h/w and f/w have
> better tools to reduce frequency, inject idle cycles, speed up fans,
> etc. If you do have ideas ... then please share.

See above. All resulted from me stating that KERN_CRIT messages or any
type of messages in dmesg as a result of hitting thermal limits are
useless. If we wanna handle those properly, then we need to do something
else.

> Proposal on the table is the algoritm embodied in Srinivas'
> patch (which originated from Alan Cox).

I think we agree on doing the dynamic threshold determination, no?

If, as Srinivas points out in another mail, the purpose of those
messages is when one wants to examine what happened, then fine. If we
must do more, then see above.

Does that make more sense?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
