Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D871E731624
	for <lists+linux-edac@lfdr.de>; Thu, 15 Jun 2023 13:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239789AbjFOLIU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 15 Jun 2023 07:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239131AbjFOLIT (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 15 Jun 2023 07:08:19 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACBD1FC3;
        Thu, 15 Jun 2023 04:08:18 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QhfXh1vStzqTbX;
        Thu, 15 Jun 2023 19:03:16 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 19:08:14 +0800
Subject: Re: [PATCH v2] x86/mce: remove unused mce_vaddr
To:     <tony.luck@intel.com>, <bp@alien8.de>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <dave.hansen@linux.intel.com>
CC:     <hpa@zytor.com>, <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230603111105.174716-1-linmiaohe@huawei.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <a5c5bb7a-b678-42a5-ed51-713274401b89@huawei.com>
Date:   Thu, 15 Jun 2023 19:08:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230603111105.174716-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 2023/6/3 19:11, Miaohe Lin wrote:
> Since commit a6e3cf70b772 ("x86/mce: Change to not send SIGBUS error during
> copy from user"), mce_vaddr is not used anymore. Remove it.
> 

friendly ping.. :)

> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  arch/x86/kernel/cpu/mce/severity.c | 2 --
>  include/linux/sched.h              | 1 -
>  2 files changed, 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
> index c4477162c07d..1c03221ddcb1 100644
> --- a/arch/x86/kernel/cpu/mce/severity.c
> +++ b/arch/x86/kernel/cpu/mce/severity.c
> @@ -255,8 +255,6 @@ static bool is_copy_from_user(struct pt_regs *regs)
>  	if (fault_in_kernel_space(addr))
>  		return false;
>  
> -	current->mce_vaddr = (void __user *)addr;
> -
>  	return true;
>  }
>  
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
> 

