Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999654B2D4B
	for <lists+linux-edac@lfdr.de>; Fri, 11 Feb 2022 20:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242050AbiBKTKt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Feb 2022 14:10:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbiBKTKt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 11 Feb 2022 14:10:49 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E27CC8;
        Fri, 11 Feb 2022 11:10:47 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 101771EC05DE;
        Fri, 11 Feb 2022 20:10:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644606642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=vi/2f3BkZ5RPd66GrgDCvoYiNBLnsHrhasUTq7tPgPc=;
        b=r9pvFL3gB63rbfAyO0Ti9+4UYEs3FxUuH0ZmlQ2qS30TAUUSTa1bvdEUMu92hFJ1xdlwwv
        ANNq1xqKp1c/xvzO9M4rZkd16lWq7zrQ0jSs2luK2BP1tDmd/rafqU5ywlEAjC9sRc9L6u
        Ye83f/ASCSzlyHXWEl1hz5hEHjG6fVo=
Date:   Fri, 11 Feb 2022 20:10:43 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v4 01/24] EDAC/amd64: Define Data Fabric operations
Message-ID: <Yga0s+9cqtfB3Yxu@zn.tnic>
References: <20220127204115.384161-1-yazen.ghannam@amd.com>
 <20220127204115.384161-2-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220127204115.384161-2-yazen.ghannam@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jan 27, 2022 at 08:40:52PM +0000, Yazen Ghannam wrote:
> Define a stub to hold operations for different Data Fabric versions.
> This will be filled in following patches.
> 
> Set the operations at init-time as appropriate for each model/family
> group.
> 
> Also, start a glossary of acronyms used in the translation code.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> Link:
> https://lore.kernel.org/r/20211028175728.121452-6-yazen.ghannam@amd.com
> 
> v3->v4:
> * Started glossary.
> * Included pr_debug() for failing case.
> 
> v2->v3:
> * Was patch 6 in v2.
> * "df_ops" is set at init time.
> 
> v1->v2:
> * New in v2.
> 
>  drivers/edac/amd64_edac.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index fba609ada0e6..639dfbea3348 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -988,6 +988,12 @@ static int sys_addr_to_csrow(struct mem_ctl_info *mci, u64 sys_addr)
>  	return csrow;
>  }
>  
> +/*
> + * Glossary of acronyms used in address translation for Zen-based systems
> + *
> + * DF          =       Data Fabric

Yeah, "DF: Data Fabric" is probably easier to parse, without that weird
spacing and equals sign.

> + */
> +
>  /* Protect the PCI config register pairs used for DF indirect access. */
>  static DEFINE_MUTEX(df_indirect_mutex);
>  
> @@ -1058,6 +1064,14 @@ struct addr_ctx {
>  	u8 inst_id;
>  };
>  
> +struct data_fabric_ops {
> +};

I know that this is not the only example but we have struct definitions
interspersed with functions in the .c file while former should be all in
the header. It is a lot cleaner to have definitions and inline functions
in the header and the actual functionality in the C file but I leave it
up to you to decide what you prefer.

> +
> +struct data_fabric_ops df2_ops = {
> +};
> +
> +struct data_fabric_ops *df_ops;
> +
>  static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
>  {
>  	u64 dram_base_addr, dram_limit_addr, dram_hole_base;
> @@ -1072,6 +1086,11 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
>  
>  	struct addr_ctx ctx;
>  
> +	if (!df_ops) {
> +		pr_debug("Data Fabric Operations not set");

That probably wants to be a WARN_ON_ONCE() so that it is loud and
prominent when it happens...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
