Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8317D5888DF
	for <lists+linux-edac@lfdr.de>; Wed,  3 Aug 2022 10:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbiHCIxP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 3 Aug 2022 04:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbiHCIxP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 3 Aug 2022 04:53:15 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F38012608;
        Wed,  3 Aug 2022 01:53:14 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z12so10598371wrs.9;
        Wed, 03 Aug 2022 01:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TnGjUxB2/misRSyJhZn77B26GscZLCACUuOmD0mcAwE=;
        b=Kc5iT1udjYwbqJInVGPOOilc6kzr3wxm2/3C84LRXY8+IW5c7yASKizquGk/zmuLzh
         dfKHKVA8qmaTTIY6G2bC4jZ6PE7Ie41Vhn4djRs7Xzzk0wt1ufyG0Ynahmwxof4xpLq5
         QIDv8GTOwTV2WqTxB929Nds8VicYuSvIAr89KX94qvad+iMVswZBwEfOIvWu7yZFS1Wk
         msw5Nkq2mb+Gu19GOBDDv+Wv4y13R5vrGvxk9PsyZQQ1ryWZwpMY2Omgo01eTphssgRI
         KLeMih5kg6ORYsBsIObP2MhF5cIUMGhXuoszJOPfQjtd49GL2G6nZLw0RayI84azFOK5
         Sxww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=TnGjUxB2/misRSyJhZn77B26GscZLCACUuOmD0mcAwE=;
        b=RyUO91oBnNGcOgvi2sxTCwmyxMuO5+Ag+ahGSQ3PJhoAllN9UlCKkpn1LyiGQUa4K6
         5rVk2xtS+glXgYXaYF32Cn7fAo/S/W1rFtlVvgByLdX0mnwnb/dplYlk80I24eo6knNP
         SiE3gre8Ky7BUfwzaGWcFYOHHl7T/QfilRewXNHzejAWGBBHKKa7C2WL3lE+//W4JTRR
         fnAbAeYclOgnscKTZijKZ6dVB98mi1amcKqwWoW0oWJ5AUc8pSwdVxMLS/M8BWCfxXli
         3KKfvUuh2zsAoz9PPQ4R2MzLeuTYn4bglMnQmJV413gz2TgErxDTf+wRqUEb2BJvocOs
         c13w==
X-Gm-Message-State: ACgBeo0s6nAwVAyx+cFT7fTBSPFQEfYArO/LfQ/67rPwLWHhUEsWW2mr
        LOiqY9zi8Dsvz+0Q1vRxWig=
X-Google-Smtp-Source: AA6agR7RJYXzYA2wklxcfIuJnmPyxf/S5akbNEH1Y0Zoy/SL8dmIdjmKlWGbIlAzWPXRCLN2WxWwLQ==
X-Received: by 2002:adf:ce92:0:b0:220:5ef0:876d with SMTP id r18-20020adfce92000000b002205ef0876dmr10157915wrn.647.1659516792840;
        Wed, 03 Aug 2022 01:53:12 -0700 (PDT)
Received: from gmail.com (84-236-113-167.pool.digikabel.hu. [84.236.113.167])
        by smtp.gmail.com with ESMTPSA id e10-20020adffd0a000000b0021d4aca9d1esm20512339wrr.99.2022.08.03.01.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 01:53:12 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 3 Aug 2022 10:53:10 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     tony.luck@intel.com, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, hch@lst.de, nvdimm@lists.linux.dev
Subject: Re: [PATCH v7] x86/mce: retrieve poison range from hardware
Message-ID: <Yuo3dioqb9mDAOcT@gmail.com>
References: <20220802195053.3882368-1-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802195053.3882368-1-jane.chu@oracle.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


* Jane Chu <jane.chu@oracle.com> wrote:

> With Commit 7917f9cdb503 ("acpi/nfit: rely on mce->misc to determine

s/Commit/commit

> poison granularity") that changed nfit_handle_mce() callback to report
> badrange according to 1ULL << MCI_MISC_ADDR_LSB(mce->misc), it's been
> discovered that the mce->misc LSB field is 0x1000 bytes, hence injecting
> 2 back-to-back poisons and the driver ends up logging 8 badblocks,
> because 0x1000 bytes is 8 512-byte.
> 
> Dan Williams noticed that apei_mce_report_mem_error() hardcode
> the LSB field to PAGE_SHIFT instead of consulting the input
> struct cper_sec_mem_err record.  So change to rely on hardware whenever
> support is available.
> 
> Link: https://lore.kernel.org/r/7ed50fd8-521e-cade-77b1-738b8bfb8502@oracle.com
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> ---
>  arch/x86/kernel/cpu/mce/apei.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
> index 717192915f28..8ed341714686 100644
> --- a/arch/x86/kernel/cpu/mce/apei.c
> +++ b/arch/x86/kernel/cpu/mce/apei.c
> @@ -29,15 +29,26 @@
>  void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
>  {
>  	struct mce m;
> +	int lsb;
>  
>  	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
>  		return;
>  
> +	/*
> +	 * Even if the ->validation_bits are set for address mask,
> +	 * to be extra safe, check and reject an error radius '0',
> +	 * and fall back to the default page size.
> +	 */
> +	if (mem_err->validation_bits & CPER_MEM_VALID_PA_MASK)
> +		lsb = find_first_bit((void *)&mem_err->physical_addr_mask, PAGE_SHIFT);
> +	else
> +		lsb = PAGE_SHIFT;
> +
>  	mce_setup(&m);
>  	m.bank = -1;
>  	/* Fake a memory read error with unknown channel */
>  	m.status = MCI_STATUS_VAL | MCI_STATUS_EN | MCI_STATUS_ADDRV | MCI_STATUS_MISCV | 0x9f;
> -	m.misc = (MCI_MISC_ADDR_PHYS << 6) | PAGE_SHIFT;
> +	m.misc = (MCI_MISC_ADDR_PHYS << 6) | lsb;

LGTM.

I suppose this wants to go upstream via the tree the bug came from (NVDIMM 
tree? ACPI tree?), or should we pick it up into the x86 tree?

Thanks,

	Ingo
