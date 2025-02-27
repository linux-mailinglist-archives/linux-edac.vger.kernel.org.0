Return-Path: <linux-edac+bounces-3216-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DCAA47DCA
	for <lists+linux-edac@lfdr.de>; Thu, 27 Feb 2025 13:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DB30161B41
	for <lists+linux-edac@lfdr.de>; Thu, 27 Feb 2025 12:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDFF22A1CF;
	Thu, 27 Feb 2025 12:31:27 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F090C270043;
	Thu, 27 Feb 2025 12:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659487; cv=none; b=sMkAr8o7De/mdGnGGozgGW1CcOLEazAVpgzxtbug5pBIzDJp2mEJwl2PQThDVA2zNkvKw1TLE1u5m89EMEFUo6Yuz6sN/87D5EVbFwui1lcjsYu1IFjAGsMEoaGjRt5TuC1hON0D2NbgbbwIMBixds+//R2wd0CXvZZBj0Gr2wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659487; c=relaxed/simple;
	bh=2UmvCeqvyloSdEbILmaFdvFZ1Z3eL5zlFIgF0aSHkOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKWUYsRSmIz64+GRfLSjlMVRcMwb37u72CbEGTW/LfYacK0/FL/LFnkGLF91v/NPV7DCs3BrtxRuzKXngm0jrBAcNY7e8uQpTAsRh5MIitWqkAYCX0FfPPW0p6rID94SyO9xxT77U7MF09Hjn22M6W5xFV1Hd7u+6XCA0CuIPlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D25AC4CEE9;
	Thu, 27 Feb 2025 12:31:20 +0000 (UTC)
Date: Thu, 27 Feb 2025 12:31:17 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: yazen.ghannam@amd.com, mark.rutland@arm.com, mingo@redhat.com,
	robin.murphy@arm.com, Jonathan.Cameron@huawei.com, bp@alien8.de,
	rafael@kernel.org, linux-arm-kernel@lists.infradead.org,
	wangkefeng.wang@huawei.com, tanxiaofei@huawei.com,
	mawupeng1@huawei.com, tony.luck@intel.com, linmiaohe@huawei.com,
	naoya.horiguchi@nec.com, james.morse@arm.com,
	tongtiangen@huawei.com, gregkh@linuxfoundation.org, will@kernel.org,
	jarkko@kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	linux-edac@vger.kernel.org, x86@kernel.org, justin.he@arm.com,
	ardb@kernel.org, ying.huang@linux.alibaba.com, ashish.kalra@amd.com,
	baolin.wang@linux.alibaba.com, tglx@linutronix.de,
	dave.hansen@linux.intel.com, lenb@kernel.org, hpa@zytor.com,
	robert.moore@intel.com, lvying6@huawei.com, xiexiuqi@huawei.com,
	zhuo.song@linux.alibaba.com
Subject: Re: [PATCH v18 2/3] mm: memory-failure: move return value
 documentation to function declaration
Message-ID: <Z8BbFRupgknBTvH8@arm.com>
References: <20250107081735.16159-1-xueshuai@linux.alibaba.com>
 <20250107081735.16159-3-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107081735.16159-3-xueshuai@linux.alibaba.com>

(going through patches in my inbox)

On Tue, Jan 07, 2025 at 04:17:34PM +0800, Shuai Xue wrote:
> Part of return value comments for memory_failure() were originally
> documented at the call site. Move those comments to the function
> declaration to improve code readability and to provide developers with

s/declaration/definition/

> immediate access to function usage and return information.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Reviewed-by: Jane Chu <jane.chu@oracle.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c |  7 -------
>  mm/memory-failure.c            | 10 +++++++---
>  2 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 7fb5556a0b53..d1dd7f892514 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1398,13 +1398,6 @@ static void kill_me_maybe(struct callback_head *cb)
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
> index a7b8ccd29b6f..14c316d7d38d 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2211,9 +2211,13 @@ static void kill_procs_now(struct page *p, unsigned long pfn, int flags,
>   * Must run in process context (e.g. a work queue) with interrupts
>   * enabled and no spinlocks held.
>   *
> - * Return: 0 for successfully handled the memory error,
> - *         -EOPNOTSUPP for hwpoison_filter() filtered the error event,
> - *         < 0(except -EOPNOTSUPP) on failure.
> + * Return:
> + *   0             - success,
> + *   -ENXIO        - memory not managed by the kernel
> + *   -EOPNOTSUPP   - hwpoison_filter() filtered the error event,
> + *   -EHWPOISON    - the page was already poisoned, potentially
> + *                   kill process,
> + *   other negative values - failure.
>   */
>  int memory_failure(unsigned long pfn, int flags)
>  {

Why not keep the comment in both places? One is about the x86 decisions,
the other is about what memory_failure() can return.

-- 
Catalin

