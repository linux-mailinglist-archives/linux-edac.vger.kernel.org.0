Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120DC6E69B7
	for <lists+linux-edac@lfdr.de>; Tue, 18 Apr 2023 18:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjDRQkV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 18 Apr 2023 12:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjDRQkU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 18 Apr 2023 12:40:20 -0400
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84679173B;
        Tue, 18 Apr 2023 09:40:19 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id k1-20020a4ab281000000b0053e8b5524abso1842471ooo.2;
        Tue, 18 Apr 2023 09:40:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681836019; x=1684428019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R58J35d4BdoHDvhoCeCYMn2FqLG6zlTzEEfzJjr3YvM=;
        b=PKDqR2O+nruNe9Ny/TL9Mvwt7H4B3wVzmgEgfGIf1568SNuiO23Rc+jxOvSHA0B7Vu
         9zW/JjQ0Sy1lClR8/8HuM6aDiybzUdB5m7JuHLJnoLhj8gvhURStvV/ItYi+i8i+oR+J
         gID6d7Xe3U2c07kirh/7kWBo76Y1Zp7S3ICjkno+73S2U7PULpZvRjyomKIws6RKR76D
         Xt6tcTH5XXyGVaHmibVnPqXFhioi+fY9PRTPpTHkBPmcArteFgj5VEScwxqhw22X0mc1
         qMXlb+1Xm20XGb3er/Uubt1yC4ovKp5Dzco0UZ32+92GGZyCW/WTa9aKlZ2FACOb1K/A
         ZYsQ==
X-Gm-Message-State: AAQBX9eufOpWgYB74CQi5yJv5Hm8jUKRqMjvOtldOgyXQeMaOC7hlNh+
        sEHhstCVO5RxrJNblDcvJgE0m4Tmfw==
X-Google-Smtp-Source: AKy350bhDqmE1OUzGaPeiIK0m0d97bc0igUxEu78dB6rIzoiiaf0Taoh1uYmJOwWMg4w5hMW13Ny7g==
X-Received: by 2002:a4a:5555:0:b0:546:ecb3:f42 with SMTP id e82-20020a4a5555000000b00546ecb30f42mr2755325oob.8.1681836018541;
        Tue, 18 Apr 2023 09:40:18 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j18-20020a4a9452000000b0053dfd96fa61sm6010442ooi.39.2023.04.18.09.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 09:40:17 -0700 (PDT)
Received: (nullmailer pid 1824043 invoked by uid 1000);
        Tue, 18 Apr 2023 16:40:16 -0000
Date:   Tue, 18 Apr 2023 11:40:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dinh Nguyen <dinguyen@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Tero Kristo <kristo@kernel.org>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] EDAC: Use of_address_to_resource()
Message-ID: <20230418164016.GA1823469-robh@kernel.org>
References: <20230327201411.529948-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327201411.529948-1-robh@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Mar 27, 2023 at 03:14:11PM -0500, Rob Herring wrote:
> Replace of_get_address() and of_translate_address() calls with single
> call to of_address_to_resource().
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
>  - Fix compile error
> ---
>  drivers/edac/altera_edac.c |  5 +++--
>  drivers/edac/ti_edac.c     | 10 +++++-----
>  2 files changed, 8 insertions(+), 7 deletions(-)

Ping!

> 
> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> index e7e8e624a436..be33329c6f18 100644
> --- a/drivers/edac/altera_edac.c
> +++ b/drivers/edac/altera_edac.c
> @@ -1096,6 +1096,7 @@ static int altr_s10_sdram_check_ecc_deps(struct altr_edac_device_dev *device)
>  	struct arm_smccc_res result;
>  	struct device_node *np;
>  	phys_addr_t sdram_addr;
> +	struct resource res;
>  	u32 read_reg;
>  	int ret;
>  
> @@ -1103,8 +1104,8 @@ static int altr_s10_sdram_check_ecc_deps(struct altr_edac_device_dev *device)
>  	if (!np)
>  		goto sdram_err;
>  
> -	sdram_addr = of_translate_address(np, of_get_address(np, 0,
> -							     NULL, NULL));
> +	of_address_to_resource(np, 0, &res);
> +	sdram_addr = res.start;
>  	of_node_put(np);
>  	sdram_ecc_addr = (unsigned long)sdram_addr + prv->ecc_en_ofst;
>  	arm_smccc_smc(INTEL_SIP_SMC_REG_READ, sdram_ecc_addr,
> diff --git a/drivers/edac/ti_edac.c b/drivers/edac/ti_edac.c
> index 6971ded598de..7befcf6c6637 100644
> --- a/drivers/edac/ti_edac.c
> +++ b/drivers/edac/ti_edac.c
> @@ -202,19 +202,19 @@ MODULE_DEVICE_TABLE(of, ti_edac_of_match);
>  static int _emif_get_id(struct device_node *node)
>  {
>  	struct device_node *np;
> -	const __be32 *addrp;
> +	struct resource res;
>  	u32 addr, my_addr;
>  	int my_id = 0;
>  
> -	addrp = of_get_address(node, 0, NULL, NULL);
> -	my_addr = (u32)of_translate_address(node, addrp);
> +	of_address_to_resource(node, 0, &res);
> +	my_addr = (u32)res.start;
>  
>  	for_each_matching_node(np, ti_edac_of_match) {
>  		if (np == node)
>  			continue;
>  
> -		addrp = of_get_address(np, 0, NULL, NULL);
> -		addr = (u32)of_translate_address(np, addrp);
> +		of_address_to_resource(np, 0, &res);
> +		addr = (u32)res.start;
>  
>  		edac_printk(KERN_INFO, EDAC_MOD_NAME,
>  			    "addr=%x, my_addr=%x\n",
> -- 
> 2.39.2
> 
