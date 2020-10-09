Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E40C28902F
	for <lists+linux-edac@lfdr.de>; Fri,  9 Oct 2020 19:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387440AbgJIRmM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 9 Oct 2020 13:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387436AbgJIRmM (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 9 Oct 2020 13:42:12 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC846C0613D2;
        Fri,  9 Oct 2020 10:42:11 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0bdf00b94e32e687b21ae5.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:df00:b94e:32e6:87b2:1ae5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3A4491EC0354;
        Fri,  9 Oct 2020 19:42:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602265329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=X3gULQutXMeAJMTyhcmVBmL++RNoQlboYa/g1nHoyHg=;
        b=QwupyX0Gp8hel6ih01isLKNIJvR8mFmUKpGsb6VVznWu1Jq47VmzvXMWdGIH8YzThGcQiN
        6yRJ6PfLxoF/uv05cB1dMeQmpjFq+ov6tO5l2EvmVQYPuPAcpRTZvbaj3TuPD32rP1Rl0f
        +x3gW2HDkX2OZiUJ1u1eTW2G2ytbgBQ=
Date:   Fri, 9 Oct 2020 19:42:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH] EDAC/amd64: Set proper family type for Family 19h Models
 20h-2Fh
Message-ID: <20201009174200.GA21731@zn.tnic>
References: <20201009171803.3214354-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201009171803.3214354-1-Yazen.Ghannam@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Oct 09, 2020 at 05:18:03PM +0000, Yazen Ghannam wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> AMD Family 19h Models 20h-2Fh use the same PCI IDs as Family 17h Models
> 70h-7Fh. The same family ops and number of channels also apply.
> 
> Use the Family17h Model 70h family_type and ops for Family 19h Models
> 20h-2Fh. Update the controller name to match the system.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  drivers/edac/amd64_edac.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index fcc08bbf6945..1362274d840b 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -3385,6 +3385,12 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
>  		break;
>  
>  	case 0x19:
> +		if (pvt->model >= 0x20 && pvt->model <= 0x2f) {
> +			fam_type = &family_types[F17_M70H_CPUS];
> +			pvt->ops = &family_types[F17_M70H_CPUS].ops;
> +			fam_type->ctl_name = "F19h_M20h";
> +			break;
> +		}
>  		fam_type	= &family_types[F19_CPUS];
>  		pvt->ops	= &family_types[F19_CPUS].ops;
>  		family_types[F19_CPUS].ctl_name = "F19h";
> -- 

Applied, thanks.

It is too close to the merge window but this is enablement for new hw
which no one has yet so nothing should break.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
