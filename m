Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6029CA41CC
	for <lists+linux-edac@lfdr.de>; Sat, 31 Aug 2019 04:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbfHaCxT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 30 Aug 2019 22:53:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:47055 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfHaCxT (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 30 Aug 2019 22:53:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id m3so4408630pgv.13
        for <linux-edac@vger.kernel.org>; Fri, 30 Aug 2019 19:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=TcyKIVZa6jDNzUj3tYKEQq2VBZtAcn28A/dAzDMcqB4=;
        b=WEFXcU/DVe/kv1NFGIue1kkWHjHKcmCywg9nrpJGCiS7ca6W4bHcBM3Cu27gMuR5HW
         uhB/dZVPFbIXfClOL8SnPxO1gxt/kSe123AhkS9dlpnzRIMB4xFdN+j28LPYPlpOf5jH
         Il+lak+vk4acWsOuL/1cgRkKDJq33XxaVya9p5gWcDnqX2DIQJeMkuIbFUoZOvlsIyPA
         WekqyeJle+vtM2rP11vXmJyE90jKsJibWyumscs5dCxyITX7yX5+QdYEE90HUGq6gM7q
         brauFe3CBWQQDuP2LHOGJVQ6f8jCdUzeLVHBFc9BikofxJ6rqOWsnm2GhHiPKZALGh3o
         EQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=TcyKIVZa6jDNzUj3tYKEQq2VBZtAcn28A/dAzDMcqB4=;
        b=ouAxKQVZSPgyhp7Zd7O1m/IfS6N2qjRuvveG8Y//+IEXPO20jiV80kIeoK5zkx4s9k
         x8OWjB0NljcykdZlloiS7S3Ygr+sB4Jga/PRGEM9ZwUq2q1eGYqWzjeT/mts4K0h0GMq
         jJZNIeb0FZBrwv+ezS8XLtmmfPTNPoo8lnp9SAANtpjMa3bLq2Z4r0cuWBPvQmIU58zq
         pELkXpEZsLHop0vftffTnesNyVVuLCvPMQlgHm+AzaIv/ZR/nz+jinRGmguEw9g0gO3J
         RUtMrvGljKQpbTxvIQjIPKfdtxwWbIMOdCwohKvKxf1n+qmmBaflt9bQJ2Dj6248FdsX
         hblw==
X-Gm-Message-State: APjAAAXra3XTF2mWVsynZCaUTUzDy7GPWOjX4oQM+U2vKt0tCMsMv1Ih
        lTtV0McfIIcBbPC5nFC2muixDg==
X-Google-Smtp-Source: APXvYqxfFVxDzm4BjpO5NkLMuM3Xv0D2H4t0n+BOM+Ax/QLKeOjyc8MmEjXrNdn3uuElKoxhoMgpaA==
X-Received: by 2002:a63:316:: with SMTP id 22mr4527823pgd.242.1567219998821;
        Fri, 30 Aug 2019 19:53:18 -0700 (PDT)
Received: from localhost ([216.9.110.10])
        by smtp.gmail.com with ESMTPSA id i14sm4289933pfo.158.2019.08.30.19.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 19:53:18 -0700 (PDT)
Date:   Fri, 30 Aug 2019 19:53:17 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
cc:     Christoph Hellwig <hch@lst.de>, Borislav Petkov <bp@alien8.de>,
        palmer@sifive.com, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yash Shah <yash.shah@sifive.com>
Subject: Re: [PATCH] riscv: move sifive_l2_cache.c to drivers/soc
In-Reply-To: <20190822062635.00f6e507@coco.lan>
Message-ID: <alpine.DEB.2.21.9999.1908301951080.16731@viisi.sifive.com>
References: <20190818082935.14869-1-hch@lst.de> <20190819060904.GA4841@zn.tnic> <20190819062619.GA20211@lst.de> <20190822062635.00f6e507@coco.lan>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Mauro,

On Thu, 22 Aug 2019, Mauro Carvalho Chehab wrote:

> I'm wandering if we should at least add an entry for this one at
> MAINTAINERS, pointing it to the EDAC mailing list. Something like:
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7dfe381c8b43..1c3bc5aa3af0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5906,6 +5906,7 @@ M:	Yash Shah <yash.shah@sifive.com>
>  L:	linux-edac@vger.kernel.org
>  S:	Supported
>  F:	drivers/edac/sifive_edac.c
> +F:	drivers/soc/sifive/
>  
>  EDAC-SKYLAKE
>  M:	Tony Luck <tony.luck@intel.com>

There's already a MAINTAINERS entry that should cover drivers/soc/sifive.  
Probably it's not needed to add another one here.


- Paul
