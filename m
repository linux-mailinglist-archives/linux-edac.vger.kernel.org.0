Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671271F502A
	for <lists+linux-edac@lfdr.de>; Wed, 10 Jun 2020 10:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgFJIUn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 10 Jun 2020 04:20:43 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46616 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgFJIUn (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 10 Jun 2020 04:20:43 -0400
Received: from zn.tnic (p200300ec2f0c1900a913926cfabdeffc.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:1900:a913:926c:fabd:effc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 27C851EC030F;
        Wed, 10 Jun 2020 10:20:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1591777242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0lhSM9cD2l1F1bxrTqd8jmkKzrg5lMSb8JJgwWgGHvU=;
        b=mpdYnPECofYieFbqJjrVtIevL//hK3Pissx2uy90gxQhlC6lNf2QJ+jjrhP6T76hqg7M/+
        JvHHPn8U/OwgYXF0OjrFZyPMt0+sg2yi8UmgtJYON75xjG6f6v+EKUKSBAGyAi/uWpI9Mk
        89oBFPuzLBzuoFyCzww83Uu+S1Bp0ks=
Date:   Wed, 10 Jun 2020 10:20:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        tony.luck@intel.com, mchehab@kernel.org, james.morse@arm.com,
        rrichter@marvell.com
Subject: Re: [PATCH] EDAC, {skx,i10nm}: Advice mcelog that the error were
 handled
Message-ID: <20200610082040.GB14118@zn.tnic>
References: <20200610065801.3579-1-zhenzhong.duan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200610065801.3579-1-zhenzhong.duan@gmail.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jun 10, 2020 at 02:58:01PM +0800, Zhenzhong Duan wrote:
> If one MCE error has been processed in kernel, it's not necessory
> to pass it to user level mcelog.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
> ---
>  drivers/edac/skx_common.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
> index 46be1a7..8c0165b 100644
> --- a/drivers/edac/skx_common.c
> +++ b/drivers/edac/skx_common.c
> @@ -615,7 +615,8 @@ int skx_mce_check_error(struct notifier_block *nb, unsigned long val,
>  
>  	skx_mce_output_error(mci, mce, &res);
>  
> -	return NOTIFY_DONE;
> +	/* Advice mcelog that the error were handled */
> +	return NOTIFY_STOP;
>  }
>  
>  void skx_remove(void)
> -- 

No, we won't be doing that anymore. See here:

https://git.kernel.org/tip/23ba710a0864108910c7531dc4c73ef65eca5568

it should appear mainline soon-ish, I hope.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
