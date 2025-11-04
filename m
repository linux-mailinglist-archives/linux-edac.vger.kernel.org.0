Return-Path: <linux-edac+bounces-5316-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DCEC304C6
	for <lists+linux-edac@lfdr.de>; Tue, 04 Nov 2025 10:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8843134D559
	for <lists+linux-edac@lfdr.de>; Tue,  4 Nov 2025 09:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0F5296BC2;
	Tue,  4 Nov 2025 09:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFQJVcMz"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0F62D7BF;
	Tue,  4 Nov 2025 09:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762249143; cv=none; b=VhoAtxAxGm5WjjDuJXFRXrL+pNy7TqRN1wXgB6dLs3WJHPL6B5Jnd2FiWr4w4IbfzL6sehbheFj84816LS24PGsaZS+u3OYslIvdTnQ6c4b92yOw8bgWiTs+D0K+v8y/3PzDKIKGyTDxJkaraF0RCC57xRci4KDwAF0fZW7sY40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762249143; c=relaxed/simple;
	bh=yCvLd6/nomDiRwqOxlI7HgKTubggDv3X7Fw8HkVVE90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZUZmxd6eAA/M0n7ueahf0n5azKFP6xkvly+sCf3Yhy8UXUegbdVyu7ybKf9QsSH9UTTI5q4ZyEN7A3EBCAeefbkfRY6JAbRFGjGUxT2vnxTaqNs7fHXXzCnx0W0h5XG7I4J2B63oBIzsUOvYcSmm+g78COkUOPIB2DGhCesSBCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFQJVcMz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B021DC16AAE;
	Tue,  4 Nov 2025 09:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762249143;
	bh=yCvLd6/nomDiRwqOxlI7HgKTubggDv3X7Fw8HkVVE90=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZFQJVcMzqNmStko7xcWsrOQU2jsh+T1CI46vYG7MnzH0iwjcfZAn6Iq4VUzTsLeFv
	 EDzRxhDVpIdsBW7iHYlhsuhz8JZKZ+EfC7eqTQZjkhD5UGaB/yZ+eUzyqR2lf+hfTU
	 RvSHzngbGZs3QS7uoyr/8slXk3r5d0MZT3i0lKwcZ8ryBtKSjdU4Rj+F2Mxdw+XEWS
	 6LvvRwC5JqOArtOvAwEwGHqwxJqINAQ4R3zhvb+r31uCmFRLofuAX6m2wGXjxdySf/
	 JA1nk5xWCsQ9/OWkCIAejRBF4rCVeNopvCjP4zEpewQbzFb/fi6GPJ9S/8eZxc/gki
	 PIYs8bzyFG+Iw==
Message-ID: <01b44e0f-ea2e-406f-9f65-b698b5504f42@kernel.org>
Date: Tue, 4 Nov 2025 10:38:54 +0100
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mm/memory-failure: remove the selection of RAS
To: Xie Yuanbin <xieyuanbin1@huawei.com>, david@redhat.com,
 dave.hansen@intel.com, bp@alien8.de, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, hpa@zytor.com, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, linmiaohe@huawei.com,
 nao.horiguchi@gmail.com, luto@kernel.org, peterz@infradead.org,
 tony.luck@intel.com
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-edac@vger.kernel.org, will@kernel.org, liaohua4@huawei.com,
 lilinjie8@huawei.com
References: <20251104072306.100738-1-xieyuanbin1@huawei.com>
 <20251104072306.100738-3-xieyuanbin1@huawei.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251104072306.100738-3-xieyuanbin1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.11.25 08:23, Xie Yuanbin wrote:
