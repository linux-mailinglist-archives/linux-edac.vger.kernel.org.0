Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63C3DCC679
	for <lists+linux-edac@lfdr.de>; Sat,  5 Oct 2019 01:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731530AbfJDXYq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 4 Oct 2019 19:24:46 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44481 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731502AbfJDXYq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 4 Oct 2019 19:24:46 -0400
Received: by mail-io1-f67.google.com with SMTP id w12so16985335iol.11
        for <linux-edac@vger.kernel.org>; Fri, 04 Oct 2019 16:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t5VoJmyM1gIMOj2ihP4m0dtGZhlTOsx/IWyANJwdZVw=;
        b=qZIJeMHuRRyz9aYl84QLkP2KgLaLrHTfF6B2u847hCYU+r/+0kBlyQHUlkoKVSkjNC
         advNWiZJ0xqEG0BgQQhSpyT5/MYyXgkmWIK1NzllFw+CUK2g+l3u6rPb8YmZAFO/Pzig
         xUpdwXU7xuws8uqCAgvrKKNXzll3QLKdd46jJQGNPe2WXpuczp84Y2GpcigQwz1YmqoW
         Z1tXKcfMErZmbK3HXUCpq1+o4JbvK/IM+bZZ3CFeX50q556ZfBNxYlOEWDxe5NDssp+l
         UyGM68+EgtBAZw2tlK+6NRbexNzKayIf8gF3C6ucLBBA0wTv70Rf72YwWTYBI82bx/An
         ehCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t5VoJmyM1gIMOj2ihP4m0dtGZhlTOsx/IWyANJwdZVw=;
        b=SxptOj8P+TAvkoltI9nTHgX9buSolWGV3qrvvNjhGpT7jKq6Wkh2u3+FD5FQ+GCx1L
         DFOPT7A2ddI8UwqIzgdreeZuYH3+LYyWQkXSxxtcOMA1pi1Z2ch9t+ZLLXtksENLUc+C
         Ikct77JF8EGZGCZ8spnCjsEe49ChHCzjb+lTF3VPUHXBPqUaf8WyP9nf8IjkbT/l6GLN
         MU3eE9AJHoGH98IH/WenvCZYVtvQoTP7Ra/WPLT13Ye02LJvB6qjGliTEHHioXr9FnHd
         cjU6O+rHcMOeHIRSQA1zIcWDWWvHSi67imgu/Nh6axrhtvQSWHsWSuLdHLjHE+yvRPEU
         //lQ==
X-Gm-Message-State: APjAAAUgG0jq5o5b+9YRTiBcfOYk0lq5Jj4AbDDkoHmMukmQFomxXgue
        pHoaT46xGgX3fTlWZzibmrw145YwDINvgypIVA8pHQ==
X-Google-Smtp-Source: APXvYqx308aZCOI6xyKA+PpfI3mwAwHMdWiaKcu5fdslzxso/ABtjWOM3BvEg2g12QeUqihbpfUU65wAmmU0PIXWH5o=
X-Received: by 2002:a02:ac82:: with SMTP id x2mr17276510jan.18.1570231485310;
 Fri, 04 Oct 2019 16:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <20191004215615.5479-1-sean.j.christopherson@intel.com> <20191004215615.5479-6-sean.j.christopherson@intel.com>
In-Reply-To: <20191004215615.5479-6-sean.j.christopherson@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 4 Oct 2019 16:24:34 -0700
Message-ID: <CALMp9eQ-XnYo0e+Z7a931_+J9Q-9cmgPZZ3higmg2A=WiPz5iA@mail.gmail.com>
Subject: Re: [PATCH 05/16] KVM: VMX: Drop initialization of
 IA32_FEATURE_CONTROL MSR
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
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

On Fri, Oct 4, 2019 at 2:56 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Remove the code to initialize IA32_FEATURE_CONTROL MSR when KVM is
> loaded now that the MSR is initialized during boot on all CPUs that
> support VMX, i.e. can possibly load kvm_intel.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
