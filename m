Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7446716D4B
	for <lists+linux-edac@lfdr.de>; Tue, 30 May 2023 21:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbjE3TQg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 30 May 2023 15:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbjE3TQd (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 30 May 2023 15:16:33 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6668E;
        Tue, 30 May 2023 12:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685474193; x=1717010193;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R42q5r0P/ryqRzajsObEsjAX6NX4QX6aC3P0KATi28E=;
  b=YCYatZZipKGCvLbYL04RKceU31TtrCemcc5i0ej7gMeYl4kcLKakberY
   ZMXc4V/9Ig56o1o/lm64pxPsUmVs0AocT0IHNLxDFLkP2OX3xL8+2uP1x
   NHNy0L5ue5webtYnod3VSDxqNqKDyR1IQy5wMdn30JMKH+DXAvJ6DxXtj
   CZP8Tl/Dxoq87o0+LFvLaZPBN/AYQtmfnJopoHGwMx2OEvW1Th6+TwOfh
   7kVQVJhHAQGFM7fWfJbbb+ydLjCQQnL26OB+cBGtZW8TXhCojzty9inHB
   QK37va/cLm4DLa9ZZDereT1JEviTxXSInZ/MjLTlrrPMyV8/u40f9pudN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="358278350"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="358278350"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 12:16:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="776467133"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="776467133"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.252.140.233])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 12:16:30 -0700
Date:   Tue, 30 May 2023 12:16:29 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     tony.luck@intel.com, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
        x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mce: remove unused mce_vaddr
Message-ID: <ZHZLjRPSYCOYjkBo@aschofie-mobl2>
References: <20230528113545.650533-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230528113545.650533-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, May 28, 2023 at 07:35:45PM +0800, Miaohe Lin wrote:
> Since commit a6e3cf70b772 ("x86/mce: Change to not send SIGBUS error during
> copy from user"), mce_vaddr is not used anymore. Remove it and clean up the
> relevant code.

Hi Miaohe,

Not so sure that the 'clean up' part is useful. See below.


> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  arch/x86/kernel/cpu/mce/severity.c | 7 +------
>  include/linux/sched.h              | 1 -
>  2 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
> index c4477162c07d..0acc0039de81 100644
> --- a/arch/x86/kernel/cpu/mce/severity.c
> +++ b/arch/x86/kernel/cpu/mce/severity.c
> @@ -252,12 +252,7 @@ static bool is_copy_from_user(struct pt_regs *regs)
>  		return false;
>  	}
>  
> -	if (fault_in_kernel_space(addr))
> -		return false;
> -
> -	current->mce_vaddr = (void __user *)addr;
> -
> -	return true;
> +	return !fault_in_kernel_space(addr);
>  }


Refactoring the return is unnecessary and seems less readable.
How about removing the assignment, and leaving the rest, as is:

diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index c4477162c07d..1c03221ddcb1 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -255,8 +255,6 @@ static bool is_copy_from_user(struct pt_regs *regs)
        if (fault_in_kernel_space(addr))
                return false;
 
-       current->mce_vaddr = (void __user *)addr;
-
        return true;
 }


Alison




>  
>  /*
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index eed5d65b8d1f..3054a7087230 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1493,7 +1493,6 @@ struct task_struct {
>  #endif
>  
>  #ifdef CONFIG_X86_MCE
> -	void __user			*mce_vaddr;
>  	__u64				mce_kflags;
>  	u64				mce_addr;
>  	__u64				mce_ripv : 1,
> -- 
> 2.27.0
> 
