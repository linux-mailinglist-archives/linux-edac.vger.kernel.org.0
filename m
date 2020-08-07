Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557D623EF28
	for <lists+linux-edac@lfdr.de>; Fri,  7 Aug 2020 16:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgHGOmH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 Aug 2020 10:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgHGOmH (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 7 Aug 2020 10:42:07 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0079C061756
        for <linux-edac@vger.kernel.org>; Fri,  7 Aug 2020 07:42:06 -0700 (PDT)
Received: from nazgul.tnic (x2f7f173.dyn.telefonica.de [2.247.241.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8CA0D1EC02F2;
        Fri,  7 Aug 2020 16:42:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1596811321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6jiYQloQ6i2jBzfYasCvdVyfT6VVE30U4zaZb3m04kY=;
        b=Evxn8WqQf6u07F6Mt/OfUsVX79eYxb8HZYuCXD6Sa3EX2+oXjdNURMbtKA3SRz7xNhkunn
        ZAWt3QwPZ0dkB9IijFeG0U9VJr98uqVJy0fH3B/btOJuVq1wHw+nGeWSvUE2VLh63nomg0
        xvGsWwlaGx5GIKjJRAuGViQm8i59Pqg=
Date:   Fri, 7 Aug 2020 16:41:37 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kyle Meyer <kyle.meyer@hpe.com>
Cc:     russ.anderson@hpe.com, steve.wahl@hpe.com, tony.luck@intel.com,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH] x86/MCE: Set the MCE's status and misc members
Message-ID: <20200807144137.GB12931@nazgul.tnic>
References: <20200807142750.270548-1-kyle.meyer@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200807142750.270548-1-kyle.meyer@hpe.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Aug 07, 2020 at 09:27:50AM -0500, Kyle Meyer wrote:
> The MCE's status and misc members are initialized to zero
> within mce_setup. Set the MCE's status and misc members to the
> corresponding values passed in by the mem_err argument. This provides
> support for the RAS: Corrected Errors Collector (CEC) which uses the
> MCE.

This commit message is talking about the "how" but that is visible from
the patch. It needs to talk more about the why, as to why are you doing
this and what you're trying to achieve. I believe you alluded to some of
that offlist.

> Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
> ---
>  arch/x86/include/asm/mce.h     | 6 ++++--
>  arch/x86/kernel/cpu/mce/apei.c | 8 ++++++++
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> index cf503824529c..2346d900a232 100644
> --- a/arch/x86/include/asm/mce.h
> +++ b/arch/x86/include/asm/mce.h
> @@ -79,8 +79,10 @@
>  #define MCACOD_INSTR	0x0150	/* Instruction Fetch */
>  
>  /* MCi_MISC register defines */
> -#define MCI_MISC_ADDR_LSB(m)	((m) & 0x3f)
> -#define MCI_MISC_ADDR_MODE(m)	(((m) >> 6) & 7)
> +#define MCI_MISC_ADDR_LSB(m)		((m) & 0x3f)
> +#define MCI_MISC_ADDR_LSB_SET(x) 	((x) & 0x3f)
> +#define MCI_MISC_ADDR_MODE(m)		(((m) >> 6) & 7)
> +#define MCI_MISC_ADDR_MODE_SET(x) 	(((x) & 7) << 6)
>  #define  MCI_MISC_ADDR_SEGOFF	0	/* segment offset */
>  #define  MCI_MISC_ADDR_LINEAR	1	/* linear address */
>  #define  MCI_MISC_ADDR_PHYS	2	/* physical address */
> diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
> index af8d37962586..efdfb55b934a 100644
> --- a/arch/x86/kernel/cpu/mce/apei.c
> +++ b/arch/x86/kernel/cpu/mce/apei.c
> @@ -38,6 +38,14 @@ void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
>  	/* Fake a memory read error with unknown channel */
>  	m.status = MCI_STATUS_VAL | MCI_STATUS_EN | MCI_STATUS_ADDRV | 0x9f;
>  
> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL ||
> +	    boot_cpu_data.x86_vendor == X86_VENDOR_ZHAOXIN) {
> +		m.status |= MCI_STATUS_MISCV;
> +		m.misc |= MCI_MISC_ADDR_LSB_SET(ffs(
> +					mem_err->physical_addr_mask) - 1) |
> +			  MCI_MISC_ADDR_MODE_SET(MCI_MISC_ADDR_PHYS);
> +	}

This is ugly, especially that trailing opening brace - please use a
helper variable.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
