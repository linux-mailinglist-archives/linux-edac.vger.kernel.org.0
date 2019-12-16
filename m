Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 254F51211BB
	for <lists+linux-edac@lfdr.de>; Mon, 16 Dec 2019 18:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbfLPR0V (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 16 Dec 2019 12:26:21 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46354 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbfLPR0U (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 16 Dec 2019 12:26:20 -0500
Received: from zn.tnic (p200300EC2F07BC00D0F2C92C76B3ABC9.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:bc00:d0f2:c92c:76b3:abc9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9F1601EC090E;
        Mon, 16 Dec 2019 18:26:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1576517175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RkjX+mBB7ECk8NOBgiaY4vw70+qzE/SL8zNjPgDJwww=;
        b=RKgPYr69MpObXRD/5D/BZs0SnwiZTOOW3CUIcT50YMMyvDuZHeoEQwUfpkPeXdk4xVYBlF
        rRRJD8nMdQoXam0PMyPH1JZSxi2OsQy06/Y/Fo7abGP2au1wlporPcCjoAR/BBPMpfeQnJ
        vH6txAtYfz4eXg8lhTvq5G1Gmh8or/s=
Date:   Mon, 16 Dec 2019 18:26:09 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jan =?utf-8?Q?H=2E_Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH 3/6] x86/mce: Fix possibly incorrect severity calculation
 on AMD
Message-ID: <20191216172609.GE17380@zn.tnic>
References: <20191210000733.17979-1-jschoenh@amazon.de>
 <20191210000733.17979-4-jschoenh@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191210000733.17979-4-jschoenh@amazon.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Dec 10, 2019 at 01:07:30AM +0100, Jan H. Schönherr wrote:
> The function mce_severity_amd_smca() requires m->bank to be initialized
> for correct operation. Fix the one case, where mce_severity() is called
> without doing so.
> 
> Fixes: 6bda529ec42e ("x86/mce: Grade uncorrected errors for SMCA-enabled systems")
> Fixes: d28af26faa0b ("x86/MCE: Initialize mce.bank in the case of a fatal error in mce_no_way_out()")
> Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
> ---
>  arch/x86/kernel/cpu/mce/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 81ab25d5357a..6afb9de251f2 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -809,8 +809,8 @@ static int mce_no_way_out(struct mce *m, char **msg, unsigned long *validp,
>  		if (quirk_no_way_out)
>  			quirk_no_way_out(i, m, regs);
>  
> +		m->bank = i;
>  		if (mce_severity(m, mca_cfg.tolerant, &tmp, true) >= MCE_PANIC_SEVERITY) {
> -			m->bank = i;
>  			mce_read_aux(m, i);
>  			*msg = tmp;
>  			return 1;
> -- 

Good catch. This should go to Linus now.

Yazen, any objections?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
