Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79142F3E1C
	for <lists+linux-edac@lfdr.de>; Wed, 13 Jan 2021 01:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393131AbhALWFu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 12 Jan 2021 17:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393047AbhALWFu (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 12 Jan 2021 17:05:50 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02ED0C0617A7
        for <linux-edac@vger.kernel.org>; Tue, 12 Jan 2021 14:04:58 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id b5so2595868pjk.2
        for <linux-edac@vger.kernel.org>; Tue, 12 Jan 2021 14:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=jp/uGViJd1rFyzqwINzBwHrML5ENBaR5RE09FM8y2rk=;
        b=o+tEsxdhzGCGsoHV1sIPiVSiNVm3QfIVPZgQqlc+JiLmlwrr+cGXF6VcEO68es1sR5
         4sjbYAIz+6YaEKlIsPnQk8QRrpepwBATzotV7rf4CMiOf++gQk+lqxVKH9egpXJwTCL6
         gKP+7N8kY+E30jdEsOcYcTtCficEYaP6PMEmbFX7nzUSo2B0UbrYxQDdRX2pO/Yb9o4+
         4N9s2VkD8ozP3B6Zmj0YpZpyxxa5e0UwbJWCZGP3We/ZOQpeUdbFwt/NL5zQ8b5Rf57o
         cHK6gDSbbSM3KeSMMbf+xAdzFvilac1HfRLY1UPA6ALiHMB9QIw3AgN1kZ5Zn0TdakUo
         /G5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=jp/uGViJd1rFyzqwINzBwHrML5ENBaR5RE09FM8y2rk=;
        b=KLZOzluv013myaBJf1gNL0lPfEWl23Nqra9ZWh6J4gyi2727lmqSzEYdDZKGfLYiN2
         e9q0V7OleG5zTYIPIonvwyudvM+2SDbk6DAOmX1+d2Rr0nUxKrO+OXt0vQxnJ/b0RVTd
         aYY5LVW5jhHi6mRYX6d814jsHdC1uHFzN7CMsbs2fLvy2WMgHnsYYNew4ZKof3wvt8cN
         WcRQ24+dFxiB5XgLkqTw4i3IQtLHDM1y4seqE5z9XlVTOVAC84cw9VwQOAD/4yVxrNek
         kZzUPPPG3OAAu/C9yvRcd9DoqIlcHSnRyFNQvmasUHbE6fHys456B8zYCwIpdaO6HPD6
         5UVQ==
X-Gm-Message-State: AOAM532QCMWhxXRR9AZfxUNjENAdH9d++N1++/UuMbSl7pC2m+1UOL74
        aAI1mDAUCG1Y0M5A7tbiFKwmMuzQpQOYUQ==
X-Google-Smtp-Source: ABdhPJy4y2gxKCe1VUOnE5Taoj0S544T+thXTxi76Iku+7ZGDndJn6pDg/pwbWqNbphh8wYmDWx1Cg==
X-Received: by 2002:a17:902:d385:b029:da:c6e4:5cab with SMTP id e5-20020a170902d385b02900dac6e45cabmr1450926pld.7.1610489097172;
        Tue, 12 Jan 2021 14:04:57 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:58cc:4dec:a37:4486? ([2601:646:c200:1ef2:58cc:4dec:a37:4486])
        by smtp.gmail.com with ESMTPSA id s1sm79453pfb.103.2021.01.12.14.04.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 14:04:56 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 1/3] x86/mce: Avoid infinite loop for copy from user recovery
Date:   Tue, 12 Jan 2021 14:04:55 -0800
Message-Id: <38AF04BE-7F39-450F-8C26-879C9934E3D6@amacapital.net>
References: <20210112205207.GA18195@agluck-desk2.amr.corp.intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
In-Reply-To: <20210112205207.GA18195@agluck-desk2.amr.corp.intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
X-Mailer: iPhone Mail (18C66)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


> On Jan 12, 2021, at 12:52 PM, Luck, Tony <tony.luck@intel.com> wrote:
>=20
> =EF=BB=BFOn Tue, Jan 12, 2021 at 10:57:07AM -0800, Andy Lutomirski wrote:
>>> On Tue, Jan 12, 2021 at 10:24 AM Luck, Tony <tony.luck@intel.com> wrote:=

>>>=20
>>> On Tue, Jan 12, 2021 at 09:21:21AM -0800, Andy Lutomirski wrote:
>>>> Well, we need to do *something* when the first __get_user() trips the
>>>> #MC.  It would be nice if we could actually fix up the page tables
>>>> inside the #MC handler, but, if we're in a pagefault_disable() context
>>>> we might have locks held.  Heck, we could have the pagetable lock
>>>> held, be inside NMI, etc.  Skipping the task_work_add() might actually
>>>> make sense if we get a second one.
>>>>=20
>>>> We won't actually infinite loop in pagefault_disable() context -- if
>>>> we would, then we would also infinite loop just from a regular page
>>>> fault, too.
>>>=20
>>> Fixing the page tables inside the #MC handler to unmap the poison
>>> page would indeed be a good solution. But, as you point out, not possibl=
e
>>> because of locks.
>>>=20
>>> Could we take a more drastic approach? We know that this case the kernel=

>>> is accessing a user address for the current process. Could the machine
>>> check handler just re-write %cr3 to point to a kernel-only page table[1]=
.
>>> I.e. unmap the entire current user process.
>>=20
>> That seems scary, especially if we're in the middle of a context
>> switch when this happens.  We *could* make it work, but I'm not at all
>> convinced it's wise.
>=20
> Scary? It's terrifying!
>=20
> But we know that the fault happend in a get_user() or copy_from_user() cal=
l
> (i.e. an RIP with an extable recovery address).  Does context switch
> access user memory?

No, but NMI can.

The case that would be very very hard to deal with is if we get an NMI just b=
efore IRET/SYSRET and get #MC inside that NMI.

What we should probably do is have a percpu list of pending memory failure c=
leanups and just accept that we=E2=80=99re going to sometimes get a second M=
CE (or third or fourth) before we can get to it.

Can we do the cleanup from an interrupt?  IPI-to-self might be a credible ap=
proach, if so.
