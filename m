Return-Path: <linux-edac+bounces-4355-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A7AB03DC2
	for <lists+linux-edac@lfdr.de>; Mon, 14 Jul 2025 13:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E791017C9FE
	for <lists+linux-edac@lfdr.de>; Mon, 14 Jul 2025 11:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDABF24728D;
	Mon, 14 Jul 2025 11:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="J1H0zooR"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0791224728A;
	Mon, 14 Jul 2025 11:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752494078; cv=none; b=F//r3Ws1LRdCp+wxc3r/1l3SmCwGfIObYyWsL6BzXT2NgbkJQP7C8LL69Ydgn/lDfOv40hWhMloNahKnkfFDfEcIGpzg/Vlyu3t2rggBZzxLz0amysd6W08FynljcLGUjref/gvJTIYQpTAXtJVWKctCT+JsFbyrsqJJ9NccbJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752494078; c=relaxed/simple;
	bh=DsWNuJlwW12kx2XbMVvdqk0TE7uBYX+86/EE/LpoqT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AlzwUwvxpO9aTmIf6eute36EGC/21+Mkq9/42QZXPx+R3Luz97+OFmoJa2oQGqdoCeFWadmz2s+zrafRnbHyjY//gOcFVuL6QJczRw+sdsJLklxkipC2N93iDYieAsowLvFj5mfe/yyTgeDZS4ilhNfE4fyqZVCtclBfaX6eB0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=J1H0zooR; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752494066; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=UkkwS35RaRMEd05xkjz7kqXm2/CwruKvAzqa1idwlHQ=;
	b=J1H0zooRDCohtIcpkpbMFRDOBCS3lwGmJWvCzW+JSmhDEtyaIdUB6jBoLesdz9OYMown5Chlh1N9Jz2UKtrh5DIJbFDkgR7YHv6yLVwQkdn9bg9ruljRYdpmERO/oVYZ9X51vu/h3WHupJ4m9e9fgHKyB4FjHGS7Z8i1lJuXI5s=
Received: from 30.246.162.71(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WiuVUPq_1752494062 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Jul 2025 19:54:24 +0800
Message-ID: <3a465782-a8ff-4be8-9c15-e46f39196757@linux.alibaba.com>
Date: Mon, 14 Jul 2025 19:54:21 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v18 1/2] ACPI: APEI: send SIGBUS to current task if
 synchronous memory error not recovered
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, "Luck, Tony"
 <tony.luck@intel.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, linux-edac@vger.kernel.org, x86@kernel.org,
 justin.he@arm.com, ardb@kernel.org, ying.huang@linux.alibaba.com,
 ashish.kalra@amd.com, baolin.wang@linux.alibaba.com, tglx@linutronix.de,
 dave.hansen@linux.intel.com, lenb@kernel.org, hpa@zytor.com,
 robert.moore@intel.com, lvying6@huawei.com, xiexiuqi@huawei.com,
 zhuo.song@linux.alibaba.com, sudeep.holla@arm.com, lpieralisi@kernel.org,
 linux-acpi@vger.kernel.org, yazen.ghannam@amd.com, mark.rutland@arm.com,
 mingo@redhat.com, robin.murphy@arm.com, Jonathan.Cameron@huawei.com,
 bp@alien8.de, linux-arm-kernel@lists.infradead.org,
 wangkefeng.wang@huawei.com, tanxiaofei@huawei.com, mawupeng1@huawei.com,
 linmiaohe@huawei.com, naoya.horiguchi@nec.com, james.morse@arm.com,
 tongtiangen@huawei.com, gregkh@linuxfoundation.org, jarkko@kernel.org
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
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <CAJZ5v0j3NC2ki1XPXfznxZRBLaReDBJ+nzHFgvqMx5+MgERL-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/1 21:56, Rafael J. Wysocki 写道:
> On Tue, Jul 1, 2025 at 1:00 PM Shuai Xue <xueshuai@linux.alibaba.com> wrote:
>>
>>   >在 2025/4/28 23:23, Will Deacon 写道:
>>   >> On Fri, Apr 25, 2025 at 09:10:09AM +0800, Shuai Xue wrote:
>>   >>> 在 2025/4/25 09:00, Hanjun Guo 写道:
>>   >>>> Call force_sig(SIGBUS) directly in ghes_do_proc() is not my favourite,
>>   >>>> but I can bear that, please add
>>   >>>>
>>   >>>> Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
>>   >>>>
>>   >>>> Thanks
>>   >>>> Hanjun
>>   >>>
>>   >>> Thanks. Hanjun.
>>   >>>
>>   >>> @Rafael, @Catalin,
>>   >>>
>>   >>> Both patch 1 and 2 have reviewed-by tag from the arm64 ACPI
>> maintainers, Hanjun,
>>   >>> now. Are you happpy to pick and queue this patch set to acpi tree
>> or arm tree?
>>   >>
>>   >> Since this primarily touches drivers/acpi/apei/ghes.c, I think it should
>>   >> go via the ACPI tree and not the arm64 one.
>>   >>
>>   >> Will
>>   >
>>   >Hi, Will,
>>   >
>>   >Thank you for your confirmation :)
>>   >
>>   >@Rafael, do you have more comments on this patch set?
>>   >
>>   >Thanks you.
>>   >
>>   >Best Regards,
>>   >Shuai
>>
>> Hi, all,
>>
>> Gentle ping.
>>
>> Does ACPI or APEI tree still active? Looking forward to any response.
> 
> For APEI changes, you need an ACK from one of the reviewers listed in
> the MAINTAINERS entry for APEI.
> 
> Thanks!

Hi, Rafael

Sorry, I missed your email which goes in span (:

ARM maintain @Catalin points that:

 > James Morse is listed as reviewer of the ACPI APEI code but he's busy
 > with resctrl/MPAM. Adding Lorenzo, Sudeep and Hanjun as arm64 ACPI
 > maintainers, hopefully they can help.

And Hanjun explictly gived his Reviewed-by tag in this thread, is that 
happy for you for merge?

Thanks.
Shuai


