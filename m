Return-Path: <linux-edac+bounces-3636-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A38A963DD
	for <lists+linux-edac@lfdr.de>; Tue, 22 Apr 2025 11:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA8243B07EC
	for <lists+linux-edac@lfdr.de>; Tue, 22 Apr 2025 09:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1754A23E33A;
	Tue, 22 Apr 2025 09:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ZPeuqs2Q"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C23B1EFFBF;
	Tue, 22 Apr 2025 09:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745313237; cv=none; b=sJGXbxdeKArJJgrV/yT88cXl9SmZRQ3mwOgdXiCRYgSRa0Uh5uWA4kwIaQDP6e05tIoIRdkE3VjdXkBdf2rU2u89uW4a1MSVouBk2QegyRPXZpriAQ46PZHbzTyYf6VEcCfQwM+wEzfqszGWsYplsA7umwHTRd6QvFHJzfl2AHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745313237; c=relaxed/simple;
	bh=8t87NXRHmH+x11mIfycM4fyvuVR/eKMQUHrwiHhPu78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZqRSsyIK2jm7yc24LVHKX8b7QMSP93cmnmSZmjGw0Jb2uyi9tIhq3VynnSgryOhP6EpNYEBScfisyxM1Hn+/7VIrIYk0R/mlV4Hr9QAGzKFxAnIurqXH1nBb3yK+TopRfuhdN9KnD7dx4xjKPg7HpLVEfaE2Fhaf3mQXjxcSQqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=ZPeuqs2Q; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.202] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 53M9Clo71988629
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 22 Apr 2025 02:12:47 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 53M9Clo71988629
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025042001; t=1745313171;
	bh=5MyMi1dWDpqM4+680ZRWUMemTrM7gOfrACTzG+hcvhU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZPeuqs2QxCZr+2CQbzBLOCpW3Aawds6/1cwg0KOGkN4s7Xzb3PZq6E2KiAUhdSklS
	 6bmAZ9hG+CfiogKMARVhoVzL3oriBG5dyHPHGBto0/mSKUTbfZ4aFLYUysVlh6JFC/
	 ZfI2lvkhOZHiUCZh+IkdkYywF31eKyF7de+lHzDs4b9fjhHs57HIRf++LaLMNtLPKY
	 QczCdjB0+4sEGoXJlmUjHhZjwRqeUafNM/3rfcGnb2CJu8EO98o0Ia9j/fEpQcfhQG
	 lCV0OoOhQjfirIbZQCPq86OrgvY0dVY0/wQxoL36KQ5giQ3vDEnESbBhySaQesbEM7
	 0Bz5uP6uYbAzw==
Message-ID: <a482b4df-f662-4d5d-8100-ade07afcdc24@zytor.com>
Date: Tue, 22 Apr 2025 02:12:46 -0700
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 06/34] x86/msr: Use the alternatives mechanism to
 read PMC
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
 <20250422082216.1954310-7-xin@zytor.com>
 <fbb509e8-0bd6-480f-be32-fd0895255a21@suse.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <fbb509e8-0bd6-480f-be32-fd0895255a21@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/22/2025 1:38 AM, Jürgen Groß wrote:
> On 22.04.25 10:21, Xin Li (Intel) wrote:
>> To eliminate the indirect call overhead introduced by the pv_ops API,
>> use the alternatives mechanism to read PMC:
> 
> Which indirect call overhead? The indirect call is patched via the
> alternative mechanism to a direct one.
> 

See below.


>>
>>      1) When built with !CONFIG_XEN_PV, X86_FEATURE_XENPV becomes a
>>         disabled feature, preventing the Xen PMC read code from being
>>         built and ensuring the native code is executed unconditionally.
> 
> Without CONFIG_XEN_PV CONFIG_PARAVIRT_XXL is not selected, resulting in
> native code anyway.

Yes, this is kept in this patch, but in a little different way.

> 
>>
>>      2) When built with CONFIG_XEN_PV:
>>
>>         2.1) If not running on the Xen hypervisor (!X86_FEATURE_XENPV),
>>              the kernel runtime binary is patched to unconditionally
>>              jump to the native PMC read code.
>>
>>         2.2) If running on the Xen hypervisor (X86_FEATURE_XENPV), the
>>              kernel runtime binary is patched to unconditionally jump
>>              to the Xen PMC read code.
>>
>> Consequently, remove the pv_ops PMC read API.
> 
> I don't see the value of this patch.
> 
> It adds more #ifdef and code lines without any real gain.
> 
> In case the x86 maintainers think it is still worth it, I won't object.

I think we want to totally bypass pv_ops in the case 2.1).

Do you mean the indirect call is patched to call native code *directly*
for 2.1?  I don't know it, can you please elaborate?

AFAIK, Xen PV has been the sole user of pv_ops for nearly 20 years. This
raises significant doubts about whether pv_ops provides Linux with the
value of being a well-abstracted "CPU" or "Platform".  And the x86
maintainers have said that it's a maintenance nightmare.

Thanks!
     Xin

