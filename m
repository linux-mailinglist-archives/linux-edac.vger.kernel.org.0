Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50A74D1CB5
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2019 01:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732659AbfJIXTr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 9 Oct 2019 19:19:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:37828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732643AbfJIXTp (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 9 Oct 2019 19:19:45 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2D9E21D7A;
        Wed,  9 Oct 2019 23:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570663184;
        bh=lUJoAmwVYmxxiLBq1t4lFuiOCc5wh99DLAMa0XWi83Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EX0XvZkUqRywUXEZluTpt8by0lHIdCK0jXPS5QiWzgkmoqtDPcb8vs+/4csID0idh
         iuI+A4/4AaNMjW05zuB+OIPXeaO34GcyKyEEFea6ZOiHHQWZbwVX282H6ZDd85uWqB
         rao57zDmN4mh8HK9pAEEpRfTKZvfVL1wt33VE2d4=
Received: by mail-qk1-f172.google.com with SMTP id u22so3824978qkk.11;
        Wed, 09 Oct 2019 16:19:44 -0700 (PDT)
X-Gm-Message-State: APjAAAW/S3U+viHuqTPO6nNFg62Bl9HrPhquxkCeNpod6CkTE4JCcTHZ
        BOjKpIW04FN+zxbUD48OOlW+4LF7LGNHtXIeiA==
X-Google-Smtp-Source: APXvYqyPSfTjVLV3COlA1kAK+1OFfKGo6+mldinX14j08Mhg6XsRIJdoe4XiZTLLEwhEamG94ntdDl3vE8H5N2e0G8U=
X-Received: by 2002:a05:620a:12f1:: with SMTP id f17mr6421929qkl.152.1570663183781;
 Wed, 09 Oct 2019 16:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <20191007151730.7705-1-hhhawa@amazon.com> <20191007151730.7705-4-hhhawa@amazon.com>
In-Reply-To: <20191007151730.7705-4-hhhawa@amazon.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 9 Oct 2019 18:19:32 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLZOHx=3d9jPy+7y0a92wA-VKEDQ4PVNvo6L8fRe7xJCQ@mail.gmail.com>
Message-ID: <CAL_JsqLZOHx=3d9jPy+7y0a92wA-VKEDQ4PVNvo6L8fRe7xJCQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] edac: Add support for Amazon's Annapurna Labs L2 EDAC
To:     Hanna Hawa <hhhawa@amazon.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>, daniel@iogearbox.net,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        devicetree@vger.kernel.org, "Woodhouse, David" <dwmw@amazon.co.uk>,
        benh@amazon.com, "Krupnik, Ronen" <ronenk@amazon.com>,
        Talel Shenhar <talel@amazon.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        "Hanoch, Uri" <hanochu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Oct 7, 2019 at 10:18 AM Hanna Hawa <hhhawa@amazon.com> wrote:
>
> Adds support for Amazon's Annapurna Labs L2 EDAC driver to detect and
> report L2 errors.
>
> Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
> ---
>  MAINTAINERS               |   5 +
>  drivers/edac/Kconfig      |   8 ++
>  drivers/edac/Makefile     |   1 +
>  drivers/edac/al_l2_edac.c | 251 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 265 insertions(+)
>  create mode 100644 drivers/edac/al_l2_edac.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7887a62dc843..0eabcfcf91a9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -748,6 +748,11 @@ M: Hanna Hawa <hhhawa@amazon.com>
>  S:     Maintained
>  F:     drivers/edac/al_l1_edac.c
>
> +AMAZON ANNAPURNA LABS L2 EDAC
> +M:     Hanna Hawa <hhhawa@amazon.com>
> +S:     Maintained
> +F:     drivers/edac/al_l2_edac.c
> +
>  AMAZON ANNAPURNA LABS THERMAL MMIO DRIVER
>  M:     Talel Shenhar <talel@amazon.com>
>  S:     Maintained
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index e8161d7c7469..cb394aff1cab 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -82,6 +82,14 @@ config EDAC_AL_L1
>           for Amazon's Annapurna Labs SoCs.
>           This driver detects errors of L1 caches.
>
> +config EDAC_AL_L2
> +       tristate "Amazon's Annapurna Labs L2 EDAC"

I still think this should be an "A57 L2 ECC" driver, but if no one
cares I'll shut up and the 2nd person can rename everything.

> +       depends on ARCH_ALPINE

|| COMPILE_TEST

Maybe it needs an ARM64 dependency too in this case?

> +       help
> +         Support for L2 error detection and correction
> +         for Amazon's Annapurna Labs SoCs.
> +         This driver detects errors of L2 caches.
> +

> +
> +       ret = platform_driver_register(&al_l2_edac_driver);
> +       if (ret) {
> +               pr_err("Failed to register %s (%d)\n", DRV_NAME, ret);
> +               return ret;
> +       }
> +
> +       edac_l2_device = platform_device_register_simple(DRV_NAME, -1, NULL, 0);
> +       if (IS_ERR(edac_l2_device)) {
> +               pr_err("Failed to register EDAC AL L2 platform device\n");
> +               return PTR_ERR(edac_l2_device);
> +       }
> +
> +       return 0;
> +}
> +
> +static void __exit al_l2_exit(void)
> +{
> +       platform_device_unregister(edac_l2_device);
> +       platform_driver_unregister(&al_l2_edac_driver);
> +}
> +
> +late_initcall(al_l2_init);
> +module_exit(al_l2_exit);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Hanna Hawa <hhhawa@amazon.com>");
> +MODULE_DESCRIPTION("Amazon's Annapurna Lab's L2 EDAC Driver");
> --
> 2.17.1
>
