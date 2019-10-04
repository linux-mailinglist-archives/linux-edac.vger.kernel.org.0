Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB1AACC680
	for <lists+linux-edac@lfdr.de>; Sat,  5 Oct 2019 01:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731610AbfJDX1K (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 4 Oct 2019 19:27:10 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33609 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728913AbfJDX1J (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 4 Oct 2019 19:27:09 -0400
Received: by mail-io1-f68.google.com with SMTP id z19so17177277ior.0
        for <linux-edac@vger.kernel.org>; Fri, 04 Oct 2019 16:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MgBtF74uU/h5axnlk7JkCOLmu+x1dOiph+vzsmYmvXk=;
        b=uVq6fcbrUf2k6Z02rKXUYQfm+NxJ2X43dktUoENxNfmYB2XHRk95SxYzgRSsUxbcrB
         VMY+k9uQhD+yw7Z86iccSLyRvIZnFRWINVLQMCAnizvTboxDa8tSgunhpBqy399TufJo
         pTQgwsr0b4UWFteBOPGCKp4iaOAJbfAmgi0akHoXxFyE+3Odreox81GbAtjlHVpI3px2
         Vbo5DzvIn0o5B/YPL/oms2GZI0hF4ZHLN5W6SagkqSMqr/NrriKUAizDRFMfuWBMfg3o
         h5rMM9AS6TZh1Fjlyk+8lgmSMuV6Io0A48BTiKiatBflNxygHw3HopbT40WTIM5nuhhh
         6BsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MgBtF74uU/h5axnlk7JkCOLmu+x1dOiph+vzsmYmvXk=;
        b=OTiAUxnX6yIA/Kf/+xOGjnbhGcdu4FiFoj5yetw8op6RINHAwf4tVuOQK19GV1Cojd
         AKtOpCkQnLdMIC+r8E97S6/SJSMweZdmw+I6LH6TAlYS7jsnI85VIbFn14FHGbAE2ONw
         qKc/YOTPKBUwoqonBTAyUfp305CmtiRt6GlCguABQFHDTV/Dsqd9QuEh6nqTuuDbcioZ
         Qle/Gs7P4YEyseNM/wy3Wg89FDJKwoX+kvF2WpP5v+KtjfLFsuABdNZraOMxQTUrHQx6
         MCfmnqCgBaKSCDFLmaNVSBrK9AA0qBNf6YOCy8GssYgMx+vKFZwDRBgrpXDNY6Mn5tcl
         FX6w==
X-Gm-Message-State: APjAAAWXJaCD8yhiJjYyqTxxKLjHmTKt9KCg2P6VWqePk4IUhA8D0oaD
        1eYpDbj5N1gMT4LvgGDFty6IUfJxUS+rMzKEnSYyFg==
X-Google-Smtp-Source: APXvYqzJcQzvaX5CC41I1TRQRNaPDPcG28y+blJrc8QdeTRZXOhchbrBqUvMeJR9kiv9S7ucRVxFUERN4ZPen7d4jzw=
X-Received: by 2002:a05:6638:3:: with SMTP id z3mr17415762jao.54.1570231626712;
 Fri, 04 Oct 2019 16:27:06 -0700 (PDT)
MIME-Version: 1.0
References: <20191004215615.5479-1-sean.j.christopherson@intel.com> <20191004215615.5479-8-sean.j.christopherson@intel.com>
In-Reply-To: <20191004215615.5479-8-sean.j.christopherson@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 4 Oct 2019 16:26:55 -0700
Message-ID: <CALMp9eRDxHAAbtvdUZyM2VyKiKhRxftW+zbmGANF6Y6qADK9_g@mail.gmail.com>
Subject: Re: [PATCH 07/16] KVM: VMX: Use VMX feature flag to query BIOS enabling
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
> Replace KVM's manual checks on IA32_FEATURE_CONTROL with a query on the
> boot CPU's VMX feature flag.  The VMX flag is now cleared during boot if
> VMX isn't fully enabled via IA32_FEATURE_CONTROL, including the case
> where IA32_FEATURE_CONTROL isn't supported.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