> The commit 97f0b13452198290799f ("tracing: add trace event for
> memory-failure") introduces the selection of RAS in memory-failure.
> This commit is just a tracing feature; in reality, there is no dependency
> between memory-failure and RAS. RAS increases the size of the bzImage
> image by 8k, which is very valuable for embedded devices.
> 
> Move the memory-failure traceing code from ras_event.h to
> memory-failure.h and remove the selection of RAS.
> 
> Signed-off-by: Xie Yuanbin <xieyuanbin1@huawei.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> ---

[...]

> +++ b/include/trace/events/memory-failure.h
> @@ -0,0 +1,97 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM ras

This trace system should not be called "ras". All RAS terminology should 
be removed here.

#define TRACE_SYSTEM memory_failure

> +#define TRACE_INCLUDE_FILE memory-failure
> +
> +#if !defined(_TRACE_MEMORY_FAILURE_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_MEMORY_FAILURE_H
> +
> +#include <linux/tracepoint.h>
> +#include <linux/mm.h>
> +
> +/*
> + * memory-failure recovery action result event
> + *
> + * unsigned long pfn -	Page Frame Number of the corrupted page
> + * int type	-	Page types of the corrupted page
> + * int result	-	Result of recovery action
> + */
> +
> +#define MF_ACTION_RESULT	\
> +	EM ( MF_IGNORED, "Ignored" )	\
> +	EM ( MF_FAILED,  "Failed" )	\
> +	EM ( MF_DELAYED, "Delayed" )	\
> +	EMe ( MF_RECOVERED, "Recovered" )
> +
> +#define MF_PAGE_TYPE		\
> +	EM ( MF_MSG_KERNEL, "reserved kernel page" )			\
> +	EM ( MF_MSG_KERNEL_HIGH_ORDER, "high-order kernel page" )	\
> +	EM ( MF_MSG_HUGE, "huge page" )					\
> +	EM ( MF_MSG_FREE_HUGE, "free huge page" )			\
> +	EM ( MF_MSG_GET_HWPOISON, "get hwpoison page" )			\
> +	EM ( MF_MSG_UNMAP_FAILED, "unmapping failed page" )		\
> +	EM ( MF_MSG_DIRTY_SWAPCACHE, "dirty swapcache page" )		\
> +	EM ( MF_MSG_CLEAN_SWAPCACHE, "clean swapcache page" )		\
> +	EM ( MF_MSG_DIRTY_MLOCKED_LRU, "dirty mlocked LRU page" )	\
> +	EM ( MF_MSG_CLEAN_MLOCKED_LRU, "clean mlocked LRU page" )	\
> +	EM ( MF_MSG_DIRTY_UNEVICTABLE_LRU, "dirty unevictable LRU page" )	\
> +	EM ( MF_MSG_CLEAN_UNEVICTABLE_LRU, "clean unevictable LRU page" )	\
> +	EM ( MF_MSG_DIRTY_LRU, "dirty LRU page" )			\
> +	EM ( MF_MSG_CLEAN_LRU, "clean LRU page" )			\
> +	EM ( MF_MSG_TRUNCATED_LRU, "already truncated LRU page" )	\
> +	EM ( MF_MSG_BUDDY, "free buddy page" )				\
> +	EM ( MF_MSG_DAX, "dax page" )					\
> +	EM ( MF_MSG_UNSPLIT_THP, "unsplit thp" )			\
> +	EM ( MF_MSG_ALREADY_POISONED, "already poisoned" )		\
> +	EMe ( MF_MSG_UNKNOWN, "unknown page" )
> +
> +/*
> + * First define the enums in MM_ACTION_RESULT to be exported to userspace
> + * via TRACE_DEFINE_ENUM().
> + */
> +#undef EM
> +#undef EMe
> +#define EM(a, b) TRACE_DEFINE_ENUM(a);
> +#define EMe(a, b)	TRACE_DEFINE_ENUM(a);
> +
> +MF_ACTION_RESULT
> +MF_PAGE_TYPE
> +
> +/*
> + * Now redefine the EM() and EMe() macros to map the enums to the strings
> + * that will be printed in the output.
> + */
> +#undef EM
> +#undef EMe
> +#define EM(a, b)		{ a, b },
> +#define EMe(a, b)	{ a, b }
> +
> +TRACE_EVENT(memory_failure_event,
> +	TP_PROTO(unsigned long pfn,
> +		 int type,
> +		 int result),
> +
> +	TP_ARGS(pfn, type, result),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned long, pfn)
> +		__field(int, type)
> +		__field(int, result)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->pfn	= pfn;
> +		__entry->type	= type;
> +		__entry->result	= result;
> +	),
> +
> +	TP_printk("pfn %#lx: recovery action for %s: %s",
> +		__entry->pfn,
> +		__print_symbolic(__entry->type, MF_PAGE_TYPE),
> +		__print_symbolic(__entry->result, MF_ACTION_RESULT)
> +	)
> +);
> +#endif /* _TRACE_MEMORY_FAILURE_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>


We want to add that new file to the "HWPOISON MEMORY FAILURE HANDLING" 
section in MAINTAINERS.

Nothing else jumped at me.

-- 
Cheers

David

