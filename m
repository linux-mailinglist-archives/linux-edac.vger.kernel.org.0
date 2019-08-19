Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAA3291C25
	for <lists+linux-edac@lfdr.de>; Mon, 19 Aug 2019 06:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbfHSEo3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 19 Aug 2019 00:44:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35287 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfHSEo3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 19 Aug 2019 00:44:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id k2so7203662wrq.2
        for <linux-edac@vger.kernel.org>; Sun, 18 Aug 2019 21:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fTdhTJlfOEvwMxtoOo8JgnOcQgqcJ7O6rfujPFqHNDs=;
        b=rH337aQk94SWC4IT60yJz1ozOzffxGCHpGpI+emUGND0A3/kgYnnSBEK6gpjmxFxXp
         iuYFCUFx5wyjY7wLk62+KIJavNt0eYH/GXtCHCjveXmnPvGiN5OixCTWxdfnqsgjxn9w
         2lcinCuOPQQySpK+QGLWFSuatxvnSJlh8MhxDp9csdOV9XsW7zqcSFXBjX6mPDhkIe34
         1AOQrEjGsSl39kOicGpeCeoVpbELRFY6k0FlA7xEmwKa0twcyyuxlKlJb13YTPAd4Tt8
         GgwlgGroYXUM9cgK5gMV1px5kHAahLOzoObnOfaO6DJ4LyQruK6G6kAZF/L72wkkS0wR
         TL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fTdhTJlfOEvwMxtoOo8JgnOcQgqcJ7O6rfujPFqHNDs=;
        b=ZBZ4qHAb1sFUpD06G6QwGGfY6D1K9zKXl6TgRDViN+PyDWJ/r1NB91ohVyl0JW0Vwz
         MBVEkI46LXAI/MmY2eF8SBEguBeTHMkhOlGdFP+vi83bypmupWM9FtLm5xvuoNOczfNZ
         iRYcPVpkcP5clbdR4KNI/0ueF01korJZOvj127tEgrHVR7XTxU+QD/6sF+WEo3cZOL6z
         AGoQydJMoZOFMgYuEA5rbw3K7TjkcWmaonuGIbzTJSZmkBPM/Fkpfzvao3bwWJ2rZ3BK
         1WQd92OaUPCiBe8Y+CsSH5MtHaF7MqkpKm4EIf3YYTLtODfnJB5b/9SlHNlspnIJC8lf
         n+3Q==
X-Gm-Message-State: APjAAAV4JkPDnj7yQFuXSvbwIhih4EyrGz9wN+UdWgpJkXL11K3lU33V
        UJls5yABWWr/POhdLhKFUmTOQaNHPEeFtUwO0EbEJA==
X-Google-Smtp-Source: APXvYqwUQPkud8m3pn3JD+iQBOJ9pDvE11srZt37VrKVieKqD5k2pI6Be57Z3epvvVVDV/zbKoPQvn8POiUVFTV1Zn8=
X-Received: by 2002:a5d:4ecb:: with SMTP id s11mr16468225wrv.323.1566189866336;
 Sun, 18 Aug 2019 21:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190818082935.14869-1-hch@lst.de>
