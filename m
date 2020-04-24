Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05151B6F12
	for <lists+linux-edac@lfdr.de>; Fri, 24 Apr 2020 09:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgDXHbu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 24 Apr 2020 03:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgDXHbu (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 24 Apr 2020 03:31:50 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C174C09B045;
        Fri, 24 Apr 2020 00:31:50 -0700 (PDT)
Received: from zn.tnic (p200300EC2F1D0400D51D34288A316128.dip0.t-ipconnect.de [IPv6:2003:ec:2f1d:400:d51d:3428:8a31:6128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 732A11EC0D9A;
        Fri, 24 Apr 2020 09:31:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1587713506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iNHVMX10NunjxM4MEIFMT2DqO85ZoVB/DzoDmdwiXB0=;
        b=jzsRFnuQTkKTQJD0T4riYMtx0zAIjsL9RnndhfzA11cQIP0xqo2dpaHPdIt4E2pjji6kUj
        whQv0uR3Gzy3nKfahiruD9y35/A6XdICAi87jhOZGU/Xl7jYPcOpNSpL507gntbw72RQC3
        /OE9rLdBmyMfOfEUH0hPo2VcFzKxMO8=
Date:   Fri, 24 Apr 2020 09:31:42 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rrichter@marvell.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] EDAC: remove defined but not used 'bridge_str'
Message-ID: <20200424073142.GA17202@zn.tnic>
References: <20200415085006.6732-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200415085006.6732-1-yanaijie@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Apr 15, 2020 at 04:50:06PM +0800, Jason Yan wrote:
> Fix the following gcc warning:
> 
> drivers/edac/amd8131_edac.c:47:21: warning: ‘bridge_str’ defined but not
> used [-Wunused-const-variable=]
>  static char * const bridge_str[] = {
>                      ^~~~~~~~~~
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  drivers/edac/amd8131_edac.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/edac/amd8131_edac.c b/drivers/edac/amd8131_edac.c
> index 93c82bc17493..169353710982 100644
> --- a/drivers/edac/amd8131_edac.c
> +++ b/drivers/edac/amd8131_edac.c
> @@ -44,14 +44,6 @@ static void edac_pci_write_dword(struct pci_dev *dev, int reg, u32 val32)
>  			" PCI Access Write Error at 0x%x\n", reg);
>  }
>  
> -static char * const bridge_str[] = {
> -	[NORTH_A] = "NORTH A",
> -	[NORTH_B] = "NORTH B",
> -	[SOUTH_A] = "SOUTH A",
> -	[SOUTH_B] = "SOUTH B",
> -	[NO_BRIDGE] = "NO BRIDGE",
> -};
> -
>  /* Support up to two AMD8131 chipsets on a platform */
>  static struct amd8131_dev_info amd8131_devices[] = {
>  	{
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
