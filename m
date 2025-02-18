Return-Path: <linux-edac+bounces-3131-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 055EDA39CCD
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 14:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D2C8188C8B3
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 13:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEB2269B18;
	Tue, 18 Feb 2025 13:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qqliAwyT"
X-Original-To: linux-edac@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9D5269B0F;
	Tue, 18 Feb 2025 13:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739883740; cv=none; b=HbvvsUtfimYizElSFgHcibyesn1BZBLLfQGgV68c+a1TgJIxHUs2deFZYq9QmN6Bgjb7B5e922lUYPSk0q7gslUyDXwqmBpH0KwhVO1i0WwB3a/kHUY4vVzHILq67wItqDBRSBDp8sVOjiNujdYjht28EBmanl9xEbMvMhwLuww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739883740; c=relaxed/simple;
	bh=DTqoC5RuRnGeckOikXeWSQc4ZtlXIxnkwnOAHMMnP2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIKaeDC63aecVOWlv5gsYVy0o4RO0Cx0VJQCu9K7tV4e3InZ9FXK/Vcwe+6pi/z37bBXtxOT5maQIbqNMqM7DAYORKK1C8OoJteGUrY0jfdDpy9x04KKiCOSDebJqf7PLtzbLIUThHMPsHzn22+zNArfPVwOSCwpQ33z0fYgi0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qqliAwyT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=esRoL3ov9D5pVObYEMuKxaYOWD0ZolLaLZj7ekAj/gI=; b=qqliAwyTPg4I4M1GIm6JZ/M4Iy
	/e82B8OeOs5AwEWec1TF/JLsgEPz9H+/wHsJ4DVkilUOOzt7JVZ3oWMJMaMoXmVLevDtiZ6USJNQV
	fMjV99+jfan1tMqjrH4myUmvCa8I7u40jV3WT5sM0dKSVEMWXECuL9MOwyP/ppD6A5Nic80zBwd1M
	VQZ02SBL4NoA6sqglTlEOYhuF3xhxX+cTYxyQTpX/BuNZxjmcJpzc+BcEp9auAEb/9yzwfTvkBAsl
	yYMyDE+1aa1rbQx3Lz/8lEQUa/iDJvoL2pbPMlr8R+tkQdhYTOy+Se7cuSUlMjvJIbsOFuJhI/++2
	MP9WyxZQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tkNEg-00000002yXj-2p1f;
	Tue, 18 Feb 2025 13:02:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 31B3630066A; Tue, 18 Feb 2025 14:02:02 +0100 (CET)
Date: Tue, 18 Feb 2025 14:02:02 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: tony.luck@intel.com, bp@alien8.de, nao.horiguchi@gmail.com,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, linmiaohe@huawei.com,
	akpm@linux-foundation.org, jpoimboe@kernel.org,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, baolin.wang@linux.alibaba.com,
	tianruidong@linux.alibaba.com
Subject: Re: [PATCH v2 3/5] x86/mce: add EX_TYPE_EFAULT_REG as in-kernel
 recovery context to fix copy-from-user operations regression
Message-ID: <20250218130202.GG31462@noisy.programming.kicks-ass.net>
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
 <20250217063335.22257-4-xueshuai@linux.alibaba.com>
 <20250218125408.GD40464@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218125408.GD40464@noisy.programming.kicks-ass.net>

On Tue, Feb 18, 2025 at 01:54:08PM +0100, Peter Zijlstra wrote:

> ---
> diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
> index dac4d64dfb2a..cb021058165f 100644
> --- a/arch/x86/kernel/cpu/mce/severity.c
> +++ b/arch/x86/kernel/cpu/mce/severity.c
> @@ -300,13 +300,12 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
>  	copy_user  = is_copy_from_user(regs);
>  	instrumentation_end();
>  
> -	switch (fixup_type) {
> -	case EX_TYPE_UACCESS:
> -		if (!copy_user)
> -			return IN_KERNEL;
> -		m->kflags |= MCE_IN_KERNEL_COPYIN;
> -		fallthrough;
> +	if (copy_user) {
> +		m->kflags |= MCE_IN_KERNEL_COPYIN | MCE_IN_KERNEL_COPYIN;

Typing is hard, obviously that second should'be been _RECOV.

> +		return IN_KERNEL_RECOV

But why are we having that bit *and* a return value saying the same
thing?

> +	}
>  
> +	switch (fixup_type) {
>  	case EX_TYPE_FAULT_MCE_SAFE:
>  	case EX_TYPE_DEFAULT_MCE_SAFE:
>  		m->kflags |= MCE_IN_KERNEL_RECOV;

