Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B346E6B66
	for <lists+linux-edac@lfdr.de>; Tue, 18 Apr 2023 19:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbjDRRuF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 18 Apr 2023 13:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjDRRuE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 18 Apr 2023 13:50:04 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3A09EDB;
        Tue, 18 Apr 2023 10:50:02 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BEDDB1EC0441;
        Tue, 18 Apr 2023 19:50:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1681840200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=j6JRsg/QQhsYzAJktxr6sLk4o83928DEGlAGxEQB5P0=;
        b=aCdj6oEopa2TZ/eZ1bIiakdEACXSFwPCOyedKNL6frPBiI6sICrS4DmY7+pR4upiMF3Tby
        M8Lf9tQUqUxJKQi0t3NS18y5xbvScGe6HFiSaWXCOTxGX+acTHTi485NV+HKI1xRuHOxhS
        gUrf30jLknoeAF2FgopglYbebOd/WQ0=
Date:   Tue, 18 Apr 2023 19:50:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] edac: cpc925: Use of_get_cpu_hwid() to read CPU node
 'reg'
Message-ID: <20230418175000.GLZD7YSNkIKk8ltGIw@fat_crate.local>
References: <20230319150141.67824-1-robh@kernel.org>
 <20230319150141.67824-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230319150141.67824-2-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Mar 19, 2023 at 10:01:41AM -0500, Rob Herring wrote:
> Replace open coded reading of CPU nodes' "reg" properties with
> of_get_cpu_hwid() dedicated for this purpose.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/edac/cpc925_edac.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/edac/cpc925_edac.c b/drivers/edac/cpc925_edac.c
> index ee193aae8e14..0182436c1b5a 100644
> --- a/drivers/edac/cpc925_edac.c
> +++ b/drivers/edac/cpc925_edac.c
> @@ -557,13 +557,13 @@ static u32 cpc925_cpu_mask_disabled(void)
>  	mask = APIMASK_ADI0 | APIMASK_ADI1;
>  
>  	for_each_of_cpu_node(cpunode) {
> -		const u32 *reg = of_get_property(cpunode, "reg", NULL);
> -		if (reg == NULL || *reg > 2) {
> +		int hwid = of_get_cpu_hwid(cpunode, 0);
> +		if ((hwid < 0) || (hwid > 2)) {
>  			cpc925_printk(KERN_ERR, "Bad reg value at %pOF\n", cpunode);
>  			continue;
>  		}
>  
> -		mask &= ~APIMASK_ADI(*reg);
> +		mask &= ~APIMASK_ADI(hwid);
>  	}
>  
>  	if (mask != (APIMASK_ADI0 | APIMASK_ADI1)) {
> -- 

$ grep CPC925 .config
CONFIG_EDAC_CPC925=m

$ make ARCH=powerpc CROSS_COMPILE=/home/boris/src/crosstool/gcc-11.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-
...
ERROR: modpost: ".of_get_cpu_hwid" [drivers/edac/cpc925_edac.ko] undefined!
make[1]: *** [scripts/Makefile.modpost:136: Module.symvers] Error 1
make: *** [Makefile:1980: modpost] Error 2

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
