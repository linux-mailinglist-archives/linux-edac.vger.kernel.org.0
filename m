Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24BB53B87B1
	for <lists+linux-edac@lfdr.de>; Wed, 30 Jun 2021 19:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbhF3RcE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 30 Jun 2021 13:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbhF3RcE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 30 Jun 2021 13:32:04 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797C7C061756;
        Wed, 30 Jun 2021 10:29:35 -0700 (PDT)
Received: from zn.tnic (p200300ec2f12c300d32a22941298d01c.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:c300:d32a:2294:1298:d01c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1749E1EC046E;
        Wed, 30 Jun 2021 19:29:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1625074174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YGhnZGfwTfvy3zpIFETm0Gunr6e5gwD/LYq1Fu48WQ4=;
        b=sUZpfB/Q+SeJQ3jfq1IfLkvy+1ILlBYyNJCbW3uX0iS1dVkVEhEHr+k/6R5JOCOlEHzFHf
        gBBJjn8bp5jZ9i780+ihjO68WOQ5+QV7QGJslWpipG/3C7rcjXedHsWm5Y5rViMiiyBWFr
        VXO4meDUbuWPmfvOm2Yl0pbt4/nt610=
Date:   Wed, 30 Jun 2021 19:29:33 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 08/31] EDAC/amd64: Define function to read DRAM
 address map registers
Message-ID: <YNyp/ZsGwnjFZr04@zn.tnic>
References: <20210623192002.3671647-1-yazen.ghannam@amd.com>
 <20210623192002.3671647-9-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210623192002.3671647-9-yazen.ghannam@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jun 23, 2021 at 07:19:39PM +0000, Yazen Ghannam wrote:
> @@ -1170,22 +1194,13 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
>  	if (remove_dram_offset(&ctx))
>  		goto out_err;
>  
> -	reg = df_regs[DRAM_BASE_ADDR];
> -	reg.offset += ctx.map_num * 8;
> -	if (amd_df_indirect_read(nid, reg, umc, &tmp))
> -		goto out_err;
> -
> -	/* Check if address range is valid. */
> -	if (!(tmp & BIT(0))) {
> -		pr_err("%s: Invalid DramBaseAddress range: 0x%x.\n",
> -			__func__, tmp);
> +	if (get_dram_addr_map(&ctx))
>  		goto out_err;
> -	}

Aha, I see where you're going with the context struct. Yap, ok.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
