Return-Path: <linux-edac+bounces-2728-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1B49F401C
	for <lists+linux-edac@lfdr.de>; Tue, 17 Dec 2024 02:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3607169B24
	for <lists+linux-edac@lfdr.de>; Tue, 17 Dec 2024 01:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3C72AF09;
	Tue, 17 Dec 2024 01:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="X8UoPFqV"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EA279CD;
	Tue, 17 Dec 2024 01:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734399647; cv=none; b=BA/QcPhLQK5BfWQ7jNguNxT84T4pmoIEHWRT//L/8gmca964Um6EEgvxHUirSJQEjNLW0BK5qBvwyMuEC1ajvNfuMGwqZ4JVWRcKJ3W6cG0aYuswpBMwyneqLkhS3Vm8DMxEOgBwUWVgXFNJVxExOnmWV7mfiDgv7B01G30hWJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734399647; c=relaxed/simple;
	bh=/vyZwwxwTAh84I9YysE3Wx2AoCfBQVkucYWVEhG38K4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ht9XDkaJnxDLO/+AOanNTnb33NZJD/fDfesxWzigHxKWmR8stazNdUFduxxhDun3RK2FeJMfsDt8D2QnSOPY3YCeCbIxC2r+GcjSqgzbtNnC6zHCI0WF9Hqv/AaC0pQVC1fAlQC4yy3EH2cIp/ZV0buZTDNYf3AIe53G3D6Rukg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=X8UoPFqV; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734399636; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kp5bgamgQnxWfuok8ilXwYLyCWVqZ0QAZHqUfBvdgPA=;
	b=X8UoPFqVcK5Zx6QPBWAfokgOKh+Bcn1XLS2hjg4I3s8UIIWcJZP689gwh1J7wvYINhLC20JgH3j8YP5Oa+Q8vV9mBpJ8okGtahaLlcSXU+k0qn24bIU1c5WJQRkQDZlP/ykuJcc9BVZIterdWwA+rJcAQ4ZyG69IngzEtLuzL2w=
Received: from 30.246.161.240(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WLgi-44_1734399632 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 17 Dec 2024 09:40:34 +0800
Message-ID: <29d80fff-f33f-4470-a345-3f8f1a46f1af@linux.alibaba.com>
Date: Tue, 17 Dec 2024 09:40:31 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 1/3] ACPI: APEI: send SIGBUS to current task if
 synchronous memory error not recovered
To: jane.chu@oracle.com, yazen.ghannam@amd.com, mark.rutland@arm.com,
 catalin.marinas@arm.com, mingo@redhat.com, robin.murphy@arm.com,
 Jonathan.Cameron@Huawei.com, bp@alien8.de, rafael@kernel.org,
 linux-arm-kernel@lists.infradead.org, wangkefeng.wang@huawei.com,
 tanxiaofei@huawei.com, mawupeng1@huawei.com, tony.luck@intel.com,
 linmiaohe@huawei.com, naoya.horiguchi@nec.com, james.morse@arm.com,
 tongtiangen@huawei.com, gregkh@linuxfoundation.org, will@kernel.org,
 jarkko@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 linux-edac@vger.kernel.org, x86@kernel.org, justin.he@arm.com,
 ardb@kernel.org, ying.huang@intel.com, ashish.kalra@amd.com,
 baolin.wang@linux.alibaba.com, tglx@linutronix.de,
 dave.hansen@linux.intel.com, lenb@kernel.org, hpa@zytor.com,
 robert.moore@intel.com, lvying6@huawei.com, xiexiuqi@huawei.com,
 zhuo.song@linux.alibaba.com
References: <20241202030527.20586-1-xueshuai@linux.alibaba.com>
 <20241202030527.20586-2-xueshuai@linux.alibaba.com>
 <2fb8b1e5-d606-47be-a79e-a4e37a3b8f7f@oracle.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <2fb8b1e5-d606-47be-a79e-a4e37a3b8f7f@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/12/17 07:37, jane.chu@oracle.com 写道:
> 
> On 12/1/2024 7:05 PM, Shuai Xue wrote:
>> Synchronous error was detected as a result of user-space process accessing
>> a 2-bit uncorrected error. The CPU will take a synchronous error exception
>> such as Synchronous External Abort (SEA) on Arm64. The kernel will queue a
>> memory_failure() work which poisons the related page, unmaps the page, and
>> then sends a SIGBUS to the process, so that a system wide panic can be
>> avoided.
>>
>> However, no memory_failure() work will be queued when abnormal synchronous
>> errors occur. These errors can include situations such as invalid PA,
>> unexpected severity, no memory failure config support, invalid GUID
>> section, etc. In such case, the user-space process will trigger SEA again.
>> This loop can potentially exceed the platform firmware threshold or even
>> trigger a kernel hard lockup, leading to a system reboot.
>>
>> Fix it by performing a force kill if no memory_failure() work is queued
>> for synchronous errors.
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
>> ---
>>   drivers/acpi/apei/ghes.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index a2491905f165..106486bdfefc 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -801,6 +801,17 @@ static bool ghes_do_proc(struct ghes *ghes,
>>           }
>>       }
>> +    /*
>> +     * If no memory failure work is queued for abnormal synchronous
>> +     * errors, do a force kill.
>> +     */
>> +    if (sync && !queued) {
>> +        dev_err(ghes->dev,
>> +            HW_ERR GHES_PFX "%s:%d: synchronous unrecoverable error (SIGBUS)\n",
>> +            current->comm, task_pid_nr(current));
>> +        force_sig(SIGBUS);
>> +    }
>> +
>>       return queued;
>>   }
> 
> Looks good.
> 
> Reviewed-by: Jane Chu <jane.chu@oracle.com>
> 
> -jane

Thanks.

Best Regards,
Shuai

