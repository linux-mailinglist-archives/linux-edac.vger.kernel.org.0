Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09973162A76
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2020 17:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgBRQ2q (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 18 Feb 2020 11:28:46 -0500
Received: from mail.skyhub.de ([5.9.137.197]:52240 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbgBRQ2q (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 18 Feb 2020 11:28:46 -0500
Received: from zn.tnic (p200300EC2F0C1F0014C3F76BBACA8B76.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:1f00:14c3:f76b:baca:8b76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0AFD71EC02D2;
        Tue, 18 Feb 2020 17:28:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582043325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XHwbSZ3DAFOYktOHxFjUverHeEraGIR2KVPHXRaJz+Y=;
        b=UtUufhEBu3BrIHzXmXf230+fla0+swQ9btDJ4GIKrjr+4sgkrs4I941/iN8OeQFVKhUQDY
        GeDfrvmaGYBWD61MhTS9AoVZq0nhwLQq3kRIitxV+pNPJgTkoICcBdmDI/JdKSZudQT3cM
        R+MXH5ouVjvadBtw91RfZOZChbRmoe8=
Date:   Tue, 18 Feb 2020 17:28:45 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH] EDAC/mce_amd: Output Scalable MCA processor warning once
Message-ID: <20200218162845.GI14449@zn.tnic>
References: <20200217134627.19765-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200217134627.19765-1-prarit@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Feb 17, 2020 at 08:46:27AM -0500, Prarit Bhargava wrote:
> This warning is output for every virtual cpu in a guest on an EPYC 2
> system.  The warning only needs to be logged one time.
> 
> Output the warning only once.
> 
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Robert Richter <rrichter@marvell.com>
> Cc: linux-edac@vger.kernel.org
> ---
>  drivers/edac/mce_amd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
> index ea980c556f2e..8874b7722b2f 100644
> --- a/drivers/edac/mce_amd.c
> +++ b/drivers/edac/mce_amd.c
> @@ -1239,7 +1239,7 @@ static int __init mce_amd_init(void)
>  
>  	case 0x17:
>  	case 0x18:
> -		pr_warn("Decoding supported only on Scalable MCA processors.\n");
> +		pr_warn_once("Decoding supported only on Scalable MCA processors.\n");
>  		return -EINVAL;
>  
>  	default:
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
