Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C49072F288
	for <lists+linux-edac@lfdr.de>; Wed, 14 Jun 2023 04:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242235AbjFNCTa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 13 Jun 2023 22:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242272AbjFNCTW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 13 Jun 2023 22:19:22 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA7E1BD2;
        Tue, 13 Jun 2023 19:19:19 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Vl4LsBS_1686709155;
Received: from 30.240.112.107(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vl4LsBS_1686709155)
          by smtp.aliyun-inc.com;
          Wed, 14 Jun 2023 10:19:17 +0800
Message-ID: <31fdaacc-cc2b-5ea5-8a0e-e5ccfe674834@linux.alibaba.com>
Date:   Wed, 14 Jun 2023 10:19:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.1
Subject: Re: [PATCH 2/3] x86/mce: Define amd_mce_usable_address()
Content-Language: en-US
To:     Yazen Ghannam <yazen.ghannam@amd.com>, linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        muralidhara.mk@amd.com, joao.m.martins@oracle.com,
        william.roche@oracle.com, boris.ostrovsky@oracle.com,
        john.allen@amd.com, baolin.wang@linux.alibaba.com
References: <20230613141142.36801-1-yazen.ghannam@amd.com>
 <20230613141142.36801-3-yazen.ghannam@amd.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20230613141142.36801-3-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 2023/6/13 22:11, Yazen Ghannam wrote:
> Currently, all valid MCA_ADDR values are assumed to be usable on AMD
> systems. However, this is not correct in most cases. Notifiers expecting
> usable addresses may then operate on inappropriate values.
> 
> Define a helper function to do AMD-specific checks for a usable memory
> address. List out all known cases.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  arch/x86/kernel/cpu/mce/amd.c      | 38 ++++++++++++++++++++++++++++++
>  arch/x86/kernel/cpu/mce/core.c     |  3 +++
>  arch/x86/kernel/cpu/mce/internal.h |  2 ++
>  3 files changed, 43 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index 1ccfb0c9257f..ca79fa10b844 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -746,6 +746,44 @@ bool amd_mce_is_memory_error(struct mce *m)
>  	return legacy_mce_is_memory_error(m);
>  }
>  
> +/*
> + * AMD systems do not have an explicit indicator that the value in MCA_ADDR is
> + * a system physical address. Therefore individual cases need to be detected.
> + * Future cases and checks will be added as needed.
> + *
> + * 1) General case
> + *	a) Assume address is not usable.
> + * 2) "Poison" errors
> + *	a) Indicated by MCA_STATUS[43]: POISON. Defined for all banks except legacy
> + *	   Northbridge (bank 4).
> + *	b) Refers to poison consumption in the Core. Does not include "no action",
> + *	   "action optional", or "deferred" error severities.
> + *	c) Will include a usuable address so that immediate action can be taken.
> + * 3) Northbridge DRAM ECC errors
> + *	a) Reported in legacy bank 4 with XEC 8.
> + *	b) MCA_STATUS[43] is *not* defined as POISON in legacy bank 4. Therefore,
> + *	   this bit should not be checked.
[nit]

> + *
> + * NOTE: SMCA UMC memory errors fall into case #1.

hi, Yazen

The address for SMCA UMC memory error is not system physical address, it make sense
to be not usable. But how we deal with the SMCA address? The MCE chain like
uc_decode_notifier will do a sanity check with mce_usable_address and it will not
handle SMCA address.

Thanks.

Best Regards,
Shuai

> + */
> +bool amd_mce_usable_address(struct mce *m)
> +{
> +	/* Check special Northbridge case first. */
> +	if (!mce_flags.smca) {
> +		if (legacy_mce_is_memory_error(m))
> +			return true;
> +		else if (m->bank == 4)
> +			return false;
> +	}
> +
> +	/* Check Poison bit for all other bank types. */
> +	if (m->status & MCI_STATUS_POISON)
> +		return true;
> +
> +	/* Assume address is not usable for all others. */
> +	return false;
> +}
> +
>  static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
>  {
>  	struct mce m;
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 89e2aab5d34d..859ce20dd730 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -464,6 +464,9 @@ int mce_usable_address(struct mce *m)
>  	if (!(m->status & MCI_STATUS_ADDRV))
>  		return 0;
>  
> +	if (m->cpuvendor == X86_VENDOR_AMD)
> +		return amd_mce_usable_address(m);
> +
>  	/* Checks after this one are Intel/Zhaoxin-specific: */
>  	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL &&
>  	    boot_cpu_data.x86_vendor != X86_VENDOR_ZHAOXIN)
> diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
> index d2412ce2d312..0d4c5b83ed93 100644
> --- a/arch/x86/kernel/cpu/mce/internal.h
> +++ b/arch/x86/kernel/cpu/mce/internal.h
> @@ -207,6 +207,7 @@ extern bool filter_mce(struct mce *m);
>  
>  #ifdef CONFIG_X86_MCE_AMD
>  extern bool amd_filter_mce(struct mce *m);
> +bool amd_mce_usable_address(struct mce *m);
>  
>  /*
>   * If MCA_CONFIG[McaLsbInStatusSupported] is set, extract ErrAddr in bits
> @@ -234,6 +235,7 @@ static __always_inline void smca_extract_err_addr(struct mce *m)
>  
>  #else
>  static inline bool amd_filter_mce(struct mce *m) { return false; }
> +static inline bool amd_mce_usable_address(struct mce *m) { return false; }
>  static inline void smca_extract_err_addr(struct mce *m) { }
>  #endif
>  
