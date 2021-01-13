Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F1C2F42F8
	for <lists+linux-edac@lfdr.de>; Wed, 13 Jan 2021 05:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbhAMEQa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 12 Jan 2021 23:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbhAMEQ3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 12 Jan 2021 23:16:29 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8850AC061786
        for <linux-edac@vger.kernel.org>; Tue, 12 Jan 2021 20:15:49 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id b5so353901pjk.2
        for <linux-edac@vger.kernel.org>; Tue, 12 Jan 2021 20:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=WqE2XXnYf/qMN/FqD8VjKEqtp+k0PhEe68KlPUOeWEU=;
        b=hbzz2kF4Yf2SoiUbtmK64kmzL62GHDOSLwEVK4nsgRYlhSUlE0DnvAGvjyIVzB2s6/
         JbXm7fUzgPu/TFI5R9WezUPt2djmdvsqV6JF8w5Hg3aaEOY0Oiv8mQCcJfRnRLbV4iTx
         odwPqgwEx6DfnvBBEWAlicK+8ZwvlqXb9qlUbbkQIDYMafzIUR2xIdhkH+6UQ/ZzZAtW
         9vE7a7qJtR5fATOG2+mpkzvO9sKCondAX+OJKQN4DPK9s8T8qKE+9P6BwXlIK0aJFutu
         v1ZsKmd0O0Y4xnfl1xfrE7W2i3mqv1CxC0naWPiltMC9r2XCM+bIBiVwEyCM279CPeyP
         G3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=WqE2XXnYf/qMN/FqD8VjKEqtp+k0PhEe68KlPUOeWEU=;
        b=pcuSuuz7T2UhV6E7ANb4W72N+7lJG5YXgcZSgTj8ZxmVQvefyz5vSkw/g2vFCaVfZ9
         GM379VgOI1oZaFPTgSgisGnFTMrIoVmYxXTQtf8prSW+aOkLwF9RZUt5e4MZDDX8QS7I
         N9Chs686VwCKGNy1B2bQb8fw0KME2OYNW+oXSIJRyDrRUeMu8M8rpL4jKYY6BwBD3np+
         inL7bbKYi7/umhma87q+f4DQ8vBWz3xdnxYv8Yir1PGd4DbAwlpWrHBnJ9d5NBB4GRiA
         8gN+lMKo25XYOezj8gNVwE1BWggQ4mq94Kai7aabvEvi9EwcDnkOvtIzxlF2IHORWAJn
         3IYQ==
X-Gm-Message-State: AOAM532iIUfIQ+zANtbIG1BvAKIm9GNcrPDfWyGBlPeNFMfWvuLS0MXI
        lDSoqdfqfrp7YPm8cHiGOIc84s5vgTP2Yg==
X-Google-Smtp-Source: ABdhPJx8+dCbabN1VXoImEXM2PuYcqke71pOTB/rq/6isimsOCGCezagyZANmR4dIxZdqINp9X9TpQ==
X-Received: by 2002:a17:902:502:b029:db:fa52:c19 with SMTP id 2-20020a1709020502b02900dbfa520c19mr381202plf.70.1610511348446;
        Tue, 12 Jan 2021 20:15:48 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:2534:ff40:8b36:e20e? ([2601:646:c200:1ef2:2534:ff40:8b36:e20e])
        by smtp.gmail.com with ESMTPSA id 184sm625435pgi.92.2021.01.12.20.15.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 20:15:47 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 1/3] x86/mce: Avoid infinite loop for copy from user recovery
Date:   Tue, 12 Jan 2021 20:15:46 -0800
Message-Id: <EAA1BF13-3C3C-443C-8BF2-A52B5FFB68DE@amacapital.net>
References: <20210113015053.GA21587@agluck-desk2.amr.corp.intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
In-Reply-To: <20210113015053.GA21587@agluck-desk2.amr.corp.intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
X-Mailer: iPhone Mail (18C66)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



> On Jan 12, 2021, at 5:50 PM, Luck, Tony <tony.luck@intel.com> wrote:
>=20
> =EF=BB=BFOn Tue, Jan 12, 2021 at 02:04:55PM -0800, Andy Lutomirski wrote:
>>> But we know that the fault happend in a get_user() or copy_from_user() c=
all
>>> (i.e. an RIP with an extable recovery address).  Does context switch
>>> access user memory?
>>=20
>> No, but NMI can.
>>=20
>> The case that would be very very hard to deal with is if we get an NMI ju=
st before IRET/SYSRET and get #MC inside that NMI.
>>=20
>> What we should probably do is have a percpu list of pending memory failur=
e cleanups and just accept that we=E2=80=99re going to sometimes get a secon=
d MCE (or third or fourth) before we can get to it.
>>=20
>> Can we do the cleanup from an interrupt?  IPI-to-self might be a credible=
 approach, if so.
>=20
> You seem to be looking for a solution that is entirely contained within
> the machine check handling code. Willing to allow for repeated machine
> checks from the same poison address in order to achieve that.
>=20
> I'm opposed to mutliple machine checks.  Willing to make some changes
> in core code to avoid repeated access to the same poison location.

How about more questions before the showdown?

If we made core code changes to avoid this, what would they be?  We really c=
an do user access from NMI and #DB, and those can happen in horrible places.=
 We could have the pagetable lock held, be in the middle of CoWing the very p=
age we tripped over, etc. I think we really can=E2=80=99t count on being abl=
e to write to the PTEs from #MC. Similarly, we might have IRQs off, so we ca=
n=E2=80=99t broadcast a TLB flush. And we might be in the middle of entry, e=
xit, or CR3 switches, and I don=E2=80=99t see a particularly clean way to wr=
ite CR3 without risking accidentally returning to user mode with the wrong C=
R3.

So I=E2=80=99m sort of at a loss as to what we can do.  All user memory acce=
ssors can handle failure, and they will all avoid infinite looping.  If we c=
an tolerate repeated MCE, we can survive.  But there=E2=80=99s not a whole l=
ot we can do from these horrible contexts.

Hmm.  Maybe if we have SMAP we could play with EFLAGS.AC?  I can imagine thi=
s having various regrettable side effects, though.=
