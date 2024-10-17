Return-Path: <linux-edac+bounces-2123-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A74799A1EA0
	for <lists+linux-edac@lfdr.de>; Thu, 17 Oct 2024 11:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6141528945C
	for <lists+linux-edac@lfdr.de>; Thu, 17 Oct 2024 09:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861BA1D95AA;
	Thu, 17 Oct 2024 09:42:05 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3795E762E0;
	Thu, 17 Oct 2024 09:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158125; cv=none; b=cAoof/vbVP7P2n/pyKsJkH3WG15dKdoEPHVr5+/d1FdYPDnYg87OGmTgUq1xXBIdjgOnoHFoVGOuLwLKzWxelnu4LEjYb/QjReHVb6Ae6WaEtXKtzqf7WX/0MQZnW1o4lw/KAO9IVt1fMRJ2pENSDoyj4eZ5Y9RnlB58kQpt6+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158125; c=relaxed/simple;
	bh=9W4Xi23mOJ8iMsXDzLrt2lIAZH4MyALaIc7BbJR6fyg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lSOV0Jdg8oz4HH2DTYNa1pUGovaEpArYIOL8axTA2mqBRbEi1s5Tqnyn0A4lVtrCs+hj1l05IAngcl81+IqL0OWtTUXf4tqzeqlvdnWkJGiTV19ycIPrNQbIOKWk//KGeROCy7KPK1SmhTnS2qqeIuYXemQM3gt+KHEd9oWvL3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTjVm4yCrz6G9bw;
	Thu, 17 Oct 2024 17:40:16 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5A3971400DB;
	Thu, 17 Oct 2024 17:42:00 +0800 (CST)
Received: from localhost (10.126.174.164) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Oct
 2024 11:41:58 +0200
Date: Thu, 17 Oct 2024 10:41:56 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
CC: <mark.rutland@arm.com>, <catalin.marinas@arm.com>, <mingo@redhat.com>,
	<robin.murphy@arm.com>, <bp@alien8.de>, <rafael@kernel.org>,
	<wangkefeng.wang@huawei.com>, <tanxiaofei@huawei.com>,
	<mawupeng1@huawei.com>, <tony.luck@intel.com>, <linmiaohe@huawei.com>,
	<naoya.horiguchi@nec.com>, <james.morse@arm.com>, <tongtiangen@huawei.com>,
	<gregkh@linuxfoundation.org>, <will@kernel.org>, <jarkko@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
	<linux-edac@vger.kernel.org>, <x86@kernel.org>, <justin.he@arm.com>,
	<ardb@kernel.org>, <ying.huang@intel.com>, <ashish.kalra@amd.com>,
	<baolin.wang@linux.alibaba.com>, <tglx@linutronix.de>,
	<dave.hansen@linux.intel.com>, <lenb@kernel.org>, <hpa@zytor.com>,
	<robert.moore@intel.com>, <lvying6@huawei.com>, <xiexiuqi@huawei.com>,
	<zhuo.song@linux.alibaba.com>
Subject: Re: [PATCH v14 2/3] mm: memory-failure: move return value
 documentation to function declaration
Message-ID: <20241017104156.00000f83@Huawei.com>
In-Reply-To: <20241014084240.18614-3-xueshuai@linux.alibaba.com>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
	<20241014084240.18614-3-xueshuai@linux.alibaba.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 14 Oct 2024 16:42:39 +0800
Shuai Xue <xueshuai@linux.alibaba.com> wrote:

> Part of return value comments for memory_failure() were originally
> documented at the call site. Move those comments to the function
> declaration to improve code readability and to provide developers with
> immediate access to function usage and return information.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Seems sensible.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> ---
>  arch/x86/kernel/cpu/mce/core.c | 7 -------
>  mm/memory-failure.c            | 9 ++++++---
>  2 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 2a938f429c4d..c90d8fcd246a 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1373,13 +1373,6 @@ static void kill_me_maybe(struct callback_head *cb)
>  		return;
>  	}
>  
> -	/*
> -	 * -EHWPOISON from memory_failure() means that it already sent SIGBUS
> -	 * to the current process with the proper error info,
> -	 * -EOPNOTSUPP means hwpoison_filter() filtered the error event,
> -	 *
> -	 * In both cases, no further processing is required.
> -	 */
>  	if (ret == -EHWPOISON || ret == -EOPNOTSUPP)
>  		return;
>  
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 96ce31e5a203..1c5098f32d48 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2209,9 +2209,12 @@ static void kill_procs_now(struct page *p, unsigned long pfn, int flags,
>   * Must run in process context (e.g. a work queue) with interrupts
>   * enabled and no spinlocks held.
>   *
> - * Return: 0 for successfully handled the memory error,
> - *         -EOPNOTSUPP for hwpoison_filter() filtered the error event,
> - *         < 0(except -EOPNOTSUPP) on failure.
> + * Return:
> + *   0             - success,
> + *   -EOPNOTSUPP   - hwpoison_filter() filtered the error event,
> + *   -EHWPOISON    - the page was already poisoned, potentially
> + *                   kill process,
> + *   other negative values - failure.
>   */
>  int memory_failure(unsigned long pfn, int flags)
>  {


