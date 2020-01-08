Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2D60133CF0
	for <lists+linux-edac@lfdr.de>; Wed,  8 Jan 2020 09:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgAHIRd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 8 Jan 2020 03:17:33 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35278 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgAHIRc (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 8 Jan 2020 03:17:32 -0500
Received: by mail-wr1-f65.google.com with SMTP id g17so2363875wro.2
        for <linux-edac@vger.kernel.org>; Wed, 08 Jan 2020 00:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=abwTz2beL2gLghCfDY6LQgHixzJKFXuNxR9Ws8d7RDM=;
        b=aI0ASofZ8Mua6VCbXQHpsVOKk4LmrksJUB9HHWJ4R//7YVTf+AUhqMkWJH0W9VehP8
         hO4J7xnWfhFJ3/BjgARnjAydkUNLG6miKqZXznSTmYG7NbXK/nCVrNLCgMgMDgwZW17h
         //+Qlu+yDH80bAB+zotUnImUeyCrF9shYMSmq5TxYR+EcUA9NiQwKAyiiJ3qw9kw6LAY
         gdy7z21xh2Qa9I2UJPvmYXXDxdKMod6+yjf1nzPgX1eWzeSCDQhhxqEnQovgazaNQfCM
         qQBVz3rFWrQyGcD678n9tQ0zwItTkphu7bT8QJNWvgAOvheUlsYrjQA5omq0vUDdpVS1
         gUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=abwTz2beL2gLghCfDY6LQgHixzJKFXuNxR9Ws8d7RDM=;
        b=Ld0JkV5J3dgBawQ7e7TXGyTGCgarBvDKcYRfrJRL1bpok/ALe+V6GKiu8ATZ8GEi8z
         9WGgWAd0EuRPsr7kSlfYBnC4geA8esRTcuaiCa/R46PU2aHXlMh0Hwf9+Pmk341OyXo7
         /hrCnn1zNnhIufTBNhhJTf0UZLgSKF98hMN82q1sF8dfSpKc9oElB8tzKFlEdHLAOPjZ
         R7ew9/B+Y5ILE43eR1cspkrkt4qN+qwmde4N58d8kMKTfXwGkSz7bfWfx0LK+p1axPkO
         /wLTGf7hjb4tHwZMlWxa5+RllZ45+8u1oJd9bS10HF0iUqtx0Hslb+VEj2gEm6uhdkGB
         MPHg==
X-Gm-Message-State: APjAAAVDD966qjMSvw+oGYej2IlRjPk/pkhUiUA7tRub0mBcyYJ/VGIX
        w4PopDo56H9RXdbye+51K7MwUuAK6te/k2hPigC9fg==
X-Google-Smtp-Source: APXvYqz5y0daA1TT4hH3Zv+jz1/iOuMW0TLllfiMXuVE3LIZXrDCM1nG4BRrP8A84+6/wpPPnvOZ98XBmvbco7MQBPg=
X-Received: by 2002:adf:d850:: with SMTP id k16mr2893460wrl.96.1578471450572;
 Wed, 08 Jan 2020 00:17:30 -0800 (PST)
MIME-Version: 1.0
References: <1578463746-25279-1-git-send-email-yash.shah@sifive.com>
In-Reply-To: <1578463746-25279-1-git-send-email-yash.shah@sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 8 Jan 2020 13:47:19 +0530
Message-ID: <CAAhSdy2UAAQrzD4mgbAu1p022YLLLhUX2dJjYomyiTifoE0mBg@mail.gmail.com>
Subject: Re: [PATCH] riscv: move sifive_l2_cache.h to include/soc
To:     Yash Shah <yash.shah@sifive.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Borislav Petkov <bp@alien8.de>, mchehab@kernel.org,
        tony.luck@intel.com, James Morse <james.morse@arm.com>,
        rrichter@marvell.com,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-edac@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jan 8, 2020 at 11:39 AM Yash Shah <yash.shah@sifive.com> wrote:
>
> The commit 9209fb51896f ("riscv: move sifive_l2_cache.c to drivers/soc")
> moves the sifive L2 cache driver to driver/soc. It did not move the
> header file along with the driver. Therefore this patch moves the header
> file to driver/soc
>
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> ---
>  arch/riscv/include/asm/sifive_l2_cache.h | 16 ----------------
>  drivers/edac/sifive_edac.c               |  2 +-
>  drivers/soc/sifive/sifive_l2_cache.c     |  2 +-
>  include/soc/sifive/sifive_l2_cache.h     | 16 ++++++++++++++++
>  4 files changed, 18 insertions(+), 18 deletions(-)
>  delete mode 100644 arch/riscv/include/asm/sifive_l2_cache.h
>  create mode 100644 include/soc/sifive/sifive_l2_cache.h
>
> diff --git a/arch/riscv/include/asm/sifive_l2_cache.h b/arch/riscv/include/asm/sifive_l2_cache.h
> deleted file mode 100644
> index 04f6748..0000000
> --- a/arch/riscv/include/asm/sifive_l2_cache.h
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * SiFive L2 Cache Controller header file
> - *
> - */
> -
> -#ifndef _ASM_RISCV_SIFIVE_L2_CACHE_H
> -#define _ASM_RISCV_SIFIVE_L2_CACHE_H
> -
> -extern int register_sifive_l2_error_notifier(struct notifier_block *nb);
> -extern int unregister_sifive_l2_error_notifier(struct notifier_block *nb);
> -
> -#define SIFIVE_L2_ERR_TYPE_CE 0
> -#define SIFIVE_L2_ERR_TYPE_UE 1
> -
> -#endif /* _ASM_RISCV_SIFIVE_L2_CACHE_H */
> diff --git a/drivers/edac/sifive_edac.c b/drivers/edac/sifive_edac.c
> index 413cdb4..c0cc72a 100644
> --- a/drivers/edac/sifive_edac.c
> +++ b/drivers/edac/sifive_edac.c
> @@ -10,7 +10,7 @@
>  #include <linux/edac.h>
>  #include <linux/platform_device.h>
>  #include "edac_module.h"
> -#include <asm/sifive_l2_cache.h>
> +#include <soc/sifive/sifive_l2_cache.h>
>
>  #define DRVNAME "sifive_edac"
>
> diff --git a/drivers/soc/sifive/sifive_l2_cache.c b/drivers/soc/sifive/sifive_l2_cache.c
> index a9ffff3..a506939 100644
> --- a/drivers/soc/sifive/sifive_l2_cache.c
> +++ b/drivers/soc/sifive/sifive_l2_cache.c
> @@ -9,7 +9,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_address.h>
> -#include <asm/sifive_l2_cache.h>
> +#include <soc/sifive/sifive_l2_cache.h>
>
>  #define SIFIVE_L2_DIRECCFIX_LOW 0x100
>  #define SIFIVE_L2_DIRECCFIX_HIGH 0x104
> diff --git a/include/soc/sifive/sifive_l2_cache.h b/include/soc/sifive/sifive_l2_cache.h
> new file mode 100644
> index 0000000..04f6748
> --- /dev/null
> +++ b/include/soc/sifive/sifive_l2_cache.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * SiFive L2 Cache Controller header file
> + *
> + */
> +
> +#ifndef _ASM_RISCV_SIFIVE_L2_CACHE_H
> +#define _ASM_RISCV_SIFIVE_L2_CACHE_H
> +
> +extern int register_sifive_l2_error_notifier(struct notifier_block *nb);
> +extern int unregister_sifive_l2_error_notifier(struct notifier_block *nb);
> +
> +#define SIFIVE_L2_ERR_TYPE_CE 0
> +#define SIFIVE_L2_ERR_TYPE_UE 1
> +
> +#endif /* _ASM_RISCV_SIFIVE_L2_CACHE_H */
> --
> 2.7.4
>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
