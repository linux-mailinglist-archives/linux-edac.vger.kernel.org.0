Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F92B322372
	for <lists+linux-edac@lfdr.de>; Tue, 23 Feb 2021 02:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbhBWBSM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Feb 2021 20:18:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:37002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230235AbhBWBSL (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 22 Feb 2021 20:18:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8BD964E3F;
        Tue, 23 Feb 2021 01:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614043050;
        bh=DvI7TUFaDLZnB8qd1iG9VUOA9R6SUoQ69R1EwEdcZMM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iEWnlPr39RLT/glEz55wiDthJseWcOOd7pGxMulUuuw/aVUol7QGBLXJc7ESQhlq5
         a3J/CQCFp9ArKvXJv3VnKqkxbM9zcG5aezsNFELKmtYzgNTQjjtVW+s1lvM2g14v5R
         kwN/kacQXzbqfkWu6+ge/NGedvHQ3mm8emopJNbtkmQMZAqM25R/osysxmUz6G2MD4
         XRL2kVHecT/wJsfizFv5DEyWn5IvuJEWglKjoT78QizCJNNVYAaJROs5VNIjIsHDeo
         QIY92qYPrbSRmiJJg/b6PUw7+bEtl1JAo0SnUOQt3HfBcrj+y04/afoDpKdD+P9rfY
         vq6QrdgsZZkLQ==
Received: by mail-io1-f48.google.com with SMTP id u20so15386211iot.9;
        Mon, 22 Feb 2021 17:17:30 -0800 (PST)
X-Gm-Message-State: AOAM532WYuEwi7K/rxMH3Ycy+NSaWfsMYmgiKYCI45QTLZZJnabTyhQD
        VQBBdw0LGNeLr9s/2914sHt6RbjvdNcIofaUuCQ=
X-Google-Smtp-Source: ABdhPJxeAJEHzXuZoV9sLeUvmUJ7b64ZWK/ioFw5Bel+3a7zaxSdBMePbVEMSu3FRzydH+NpRl52Jax8st22Ohrw9VY=
X-Received: by 2002:a05:6638:22e:: with SMTP id f14mr11702213jaq.96.1614043050082;
 Mon, 22 Feb 2021 17:17:30 -0800 (PST)
MIME-Version: 1.0
References: <20210222161905.1153-1-lukas.bulwahn@gmail.com> <20210222161905.1153-4-lukas.bulwahn@gmail.com>
In-Reply-To: <20210222161905.1153-4-lukas.bulwahn@gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 23 Feb 2021 09:17:18 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5-a2PCbGiezQ5LNT3THBhWrcZnJys0NUZ8+1N9ivkBAw@mail.gmail.com>
Message-ID: <CAAhV-H5-a2PCbGiezQ5LNT3THBhWrcZnJys0NUZ8+1N9ivkBAw@mail.gmail.com>
Subject: Re: [PATCH 3/5] arch: mips: update references to current linux-mips list
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Tiezhu Yang <yangtiezhu@loongson.cn>, Willy Tarreau <w@1wt.eu>,
        linux-edac@vger.kernel.org, linux-hams@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Reviewed-by: Huacai Chen <chenhuacai@kernel.org>

On Tue, Feb 23, 2021 at 12:22 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> The linux-mips mailing list now lives at kernel.org. Update all references
> in the kernel tree.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  arch/mips/kernel/r4k-bugs64.c | 2 +-
>  arch/mips/lib/iomap-pci.c     | 2 +-
>  arch/mips/sgi-ip32/ip32-irq.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/mips/kernel/r4k-bugs64.c b/arch/mips/kernel/r4k-bugs64.c
> index 1ff19f1ea5ca..35729c9e6cfa 100644
> --- a/arch/mips/kernel/r4k-bugs64.c
> +++ b/arch/mips/kernel/r4k-bugs64.c
> @@ -18,7 +18,7 @@
>  static char bug64hit[] __initdata =
>         "reliable operation impossible!\n%s";
>  static char nowar[] __initdata =
> -       "Please report to <linux-mips@linux-mips.org>.";
> +       "Please report to <linux-mips@vger.kernel.org>.";
>  static char r4kwar[] __initdata =
>         "Enable CPU_R4000_WORKAROUNDS to rectify.";
>  static char daddiwar[] __initdata =
> diff --git a/arch/mips/lib/iomap-pci.c b/arch/mips/lib/iomap-pci.c
> index 210f5a95ecb1..a9cb28813f0b 100644
> --- a/arch/mips/lib/iomap-pci.c
> +++ b/arch/mips/lib/iomap-pci.c
> @@ -32,7 +32,7 @@ void __iomem *__pci_ioport_map(struct pci_dev *dev,
>                 sprintf(name, "%04x:%02x", pci_domain_nr(bus), bus->number);
>                 printk(KERN_WARNING "io_map_base of root PCI bus %s unset.  "
>                        "Trying to continue but you better\nfix this issue or "
> -                      "report it to linux-mips@linux-mips.org or your "
> +                      "report it to linux-mips@vger.kernel.org or your "
>                        "vendor.\n", name);
>  #ifdef CONFIG_PCI_DOMAINS
>                 panic("To avoid data corruption io_map_base MUST be set with "
> diff --git a/arch/mips/sgi-ip32/ip32-irq.c b/arch/mips/sgi-ip32/ip32-irq.c
> index 1bbd5bfb5458..e21ea1de05e3 100644
> --- a/arch/mips/sgi-ip32/ip32-irq.c
> +++ b/arch/mips/sgi-ip32/ip32-irq.c
> @@ -343,7 +343,7 @@ static void ip32_unknown_interrupt(void)
>         printk("Register dump:\n");
>         show_regs(get_irq_regs());
>
> -       printk("Please mail this report to linux-mips@linux-mips.org\n");
> +       printk("Please mail this report to linux-mips@vger.kernel.org\n");
>         printk("Spinning...");
>         while(1) ;
>  }
> --
> 2.17.1
>
