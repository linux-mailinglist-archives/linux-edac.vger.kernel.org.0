Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D467A149A
	for <lists+linux-edac@lfdr.de>; Fri, 15 Sep 2023 05:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjIODxp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 14 Sep 2023 23:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjIODxo (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 14 Sep 2023 23:53:44 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D96268E
        for <linux-edac@vger.kernel.org>; Thu, 14 Sep 2023 20:53:39 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-76f14d80ea6so112608485a.2
        for <linux-edac@vger.kernel.org>; Thu, 14 Sep 2023 20:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694750018; x=1695354818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=safuiutMd5TAjaP497Td/r6GuUOV211lkJ/afrQb0xk=;
        b=kAboyiveCqCE3RcWWNlLtGvR5vq+6yY+VagclkuImxcR7elhpTMI1J1FrgiJLCZ1ge
         eppVoLf+5yetw3j9Rz7PbKOgfNWVTXPU16Nr1NFYltUxMVzYUAEaPssnXrk6dtE3LYWv
         Rh+MPdgAJtIKDVJx/ghmorA34Dy+Ga/v078H0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694750018; x=1695354818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=safuiutMd5TAjaP497Td/r6GuUOV211lkJ/afrQb0xk=;
        b=OGKl8JOBBGS3T+aHajx7iByHWDPk8NuWEcC82VNhWRP667luOyC9DZ161gO7B/wEjE
         7Im/evIuJRIbE8iH7EX1UHEIVWDJIr1bh9g3NJhlnYZsAbDLPQ0c5HH0jRnoKg8K3dfx
         +OPaddeligri7oW1WXwg5Xjeo4ybCOqmJxC1idZQr8TJH1AEBlAIVxQfYcfBv7G6tGZK
         TqBaojPQkOxzoKAWU69uW22vayh+hinfXe51fphaNtahhrYShKEktgEbao5zcJwl8j/s
         5b9uLdQnQldb0v1GZCqmmNfI53Pg2Ss/WpgwCMQnhofMBED8lcvE/hSLcLMuTTXqgjFe
         GVGg==
X-Gm-Message-State: AOJu0YwqeyL1tY2BfvoJDrfPyYxoGth9CRzh6vyd+Wyfjc5CvbIrIRpz
        Sg3pOsqqNPn80AJ25eD5u51L6A==
X-Google-Smtp-Source: AGHT+IFDC+mV4cqDd8P2tRkndNFN7B4M7VpZL+CZjMC55Tnyu67GBZhlOjFGlx8asBQ+k7cwzDHEHQ==
X-Received: by 2002:a05:620a:201c:b0:772:45f0:5018 with SMTP id c28-20020a05620a201c00b0077245f05018mr453991qka.40.1694750018281;
        Thu, 14 Sep 2023 20:53:38 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e21-20020aa78255000000b00682d79199e7sm2002388pfn.200.2023.09.14.20.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 20:53:37 -0700 (PDT)
Date:   Thu, 14 Sep 2023 20:53:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] EDAC/mc_sysfs: refactor deprecated strncpy
Message-ID: <202309142045.7CBAE940E@keescook>
References: <20230913-strncpy-drivers-edac-edac_mc_sysfs-c-v3-1-38c1db7d207f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913-strncpy-drivers-edac-edac_mc_sysfs-c-v3-1-38c1db7d207f@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Sep 13, 2023 at 05:20:50PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on the destination buffer without needlessly
> NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Changes in v3:
> - prefer strscpy to strscpy_pad (thanks Tony)
> - Link to v2: https://lore.kernel.org/r/20230913-strncpy-drivers-edac-edac_mc_sysfs-c-v2-1-2d2e6bd43642@google.com
> 
> Changes in v2:
> - included refactor of another strncpy in same file
> - Link to v1: https://lore.kernel.org/r/20230913-strncpy-drivers-edac-edac_mc_sysfs-c-v1-1-d232891b05b0@google.com
> ---
> Note: build-tested only.
> ---
>  drivers/edac/edac_mc_sysfs.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
> index 15f63452a9be..9a5b4bbd8191 100644
> --- a/drivers/edac/edac_mc_sysfs.c
> +++ b/drivers/edac/edac_mc_sysfs.c
> @@ -229,8 +229,7 @@ static ssize_t channel_dimm_label_store(struct device *dev,
>  	if (copy_count == 0 || copy_count >= sizeof(rank->dimm->label))
>  		return -EINVAL;
>  
> -	strncpy(rank->dimm->label, data, copy_count);
> -	rank->dimm->label[copy_count] = '\0';
> +	strscpy(rank->dimm->label, data, copy_count);

Hrm, I don't like the use of "copy_count" here -- it's the source
length, not the destination buffer size. It is technically safe because
it was bounds-checked right before, but now we run the risk of
additional truncation since "copy_count" will not include the '\0'.

Imagine data = "a", count = 1. strscpy(dst, data, 1) will only copy
'\0'.

I think this should be memcpy(), not strscpy(). The bounds checking and
truncation of '\n' has already been calculated -- we're just doing a
byte copy at this point:

        if (count == 0)
                return -EINVAL;

        if (data[count - 1] == '\0' || data[count - 1] == '\n')
                copy_count -= 1;

        if (copy_count == 0 || copy_count >= sizeof(rank->dimm->label))
                return -EINVAL;

        memcpy(rank->dimm->label, data, copy_count);
        rank->dimm->label[copy_count] = '\0';



>  
>  	return count;
>  }
> @@ -535,7 +534,7 @@ static ssize_t dimmdev_label_store(struct device *dev,
>  	if (copy_count == 0 || copy_count >= sizeof(dimm->label))
>  		return -EINVAL;
>  
> -	strncpy(dimm->label, data, copy_count);
> +	strscpy(dimm->label, data, copy_count);
>  	dimm->label[copy_count] = '\0';

Same for this one: replace strncpy with memcpy.

-Kees

>  
>  	return count;
> 
> ---
> base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
> change-id: 20230913-strncpy-drivers-edac-edac_mc_sysfs-c-e619b00124a3
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

-- 
Kees Cook
