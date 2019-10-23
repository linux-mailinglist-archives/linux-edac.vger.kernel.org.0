Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A768E139A
	for <lists+linux-edac@lfdr.de>; Wed, 23 Oct 2019 10:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390075AbfJWIHU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Oct 2019 04:07:20 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58698 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727574AbfJWIHU (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 23 Oct 2019 04:07:20 -0400
Received: from zn.tnic (p200300EC2F11E8005961F1FA34C94581.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:e800:5961:f1fa:34c9:4581])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8762E1EC0CA4;
        Wed, 23 Oct 2019 10:07:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1571818034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6re90X+K2Ba3Le4UC0nY3M3OCT0CmUV6pKn4yBGcnFE=;
        b=NchdNT9SJ/OUDAsztb3nXKP6IK9CYG3dJ6LG7Jd0S3aYJx/OZScUjw8sCyjfwcXzFRebHW
        tDoHQLNq2eZw/Wn44CiyRG2zBHiIoXd862DF+Z+0st9qyilVL4Pn64q9UM4icW9L20aTXs
        wOz0w/9+4TuLU7oXj8jbO75NtfpHeF8=
Date:   Wed, 23 Oct 2019 10:07:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     tony.luck@intel.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        up2wing@gmail.com, wang.liang82@zte.com.cn
Subject: Re: [PATCH] x86/mce/amd: fix -Wmissing-prototypes warnings
Message-ID: <20191023080709.GC16060@zn.tnic>
References: <1571817437-7570-1-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1571817437-7570-1-git-send-email-wang.yi59@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Oct 23, 2019 at 03:57:17PM +0800, Yi Wang wrote:
> We get two warnings when build kernel W=1:
> arch/x86/kernel/cpu/mce/amd.c:586:6: warning: no previous prototype for ‘disable_err_thresholding’ [-Wmissing-prototypes]
> 
> Make the function static to fix this.
> 
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> ---
>  arch/x86/kernel/cpu/mce/amd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index 6ea7fdc..5167bd2 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -583,7 +583,7 @@ bool amd_filter_mce(struct mce *m)
>   * - Prevent possible spurious interrupts from the IF bank on Family 0x17
>   *   Models 0x10-0x2F due to Erratum #1114.
>   */
> -void disable_err_thresholding(struct cpuinfo_x86 *c, unsigned int bank)
> +static void disable_err_thresholding(struct cpuinfo_x86 *c, unsigned int bank)
>  {
>  	int i, num_msrs;
>  	u64 hwcr;
> --

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=ras/core&id=47cd84e98f512eac5aad988f08baff432aea35ba

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
