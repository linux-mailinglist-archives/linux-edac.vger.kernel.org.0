Return-Path: <linux-edac+bounces-3148-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C21A3B1AF
	for <lists+linux-edac@lfdr.de>; Wed, 19 Feb 2025 07:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E87F1726DE
	for <lists+linux-edac@lfdr.de>; Wed, 19 Feb 2025 06:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569B21B6D0F;
	Wed, 19 Feb 2025 06:34:57 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E141B425D;
	Wed, 19 Feb 2025 06:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739946897; cv=none; b=HpRnZrSU/EERrdpchd/uUViviML0V8pGz22mWi+eQZnBrARa3SZBV6XJ5XV+Z397WPw3o40AxIS9Y9ly/3vC1435816rPi8RuP+yLaiqyWe+njBxlDgLIS4URWHCTovUMzB8phPwfypeNjsefBgisKaeedtyptXIgnVvgy5Env0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739946897; c=relaxed/simple;
	bh=Nkk4tLvZQI67voOW8z5AeTYS2qk07OSNLO01/1b3FM4=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=YW6yNT4zYD8uryOehXxaH9qjj4usz1c6mcl6nhY1UNvkxc3YxBJYQ3kw/a1YzMKhWJOemBfQ7p/I7fVUKdH4y1WWxTmtt9pkyFfn5pa8No+QnjkqTnc7ECbr24L1jEVZIAloQAnyuK9We2PAilUaKZrZjxp7P16OjCb6irrBrZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4YyRMr1d4vz1Y1t2;
	Wed, 19 Feb 2025 14:30:16 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id 0897A140159;
	Wed, 19 Feb 2025 14:34:52 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 kwepemd200019.china.huawei.com (7.221.188.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 19 Feb 2025 14:34:50 +0800
Subject: Re: [PATCH v2 4/5] mm/hwpoison: Fix incorrect "not recovered" report
 for recovered clean pages
To: Shuai Xue <xueshuai@linux.alibaba.com>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<peterz@infradead.org>, <jpoimboe@kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<baolin.wang@linux.alibaba.com>, <tianruidong@linux.alibaba.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <nao.horiguchi@gmail.com>
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
 <20250217063335.22257-5-xueshuai@linux.alibaba.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <ddd769c2-a17d-9e34-822d-66f72bd654ac@huawei.com>
Date: Wed, 19 Feb 2025 14:34:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250217063335.22257-5-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200019.china.huawei.com (7.221.188.193)

On 2025/2/17 14:33, Shuai Xue wrote:
> When an uncorrected memory error is consumed there is a race between
> the CMCI from the memory controller reporting an uncorrected error
> with a UCNA signature, and the core reporting and SRAR signature
> machine check when the data is about to be consumed.
> 
> If the CMCI wins that race, the page is marked poisoned when
> uc_decode_notifier() calls memory_failure(). For dirty pages,
> memory_failure() invokes try_to_unmap() with the TTU_HWPOISON flag,
> converting the PTE to a hwpoison entry. As a result,
> kill_accessing_process():
> 
> - call walk_page_range() and return 1 regardless of whether
>   try_to_unmap() succeeds or fails,
> - call kill_proc() to make sure a SIGBUS is sent
> - return -EHWPOISON to indicate that SIGBUS is already sent to the
>   process and kill_me_maybe() doesn't have to send it again.
> 
> However, for clean pages, the TTU_HWPOISON flag is cleared, leaving the
> PTE unchanged and not converted to a hwpoison entry. Conversely, for
> clean pages where PTE entries are not marked as hwpoison,
> kill_accessing_process() returns -EFAULT, causing kill_me_maybe() to
> send a SIGBUS.
> 
> Console log looks like this:
> 
>     Memory failure: 0x827ca68: corrupted page was clean: dropped without side effects
>     Memory failure: 0x827ca68: recovery action for clean LRU page: Recovered
>     Memory failure: 0x827ca68: already hardware poisoned
>     mce: Memory error not recovered
> 
> To fix it, return 0 for "corrupted page was clean", preventing an
> unnecessary SIGBUS.
> 
> Fixes: 046545a661af ("mm/hwpoison: fix error page recovered but reported "not recovered"")
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Cc: stable@vger.kernel.org
> ---
>  mm/memory-failure.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 995a15eb67e2..b037952565be 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -881,12 +881,17 @@ static int kill_accessing_process(struct task_struct *p, unsigned long pfn,
>  	mmap_read_lock(p->mm);
>  	ret = walk_page_range(p->mm, 0, TASK_SIZE, &hwpoison_walk_ops,
>  			      (void *)&priv);
> +	/*
> +	 * ret = 1 when CMCI wins, regardless of whether try_to_unmap()
> +	 * succeeds or fails, then kill the process with SIGBUS.
> +	 * ret = 0 when poison page is a clean page and it's dropped, no
> +	 * SIGBUS is needed.
> +	 */
>  	if (ret == 1 && priv.tk.addr)
>  		kill_proc(&priv.tk, pfn, flags);
> -	else
> -		ret = 0;
>  	mmap_read_unlock(p->mm);
> -	return ret > 0 ? -EHWPOISON : -EFAULT;
> +
> +	return ret > 0 ? -EHWPOISON : 0;

The caller kill_me_maybe will do set_mce_nospec + sync_core again.

static void kill_me_maybe(struct callback_head *cb)
{
	struct task_struct *p = container_of(cb, struct task_struct, mce_kill_me);
	int flags = MF_ACTION_REQUIRED;
	...
	ret = memory_failure(pfn, flags);
	if (!ret) {
		set_mce_nospec(pfn);
		sync_core();
		return;
	}

Is this expected?

Thanks.
.

