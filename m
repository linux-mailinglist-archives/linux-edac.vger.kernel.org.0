Return-Path: <linux-edac+bounces-2455-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D03159BDE7F
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2024 07:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 870121F244EA
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2024 06:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0771917DB;
	Wed,  6 Nov 2024 06:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kSlx7nSh"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93ED36D;
	Wed,  6 Nov 2024 06:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730873244; cv=none; b=GaTb3LKUCDmXLCbBAIrplQpq83TcDqBOFfm6lEc1K1zZRI+ePcXYTKq5lRm9hRSX4wpPsTPbCyuzHC5TeRhCh4twx2s4z8GHYDpMf4rAAsC0vJdQ3JAZf/EVLKhKp7wLimSzMi3v6giZGeSZTzFMcjq3WcqsgkmthtvS7br2WRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730873244; c=relaxed/simple;
	bh=3tDMLeqhTLFddd4gV1A72IAhT0BPFpeYU9BNfPBRo7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HTBKzxHBStR8cXERRLAHGupVqj79ptxArAitiV5wd1ddcpfyqk4rauubCm48Q1eHNtcGDSGuOzIgDjst2k2mxuuO6rFt1Obw5NCqaFPDM290i95g998oP8b7Tpx/3SaqKpSbpQPpILG8aOjoR9uVDJhQwHjZby4PtMclgiRRjkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kSlx7nSh; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730873239; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ifC7maoPLJGfpi4Xs27e8HUfbbxX8LbnbtLNxWgwIr4=;
	b=kSlx7nSh5m/L0DCqndEUHIPPBMMAF2PxDPJVr6CfXraqoyY5/1b7DXKMOJ57se7oewzDmvIoF2n+a82tcREit5URAn5k2UQcE+d4W/q0HZZK7aFrXH8EfahM7hkHnIJFXPu8km6lZ+u1CH7Ef+QD6uFgxot8rVynIQNirsjp4R8=
Received: from 30.246.162.170(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WIqDixT_1730873235 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 06 Nov 2024 14:07:17 +0800
Message-ID: <64dff7c7-95c9-48e5-b549-ec37ed6a6587@linux.alibaba.com>
Date: Wed, 6 Nov 2024 14:07:14 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 1/3] ACPI: APEI: send SIGBUS to current task if
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
 <20241104015430.98599-2-xueshuai@linux.alibaba.com>
 <20241105150945.GE916505@yaz-khff2.amd.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20241105150945.GE916505@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/11/5 23:09, Yazen Ghannam 写道:
> On Mon, Nov 04, 2024 at 09:54:28AM +0800, Shuai Xue wrote:
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
>> index ada93cfde9ba..af3339dd3817 100644
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
>> +		pr_err(HW_ERR GHES_PFX "%s:%d: hardware memory corruption (SIGBUS)\n",
> 
> Is this always a memory error? The code flow above implies that an
> unrecoverable ARM processor error can all be !queued. So should the
> message be more generic like "synchronous unrecoverable error" or
> similar?

Yes, you are right. Will fix it.
> 
> In any case, this is just a minor nit if this is not an issue in
> practice.
> 
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Thanks,
> Yazen

Thank you for valuable comments.
Shuai


