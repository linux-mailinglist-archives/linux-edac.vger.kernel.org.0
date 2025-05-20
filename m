Return-Path: <linux-edac+bounces-3964-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BFDABE7F9
	for <lists+linux-edac@lfdr.de>; Wed, 21 May 2025 01:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C8FE4C07F4
	for <lists+linux-edac@lfdr.de>; Tue, 20 May 2025 23:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A0F253F1B;
	Tue, 20 May 2025 23:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UiKemof4"
X-Original-To: linux-edac@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BAA1AE875;
	Tue, 20 May 2025 23:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747783212; cv=none; b=P4DQyi9v2qk/JYgLa6awtwSjNTZIrNSv8SNoUoX/BOplJJbf3OR5fv3jfO1TrLjUUJztRH/z3EMt+/9VMbmueCNQApFQ9bjg57kBRwSggmSRWzMaDmwi0YZle0/UFt3E3heauY+fUzEj8asS+GaGCMspvUK9d9hq8EwJO7WCjeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747783212; c=relaxed/simple;
	bh=b47Sid/Tzj1Q6uJ947FsPwJJqZpc02OLBHi2OAxo3bM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hSxAqd8oHdS8Dd6kWJQMDyn9tM6nk2uqQkGJL8anjtkW6tmZ3nc0rprG+MiR/OKx5TYWNQfOj6ezCYP5NdHLPaX3zQ9aVmqZKjW4pWfp2odPOSpLNS08ygn+8j7ARWdgAC09KjftQf/LQdsn4gneTkCsLrlZmgeww5HriIdeTB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UiKemof4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.93.0.51] (unknown [40.118.131.60])
	by linux.microsoft.com (Postfix) with ESMTPSA id BB4F420277CF;
	Tue, 20 May 2025 16:20:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BB4F420277CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747783210;
	bh=48UOZJdi6UD0dTmbUI5+OhczKXq3m/qlzK9e/Ymb7lc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UiKemof4NVC12FTSwoVFwZop9oUSLkxoYN/VD+Vc8mty/dp/V66dBh0zh+mkJ0nXg
	 CuBX4s6pPstRl1QKEkyldcTJKa1AFmYWOBnzzwD6hx8zfG/spgcXmTUprqT/kp4Uws
	 /9RN1w/yCKHtlqQF59PfNYs3nJpAKAPOhPlVgbu0=
Message-ID: <e9fb39c6-6678-4369-9184-a7308627714f@linux.microsoft.com>
Date: Tue, 20 May 2025 16:20:15 -0700
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drivers/edac: Add L1 and L2 error detection for A72
To: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, James Morse <james.morse@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Richter
 <rric@kernel.org>, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tyler Hicks <code@tyhicks.com>, Marc Zyngier <maz@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, devicetree@vger.kernel.org
References: <1747353973-4749-1-git-send-email-vijayb@linux.microsoft.com>
 <1747353973-4749-2-git-send-email-vijayb@linux.microsoft.com>
 <20250519085130.GFaCrxEnZvaoETKrao@fat_crate.local>
 <ea19ad06-142c-4d7e-83ba-00b9b7e3cdaf@linux.microsoft.com>
 <4630a9fc-0980-485f-9b70-01558ab418db@linux.microsoft.com>
 <20250520200448.GRaCzgYFnfIjKAgAg2@fat_crate.local>
Content-Language: en-US
From: Vijay Balakrishna <vijayb@linux.microsoft.com>
In-Reply-To: <20250520200448.GRaCzgYFnfIjKAgAg2@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/20/2025 1:04 PM, Borislav Petkov wrote:
> On Tue, May 20, 2025 at 12:54:32PM -0700, Vijay Balakrishna wrote:
>> On 5/20/2025 9:09 AM, Vijay Balakrishna wrote:
>>> On 5/19/2025 1:51 AM, Borislav Petkov wrote:
>>>> I'd venture a guess you need to protect here against CPU hotplug...
>>>>
>>>>> +    for_each_cpu_and(cpu, cpu_online_mask, &compat_mask) {
>>>>> +        smp_call_function_single(cpu, read_errors, &merrsr, true);
>>>>> +        report_errors(edac_ctl, cpu, &merrsr);
>>>>> +    }
>>>>> +}
>>>>> +
>>>
>>> Hi Boris,
>>>
>>> I appreciate you highlighting the CPU hotplug issue. Upon further review
>>> of surrounding code, I realized we must ensure that the data passed to
>>> read_errors() is per-CPU.
>>
>> Actually, per-CPU data not needed as we are passing true -- wait until
>> function has completed on other CPUs.
> 
> What happens if @cpu above gets offlined right before you do
> smp_call_function_single() ?

We can see inconsistent behavior or kernel crash/hang. You are correct, 
we need to protect against CPU hotplug. I will add 
cpus_read_lock()/cpus_read_unlock().

Thanks,
Vijay



