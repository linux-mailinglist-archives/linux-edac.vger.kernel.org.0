Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20F64E2B7E
	for <lists+linux-edac@lfdr.de>; Mon, 21 Mar 2022 16:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238929AbiCUPLq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 21 Mar 2022 11:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344832AbiCUPLp (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 21 Mar 2022 11:11:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBF2B7C78;
        Mon, 21 Mar 2022 08:10:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8989560F42;
        Mon, 21 Mar 2022 15:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C582EC340E8;
        Mon, 21 Mar 2022 15:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647875418;
        bh=2NhbbdTteLjcJ8tMp9FedI8DJRaiJl0VuMgB1aUaD9A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Bgv+FDLU4CzS47qsmq7TCpsMoQFGtqY2wumfl2GnWrdZN5+boxTTQa0iiHnLVpxzA
         USvTK7rxbCiZ1POJDK5EeERbqEDJITvwfvLSfxJoUJVg2ljNr6kNyV8owypt/eOX32
         au1kBUttruGWZkztlmkLupiYmLfBh0ndAmo3oKoKz/esS+ZX7xXx15s86OoZLuSr2K
         bo7HKbei6wVDvyV83cB+/nRyOXuiuTMkps/WI1aqNi2FyHeJW7mLOVoIhGKi6hnjxW
         fJD1ZvoIaRHW7/Y0Z2drcN2NXKVJh/rmkNRZbYwZY3fMsEbBsoSdpL6gkHRPDlK7uh
         hAGB/rkIX8SPA==
Message-ID: <79f5594f-2864-4df8-c04b-6d1c3f8a764c@kernel.org>
Date:   Mon, 21 Mar 2022 10:10:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH -next] EDAC/altera: Remove unnecessary print function
 dev_err()
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20220317233722.109036-1-yang.lee@linux.alibaba.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20220317233722.109036-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 3/17/22 18:37, Yang Li wrote:
> The print function dev_err() is redundant because platform_get_irq()
> already prints an error.
> 
> Eliminate the follow coccicheck warnings:
> ./drivers/edac/altera_edac.c:2153:2-9: line 2153 is redundant because
> platform_get_irq() already prints an error
> ./drivers/edac/altera_edac.c:2188:2-9: line 2188 is redundant because
> platform_get_irq() already prints an error
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>   drivers/edac/altera_edac.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> index e7e8e624a436..47dc35938fa8 100644
> --- a/drivers/edac/altera_edac.c
> +++ b/drivers/edac/altera_edac.c
> @@ -2149,10 +2149,8 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
>   	}
>   
>   	edac->sb_irq = platform_get_irq(pdev, 0);
> -	if (edac->sb_irq < 0) {
> -		dev_err(&pdev->dev, "No SBERR IRQ resource\n");
> +	if (edac->sb_irq < 0)
>   		return edac->sb_irq;
> -	}
>   
>   	irq_set_chained_handler_and_data(edac->sb_irq,
>   					 altr_edac_a10_irq_handler,
> @@ -2184,10 +2182,8 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
>   	}
>   #else
>   	edac->db_irq = platform_get_irq(pdev, 1);
> -	if (edac->db_irq < 0) {
> -		dev_err(&pdev->dev, "No DBERR IRQ resource\n");
> +	if (edac->db_irq < 0)
>   		return edac->db_irq;
> -	}
>   	irq_set_chained_handler_and_data(edac->db_irq,
>   					 altr_edac_a10_irq_handler, edac);
>   #endif

Acked-by: Dinh Nguyen <dinguyen@kernel.org>
