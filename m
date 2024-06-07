Return-Path: <linux-edac+bounces-1240-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448268FFC86
	for <lists+linux-edac@lfdr.de>; Fri,  7 Jun 2024 09:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E4E61C2508D
	for <lists+linux-edac@lfdr.de>; Fri,  7 Jun 2024 07:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB7C37169;
	Fri,  7 Jun 2024 07:00:21 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441D31095B;
	Fri,  7 Jun 2024 07:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717743621; cv=none; b=GwMjf7yA85OLtwaNZ79WTg/xeG00VQhXcO14iYKEqZTaozaUrI0bf6k/HnTU/oGKqvv+W7g4mM8A7fthxY8/3J4rz/HsirXqUivIdxmsuUAxAvc4joiyR/oGxrllRppLNDPs7ME7M1fhretDJan8pd72zOY8nkWtwDtzj7Y0zQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717743621; c=relaxed/simple;
	bh=84yQihkMMkjXXKHvr4udFnc211ytJn+D0v7SvxUVexI=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=iCYnwWlc50fKoyhkaY0uJslW03UzdV+3paAZhgIVoUbn5B12gzuVPubRYV3om+j3sT7eG8uH6U4SwczoM3Wo0KGVq9m1uKcH58vi+7A/QlCYydqLcZ0s7pFIRRsybYNNDfY2WklPNVWdpwrRslIyWlXmGTYKujddVGQPCglWRzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VwX6K4fg1zsTTP;
	Fri,  7 Jun 2024 14:56:09 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 6EF9C18007E;
	Fri,  7 Jun 2024 15:00:08 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Jun 2024 15:00:07 +0800
Subject: Re: [PATCH v2 10/13] mm/memory-failure: move some function
 declarations into internal.h
To: Matthew Wilcox <willy@infradead.org>
CC: <akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<nao.horiguchi@gmail.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
References: <20240606063247.712575-1-linmiaohe@huawei.com>
 <20240606063247.712575-11-linmiaohe@huawei.com>
 <ZmKC0Z3omr04grkj@casper.infradead.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <1f3bdaf8-bc9b-1dc9-b06c-e670a906dc1b@huawei.com>
Date: Fri, 7 Jun 2024 15:00:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZmKC0Z3omr04grkj@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/6/7 11:47, Matthew Wilcox wrote:
> On Thu, Jun 06, 2024 at 02:32:44PM +0800, Miaohe Lin wrote:
>> +++ b/mm/internal.h
>> @@ -1077,6 +1077,16 @@ extern u64 hwpoison_filter_flags_mask;
>>  extern u64 hwpoison_filter_flags_value;
>>  extern u64 hwpoison_filter_memcg;
>>  extern u32 hwpoison_filter_enable;
>> +#define MAGIC_HWPOISON	0x48575053U	/* HWPS */
>> +extern void SetPageHWPoisonTakenOff(struct page *page);
>> +extern void ClearPageHWPoisonTakenOff(struct page *page);
>> +extern bool take_page_off_buddy(struct page *page);
>> +extern bool put_page_back_buddy(struct page *page);
> 
> s/extern// for function declarations.

Will do in next version.
Thanks.
.

