Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25652453E2
	for <lists+linux-edac@lfdr.de>; Sun, 16 Aug 2020 00:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbgHOWGl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 15 Aug 2020 18:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbgHOVus (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 15 Aug 2020 17:50:48 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF194C03B3D7;
        Sat, 15 Aug 2020 02:13:41 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id o23so12397796ejr.1;
        Sat, 15 Aug 2020 02:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mqUm0D+LR1fyNqgEpWLZcUrJ5fpnGERJD73F5yobxbo=;
        b=NXSY0vjVE5tPHf7IuLRoeAubB/ylXeS1/3XQ5D3uq+prksg4wr/wFryYS9yTbnP4di
         md8LZYgPigun2do3qz7miFA87HgFqeha4DH/nrgJKN4AMqw5+ZFiSPMktIap/pH51ROs
         Lf+qBonK2VWqkiID86N7ws1hIx9M/X8nFu8khVOTcQmH1XGaO2heo3a3pdXQvRfPUrPI
         LRFzwQH/I7fHgLt4hXEbBHiyUGrfwXPAQkMWzl2/uu8PJQbqhb0fqXgpBibI2wLIgLxq
         l0VRUKBV7N9Bp/Qv8e462/XXOHTUn6sjVI0jagAwFgNceU//9a1xtL5ZZpwezfq1HQsP
         eBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=mqUm0D+LR1fyNqgEpWLZcUrJ5fpnGERJD73F5yobxbo=;
        b=pyDfon05IZFlBRLYZop3TmKHWwzWlLbjEvCRFhUhwO6BhJhB+J7urkNUH8RT+H6kKB
         V580o0wELpNPOVA1fKyDbtBOvY1tJntGewT7kPucEI3yIGjZvsaYaqHZerhqEeKPUV6R
         SP6I5XPBK5cKT4eF1DiM9Ubm4qJf2s4GysHBzi03mHRUBE7DP7RJJKIC0J0WcddPlPN9
         JYaxZZSmh4XXz5fowAFvsIiQ5yzUl8lSK6QUXlPXPu9aZxGRnVbFHpoib4a2HETnjWEn
         RekonfjavKYoDMb5sLxERnTbZEFRUcWV80bTxiUY/GJh7DSOs4ufcyswA2WajZTnzwqL
         5I8Q==
X-Gm-Message-State: AOAM530R51w3PBb6Wds7Tha0qQ4LG/ynrLmabQ4zwWOfNrICIKWPxRlG
        Gg8wrbNfEcxs+JIe3o6x4No=
X-Google-Smtp-Source: ABdhPJz5cQsILyJBeRROxoz/Tt1xsLjVUdBpw4vvM3748mGAI6Hau96Ht566QXH5PtIUwSDZuXEvuQ==
X-Received: by 2002:a17:906:af0c:: with SMTP id lx12mr6308746ejb.228.1597482820529;
        Sat, 15 Aug 2020 02:13:40 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id dr21sm9275800ejc.112.2020.08.15.02.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 02:13:39 -0700 (PDT)
Date:   Sat, 15 Aug 2020 11:13:36 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        bp@suse.de, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH 2/2] x86/MCE/AMD Support new memory interleaving schemes
 during address translation
Message-ID: <20200815091336.GB2444151@gmail.com>
References: <20200814191449.183998-1-Yazen.Ghannam@amd.com>
 <20200814191449.183998-3-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814191449.183998-3-Yazen.Ghannam@amd.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


* Yazen Ghannam <Yazen.Ghannam@amd.com> wrote:

> +     /* Read D18F1x208 (System Fabric ID Mask 0). */
> +     if (amd_df_indirect_read(nid, 1, 0x208, umc, &tmp))
> +             goto out_err;
> +
> +     /* Determine if system is a legacy Data Fabric type. */
> +     legacy_df = !(tmp & 0xFF);

1)

I see this pattern in a lot of places in the code, first the magic 
constant 0x208 is explained a comment, then it is *repeated* and used 
it in the code...

How about introducing an obviously named enum for it instead, which 
would then be self-documenting, saving the comment and removing magic 
numbers:

	if (amd_df_indirect_read(nid, 1, AMD_REG_FAB_ID, umc, &reg_fab_id))
		goto out_err;

(The symbolic name should be something better, I just guessed 
something quickly.)

Please clean this up in a separate patch, not part of the already 
large patch that introduces a new feature.

2)

'tmp & 0xFF' is some sort of fabric version ID value, with a value of 
0 denoting legacy (pre-Rome) systems, right?

How about making that explicit:

	df_version = reg_fab_id & 0xFF;

