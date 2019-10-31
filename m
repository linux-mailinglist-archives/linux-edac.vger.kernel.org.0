Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5373EB2C0
	for <lists+linux-edac@lfdr.de>; Thu, 31 Oct 2019 15:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbfJaOaM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 31 Oct 2019 10:30:12 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37112 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728173AbfJaOaL (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 31 Oct 2019 10:30:11 -0400
Received: from nazgul.tnic (unknown [91.217.168.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 05F6D1EC0CDD;
        Thu, 31 Oct 2019 15:30:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1572532209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=sqyP3VfoTbEL895VJ1+f3tSVuCaoBE2+04xz1AAnFOg=;
        b=Xeo3HsCIcfJmvYZOJCPPipEJ1ibs+bfYoPo6eun1uVpM5jPUhxWCHrzLZzQJoh98HR7IQZ
        smtEPthP2lAwmLWh7hXd7NZ8MrzA7oiSsoa6uMTM5RvwsZj4nf38Y1Unws7lfAXx3EMgUJ
        IJuwCAFqZ3wG0ountN7Fah5+HiXgZ8w=
Date:   Thu, 31 Oct 2019 15:29:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc:     Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/MCE/AMD: fix warning about sleep-in-atomic at early
 boot
Message-ID: <20191031142955.GA23693@nazgul.tnic>
References: <157252708836.3876.4604398213417262402.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <157252708836.3876.4604398213417262402.stgit@buzz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Oct 31, 2019 at 04:04:48PM +0300, Konstantin Khlebnikov wrote:
> Function smca_configure() is called only for current cpu thus
> rdmsr_safe_on_cpu() could be replaced with atomic rdmsr_safe().
> 
>  BUG: sleeping function called from invalid context at kernel/sched/completion.c:99
>  in_atomic(): 1, irqs_disabled(): 1, pid: 0, name: swapper/1
>  CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.19.79-16 #1
					     ^^^^^^^^^^

I'm assuming you hit this on latest upstream too?

>  Hardware name: GIGABYTE R181-Z90-00/MZ91-FS0-00, BIOS R11 10/25/2019
>  Call Trace:
>   dump_stack+0x5c/0x7b
>   ___might_sleep+0xec/0x110
>   wait_for_completion+0x39/0x160
>   ? __rdmsr_safe_on_cpu+0x45/0x60
>   rdmsr_safe_on_cpu+0xae/0xf0
>   ? wrmsr_on_cpus+0x20/0x20
>   ? machine_check_poll+0xfd/0x1f0
>   ? mce_amd_feature_init+0x190/0x2d0
>   mce_amd_feature_init+0x190/0x2d0
>   mcheck_cpu_init+0x11a/0x460
>   identify_cpu+0x3e2/0x560
>   identify_secondary_cpu+0x13/0x80
>   smp_store_cpu_info+0x45/0x50
>   start_secondary+0xaa/0x200
>   secondary_startup_64+0xa4/0xb0
> 
> Except warning in kernel log everything works fine.
> 
> Fixes: 5896820e0aa3 ("x86/mce/AMD, EDAC/mce_amd: Define and use tables for known SMCA IP types")
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
>  arch/x86/kernel/cpu/mce/amd.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index 6ea7fdc82f3c..c7ab0d38af79 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -269,7 +269,7 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
>  	if (smca_banks[bank].hwid)
>  		return;
>  
> -	if (rdmsr_safe_on_cpu(cpu, MSR_AMD64_SMCA_MCx_IPID(bank), &low, &high)) {
> +	if (rdmsr_safe(MSR_AMD64_SMCA_MCx_IPID(bank), &low, &high)) {

Yazen, any objections?

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
