Return-Path: <linux-edac+bounces-3139-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D45A39E77
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 15:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EEF53A29D0
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 14:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F0C269D1C;
	Tue, 18 Feb 2025 14:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k0O75M8s"
X-Original-To: linux-edac@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EA6266F12;
	Tue, 18 Feb 2025 14:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739888160; cv=none; b=Q5an4ktZ8dlAC+MS5FgJjU5bDtwBIjuCJJVbX+yVhKlHq1WeaK0mOn96XjS+fyrWBpWerSbrSgtYQ5KwRsoqHUkgfmpqk+RwdXWkO3s243toi1ITB5AF8enkZG3ymk53gzhLBmstHrXETyAZcCzot9bqsfaBAoCTrSPTwAjNzD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739888160; c=relaxed/simple;
	bh=il0/fwos78QaT2glNgi9dBtOkSnaETReFROz9x7Tke8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h//UnFi4Od4Xf8/+WlU6RzcCaGn0xAPCbAGMH5lBcbHcv9HUwCaqE6UAO0FTq8uouPR7/sCbLHGuzVdd6KdBogaOSUmbhAouRVcIN0dpCt1fXpdNCnCj+FvSE6irvE45ST1UlPeTmym4HWO6OY5HktCa58lsmpngJMap0+F4cug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k0O75M8s; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=m5IoPhaVq1POyaoUMPduSGVVSP03TBUKtcmoRy88Zec=; b=k0O75M8s6Qt8NWWKvXofnjANYK
	uQceWK6njmGSRheLJ4tjN2DfOUc4uWMGs9F45Eu5YzB09X63qnpLgMJrb3FRoS9cnwZSSXRqCpo5A
	/7nCQT7bnoCCuf5mBuW87CKCYUC+4m3Vb4MBqTqESDWtzBagxctnOo6oPiI2y+cpPTNVgO1Rdx+bu
	G3gEwvhnxyM/pkskRO5BFU32uveWKFjaltny+wvyCfIq8lmXZgJl3hEIXtrnX4CUb0Y8JUVwSsZqp
	JMiE1Rn51hSuvmjlEv0wQozOP28Ib+clMRPCNyW+7lOo48lncKMBKaOUETPWThXlC3kgXG9MLM+75
	XCHbuYwQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tkONs-00000003412-2WaL;
	Tue, 18 Feb 2025 14:15:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B6F7C30066A; Tue, 18 Feb 2025 15:15:35 +0100 (CET)
Date: Tue, 18 Feb 2025 15:15:35 +0100
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
Message-ID: <20250218141535.GC34567@noisy.programming.kicks-ass.net>
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
 <20250217063335.22257-4-xueshuai@linux.alibaba.com>
 <20250218125408.GD40464@noisy.programming.kicks-ass.net>
 <1ff716d3-eb3d-477e-ae30-1abe97eee01b@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ff716d3-eb3d-477e-ae30-1abe97eee01b@linux.alibaba.com>

On Tue, Feb 18, 2025 at 09:28:33PM +0800, Shuai Xue wrote:

> I did build and test this patch set on it. But I did not find any warnings.
> Could you provide more details?

NOINSTR_VALIDATION=y helps

> > >   	/* Allow instrumentation around external facilities usage. */
> > >   	instrumentation_begin();
> > > -	fixup_type = ex_get_fixup_type(m->ip);
> > > +	fixup_type = FIELD_GET(EX_DATA_TYPE_MASK, e->data);
> > > +	imm  = FIELD_GET(EX_DATA_IMM_MASK,  e->data);
> > >   	copy_user  = is_copy_from_user(regs);
> > >   	instrumentation_end();
> > > @@ -304,9 +311,13 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
> > >   	case EX_TYPE_UACCESS:
> > >   		if (!copy_user)
> > >   			return IN_KERNEL;
> > > -		m->kflags |= MCE_IN_KERNEL_COPYIN;
> > > -		fallthrough;
> > > -
> > > +		m->kflags |= MCE_IN_KERNEL_COPYIN | MCE_IN_KERNEL_RECOV;
> > > +		return IN_KERNEL_RECOV;
> > > +	case EX_TYPE_IMM_REG:
> > > +		if (!copy_user || imm != -EFAULT)
> > > +			return IN_KERNEL;
> > > +		m->kflags |= MCE_IN_KERNEL_COPYIN | MCE_IN_KERNEL_RECOV;
> > > +		return IN_KERNEL_RECOV;
> > 
> > Maybe I'm justnot understanding things, but what's wrong with something
> > like the below; why do we care about the ex-type if we know its a MOV
> > reading from userspace?
> > 
> > The less we muck about with the extable here, the better.
> 
> We need to make sure that we have register a fixup handler for the copy_user
> case.  If no fixup handler found, the PC accessing posion will trigger #MCE
> again and again resulting a hardlock up.

Well, then write it like so. Afaict, you don't care what the actual
exception type is, just that there is one, for the copy_user case.

diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index dac4d64dfb2a..cfdae25eacd7 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -301,18 +301,19 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
 	instrumentation_end();
 
 	switch (fixup_type) {
-	case EX_TYPE_UACCESS:
-		if (!copy_user)
-			return IN_KERNEL;
-		m->kflags |= MCE_IN_KERNEL_COPYIN;
-		fallthrough;
-
 	case EX_TYPE_FAULT_MCE_SAFE:
 	case EX_TYPE_DEFAULT_MCE_SAFE:
 		m->kflags |= MCE_IN_KERNEL_RECOV;
 		return IN_KERNEL_RECOV;
 
 	default:
+		if (copy_user) {
+			m->kflags |= MCE_IN_KERNEL_COPYIN | MCE_IN_KERNEL_RECOV;
+			return IN_KERNEL_RECOV;
+		}
+		fallthrough;
+
+	case EX_TYPE_NONE:
 		return IN_KERNEL;
 	}
 }

