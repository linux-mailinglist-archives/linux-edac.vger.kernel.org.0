Return-Path: <linux-edac+bounces-3661-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4819DA9843F
	for <lists+linux-edac@lfdr.de>; Wed, 23 Apr 2025 10:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8B833ACCBA
	for <lists+linux-edac@lfdr.de>; Wed, 23 Apr 2025 08:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E831F7575;
	Wed, 23 Apr 2025 08:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="dl3P7bXF"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5691F2BAB;
	Wed, 23 Apr 2025 08:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745398406; cv=none; b=kXatubg/QDNCoEKJV2cDeimGGLnrUlkNid4qNRCsBYloxCirg3knqgaN4wj5hx/hnN6hBoz67Xtird627sAasHZl+nITvGDakxc1nh+ygtcmh2qi5u4Lv2FJ4OtAZlEouENhGUG8PpVG9VrhPU19MO0uNiIdSxffTNQSfoSpC8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745398406; c=relaxed/simple;
	bh=auPKMW+q1+Qqn2QTB5GXMprPrUP+dPOtU3JF8GSfRa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ndeoyMDsTWU9n0hDDJNI5xWEd7V1cZaqD2nqn3tyEPNwJZYVZAnZPxfjAB5x6lA4DLM9w+4WJUFyvnF4XCd9Z9YEYadQ4DKMMXSFM/H/DFOp7HbiJEYY5U2p17Kf+l5UitundvEY35t/CcUlKHCpIf3WWJFs40NDqwgmGoSfa8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=dl3P7bXF; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.202] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 53N8pdPU3180274
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 23 Apr 2025 01:51:39 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 53N8pdPU3180274
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025042001; t=1745398303;
	bh=6kmN/+GrZw4rC3Ys6pLoNaD/Wf1DQKhvLOyIykqio94=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dl3P7bXFsCov3PgD20ymOIC1FG1eSAGxGe1DQbY2LG6O/NrMHMVBlGAk+JDp60Fgf
	 +Pnv70fyGnLeBBbiUkB5NfR80TUqf9PoUmAU9iHHDMoRGzCfwBcwkKjONfEfh6RU3y
	 Xd+yt6SiKMOPKs7smA0LIwhSCJBbmEF2pgXMq1hR7ce2lmLZxa2oozrZU5Xx64YBSy
	 em5fezjfad3PGQcOwdbxM11bSPQVT17+MM/RZhPGMfA5z1Fo8GISFAxn0dAWTxVqKs
	 NapT16DwTl3Gg6ZXI0V3IlW3sqxII7MOJohN3YgP4fSuVYSwWgYi1N7Og/gNcKFK4d
	 023Wanxii0hkw==
Message-ID: <f7198308-e8f8-4cc5-b884-24bc5f408a2a@zytor.com>
Date: Wed, 23 Apr 2025 01:51:38 -0700
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 21/34] x86/msr: Utilize the alternatives mechanism
 to write MSR
To: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux.dev, linux-pm@vger.kernel.org,
        linux-edac@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org,
        netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        acme@kernel.org, andrew.cooper3@citrix.com, peterz@infradead.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
        wei.liu@kernel.org, ajay.kaher@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, tony.luck@intel.com,
        pbonzini@redhat.com, vkuznets@redhat.com, seanjc@google.com,
        luto@kernel.org, boris.ostrovsky@oracle.com, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com
References: <20250422082216.1954310-1-xin@zytor.com>
 <20250422082216.1954310-22-xin@zytor.com>
 <b2624e84-6fab-44a3-affc-ce0847cd3da4@suse.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <b2624e84-6fab-44a3-affc-ce0847cd3da4@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/22/2025 2:57 AM, Jürgen Groß wrote:
> On 22.04.25 10:22, Xin Li (Intel) wrote:
>> The story started from tglx's reply in [1]:
>>
>>    For actual performance relevant code the current PV ops mechanics
>>    are a horrorshow when the op defaults to the native instruction.
>>
>>    look at wrmsrl():
>>
>>    wrmsrl(msr, val
>>     wrmsr(msr, (u32)val, (u32)val >> 32))
>>      paravirt_write_msr(msr, low, high)
>>        PVOP_VCALL3(cpu.write_msr, msr, low, high)
>>
>>    Which results in
>>
>>     mov    $msr, %edi
>>     mov    $val, %rdx
>>     mov    %edx, %esi
>>     shr    $0x20, %rdx
>>     call    native_write_msr
>>
>>    and native_write_msr() does at minimum:
>>
>>     mov    %edi,%ecx
>>     mov    %esi,%eax
>>     wrmsr
>>     ret
>>
>>    In the worst case 'ret' is going through the return thunk. Not to
>>    talk about function prologues and whatever.
>>
>>    This becomes even more silly for trivial instructions like STI/CLI
>>    or in the worst case paravirt_nop().
> 
> This is nonsense.
> 
> In the non-Xen case the initial indirect call is directly replaced with
> STI/CLI via alternative patching, while for Xen it is replaced by a direct
> call.
> 
> The paravirt_nop() case is handled in alt_replace_call() by replacing the
> indirect call with a nop in case the target of the call was paravirt_nop()
> (which is in fact no_func()).
> 
>>
>>    The call makes only sense, when the native default is an actual
>>    function, but for the trivial cases it's a blatant engineering
>>    trainwreck.
> 
> The trivial cases are all handled as stated above: a direct replacement
> instruction is placed at the indirect call position.

