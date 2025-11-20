Return-Path: <linux-edac+bounces-5487-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FF6C7473C
	for <lists+linux-edac@lfdr.de>; Thu, 20 Nov 2025 15:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 827AE4EB830
	for <lists+linux-edac@lfdr.de>; Thu, 20 Nov 2025 14:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117A23469E7;
	Thu, 20 Nov 2025 14:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIxgw57d"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA442307AFA;
	Thu, 20 Nov 2025 14:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763647203; cv=none; b=M+rutiqZPLvr7qApSWp/qVDgy98B7mABMjuqLFnjyI/nypl0uH6lKD5HE9aMHqt4rr+XxSWguYv76lH7LRA52ema7Sus43AnISmo3EurgkULVUgXnlbHyQedy02AgMrqGH2lb0lxQoxdSKYdDZT1q7UebvkACSgnF1lV6PxlJNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763647203; c=relaxed/simple;
	bh=3c1rDlMwrBbzOuvwQjvriGZ09BNm0ZrVc/uEpCI/im8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mJTNr9Z7W0KvYqCsS4r58+v8gNj51AJ5U1XhPoT4/WEZVAxjmxyXZHBeUKepGgt222uuC47rLiumxfhmRZo0A9X0gg3DN2yFtqzVxlD8Fg82hgPS0jm7dFvHi2t2cpM5cGxcCTqrFB5yDsiXe9dbridgXbVhOwYHL4E201X0dkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIxgw57d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD14C4CEF1;
	Thu, 20 Nov 2025 13:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763647202;
	bh=3c1rDlMwrBbzOuvwQjvriGZ09BNm0ZrVc/uEpCI/im8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OIxgw57dsl4CdroEfiPwEnKA/qK2YigIeTiVi5AlW3YxcgIYi9GBZusrzlVEOroyD
	 JsTGBTLY5JlXkZp875v6PsQ8NUULK+kIUd47qeV/x2bZyy1SKSN1TMy23JS7zXl7cz
	 ir1C/bH2smy+cQqvWVIjHghli4KIJM+Z25MgeNfmw2srRa1X6ayWcylZCI5HXl6MJf
	 wqmNuBZK0qm/IDFTW2ugm0gnifZ5qCTWlOBKpgNr2vX8j9pZ1eFqsDWeG9zTHXxmRb
	 OSqUnsJqqzXBV6442s/EW0bbVFA7cZsjTc5b4CQYdQzKVrmay3bBzhuC32QjqetYyO
	 sirtoHruo0W/A==
Message-ID: <fc7bae22-0705-475a-be89-8bb3ca12384d@kernel.org>
Date: Thu, 20 Nov 2025 14:59:54 +0100
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/memory-failure: remove the selection of RAS
To: Xie Yuanbin <xieyuanbin1@huawei.com>, tony.luck@intel.com, bp@alien8.de,
 linmiaohe@huawei.com, nao.horiguchi@gmail.com, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, will@kernel.org,
 liaohua4@huawei.com, lilinjie8@huawei.com
References: <20251119095943.67125-1-xieyuanbin1@huawei.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251119095943.67125-1-xieyuanbin1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/19/25 10:59, Xie Yuanbin wrote:
> The commit 97f0b13452198290799f ("tracing: add trace event for
> memory-failure") introduces the selection of RAS in memory-failure.
> This commit is just a tracing feature; in reality, there is no dependency
> between memory-failure and RAS. RAS increases the size of the bzImage
> image by 8k, which is very valuable for embedded devices.
> 
> Move the memory-failure traceing code from ras_event.h to
> memory-failure.h and remove the selection of RAS.
> 
> v2->v3: https://lore.kernel.org/20251104072306.100738-3-xieyuanbin1@huawei.com
>    - Change define TRACE_SYSTEM from ras to memory_failure
>    - Add include/trace/events/memory-failure.h to
>      "HWPOISON MEMORY FAILURE HANDLING" section in MAINTAINERS
>    - Rebase to latest linux-next source
> 
> v1->v2: https://lore.kernel.org/20251103033536.52234-2-xieyuanbin1@huawei.com
>    - Move the memory-failure traceing code from ras_event.h to
>      memory-failure.h
> 
> Signed-off-by: Xie Yuanbin <xieyuanbin1@huawei.com>
> Cc: David Hildenbrand (Red Hat) <david@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   MAINTAINERS                           |  1 +
>   include/ras/ras_event.h               | 87 ------------------------
>   include/trace/events/memory-failure.h | 98 +++++++++++++++++++++++++++
>   mm/Kconfig                            |  1 -
>   mm/memory-failure.c                   |  5 +-
>   5 files changed, 103 insertions(+), 89 deletions(-)
>   create mode 100644 include/trace/events/memory-failure.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7310d9ca0370..43d6eb95fb05 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11631,10 +11631,11 @@ R:	Naoya Horiguchi <nao.horiguchi@gmail.com>
>   L:	linux-mm@kvack.org
>   S:	Maintained
>   F:	include/linux/memory-failure.h
>   F:	mm/hwpoison-inject.c
>   F:	mm/memory-failure.c
> +F:	include/trace/events/memory-failure.

These are ordered alphabetically, so it should be further up next to the 
other include.

With that

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David

