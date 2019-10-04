Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34CD1CC698
	for <lists+linux-edac@lfdr.de>; Sat,  5 Oct 2019 01:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbfJDXf7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 4 Oct 2019 19:35:59 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33033 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728913AbfJDXfy (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 4 Oct 2019 19:35:54 -0400
Received: by mail-io1-f68.google.com with SMTP id z19so17205369ior.0
        for <linux-edac@vger.kernel.org>; Fri, 04 Oct 2019 16:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+T7DRRD+UBJWxQqae2a5KokUy893Q+Fh/NFyFQWVL5c=;
        b=aR+KCZ9iMZp71ShYHM33WPPJZLgnz4zsUdnjqJr8GHFuHLR7FyxN/fle/WUHQd2S1g
         OfLnAhfjfVGHzOaJK0w0TC11rXg1X4dvELPEblK609VJWdmUv3sZEwya23vmrWxc9DIG
         vIwRS1tb3jC35O1UM0jW9C+Ii5AJiQBiaQ1Ur7s/C07BnQkMOVZ4W9F3sPzf++A2KGb7
         xR6BJ5NeINKOa0O4NpITK3QSA5A4hBhi6JPVSDWobx9wowRsCSuZB6NQRnkdoOs+Z2W2
         osQu5NuuvxVuUBBBHYMDims/a/amUqM21/mCbGDA6dx/4nzkkCX+H13qHMc6NbHauO0N
         1cfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+T7DRRD+UBJWxQqae2a5KokUy893Q+Fh/NFyFQWVL5c=;
        b=pBXI3JxkjHHsxs1bFYP+EiV5M/gGj9cuV7nLG4PQKP4tDof1d7nB3W3Rbx1lR4Bj4m
         0bl+tudSDA8Aw/AFfuU+VQlsOXhRvU34VbjnbcUoSf3zKNq5MXigl30h6s8x1xM7CWXh
         jnQYAItd9cy+gD0E51wUIqu43pTJcJLiSljmsM4J4JUHvmxS5djq6o5CpUv7JidexOs0
         TR7KuLy7cSnvKeGoBX5j79mDSbNgwak3728AqrmikJXxTJiDzRPATzPd0NG8sWzp4QaU
         Clgvt6hjhm75PMGl3LxUw1aaEXvpIFdIjal8EtZBsJLPJlbH68dOy2KfW+18ilTg5NzP
         1WsQ==
X-Gm-Message-State: APjAAAWrPnnCLbmE6vpUNB4snU3rIPJwMIH4lqgzxgBQFq9YiMvXxUK0
        RCDkhR8wpzRvsyUIE1mTsk+jKoCARdkbGDmUXYQNzA==
X-Google-Smtp-Source: APXvYqx43jSstCJvk+2c6AUFzK14t9HPWx/edmJdJr8SoFrOND4p+DMir84DYAG2WVlbh9N6FdgDkbxAOENqDWPCqg4=
X-Received: by 2002:a92:5a10:: with SMTP id o16mr19118181ilb.296.1570232153408;
 Fri, 04 Oct 2019 16:35:53 -0700 (PDT)
MIME-Version: 1.0
References: <20191004215615.5479-1-sean.j.christopherson@intel.com> <20191004215615.5479-9-sean.j.christopherson@intel.com>
In-Reply-To: <20191004215615.5479-9-sean.j.christopherson@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 4 Oct 2019 16:35:42 -0700
Message-ID: <CALMp9eSEF-MKxF1+ApTe9-2fJbRBt2svHiCdX=4jP25Ed2LqBg@mail.gmail.com>
Subject: Re: [PATCH 08/16] KVM: VMX: Check for full VMX support when verifying
 CPU compatibility
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
> Explicitly check the current CPU's VMX feature flag when verifying
> compatibility across physical CPUs.  This effectively adds a check on
> IA32_FEATURE_CONTROL to ensure that VMX is fully enabled on all CPUs.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
