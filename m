Return-Path: <linux-edac+bounces-1239-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F16418FFAF4
	for <lists+linux-edac@lfdr.de>; Fri,  7 Jun 2024 06:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A10A128D134
	for <lists+linux-edac@lfdr.de>; Fri,  7 Jun 2024 04:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E33C383BD;
	Fri,  7 Jun 2024 04:38:39 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF2229428;
	Fri,  7 Jun 2024 04:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717735119; cv=none; b=oG+gQ5mf3eyjquevM1zyVsiczt83rUECQJNm4OSN1L+GnenVrh+RH7QjoWuycDQDO1le/CYBZZffwpuk2+gcQt0KuIIj4h/kcMNbxda89wUon6JashI/zVVyOS9Rdycaxit8Ljh0U8SYrsg5aNq/UfI4hmfk1ZJd/SN2v4LYttw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717735119; c=relaxed/simple;
	bh=vac7htRjP7+xLahxrQT74cj20v7bpo9RsBX5+L4ZlqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EskVON8td0aiPAZeUDFuSyoG8a0MP5C1vUN+z2KBypDbUuYr3rOJbukfAOZnckjGW5FHrjMx8Z+nRJCAwTWjIn5/v5gEm5p35SDQP/s6TsYzKRPc3fRn/sKDLxAKoSm8LqS+sPoKTdKT0GwRqB/CCRB6lXT/kud6jwzN7xTXkns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VwSyy4JZBzwRv6;
	Fri,  7 Jun 2024 12:34:34 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 873A618007E;
	Fri,  7 Jun 2024 12:38:33 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 7 Jun 2024 12:38:33 +0800
Message-ID: <20253c7b-fdf9-47db-a388-ab34b8658a2a@huawei.com>
Date: Fri, 7 Jun 2024 12:38:32 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/13] mm/memory-failure: simplify put_ref_page()
Content-Language: en-US
To: Miaohe Lin <linmiaohe@huawei.com>
CC: <nao.horiguchi@gmail.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>
References: <20240606063247.712575-1-linmiaohe@huawei.com>
 <20240606063247.712575-2-linmiaohe@huawei.com>
 <be3d958b-fc14-482f-bb7d-9ecf7d1693ab@huawei.com>
 <d16db200-1e34-00f1-6b0a-20f650f389bf@huawei.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <d16db200-1e34-00f1-6b0a-20f650f389bf@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 2024/6/7 11:28, Miaohe Lin wrote:
> On 2024/6/6 14:46, Kefeng Wang wrote:
>>
>>
>> On 2024/6/6 14:32, Miaohe Lin wrote:
>>> Remove unneeded page != NULL check. pfn_to_page() won't return NULL.
>>> No functional change intended.
>>>
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>> ---
>>>    mm/memory-failure.c | 6 +-----
>>>    1 file changed, 1 insertion(+), 5 deletions(-)
>>>
>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>> index f679b579d45d..2e6038c73119 100644
>>> --- a/mm/memory-failure.c
>>> +++ b/mm/memory-failure.c
>>> @@ -2120,14 +2120,10 @@ static inline unsigned long folio_free_raw_hwp(struct folio *folio, bool flag)
>>>    /* Drop the extra refcount in case we come from madvise() */
>>>    static void put_ref_page(unsigned long pfn, int flags)
>>
>> Since all calllers have a valid page，better to pass the page instead of pfn?
> 
> Seems not. put_ref_page() called above memory_failure_dev_pagemap() seems don't have a valid page yet.
> Also page might be NULL when calling put_ref_page() in soft_offline_page(). So it should be better to
> still pass pfn. Or am I miss something?

Yes, missing it, please ignore it
> 
> Thanks.
> .
> 

