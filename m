Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9EF737A03
	for <lists+linux-edac@lfdr.de>; Wed, 21 Jun 2023 06:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjFUEBQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 21 Jun 2023 00:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjFUEBE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 21 Jun 2023 00:01:04 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364401BD9;
        Tue, 20 Jun 2023 21:00:45 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Qm8tD6qc1z1FDhn;
        Wed, 21 Jun 2023 12:00:36 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 21 Jun 2023 12:00:43 +0800
Subject: Re: [PATCH] EDAC/mc: fix potential memoryleak in edac_mc_alloc()
To:     <tony.luck@intel.com>, <bp@alien8.de>
CC:     <james.morse@arm.com>, <mchehab@kernel.org>, <rric@kernel.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230603144131.832804-1-linmiaohe@huawei.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <e9d1f449-17ad-c4d9-05b0-779c7160433e@huawei.com>
Date:   Wed, 21 Jun 2023 12:00:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230603144131.832804-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

On 2023/6/3 22:41, Miaohe Lin wrote:
> When fails to allocate memory for layers or pvt_info, _edac_mc_free()
> will be called to release the resource of edac mc but mci->dev is not
> even initialized at that time. _edac_mc_free() will fail to release
> the allocated memory.

friendly ping.. :)

> 
> Fixes: 0bbb265f7089 ("EDAC/mc: Get rid of silly one-shot struct allocation in edac_mc_alloc()")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  drivers/edac/edac_mc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index 6faeb2ab3960..89dc5954d19e 100644
> --- a/drivers/edac/edac_mc.c
> +++ b/drivers/edac/edac_mc.c
> @@ -364,6 +364,8 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
>  	mci = kzalloc(sizeof(struct mem_ctl_info), GFP_KERNEL);
>  	if (!mci)
>  		return NULL;
> +	mci->dev.release = mci_release;
> +	device_initialize(&mci->dev);
>  
>  	mci->layers = kcalloc(n_layers, sizeof(struct edac_mc_layer), GFP_KERNEL);
>  	if (!mci->layers)
> @@ -373,9 +375,6 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
>  	if (!mci->pvt_info)
>  		goto error;
>  
> -	mci->dev.release = mci_release;
> -	device_initialize(&mci->dev);
> -
>  	/* setup index and various internal pointers */
>  	mci->mc_idx = mc_num;
>  	mci->tot_dimms = tot_dimms;
> 

