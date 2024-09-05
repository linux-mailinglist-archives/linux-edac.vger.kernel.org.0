Return-Path: <linux-edac+bounces-1815-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E579396CCE8
	for <lists+linux-edac@lfdr.de>; Thu,  5 Sep 2024 05:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A10BE2859C7
	for <lists+linux-edac@lfdr.de>; Thu,  5 Sep 2024 03:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09A31465A9;
	Thu,  5 Sep 2024 03:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RmrAbVvA"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254B41448C7;
	Thu,  5 Sep 2024 03:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725505459; cv=none; b=cdN8qM3iaEz9vwLxdqMl8xEfbhsHR59cL4vle2KfYFU7ffZfNEEfFCMkyo8KYms7V8xWnlkDK56aXc7B6GK8f0jXrtA7k2bfuTDC0rR3nzJD6VtxaTAASvjPY0adA8172KVHuLqkRH1t2nPe2K7ypvDmOOElHGrouHicTgObEV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725505459; c=relaxed/simple;
	bh=7GdYfRNzrCCZuilokKtXRCmGGQXdXKTLbn56/sVnFFo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CZ3AbOqoGAsAL28OdO6bb3yIJmn7fhxVyOrqQ85byqDCiNB0YHdbosFsyTerYDFaxfvchavtHcPhmgXmbeCvKA0jYvINXUBc0RhbL4pLbE4gDiYoaPtVmzsRagGwU4O8fCuSBE794T9GK+aow5seOgkeSulcfNRm/HDhu0PUR0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RmrAbVvA; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725505449; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=GDVRuhXoCkztJWuUnUtFfnUSjUnxHDl6SdZdNPHpDvI=;
	b=RmrAbVvAsKRpX3PwvsUZ09TXaKrc7esqwkpG3puATjoSAeYWRUMbQ1YKEFyWRdr29yNuVgnVceKKJfiNRZoqQh75pt7VlNoD1U/cs9nIR3NHEtk41DwoPIq6bijkeeYGhIHV4YFoEqKMSx5b68JoYOZ/2XllsmqQypUrPUkd0LQ=
Received: from 30.246.162.144(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WEJd.uX_1725505445)
          by smtp.aliyun-inc.com;
          Thu, 05 Sep 2024 11:04:07 +0800
Message-ID: <bf984773-2a8e-4528-9af1-9775fdc7c4e2@linux.alibaba.com>
Date: Thu, 5 Sep 2024 11:04:04 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v12 1/3] ACPI: APEI: send SIGBUS to current task if
 synchronous memory error not recovered
To: Jarkko Sakkinen <jarkko@kernel.org>, bp@alien8.de, rafael@kernel.org,
 wangkefeng.wang@huawei.com, tanxiaofei@huawei.com, mawupeng1@huawei.com,
 tony.luck@intel.com, linmiaohe@huawei.com, naoya.horiguchi@nec.com,
 james.morse@arm.com, tongtiangen@huawei.com, gregkh@linuxfoundation.org,
 will@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 linux-edac@vger.kernel.org, x86@kernel.org, justin.he@arm.com,
 ardb@kernel.org, ying.huang@intel.com, ashish.kalra@amd.com,
 baolin.wang@linux.alibaba.com, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, lenb@kernel.org, hpa@zytor.com,
 robert.moore@intel.com, lvying6@huawei.com, xiexiuqi@huawei.com,
 zhuo.song@linux.alibaba.com
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20240902030034.67152-2-xueshuai@linux.alibaba.com>
 <D3WS2P2DU0CE.SANBOLMHG6TC@kernel.org>
In-Reply-To: <D3WS2P2DU0CE.SANBOLMHG6TC@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/9/4 00:09, Jarkko Sakkinen 写道:
> On Mon Sep 2, 2024 at 6:00 AM EEST, Shuai Xue wrote:
>> Synchronous error was detected as a result of user-space process accessing
>> a 2-bit uncorrected error. The CPU will take a synchronous error exception
>> such as Synchronous External Abort (SEA) on Arm64. The kernel will queue a
>> memory_failure() work which poisons the related page, unmaps the page, and
>> then sends a SIGBUS to the process, so that a system wide panic can be
>> avoided.
>>
>> However, no memory_failure() work will be queued unless all bellow
>> preconditions check passed:
>>
>> - `if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))` in ghes_handle_memory_failure()
>> - `if (flags == -1)` in ghes_handle_memory_failure()
>> - `if (!IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))` in ghes_do_memory_failure()
>> - `if (!pfn_valid(pfn) && !arch_is_platform_page(physical_addr)) ` in ghes_do_memory_failure()
>>
>> In such case, the user-space process will trigger SEA again.  This loop
>> can potentially exceed the platform firmware threshold or even trigger a
>> kernel hard lockup, leading to a system reboot.
>>
>> Fix it by performing a force kill if no memory_failure() work is queued
>> for synchronous errors.
>>
>> Suggested-by: Xiaofei Tan <tanxiaofei@huawei.com>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>>
>> ---
>>   drivers/acpi/apei/ghes.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 623cc0cb4a65..b0b20ee533d9 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -801,6 +801,16 @@ static bool ghes_do_proc(struct ghes *ghes,
>>   		}
>>   	}
>>   
>> +	/*
>> +	 * If no memory failure work is queued for abnormal synchronous
>> +	 * errors, do a force kill.
>> +	 */
>> +	if (sync && !queued) {
>> +		pr_err("Sending SIGBUS to %s:%d due to hardware memory corruption\n",
>> +			current->comm, task_pid_nr(current));
> 
> Hmm... doest this need "hardware" or would "memory corruption" be
> enough?
> 
> Also, does this need to say that it is sending SIGBUS when the signal
> itself tells that already?
> 
> I.e. could "%s:%d has memory corruption" be enough information?

Hi, Jarkko,

Thank you for your suggestion. Maybe it could.

There are some similar error info which use "hardware memory error", e.g.

	static void kill_me_maybe(struct callback_head *cb)
	{
		pr_err("Uncorrected hardware memory error in user-access at %llx", 
p->mce_addr);
		...
		pr_err("Memory error not recovered");
		kill_me_now(cb);
	}
	
	static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
	{
		pr_err("%#lx: Sending SIGBUS to %s:%d due to hardware memory 
corruption\n",
				pfn, t->comm, task_pid_nr(t));
		...
			ret = force_sig_mceerr(BUS_MCEERR_AR,
					 (void __user *)tk->addr, addr_lsb);
	
	}	

So, personally, I prefer this info to be consistent with them.


Best Regards,
Shuai

