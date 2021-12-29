Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAAD4815E8
	for <lists+linux-edac@lfdr.de>; Wed, 29 Dec 2021 18:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhL2RmR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 29 Dec 2021 12:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbhL2RmQ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 29 Dec 2021 12:42:16 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913C6C061574;
        Wed, 29 Dec 2021 09:42:16 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 19EFD1EC03AD;
        Wed, 29 Dec 2021 18:42:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640799731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wdG1orpujtasxO//buWEJh/ooLbBOXspasZ4g7ST8e4=;
        b=ls27hWEHrpqqrthKPBApoifZfX5HWZ6ccqjGP+JDnlShCkPzhGAkojRhaMVr+IjMLRrOse
        f/U7Oa9GBUlTDrsoWw7wIttUhqN+tQjy9+JG2OEIgtlQgVZWR0Zd8bpNSfJNcfr0Ti7ekt
        7AHx2vCscDHUMXnBoJ0svCbza7Vlalg=
Date:   Wed, 29 Dec 2021 18:42:18 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH] x86/MCE/AMD: Allow thresholding interface updates after
 init
Message-ID: <Ycyd+nYgXvJpL19y@zn.tnic>
References: <20211207193028.9389-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211207193028.9389-1-yazen.ghannam@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Dec 07, 2021 at 07:30:28PM +0000, Yazen Ghannam wrote:
> Changes to the AMD Thresholding sysfs code prevents sysfs writes from
> updating the underlying registers once CPU init is completed, i.e.
> "threshold_banks" is set.
> 
> Allow the registers to be updated if the thresholding interface is
> already initialized or if in the init path. Use the "set_lvt_off" value
> to indicate if running in the init path, since this value is only set
> during init.
> 
> Fixes: a037f3ca0ea0 ("x86/mce/amd: Make threshold bank setting hotplug robust")
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>

We want that in stable, right?

> ---
>  arch/x86/kernel/cpu/mce/amd.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index 2eadc7c4c902..408c9546ea0b 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -400,8 +400,12 @@ static void threshold_restart_bank(void *_tr)
>  	struct thresh_restart *tr = _tr;
>  	u32 hi, lo;
>  
> -	/* sysfs write might race against an offline operation */
> -	if (this_cpu_read(threshold_banks))
> +	/*
> +	 * sysfs write might race against an offline operation.
> +	 * Prevent register writes if threshold_banks are not set and this is
> +	 * not called from the init path as indicated by "set_lvt_off".
> +	 */

So if you convert this text into code, it would read like:

	if (!this_cpu_read(threshold_banks) && !tr->set_lvt_off)

which is equivalent to:

> +	if (!(this_cpu_read(threshold_banks) || tr->set_lvt_off))

but easier to follow, methinks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
