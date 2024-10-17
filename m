Return-Path: <linux-edac+bounces-2131-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1CF9A3176
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2024 01:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6FE328401F
	for <lists+linux-edac@lfdr.de>; Thu, 17 Oct 2024 23:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291D120E316;
	Thu, 17 Oct 2024 23:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="J1rrqGLn"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCEC20E30D;
	Thu, 17 Oct 2024 23:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729208518; cv=none; b=QHLgjcbjlWyQ5u8SuXFUZ4x2yll05hC7F8HkNqyBT2e8qiIFwsMiLI+ecWhpAhK2JbNGnxi8JdGmeGO8R7/DLIuab/FVzBpcOxKVrDxjzKnPUwePbWNEgxiRb6g4mworue1ctR0PbUg8HUkzioWZnkpVM/gKyK2gLO701A7EKjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729208518; c=relaxed/simple;
	bh=rzTjsoxCvdckGmoxcEp2HsAOGoFFJ8K5tdixv7Ddc5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pj9/RFrq0Ow69n1pZLwzuOaoUzONM/4H1HscbS5fhcKZ+ULFp38KOq4tuD02VPJZStDY7mU6nmXCmLarMYklN8h22toleaaqzr/QTeb8oWAvEyabCFk4W8NPFWMPb4Q/mUJR6nlY6soFOfrcJz9uXOgJUBjcz8X9/NhUZhvjNv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=J1rrqGLn; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729208512; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=0aawDGjGNZQE0Mn+vyxLbUtklTzFw7RqZEkL6wKmfks=;
	b=J1rrqGLnvWJkz8uIrPbobfLCGxm+MPAsOmmwOoTaOElI8N4wOTZmhrmqG+wU367O9PmslGZwk5Pz/lt0QlK0pnd8L4wr3EffwTqEK3ry6egZS5ijkeUEZrPXKFKPQbyA1l3+gGMrsEEgNmHBpe5KB8dXrjdLN3iGZe21IX5qqCY=
Received: from 30.246.161.56(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WHLxo66_1729208507 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 18 Oct 2024 07:41:50 +0800
Message-ID: <679e9acc-3d76-43dc-a00f-9301a1da0ce6@linux.alibaba.com>
Date: Fri, 18 Oct 2024 07:41:47 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 1/3] ACPI: APEI: send SIGBUS to current task if
 synchronous memory error not recovered
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: mark.rutland@arm.com, catalin.marinas@arm.com, mingo@redhat.com,
 robin.murphy@arm.com, bp@alien8.de, rafael@kernel.org,
 wangkefeng.wang@huawei.com, tanxiaofei@huawei.com, mawupeng1@huawei.com,
 tony.luck@intel.com, linmiaohe@huawei.com, naoya.horiguchi@nec.com,
 james.morse@arm.com, tongtiangen@huawei.com, gregkh@linuxfoundation.org,
 will@kernel.org, jarkko@kernel.org, linux-acpi@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 linux-edac@vger.kernel.org, x86@kernel.org, justin.he@arm.com,
 ardb@kernel.org, ying.huang@intel.com, ashish.kalra@amd.com,
 baolin.wang@linux.alibaba.com, tglx@linutronix.de,
 dave.hansen@linux.intel.com, lenb@kernel.org, hpa@zytor.com,
 robert.moore@intel.com, lvying6@huawei.com, xiexiuqi@huawei.com,
 zhuo.song@linux.alibaba.com, linux-cxl@vger.kernel.org
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20241014084240.18614-2-xueshuai@linux.alibaba.com>
 <20241017103923.00007033@Huawei.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20241017103923.00007033@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/10/17 17:39, Jonathan Cameron 写道:
> On Mon, 14 Oct 2024 16:42:38 +0800
> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> 
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
> 
> The subtle cases in here are the various other forms of delayed handling
> buried in some of the record handling that don't set queued.
> I've been through them all and have convinced myself that either
> hey should never be synchronous or that there is no attempt to
> recover in kernel today (non memory things such as CXL protocol
> collapse, which might I guess be detected synchronously on a read
> - though I'd expect poison and a memory error first) so the correct
> thing to do is what you have here.
> 
> Fiddly code though with a lot of paths, so more eyes welcome!
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> +CC linux-cxl for info.

Thanks :)

Best Regards,
Shuai

