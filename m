Return-Path: <linux-edac+bounces-1797-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7297D96A3C9
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 18:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4B9E1C241C6
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 16:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92EA1898EE;
	Tue,  3 Sep 2024 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IA5U16DO"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFD71891D9;
	Tue,  3 Sep 2024 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725379838; cv=none; b=WYOZTVX5K/MPsUDHTjEszf/TMgpjKxjqQynpG7hp+IDR1WTTkmXsUghV9hQtQvjg9p2x8thAtzMNr8QOFl7V1udsl/3vKZfLD/2gB3jvF9Zb/1fkNw7Sin9vE60WbOxRfgD/M3HrkDoX6dCk2f/uuz6QUz0kk6PmqBEDg4ZmcuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725379838; c=relaxed/simple;
	bh=xex94DES95vi44hvW2E+tvA/zSdqkC8n+EuRP566ZLE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=IVEzcaT67IHabiteaCSn3v8VBS+MwSSIWMSh704pTeqyCkxnfTmbxnFs69s2Xb/dTF+zZPWKRiyzYbbXhydQ6pqPTK204LBDG/0nklXJdh7SOKRQz5jDt57czhhj86S30IrK6aePF5jiKJx/th4DPgySYe7LUWCaOE/12kvZlp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IA5U16DO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA66C4CEC4;
	Tue,  3 Sep 2024 16:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725379838;
	bh=xex94DES95vi44hvW2E+tvA/zSdqkC8n+EuRP566ZLE=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=IA5U16DOtLR6DbrDi1P5qpGMi5ooAiZQRplmIii4n4vbRax6vGy+wFArnwd1ZjJUb
	 ZHS6G4UDnyyVfDVgqwoBRglWfd+0wdrs6rq3FjniF+5bzDRdAyDWSdYErvIq3tLRrC
	 ZQ95U4BqBbOblMTd/mRPtWz+QKb0tbNkGwwwmPpKUAQIPxbyfp4LWbojukrsIapA25
	 1I4gJ6he/rDTUCA30WigqyOXrCsI92cARsoxPw73N+BamQ1RLjiq4e5dXXOcProWEo
	 NOt1ivbA0Qgk+GBWVBaN82dKIFQdA4c23tVVHIfISgNM+FpCrAAaPFi0mYB/ttNpUh
	 GF+7o1P09u0Yw==
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Sep 2024 19:10:34 +0300
Message-Id: <D3WS3TK054QR.580Q46WYCDEZ@kernel.org>
Subject: Re: [PATCH v12 2/3] mm: memory-failure: move return value
 documentation to function declaration
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Shuai Xue" <xueshuai@linux.alibaba.com>, <bp@alien8.de>,
 <rafael@kernel.org>, <wangkefeng.wang@huawei.com>, <tanxiaofei@huawei.com>,
 <mawupeng1@huawei.com>, <tony.luck@intel.com>, <linmiaohe@huawei.com>,
 <naoya.horiguchi@nec.com>, <james.morse@arm.com>, <tongtiangen@huawei.com>,
 <gregkh@linuxfoundation.org>, <will@kernel.org>
Cc: <linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
 <linux-edac@vger.kernel.org>, <x86@kernel.org>, <justin.he@arm.com>,
 <ardb@kernel.org>, <ying.huang@intel.com>, <ashish.kalra@amd.com>,
 <baolin.wang@linux.alibaba.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
 <dave.hansen@linux.intel.com>, <lenb@kernel.org>, <hpa@zytor.com>,
 <robert.moore@intel.com>, <lvying6@huawei.com>, <xiexiuqi@huawei.com>,
 <zhuo.song@linux.alibaba.com>
X-Mailer: aerc 0.18.2
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20240902030034.67152-3-xueshuai@linux.alibaba.com>
In-Reply-To: <20240902030034.67152-3-xueshuai@linux.alibaba.com>

On Mon Sep 2, 2024 at 6:00 AM EEST, Shuai Xue wrote:
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
> index b85ec7a4ec9e..66693b6dd1cd 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1361,13 +1361,6 @@ static void kill_me_maybe(struct callback_head *cb=
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
> index 7066fc84f351..df26e2ff5e06 100644
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
> + * Return values:

s/Return values/Return:/=20

https://www.kernel.org/doc/Documentation/kernel-doc-nano-HOWTO.txt

> + *   0             - success,
> + *   -EOPNOTSUPP   - hwpoison_filter() filtered the error event,
> + *   -EHWPOISON    - the page was already poisoned, potentially
> + *                   kill process,
> + *   other negative values - failure.
>   */
>  int memory_failure(unsigned long pfn, int flags)
>  {

BR, Jarkko

