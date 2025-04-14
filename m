Return-Path: <linux-edac+bounces-3533-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 635FAA88711
	for <lists+linux-edac@lfdr.de>; Mon, 14 Apr 2025 17:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73EFD582E68
	for <lists+linux-edac@lfdr.de>; Mon, 14 Apr 2025 15:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD369274FCD;
	Mon, 14 Apr 2025 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qWPsN03x"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B1025229A;
	Mon, 14 Apr 2025 15:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744642957; cv=none; b=MpUp1kHCwBU+jW/OowX7q1MNLdmT5fAEUnIn8dPGmLoGOv+cz56ubb3qZrv6y++HP6jMkOVThx3cqJ2Vt9KGYb/j9rHum2qnlSChWnwK+liA0VnmEy3N5pCgssh4rqSrkk/XwjyYTHRzoKcdZSFdOchjpnuppYfwr4x1qg4M+BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744642957; c=relaxed/simple;
	bh=29LBL8Eiyg9CDsCmAAfUL9mYEIwFGfoqYzoIU8iyiQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AraeoyfV7P58C11VuC5gcFxohfX4O3aSz0j2zrKaxsPxznwgve1WvNCHsZAOubm89JKK2oE/t5q73SdaIZ3D2HUrwRge8vPSoO2t6mpFnE3iF9U6/fbcHi5ZCURtMfshG6ZD9sCDzyR318gr7xn4ODb8Oy778hy9fjvHjNDJeCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qWPsN03x; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1744642944; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=XP1wiJKn79M25SDS7QDbse457FmVwidLJBCVM8ARXV4=;
	b=qWPsN03xz9+pTwownWuaBgpyTH0pHxo1wiofftgmL4NUgVGKBx1rkK6Oc1UfaanaiLvQB5xPRY8PV3a9AquDZJ1I+R2PS3DQbJkxxcCjWz+N+mxOmRxoUl/shW77PYKWLyXuBt+ZRJvi9SGe0HcE0BRz4lOCI87ZOp2NORAKphE=
Received: from 30.246.161.79(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WWsd0xB_1744642940 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Apr 2025 23:02:22 +0800
Message-ID: <709ee8d2-8969-424c-b32b-101c6a8220fb@linux.alibaba.com>
Date: Mon, 14 Apr 2025 23:02:19 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v18 1/2] ACPI: APEI: send SIGBUS to current task if
 synchronous memory error not recovered
To: Hanjun Guo <guohanjun@huawei.com>, catalin.marinas@arm.com,
 sudeep.holla@arm.com, lpieralisi@kernel.org, linux-acpi@vger.kernel.org,
 yazen.ghannam@amd.com, mark.rutland@arm.com, mingo@redhat.com,
 robin.murphy@arm.com, Jonathan.Cameron@Huawei.com, bp@alien8.de,
 rafael@kernel.org, linux-arm-kernel@lists.infradead.org,
 wangkefeng.wang@huawei.com, tanxiaofei@huawei.com, mawupeng1@huawei.com,
 tony.luck@intel.com, linmiaohe@huawei.com, naoya.horiguchi@nec.com,
 james.morse@arm.com, tongtiangen@huawei.com, gregkh@linuxfoundation.org,
 will@kernel.org, jarkko@kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, linux-edac@vger.kernel.org, x86@kernel.org,
 justin.he@arm.com, ardb@kernel.org, ying.huang@linux.alibaba.com,
 ashish.kalra@amd.com, baolin.wang@linux.alibaba.com, tglx@linutronix.de,
 dave.hansen@linux.intel.com, lenb@kernel.org, hpa@zytor.com,
 robert.moore@intel.com, lvying6@huawei.com, xiexiuqi@huawei.com,
 zhuo.song@linux.alibaba.com
References: <20250404112050.42040-1-xueshuai@linux.alibaba.com>
 <20250404112050.42040-2-xueshuai@linux.alibaba.com>
 <0c0bc332-0323-4e43-a96b-dd5f5957ecc9@huawei.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <0c0bc332-0323-4e43-a96b-dd5f5957ecc9@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/14 22:37, Hanjun Guo 写道:
> On 2025/4/4 19:20, Shuai Xue wrote:
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
>> Reviewed-by: Jane Chu <jane.chu@oracle.com>
>> ---
>>   drivers/acpi/apei/ghes.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index b72772494655..50e4d924aa8b 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -799,6 +799,17 @@ static bool ghes_do_proc(struct ghes *ghes,
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
> 
> I think it's reasonable to send a force kill to the task when the
> synchronous memory error is not recovered.
> 
> But I hope this code will not trigger some legacy firmware issues,
> let's be careful for this, so can we just introduce arch specific
> callbacks for this?

Sorry, can you give more details? I am not sure I got your point.

For x86, Tony confirmed that ghes will not dispatch x86 synchronous errors
(a.k.a machine check exception), in previous vesion.
Sync is only used in arm64 platform, see is_hest_sync_notify().

> 
> Thanks
> Hanjun

Thanks.
Shuai

