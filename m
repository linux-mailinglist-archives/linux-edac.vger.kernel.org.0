Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42A6C9AE11
	for <lists+linux-edac@lfdr.de>; Fri, 23 Aug 2019 13:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387733AbfHWL0f (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 23 Aug 2019 07:26:35 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44184 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387678AbfHWL0f (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 23 Aug 2019 07:26:35 -0400
Received: from zn.tnic (p200300EC2F0BC50060C2B7403FC38AED.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:c500:60c2:b740:3fc3:8aed])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 53E971EC0980;
        Fri, 23 Aug 2019 13:26:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1566559594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=iI39I0Q4co5VyceWCTupGzA8Za44qrETqplwh6Uodfc=;
        b=Y89jQiZV8ZFfmb1hplMsY5qL31xa53G2H0nOXmhhsKNNrF2keTW1h5JbgCecYmVj+1HqXV
        l1KhYL2IimS8r1QaFUCaLwxy2YjU4bwtsSKxI+BBHFBjS2+mbJAKg50+q/vJTwoaDgYNQc
        PCsGmBRymDTkGceZ7yipSWfFbrgEHBk=
Date:   Fri, 23 Aug 2019 13:26:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 7/8] EDAC/amd64: Support Asymmetric Dual-Rank DIMMs
Message-ID: <20190823112628.GA28379@zn.tnic>
References: <20190821235938.118710-1-Yazen.Ghannam@amd.com>
 <20190821235938.118710-8-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190821235938.118710-8-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Aug 22, 2019 at 12:00:02AM +0000, Ghannam, Yazen wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Future AMD systems will support "Asymmetric" Dual-Rank DIMMs. These are
> DIMMs where the ranks are of different sizes.
> 
> The even rank will use the Primary Even Chip Select registers and the
> odd rank will use the Secondary Odd Chip Select registers.
> 
> Recognize if a Secondary Odd Chip Select is being used. Use the
> Secondary Odd Address Mask when calculating the chip select size.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> Link:
> https://lkml.kernel.org/r/20190709215643.171078-8-Yazen.Ghannam@amd.com
> 
> v2->v3:
> * Add check of csrow_nr before using secondary mask.
> 
> v1->v2:
> * No change.
> 
>  drivers/edac/amd64_edac.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 26ce48fcaf00..4d1e6daa7ec4 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -790,9 +790,13 @@ static void debug_dump_dramcfg_low(struct amd64_pvt *pvt, u32 dclr, int chan)
>  
>  #define CS_EVEN_PRIMARY		BIT(0)
>  #define CS_ODD_PRIMARY		BIT(1)
> +#define CS_EVEN_SECONDARY	BIT(2)
> +#define CS_ODD_SECONDARY	BIT(3)
>  
> -#define CS_EVEN			CS_EVEN_PRIMARY
> -#define CS_ODD			CS_ODD_PRIMARY
> +#define CS_EVEN			(CS_EVEN_PRIMARY | CS_EVEN_SECONDARY)
> +#define CS_ODD			(CS_ODD_PRIMARY | CS_EVEN_SECONDARY)

That's just my urge to have stuff ballanced but shouldn't that last line be:

#define CS_ODD			(CS_ODD_PRIMARY | CS_ODD_SECONDARY)

i.e., not have "even" as in CS_EVEN_SECONDARY in there but only "odd"s? :)

> +#define csrow_sec_enabled(i, dct, pvt)	((pvt)->csels[(dct)].csbases_sec[(i)] & DCSB_CS_ENABLE)

I moved that to the header, under csrow_enabled().

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
