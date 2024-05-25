Return-Path: <linux-edac+bounces-1128-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C50C48CED6D
	for <lists+linux-edac@lfdr.de>; Sat, 25 May 2024 03:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F950B20DBB
	for <lists+linux-edac@lfdr.de>; Sat, 25 May 2024 01:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F60010F1;
	Sat, 25 May 2024 01:34:27 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9DDEBB;
	Sat, 25 May 2024 01:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716600867; cv=none; b=MSPLLeBSkHFNX4/Jx4/T8uLOYKmHNhTGzjonSP63UuzdOp7tBQffHMCilX0iDwk97TcTQ421+2cgd13ZNBCZKJuW3oeS8u/1pG+vauDug9VzIFGxahT9Ds6d70UCL47EiyqlDRCnh7u7lhJFbuyxww7uyU9IVsDxxkOgwJMnmlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716600867; c=relaxed/simple;
	bh=Ww/4DxroOLtHxcOTGPiNSAggxRvgwxUi8uR9q7ehp+4=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=f9694uF/AvB3GP4zKVZlvx8Zs7dWiHaGuER+RcXrVMMuBDKL7meYuIDNBK3eq2B57E6oOS/lxA+eSU4lCFYt8lrePRyXJM4eH24wNYfmfsKRbjO7ye6wopR4qyyuid72k3NI4EyD68DdPt8ZDQMprmrfjlLuEfRmgWDXPxcuxBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VmPVl6g8JzwPbw;
	Sat, 25 May 2024 09:30:39 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 955D6180069;
	Sat, 25 May 2024 09:34:21 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 25 May 2024 09:34:21 +0800
Subject: Re: [PATCH 04/13] mm/memory-failure: save a page_folio() call
To: David Hildenbrand <david@redhat.com>
CC: <nao.horiguchi@gmail.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>
References: <20240524091310.1430048-1-linmiaohe@huawei.com>
 <20240524091310.1430048-5-linmiaohe@huawei.com>
 <65447480-f46f-4256-a093-f8232fb6ed84@redhat.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <78e22db5-791d-0086-f6a3-8c9bba2ca4cc@huawei.com>
Date: Sat, 25 May 2024 09:34:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <65447480-f46f-4256-a093-f8232fb6ed84@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/5/24 23:06, David Hildenbrand wrote:
> On 24.05.24 11:13, Miaohe Lin wrote:
>> Use local variable folio directly to save a page_folio() call.
>> No functional change intended.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>   mm/memory-failure.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index b571aaf987a2..73878ecdec22 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -1658,7 +1658,7 @@ static bool hwpoison_user_mappings(struct folio *folio, struct page *p,
>>       unmap_success = !page_mapped(p);
> 
> We should be using folio_mapped() here.

Will fix this.

> 
>>       if (!unmap_success)
>>           pr_err("%#lx: failed to unmap page (folio mapcount=%d)\n",
>> -               pfn, folio_mapcount(page_folio(p)));
>> +               pfn, folio_mapcount(folio));
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks for your comment.
.