In-Reply-To: <20190818082935.14869-1-hch@lst.de>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 19 Aug 2019 10:14:14 +0530
Message-ID: <CAAhSdy18rh+3nSrpeMPoxmi_St4FUEy=48oPZmDnOndWUFegbg@mail.gmail.com>
Subject: Re: [PATCH] riscv: move sifive_l2_cache.c to drivers/soc
To:     Christoph Hellwig <hch@lst.de>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-edac@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Aug 18, 2019 at 2:01 PM Christoph Hellwig <hch@lst.de> wrote:
>
> The sifive_l2_cache.c is in no way related to RISC-V architecture
> memory management.  It is a little stub driver working around the fact
> that the EDAC maintainers prefer their drivers to be structured in a
> certain way that doesn't fit the SiFive SOCs.
>
> Move the file to drivers/soc and add a Kconfig option for it, as well
> as the whole drivers/soc boilerplate for CONFIG_SOC_SIFIVE.
>
> Fixes: a967a289f169 ("RISC-V: sifive_l2_cache: Add L2 cache controller driver for SiFive SoCs")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/riscv/mm/Makefile                                 |  1 -
>  drivers/edac/Kconfig                                   |  2 +-
>  drivers/soc/Kconfig                                    |  1 +
>  drivers/soc/Makefile                                   |  1 +
>  drivers/soc/sifive/Kconfig                             | 10 ++++++++++
>  drivers/soc/sifive/Makefile                            |  4 ++++
>  .../riscv/mm => drivers/soc/sifive}/sifive_l2_cache.c  |  0
>  7 files changed, 17 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/soc/sifive/Kconfig
>  create mode 100644 drivers/soc/sifive/Makefile
>  rename {arch/riscv/mm => drivers/soc/sifive}/sifive_l2_cache.c (100%)
>
> diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
> index 74055e1d6f21..d2101d0741d4 100644
> --- a/arch/riscv/mm/Makefile
> +++ b/arch/riscv/mm/Makefile
> @@ -11,6 +11,5 @@ obj-y += extable.o
>  obj-y += ioremap.o
>  obj-y += cacheflush.o
>  obj-y += context.o
> -obj-y += sifive_l2_cache.o
>
>  obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 200c04ce5b0e..9241b3e7a050 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -462,7 +462,7 @@ config EDAC_ALTERA_SDMMC
>
>  config EDAC_SIFIVE
>         bool "Sifive platform EDAC driver"
> -       depends on EDAC=y && RISCV
> +       depends on EDAC=y && SIFIVE_L2
>         help
>           Support for error detection and correction on the SiFive SoCs.
>
> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> index 833e04a7835c..1778f8c62861 100644
> --- a/drivers/soc/Kconfig
> +++ b/drivers/soc/Kconfig
> @@ -14,6 +14,7 @@ source "drivers/soc/qcom/Kconfig"
>  source "drivers/soc/renesas/Kconfig"
>  source "drivers/soc/rockchip/Kconfig"
>  source "drivers/soc/samsung/Kconfig"
> +source "drivers/soc/sifive/Kconfig"
>  source "drivers/soc/sunxi/Kconfig"
>  source "drivers/soc/tegra/Kconfig"
>  source "drivers/soc/ti/Kconfig"
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index 2ec355003524..8b49d782a1ab 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -20,6 +20,7 @@ obj-y                         += qcom/
>  obj-y                          += renesas/
>  obj-$(CONFIG_ARCH_ROCKCHIP)    += rockchip/
>  obj-$(CONFIG_SOC_SAMSUNG)      += samsung/
> +obj-$(CONFIG_SOC_SIFIVE)       += sifive/
>  obj-y                          += sunxi/
>  obj-$(CONFIG_ARCH_TEGRA)       += tegra/
>  obj-y                          += ti/
> diff --git a/drivers/soc/sifive/Kconfig b/drivers/soc/sifive/Kconfig
> new file mode 100644
> index 000000000000..9ffb2e8a48cd
> --- /dev/null
> +++ b/drivers/soc/sifive/Kconfig
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +if SOC_SIFIVE
> +
> +config SIFIVE_L2
> +       tristate "Sifive L2 Cache controller"
> +       help
> +         Support for the L2 cache controller on SiFive platforms.
> +
> +endif
> diff --git a/drivers/soc/sifive/Makefile b/drivers/soc/sifive/Makefile
> new file mode 100644
> index 000000000000..9b4a85558347
> --- /dev/null
> +++ b/drivers/soc/sifive/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_SIFIVE_L2)        += sifive_l2_cache.o
> +
> diff --git a/arch/riscv/mm/sifive_l2_cache.c b/drivers/soc/sifive/sifive_l2_cache.c
> similarity index 100%
> rename from arch/riscv/mm/sifive_l2_cache.c
> rename to drivers/soc/sifive/sifive_l2_cache.c
> --
> 2.20.1
>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
