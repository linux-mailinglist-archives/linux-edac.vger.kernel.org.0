Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E06DA1CE0CD
	for <lists+linux-edac@lfdr.de>; Mon, 11 May 2020 18:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgEKQmS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 11 May 2020 12:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbgEKQmS (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 11 May 2020 12:42:18 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5970FC061A0C;
        Mon, 11 May 2020 09:42:17 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d22so4810481pgk.3;
        Mon, 11 May 2020 09:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wjcVkM0iIPHDmnA1v2m/HCs7tHhpwlpy7N3vN8jxvGA=;
        b=or8Ih0uOAb5nfLO9YVIifoJs8Y11ITKyZHsLxs+Tt5+8jb/Hwgk190tJ94+uFXVVaA
         P+Bih9aM1e7kiJUm8Yfsy1oB6w+viVr81EHw0nzAyipb/KNYnYTIYmm5GQyqSuIQDZ/g
         DhAD4QzusQq9yXq/clJjP3odeF0FcjwE8gW/My3WlhuL4e6ekPhdlwoz88CY9VJ3M+1g
         C7/2o1x0u4Fx1ut4cw17VCsN2xH7uFbYw80roIQVAceC4QdjcKZEOshZdIbPz9OWKvXX
         +edrhABujWLGECFOmwQ6tipvOpNEwHecuALrI1ij777In5jmnYplNOOizUt042apdYCC
         eR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wjcVkM0iIPHDmnA1v2m/HCs7tHhpwlpy7N3vN8jxvGA=;
        b=IcfLiKIYkTbK9KDhJG9C6R3AcyrCdDFESf3LmsDyxkXOwhzKfmb7xzU8H7oaPKrRbU
         MTswvJxMYapVUMSzmIeot3fOcUS7G+Txhajl0xfBBaOfItihSE4y4ikY8zb7VbIl5s6z
         k6geLas+wnMyqax4hVQC2AENX1vpLp3BhKiwmKjrpDHK79TCddGjUCW6EX4SuSNTdiHW
         bCLBNZw2cLBTry1sItlRJW5HctNYFKqXbItJ5ynbKj9LNC/f56r9JvvKzFG3bfm2E7+N
         Uxv7bPrDps1xDK8TPIv+Nr5Mf4IYWQdLm9Qwz9QAi9Uu0mlIMrRfGF70HP54tDxQWLRO
         PjAQ==
X-Gm-Message-State: AGi0PuYE9EWFhXxf4HewBVTs6yoYRO1vte4LsguzjmYVDzZVN/PaGEVH
        ghTqQxO/1rQNmI4Wn8dbw3g=
X-Google-Smtp-Source: APiQypKAjJK0uNGblLw3mQPEnYObTagGL96ucTXOo0nd0rScmYisG5kfy5slZQu1hsOEy3vHgN26Vg==
X-Received: by 2002:aa7:9a4c:: with SMTP id x12mr17113131pfj.263.1589215335809;
        Mon, 11 May 2020 09:42:15 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z7sm9536200pff.47.2020.05.11.09.42.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 May 2020 09:42:14 -0700 (PDT)
Date:   Mon, 11 May 2020 09:42:13 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexander Monakov <amonakov@ispras.ru>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Brian Woods <brian.woods@amd.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH 2/3] hwmon: (k10temp) Add AMD family 17h model 60h PCI
 match
Message-ID: <20200511164213.GA188488@roeck-us.net>
References: <20200510204842.2603-1-amonakov@ispras.ru>
 <20200510204842.2603-3-amonakov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200510204842.2603-3-amonakov@ispras.ru>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, May 10, 2020 at 08:48:41PM +0000, Alexander Monakov wrote:
> Add support for retrieving Tdie and Tctl on AMD Renoir (4000-series
> Ryzen CPUs).
> 
> It appears SMU offsets for reading current/voltage and CCD temperature
> have changed for this generation (reads from currently used offsets
> yield zeros), so those features cannot be enabled so trivially.
> 
> Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: Yazen Ghannam <yazen.ghannam@amd.com>
> Cc: Brian Woods <brian.woods@amd.com>
> Cc: Clemens Ladisch <clemens@ladisch.de>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> Cc: linux-edac@vger.kernel.org

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/hwmon/k10temp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index 9915578533bb..8f12995ec133 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -632,6 +632,7 @@ static const struct pci_device_id k10temp_id_table[] = {
>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F3) },
>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F3) },
> +	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F3) },
>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
>  	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
>  	{}
> -- 
> 2.26.2
> 
