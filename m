Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B6170655D
	for <lists+linux-edac@lfdr.de>; Wed, 17 May 2023 12:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjEQKfk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 17 May 2023 06:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjEQKfj (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 17 May 2023 06:35:39 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACABB46BC;
        Wed, 17 May 2023 03:35:36 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 23ABB1EC055F;
        Wed, 17 May 2023 12:35:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1684319735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FwGWKHLkKUdLuUdBhzwQ9e1l46xPOSwRIK8Q7K5w8as=;
        b=kCoZaZfsh0+CF4xNiQMOmIRwCwKGjZxbV7ir7L2Ke/xXASps+uJky4O2gdLDO7gDJ0J5J4
        KERcKDzTGYhXRZKZJ1y2mgYWUobvEWjwfkfJudtBBq68T9r6ov8Qq94n6gz6B9UA+5X8Wo
        yuVh6Xlmkxtt/S063i3HYiVTa+zRllM=
Date:   Wed, 17 May 2023 12:35:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, mchehab@kernel.org, james.morse@arm.com,
        rric@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmitry.baryshkov@linaro.org
Subject: Re: [RESEND PATCH v7 1/2] EDAC/qcom: Remove extra error no
 assignment in qcom_llcc_core_setup()
Message-ID: <20230517103531.GBZGSt8+UMmEp4Q/8K@fat_crate.local>
References: <20230517062859.57371-1-manivannan.sadhasivam@linaro.org>
 <20230517062859.57371-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230517062859.57371-2-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, May 17, 2023 at 11:58:58AM +0530, Manivannan Sadhasivam wrote:
> If the ret variable is initialized with -EINVAL, then there is no need to
> assign it again in the default case of qcom_llcc_core_setup().
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/edac/qcom_edac.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
> index 265e0fb39bc7..53d666ffcb1f 100644
> --- a/drivers/edac/qcom_edac.c
> +++ b/drivers/edac/qcom_edac.c
> @@ -170,7 +170,7 @@ static int qcom_llcc_core_setup(struct regmap *llcc_bcast_regmap)
>  static int
>  qcom_llcc_clear_error_status(int err_type, struct llcc_drv_data *drv)
>  {
> -	int ret = 0;
> +	int ret = -EINVAL;

It is actually better to leave it here uninitialized...

>  
>  	switch (err_type) {
>  	case LLCC_DRAM_CE:
> @@ -198,7 +198,6 @@ qcom_llcc_clear_error_status(int err_type, struct llcc_drv_data *drv)
>  			return ret;
>  		break;
>  	default:
> -		ret = -EINVAL;

... and initialize it here to -EINVAL because then it is perfectly clear
what the default case returns. Instead of going through the whole
function.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
