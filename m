Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 216C28949F
	for <lists+linux-edac@lfdr.de>; Mon, 12 Aug 2019 00:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfHKWKu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 11 Aug 2019 18:10:50 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48776 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfHKWKu (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 11 Aug 2019 18:10:50 -0400
Received: from zn.tnic (p200300EC2F223C00705A3C93C863E474.dip0.t-ipconnect.de [IPv6:2003:ec:2f22:3c00:705a:3c93:c863:e474])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 872C41EC01AF;
        Mon, 12 Aug 2019 00:10:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565561448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/7+lA8pG049Y6XQ5QYmLyc6LCP+Ap+AkeW9aIY4Awco=;
        b=J1MEiYAc+/e5toqLbdospF5kmOLv/iN/B6Cgp9fOgWfWtBjn/Brg81efm7bWYdeiAu2jRu
        JXtV2AeQP+R9IBMCI9rbfggysSCjQ0DGKLg67pUnBl19Q/5fyM4cf3ugTnjWVvwDgqiQsj
        f0efp7atNMuYbUeWCAXKvQvrnEidlQs=
Date:   Mon, 12 Aug 2019 00:11:32 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Saar Amar <Saar.Amar@microsoft.com>
Cc:     "tony.luck@intel.com" <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [PATCH] Fix dangling pointer in MCE amd.c
Message-ID: <20190811221132.GA14617@zn.tnic>
References: <AM6PR83MB0312E97C139EA0A2EC942EE0F1D00@AM6PR83MB0312.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AM6PR83MB0312E97C139EA0A2EC942EE0F1D00@AM6PR83MB0312.EURPRD83.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Aug 11, 2019 at 09:32:22PM +0000, Saar Amar wrote:
> From: Saar Amar <saaramar@microsoft.com<mailto:saaramar@microsoft.com>>
> Date: Mon, 6 May 2019 02:22:16
> Subject: [PATCH] Fix dangling pointer in MCE amd.c
> 
> Signed-off-by: Saar Amar saar.amar@microsoft.com<mailto:saar.amar@microsoft.com>
> 
> The functions threshold_create_bank() and allocate_threshold_blocks() could create a dangling pointer in an error flow handling. Make sure to NULL those pointers out in that case.
> ---
> 
> 
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index 6ea7fdc82f3c..a742697ae44c 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -1259,8 +1259,12 @@ static int allocate_threshold_blocks(unsigned int cpu, unsigned int bank,
>                 return 0;
> 
>         err = allocate_threshold_blocks(cpu, bank, block, address);
> -       if (err)
> +       if (err) {
> +               if (! per_cpu(threshold_banks, cpu)[bank]->blocks) {

I'd venture a guess you don't mean "!" here.

> +                       per_cpu(threshold_banks, cpu)[bank]->blocks = NULL;
> +               }
>                 goto out_free;
> +       }
> 
>         if (b)
>                 kobject_uevent(&b->kobj, KOBJ_ADD);
> @@ -1356,8 +1360,12 @@ static int threshold_create_bank(unsigned int cpu, unsigned int bank)
>         }
> 
>         err = allocate_threshold_blocks(cpu, bank, 0, msr_ops.misc(bank));
> -       if (!err)
> -               goto out;
> +       if (err) {
> +               per_cpu(threshold_banks, cpu)[bank] = NULL;
> +               nb->bank4 = NULL;
> +               goto out_free;
> +       }
> +       goto out;

Anyway, those pointer cleanups should happen at the respective labels
the error handling flow jumps to.

Then, if you want me to apply a patch of yours, you'd have to send
it to me in an applicable format which means, do not create it on
windows.

For how to create it properly, look at:

https://www.kernel.org/doc/html/latest/process/email-clients.html

and

https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Also, do

$ git log -p arch/x86/kernel/cpu/mce/amd.c

to get an idea how to format your patch and what to put there.

And before you send it, run it through the checkpatch.pl tool and fix
most issues it complains about (apply common sense, of course).

Then, send it to yourself only and try applying it. If it works, then
you're good to do.

Right now it looks like this:

$ ./scripts/checkpatch.pl /tmp/saar.amar.01
WARNING: email address 'Saar Amar saar.amar@microsoft.com<mailto:saar.amar@microsoft.com>' might be better as '"Saar Amar saar.amar@microsoft.com" <mailto:saar.amar@microsoft.com>'
#17: 
Signed-off-by: Saar Amar saar.amar@microsoft.com<mailto:saar.amar@microsoft.com>

WARNING: please, no spaces at the start of a line
#32: FILE: arch/x86/kernel/cpu/mce/amd.c:1262:
+       if (err) {$

WARNING: suspect code indent for conditional statements (7, 15)
#32: FILE: arch/x86/kernel/cpu/mce/amd.c:1262:
+       if (err) {
+               if (! per_cpu(threshold_banks, cpu)[bank]->blocks) {

ERROR: code indent should use tabs where possible
#33: FILE: arch/x86/kernel/cpu/mce/amd.c:1263:
+               if (! per_cpu(threshold_banks, cpu)[bank]->blocks) {$

WARNING: please, no spaces at the start of a line
#33: FILE: arch/x86/kernel/cpu/mce/amd.c:1263:
+               if (! per_cpu(threshold_banks, cpu)[bank]->blocks) {$

WARNING: suspect code indent for conditional statements (15, 23)
#33: FILE: arch/x86/kernel/cpu/mce/amd.c:1263:
+               if (! per_cpu(threshold_banks, cpu)[bank]->blocks) {
+                       per_cpu(threshold_banks, cpu)[bank]->blocks = NULL;

ERROR: space prohibited after that '!' (ctx:BxW)
#33: FILE: arch/x86/kernel/cpu/mce/amd.c:1263:
+               if (! per_cpu(threshold_banks, cpu)[bank]->blocks) {
                    ^

WARNING: braces {} are not necessary for single statement blocks
#33: FILE: arch/x86/kernel/cpu/mce/amd.c:1263:
+               if (! per_cpu(threshold_banks, cpu)[bank]->blocks) {
+                       per_cpu(threshold_banks, cpu)[bank]->blocks = NULL;
+               }

ERROR: code indent should use tabs where possible
#34: FILE: arch/x86/kernel/cpu/mce/amd.c:1264:
+                       per_cpu(threshold_banks, cpu)[bank]->blocks = NULL;$

WARNING: please, no spaces at the start of a line
#34: FILE: arch/x86/kernel/cpu/mce/amd.c:1264:
+                       per_cpu(threshold_banks, cpu)[bank]->blocks = NULL;$

ERROR: code indent should use tabs where possible
#35: FILE: arch/x86/kernel/cpu/mce/amd.c:1265:
+               }$

WARNING: please, no spaces at the start of a line
#35: FILE: arch/x86/kernel/cpu/mce/amd.c:1265:
+               }$

WARNING: please, no spaces at the start of a line
#37: FILE: arch/x86/kernel/cpu/mce/amd.c:1267:
+       }$

WARNING: please, no spaces at the start of a line
#47: FILE: arch/x86/kernel/cpu/mce/amd.c:1363:
+       if (err) {$

WARNING: suspect code indent for conditional statements (7, 15)
#47: FILE: arch/x86/kernel/cpu/mce/amd.c:1363:
+       if (err) {
+               per_cpu(threshold_banks, cpu)[bank] = NULL;

ERROR: code indent should use tabs where possible
#48: FILE: arch/x86/kernel/cpu/mce/amd.c:1364:
+               per_cpu(threshold_banks, cpu)[bank] = NULL;$

WARNING: please, no spaces at the start of a line
#48: FILE: arch/x86/kernel/cpu/mce/amd.c:1364:
+               per_cpu(threshold_banks, cpu)[bank] = NULL;$

ERROR: code indent should use tabs where possible
#49: FILE: arch/x86/kernel/cpu/mce/amd.c:1365:
+               nb->bank4 = NULL;$

WARNING: please, no spaces at the start of a line
#49: FILE: arch/x86/kernel/cpu/mce/amd.c:1365:
+               nb->bank4 = NULL;$

ERROR: code indent should use tabs where possible
#50: FILE: arch/x86/kernel/cpu/mce/amd.c:1366:
+               goto out_free;$

WARNING: please, no spaces at the start of a line
#50: FILE: arch/x86/kernel/cpu/mce/amd.c:1366:
+               goto out_free;$

WARNING: please, no spaces at the start of a line
#51: FILE: arch/x86/kernel/cpu/mce/amd.c:1367:
+       }$

WARNING: please, no spaces at the start of a line
#52: FILE: arch/x86/kernel/cpu/mce/amd.c:1368:
+       goto out;$

WARNING: Missing Signed-off-by: line by nominal patch author 'Saar Amar <saaramar@microsoft.com<mailto:saaramar@microsoft.com>>'

total: 7 errors, 17 warnings, 27 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

/tmp/saar.amar.01 has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.
---

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
