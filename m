Return-Path: <linux-edac+bounces-3530-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3527BA885D8
	for <lists+linux-edac@lfdr.de>; Mon, 14 Apr 2025 16:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D45CE1940CCF
	for <lists+linux-edac@lfdr.de>; Mon, 14 Apr 2025 14:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9529527A90D;
	Mon, 14 Apr 2025 14:37:29 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7AC2DFA4D;
	Mon, 14 Apr 2025 14:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744641449; cv=none; b=Zmqdz+MtSvFJlrV5BGBF6vs0B2rLPe+3wS86euBiX5pM2GUJsAKnUDMUJrO4MH5RsMSRhQwFFodvhwJ59wmgO5w0ed9YWYUsCbcnpwVNSDJ/0vFDZn95HVH/EZEXkv53VtF+4ohQlRj3z9emeZbLh9TQNBB/NKE1IQOZF/oaQmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744641449; c=relaxed/simple;
	bh=/RyjC2iNOfnZm2jgaWulSid9/ozmjHgS3tJdqrDAXDw=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JdVGoCMGczJwP5iUM+cIgTJGZvv3SbhHNUlVSpz4gK89fbwdIhm6VMkjntLjC+pF9xq87EmqVo/DM8pDraBGYtTRt2kVdT/RiK0ksMTgi5BjKgzfW8ADCO7gMS1807xmxHZ9B7NQ8cTq2s/fkeDuLkiPcTRWaKj5ixL+vgNFfCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ZbqY14QMGzHrDV;
	Mon, 14 Apr 2025 22:33:57 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 53FEC1401F4;
	Mon, 14 Apr 2025 22:37:23 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 14 Apr 2025 22:37:21 +0800
Subject: Re: [RESEND PATCH v18 1/2] ACPI: APEI: send SIGBUS to current task if
 synchronous memory error not recovered
To: Shuai Xue <xueshuai@linux.alibaba.com>, <catalin.marinas@arm.com>,
	<sudeep.holla@arm.com>, <lpieralisi@kernel.org>,
	<linux-acpi@vger.kernel.org>, <yazen.ghannam@amd.com>,
	<mark.rutland@arm.com>, <mingo@redhat.com>, <robin.murphy@arm.com>,
	<Jonathan.Cameron@Huawei.com>, <bp@alien8.de>, <rafael@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <wangkefeng.wang@huawei.com>,
	<tanxiaofei@huawei.com>, <mawupeng1@huawei.com>, <tony.luck@intel.com>,
	<linmiaohe@huawei.com>, <naoya.horiguchi@nec.com>, <james.morse@arm.com>,
	<tongtiangen@huawei.com>, <gregkh@linuxfoundation.org>, <will@kernel.org>,
	<jarkko@kernel.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<akpm@linux-foundation.org>, <linux-edac@vger.kernel.org>, <x86@kernel.org>,
	<justin.he@arm.com>, <ardb@kernel.org>, <ying.huang@linux.alibaba.com>,
	<ashish.kalra@amd.com>, <baolin.wang@linux.alibaba.com>,
	<tglx@linutronix.de>, <dave.hansen@linux.intel.com>, <lenb@kernel.org>,
	<hpa@zytor.com>, <robert.moore@intel.com>, <lvying6@huawei.com>,
	<xiexiuqi@huawei.com>, <zhuo.song@linux.alibaba.com>
References: <20250404112050.42040-1-xueshuai@linux.alibaba.com>
 <20250404112050.42040-2-xueshuai@linux.alibaba.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <0c0bc332-0323-4e43-a96b-dd5f5957ecc9@huawei.com>
Date: Mon, 14 Apr 2025 22:37:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250404112050.42040-2-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2025/4/4 19:20, Shuai Xue wrote:
> Synchronous error was detected as a result of user-space process accessing
> a 2-bit uncorrected error. The CPU will take a synchronous error exception
> such as Synchronous External Abort (SEA) on Arm64. The kernel will queue a
> memory_failure() work which poisons the related page, unmaps the page, and
> then sends a SIGBUS to the process, so that a system wide panic can be
> avoided.
> 
> However, no memory_failure() work will be queued when abnormal synchronous
> errors occur. These errors can include situations such as invalid PA,
> unexpected severity, no memory failure config support, invalid GUID
> section, etc. In such case, the user-space process will trigger SEA again.
> This loop can potentially exceed the platform firmware threshold or even
> trigger a kernel hard lockup, leading to a system reboot.
> 
> Fix it by performing a force kill if no memory_failure() work is queued
> for synchronous errors.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Reviewed-by: Jane Chu <jane.chu@oracle.com>
> ---
>   drivers/acpi/apei/ghes.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index b72772494655..50e4d924aa8b 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -799,6 +799,17 @@ static bool ghes_do_proc(struct ghes *ghes,
>   		}
>   	}
>   
> +	/*
> +	 * If no memory failure work is queued for abnormal synchronous
> +	 * errors, do a force kill.
> +	 */
> +	if (sync && !queued) {
> +		dev_err(ghes->dev,
> +			HW_ERR GHES_PFX "%s:%d: synchronous unrecoverable error (SIGBUS)\n",
> +			current->comm, task_pid_nr(current));
> +		force_sig(SIGBUS);
> +	}

I think it's reasonable to send a force kill to the task when the
synchronous memory error is not recovered.

But I hope this code will not trigger some legacy firmware issues,
let's be careful for this, so can we just introduce arch specific
callbacks for this?

Thanks
Hanjun

