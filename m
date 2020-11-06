Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C91A2A9507
	for <lists+linux-edac@lfdr.de>; Fri,  6 Nov 2020 12:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgKFLMg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 6 Nov 2020 06:12:36 -0500
Received: from mail.skyhub.de ([5.9.137.197]:59268 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbgKFLMg (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 6 Nov 2020 06:12:36 -0500
Received: from zn.tnic (p200300ec2f0d1f00f768ac1eea3c6850.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:1f00:f768:ac1e:ea3c:6850])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 21C891EC0472;
        Fri,  6 Nov 2020 12:12:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1604661155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=OCxVZWJigVhJHe/ncO/1mdogKymzvXbkcJRjV3WLbbc=;
        b=LzOpYBRdo+QL74XTXml4Qq9WUKbpDmz0D/nWteBYZoFQdjcx3z815+dE3PYxwDi/MfyMos
        2glCfam0gbtK6wXW8sGaGsVHRnRDCnhYJbHKFYGX+0bMkVKg3pnQmB+WlkoyTJDgfdp+Lu
        zyO2B5NeX3/VFVwCXacQsL/fMtAcGwc=
Date:   Fri, 6 Nov 2020 12:12:20 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86 <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        linux-edac <linux-edac@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] x86/mce: remove unused WARN_ON() in
 mce_register_decode_chain()
Message-ID: <20201106111220.GA14914@zn.tnic>
References: <20201106084340.2009-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201106084340.2009-1-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Nov 06, 2020 at 04:43:40PM +0800, Zhen Lei wrote:
> enum mce_notifier_prios {
>         MCE_PRIO_LOWEST,
>         MCE_PRIO_MCELOG,
>         MCE_PRIO_EDAC,
> 
> After commit c9c6d216ed28 ("x86/mce: Rename "first" function as "early""),
> there is no other integer between MCE_PRIO_MCELOG and MCE_PRIO_EDAC.
> Therefore, the WARN_ON() will never be triggered, just delete it.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 4102b866e7c0..914f9f102995 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -162,9 +162,6 @@ EXPORT_SYMBOL_GPL(mce_log);
>  
>  void mce_register_decode_chain(struct notifier_block *nb)
>  {
> -	if (WARN_ON(nb->priority > MCE_PRIO_MCELOG && nb->priority < MCE_PRIO_EDAC))
> -		return;

No, you don't want to remove it - you want to update it so that it
catches wrong priorities...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
