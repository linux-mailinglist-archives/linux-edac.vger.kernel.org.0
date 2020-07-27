Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9938422E5A9
	for <lists+linux-edac@lfdr.de>; Mon, 27 Jul 2020 08:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgG0GAs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Jul 2020 02:00:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37393 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgG0GAs (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 27 Jul 2020 02:00:48 -0400
Received: from [IPv6:2601:646:8600:3281:d01e:b6c6:1a24:9007] ([IPv6:2601:646:8600:3281:d01e:b6c6:1a24:9007])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 06R60erA1896045
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Sun, 26 Jul 2020 23:00:40 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 06R60erA1896045
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020072401; t=1595829640;
        bh=7ZJ+HouPgYEW8yiE/LlDG0NoGA+OpyGJKIgsOqzZVVo=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=KvHChYHVfL0eFt8kwhYWOEWit5bUKLOzOmF5TipbW3aUH9IH0jSxQ0G/9uITl/CLv
         bMlYvnZN6dN905twqBfvtRJUClC/BF5fz8rwdl7dIjCzWUnOBtUQ72Lj3yZo8IyHUQ
         wEIoXD3M2LghykG8/lJHX6lYFRDqd/b78G0b9LAiAJw3A7JqexQOW0xCDLtl5RAewo
         i7q07r2nCsNH73rUXpr6oICjkX8Zn3+BP8PfMie+WQ93YfpLeWGEfnuTJK7r0hfe2A
         PwBFsztVz5rpJ+xlDmolRx62lRm4x63Tr6G4anZCm2GcIGNOT012aXnOYeGV1MAgQa
         M7lVstsboyCVw==
Date:   Sun, 26 Jul 2020 23:00:33 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <D51F2DC3-3C56-44E6-A1F2-434E7D27133C@zytor.com>
References: <20200727043132.15082-1-ricardo.neri-calderon@linux.intel.com> <20200727043132.15082-5-ricardo.neri-calderon@linux.intel.com> <D51F2DC3-3C56-44E6-A1F2-434E7D27133C@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4/4] x86/cpu: Use SERIALIZE in sync_core() when available
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org
CC:     Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Cathy Zhang <cathy.zhang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Kyung Min Park <kyung.min.park@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-edac@vger.kernel.org
From:   hpa@zytor.com
Message-ID: <EBDB5889-4FAC-45FC-A2B1-285751721592@zytor.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On July 26, 2020 10:55:15 PM PDT, hpa@zytor=2Ecom wrote:
>On July 26, 2020 9:31:32 PM PDT, Ricardo Neri
><ricardo=2Eneri-calderon@linux=2Eintel=2Ecom> wrote:
>>The SERIALIZE instruction gives software a way to force the processor
>>to
>>complete all modifications to flags, registers and memory from
>previous
>>instructions and drain all buffered writes to memory before the next
>>instruction is fetched and executed=2E Thus, it serves the purpose of
>>sync_core()=2E Use it when available=2E
>>
>>Use boot_cpu_has() and not static_cpu_has(); the most critical paths
>>(returning to user mode and from interrupt and NMI) will not reach
>>sync_core()=2E
>>
>>Cc: Andy Lutomirski <luto@kernel=2Eorg>
>>Cc: Cathy Zhang <cathy=2Ezhang@intel=2Ecom>
>>Cc: Dave Hansen <dave=2Ehansen@linux=2Eintel=2Ecom>
>>Cc: Fenghua Yu <fenghua=2Eyu@intel=2Ecom>
>>Cc: "H=2E Peter Anvin" <hpa@zytor=2Ecom>
>>Cc: Kyung Min Park <kyung=2Emin=2Epark@intel=2Ecom>
>>Cc: Peter Zijlstra <peterz@infradead=2Eorg>
>>Cc: "Ravi V=2E Shankar" <ravi=2Ev=2Eshankar@intel=2Ecom>
>>Cc: Sean Christopherson <sean=2Ej=2Echristopherson@intel=2Ecom>
>>Cc: linux-edac@vger=2Ekernel=2Eorg
>>Cc: linux-kernel@vger=2Ekernel=2Eorg
>>Reviwed-by: Tony Luck <tony=2Eluck@intel=2Ecom>
>>Suggested-by: Andy Lutomirski <luto@kernel=2Eorg>
>>Signed-off-by: Ricardo Neri <ricardo=2Eneri-calderon@linux=2Eintel=2Ecom=
>
>>---
>>---
>> arch/x86/include/asm/special_insns=2Eh |  5 +++++
>> arch/x86/include/asm/sync_core=2Eh     | 10 +++++++++-
>> 2 files changed, 14 insertions(+), 1 deletion(-)
>>
>>diff --git a/arch/x86/include/asm/special_insns=2Eh
>>b/arch/x86/include/asm/special_insns=2Eh
>>index 59a3e13204c3=2E=2E0a2a60bba282 100644
>>--- a/arch/x86/include/asm/special_insns=2Eh
>>+++ b/arch/x86/include/asm/special_insns=2Eh
>>@@ -234,6 +234,11 @@ static inline void clwb(volatile void *__p)
>>=20
>> #define nop() asm volatile ("nop")
>>=20
>>+static inline void serialize(void)
>>+{
>>+	asm volatile("=2Ebyte 0xf, 0x1, 0xe8");
>>+}
>>+
>> #endif /* __KERNEL__ */
>>=20
>> #endif /* _ASM_X86_SPECIAL_INSNS_H */
>>diff --git a/arch/x86/include/asm/sync_core=2Eh
>>b/arch/x86/include/asm/sync_core=2Eh
>>index fdb5b356e59b=2E=2Ebf132c09d61b 100644
>>--- a/arch/x86/include/asm/sync_core=2Eh
>>+++ b/arch/x86/include/asm/sync_core=2Eh
>>@@ -5,6 +5,7 @@
>> #include <linux/preempt=2Eh>
>> #include <asm/processor=2Eh>
>> #include <asm/cpufeature=2Eh>
>>+#include <asm/special_insns=2Eh>
>>=20
>> #ifdef CONFIG_X86_32
>> static inline void iret_to_self(void)
>>@@ -54,7 +55,8 @@ static inline void iret_to_self(void)
>> static inline void sync_core(void)
>> {
>> 	/*
>>-	 * There are quite a few ways to do this=2E  IRET-to-self is nice
>>+	 * Hardware can do this for us if SERIALIZE is available=2E Otherwise,
>>+	 * there are quite a few ways to do this=2E  IRET-to-self is nice
>> 	 * because it works on every CPU, at any CPL (so it's compatible
>> 	 * with paravirtualization), and it never exits to a hypervisor=2E
>> 	 * The only down sides are that it's a bit slow (it seems to be
>>@@ -75,6 +77,12 @@ static inline void sync_core(void)
>> 	 * Like all of Linux's memory ordering operations, this is a
>> 	 * compiler barrier as well=2E
>> 	 */
>>+
>>+	if (boot_cpu_has(X86_FEATURE_SERIALIZE)) {
>>+		serialize();
>>+		return;
>>+	}
>>+
>> 	iret_to_self();
>> }
>>=20
>
>Any reason to not make sync_core() an inline with alternatives?
>
>For a really overenginered solution, but which might perform
>unnecessary poorly on existing hardware:
>
>asm volatile("1: =2Ebyte 0xf, 0x1, 0xe8; 2:"
>                        _ASM_EXTABLE(1b,2b));

(and : : : "memory" of course=2E)
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
