Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6250B3B86FC
	for <lists+linux-edac@lfdr.de>; Wed, 30 Jun 2021 18:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbhF3QZa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 30 Jun 2021 12:25:30 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51280 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229510AbhF3QZ3 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 30 Jun 2021 12:25:29 -0400
Received: from zn.tnic (p200300ec2f12c300d32a22941298d01c.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:c300:d32a:2294:1298:d01c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 529521EC046E;
        Wed, 30 Jun 2021 18:22:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1625070179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hMfarp5GvkxIXSwVvJ53UgpVWIdlYeCH8XpzAsO2vd8=;
        b=hbMTidl+FagpKF0SQ+r4y7Wex8U9+0b65t93mJpTwGzcCy5kaLHI4kEWltWl8xoWOs+4yt
        k7yfPbWuffoMZKVIL93chdZ8LdBVgm323nHDlPSoIkrnPPpfBMDL8mZRzzPbnQh1oAxrEV
        5xvtwFcaA8NBItdy0Di6MsgCKWvJLuY=
Date:   Wed, 30 Jun 2021 18:22:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 04/31] EDAC/amd64: Allow for DF Indirect Broadcast
 reads
Message-ID: <YNyaXr9yfi/paLt/@zn.tnic>
References: <20210623192002.3671647-1-yazen.ghannam@amd.com>
 <20210623192002.3671647-5-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210623192002.3671647-5-yazen.ghannam@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jun 23, 2021 at 07:19:35PM +0000, Yazen Ghannam wrote:
> The DF Indirect Access method allows for "Broadcast" accesses in which
> case no specific instance is targeted. Add support using a reserved
> instance ID of 0xFF to indicate a broadcast access. Set the FICAA
> register appropriately.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> Link:
> https://lkml.kernel.org/r/20210507190140.18854-1-Yazen.Ghannam@amd.com
> 
> v1->v2:
> * New in v2.
> 
>  drivers/edac/amd64_edac.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index b94067e3952b..d67cd8f57b94 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -1010,7 +1010,11 @@ struct df_reg {
>   *
>   * Fabric Indirect Configuration Access Data (FICAD): There are FICAD LO
>   * and FICAD HI registers but so far we only need the LO register.
> + *
> + * Use Instance Id 0xFF to indicate a broadcast read.
>   */
> +
> +#define DF_BROADCAST	0xFF
>  static int amd_df_indirect_read(u16 node, struct df_reg reg, u8 instance_id, u32 *lo)
>  {
>  	struct pci_dev *F4;
> @@ -1024,7 +1028,7 @@ static int amd_df_indirect_read(u16 node, struct df_reg reg, u8 instance_id, u32
>  	if (!F4)
>  		goto out;
>  
> -	ficaa  = 1;
> +	ficaa  = (instance_id == DF_BROADCAST) ? 0 : 1;

Or, you can define two functions:

df_indirect_read_broadcast()
df_indirect_read_umc()

(no need for the "amd_" prefix either - this is a static function now)

which both call a low-level helper:

static int __df_indirect_read(u16 node, struct df_reg reg, u8 instance_id, u32 *lo)

and there you either pass the instance_id or 0xff depending on which
outer function is calling it...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
