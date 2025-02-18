Return-Path: <linux-edac+bounces-3129-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A016A39C13
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 13:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AFEC1891410
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 12:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A172417E1;
	Tue, 18 Feb 2025 12:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BkBOoiME"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52462417E3;
	Tue, 18 Feb 2025 12:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739881489; cv=none; b=RZoXE80abRfoTQ4G6ebnnMVtUH/JjSL4pL5hd6l7oZ1ZwOGHmVevJM7Bl02gSydRF0BrW8SivCELsGXd9w62wYJdkMSq77oV9lrrRM+sJtbFMx9JyGj8veRx/AcWeWDusvkR/b8AcLqdzmzLf9JS8KEM6orJgmOMq+/xpeXqriQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739881489; c=relaxed/simple;
	bh=B/22zPRyJLkyFbsyzQOg7F8j5yKKchLBj1RL06SOF5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajDgjbyF7M+1/Y8hHibnFIftOy79ubuP8S2xbbrU+gkFjN3I+0kH4iqpxiOmTrBdzFHqyNb+lRWq04CRCDPYs7zDp1OXv53EKZzv3xudx/QM1+zKR/bK4nrUxctgmLCyrGErNHAR15ECnrvr9Qf9RYOXGtOZk2KypOlo9CoLGxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BkBOoiME; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2B39A40E020E;
	Tue, 18 Feb 2025 12:24:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id OyDvPaUDwoWc; Tue, 18 Feb 2025 12:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739881480; bh=WI+Uaqm9Cw9dVESJ3i25x12Uq0b4Q9A8IQaKBTE93+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BkBOoiMEQp6jcZIbbtwagiV/Mkd09m070ochMoIyiIdzrc9aMIoMIojtiuuG8zQt9
	 /s9Haq1pxtO1MK7+24L43rHDcxwkmNJSUc29w73lHdosqGzk9MxQVNBl7hAZVay6Rx
	 dnRjIvKIKdU/RfFELDlLTcHuxdGGffIEhhAp/I1wNai5wu5fXHwQdDwLxdkcOA48r2
	 qcHErggIqF59QrohnLog0FS4ToJqWLHu+4lJi2HM6klQvErzfoP/0uF5HetDWxwcj6
	 CVI7ELi7ASFOtnflUUDpXBqT83ckeh5Qy4iyQtoB/2ebxvX0LKL4R61EBy3uEdd6HB
	 aLyHalxJ2Ic6SFTCXI/vEvaMrw4TuuS9bttqco4L6Xb5ArZWwt8UL57GuwCYYelXYs
	 FoaERsjklDv4B2LECzgWgiSBclaQU41VEcHCgIfj3ay4FtYrkyQyQUWPurWdkE47Dr
	 bJcjxcS1r6ux2S11bCClbdymi+5JGgNPv9WRqDbxxpLs0EtAeYR3nYJSbzVgwWTABt
	 6biRjIRtGzIsQILJsuU/HZSa7iHML0NOAA4yMmWdxCGA0vv2XO/URUBd2ZRmm7nQYW
	 tfBayKNLv5JtlE05eBSMhVN07wZC/qkIrMUVZoS5x25k4USRwTnt7BkS0v9/cCM8Ls
	 S2DhYoqaZrkYwY7YKX3XlVQM=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C2CD140E01A1;
	Tue, 18 Feb 2025 12:24:22 +0000 (UTC)
Date: Tue, 18 Feb 2025 13:24:17 +0100
From: Borislav Petkov <bp@alien8.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>, tony.luck@intel.com
Cc: nao.horiguchi@gmail.com, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	linmiaohe@huawei.com, akpm@linux-foundation.org,
	peterz@infradead.org, jpoimboe@kernel.org,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, baolin.wang@linux.alibaba.com,
	tianruidong@linux.alibaba.com
Subject: Re: [PATCH v2 0/5] mm/hwpoison: Fix regressions in memory failure
 handling
Message-ID: <20250218122417.GHZ7R78fPm32jKYUlx@fat_crate.local>
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
 <20250218082727.GCZ7REb7OG6NTAY-V-@fat_crate.local>
 <7393bcfb-fe94-4967-b664-f32da19ae5f9@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7393bcfb-fe94-4967-b664-f32da19ae5f9@linux.alibaba.com>

On Tue, Feb 18, 2025 at 07:31:34PM +0800, Shuai Xue wrote:
> Kernel can recover from poison found while copying from user space.

Where was that poison found? On user pages? So reading them consumes the
poison?

So you're not really seeing real issues on real hw - you're using ras tools to
trigger those, correct?

If so, what guarantees ras tools are doing the right thing?

> MCE check the fixup handler type to decide whether an in kernel #MC can be
> recovered.  When EX_TYPE_UACCESS is found,

Sounds like poison on user memory...

> the PC jumps to recovery code specified in _ASM_EXTABLE_FAULT() and return
> a -EFAULT to user space.

> For instr case:
> 
> If a poison found while instruction fetching in user space, full recovery is
> possible. User process takes #PF, Linux allocates a new page and fills by
> reading from storage.
> 
> > 3. What actually happens and why
> 
> For copyin case: kernel panic since v5.17
> 
> Commit 4c132d1d844a ("x86/futex: Remove .fixup usage") introduced a new extable
> fixup type, EX_TYPE_EFAULT_REG, and later patches updated the extable fixup
> type for copy-from-user operations, changing it from EX_TYPE_UACCESS to
> EX_TYPE_EFAULT_REG.

What do futexes have to do with copying user memory?

> For instr case: user process is killed by a SIGBUS signal
> 
> Commit 046545a661af ("mm/hwpoison: fix error page recovered but reported "not
> recovered"") introduced a bug that kill_accessing_process() return -EHWPOISON
> for instr case, as result, kill_me_maybe() send a SIGBUS to user process.

This makes my head hurt... a race between the CMCI reporting an uncorrected
error... why does the CMCI report uncorrected errors? This sounds like some
nasty confusion.

And you've basically reused the format and wording of 046545a661af for your
commit message and makes staring at those a PITA.

Tony, what's going on with that CMCI and SRAR race?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

