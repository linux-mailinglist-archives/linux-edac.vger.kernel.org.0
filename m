Return-Path: <linux-edac+bounces-4361-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F06B04DA7
	for <lists+linux-edac@lfdr.de>; Tue, 15 Jul 2025 04:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50BA13B176F
	for <lists+linux-edac@lfdr.de>; Tue, 15 Jul 2025 02:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CFE253932;
	Tue, 15 Jul 2025 02:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BRrAqqQQ"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D682E2BAF7;
	Tue, 15 Jul 2025 02:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752545022; cv=none; b=pSLLHdd6NvsQyxI9NLdxf+N2+LhCJrUUrj6SqksmNgOHFb8/h26xQ2g9r69/TathULHzqRJsFe92Edr0kQ5azhvbU2rIEjQRybq3i/FQ5boHGps/RIpS5nToZIptIjinhQZslh/kof58KGYktBFxxAj6+PhdRK1eKbTP92iDIG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752545022; c=relaxed/simple;
	bh=wIhcqbIU3A2uS19iVB5mFF+JdhGyFUreWhkEW6nyKpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uem/L8ODSx9XTGSrqFEZl0rfuuQZUypxxYCxPMx7+KhF1ZskPkAIL2An7mrdpWvCf9ZstKA3tHi4Ig09P/uashHKtVh+R4Ijb7FLgxBCc9cC8+abbZ77sGa7MUJL/ONUAtq9vDpz8u3mzZfuuLhZqH44YaoqeB2QNBssbzlExJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BRrAqqQQ; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752545013; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=zYnSNf9BzJd5gcJLKc4Aki1X1bARqpvuAcht6oEbdus=;
	b=BRrAqqQQFtfUfbBcNXfOB0qLfxlHUOoz79hUrHzGHs5U0OKdukq27YvtuGf1j82E/sTt9IxQ0DCw+bAVJYUiff6jz3NG0CUI95lBKmavb3LU396mIJZjnS8ysbnYycHSsoqICJdSe2G7YcQgZ0/4WJIJ2IDL5D6l2urN7r26XX0=
Received: from 30.246.162.71(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wj-H5cN_1752545009 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Jul 2025 10:03:31 +0800
Message-ID: <548ba9fd-60d6-4976-b04b-94fc79e858ff@linux.alibaba.com>
Date: Tue, 15 Jul 2025 10:03:28 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v18 1/2] ACPI: APEI: send SIGBUS to current task if
 synchronous memory error not recovered
To: "Rafael J. Wysocki" <rafael@kernel.org>, "Luck, Tony"
 <tony.luck@intel.com>, lenb@kernel.org, bp@alien8.de, james.morse@arm.com,
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 linux-edac@vger.kernel.org, x86@kernel.org, justin.he@arm.com,
 ardb@kernel.org, ying.huang@linux.alibaba.com, ashish.kalra@amd.com,
 baolin.wang@linux.alibaba.com, tglx@linutronix.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, robert.moore@intel.com,
 lvying6@huawei.com, xiexiuqi@huawei.com, zhuo.song@linux.alibaba.com,
 sudeep.holla@arm.com, lpieralisi@kernel.org, linux-acpi@vger.kernel.org,
 yazen.ghannam@amd.com, mark.rutland@arm.com, mingo@redhat.com,
 robin.murphy@arm.com, Jonathan.Cameron@huawei.com,
 linux-arm-kernel@lists.infradead.org, wangkefeng.wang@huawei.com,
 tanxiaofei@huawei.com, mawupeng1@huawei.com, linmiaohe@huawei.com,
 naoya.horiguchi@nec.com, james.morse@arm.com, tongtiangen@huawei.com,
 gregkh@linuxfoundation.org, jarkko@kernel.org
References: <20250404112050.42040-1-xueshuai@linux.alibaba.com>
 <20250404112050.42040-2-xueshuai@linux.alibaba.com>
 <0c0bc332-0323-4e43-a96b-dd5f5957ecc9@huawei.com>
 <709ee8d2-8969-424c-b32b-101c6a8220fb@linux.alibaba.com>
 <353809e7-5373-0d54-6ddb-767bc5af9e5f@huawei.com>
 <653abdd4-46d2-4956-b49c-8f9c309af34d@linux.alibaba.com>
 <de5d2417-dc92-b276-1125-4feb5151de7f@huawei.com>
 <f60f1128-0d42-48e5-9a06-6ed7ca10767f@linux.alibaba.com>
 <20250428152350.GA23615@willie-the-truck>
 <6671c3cc-5119-4544-bcb5-17e8cc2d7057@linux.alibaba.com>
 <CAJZ5v0j3NC2ki1XPXfznxZRBLaReDBJ+nzHFgvqMx5+MgERL-A@mail.gmail.com>
 <3a465782-a8ff-4be8-9c15-e46f39196757@linux.alibaba.com>
 <CAJZ5v0gfFHCvE2Uu8=GRb9=ueK51s1-0BDBkJbbDG0tQvD5pLA@mail.gmail.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <CAJZ5v0gfFHCvE2Uu8=GRb9=ueK51s1-0BDBkJbbDG0tQvD5pLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/15 01:30, Rafael J. Wysocki 写道:
