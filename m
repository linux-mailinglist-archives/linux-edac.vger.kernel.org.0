Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 435EF26850A
	for <lists+linux-edac@lfdr.de>; Mon, 14 Sep 2020 08:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgINGjL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 14 Sep 2020 02:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbgINGjE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 14 Sep 2020 02:39:04 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A7CC06174A;
        Sun, 13 Sep 2020 23:39:04 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id p9so21544220ejf.6;
        Sun, 13 Sep 2020 23:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tM1rt0vCMPBG29FozlgK4tPcKJfgi5TlJoa0v0rD7zo=;
        b=KM43qRmICDk1SaQ1VXMUHX+8tngtm6ts9le/JiSXTFcxsA4Rn545KbrS6sbua4lvB6
         55oFrksVPZKrTSkYogsSedq0HvH+7BnTvkNsKjTX8YbbnNv9LWYp3KAOZuNYjrzekkso
         g15xcuUW7Pp9ctrMAJdkZx7E67oOI6E/iPPjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tM1rt0vCMPBG29FozlgK4tPcKJfgi5TlJoa0v0rD7zo=;
        b=KNVSjCN7ZvwMEMSnACwEtj2+0FaCFzkqlEFoabrb6IOhJ2dGWGpGqJByenjSiIrKSn
         UslM1N9dYm+xRarFg9hxqQQZ3CRs4x53Tu/g8LFPA6eOv4kXTvVrsfDYSz2LnqYbyMg4
         Uv5Ua9SAvODNa1ejxax34yM04SAvVxMlYRDjw3Mz+GcU/NxPrSnNkDdzSXmzdy2cM51Y
         xLgzj5/T+UGogReeasrtwT7AvHDTnkzpcfj2cK4kwQ08sQ4ujqJmEiurQcS4j7oD+9fU
         nXyZr/rO5WM1W3hCZOGfFrmnvNx6Nc2hAE4TU70Zqe3Hpsiv/Kvs8l4SNjyPEUvIQPVp
         Fzrw==
X-Gm-Message-State: AOAM532eUTiK8h6pIJ3WcpMl1WXwSv+oDGWKNzB1rmRP4d9nuiOOolnj
        aEvOI3N259ToREnIqB3DbmgdJjADh56lvDE1oGE=
X-Google-Smtp-Source: ABdhPJzrrj2gAuLbkZT1NZHl72TkCiS8KlLa+esbZG3y0tjiUqQYdjdE8GIcrDf9ZRv0CeN9WMiieM2monhZa1/DE5s=
X-Received: by 2002:a17:906:4c58:: with SMTP id d24mr13673692ejw.108.1600065543130;
 Sun, 13 Sep 2020 23:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200914065358.3726216-1-liushixin2@huawei.com>
In-Reply-To: <20200914065358.3726216-1-liushixin2@huawei.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 14 Sep 2020 06:38:50 +0000
Message-ID: <CACPK8XdWAFjdmsr6nRtuvK95DOrq2C39WHjG+ZHvHGEVP4kE_w@mail.gmail.com>
Subject: Re: [PATCH -next] EDAC/aspeed: use module_platform_driver to simplify
 the code
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Stefan Schaeckeler <sschaeck@cisco.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>, linux-edac@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, 14 Sep 2020 at 06:31, Liu Shixin <liushixin2@huawei.com> wrote:
>
> module_platform_driver() makes the code simpler by eliminating
> boilerplate code.
>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/edac/aspeed_edac.c | 18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
>
> diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
> index fbec28dc661d..fde809efc520 100644
> --- a/drivers/edac/aspeed_edac.c
> +++ b/drivers/edac/aspeed_edac.c
> @@ -388,23 +388,7 @@ static struct platform_driver aspeed_driver = {
>         .probe          = aspeed_probe,
>         .remove         = aspeed_remove
>  };
> -
> -
> -static int __init aspeed_init(void)
> -{
> -       return platform_driver_register(&aspeed_driver);
> -}
> -
> -
> -static void __exit aspeed_exit(void)
> -{
> -       platform_driver_unregister(&aspeed_driver);
> -}
> -
> -
> -module_init(aspeed_init);
> -module_exit(aspeed_exit);
> -
> +module_platform_driver(aspeed_driver);
>
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Stefan Schaeckeler <sschaeck@cisco.com>");
> --
> 2.25.1
>
