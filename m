Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCAF11C915
	for <lists+linux-edac@lfdr.de>; Thu, 12 Dec 2019 10:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbfLLJZQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 12 Dec 2019 04:25:16 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47846 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728344AbfLLJZQ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 12 Dec 2019 04:25:16 -0500
Received: from zn.tnic (p200300EC2F0A5A00984E1B37A4E020FA.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:5a00:984e:1b37:a4e0:20fa])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9E4F41EC0985;
        Thu, 12 Dec 2019 10:25:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1576142714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+dYA8drbIsiT7giIEQe7BBpW6cQ7yCAKZaHUc/zBWRM=;
        b=K/BGdkTbgGNJ3oJxIP+zDsGaBijLUTL6eRRcQn81scGw+OHe8dzUUZE+q0t39gaKxHUqX+
        VD4HI9lFACMrJGt79F9WU4np/Bgsd+KgljTPCLospi5QIiX4hEdaTV+g05+UjlIMz/lofV
        F7Prs7AFNWlxF1UddZrrXLCUK9F8y9A=
Date:   Thu, 12 Dec 2019 10:25:09 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
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
Subject: Re: [PATCH v4 01/19] x86/msr-index: Clean up bit defines for
 IA32_FEATURE_CONTROL MSR
Message-ID: <20191212092509.GB4991@zn.tnic>
References: <20191128014016.4389-2-sean.j.christopherson@intel.com>
 <201912010347.7tMb4moN%lkp@intel.com>
 <20191202190633.GG4063@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191202190633.GG4063@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Dec 02, 2019 at 11:06:33AM -0800, Sean Christopherson wrote:
> Argh, flat out missed this when doing search and replace.

There are more. What always works reliably for me is git grep:

$ git grep MSR_IA32_FEATURE_CONTROL
drivers/idle/intel_idle.c:1287:         rdmsrl(MSR_IA32_FEATURE_CONTROL, msr);
tools/arch/x86/include/asm/msr-index.h:561:#define MSR_IA32_FEATURE_CONTROL        0x0000003a
tools/power/x86/turbostat/turbostat.c:4502:     if (!get_msr(base_cpu, MSR_IA32_FEATURE_CONTROL, &msr))
tools/power/x86/turbostat/turbostat.c:4503:             fprintf(outf, "cpu%d: MSR_IA32_FEATURE_CONTROL: 0x%08llx (%sLocked %s)\n",
tools/testing/selftests/kvm/include/x86_64/processor.h:771:#define MSR_IA32_FEATURE_CONTROL        0x0000003a
tools/testing/selftests/kvm/lib/x86_64/vmx.c:162:       feature_control = rdmsr(MSR_IA32_FEATURE_CONTROL);
tools/testing/selftests/kvm/lib/x86_64/vmx.c:164:               wrmsr(MSR_IA32_FEATURE_CONTROL, feature_control | required);

those additional ones won't break the build but it is perhaps worth
unifying them all since we're at it, anyway.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