I'm pretty sure such a version ID might come handy later on, should 
there be quirks or new capabilities with the newer systems ...


>  			ret_addr -= hi_addr_offset;
> @@ -728,23 +740,31 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
>  	}
>  
>  	lgcy_mmio_hole_en = tmp & BIT(1);
> -	intlv_num_chan	  = (tmp >> 4) & 0xF;
> -	intlv_addr_sel	  = (tmp >> 8) & 0x7;
> -	dram_base_addr	  = (tmp & GENMASK_ULL(31, 12)) << 16;
>  
> -	/* {0, 1, 2, 3} map to address bits {8, 9, 10, 11} respectively */
> -	if (intlv_addr_sel > 3) {
> -		pr_err("%s: Invalid interleave address select %d.\n",
> -			__func__, intlv_addr_sel);
> -		goto out_err;
> +	if (legacy_df) {
> +		intlv_num_chan	  = (tmp >> 4) & 0xF;
> +		intlv_addr_sel	  = (tmp >> 8) & 0x7;
> +	} else {
> +		intlv_num_chan    = (tmp >> 2) & 0xF;
> +		intlv_num_dies	  = (tmp >> 6) & 0x3;
> +		intlv_num_sockets = (tmp >> 8) & 0x1;
> +		intlv_addr_sel	  = (tmp >> 9) & 0x7;
>  	}
>  
> +	dram_base_addr	  = (tmp & GENMASK_ULL(31, 12)) << 16;
> +
>  	/* Read D18F0x114 (DramLimitAddress). */
>  	if (amd_df_indirect_read(nid, 0, 0x114 + (8 * base), umc, &tmp))
>  		goto out_err;
>  
> -	intlv_num_sockets = (tmp >> 8) & 0x1;
> -	intlv_num_dies	  = (tmp >> 10) & 0x3;
> +	if (legacy_df) {
> +		intlv_num_sockets = (tmp >> 8) & 0x1;
> +		intlv_num_dies	  = (tmp >> 10) & 0x3;
> +		dst_fabric_id	  = tmp & 0xFF;
> +	} else {
> +		dst_fabric_id	  = tmp & 0x3FF;
> +	}
> +
>  	dram_limit_addr	  = ((tmp & GENMASK_ULL(31, 12)) << 16) | GENMASK_ULL(27, 0);

Could we please structure this code in a bit more readable fashion?

1)

Such as not using the meaningless 'tmp' variable name to first read 
out DramOffset, then DramLimitAddress?

How about naming them a bit more obviously, and retrieving them in a 
single step:

        if (amd_df_indirect_read(nid, 0, 0x1B4, umc, &reg_dram_off))
                goto out_err;

        /* Remove HiAddrOffset from normalized address, if enabled: */
        if (reg_dram_off & BIT(0)) {
                u64 hi_addr_offset = (tmp & GENMASK_ULL(31, 20)) << 8;

                if (norm_addr >= hi_addr_offset) {
                        ret_addr -= hi_addr_offset;
                        base = 1;
                }
        }

        if (amd_df_indirect_read(nid, 0, 0x114 + (8 * base), umc, &reg_dram_lim))
                goto out_err;

('reg' stands for register value - but 'val' would work too.)

Side note: why is the above code using BIT() and GENMASK_UUL() when 
all the other and new code is using fixed masks? Use one of these 
versions instead of a weird mix ...

2)

Then all the fabric version dependent logic could be consolidated 
instead of being spread out:

	if (df_version) {
		intlv_num_chan    = (reg_dram_off >>  2) & 0xF;
		intlv_num_dies    = (reg_dram_off >>  6) & 0x3;
		intlv_num_sockets = (reg_dram_off >>  8) & 0x1;
		intlv_addr_sel    = (reg_dram_off >>  9) & 0x7;

		dst_fabric_id     = (reg_dram_lim >>  0) & 0x3FF;
	} else {
		intlv_num_chan    = (reg_dram_off >>  4) & 0xF;
		intlv_num_dies    = (reg_dram_lim >> 10) & 0x3;
		intlv_num_sockets = (reg_dram_lim >>  8) & 0x1;
		intlv_addr_sel    = (reg_dram_off >>  8) & 0x7;

		dst_fabric_id     = (reg_dram_lim >>  0) & 0xFF;
	}

Also note a couple of more formatting & ordering edits I did to the 
code, to improve the structure. My copy & paste job is untested 
though.

3)

Notably, note how the new code on current systems is the first branch 
- that's the most interesting code most of the time anyaway, legacy 
systems being legacy.

BTW., please do any such suggested code flow and structure clean-up 
patches first in the series, then introduce the new logic, to make it 
easier to verify.

Thanks,

	Ingo
