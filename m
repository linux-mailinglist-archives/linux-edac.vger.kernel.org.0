Return-Path: <linux-edac+bounces-3142-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66068A3A328
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 17:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AAD93AA4C3
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 16:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49124269AFD;
	Tue, 18 Feb 2025 16:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HD/O1tXX"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2000014A4E7;
	Tue, 18 Feb 2025 16:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739897313; cv=none; b=Z56ydNAuLZx7Rx6dRuCnvQs7EuVdcGQ1psS7szmcroxAEhyeX2aggbTgmsKAWEQAlluG9gZ3C9e5JCjTyh6ZEKKWPUk7q3i5Jzi02kmV9Dg1Is8aRuaiirJecUQweqW5Js9rUuT7M7spo7VCr3Uhx/2JPKurbuZOQNkUvpgTTG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739897313; c=relaxed/simple;
	bh=otEYAf2By+RplMWWatkXEUSLTFeywrjdB+JwrfM0OBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emRaGyJsrCfaPQ+ujJr4gwzqk96eftRzO97Pgg+CffCWNg4q8ChmAhhNBjrY840jNivhp43yhFMcFWP5ONSmRIldbS1A0g1VRwnD6MrusQ8iEAouKl9ZfMQEsiuxjcc7DaKurhUW0mZ5coLAYGV3LT+D062e3pcCaEaSJ3uDR6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HD/O1tXX; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6FA1740E021F;
	Tue, 18 Feb 2025 16:48:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xeyfLXdiWnKB; Tue, 18 Feb 2025 16:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739897304; bh=4qKrqlnj1J4jOxgftZM09y1CXDjIpIB/KfD0MtUHuWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HD/O1tXXg+DLMtbYiPZsmIvGTksECzRsjwqMgQreKM7RvI9Vt+y8h40eM9ebmG9wo
	 b3iTh3Y8vNBurKLoxdeGhjdlj0SMlTWy8mLtVbbnoPFrkrbrSSEGAZa0hgo/Ty90vi
	 BKDLBfk69CIuzfJscYn263RApCzaQHNUve983dYDi7yUZ5G4cxmSBekIqWlS6WMqG0
	 DML5A/NYXI3ICXrPTt3BZqPdskntzd+qh4PeOfCW27FGFIDrScmmSkkeFIV57Hk5PS
	 1O2KvMm8ltX0EIffOUUrPclAxye9Ej5di4yupo/XvANWRM7PCJ0xiA6Yf3ovHauwFM
	 FjS6O8msJeiHzlcTzmi6ahAYTiGMDdjq8JE2hKYaS8NwdmbR7NA9g2cmLSqH9tqmnn
	 DZjM3FavJgjhq5bm+ObP555idawMoGnCrPpTrfrQUjmUoEBpf5sXSIr5FM6pVqIsso
	 NzshF7JTQ3ctHMH6Rtor1k2ii3lS2xbBEVFFB9RpF/wB6RgrXLseSTt4V0BvFrtGv8
	 L0naVQ9q8AMl7865gHCfDQGEM4a+TE0HCEs1vnFHHzXNH8he73U5xz/z8wCaCqPW4l
	 xQGkW7oRQ64xZz5YkyCK2JmZPpkmzZ2l+R+/e0W7XorBB//Ei7aXycqMJmWMaZBBBw
	 3kTJKY/q3025/Oa18b9mXMBI=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 43D3640E00C9;
	Tue, 18 Feb 2025 16:48:07 +0000 (UTC)
Date: Tue, 18 Feb 2025 17:48:00 +0100
From: Borislav Petkov <bp@alien8.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>, tony.luck@intel.com,
	nao.horiguchi@gmail.com, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	linmiaohe@huawei.com, akpm@linux-foundation.org,
	jpoimboe@kernel.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	baolin.wang@linux.alibaba.com, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v2 3/5] x86/mce: add EX_TYPE_EFAULT_REG as in-kernel
 recovery context to fix copy-from-user operations regression
Message-ID: <20250218164800.GNZ7S5wL1A4dTaySOP@fat_crate.local>
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
 <20250217063335.22257-4-xueshuai@linux.alibaba.com>
 <20250218125408.GD40464@noisy.programming.kicks-ass.net>
 <1ff716d3-eb3d-477e-ae30-1abe97eee01b@linux.alibaba.com>
 <20250218141535.GC34567@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250218141535.GC34567@noisy.programming.kicks-ass.net>

On Tue, Feb 18, 2025 at 03:15:35PM +0100, Peter Zijlstra wrote:
> diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
> index dac4d64dfb2a..cfdae25eacd7 100644
> --- a/arch/x86/kernel/cpu/mce/severity.c
> +++ b/arch/x86/kernel/cpu/mce/severity.c
> @@ -301,18 +301,19 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
>  	instrumentation_end();
>  
>  	switch (fixup_type) {
> -	case EX_TYPE_UACCESS:
> -		if (!copy_user)
> -			return IN_KERNEL;
> -		m->kflags |= MCE_IN_KERNEL_COPYIN;
> -		fallthrough;
> -
>  	case EX_TYPE_FAULT_MCE_SAFE:
>  	case EX_TYPE_DEFAULT_MCE_SAFE:
>  		m->kflags |= MCE_IN_KERNEL_RECOV;
>  		return IN_KERNEL_RECOV;
>  
>  	default:
> +		if (copy_user) {

As said on chat, if we can make is_copy_from_user() *always* correctly detect
user access, then sure but I'm afraid EX_TYPE_UACCESS being generated at the
handful places where we do user memory access is there for a reason as it
makes it pretty explicit.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

