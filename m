Return-Path: <linux-edac+bounces-1212-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7757B8FDF10
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 08:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 275F71F2437B
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 06:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A415446A2;
	Thu,  6 Jun 2024 06:46:09 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3857319D898;
	Thu,  6 Jun 2024 06:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717656369; cv=none; b=Tjb/kBX3r3yStLirl3hFMaLBXfp4O/WBsymhfa4RW0U5nO9zHHpqz1DehdgpSy/3Y/8+tdCJgnHdcDscV0j6wiZ30bbIOH0bGxhjCSWJjKhSCV7GmBmyshky4NgMaHU8mdVKdHiG39GeM3iXI0k+rt1H0nyydajXr+snhRAKix4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717656369; c=relaxed/simple;
	bh=TYTkF+Xuxt4yfWQNk5E6TQm5OAaWoFQgNvTLdR7qEig=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=irEX2tXJhNHYlITcaSG5cii4twN7ZbD1wIEchrofZs0oa5dw/+9gz7BjfN1/4MGE697vHKBa8uBB2zrpSxWLi+4zNRoreVjyJbwF5m5hAMPGG7IFGF7OrQxWqz1oKqYVBwffLHK5n2VHHmjirgO37HpWeOSQ4dkn82redEnl0DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VvvsK22rPzPkR3;
	Thu,  6 Jun 2024 14:42:45 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 96EE518007E;
	Thu,  6 Jun 2024 14:46:03 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 6 Jun 2024 14:46:03 +0800
Message-ID: <be3d958b-fc14-482f-bb7d-9ecf7d1693ab@huawei.com>
Date: Thu, 6 Jun 2024 14:46:02 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/13] mm/memory-failure: simplify put_ref_page()
Content-Language: en-US
To: Miaohe Lin <linmiaohe@huawei.com>, <akpm@linux-foundation.org>,
	<tony.luck@intel.com>, <bp@alien8.de>
CC: <nao.horiguchi@gmail.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
References: <20240606063247.712575-1-linmiaohe@huawei.com>
 <20240606063247.712575-2-linmiaohe@huawei.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20240606063247.712575-2-linmiaohe@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/6/6 14:32, Miaohe Lin wrote:
> Remove unneeded page != NULL check. pfn_to_page() won't return NULL.
> No functional change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/memory-failure.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index f679b579d45d..2e6038c73119 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2120,14 +2120,10 @@ static inline unsigned long folio_free_raw_hwp(struct folio *folio, bool flag)
>   /* Drop the extra refcount in case we come from madvise() */
>   static void put_ref_page(unsigned long pfn, int flags)

Since all calllers have a valid page，better to pass the page instead of 
pfn?

>   {
> -	struct page *page;
> -
>   	if (!(flags & MF_COUNT_INCREASED))
>   		return;
>   
> -	page = pfn_to_page(pfn);
> -	if (page)
> -		put_page(page);
> +	put_page(pfn_to_page(pfn));
>   }
>   
>   static int memory_failure_dev_pagemap(unsigned long pfn, int flags,

