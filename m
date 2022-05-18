Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E62852B83C
	for <lists+linux-edac@lfdr.de>; Wed, 18 May 2022 13:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235266AbiERLC3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 18 May 2022 07:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbiERLC2 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 18 May 2022 07:02:28 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DED91668A5;
        Wed, 18 May 2022 04:02:24 -0700 (PDT)
Received: from zn.tnic (p200300ea974657d0329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:57d0:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6EC811EC0622;
        Wed, 18 May 2022 13:02:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1652871738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3KZplAhi7nPL7UxT3WtozJ9AVTOwoLDcqlHiNy8Et8I=;
        b=SLGBz714A+zFjmiQKQHnOoWGuLqxTYj4vzgEuNsPIxgJ3GEzpCl0Ib8BLUWgf5R1Zgtn24
        iOj7CFzKLvh4o2ZF/rVSIeQqIQBNCYqJGo0oeEIITIpO6GG+Dq7grQMi6omW4rRMwqpVHE
        XQMqfmHZ8osvN5vDJ//8WIN980urIqg=
Date:   Wed, 18 May 2022 13:02:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Smita.KoralahalliChannabasappa@amd.com, muralidhara.mk@amd.com,
        naveenkrishna.chatradhi@amd.com
Subject: Re: [PATCH 10/18] EDAC/amd64: Add read_mc_regs() into pvt->ops
Message-ID: <YoTSNajDepFS6Wxp@zn.tnic>
References: <20220509145534.44912-1-yazen.ghannam@amd.com>
 <20220509145534.44912-11-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220509145534.44912-11-yazen.ghannam@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, May 09, 2022 at 02:55:26PM +0000, Yazen Ghannam wrote:
> @@ -3766,6 +3751,7 @@ static struct low_ops umc_ops = {
>  	.read_base_mask			= umc_read_base_mask,
>  	.determine_memory_type		= umc_determine_memory_type,
>  	.determine_ecc_sym_sz		= umc_determine_ecc_sym_sz,
> +	.read_mc_regs			= umc_read_mc_regs,
>  };
>  
>  /* Use Family 16h versions for defaults and adjust as needed below. */
> @@ -3777,6 +3763,7 @@ static struct low_ops dct_ops = {
>  	.read_base_mask			= dct_read_base_mask,
>  	.determine_memory_type		= dct_determine_memory_type,
>  	.determine_ecc_sym_sz		= dct_determine_ecc_sym_sz,
> +	.read_mc_regs			= dct_read_mc_regs,

Aha, good, here you do that split I mentioned earlier.

>  static int per_family_init(struct amd64_pvt *pvt)
> @@ -3938,7 +3925,15 @@ static int hw_info_get(struct amd64_pvt *pvt)
>  	if (ret)
>  		return ret;
>  
> -	read_mc_regs(pvt);
> +	pvt->ops->read_mc_regs(pvt);
> +
> +	pvt->ops->prep_chip_selects(pvt);
> +
> +	pvt->ops->read_base_mask(pvt);
> +
> +	pvt->ops->determine_memory_type(pvt);
> +
> +	pvt->ops->determine_ecc_sym_sz(pvt);
>  

Yeah, no need for the spaces.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
