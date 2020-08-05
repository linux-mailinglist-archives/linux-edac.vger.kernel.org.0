Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B11E23D304
	for <lists+linux-edac@lfdr.de>; Wed,  5 Aug 2020 22:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgHEUaj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 5 Aug 2020 16:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgHEUag (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 5 Aug 2020 16:30:36 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7795C061575
        for <linux-edac@vger.kernel.org>; Wed,  5 Aug 2020 13:30:36 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d22so5210227pfn.5
        for <linux-edac@vger.kernel.org>; Wed, 05 Aug 2020 13:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=V2Jneb4UoC2fWhfkl2WuSXjrqudasBUYHmLXhIRx3sk=;
        b=pcQ+CWVT4oLml67bVoKGdBrXiIt7brVuWQjj0LD09b+AngJInQ8Y6CUnoA0UrI3sdc
         ZI8iC43ed5wx35fMkbBrp53kBvdkjPJtIjcUeggyZwTRh2r7RuNFjQlPC+5RSd6sLgJ2
         wZ3XlwsC/q33UhMKsxwp/rZyd8GOr+pSHxVDkaM58gr4ji0rIY+zPXMIIL+ViJVvT1th
         qPOge8g4RUFNaOpwFiW6SM4ukLxkwHzbpt0D4to95MnycKe7UZHeQoHQXrX//8j3ZTA7
         HwxRIVgqQb0V/Z4HmaY+NWeZqiEGvXgxF/+ajwF4DLUUnujfTge4pW0MsiCwG7JlPO3D
         LC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=V2Jneb4UoC2fWhfkl2WuSXjrqudasBUYHmLXhIRx3sk=;
        b=n3Pq2hxOgHHiPg+DuAGwUXGNPOdZ/dFtn8vE74NjrmWgVdBJ8fiQmjhFaTtjY2XRS/
         lFYRmwYZsufNIMQSfnNasasfpc5rmo8mLRijvGLLwQzCN/mSrB5QX1yato/EQYpFDMes
         8p8jVvIu3CETSRpCDmeMCYxxSSlK2q4QoBjt0sbdXu06vPoDrLEfU9vyB+5YQF7NhNf1
         Ve226Hyx+o0cDfDlyCbo7emEBU1FM0tVAkYYj1e1KJ8Xyl8nI8aaV/PsN/6vHX6o5ebD
         pqcFd+edEN0nNX/x4PTeTHTCK5RoHGPrH3OsRVHni4//JOf+A3IEZW6tlkxtqIZBGL+9
         OuRA==
X-Gm-Message-State: AOAM533EZgYiPZoktMHrxiTU0RBAWn9E34cLEsFLPea35xsuB8ulh+fN
        VYj1XmdxwWvXcfCBxKAjeDPmig==
X-Google-Smtp-Source: ABdhPJzlUCR+yFWKLNVh6nLZ+fETiNYut2U9HTsD85qd8SdUH966JaRJXmA4AC5PH6GFfqQzG1tN7Q==
X-Received: by 2002:a63:e107:: with SMTP id z7mr4413591pgh.71.1596659436077;
        Wed, 05 Aug 2020 13:30:36 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:a84d:be3c:49a:e3a1? ([2601:646:c200:1ef2:a84d:be3c:49a:e3a1])
        by smtp.gmail.com with ESMTPSA id js19sm3920084pjb.33.2020.08.05.13.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 13:30:35 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] x86/cpu: Use SERIALIZE in sync_core() when available
Date:   Wed, 5 Aug 2020 13:30:32 -0700
Message-Id: <AC4AC665-06C3-404A-8245-BA4F1F4C4961@amacapital.net>
References: <20200805191126.GA27509@ranerica-svr.sc.intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Cathy Zhang <cathy.zhang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Kyung Min Park <kyung.min.park@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-edac <linux-edac@vger.kernel.org>
In-Reply-To: <20200805191126.GA27509@ranerica-svr.sc.intel.com>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: iPhone Mail (17G68)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



> On Aug 5, 2020, at 12:11 PM, Ricardo Neri <ricardo.neri-calderon@linux.int=
el.com> wrote:
>=20
> =EF=BB=BFOn Wed, Aug 05, 2020 at 11:28:31AM -0700, Andy Lutomirski wrote:
>>> On Wed, Aug 5, 2020 at 10:07 AM Ricardo Neri
>>> <ricardo.neri-calderon@linux.intel.com> wrote:
>>>=20
>>> On Wed, Aug 05, 2020 at 07:08:08AM +0200, Borislav Petkov wrote:
>>>> On Tue, Aug 04, 2020 at 09:58:25PM -0700, hpa@zytor.com wrote:
>>>>> Because why use an alternative to jump over one instruction?
>>>>>=20
>>>>> I personally would prefer to have the IRET put out of line
>>>>=20
>>>> Can't yet - SERIALIZE CPUs are a minority at the moment.
>>>>=20
>>>>> and have the call/jmp replaced by SERIALIZE inline.
>>>>=20
>>>> Well, we could do:
>>>>=20
>>>>      alternative_io("... IRET bunch", __ASM_SERIALIZE, X86_FEATURE_SERI=
ALIZE, ...);
>>>>=20
>>>> and avoid all kinds of jumping. Alternatives get padded so there
>>>> would be a couple of NOPs following when SERIALIZE gets patched in
>>>> but it shouldn't be a problem. I guess one needs to look at what gcc
>>>> generates...
>>>=20
>>> But the IRET-TO-SELF code has instruction which modify the stack. This
>>> would violate stack invariance in alternatives as enforced in commit
>>> 7117f16bf460 ("objtool: Fix ORC vs alternatives"). As a result, objtool
>>> gives warnings as follows:
>>>=20
>>> arch/x86/kernel/alternative.o: warning: objtool: do_sync_core()+0xe:
>>> alternative modifies stack
>>>=20
>>> Perhaps in this specific case it does not matter as the changes in the
>>> stack will be undone by IRET. However, using alternative_io would requir=
e
>>> adding the macro STACK_FRAME_NON_STANDARD to functions using sync_core()=
.
>>> IMHO, it wouldn't look good.
>>>=20
>>> So maybe the best approach is to implement as you suggested using
>>> static_cpu_has()?
>>=20
>> I agree.  Let's keep it simple.
>>=20
>> Honestly, I think the right solution is to have iret_to_self() in
>> actual asm and invoke it from C as needed.=20
>=20
> Do you mean anything different from what we have already [1]? If I
> understand your comment correctly, we have exactly that: an
> iret_to_self() asm implementation invoked from C.

I meant asm as in a .S file. But the code we have is fine for this purpose, a=
t least for now.

>=20
> Thanks and BR,
> Ricardo
>=20
> [1]. https://lore.kernel.org/lkml/20200727043132.15082-4-ricardo.neri-cald=
eron@linux.intel.com/
>=20
> Thanks and BR,
> Ricardo
