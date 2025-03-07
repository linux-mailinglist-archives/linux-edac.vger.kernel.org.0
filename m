Return-Path: <linux-edac+bounces-3308-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC033A57300
	for <lists+linux-edac@lfdr.de>; Fri,  7 Mar 2025 21:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9CBF3B2BC2
	for <lists+linux-edac@lfdr.de>; Fri,  7 Mar 2025 20:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA95E257426;
	Fri,  7 Mar 2025 20:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OfSeKN2n"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3A42571CA;
	Fri,  7 Mar 2025 20:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741380054; cv=none; b=WiKt0AiaJmpQ78wWeIPnN1qqm3bJnbsGGqUNCvCsoEmEra8/I+myUkTj2cYwA906n1bIMqJYBHCflK9/RoBKH0XNhIfitm/AzK390M/wWlXJES8YRuNdipJvcfVbdkFyBBUwb8PZGjdKrm7fO1PrqirP3R1kwff9XKi8pqj/ang=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741380054; c=relaxed/simple;
	bh=1F+rED3Q3WyzWENlHa5e0Ut3mPatCVA5SZHzdiF5Spw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STlpA66xxQzutMvb5zqAm5Lq+2jVtf0AxrLxATzA3WHsUp5CiLYpMK9/nL7MlcUOepFu2xdDprxtJeiEZex+lEiLFfIlYb7StsQMXkljEi6p3ymyxlcQdgmGWgyE7h0TD/0Pvh34M2pNfRrcWOU7D/xhLmujKIWjirVoOtFwBdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=OfSeKN2n; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C650340E015D;
	Fri,  7 Mar 2025 20:40:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NdKAio2ugQHc; Fri,  7 Mar 2025 20:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741380043; bh=tvmXHqIYftJRt0oebzEXA55kOmNwTMYQGu0wdi+S7Eg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OfSeKN2nlvAM2oE4E6Hj1y5anGWONXxJLReZcM5ozITUBK6d3BN6/jf4r5CsOXaMP
	 Vqd+ZJYupKT35Qfbk4MtttZL1C+/jXCihCoti0D7Fd/wFnSBLkQafJJgPFFngJ6/fJ
	 SRuv5i5NqXrbfPJq1ThWHhY3SpnFYKuzxqbKS/MJZxL614PksFIoJN2thyKTluE2Vz
	 V8Lti7CArvD++Hvx7e/jcVpU8rg1WDfK8dheNM2vjx1SJ35twnH2kuXCZJNEkfOv5T
	 exdFO/BTeAzovlwmJNYi+mxgqBn9WV66NuNmSLUZ/4zwqOGpt16CmagS1fDQqiY44p
	 HJeEYWpC0MX8rHdOFyMActWo4ALEcHEx+C4Wm+v57ipCFCaPkSLBPbWA+JcgQSB/jf
	 43Z9egVA20dmvLt0Au5J7vHgORgGLBRusqAGEpAh2P09ZUib1eIFcfcon2E1rwSvL7
	 tt5xITym5JDwOommx/kz/vMW4z2GUoJcjb1nWUcPsh1WnSAgHFfBjOIgiDy9FIuuUC
	 EQgTUFH2uX81W17IJibP3d6+sMRaUuHIh4MrMdvuwnmrufSeD6WSkyWypjnRUlKodh
	 iCNIT0EJ5qXz4SUZnfeOsAeEBlz7bVCuARf9flraD2J3FnpDd2v8oT4GSnQ3Fr9WCl
	 g6BwowHg+hmWZJinUEdG1UiI=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E0ABF40E01A0;
	Fri,  7 Mar 2025 20:40:23 +0000 (UTC)
Date: Fri, 7 Mar 2025 21:40:18 +0100
From: Borislav Petkov <bp@alien8.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: tony.luck@intel.com, peterz@infradead.org, catalin.marinas@arm.com,
	yazen.ghannam@amd.com, akpm@linux-foundation.org,
	linmiaohe@huawei.com, nao.horiguchi@gmail.com, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, jpoimboe@kernel.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	baolin.wang@linux.alibaba.com, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v4 1/3] x86/mce: Use is_copy_from_user() to determine
 copy-from-user context
Message-ID: <20250307204018.GAZ8tZstt11Y4KFprC@fat_crate.local>
References: <20250307054404.73877-1-xueshuai@linux.alibaba.com>
 <20250307054404.73877-2-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250307054404.73877-2-xueshuai@linux.alibaba.com>

On Fri, Mar 07, 2025 at 01:44:02PM +0800, Shuai Xue wrote:
> Commit 4c132d1d844a ("x86/futex: Remove .fixup usage") introduced a new
> extable fixup type, EX_TYPE_EFAULT_REG, and commit 4c132d1d844a
> ("x86/futex: Remove .fixup usage") updated the extable fixup type for
> copy-from-user operations, changing it from EX_TYPE_UACCESS to
> EX_TYPE_EFAULT_REG. The error context for copy-from-user operations no
> longer functions as an in-kernel recovery context. Consequently, the error
> context for copy-from-user operations no longer functions as an in-kernel
> recovery context, resulting in kernel panics with the message: "Machine
> check: Data load in unrecoverable area of kernel."
> 
> The critical aspect is identifying whether the error context involves a
> read from user memory. We do not care about the ex-type if we know its a

Please use passive voice in your commit message: no "we" or "I", etc,
and describe your changes in imperative mood.

Also, pls read section "2) Describe your changes" in
Documentation/process/submitting-patches.rst for more details.

Also, see section "Changelog" in
Documentation/process/maintainer-tip.rst

Bottom line is: personal pronouns are ambiguous in text, especially with
so many parties/companies/etc developing the kernel so let's avoid them
please.

"ex-type"?

Please write in plain English - not in a programming language.

> MOV reading from userspace. is_copy_from_user() return true when both of
> the following conditions are met:
> 
>     - the current instruction is copy

There is no "copy instruction". You mean the "current operation".

>     - source address is user memory

So you can simply say "when reading user memory". Simple.
> 
> So, use is_copy_from_user() to determin if a context is copy user directly.

Unknown word [determin] in commit message.
Suggestions: ['determine',

Please introduce a spellchecker into your patch creation workflow.

Also, run your commit messages through AI to correct the grammar and
formulations in them.

The more important part which I asked for already is, is is_copy_from_user()
exhaustive in determining the that the operation really is a copy from user?

The EX_TYPE_UACCESS things *explicitly* marked such places in the code. Does
is_copy_from_user() guarantee the same, without false positives?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

