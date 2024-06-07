Return-Path: <linux-edac+bounces-1236-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2DD8FFA2F
	for <lists+linux-edac@lfdr.de>; Fri,  7 Jun 2024 05:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E7021F21ABC
	for <lists+linux-edac@lfdr.de>; Fri,  7 Jun 2024 03:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D3911184;
	Fri,  7 Jun 2024 03:28:46 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55E118EA1;
	Fri,  7 Jun 2024 03:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717730926; cv=none; b=OMoun4TvyACSXsz+9UkWP2zApR3xQbW2m+EREPgyw0JjUwccxLzYtO61o5WPY3gzuZFwxlrbFf/NPMFOI0H3IFkTHmq4ax/+tPJxY8ZRGBp7x7/5wwShcWF1xLnEqJWXbeTN6mIi/GBb5v23zm6+c0R5igi0HoLzdFzBSC0gtEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717730926; c=relaxed/simple;
	bh=9ZSuRFiMb1/P9aDDtFCe5uTcEsGSZdC6VtpLYJaJU6w=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=WE+UxZkKtwsAnxrrzYxoOdDHa+1tRHynxuAWsldYJoufOGGgG3gxb3t8gQlwzTWMwl/2WH/3bzex6eMQOWeZ69GS5DlcXdMvsIk0x3gDRbTz9kcdpxqKGun0j7LKGu1nUoN/Q9FBUE+wqe433T7qFmjrhpvDDfpidnp4zuIg9AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4VwRQc55Kpz1S5ky;
	Fri,  7 Jun 2024 11:24:56 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id ED3F41402CB;
	Fri,  7 Jun 2024 11:28:39 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Jun 2024 11:28:39 +0800
Subject: Re: [PATCH v2 01/13] mm/memory-failure: simplify put_ref_page()
To: Kefeng Wang <wangkefeng.wang@huawei.com>
CC: <nao.horiguchi@gmail.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>
References: <20240606063247.712575-1-linmiaohe@huawei.com>
 <20240606063247.712575-2-linmiaohe@huawei.com>
 <be3d958b-fc14-482f-bb7d-9ecf7d1693ab@huawei.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <d16db200-1e34-00f1-6b0a-20f650f389bf@huawei.com>
Date: Fri, 7 Jun 2024 11:28:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <be3d958b-fc14-482f-bb7d-9ecf7d1693ab@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/6/6 14:46, Kefeng Wang wrote:
> 
> 
> On 2024/6/6 14:32, Miaohe Lin wrote:
>> Remove unneeded page != NULL check. pfn_to_page() won't return NULL.
>> No functional change intended.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>   mm/memory-failure.c | 6 +-----
>>   1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index f679b579d45d..2e6038c73119 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -2120,14 +2120,10 @@ static inline unsigned long folio_free_raw_hwp(struct folio *folio, bool flag)
>>   /* Drop the extra refcount in case we come from madvise() */
>>   static void put_ref_page(unsigned long pfn, int flags)
> 
> Since all calllers have a valid page，better to pass the page instead of pfn?

Seems not. put_ref_page() called above memory_failure_dev_pagemap() seems don't have a valid page yet.
Also page might be NULL when calling put_ref_page() in soft_offline_page(). So it should be better to
still pass pfn. Or am I miss something?

Thanks.
.


