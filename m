Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18B0203A6A
	for <lists+linux-edac@lfdr.de>; Mon, 22 Jun 2020 17:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbgFVPNK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Jun 2020 11:13:10 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56922 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728070AbgFVPNJ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 22 Jun 2020 11:13:09 -0400
Received: from zn.tnic (p200300ec2f0a2500329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:2500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9932F1EC02A1;
        Mon, 22 Jun 2020 17:13:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592838788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Dljhad+Rk36ZRrbHLEsgzwhIujRtqbCVqVbqGWMhdag=;
        b=luyu4ELk5AK/JuZx52kQWIxNm6VafbxCYKJRKhZJ/vnwW7UIzkr+fcVuL037D9iKvowjCt
        avUIGHCzTL+Fn4FLnMzqnKUJdllN8BbwgyGGE+qio/+OJWpKSRny7q15+Ibg1Xte46OSCt
        8KvWeXhNmHtpzFQrv3QWYxusVi8e7y8=
Date:   Mon, 22 Jun 2020 17:13:05 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Anders Andersson <pipatron@gmail.com>
Cc:     linux-edac@vger.kernel.org
Subject: Re: [PATCH] EDAC/amd64: Read back the scrub rate PCI register on F15h
Message-ID: <20200622151305.GD32200@zn.tnic>
References: <CAKkunMbNWppx_i6xSdDHLseA2QQmGJqj_crY=NF-GZML5np4Vw@mail.gmail.com>
 <20200618175646.GD27951@zn.tnic>
 <20200618184041.GE27951@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200618184041.GE27951@zn.tnic>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jun 18, 2020 at 08:40:41PM +0200, Borislav Petkov wrote:
> On Thu, Jun 18, 2020 at 07:56:46PM +0200, Borislav Petkov wrote:
> > Oh, you're manipulating it alright but there's a bug in reporting it.
> > Wanna test a patch?
> 
> Here it is:
> 
> ---
> From: Borislav Petkov <bp@suse.de>
> 
> Commit:
> 
>   da92110dfdfa ("EDAC, amd64_edac: Extend scrub rate support to F15hM60h")
> 
> added support for F15h, model 0x60 CPUs but in doing so, missed to read
> back SCRCTRL PCI config register on F15h CPUs which are *not* model
> 0x60. Add that read so that doing
> 
>   $ cat /sys/devices/system/edac/mc/mc0/sdram_scrub_rate
> 
> can show the previously set DRAM scrub rate.
> 
> Fixes: da92110dfdfa ("EDAC, amd64_edac: Extend scrub rate support to F15hM60h")
> Reported-by: Anders Andersson <pipatron@gmail.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: <stable@vger.kernel.org> #v4.4..
> Link: https://lkml.kernel.org/r/CAKkunMbNWppx_i6xSdDHLseA2QQmGJqj_crY=NF-GZML5np4Vw@mail.gmail.com
> ---
>  drivers/edac/amd64_edac.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index ef90070a9194..6262f6370c5d 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -269,6 +269,8 @@ static int get_scrub_rate(struct mem_ctl_info *mci)
>  
>  		if (pvt->model == 0x60)
>  			amd64_read_pci_cfg(pvt->F2, F15H_M60H_SCRCTRL, &scrubval);
> +		else
> +			amd64_read_pci_cfg(pvt->F3, SCRCTRL, &scrubval);
>  	} else {
>  		amd64_read_pci_cfg(pvt->F3, SCRCTRL, &scrubval);
>  	}
> -- 

Queued into edac-urgent.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
