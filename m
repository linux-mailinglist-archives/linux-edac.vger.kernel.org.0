Return-Path: <linux-edac+bounces-4452-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8E3B132BB
	for <lists+linux-edac@lfdr.de>; Mon, 28 Jul 2025 03:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99C82170882
	for <lists+linux-edac@lfdr.de>; Mon, 28 Jul 2025 01:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB5613C3F2;
	Mon, 28 Jul 2025 01:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eGKpMu8N"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473AD29B0;
	Mon, 28 Jul 2025 01:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753664921; cv=none; b=jmKTKLadiqXkV6eEaJSO1Wx2CdzybqpaupzbfVNJTJjombYcrVXY3J7ZZV2swYQFCDr+tyzV6EFHFiMhogbJBvqmSVePqvH21rUFVcvsXmBs9h44JG5ayR+Y4lqhggknLdGmFmJaL+vDs4Z/ONzXEdQur7FzE+luCewrixA/pfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753664921; c=relaxed/simple;
	bh=6Y3D9D9Ou7Tlb+4EPgKYBcu/72sFDKzVsN8C1xEr5d0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GXpT7wg9q9gtynEngKYJ5Bk/75dzPwRW1Ls210kmgsDdJUfsLCKSEFZqM5Tb2tEsS0S27Z364nyAebS5hO0cXyzIiaIWBlM8HjhSWX4i8mwGq6Zg5duygO7uBvBUZuy7KeKbosxsXnU3NWdyvqejo9hCyHk9RBEVdpxTxUn6wtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eGKpMu8N; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753664908; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=2Iz/DOKZWtt9pD+4iMxQ3XO3FM24VBfncMNR3ZAeizA=;
	b=eGKpMu8NscuyUwKZnRp3q8JcVV05i/CslvjaduwcGJ4JGAVbxoBKkdH+efdAXASIX8mYJySv2+aHT7VylLCfSJ0JWtmoP8dFopeh3IzzyyjDbMOak0cgEY2+BDpxSe45xjlLEe+I6ay/nEQpWD32lTWqmHEdsuP/9zGoloh4D2o=
Received: from 30.246.181.19(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WkBBPjH_1753664905 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 28 Jul 2025 09:08:26 +0800
Message-ID: <4ef01be1-44b2-4bf5-afec-a90d4f71e955@linux.alibaba.com>
Date: Mon, 28 Jul 2025 09:08:25 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vmcoreinfo: Track and log recoverable hardware errors
To: Breno Leitao <leitao@debian.org>
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>, Robert Moore <robert.moore@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Hanjun Guo <guohanjun@huawei.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 acpica-devel@lists.linux.dev, osandov@osandov.com, konrad.wilk@oracle.com,
 linux-edac@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, kernel-team@meta.com
References: <20250722-vmcore_hw_error-v3-1-ff0683fc1f17@debian.org>
 <7ce9731a-b212-4e27-8809-0559eb36c5f2@linux.alibaba.com>
 <4qh2wbcbzdajh2tvki26qe4tqjazmyvbn7v7aqqhkxpitdrexo@ucch4ppo7i4e>
 <fdb5dced-ea5a-48b8-bbb4-fc3ade7f3df8@linux.alibaba.com>
 <ldlansfiesfxf4a6dzp5z2etquz5jgiq6ttx3al6q7sesgros6@xh4lkevbzsow>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <ldlansfiesfxf4a6dzp5z2etquz5jgiq6ttx3al6q7sesgros6@xh4lkevbzsow>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/26 00:16, Breno Leitao 写道:
> Hello Shuai,
> 
> On Fri, Jul 25, 2025 at 03:40:58PM +0800, Shuai Xue wrote:
>>>> APEI does not define an error type named GHES. GHES is just a kernel
>>>> driver name. Many hardware error types can be handled in GHES (see
>>>> ghes_do_proc), for example, AER is routed by GHES when firmware-first
>>>> mode is used. As far as I know, firmware-first mode is commonly used in
>>>> production. Should GHES errors be categorized into AER, memory, and CXL
>>>> memory instead?
>>>
>>> I also considered slicing the data differently initially, but then
>>> realized it would add more complexity than necessary for my needs.
>>>
>>> If you believe we should further subdivide the data, I’m happy to do so.
>>>
>>> You’re suggesting a structure like this, which would then map to the
>>> corresponding CPER_SEC_ sections:
>>>
>>> 	enum hwerr_error_type {
>>> 	HWERR_RECOV_AER,     // maps to CPER_SEC_PCIE
>>> 	HWERR_RECOV_MCE,     // maps to default MCE + CPER_SEC_PCIE
>>
>> CPER_SEC_PCIE is typo?
> 
> Correct, HWERR_RECOV_MCE would map to the regular MCE and not errors
> coming from GHES.
> 
>>> 	HWERR_RECOV_CXL,     // maps to CPER_SEC_CXL_*
>>> 	HWERR_RECOV_MEMORY,  // maps to CPER_SEC_PLATFORM_MEM
>>> 	}
>>>
>>> Additionally, what about events related to CPU, Firmware, or DMA
>>> errors—for example, CPER_SEC_PROC, CPER_SEC_FW, CPER_SEC_DMAR? Should we
>>> include those in the classification as well?
>>
>> I would like to split a error from ghes to its own type,
>> it sounds more reasonable. I can not tell what happened from HWERR_RECOV_AERat all :(
> 
> Makes sense. Regarding your answer, I suppose we might want to have
> something like the following:
> 
> 	enum hwerr_error_type {
> 		HWERR_RECOV_MCE,     // maps to errors in do_machine_check()
> 		HWERR_RECOV_CXL,     // maps to CPER_SEC_CXL_
> 		HWERR_RECOV_PCI,     // maps to AER (pci_dev_aer_stats_incr()) and CPER_SEC_PCIE and CPER_SEC_PCI
> 		HWERR_RECOV_MEMORY,  // maps to CPER_SEC_PLATFORM_MEM_
> 		HWERR_RECOV_CPU,     // maps to CPER_SEC_PROC_
> 		HWERR_RECOV_DMA,     // maps to CPER_SEC_DMAR_
> 		HWERR_RECOV_OTHERS,  // maps to CPER_SEC_FW_, CPER_SEC_DMAR_,
> 	}
> 
> Is this what you think we should track?
> 
> Thanks
> --breno

It sounds good to me.

Thanks.
Shuai


