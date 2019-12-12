Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E916A11D194
	for <lists+linux-edac@lfdr.de>; Thu, 12 Dec 2019 16:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbfLLP5T (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 12 Dec 2019 10:57:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52436 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729599AbfLLP5T (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 12 Dec 2019 10:57:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576166238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rRNrufMF5ZmcT+/5HZMlWib9qPtBnpXc+naU09rmhxc=;
        b=OpNWRtOsaH3Av2oZEgSE/JKPJMiYoUyluTwBmc+8VZv6/T2n16sYSRduhKCzf94igpwKvJ
        pvlT6ZA+U4VFAMvUe0hsLKk4dzmvey7yAzgVwdufK89/tM1DVWrV7DGdPvEsvyqAB/IpOE
        FkHpIT+sy5sLLCHKSrljj7J/znOlF7U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-bDgCSRLeOR6T6pb0k1YaCQ-1; Thu, 12 Dec 2019 10:57:16 -0500
X-MC-Unique: bDgCSRLeOR6T6pb0k1YaCQ-1
Received: by mail-wm1-f70.google.com with SMTP id p5so753540wmc.4
        for <linux-edac@vger.kernel.org>; Thu, 12 Dec 2019 07:57:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rRNrufMF5ZmcT+/5HZMlWib9qPtBnpXc+naU09rmhxc=;
        b=MB+FXn8Gs4T+yX5nIFcM58MZGAdTHA47Z7W2IEKAiOgLhhnzzz9v0ttulN65I7NUnt
         B02jJg/M+9J4KVA/6sa5x7TO3baaCzTqJp669FmzqEBcERAXziZPET6OHz4c55W8Wh/+
         6m62s4ko91ft6OHXk7w3Nmq026wNOGzVr78bjdZa3L8yd6FtozUUGtT3FzEX01QKYqC8
         pMy0cN3QkIHfvlqXNH5Vyczkr2npAbbPDyCdCNdih2/rESEPGwcSdAYWUtqYSCBfZMla
         fmUcndPhXW+KWtp9PXmMvMcGVF1qpZUEAOFR21KGBsHJwczkrhFtCiNtkiq9M0lUROl2
         /p7Q==
X-Gm-Message-State: APjAAAUn+taAsPYNbreiCmkKhu7MSSU0wFV1BLyRPHjx3wJxUugpOKW6
        /F2aoAbKK0GSes6poamLo7FFz7zUK5Z+CCcTb+zhmxTJPN1KbwLbU4iVTBiB1tzLJagD6I3b+4I
        p6z5aYZ6wQJkxp+CHBAoFyA==
X-Received: by 2002:adf:e6c6:: with SMTP id y6mr7226959wrm.284.1576166235415;
        Thu, 12 Dec 2019 07:57:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqxCcJblbdBpu6fVRmTMMxd9YCps91vlO3a/KrWqDMJ5D1GjIwC7bcnVpKVuMe+qGktQ2LnvbA==
X-Received: by 2002:adf:e6c6:: with SMTP id y6mr7226922wrm.284.1576166235182;
        Thu, 12 Dec 2019 07:57:15 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9? ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
        by smtp.gmail.com with ESMTPSA id s10sm6451431wrw.12.2019.12.12.07.57.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 07:57:14 -0800 (PST)
Subject: Re: [PATCH v4 11/19] x86/cpu: Print VMX flags in /proc/cpuinfo using
 VMX_FEATURES_*
To:     Liran Alon <liran.alon@oracle.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tony Luck <tony.luck@intel.com>,
        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
        Len Brown <lenb@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
References: <20191128014016.4389-1-sean.j.christopherson@intel.com>
 <20191128014016.4389-12-sean.j.christopherson@intel.com>
 <20191212122646.GE4991@zn.tnic>
 <d0b21e7e-69f5-09f9-3e1c-14d49fa42b9f@redhat.com>
 <4A24DE75-4E68-4EC6-B3F3-4ACB0EE82BF0@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <17c6569e-d0af-539c-6d63-f4c07367d8d1@redhat.com>
Date:   Thu, 12 Dec 2019 16:57:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <4A24DE75-4E68-4EC6-B3F3-4ACB0EE82BF0@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 12/12/19 16:52, Liran Alon wrote:
>>> virt_apic_accesses	-> vapic
>> apicv
> Frankly, I dislike APICv terminology. I prefer to enumerate the
> various VMX features which are collectively called APICv by KVM. 
> APICv currently represents in KVM terminology the combination of
> APIC-register virtualization, virtual-interrupt-delivery and
> posted-interrupts (See cpu_has_vmx_apicv()).
> 
> In fact, the coupling of “enable_apicv” module parameter have made me
> multiple times to need to disable entire APICv features when there
> for example was only a bug in posted-interrupts.
> 
> Even you got confused as virtualize-apic-access is not part of KVM’s
> APICv terminology but rather it’s enablement depend on
> flexpriority_enabled (See cpu_need_virtualize_apic_accesses()). i.e.
> It can be used for faster intercept handling of accesses to guest
> xAPIC MMIO page.

Right, I got confused with APIC-register virtualization.  Virtualize
APIC accesses is another one I wouldn't bother putting in /proc/cpuinfo,
since it's usually present together with flexpriority.

Paolo

