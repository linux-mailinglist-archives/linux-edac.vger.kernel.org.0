Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58290565086
	for <lists+linux-edac@lfdr.de>; Mon,  4 Jul 2022 11:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbiGDJOJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 4 Jul 2022 05:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbiGDJOI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 4 Jul 2022 05:14:08 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA8862CD;
        Mon,  4 Jul 2022 02:14:06 -0700 (PDT)
Received: from zn.tnic (p200300ea970ff6e2329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:970f:f6e2:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 673CC1EC01A9;
        Mon,  4 Jul 2022 11:14:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1656926041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nhdSe953FnlIpSSAxgOW6MGqqbAry+g8TEoo9eus74k=;
        b=C5ebQnCytXt5CAM+q16I71EftU1pJk9wJ6s0v1KILI2NrAG6lzBpiF85Dx3Q0GqlbieWrF
        7UIZZ+R6/tg1SPIB8/MJ36RhRZkSXF1YRrZjTloJyYubDRG//aDeS3w5h5Qmw9TwhcGKzw
        fLWP8u53xPPvDCwSnx0oFtBZu/tK4js=
Date:   Mon, 4 Jul 2022 11:13:56 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH 3/3] EDAC/mce_amd: Add support for FRU Text in MCA
Message-ID: <YsKvVI/t2svrib1L@zn.tnic>
References: <20220418174440.334336-1-yazen.ghannam@amd.com>
 <20220418174440.334336-4-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220418174440.334336-4-yazen.ghannam@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Apr 18, 2022 at 05:44:40PM +0000, Yazen Ghannam wrote:
> @@ -1254,11 +1255,10 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
>  		((m->status & MCI_STATUS_PCC)	? "PCC"	  : "-"));
>  
>  	if (boot_cpu_has(X86_FEATURE_SMCA)) {
> -		u32 low, high;
>  		u32 addr = MSR_AMD64_SMCA_MCx_CONFIG(m->bank);
>  
> -		if (!rdmsr_safe(addr, &low, &high) &&
> -		    (low & MCI_CONFIG_MCAX))
> +		if (!rdmsrl_safe_on_cpu(m->extcpu, addr, &mca_config) &&

This change needs to be mentioned in the commit message.

> +		    (mca_config & MCI_CONFIG_MCAX))
>  			pr_cont("|%s", ((m->status & MCI_STATUS_TCC) ? "TCC" : "-"));
>  
>  		pr_cont("|%s", ((m->status & MCI_STATUS_SYNDV) ? "SyndV" : "-"));
> @@ -1300,6 +1300,17 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
>  		pr_cont("\n");

So here above the code prints SYND1 and SYND2.

If they contain FRU strings, then this printing should be an if-else by
checking bit 9.

	if (BIT(9))
		print fru text
	else
		print naked syndromes


>  		decode_smca_error(m);
> +
> +		if (mca_config & BIT(9)) {
> +			char frutext[32];

Why 32?

> +			memset(frutext, 0, sizeof(frutext));
> +			memcpy(&frutext[0], &m->synd1, 8);
> +			memcpy(&frutext[8], &m->synd2, 8);
> +
> +			pr_emerg(HW_ERR "FRU Text: %s\n", frutext);
> +		}
> +
>  		goto err_code;
>  	}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
