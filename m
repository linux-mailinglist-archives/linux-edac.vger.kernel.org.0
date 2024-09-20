Return-Path: <linux-edac+bounces-1904-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBCE97D4DF
	for <lists+linux-edac@lfdr.de>; Fri, 20 Sep 2024 13:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71E6F1C21D0C
	for <lists+linux-edac@lfdr.de>; Fri, 20 Sep 2024 11:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25A4143738;
	Fri, 20 Sep 2024 11:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fM2OnSX3"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CDC13D28A;
	Fri, 20 Sep 2024 11:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726832148; cv=none; b=DnU5YSHQAqxhlYDXHNgNWLocRviHtnlYVw4aRY0tG55v7sANG8JH+gpgUmjZin/hpmHY3t2AymOoT7pwUuwvfaVWC0lg2DrNzPNcEAfRGVIY+62ysnhbClTHAV3fBC3kYjdPQU8JFppNkrNJjEf9BddZoTd6BW2G96ex4rzS14k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726832148; c=relaxed/simple;
	bh=EbTjQgk/7KugYLkubRSV4y03LGYLCfQsZg5hwoWGZyo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=r+vSpag6EshPKOyVBqOgDREIVljQ2P9BX181ulGP0GLrF/HHihFcfRe69nr78bwUQgDl602h/3hLPye0mCyAMd7O3u9HClCOlop1mC8NS2muwdkChUkm+kPcg1YeECiMj9OwpxRmlRZRUFmd0qooueYdebGJuCFtdjTFEsJKXxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fM2OnSX3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF4FC4CEC3;
	Fri, 20 Sep 2024 11:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726832148;
	bh=EbTjQgk/7KugYLkubRSV4y03LGYLCfQsZg5hwoWGZyo=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=fM2OnSX3rC+deNekkdTvQ+Arwe7lDLn8On26UqgCf7KcVwGnzJEDv95G78s2Yg8Ic
	 0NLb00A6A1czFHATmVWOYNWXUlTjYjLTDywli6stQlQ9qdR2nMgjo0d3lm5EeXHG2J
	 SRxdECnbhwWlW0XH+vky4wqtwBeZLZjSLYDpcCo4OSGc0co33RnxB4+mbMMHwbTdj7
	 5Aeh35PYdeEoPi5UFCq09Gz/bLSHctvQJlUhQ8lDkyI5KmKSIeN0yejIgvf6vti91W
	 k6E5Ioo9aWBV+BwZhIdWzQ8F9lBuYfTXG33YHiREeVNh62SkFDpmMBtgUaCT4tzTQ8
	 9Kc1PRIKou1qw==
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Sep 2024 14:35:44 +0300
Message-Id: <D4B2WNJCNUZG.2LF50Q197L6AN@kernel.org>
Cc: <linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
 <linux-edac@vger.kernel.org>, <x86@kernel.org>, <justin.he@arm.com>,
 <ardb@kernel.org>, <ying.huang@intel.com>, <ashish.kalra@amd.com>,
 <baolin.wang@linux.alibaba.com>, <tglx@linutronix.de>,
 <dave.hansen@linux.intel.com>, <lenb@kernel.org>, <hpa@zytor.com>,
 <robert.moore@intel.com>, <lvying6@huawei.com>, <xiexiuqi@huawei.com>,
 <zhuo.song@linux.alibaba.com>
Subject: Re: [PATCH v13 2/3] mm: memory-failure: move return value
 documentation to function declaration
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Shuai Xue" <xueshuai@linux.alibaba.com>, <mark.rutland@arm.com>,
 <catalin.marinas@arm.com>, <mingo@redhat.com>, <robin.murphy@arm.com>,
 <Jonathan.Cameron@Huawei.com>, <bp@alien8.de>, <rafael@kernel.org>,
 <wangkefeng.wang@huawei.com>, <tanxiaofei@huawei.com>,
 <mawupeng1@huawei.com>, <tony.luck@intel.com>, <linmiaohe@huawei.com>,
 <naoya.horiguchi@nec.com>, <james.morse@arm.com>, <tongtiangen@huawei.com>,
 <gregkh@linuxfoundation.org>, <will@kernel.org>
X-Mailer: aerc 0.18.2
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20240920043027.21907-3-xueshuai@linux.alibaba.com>
In-Reply-To: <20240920043027.21907-3-xueshuai@linux.alibaba.com>

On Fri Sep 20, 2024 at 7:30 AM EEST, Shuai Xue wrote:
> Part of return value comments for memory_failure() were originally
> documented at the call site. Move those comments to the function
> declaration to improve code readability and to provide developers with
> immediate access to function usage and return information.
>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c | 7 -------
>  mm/memory-failure.c            | 9 ++++++---
>  2 files changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/cor=
e.c
> index 2a938f429c4d..c90d8fcd246a 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1373,13 +1373,6 @@ static void kill_me_maybe(struct callback_head *cb=
)
>  		return;
>  	}
> =20
> -	/*
> -	 * -EHWPOISON from memory_failure() means that it already sent SIGBUS
> -	 * to the current process with the proper error info,
> -	 * -EOPNOTSUPP means hwpoison_filter() filtered the error event,
> -	 *
> -	 * In both cases, no further processing is required.
> -	 */
>  	if (ret =3D=3D -EHWPOISON || ret =3D=3D -EOPNOTSUPP)
>  		return;
> =20
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 7066fc84f351..7984e0d99d09 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2199,9 +2199,12 @@ static void kill_procs_now(struct page *p, unsigne=
d long pfn, int flags,
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

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

