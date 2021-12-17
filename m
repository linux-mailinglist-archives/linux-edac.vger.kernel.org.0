Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADAB04789E6
	for <lists+linux-edac@lfdr.de>; Fri, 17 Dec 2021 12:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbhLQL3r (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 17 Dec 2021 06:29:47 -0500
Received: from mail.skyhub.de ([5.9.137.197]:52822 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229817AbhLQL3r (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 17 Dec 2021 06:29:47 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 663061EC01A2;
        Fri, 17 Dec 2021 12:29:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1639740582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0dsuzqrpYsFL/K0AJrrGFcR61xzUAu7ie3t40tDlXQY=;
        b=auit6a3pktzqkzNQIzLGjJzaN/5YSK4WbaJxDFChnx2ufBfcei61QU7oJ7wVLMHnO8vpOY
        zyxkCkV1SDSKzKww0YZL6ZxgRXqzzrUDF6e7QSyS+NXHPThEO+1hZVMEuEPSflj8rieW1e
        3nQzGdLcc7UGwREIv9nmsRXvpyJ6a68=
Date:   Fri, 17 Dec 2021 12:29:45 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-edac@vger.kernel.org, Tony Luck <tony.luck@intel.com>
Subject: Re: [bug report] x86/mce: Prevent severity computation from being
 instrumented
Message-ID: <Ybx0qV3S61Hjj+jw@zn.tnic>
References: <20211217102029.GA29708@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211217102029.GA29708@kili>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

+ Tony.

On Fri, Dec 17, 2021 at 01:20:29PM +0300, Dan Carpenter wrote:
> Hello Borislav Petkov,
> 
> This is a semi-automatic email about new static checker warnings.
> 
> The patch 0a5b288e85bb: "x86/mce: Prevent severity computation from
> being instrumented" from Oct 13, 2021, leads to the following Smatch
> complaint:
> 
>     arch/x86/kernel/cpu/mce/severity.c:286 error_context()
>     warn: variable dereferenced before check 'regs' (see line 280)
> 
> arch/x86/kernel/cpu/mce/severity.c
>    279		fixup_type = ex_get_fixup_type(m->ip);
>    280		copy_user  = is_copy_from_user(regs);
>                                                ^^^^
> New unchecked dereference
> 
>    281		instrumentation_end();
>    282	
>    283		switch (fixup_type) {
>    284		case EX_TYPE_UACCESS:
>    285		case EX_TYPE_COPY:
>    286			if (!regs || !copy_user)
>                              ^^^^
> Old code checked for NULL
> 
>    287				return IN_KERNEL;
>    288			m->kflags |= MCE_IN_KERNEL_COPYIN;

Good catch, thanks!

I guess we can do something like this:

---
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index a32646769705..7aa2bda93cbb 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -222,6 +222,9 @@ static bool is_copy_from_user(struct pt_regs *regs)
 	struct insn insn;
 	int ret;
 
+	if (!regs)
+		return false;
+
 	if (copy_from_kernel_nofault(insn_buf, (void *)regs->ip, MAX_INSN_SIZE))
 		return false;
 
@@ -283,7 +286,7 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
 	switch (fixup_type) {
 	case EX_TYPE_UACCESS:
 	case EX_TYPE_COPY:
-		if (!regs || !copy_user)
+		if (!copy_user)
 			return IN_KERNEL;
 		m->kflags |= MCE_IN_KERNEL_COPYIN;
 		fallthrough;

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