The above comment was given in 2023 IIRC, and you have addressed it.

> 
>> Later a consensus was reached to utilize the alternatives mechanism to
>> eliminate the indirect call overhead introduced by the pv_ops APIs:
>>
>>      1) When built with !CONFIG_XEN_PV, X86_FEATURE_XENPV becomes a
>>         disabled feature, preventing the Xen code from being built
>>         and ensuring the native code is executed unconditionally.
> 
> This is the case today already. There is no need for any change to have
> this in place.
> 
>>
>>      2) When built with CONFIG_XEN_PV:
>>
>>         2.1) If not running on the Xen hypervisor (!X86_FEATURE_XENPV),
>>              the kernel runtime binary is patched to unconditionally
>>              jump to the native MSR write code.
>>
>>         2.2) If running on the Xen hypervisor (X86_FEATURE_XENPV), the
>>              kernel runtime binary is patched to unconditionally jump
>>              to the Xen MSR write code.
> 
> I can't see what is different here compared to today's state.
> 
>>
>> The alternatives mechanism is also used to choose the new immediate
>> form MSR write instruction when it's available.
> 
> Yes, this needs to be added.
> 
>> Consequently, remove the pv_ops MSR write APIs and the Xen callbacks.
> 
> I still don't see a major difference to today's solution.

The existing code generates:

     ...
     bf e0 06 00 00          mov    $0x6e0,%edi
     89 d6                   mov    %edx,%esi
     48 c1 ea 20             shr    $0x20,%rdx
     ff 15 07 48 8c 01       call   *0x18c4807(%rip)  # <pv_ops+0xb8>
     31 c0                   xor    %eax,%eax
     ...

And on native, the indirect call instruction is patched to a direct call
as you mentioned:

     ...
     bf e0 06 00 00          mov    $0x6e0,%edi
     89 d6                   mov    %edx,%esi
     48 c1 ea 20             shr    $0x20,%rdx
     e8 60 3e 01 00          call   <{native,xen}_write_msr> # direct
     90                      nop
     31 c0                   xor    %eax,%eax
     ...


This patch set generates assembly w/o CALL on native:

     ...
     e9 e6 22 c6 01          jmp    1f   # on native or nop on Xen
     b9 e0 06 00 00          mov    $0x6e0,%ecx
     e8 91 d4 fa ff          call   ffffffff8134ee80 <asm_xen_write_msr>
     e9 a4 9f eb 00          jmp    ffffffff8225b9a0 <__x86_return_thunk>
         ...
1:  b9 e0 06 00 00          mov    $0x6e0,%ecx   # immediate form here
     48 89 c2                mov    %rax,%rdx
     48 c1 ea 20             shr    $0x20,%rdx
     3e 0f 30                ds wrmsr
     ...

It's not a major change, but when it is patched to use the immediate 
form MSR write instruction, it's straightforwardly streamlined.

> 
> Only the "paravirt" term has been eliminated.

Yes.

But a PV guest doesn't operate at the highest privilege level, which
means MSR instructions typically result in a #GP fault.  I actually 
think the pv_ops MSR APIs are unnecessary because of this inherent
limitation.

Looking at the Xen MSR code, except PMU and just a few MSRs, it falls
back to executes native MSR instructions.  As MSR instructions trigger
#GP, Xen takes control and handles them in 2 ways:

   1) emulate (or ignore) a MSR operation and skip the guest instruction.

   2) inject the #GP back to guest OS and let its #GP handler handle it.
      But Linux MSR exception handler just ignores the MSR instruction
      (MCE MSR exception will panic).

So why not let Xen handle all the details which it already tries to do?
(Linux w/ such a change may not be able to run on old Xen hypervisors.)

BTW, if performance is a concern, writes to MSR_KERNEL_GS_BASE and
MSR_GS_BASE anyway are hpyercalls into Xen.

Thanks!
     Xin

