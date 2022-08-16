Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C4E5962A2
	for <lists+linux-edac@lfdr.de>; Tue, 16 Aug 2022 20:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbiHPSp5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 Aug 2022 14:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbiHPSp4 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 16 Aug 2022 14:45:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BFA74DFC;
        Tue, 16 Aug 2022 11:45:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7BCE1B81AA9;
        Tue, 16 Aug 2022 18:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8E8C433D6;
        Tue, 16 Aug 2022 18:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660675553;
        bh=os2c9vPg3OgzC/dA3TJzMLoc1HojWYTnA3bWiznJ10s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=r2R4qO+ei+prrcXJ+uHhlv3nxcRSDBmyN5TGAFtL+R5mxvNUg9YW7MoOFKlm9QIj2
         Ba6ReofMAfUDhRzb+RtFbNBeDtviCe3HHnshXJRyen8Yuxcg1ehhXr2ZIVCvuA++Ig
         GwdoN2HL4Ezhx91Nzr6aH7T0UMKy60YWokfDrvsNhPPq44bYkcBShm1fogsBtQxUmu
         co4kcRaQCM7ez/xOg6AWhGMxu05b5uOeJ3PTuNSgFqs3M9oX4vWjNBiKPoBTVVET48
         aLx2jBWpIb0KcF8PMtYWWTP6NSx2CT7bKbF2ZDi/HXbQOjHP6sMUrh7x+SIXrB0lqU
         OjWiq4qp1zJcw==
Message-ID: <3339f4d2-a79f-9894-1c86-9b160c6a2751@kernel.org>
Date:   Tue, 16 Aug 2022 13:45:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] EDAC/altera: Fix comment typo
Content-Language: en-US
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220811120822.16832-1-wangborong@cdjrlc.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20220811120822.16832-1-wangborong@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 8/11/22 07:08, Jason Wang wrote:
> The double `the' is duplicated in the comment, remove one.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>   drivers/edac/altera_edac.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> index e7e8e624a436..940f8149172c 100644
> --- a/drivers/edac/altera_edac.c
> +++ b/drivers/edac/altera_edac.c
> @@ -168,7 +168,7 @@ static ssize_t altr_sdr_mc_err_inject_write(struct file *file,
>   	/*
>   	 * To trigger the error, we need to read the data back
>   	 * (the data was written with errors above).
> -	 * The READ_ONCE macros and printk are used to prevent the
> +	 * The READ_ONCE macros and printk are used to prevent
>   	 * the compiler optimizing these reads out.
>   	 */
>   	reg = READ_ONCE(ptemp[0]);

Acked-by: Dinh Nguyen <dinguyen@kernel.org>
