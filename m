Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD01D243062
	for <lists+linux-edac@lfdr.de>; Wed, 12 Aug 2020 23:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgHLVJS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 12 Aug 2020 17:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgHLVJR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 12 Aug 2020 17:09:17 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93619C061383
        for <linux-edac@vger.kernel.org>; Wed, 12 Aug 2020 14:09:17 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id kr4so1738038pjb.2
        for <linux-edac@vger.kernel.org>; Wed, 12 Aug 2020 14:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bAaQQ7e9aAoGDmzOJ51xKy0+RuDHeXB46TjNq9EcMXw=;
        b=JJyY3xwd5EgGKBxKKs4dXLXjk5wiLbg072kKzLvv50o9mgzTqqrQJL+xdDaimziA1c
         8lAJxeWVFouTjEHC3p+FJBHv9MkkQXebphjhv/87vMA03btiQzyISXigPijA5x2KQoW5
         nUw89h2rmkM9A/ksku0Eaj3hOHIgdGgwzjFhnjtQSgNPwpja4IRE5ffrLMK8bI+rSdPx
         zrd1zLC5Ud5n5igqgNzbn4hLLF+kvpQzPaA3G36KP5d616DBAw5ejnhDSpbZCyii00Ts
         0nv+48h+3RkOCkQQ7zTOGGL8XFhl0NtwiI7rHihoXoga1nJQSXnDWdFxDtA0zFVtgo2u
         58kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bAaQQ7e9aAoGDmzOJ51xKy0+RuDHeXB46TjNq9EcMXw=;
        b=uCtKYrv8eqxpZXeFAivfcdrg/0wUe3uLQqvXI+M8jpaAQlAJ0hn9jK/bPnwLJeHC8P
         ovuODrLIOx0F0X8eDAkgtyiEbRXUX7t7koAqMVl2UhZ6wbEMwKQV0lZf87Pw4fwCQ664
         fNP17PUFFe8cyEqxthHLT3W4023h/pCiC0SOQOh0ogkVevo1OuDZJG2ny5TI6ypIu/0h
         SVbvTE3lnoHFp80gMlU7hJ6303hB9vU0jRFH4rEykquuDJ83SA4QFk6Eyi4JNNtIgIR/
         ZyQ1L1KYixRCF9B5w0XQBgxekukMIlqhQx/2rmyn/zNU9o0PxKdj6Zr+9cdfXY6rGqYi
         +O9A==
X-Gm-Message-State: AOAM532UIbXHqtuIsddYrE4ZMe+p+ctlIjN1VuImul0Q/ItfAC1+NGsW
        PM1s4BhVdqsp32NpoCj5ItPJlMDtwEs=
X-Google-Smtp-Source: ABdhPJzpIfuVpvNm7+wJPOKe1ryB9LzK23HxdnBP82RAznzjdf1L5AejEUEGRunqac7heeExlbSFHQ==
X-Received: by 2002:a17:90a:2210:: with SMTP id c16mr1938422pje.65.1597266556824;
        Wed, 12 Aug 2020 14:09:16 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
        by smtp.gmail.com with ESMTPSA id n1sm3437625pfu.2.2020.08.12.14.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 14:09:16 -0700 (PDT)
Date:   Wed, 12 Aug 2020 14:09:09 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Luca Stefani <luca.stefani.ge1@gmail.com>
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] RAS/CEC: Fix cec_init prototype
Message-ID: <20200812210909.GA3283093@google.com>
References: <20200805045955.GB9127@nazgul.tnic>
 <20200805095708.83939-1-luca.stefani.ge1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805095708.83939-1-luca.stefani.ge1@gmail.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Luca,

On Wed, Aug 05, 2020 at 11:57:08AM +0200, Luca Stefani wrote:
> * late_initcall expects a function that returns an integer
>   -> Update the function signature to match.
> 
> Fixes: 9554bfe403nd ("x86/mce: Convert the CEC to use the MCE notifier")
> Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>

Thank you for fixing this!

[Note that this v2 email never landed in my inbox, perhaps Gmail filtered
 it out due to a missing To: line?]

> ---
>  drivers/ras/cec.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
> index 569d9ad2c594..6939aa5b3dc7 100644
> --- a/drivers/ras/cec.c
> +++ b/drivers/ras/cec.c
> @@ -553,20 +553,20 @@ static struct notifier_block cec_nb = {
>  	.priority	= MCE_PRIO_CEC,
>  };
>  
> -static void __init cec_init(void)
> +static int __init cec_init(void)
>  {
>  	if (ce_arr.disabled)
> -		return;
> +		return -ENODEV;
>  
>  	ce_arr.array = (void *)get_zeroed_page(GFP_KERNEL);
>  	if (!ce_arr.array) {
>  		pr_err("Error allocating CE array page!\n");
> -		return;
> +		return -ENOMEM;
>  	}
>  
>  	if (create_debugfs_nodes()) {
>  		free_page((unsigned long)ce_arr.array);
> -		return;
> +		return -ENOMEM;
>  	}
>  
>  	INIT_DELAYED_WORK(&cec_work, cec_work_fn);
> @@ -575,6 +575,7 @@ static void __init cec_init(void)
>  	mce_register_decode_chain(&cec_nb);
>  
>  	pr_info("Correctable Errors collector initialized.\n");
> +	return 0;
>  }
>  late_initcall(cec_init);

The type mismatch broke allyesconfig in my test tree and your patch
fixes the issue. Please feel free to add:

  Reviewed-and-tested-by: Sami Tolvanen <samitolvanen@google.com>

Sami
