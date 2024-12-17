Return-Path: <linux-edac+bounces-2731-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 729A39F411F
	for <lists+linux-edac@lfdr.de>; Tue, 17 Dec 2024 04:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D144188C6CC
	for <lists+linux-edac@lfdr.de>; Tue, 17 Dec 2024 03:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09E9537F8;
	Tue, 17 Dec 2024 03:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PH0/0c/O"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87027182CD;
	Tue, 17 Dec 2024 03:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734404727; cv=none; b=D8VD8FjSb009TrBpbenexAAnPVGG/k0cW0cohbzMDTys3cQ52IKT7a/ZJcRu9MuBXhcCJbIvLB2mZYms6ApL9Dlu+fKyCRHZPfmq/DRcuq5hhD5iapXQ0T8cjMX2+fN0Bkb8qJI9Bnv9rHBkqXX9f4SbqpQNzIR3CifSogtQo0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734404727; c=relaxed/simple;
	bh=/IhZ886Fl+MVJYlsp68aj9MUHIJ+gquw8xBlKwpHNT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jLJ2npDRTSH8fzETC4fHsgec93dbHBrhMVZ/JGmTTTLEQJNgifi2R6kY7ZDmqg77TEnaN9m3r1fiTtwjcvaG3ArLyRWQxIDWQBz2XUY1ARaUoOxp6XbJiV95NF+g2F5JkAQOTHGCoA85nZMRX5O9zDx7CQvB5XL0fUHmMIkpZpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PH0/0c/O; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734404715; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=JYaV8tUHY5DY/QNPB9vrWmARi1TH7zIIIk5o2rlYGdA=;
	b=PH0/0c/OtyMeIukeEL7h1vhk9BKDpn+ZIVdSD18qd15tHEa76qiPQCsamM8cUPGt5kv58LchXUuWvEF/JlrLa1xRwvLvR6Lq1817LQfPeY1C5BYXm5pSxEj6qRkuIGTg6eYR47mYBbDM6ekhsT99gftVJePZyaX87WjpI7orccQ=
Received: from 30.246.161.240(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WLh6bXS_1734404711 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 17 Dec 2024 11:05:13 +0800
Message-ID: <1e0a0f9b-7c58-4f70-b2d4-6b3c2c4143de@linux.alibaba.com>
Date: Tue, 17 Dec 2024 11:05:11 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 2/3] mm: memory-failure: move return value
 documentation to function declaration
To: jane.chu@oracle.com, yazen.ghannam@amd.com, mark.rutland@arm.com,
 catalin.marinas@arm.com, mingo@redhat.com, robin.murphy@arm.com,
 Jonathan.Cameron@Huawei.com, bp@alien8.de, rafael@kernel.org,
 linux-arm-kernel@lists.infradead.org, wangkefeng.wang@huawei.com,
 tanxiaofei@huawei.com, mawupeng1@huawei.com, tony.luck@intel.com,
 linmiaohe@huawei.com, naoya.horiguchi@nec.com, james.morse@arm.com,
 tongtiangen@huawei.com, gregkh@linuxfoundation.org, will@kernel.org,
 jarkko@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 linux-edac@vger.kernel.org, x86@kernel.org, justin.he@arm.com,
 ardb@kernel.org, ying.huang@intel.com, ashish.kalra@amd.com,
 baolin.wang@linux.alibaba.com, tglx@linutronix.de,
 dave.hansen@linux.intel.com, lenb@kernel.org, hpa@zytor.com,
 robert.moore@intel.com, lvying6@huawei.com, xiexiuqi@huawei.com,
 zhuo.song@linux.alibaba.com
References: <20241202030527.20586-1-xueshuai@linux.alibaba.com>
 <20241202030527.20586-3-xueshuai@linux.alibaba.com>
 <51d231c2-3659-461a-b6c3-d0e7f9fddfc1@oracle.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <51d231c2-3659-461a-b6c3-d0e7f9fddfc1@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/12/17 07:37, jane.chu@oracle.com 写道:
> 
> On 12/1/2024 7:05 PM, Shuai Xue wrote:
>> Part of return value comments for memory_failure() were originally
>> documented at the call site. Move those comments to the function
>> declaration to improve code readability and to provide developers with
>> immediate access to function usage and return information.
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
>> ---
>>   arch/x86/kernel/cpu/mce/core.c |  7 -------
>>   mm/memory-failure.c            | 10 +++++++---
>>   2 files changed, 7 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
>> index 7fb5556a0b53..d1dd7f892514 100644
>> --- a/arch/x86/kernel/cpu/mce/core.c
>> +++ b/arch/x86/kernel/cpu/mce/core.c
>> @@ -1398,13 +1398,6 @@ static void kill_me_maybe(struct callback_head *cb)
>>           return;
>>       }
>> -    /*
>> -     * -EHWPOISON from memory_failure() means that it already sent SIGBUS
>> -     * to the current process with the proper error info,
>> -     * -EOPNOTSUPP means hwpoison_filter() filtered the error event,
>> -     *
>> -     * In both cases, no further processing is required.
>> -     */
>>       if (ret == -EHWPOISON || ret == -EOPNOTSUPP)
>>           return;
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index a7b8ccd29b6f..14c316d7d38d 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -2211,9 +2211,13 @@ static void kill_procs_now(struct page *p, unsigned long pfn, int flags,
>>    * Must run in process context (e.g. a work queue) with interrupts
>>    * enabled and no spinlocks held.
>>    *
>> - * Return: 0 for successfully handled the memory error,
>> - *         -EOPNOTSUPP for hwpoison_filter() filtered the error event,
>> - *         < 0(except -EOPNOTSUPP) on failure.
>> + * Return:
>> + *   0             - success,
>> + *   -ENXIO        - memory not managed by the kernel
>> + *   -EOPNOTSUPP   - hwpoison_filter() filtered the error event,
>> + *   -EHWPOISON    - the page was already poisoned, potentially
>> + *                   kill process,
>> + *   other negative values - failure.
>>    */
>>   int memory_failure(unsigned long pfn, int flags)
>>   {
> 
> Looks good.
> 
> Reviewed-by: Jane Chu <jane.chu@oracle.com>
> 
> -jane


Thanks.

Best Regards,
Shuai

