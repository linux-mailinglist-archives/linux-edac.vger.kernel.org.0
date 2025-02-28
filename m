Return-Path: <linux-edac+bounces-3232-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC01FA48E20
	for <lists+linux-edac@lfdr.de>; Fri, 28 Feb 2025 02:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50FB97A3179
	for <lists+linux-edac@lfdr.de>; Fri, 28 Feb 2025 01:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D7A224D6;
	Fri, 28 Feb 2025 01:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aUM/v2Vv"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495EAC2F2;
	Fri, 28 Feb 2025 01:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740707207; cv=none; b=kUl8SvhP+TTdChbCWW1XxY4HodZ2mdZwKENRvKK11l4skVKrlyA2H/WwuYCxJOrA8gZRl8arL8jy53uhh6VPPDbNOyH2Yi0d4BQLfhUJLDdb11UT+FG8B2R1kJm4TOxtZa/dK5JJh3xGgQzjiBt7cT5G3h5tgM+k04K9eC0QBko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740707207; c=relaxed/simple;
	bh=ZZHNCgut0dGMFXCWAAMpaymxZyfRxzSLiAKJxYuUhR8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SeR70Lxu0lgBczZ42Ocy5LfNJWaEBtQfarN0D+uKqxq/gUocJnZBI74GUkvYa/C6wA4vxDBRyAWYAmdYBRq+XyBCwXf7olGZ36EGqS8qu95mW6gQ9clMGB0qyjCiLKcipChTOqwq99fajVUOztjte8E9Pf1uHWrJAyIuPBSyT08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aUM/v2Vv; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740707196; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=5r+5WkyUwaatx2CtpLzuZtA6tB6jLB9WVQM6cMSk/Qs=;
	b=aUM/v2VvKf8dzM596SA5GV2hIgimrJrqAebseOLiKXRUhq5Ry+3e0I+d1ESoUaAaF1fwSV4Icafx7DQQRqrR1U8X3WDMeaaIIVNoRvL4eN5XreKk//R3RXgP01B0kaWxI9G/L0v/Xc8WePRD/0dw2ir64G/wTbz5fBss1NDwZsM=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WQNqCdH_1740707191 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 28 Feb 2025 09:46:33 +0800
Message-ID: <0c93542f-4521-41bc-a030-5b2d8621aa6a@linux.alibaba.com>
Date: Fri, 28 Feb 2025 09:46:30 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v18 2/3] mm: memory-failure: move return value
 documentation to function declaration
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: yazen.ghannam@amd.com, mark.rutland@arm.com, mingo@redhat.com,
 robin.murphy@arm.com, Jonathan.Cameron@huawei.com, bp@alien8.de,
 rafael@kernel.org, linux-arm-kernel@lists.infradead.org,
 wangkefeng.wang@huawei.com, tanxiaofei@huawei.com, mawupeng1@huawei.com,
 tony.luck@intel.com, linmiaohe@huawei.com, naoya.horiguchi@nec.com,
 james.morse@arm.com, tongtiangen@huawei.com, gregkh@linuxfoundation.org,
 will@kernel.org, jarkko@kernel.org, linux-acpi@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 linux-edac@vger.kernel.org, x86@kernel.org, justin.he@arm.com,
 ardb@kernel.org, ying.huang@linux.alibaba.com, ashish.kalra@amd.com,
 baolin.wang@linux.alibaba.com, tglx@linutronix.de,
 dave.hansen@linux.intel.com, lenb@kernel.org, hpa@zytor.com,
 robert.moore@intel.com, lvying6@huawei.com, xiexiuqi@huawei.com,
 zhuo.song@linux.alibaba.com
References: <20250107081735.16159-1-xueshuai@linux.alibaba.com>
 <20250107081735.16159-3-xueshuai@linux.alibaba.com>
 <Z8BbFRupgknBTvH8@arm.com>
In-Reply-To: <Z8BbFRupgknBTvH8@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/27 20:31, Catalin Marinas 写道:
> (going through patches in my inbox)
> 
> On Tue, Jan 07, 2025 at 04:17:34PM +0800, Shuai Xue wrote:
>> Part of return value comments for memory_failure() were originally
>> documented at the call site. Move those comments to the function
>> declaration to improve code readability and to provide developers with
> 
> s/declaration/definition/

Thanks, will fix.

> 
>> immediate access to function usage and return information.
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
>> Reviewed-by: Jane Chu <jane.chu@oracle.com>
>> ---
>>   arch/x86/kernel/cpu/mce/core.c |  7 -------
>>   mm/memory-failure.c            | 10 +++++++---
>>   2 files changed, 7 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
>> index 7fb5556a0b53..d1dd7f892514 100644
>> --- a/arch/x86/kernel/cpu/mce/core.c
>> +++ b/arch/x86/kernel/cpu/mce/core.c
>> @@ -1398,13 +1398,6 @@ static void kill_me_maybe(struct callback_head *cb)
>>   		return;
>>   	}
>>   
>> -	/*
>> -	 * -EHWPOISON from memory_failure() means that it already sent SIGBUS
>> -	 * to the current process with the proper error info,
>> -	 * -EOPNOTSUPP means hwpoison_filter() filtered the error event,
>> -	 *
>> -	 * In both cases, no further processing is required.
>> -	 */
>>   	if (ret == -EHWPOISON || ret == -EOPNOTSUPP)
>>   		return;
>>   
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index a7b8ccd29b6f..14c316d7d38d 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -2211,9 +2211,13 @@ static void kill_procs_now(struct page *p, unsigned long pfn, int flags,
>>    * Must run in process context (e.g. a work queue) with interrupts
>>    * enabled and no spinlocks held.
>>    *
>> - * Return: 0 for successfully handled the memory error,
>> - *         -EOPNOTSUPP for hwpoison_filter() filtered the error event,
>> - *         < 0(except -EOPNOTSUPP) on failure.
>> + * Return:
>> + *   0             - success,
>> + *   -ENXIO        - memory not managed by the kernel
>> + *   -EOPNOTSUPP   - hwpoison_filter() filtered the error event,
>> + *   -EHWPOISON    - the page was already poisoned, potentially
>> + *                   kill process,
>> + *   other negative values - failure.
>>    */
>>   int memory_failure(unsigned long pfn, int flags)
>>   {
> 
> Why not keep the comment in both places? One is about the x86 decisions,
> the other is about what memory_failure() can return.
> 

Ok, will keep x86 path.

By the way, could arm maintainers help to ack patch 1 and 3 if there
is no objection?

Thanks.
Shuai


