Return-Path: <linux-edac+bounces-3130-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 832FCA39C90
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 13:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C6067A0541
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 12:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF0225A620;
	Tue, 18 Feb 2025 12:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BUhxIFPN"
X-Original-To: linux-edac@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4961DDE9;
	Tue, 18 Feb 2025 12:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739883277; cv=none; b=gvNeB9ULODTi8nXlTuWTe12PoYlAHO5nVWtHtkmMqRLRNfyg/fMjUpqsscnTExnjZ6IaF7fn5cLuccznzRRj/0farwsf7gVZ8U86RbYnWegFvkalJdp0ocRQgbeBDbIGLRKEFsVmJavM9slYpJNOuZoql6V9ctLDXPwi1B4NgYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739883277; c=relaxed/simple;
	bh=9iLjWenisN+dVaIMgiSEzXpNWoRcY2AAiSCeIH8AZG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1YtKOpEDHhxeXxBzPNwfA1LvAZ8sToyBfy9KMALdooOzyTUv8FjhATN4UgfDfdmi1huvlhCcc7hfFxwSAzl+rtI2174p5m9pJItUpQnjnQIm/vhkEMHLgi2NHefNU0X6Jxwhih13SU37sIdqLUMdckSD6bfyH2w21R8npZG85A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BUhxIFPN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VVKWP6ytKSkuriXLiOY594dcQpAZqm3RHMrTqM14g2g=; b=BUhxIFPN3HA0SscltiSVAqvCLZ
	VMvZsqM/qx1AFkRQNuSx0NK+E2BHghzF33a30xyuVkgU5Vrv/TCTQQCB7pbiZvYx48tCXFwEr/vin
	mg4+dVUWRBwmZPd8VAQvDE2VWZMIC9ZNcir+7KOfrXlegoylzV3Ige9xU5cdZZeZAblfjotS59NHp
	6yP18R1R1k/ZfV4PMunQW5+NXO+pfpPyRXJOSfKzSjVOPbpcJFKBY57i2E1DT4ILGUA61aOr5Gy2K
	S0Ua8QZjXuuZUBdcqjKvMargyKVUf1mK3gsjgBSwPgaQO+Mu/GsaQSfcBcjzVGp5/8zO7Pne9CUAQ
	eCZDUlWw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tkN73-00000002xxp-1FSx;
	Tue, 18 Feb 2025 12:54:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 30E9E30066A; Tue, 18 Feb 2025 13:54:08 +0100 (CET)
Date: Tue, 18 Feb 2025 13:54:08 +0100
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
Message-ID: <20250218125408.GD40464@noisy.programming.kicks-ass.net>
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
 <20250217063335.22257-4-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217063335.22257-4-xueshuai@linux.alibaba.com>

On Mon, Feb 17, 2025 at 02:33:33PM +0800, Shuai Xue wrote:

> diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
> index dac4d64dfb2a..14c2d71c3ce1 100644
> --- a/arch/x86/kernel/cpu/mce/severity.c
> +++ b/arch/x86/kernel/cpu/mce/severity.c
> @@ -16,6 +16,7 @@
>  #include <asm/traps.h>
>  #include <asm/insn.h>
>  #include <asm/insn-eval.h>
> +#include <linux/extable.h>
>  
>  #include "internal.h"
>  
> @@ -285,7 +286,8 @@ static bool is_copy_from_user(struct pt_regs *regs)
>   */
>  static noinstr int error_context(struct mce *m, struct pt_regs *regs)
>  {
> -	int fixup_type;
> +	const struct exception_table_entry *e;
> +	int fixup_type, imm;
>  	bool copy_user;
>  
>  	if ((m->cs & 3) == 3)
> @@ -294,9 +296,14 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
>  	if (!mc_recoverable(m->mcgstatus))
>  		return IN_KERNEL;
>  
> +	e = search_exception_tables(m->ip);
> +	if (!e)
> +		return IN_KERNEL;

You didn't actually build this, did you? Or did you ignore the extra
noinstr warnings?

>  	/* Allow instrumentation around external facilities usage. */
>  	instrumentation_begin();
> -	fixup_type = ex_get_fixup_type(m->ip);
> +	fixup_type = FIELD_GET(EX_DATA_TYPE_MASK, e->data);
> +	imm  = FIELD_GET(EX_DATA_IMM_MASK,  e->data);
>  	copy_user  = is_copy_from_user(regs);
>  	instrumentation_end();
>  
> @@ -304,9 +311,13 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
>  	case EX_TYPE_UACCESS:
>  		if (!copy_user)
>  			return IN_KERNEL;
> -		m->kflags |= MCE_IN_KERNEL_COPYIN;
> -		fallthrough;
> -
> +		m->kflags |= MCE_IN_KERNEL_COPYIN | MCE_IN_KERNEL_RECOV;
> +		return IN_KERNEL_RECOV;
> +	case EX_TYPE_IMM_REG:
> +		if (!copy_user || imm != -EFAULT)
> +			return IN_KERNEL;
> +		m->kflags |= MCE_IN_KERNEL_COPYIN | MCE_IN_KERNEL_RECOV;
> +		return IN_KERNEL_RECOV;

Maybe I'm justnot understanding things, but what's wrong with something
like the below; why do we care about the ex-type if we know its a MOV
reading from userspace?

The less we muck about with the extable here, the better.

---
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index dac4d64dfb2a..cb021058165f 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -300,13 +300,12 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
 	copy_user  = is_copy_from_user(regs);
 	instrumentation_end();
 
-	switch (fixup_type) {
-	case EX_TYPE_UACCESS:
-		if (!copy_user)
-			return IN_KERNEL;
-		m->kflags |= MCE_IN_KERNEL_COPYIN;
-		fallthrough;
+	if (copy_user) {
+		m->kflags |= MCE_IN_KERNEL_COPYIN | MCE_IN_KERNEL_COPYIN;
+		return IN_KERNEL_RECOV
+	}
 
+	switch (fixup_type) {
 	case EX_TYPE_FAULT_MCE_SAFE:
 	case EX_TYPE_DEFAULT_MCE_SAFE:
 		m->kflags |= MCE_IN_KERNEL_RECOV;

