Return-Path: <linux-edac+bounces-3032-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F8BA320A1
	for <lists+linux-edac@lfdr.de>; Wed, 12 Feb 2025 09:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45CC9163B43
	for <lists+linux-edac@lfdr.de>; Wed, 12 Feb 2025 08:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19437204C1B;
	Wed, 12 Feb 2025 08:09:19 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31192046AD;
	Wed, 12 Feb 2025 08:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739347759; cv=none; b=kU4ncv6306x7ap6DQFePBir6DBIAv4MkUgJWzJL0AmYL7koJYSHy1SzZUv/xoYX5R+xmov04Ey1SsOi3TqZRcXNZ6lvou7sMrPmqaZFeFTiFcp/7EQ4yIy3d5PcxEyhGGY1GPOBrn77S5SlnoSnvcZ9qOXm+GBlBYygN+V5AtcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739347759; c=relaxed/simple;
	bh=Hswue5MGF5m27Goc5Gy8v6ReichRB1wMgt8PbHdHc2s=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Ip12zbsTYqHmJppesnFnFa8q3Ez/OaXXaMrmKle1fyDJRs4+NfWWns7YfPg1i8yIvdXYoNlV3Pteq0h4snx6hGOb3rpxM8BPvz3UPBtw2uqsSc/53dH/HagNkYgpB/vaORRysE3NPgsS45uhVoQWdEd12qGECFNf/LGRCQXOSmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Yt9q95D9MzkXN3;
	Wed, 12 Feb 2025 16:05:41 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id 3251B1802D0;
	Wed, 12 Feb 2025 16:09:14 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 kwepemd200019.china.huawei.com (7.221.188.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 12 Feb 2025 16:09:13 +0800
Subject: Re: [PATCH v1 4/4] mm/hwpoison: Fix incorrect "not recovered" report
 for recovered clean pages
To: Shuai Xue <xueshuai@linux.alibaba.com>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <baolin.wang@linux.alibaba.com>,
	<tianruidong@linux.alibaba.com>, <tony.luck@intel.com>, <bp@alien8.de>,
	<nao.horiguchi@gmail.com>
References: <20250211060200.33845-1-xueshuai@linux.alibaba.com>
 <20250211060200.33845-5-xueshuai@linux.alibaba.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <5f116840-60df-c6d9-d7ff-dcf1dce7773f@huawei.com>
Date: Wed, 12 Feb 2025 16:09:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250211060200.33845-5-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200019.china.huawei.com (7.221.188.193)

On 2025/2/11 14:02, Shuai Xue wrote:
> When an uncorrected memory error is consumed there is a race between
> the CMCI from the memory controller reporting an uncorrected error
> with a UCNA signature, and the core reporting and SRAR signature
> machine check when the data is about to be consumed.
> 
> If the CMCI wins that race, the page is marked poisoned when
> uc_decode_notifier() calls memory_failure(). For dirty pages,
> memory_failure() invokes try_to_unmap() with the TTU_HWPOISON flag,
> converting the PTE to a hwpoison entry. However, for clean pages, the
> TTU_HWPOISON flag is cleared, leaving the PTE unchanged and not converted
> to a hwpoison entry. Consequently, for an unmapped dirty page, the PTE is
> marked as a hwpoison entry allowing kill_accessing_process() to:
> 
> - call walk_page_range() and return 1
> - call kill_proc() to make sure a SIGBUS is sent
> - return -EHWPOISON to indicate that SIGBUS is already sent to the process
>   and kill_me_maybe() doesn't have to send it again.
> 
> Conversely, for clean pages where PTE entries are not marked as hwpoison,
> kill_accessing_process() returns -EFAULT, causing kill_me_maybe() to send a
> SIGBUS.
> 
> Console log looks like this:
> 
>     Memory failure: 0x827ca68: corrupted page was clean: dropped without side effects
>     Memory failure: 0x827ca68: recovery action for clean LRU page: Recovered
>     Memory failure: 0x827ca68: already hardware poisoned
>     mce: Memory error not recovered
> 
> To fix it, return -EHWPOISON if no hwpoison PTE entry is found, preventing
> an unnecessary SIGBUS.

Thanks for your patch.

> 
> Fixes: 046545a661af ("mm/hwpoison: fix error page recovered but reported "not recovered"")
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
>  mm/memory-failure.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 995a15eb67e2..f9a6b136a6f0 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -883,10 +883,9 @@ static int kill_accessing_process(struct task_struct *p, unsigned long pfn,
>  			      (void *)&priv);
>  	if (ret == 1 && priv.tk.addr)
>  		kill_proc(&priv.tk, pfn, flags);
> -	else
> -		ret = 0;
>  	mmap_read_unlock(p->mm);
> -	return ret > 0 ? -EHWPOISON : -EFAULT;
> +
> +	return ret >= 0 ? -EHWPOISON : -EFAULT;

IIUC, kill_accessing_process() is supposed to return -EHWPOISON to notify that SIGBUS is already
sent to the process and kill_me_maybe() doesn't have to send it again. But with your change,
kill_accessing_process() will return -EHWPOISON even if SIGBUS is not sent. Does this break
the semantics of -EHWPOISON?

BTW I scanned the code of walk_page_range(). It seems with implementation of hwpoison_walk_ops
walk_page_range() will only return 0 or 1, i.e. always >= 0. So kill_accessing_process() will always
return -EHWPOISON if this patch is applied.

Correct me if I miss something.

Thanks.
.

