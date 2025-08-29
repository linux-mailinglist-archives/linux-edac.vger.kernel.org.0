Return-Path: <linux-edac+bounces-4705-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20739B3B385
	for <lists+linux-edac@lfdr.de>; Fri, 29 Aug 2025 08:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D603A686966
	for <lists+linux-edac@lfdr.de>; Fri, 29 Aug 2025 06:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B59252287;
	Fri, 29 Aug 2025 06:35:23 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE3424678F;
	Fri, 29 Aug 2025 06:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756449323; cv=none; b=rEJouBKW9BBea1g81G5X03IZaOSKzsSltNO2siIwVdoRtVVFUBNhLCXrmH0SvUH+ql9Cv5cu//DimdqpU+7dMmwOc3i3+9/QQ+0lSYgUe/y/AKgpVkFc5f4NaxL68jL5EOEHJo2pcrHs0pqgclT3uxjTOI0RCrVmRYBNtj+2Dt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756449323; c=relaxed/simple;
	bh=qNSa3vT4vKkOD8AfmP9VFRjmOPRIZ4iRZU4tVSSLGjI=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=OVerczcKLSmHAHB/Bmh+m9SLeCn2Ntaol2K6kX0bxiV7IQ4HoIjpaMiw1clOjuhUD+YKNj+5qXWtzLVEHHq4HBFdTEtkz4KoNAcWsNdoCj3Tbab0H2HWyBzLRg9c82rSs9WWPLCB03/3YUN+HZxcih3wbSiQFuMSDVKwUIvvA3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cCpM75CvWz13NLn;
	Fri, 29 Aug 2025 14:31:31 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 710101800B1;
	Fri, 29 Aug 2025 14:35:16 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 29 Aug 2025 14:35:16 +0800
Received: from [10.173.125.236] (10.173.125.236) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 29 Aug 2025 14:35:14 +0800
Subject: Re: [PATCH v2] mm/memory-failure: Fix redundant updates for already
 poisoned pages
To: Kyle Meyer <kyle.meyer@hpe.com>
CC: <bp@alien8.de>, <david@redhat.com>, <Liam.Howlett@oracle.com>,
	<linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <lorenzo.stoakes@oracle.com>, <mhocko@suse.com>,
	<nao.horiguchi@gmail.com>, <osalvador@suse.de>, <rppt@kernel.org>,
	<russ.anderson@hpe.com>, <surenb@google.com>, <tony.luck@intel.com>,
	<vbabka@suse.cz>, <akpm@linux-foundation.org>, <jane.chu@oracle.com>,
	<jiaqiyan@google.com>
References: <aLCiHMy12Ck3ouwC@hpe.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <555fda23-4617-0898-df9c-ed1301726b26@huawei.com>
Date: Fri, 29 Aug 2025 14:35:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aLCiHMy12Ck3ouwC@hpe.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2025/8/29 2:38, Kyle Meyer wrote:
> Duplicate memory errors can be reported by multiple sources.
> 
> Passing an already poisoned page to action_result() causes issues:
> 
> * The amount of hardware corrupted memory is incorrectly updated.
> * Per NUMA node MF stats are incorrectly updated.
> * Redundant "already poisoned" messages are printed.
> 
> Avoid those issues by:
> 
> * Skipping hardware corrupted memory updates for already poisoned pages.
> * Skipping per NUMA node MF stats updates for already poisoned pages.
> * Dropping redundant "already poisoned" messages.
> 
> Make MF_MSG_ALREADY_POISONED consistent with other action_page_types and
> make calls to action_result() consistent for already poisoned
> normal pages and huge pages.
> 
> Fixes: b8b9488d50b7 ("mm/memory-failure: improve memory failure action_result messages")
> Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>

Thanks for your patch. This patch looks good to me.

Acked-by: Miaohe Lin <linmiaohe@huawei.com>
Thanks.
.

> ---
> 
> v1 -> v2:
>  * Continue passing poisoned pages to action_result() with MF_FAILED but don't
> update anything.
>  * https://lore.kernel.org/all/20250821164445.14467-1-kyle.meyer@hpe.com
> 
> ---
>  mm/memory-failure.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index fc30ca4804bf..10b3c281c2ae 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -956,7 +956,7 @@ static const char * const action_page_types[] = {
>  	[MF_MSG_BUDDY]			= "free buddy page",
>  	[MF_MSG_DAX]			= "dax page",
>  	[MF_MSG_UNSPLIT_THP]		= "unsplit thp",
> -	[MF_MSG_ALREADY_POISONED]	= "already poisoned",
> +	[MF_MSG_ALREADY_POISONED]	= "already poisoned page",
>  	[MF_MSG_UNKNOWN]		= "unknown page",
>  };
>  
> @@ -1349,9 +1349,10 @@ static int action_result(unsigned long pfn, enum mf_action_page_type type,
>  {
>  	trace_memory_failure_event(pfn, type, result);
>  
> -	num_poisoned_pages_inc(pfn);
> -
> -	update_per_node_mf_stats(pfn, result);
> +	if (type != MF_MSG_ALREADY_POISONED) {
> +		num_poisoned_pages_inc(pfn);
> +		update_per_node_mf_stats(pfn, result);
> +	}
>  
>  	pr_err("%#lx: recovery action for %s: %s\n",
>  		pfn, action_page_types[type], action_name[result]);
> @@ -2094,12 +2095,11 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
>  		*hugetlb = 0;
>  		return 0;
>  	} else if (res == -EHWPOISON) {
> -		pr_err("%#lx: already hardware poisoned\n", pfn);
>  		if (flags & MF_ACTION_REQUIRED) {
>  			folio = page_folio(p);
>  			res = kill_accessing_process(current, folio_pfn(folio), flags);
> -			action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
>  		}
> +		action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
>  		return res;
>  	} else if (res == -EBUSY) {
>  		if (!(flags & MF_NO_RETRY)) {
> @@ -2285,7 +2285,6 @@ int memory_failure(unsigned long pfn, int flags)
>  		goto unlock_mutex;
>  
>  	if (TestSetPageHWPoison(p)) {
> -		pr_err("%#lx: already hardware poisoned\n", pfn);
>  		res = -EHWPOISON;
>  		if (flags & MF_ACTION_REQUIRED)
>  			res = kill_accessing_process(current, pfn, flags);
> 


