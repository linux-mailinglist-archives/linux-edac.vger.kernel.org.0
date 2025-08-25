Return-Path: <linux-edac+bounces-4648-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62631B33468
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 05:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EFFB3A5E6C
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 03:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B361A23A4;
	Mon, 25 Aug 2025 03:04:52 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C81AB661;
	Mon, 25 Aug 2025 03:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756091092; cv=none; b=KXW/LjA27ksr7CzZY26Dt7m33o1Hk0XOQydjok+jsZlii72nZSXy2kQlmnuN/MkCyjX3CnT3YEsl7a4OhOKirpPYaZ0t0KVeh2YcGhSORseyCC7SnIWnFxVy6Qtv378oogfBkPlPjvoMZDIDwqtQygRLbXtqqW4VBsfaySZ19A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756091092; c=relaxed/simple;
	bh=9g47+BkJaXB2Ijz96KkLEKSdqLn9g+dLROoVz+wODOU=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Ux40Ab19FWqJ4HOfRypEB0dQmwCahZFNQ/sTtaswfYH82k9fulTw++XqffLzzFKCobYtal3yP2cvd0edjRDYZeCimYKOyCwajEA5BcXZjDvjcdqyieGd05abhddfd8IgwdYi/wZKgSQukAkXUIbOcDWVU8kvTj20xbUAUEJsHSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4c9FyH2v90z14MWR;
	Mon, 25 Aug 2025 11:04:39 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 4F012180B58;
	Mon, 25 Aug 2025 11:04:45 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 25 Aug 2025 11:04:45 +0800
Received: from [10.173.125.236] (10.173.125.236) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 25 Aug 2025 11:04:43 +0800
Subject: Re: [PATCH] mm/memory-failure: Do not call action_result() on already
 poisoned pages
To: Jiaqi Yan <jiaqiyan@google.com>, Kyle Meyer <kyle.meyer@hpe.com>
CC: <akpm@linux-foundation.org>, <david@redhat.com>, <tony.luck@intel.com>,
	<bp@alien8.de>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <lorenzo.stoakes@oracle.com>,
	<Liam.Howlett@oracle.com>, <vbabka@suse.cz>, <rppt@kernel.org>,
	<surenb@google.com>, <mhocko@suse.com>, <nao.horiguchi@gmail.com>,
	<jane.chu@oracle.com>, <osalvador@suse.de>
References: <20250821164445.14467-1-kyle.meyer@hpe.com>
 <CACw3F53KmKRJyH+ajicyDUgGbPZT=U3VE4n+Jt3E62BxEiiCGA@mail.gmail.com>
 <aKd1K3ueTacGTf1W@hpe.com>
 <CACw3F527M-x=UeB0tN_sjCgp_YP_8yLkVRCLP2dLO2bzXrqWsA@mail.gmail.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <14a0dd45-388d-7a32-5ee5-44e60277271a@huawei.com>
Date: Mon, 25 Aug 2025 11:04:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CACw3F527M-x=UeB0tN_sjCgp_YP_8yLkVRCLP2dLO2bzXrqWsA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2025/8/22 8:24, Jiaqi Yan wrote:
> On Thu, Aug 21, 2025 at 12:36 PM Kyle Meyer <kyle.meyer@hpe.com> wrote:
>>
>> On Thu, Aug 21, 2025 at 11:23:48AM -0700, Jiaqi Yan wrote:
>>> On Thu, Aug 21, 2025 at 9:46 AM Kyle Meyer <kyle.meyer@hpe.com> wrote:
>>>>
>>>> Calling action_result() on already poisoned pages causes issues:
>>>>
>>>> * The amount of hardware corrupted memory is incorrectly incremented.
>>>> * NUMA node memory failure statistics are incorrectly updated.
>>>> * Redundant "already poisoned" messages are printed.
>>>
>>> All agreed.
>>>
>>>>
>>>> Do not call action_result() on already poisoned pages and drop unused
>>>> MF_MSG_ALREADY_POISONED.
>>>
>>> Hi Kyle,
>>>
>>> Patch looks great to me, just one thought...

Thanks both.

>>>
>>> Alternatively, have you thought about keeping MF_MSG_ALREADY_POISONED
>>> but changing action_result for MF_MSG_ALREADY_POISONED?
>>> - don't num_poisoned_pages_inc(pfn)
>>> - don't update_per_node_mf_stats(pfn, result)
>>> - still pr_err("%#lx: recovery action for %s: %s\n", ...)
>>> - meanwhile remove "pr_err("%#lx: already hardware poisoned\n", pfn)"
>>> in memory_failure and try_memory_failure_hugetlb
>>
>> I did consider that approach but I was concerned about passing
>> MF_MSG_ALREADY_POISONED to action_result() with MF_FAILED. The message is a
>> bit misleading.
> 
> Based on my reading the documentation for MF_* in static const char
> *action_name[]...
> 
> Yeah, for file mapped pages, kernel may not have hole-punched or
> truncated it from the file mapping (shmem and hugetlbfs for example)
> but that still considered as MF_RECOVERED, so touching a page with
> HWPoison flag doesn't mean that page was failed to be recovered
> previously.
> 
> For pages intended to be taken out of the buddy system, touching a
> page with HWPoison flag does imply it isn't isolated and hence
> MF_FAILED.

There should be other cases that memory_failure failed to isolate the
hwpoisoned pages at first time due to various reasons.

> 
> In summary, seeing the HWPoison flag again doesn't necessarily
> indicate what the recovery result was previously; it only indicate
> kernel won't re-attempt to recover?

Yes, kernel won't re-attempt to or just cannot recover.

> 
>>
>> How about introducing a new MF action result? Maybe MF_NONE? The message could
>> look something like:
> 
> Adding MF_NONE sounds fine to me, as long as we correctly document its
> meaning, which can be subtle.

Adding a new MF action result sounds good to me. But IMHO MF_NONE might not be that suitable
as kill_accessing_process might be called to kill proc in this case, so it's not "NONE".

Thanks.
.

