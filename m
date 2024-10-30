Return-Path: <linux-edac+bounces-2339-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C856F9B59A8
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 02:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F429B222A9
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 01:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363F613C69E;
	Wed, 30 Oct 2024 01:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZOmQ4E0G"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFA11BC3F;
	Wed, 30 Oct 2024 01:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730253253; cv=none; b=DBSSay57YBuDIlsxiY7FJLhtJHgADksvbBjJ24NYgxqZjPWx17UPO0VlYYhwRy+MjBYtRbjAtSANn/JExcePVxAUUeAYTMizDvNvVnZMeWvxc+JcCuNGKhB4fAIkTfWfVVEefjhdwDXIpP1VYTlGN7YqqICJJ7lRcGpoLd5tsgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730253253; c=relaxed/simple;
	bh=wn4kpuFmeCG27j7Q5f1Et34O77xDdiyk5WPJjNIG1Do=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X5YHDHNRHSYyjd0PK/+m8pT4zc2RrdRH1BE7M4qbvCHyMBglIVLjH3eI+xwFf+EGpSCLrf64zPzNmkzASpNXO1ht8rqaZPwW9E7JsvuIh4JSfjCo5IVpugdrgnUXvsSUeXn7cGqJs3ehOUc/hard7bS8i+l5GCDwrmrZtKiBQNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZOmQ4E0G; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730253246; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=QVuP8bL2UthKGyf2UbcF1p2yjun+l2O30gXmPUgnGX4=;
	b=ZOmQ4E0GuzjdBFAZMcM+7Cz7W8Gc7kGMh2td12w+LThHhidBblj+EVUe6ScSSmu1NA+GMBYl2vB643VTVq3j6g/orJOIssHrF4F51pMYDlqabkp7KyHVct/boDdvzS4+qG8ORU7nTEgr9fZCurY6oH5NsBupQQFwd1S0R0yd2Es=
Received: from 30.246.162.170(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WIC1TDj_1730253241 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 30 Oct 2024 09:54:04 +0800
Message-ID: <d62d775e-08e3-4a2d-88a8-437a4c04ebd3@linux.alibaba.com>
Date: Wed, 30 Oct 2024 09:54:00 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 1/3] ACPI: APEI: send SIGBUS to current task if
 synchronous memory error not recovered
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: mark.rutland@arm.com, catalin.marinas@arm.com, mingo@redhat.com,
 robin.murphy@arm.com, Jonathan.Cameron@huawei.com, bp@alien8.de,
 rafael@kernel.org, wangkefeng.wang@huawei.com, tanxiaofei@huawei.com,
 mawupeng1@huawei.com, tony.luck@intel.com, linmiaohe@huawei.com,
 naoya.horiguchi@nec.com, james.morse@arm.com, tongtiangen@huawei.com,
 gregkh@linuxfoundation.org, will@kernel.org, jarkko@kernel.org,
 linux-acpi@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 linux-edac@vger.kernel.org, x86@kernel.org, justin.he@arm.com,
 ardb@kernel.org, ying.huang@intel.com, ashish.kalra@amd.com,
 baolin.wang@linux.alibaba.com, tglx@linutronix.de,
 dave.hansen@linux.intel.com, lenb@kernel.org, hpa@zytor.com,
 robert.moore@intel.com, lvying6@huawei.com, xiexiuqi@huawei.com,
 zhuo.song@linux.alibaba.com
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20241028081142.66028-2-xueshuai@linux.alibaba.com>
 <20241029204848.GA1229628@yaz-khff2.amd.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20241029204848.GA1229628@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/10/30 04:48, Yazen Ghannam 写道:
> On Mon, Oct 28, 2024 at 04:11:40PM +0800, Shuai Xue wrote:
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
>> ---
>>   drivers/acpi/apei/ghes.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index ada93cfde9ba..f2ee28c44d7a 100644
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
>> +		pr_err("%s:%d: hardware memory corruption (SIGBUS)\n",
>> +			current->comm, task_pid_nr(current));
> 
> I think it would help to include the GHES_PFX to indicate where this
> message is coming from. The pr_fmt() macro could also be introduced
> instead.

Yes, GHES_PFX is a effective prefix and will be consistent to other 
message in GHES driver. Will add it in next version.

What do you mean about pr_fmt()?

> 
> Also, you may want to include the HW_ERR prefix. Not all kernel messages
> related to hardware errors have this prefix today. But maybe that should
> be changed so there is more consistent messaging.
> 

Do we really need a HW_ERR prefix? The other case which use HW_ERR 
prefix are for hardware registers. The messages which send SIGBUS does
not include HW_ERR, e.g. in kill_proc(), kill_procs().

     pr_err("%#lx: Sending SIGBUS to %s:%d due to hardware memory 
corruption\n",...
     pr_err("%#lx: forcibly killing %s:%d because of failure to unmap 
corrupted page\n",...


> Thanks,
> Yazen

Thanks for valuable comments.

Best Regards,
Shuai


