Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42ED023C4D8
	for <lists+linux-edac@lfdr.de>; Wed,  5 Aug 2020 06:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgHEE7I (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 5 Aug 2020 00:59:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56239 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbgHEE7H (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 5 Aug 2020 00:59:07 -0400
Received: from [IPv6:2601:646:8600:3281:4d47:1bf:1c0:ca78] ([IPv6:2601:646:8600:3281:4d47:1bf:1c0:ca78])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 0754wZ0n1340656
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 4 Aug 2020 21:58:37 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 0754wZ0n1340656
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020072401; t=1596603517;
        bh=K0YtmlVOlBrq2tiPxngWD6/nA93bB+Z0pt3YUuJ0E/o=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=O/7+2mMiUk1rHmLD+v09FyUwzmvm8h6gepWLUfGSy3qqZ9WFnAQ2ceHrzwkF9DBB3
         wLVvy8mN9RL5qSjeUwOCjQmLjbXUtH1xKKPR3BSqsWohinv3u6/tkchGGZq0joTkvY
         lb2ovEmbwpEXvrd9g0Z132SBHhM2KJVArIYYVlTK4uVDx+qEotVfRCfj3Y+gHVaY2l
         y6LPz1foxoZDyMlwDUcJTvOVm9nK2KyW2ABa3DGBOb/tT6AAUFI113tGTmzYDdrN3l
         hoUYuq5Or8NC20qJiiozi/asvqNDYPTzQsFAgFFyJHnICrWEdH5MVsokbu2gArvDWx
         8dTRYU52EL90Q==
Date:   Tue, 04 Aug 2020 21:58:25 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20200805044840.GA9127@nazgul.tnic>
References: <20200805021059.1331-1-ricardo.neri-calderon@linux.intel.com> <20200805044840.GA9127@nazgul.tnic>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] x86/cpu: Use SERIALIZE in sync_core() when available
To:     Borislav Petkov <bp@suse.de>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Cathy Zhang <cathy.zhang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Kyung Min Park <kyung.min.park@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-edac@vger.kernel.org
From:   hpa@zytor.com
Message-ID: <47A60E6A-0742-45FB-B707-175E87C58184@zytor.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On August 4, 2020 9:48:40 PM PDT, Borislav Petkov <bp@suse=2Ede> wrote:
>On Tue, Aug 04, 2020 at 07:10:59PM -0700, Ricardo Neri wrote:
>> The SERIALIZE instruction gives software a way to force the processor
>to
>> complete all modifications to flags, registers and memory from
>previous
>> instructions and drain all buffered writes to memory before the next
>> instruction is fetched and executed=2E Thus, it serves the purpose of
>> sync_core()=2E Use it when available=2E
>>=20
>> Commit 7117f16bf460 ("objtool: Fix ORC vs alternatives") enforced
>stack
>> invariance in alternatives=2E The iret-to-self does not comply with
>such
>> invariance=2E Thus, it cannot be used inside alternative code=2E Instea=
d,
>use
>> an alternative that jumps to SERIALIZE when available=2E
>>=20
>> Cc: Andy Lutomirski <luto@kernel=2Eorg>
>> Cc: Cathy Zhang <cathy=2Ezhang@intel=2Ecom>
>> Cc: Dave Hansen <dave=2Ehansen@linux=2Eintel=2Ecom>
>> Cc: Fenghua Yu <fenghua=2Eyu@intel=2Ecom>
>> Cc: "H=2E Peter Anvin" <hpa@zytor=2Ecom>
>> Cc: Kyung Min Park <kyung=2Emin=2Epark@intel=2Ecom>
>> Cc: Peter Zijlstra <peterz@infradead=2Eorg>
>> Cc: "Ravi V=2E Shankar" <ravi=2Ev=2Eshankar@intel=2Ecom>
>> Cc: Sean Christopherson <sean=2Ej=2Echristopherson@intel=2Ecom>
>> Cc: linux-edac@vger=2Ekernel=2Eorg
>> Cc: linux-kernel@vger=2Ekernel=2Eorg
>> Suggested-by: Andy Lutomirski <luto@kernel=2Eorg>
>> Signed-off-by: Ricardo Neri <ricardo=2Eneri-calderon@linux=2Eintel=2Eco=
m>
>> ---
>> This is a v2 from my initial submission [1]=2E The first three patches
>of
>> the series have been merged in Linus' tree=2E Hence, I am submitting
>only
>> this patch for review=2E
>>=20
>> [1]=2E https://lkml=2Eorg/lkml/2020/7/27/8
>>=20
>> Changes since v1:
>>  * Support SERIALIZE using alternative runtime patching=2E
>>    (Peter Zijlstra, H=2E Peter Anvin)
>>  * Added a note to specify which version of binutils supports
>SERIALIZE=2E
>>    (Peter Zijlstra)
>>  * Verified that (::: "memory") is used=2E (H=2E Peter Anvin)
>> ---
>>  arch/x86/include/asm/special_insns=2Eh |  2 ++
>>  arch/x86/include/asm/sync_core=2Eh     | 10 +++++++++-
>>  2 files changed, 11 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/arch/x86/include/asm/special_insns=2Eh
>b/arch/x86/include/asm/special_insns=2Eh
>> index 59a3e13204c3=2E=2E25cd67801dda 100644
>> --- a/arch/x86/include/asm/special_insns=2Eh
>> +++ b/arch/x86/include/asm/special_insns=2Eh
>> @@ -10,6 +10,8 @@
>>  #include <linux/irqflags=2Eh>
>>  #include <linux/jump_label=2Eh>
>> =20
>> +/* Instruction opcode for SERIALIZE; supported in binutils >=3D 2=2E35=
=2E
>*/
>> +#define __ASM_SERIALIZE "=2Ebyte 0xf, 0x1, 0xe8"
>>  /*
>>   * Volatile isn't enough to prevent the compiler from reordering the
>>   * read/write functions for the control registers and messing
>everything up=2E
>> diff --git a/arch/x86/include/asm/sync_core=2Eh
>b/arch/x86/include/asm/sync_core=2Eh
>> index fdb5b356e59b=2E=2E201ea3d9a6bd 100644
>> --- a/arch/x86/include/asm/sync_core=2Eh
>> +++ b/arch/x86/include/asm/sync_core=2Eh
>> @@ -5,15 +5,19 @@
>>  #include <linux/preempt=2Eh>
>>  #include <asm/processor=2Eh>
>>  #include <asm/cpufeature=2Eh>
>> +#include <asm/special_insns=2Eh>
>> =20
>>  #ifdef CONFIG_X86_32
>>  static inline void iret_to_self(void)
>>  {
>>  	asm volatile (
>> +		ALTERNATIVE("", "jmp 2f", X86_FEATURE_SERIALIZE)
>>  		"pushfl\n\t"
>>  		"pushl %%cs\n\t"
>>  		"pushl $1f\n\t"
>>  		"iret\n\t"
>> +		"2:\n\t"
>> +		__ASM_SERIALIZE "\n"
>>  		"1:"
>>  		: ASM_CALL_CONSTRAINT : : "memory");
>>  }
>> @@ -23,6 +27,7 @@ static inline void iret_to_self(void)
>>  	unsigned int tmp;
>> =20
>>  	asm volatile (
>> +		ALTERNATIVE("", "jmp 2f", X86_FEATURE_SERIALIZE)
>
>Why is this and above stuck inside the asm statement?
>
>Why can't you simply do:
>
>	if (static_cpu_has(X86_FEATURE_SERIALIZE)) {
>		asm volatile(__ASM_SERIALIZE ::: "memory");
>		return;
>	}
>
>on function entry instead of making it more unreadable for no
>particular
>reason?

Because why use an alternative to jump over one instruction?

I personally would prefer to have the IRET put out of line and have the ca=
ll/jmp replaced by SERIALIZE inline=2E

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
