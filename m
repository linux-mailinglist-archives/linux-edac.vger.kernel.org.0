Return-Path: <linux-edac+bounces-5453-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E320BC64407
	for <lists+linux-edac@lfdr.de>; Mon, 17 Nov 2025 14:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 975E13A5331
	for <lists+linux-edac@lfdr.de>; Mon, 17 Nov 2025 13:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D847F32E140;
	Mon, 17 Nov 2025 13:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="og7gAhEu"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7B22820C6;
	Mon, 17 Nov 2025 13:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763384634; cv=none; b=VYYkHECnVPxhp1PFsIrZaia/EYNnyiypdqs3zq3aMf8Pl03fH+jacWNI1hGjgs6uFHhkNEqnfiswHgzhE5GMQUDBuEQ7c+emBa8+aVUEZR4L/W9aP++j//qH0E6LdYXOBeHbDyoq6SoMyme0HEhNBq/UVAoR4mL4uLAyDRvBpGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763384634; c=relaxed/simple;
	bh=mLHRse2lP8TCM6UtCPpAgpRgFlU7oFFLWpKldAxaUS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sGVknj8jgXradRCgsU59xHQup8UaB6oD1beoE095kjFjFNhu62lcN6PDKfm6TaPdJL0HVxBrrQgOP61FO63OTmpTetcW0O1ZlnF4FSioD3wVkVQIXzmiYOen9iY/F/5KGYMXqzSN+ie9TudxTh9LRIa+OaePhf49idsG8RF+YbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=og7gAhEu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF361C4CEF1;
	Mon, 17 Nov 2025 13:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763384634;
	bh=mLHRse2lP8TCM6UtCPpAgpRgFlU7oFFLWpKldAxaUS8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=og7gAhEubxWK2PIaxk+PhpsRl1T141dZPXVR/3M+0mE6jEsBBUlPP0WGIXlbtztfx
	 RZMsHHJKiX24Py11mbhEbtVtUyBbb6lCyPG6NM6kUwFY0my3BmM+n2RZizwi5CAemf
	 JFvf/pSuVVVkljsfxk8w2JrRjDQ84QyLGLU2/BnLISQWRZEMB80WnVyLMcmPVjUdQE
	 agksJJIJD20rXBVLsu6bfpytqPuqnUfdQ2hb4hEfkAnWdEaFQFwCoYtHR9n3bgs+Yc
	 r25DSgMx/O8qPpkYiiZi5fJx+fKNYbi7KObXWGgRUFS1J5MGB+w6PYg9+NW3V6fGmE
	 AbR+hUXNFMacQ==
Message-ID: <534dfba8-6222-4eea-aeb8-440d47c67f5b@kernel.org>
Date: Mon, 17 Nov 2025 14:03:46 +0100
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] x86/mm: support memory-failure on 32-bits with
 SPARSEMEM
To: Xie Yuanbin <xieyuanbin1@huawei.com>, dave.hansen@intel.com
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, liaohua4@huawei.com,
 lilinjie8@huawei.com, linmiaohe@huawei.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, luto@kernel.org, mhocko@suse.com,
 mingo@redhat.com, nao.horiguchi@gmail.com, peterz@infradead.org,
 rppt@kernel.org, surenb@google.com, tglx@linutronix.de, tony.luck@intel.com,
 vbabka@suse.cz, will@kernel.org, x86@kernel.org
References: <20251105090536.11676-1-xieyuanbin1@huawei.com>
 <20251117020956.7071-1-xieyuanbin1@huawei.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251117020956.7071-1-xieyuanbin1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.11.25 03:09, Xie Yuanbin wrote:
> On Wed, 5 Nov 2025 17:05:36 +0800, Xie Yuanbin wrote:
>> On Wed, 5 Nov 2025 09:12:04 +0100, Dave Hansen wrote:
>>> Let me clarify what we need to know:
>>>
>>> Will you (or your employer) be running such updated 32bit kernels on
>>> hardware that supports MCEs.
>>>
>>> In other words: is this change driver by *real demand*
>>
>> Thanks! Asking like this, I completely understand now.
>>
>> We won't directly upgrade the kernel to 6.18.x (or later versions) to use
>> this feature, but if Linux community approves these patches, we will
>> backport it to 5.10.x and use it. I know that the page-flags in 5.10.x
>> have been exhausted, but we can work around them by adjusting
>> SECTION_SIZE_BITS/MAX_PHYSMEM_BITS to free up a page flag.
>> Another patch I submitted for arm32:
>> Link: https://lore.kernel.org/20250922021453.3939-1-xieyuanbin1@huawei.com
>> , follows the same logic.
>>
>> Currently, there is a clear demand for ARM32, while the demand for x86 is
>> still under discussion.
>>
>>> or just by "oh
>>> look, we can enable that now, I can come up with a theoretical use case
>>> but I don't know if anybody would actually care"?
>>
>> It can also be said that way. In fact, when developing the demand
>> "support MEMORY_FAILURE for 32-bit OS" in version 5.10.x, I found that the
>> latest version already supported this feature, so I submitted these
>> patches, and hope others can benefit from it as well.
> 
> Hello, David Hildenbrand and Dave Hansen!
> 
> Do you have any other comments on this patch? If you think that
> supporting memory-failure on x86_32 is meaningless, I will only submit
> patch 2 in the v3 patches.

I'd say, if nobody will really make use of that right now (customer 
request etc), just leave x86 alone for now.

-- 
Cheers

David

