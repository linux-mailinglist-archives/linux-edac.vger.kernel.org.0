Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E18BDCFF4D
	for <lists+linux-edac@lfdr.de>; Tue,  8 Oct 2019 18:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbfJHQx5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 8 Oct 2019 12:53:57 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44348 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfJHQx5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 8 Oct 2019 12:53:57 -0400
Received: by mail-io1-f66.google.com with SMTP id w12so37928440iol.11
        for <linux-edac@vger.kernel.org>; Tue, 08 Oct 2019 09:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fme5fFYUj0wdKTaXtPchzRO/hZyN3IQGJxfMnt1qVJI=;
        b=nF6ztrceJdjl9xNuXNv5mwqCWU5zJiJnq0FWCZzdURWJFCyF8lq29UW/vjWY6vTYma
         A2vyFCS8QnTpZRdKfqpcLtymIzPuly4yfU+HNeOcaOe8C0t7yiMkXCpg2oYL6hJvEsee
         Up6y0FoUSqnDLGgBNM9DYqZNWygDKvbsDednwj+Rj3AVL0cd8Y1O1AwblvHbnErAyM1s
         Oq0JalZDIlpzXA79i8F9OCTZDMF/7uK8H/ZB1T0tKbINfE1H1l9gPgxcdjjjRcVQZPUw
         RGUnyj/xgKxNMmLsrq5wWKfa0asvyNQqKOi+g7hq2lwcgkhXkMCPWXJ4T/K8unUXl+j+
         FosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fme5fFYUj0wdKTaXtPchzRO/hZyN3IQGJxfMnt1qVJI=;
        b=PfmrtbySdtI2CdPV/P/FeK1DNDtMxiFqQKVwBHuXUB3XVSc0ITQsSH7Dqh/VgokvtO
         i39kI6W+jthHVek2b93NDiI/KC1xGoFza1CX7NOe+C1H9wi1AXdl+u+8g62vLZr7lCTD
         63Ylk1L4Hpd7gKo2f7ZOnRck3hUDSlikN2ltaSLQXUPQDFVf7I9qb4ZMd7hDbQDtglWw
         sE7wueAR9isqi3IDwD6UONLwi/x6IA+FFY0G7t6x33NTYKrcL0j38gfESPNkDgAZDbwz
         Mau0ycB0KsH73YIgQNBn5vHVB2jiOK/bgaLGCcRo0j0+PYB5pEZ1bmAQskBonHeaBlbj
         72BA==
X-Gm-Message-State: APjAAAVb7nS4bG6LfSTNb/4KewW7qQkgSCJMewq++RvO5EkkeKTckWLw
        TqjW9G97ePZruJbkWj8EWaa0qx0ZphzvEaMzIe7abA==
X-Google-Smtp-Source: APXvYqwDWGOf+yElISRWjmDcwEri92PuzaR9Mbp5SH1x+dezCLs5TRcNt3I5EnwbB6Klb9T5kpEFj0FvbeItRICFmbk=
X-Received: by 2002:a6b:1606:: with SMTP id 6mr32477437iow.108.1570553635857;
 Tue, 08 Oct 2019 09:53:55 -0700 (PDT)
MIME-Version: 1.0
References: <20191004215615.5479-1-sean.j.christopherson@intel.com>
 <20191004215615.5479-12-sean.j.christopherson@intel.com> <55f45459-47bf-df37-a12b-17c4c5c6c19a@redhat.com>
 <20191007195638.GG18016@linux.intel.com> <bd2cffea-6427-b3cc-7098-a881e3d4522d@redhat.com>
In-Reply-To: <bd2cffea-6427-b3cc-7098-a881e3d4522d@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 8 Oct 2019 09:53:44 -0700
Message-ID: <CALMp9eSM=rq+jEEzPwWNHNxv03F1s2Dysa7euWJ==PaE=b1sMw@mail.gmail.com>
Subject: Re: [PATCH 11/16] x86/cpu: Print VMX features as separate line item
 in /proc/cpuinfo
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>, linux-edac@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Oct 7, 2019 at 11:57 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 07/10/19 21:56, Sean Christopherson wrote:
> > On Mon, Oct 07, 2019 at 07:12:37PM +0200, Paolo Bonzini wrote:
> >> On 04/10/19 23:56, Sean Christopherson wrote:
> >>> diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
> >>> index cb2e49810d68..4eec8889b0ff 100644
> >>> --- a/arch/x86/kernel/cpu/proc.c
> >>> +++ b/arch/x86/kernel/cpu/proc.c
> >>> @@ -7,6 +7,10 @@
> >>>
> >>>  #include "cpu.h"
> >>>
> >>> +#ifdef CONFIG_X86_VMX_FEATURE_NAMES
> >>> +extern const char * const x86_vmx_flags[NVMXINTS*32];
> >>> +#endif
> >>> +
> >>>  /*
> >>>   * Get CPU information for use by the procfs.
> >>>   */
> >>> @@ -102,6 +106,17 @@ static int show_cpuinfo(struct seq_file *m, void *v)
> >>>             if (cpu_has(c, i) && x86_cap_flags[i] != NULL)
> >>>                     seq_printf(m, " %s", x86_cap_flags[i]);
> >>
> >> I'm afraid this is going to break some scripts in the wild.  I would
> >> simply remove the seq_puts below.
> >
> > Can you elaborate?  I'm having trouble connecting the dots...
>
> Somebody is bound to have scripts doing "grep ^flags.*ept /proc/cpuinfo"
> or checking for VMX flags under some kind of "if (/^flags/)", so it's
> safer not to separate VMX and non-VMX flags.

Yep. Not quite that exact syntax, but we do have, e.g.:

./x86/feature_check.sh ept

...and you can imagine what feature_check.sh does.
