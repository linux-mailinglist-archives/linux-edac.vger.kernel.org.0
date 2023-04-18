Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE7E6E68E6
	for <lists+linux-edac@lfdr.de>; Tue, 18 Apr 2023 18:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjDRQF1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 18 Apr 2023 12:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjDRQF0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 18 Apr 2023 12:05:26 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD94126;
        Tue, 18 Apr 2023 09:05:22 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-187b70ab997so4557990fac.0;
        Tue, 18 Apr 2023 09:05:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681833922; x=1684425922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37QgubmPeBvy6q0pboJJwiVigrtJ8uPmYfNfy3Y5omw=;
        b=SKqf1l+qgP66hAziNHcTykgYa98F6JOH1dvpCnoSnD82B8ARoHbbFrHOY/M2KkjUyC
         TPuANYX8Yj+3Nr8p9PbWGhD770LUt8/lhZ3CkwWXdqjHdGlJ+M2y51//V1SKbluF+ERe
         dcmPaKaAV8mZenG/I6/3cs3ciutP7E+QDIDLggf8PNiVs7QwM7MTYso6D6h9bFhIqELk
         q/Mpeab/YNVH59To0sIlCCPwaNpH1TRD9QhKQefXEq4n0TSq6Evlh+lwBJvIFsgHYJn6
         ste5uO1MPgMpJEh4qG5qM9AaLcmGz5MvmZxP+tVSlQI5qfP2OyhO077SPDFtiWqt3zzr
         pMgQ==
X-Gm-Message-State: AAQBX9doebUb8CuRy8D/oVwdzIWmbpUhHEmU+jTlYUkrS5mFNL/R6UlN
        /8ry4k7Vzqm4qVqtOA8d7NLnbKqcCw==
X-Google-Smtp-Source: AKy350aCBFSt/fXOgOHTnl1ahI06Q7TvcGvIQmpZb+UIjqqo3eY+92UYs86KR0u8K3b8vqQYMP4rqA==
X-Received: by 2002:aca:1005:0:b0:37f:acda:9668 with SMTP id 5-20020aca1005000000b0037facda9668mr1328389oiq.12.1681833921599;
        Tue, 18 Apr 2023 09:05:21 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r7-20020acada07000000b003895430852dsm5982282oig.54.2023.04.18.09.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 09:05:20 -0700 (PDT)
Received: (nullmailer pid 1663587 invoked by uid 1000);
        Tue, 18 Apr 2023 16:05:18 -0000
Date:   Tue, 18 Apr 2023 11:05:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] edac: cpc925: Drop unused memory size DT parsing
Message-ID: <20230418160518.GA1631727-robh@kernel.org>
References: <20230319150141.67824-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230319150141.67824-1-robh@kernel.org>
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

On Sun, Mar 19, 2023 at 10:01:40AM -0500, Rob Herring wrote:
> The 'total_mem' memory size is parsed from DT, but never used anywhere.
> Just drop it as drivers shouldn't really do their own parsing of common
> bindings, and memblock would be a better way to get memory size now
> anyways.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/edac/cpc925_edac.c | 34 ----------------------------------
>  1 file changed, 34 deletions(-)

Ping.

> 
> diff --git a/drivers/edac/cpc925_edac.c b/drivers/edac/cpc925_edac.c
> index 9797e6d60dde..ee193aae8e14 100644
> --- a/drivers/edac/cpc925_edac.c
> +++ b/drivers/edac/cpc925_edac.c
> @@ -263,7 +263,6 @@ enum brgctrl_bits {
>  /* Private structure for edac memory controller */
>  struct cpc925_mc_pdata {
>  	void __iomem *vbase;
> -	unsigned long total_mem;
>  	const char *name;
>  	int edac_idx;
>  };
> @@ -280,37 +279,6 @@ struct cpc925_dev_info {
>  	void (*check)(struct edac_device_ctl_info *edac_dev);
>  };
>  
> -/* Get total memory size from Open Firmware DTB */
> -static void get_total_mem(struct cpc925_mc_pdata *pdata)
> -{
> -	struct device_node *np = NULL;
> -	const unsigned int *reg, *reg_end;
> -	int len, sw, aw;
> -	unsigned long start, size;
> -
> -	np = of_find_node_by_type(NULL, "memory");
> -	if (!np)
> -		return;
> -
> -	aw = of_n_addr_cells(np);
> -	sw = of_n_size_cells(np);
> -	reg = (const unsigned int *)of_get_property(np, "reg", &len);
> -	reg_end = reg + len/4;
> -
> -	pdata->total_mem = 0;
> -	do {
> -		start = of_read_number(reg, aw);
> -		reg += aw;
> -		size = of_read_number(reg, sw);
> -		reg += sw;
> -		edac_dbg(1, "start 0x%lx, size 0x%lx\n", start, size);
> -		pdata->total_mem += size;
> -	} while (reg < reg_end);
> -
> -	of_node_put(np);
> -	edac_dbg(0, "total_mem 0x%lx\n", pdata->total_mem);
> -}
> -
>  static void cpc925_init_csrows(struct mem_ctl_info *mci)
>  {
>  	struct cpc925_mc_pdata *pdata = mci->pvt_info;
> @@ -321,8 +289,6 @@ static void cpc925_init_csrows(struct mem_ctl_info *mci)
>  	u32 mbmr, mbbar, bba, grain;
>  	unsigned long row_size, nr_pages, last_nr_pages = 0;
>  
> -	get_total_mem(pdata);
> -
>  	for (index = 0; index < mci->nr_csrows; index++) {
>  		mbmr = __raw_readl(pdata->vbase + REG_MBMR_OFFSET +
>  				   0x20 * index);
> -- 
> 2.39.2
> 
