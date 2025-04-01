Return-Path: <linux-edac+bounces-3445-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 295BEA773EC
	for <lists+linux-edac@lfdr.de>; Tue,  1 Apr 2025 07:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AFC4188EAFE
	for <lists+linux-edac@lfdr.de>; Tue,  1 Apr 2025 05:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCCF1D95A3;
	Tue,  1 Apr 2025 05:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="PuNRo8V6"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1AE2AF14;
	Tue,  1 Apr 2025 05:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743485414; cv=none; b=PyhfN+RN6EEXHZc6xvg05kJpMjOIUlySyN0nrdwnXWtsc7fRAS/S/xSJuBpDWqt5Bmg9A3dbcN711psJB8rA8c8zHSysknZj/Y24AqLTS0LbILZ1jZ6sw8Q0682cFEAv4RdX1kdXGyMkotD8MOuuncEXnrwSROx5g5WiLL2ykQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743485414; c=relaxed/simple;
	bh=Y7pIpOOOgYadkjudSTcnTBayny0VQdBZUYXqpf4vEzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oPAAHHeZ+j9m91X8QgobPxsHSP6xw5xq7jSJbvN+Nzp4LOfOTpyKuwcaoX6yvggry1c5ngPrNOgVwLuSXs2BghKAtIZiRMl7Y5/BVKsNo7blmPFt2PXjOdFpxH9zjBSe0MxrUYcyxJL7Szusbzh0TRKeqbIq3bkAsX2gTXV6Tkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=PuNRo8V6; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.202] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5315TLRJ3578162
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 31 Mar 2025 22:29:22 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5315TLRJ3578162
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025032001; t=1743485364;
	bh=tuYUVWHXKKCOA8JUjduDbXOfJ32573HPzEBPhF28G1U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PuNRo8V6ftJc3Js38Xt4+TPl7kcUwg2H/x5pUpEyYzi5yh4DDLkLlfTh1+cPv15Ju
	 dWziFt2BjmW6G8CLCEsUhjN9zmSFpxd5hIVv9cdXt52fpANXDQAF4mQigMq0+0E0CE
	 7/6oUfZw2t3Ler+zOXMQ8swzm01cbejNDrBEd8Q2Z5fBJmEFZL9uYdaS0txe/IvZ/i
	 e5OGXzLYWtkOw6AtYS5H4IMxdvILUBb9AFccmBXaVWsdDmNMkIr7xMXEIHaglNHoxU
	 yMzPh3IKZ+Ue5Am3ilhBA2dMtkCPTsFDGLanh6aCEHH/0mNg/Lm28JEuiML1/KzRw6
	 RrhgzdOxIVCTw==
Message-ID: <0084e9a9-8247-456f-b1a5-c5cd7bb62710@zytor.com>
Date: Mon, 31 Mar 2025 22:29:21 -0700
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 01/15] x86/msr: Replace __wrmsr() with
 native_wrmsrl()
To: "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
        linux-edac@vger.kernel.org, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-ide@vger.kernel.org,
        linux-pm@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, jgross@suse.com,
        peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, wei.liu@kernel.org, ajay.kaher@broadcom.com,
        alexey.amakhalov@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        tony.luck@intel.com, pbonzini@redhat.com, vkuznets@redhat.com,
        seanjc@google.com, luto@kernel.org, boris.ostrovsky@oracle.com,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com
References: <20250331082251.3171276-1-xin@zytor.com>
 <20250331082251.3171276-2-xin@zytor.com>
 <0da43a86-81b0-4388-b47b-3a76b15f2a4c@citrix.com>
 <03874E9B-FAEB-4ACA-B13D-0BED7D54F443@zytor.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <03874E9B-FAEB-4ACA-B13D-0BED7D54F443@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/31/2025 10:13 PM, H. Peter Anvin wrote:
> On March 31, 2025 2:45:43 PM PDT, Andrew Cooper <andrew.cooper3@citrix.com> wrote:
>> On 31/03/2025 9:22 am, Xin Li (Intel) wrote:
>>> __wrmsr() is the lowest level primitive MSR write API, and its direct
>>> use is NOT preferred.  Use its wrapper function native_wrmsrl() instead.
>>>
>>> No functional change intended.
>>>
>>> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
>>
>> The critical piece of information you're missing from the commit message
>> is that the MSR_IMM instructions take a single u64.
>>
>> Therefore to use them, you've got to arrange for all callers to provide
>> a single u64, rather than a split u32 pair.
>>
>> ~Andrew
> 
> That being said, there is nothing wrong with having a two-word convenience wrapper.
> 

Yes, I ended up keeping the two-word convenience wrapper in this patch
set, and the wrapper calls a lower level API that takes a u64 argument.

And yes, as Ingo said, some of the conversion is NOT an improvement.