> Hi,
> 
> On Mon, Jul 14, 2025 at 1:54 PM Shuai Xue <xueshuai@linux.alibaba.com> wrote:
>>
>> 在 2025/7/1 21:56, Rafael J. Wysocki 写道:
>>> On Tue, Jul 1, 2025 at 1:00 PM Shuai Xue <xueshuai@linux.alibaba.com> wrote:
>>>>
>>>>    >在 2025/4/28 23:23, Will Deacon 写道:
>>>>    >> On Fri, Apr 25, 2025 at 09:10:09AM +0800, Shuai Xue wrote:
>>>>    >>> 在 2025/4/25 09:00, Hanjun Guo 写道:
>>>>    >>>> Call force_sig(SIGBUS) directly in ghes_do_proc() is not my favourite,
>>>>    >>>> but I can bear that, please add
>>>>    >>>>
>>>>    >>>> Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
>>>>    >>>>
>>>>    >>>> Thanks
>>>>    >>>> Hanjun
>>>>    >>>
>>>>    >>> Thanks. Hanjun.
>>>>    >>>
>>>>    >>> @Rafael, @Catalin,
>>>>    >>>
>>>>    >>> Both patch 1 and 2 have reviewed-by tag from the arm64 ACPI
>>>> maintainers, Hanjun,
>>>>    >>> now. Are you happpy to pick and queue this patch set to acpi tree
>>>> or arm tree?
>>>>    >>
>>>>    >> Since this primarily touches drivers/acpi/apei/ghes.c, I think it should
>>>>    >> go via the ACPI tree and not the arm64 one.
>>>>    >>
>>>>    >> Will
>>>>    >
>>>>    >Hi, Will,
>>>>    >
>>>>    >Thank you for your confirmation :)
>>>>    >
>>>>    >@Rafael, do you have more comments on this patch set?
>>>>    >
>>>>    >Thanks you.
>>>>    >
>>>>    >Best Regards,
>>>>    >Shuai
>>>>
>>>> Hi, all,
>>>>
>>>> Gentle ping.
>>>>
>>>> Does ACPI or APEI tree still active? Looking forward to any response.
>>>
>>> For APEI changes, you need an ACK from one of the reviewers listed in
>>> the MAINTAINERS entry for APEI.
>>>
>>> Thanks!
>>
>> Hi, Rafael
>>
>> Sorry, I missed your email which goes in span (:
>>
>> ARM maintain @Catalin points that:
>>
>>   > James Morse is listed as reviewer of the ACPI APEI code but he's busy
>>   > with resctrl/MPAM. Adding Lorenzo, Sudeep and Hanjun as arm64 ACPI
>>   > maintainers, hopefully they can help.
>>
>> And Hanjun explictly gived his Reviewed-by tag in this thread, is that
>> happy for you for merge?
> 
> Not really.
> 
> I need an ACK or R-by from a reviewer listed in the APEI entry in MAINTAINERS.

Hi Rafael,

I understand your requirement for an ACK/R-by from the APEI reviewers 
listed in MAINTAINERS.

So, @Tony, @James, @Borislav, @Len,

Gentle ping, we need your help to review and ack this patch set.

If I recall correctly, Rafael has mentioned this issue at least three 
times in previous emails, but we still haven't received explict response 
from the APEI maintainer.


> 
> If James Morse is not able to fill that role (and AFAICS he's not been
> for quite some time now), I'd expect someone else to step up.
> 
> Thanks!

Thank you for the clarification.

I'd like to volunteer to help with APEI code reviews. I have been 
working with APEI-related code and am familiar with the ACPI error 
handling mechanisms.

I'm willing to start by contributing reviews and help move pending APEI 
patches forward. If the community finds my contributions valuable and 
believes I have the necessary expertise, I would welcome the opportunity 
to be formally set up as an APEI reviewer in the future.

Thanks for considering this, and I look forward to your guidance.

Thanks.
Shuai

