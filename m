Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C184D2CB573
	for <lists+linux-edac@lfdr.de>; Wed,  2 Dec 2020 08:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgLBHCb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 2 Dec 2020 02:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgLBHCb (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 2 Dec 2020 02:02:31 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27281C0613CF;
        Tue,  1 Dec 2020 23:01:45 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id dm12so269738qvb.3;
        Tue, 01 Dec 2020 23:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MA2zJo9bj/EIZzJG0XmMx/IZDBJAL5UetxtUGnb1JcE=;
        b=aBFCXZNYzdc6s0fqQRq03Fap97IXfUONqVQg+WwwECxF143wymeGH5G8zL9AWOZCSZ
         3scwloDVjjHtmgPlPSgWZdGhGAY+5nUQxQDMQ44aMQDEWts2u7mQ/TKbz6rFL3pQNcjb
         jWXLMnNqZHtxnkuWGlsg25PRob8WZcqoB24zE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MA2zJo9bj/EIZzJG0XmMx/IZDBJAL5UetxtUGnb1JcE=;
        b=nb6zQCoR3rW67lMIkbi7JNXMRcUJaqMlYSBeS81GbXTemjaANgtZJBcmY1nXtVktsh
         dGegOJGlwgdWJ8RKhFXgo37Z4+Jge/UrfOfNKXGwmmIH2MZoWSDVGsoGI8vzpix2n4HG
         eQo1xAyzskUsJGaPtDhxDiHdINh78cSY3b8krvXby0hA/8308ht5IlSsLHtohvbl0uLG
         3WtSOCsF1nLWVlVIKDrWl/JFS1Arl9BZJC6G2wW4bVBtZBLrtjuOW9vHcNyeKqzXBtni
         g+2rXL3eNYJZAmDh1gNUAzhFs7WEPOTkx2cHK2+HQxgaC1oqfV5K81Gr4iZvrWuWfpds
         sHMw==
X-Gm-Message-State: AOAM5302qluUTx+28IXYBvF4eLD16b3YvUqPQlK8lRVMdVL1O6ZnR4mS
        H5UojRgmFIQ2DNRSg28OaJ2u5blx/CJLxk2ILv0=
X-Google-Smtp-Source: ABdhPJwr1ikAABYLva9tQV6P42ObH2nWpxzGr7QZQK5w1rB8Fb6Ep334b2uhmyLtfItMHk49IniPr/zAGK29uoOqoyg=
X-Received: by 2002:ad4:5687:: with SMTP id bc7mr1039099qvb.61.1606892503587;
 Tue, 01 Dec 2020 23:01:43 -0800 (PST)
MIME-Version: 1.0
References: <20201202063612.21241-1-troy_lee@aspeedtech.com> <20201202063612.21241-3-troy_lee@aspeedtech.com>
In-Reply-To: <20201202063612.21241-3-troy_lee@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 2 Dec 2020 07:01:31 +0000
Message-ID: <CACPK8XcBTm8-cAPmtswHbYAf2B+PdBiZ2s1XK1UqKA_NQX_-mw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] edac: Supporting AST2400 and AST2600 edac driver
To:     Troy Lee <troy_lee@aspeedtech.com>
Cc:     Stefan Schaeckeler <sschaeck@cisco.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:EDAC-CORE" <linux-edac@vger.kernel.org>,
        leetroy@gmail.com, Ryan Chen <ryan_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, 2 Dec 2020 at 06:37, Troy Lee <troy_lee@aspeedtech.com> wrote:
>
> Adding AST2400 and AST2600 edac driver support.
>
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> ---
> Change since v1:
> 1. Removing SoC specific code
> 2. Changing numerical representation of memory sizing
> ---
>  drivers/edac/Kconfig       |   6 +--
>  drivers/edac/aspeed_edac.c | 103 +++++++++++++++++++++++++++++--------
>  2 files changed, 85 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index fc30f2ef9782..8ea70746d0bf 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -508,10 +508,10 @@ config EDAC_QCOM
>           health, you should probably say 'Y' here.
>
>  config EDAC_ASPEED
> -       tristate "Aspeed AST 2500 SoC"
> -       depends on MACH_ASPEED_G5
> +       tristate "Aspeed AST BMC SoC"
> +       depends on (MACH_ASPEED_G4 || MACH_ASPEED_G5 || MACH_ASPEED_G6)

Change this to ARCH_ASPEED.

>         help
> -         Support for error detection and correction on the Aspeed AST 2500 SoC.
> +         Support for error detection and correction on the Aspeed AST BMC SoC.
>
>           First, ECC must be configured in the bootloader. Then, this driver
>           will expose error counters via the EDAC kernel framework.
> diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
> index fbec28dc661d..b8c8d6a05f91 100644
> --- a/drivers/edac/aspeed_edac.c
> +++ b/drivers/edac/aspeed_edac.c
> @@ -14,12 +14,11 @@
>  #include <linux/regmap.h>
>  #include "edac_module.h"
>
> -

These whitespace cleanups are ok, but can probably go in a different
patch so they aren't mixed up with the functional changes.

>  #define DRV_NAME "aspeed-edac"
>
> -
>  #define ASPEED_MCR_PROT        0x00 /* protection key register */
>  #define ASPEED_MCR_CONF        0x04 /* configuration register */
> +#define ASPEED_MCR_REQ         0x08 /* Graphics Memory Protection register */
>  #define ASPEED_MCR_INTR_CTRL   0x50 /* interrupt control/status register */
>  #define ASPEED_MCR_ADDR_UNREC  0x58 /* address of first un-recoverable error */
>  #define ASPEED_MCR_ADDR_REC    0x5c /* address of last recoverable error */
> @@ -29,15 +28,17 @@
>  #define ASPEED_MCR_PROT_PASSWD             0xfc600309
>  #define ASPEED_MCR_CONF_DRAM_TYPE               BIT(4)
>  #define ASPEED_MCR_CONF_ECC                     BIT(7)
> +#define ASPEED_MCR_CONF_DRAM_CTRL_TYPE (BIT(28)|BIT(29)|BIT(30)|BIT(31))

We can use GENMASK here:

 GENMASK(31, 28)

>  #define ASPEED_MCR_INTR_CTRL_CLEAR             BIT(31)
>  #define ASPEED_MCR_INTR_CTRL_CNT_REC   GENMASK(23, 16)
>  #define ASPEED_MCR_INTR_CTRL_CNT_UNREC GENMASK(15, 12)
>  #define ASPEED_MCR_INTR_CTRL_ENABLE  (BIT(0) | BIT(1))
>
> +#define ASPEED_MCR_CONF_DRAM_CTRL_TYPE_AST2500  0x01
> +#define ASPEED_MCR_CONF_DRAM_CTRL_TYPE_AST2600  0x03
>
>  static struct regmap *aspeed_regmap;
>
> -
>  static int regmap_reg_write(void *context, unsigned int reg, unsigned int val)
>  {
>         void __iomem *regs = (void __iomem *)context;
> @@ -53,7 +54,6 @@ static int regmap_reg_write(void *context, unsigned int reg, unsigned int val)
>         return 0;
>  }
>
> -
>  static int regmap_reg_read(void *context, unsigned int reg, unsigned int *val)
>  {
>         void __iomem *regs = (void __iomem *)context;
> @@ -63,6 +63,79 @@ static int regmap_reg_read(void *context, unsigned int reg, unsigned int *val)
>         return 0;
>  }
>
> +extern void aspeed_sdmc_disable_mem_protection(u8 req)
> +{
> +       u32 req_val = 0;
> +
> +       regmap_read(aspeed_regmap, ASPEED_MCR_REQ, &req_val);
> +
> +       req_val &= ~BIT(req);
> +
> +       regmap_write(aspeed_regmap, ASPEED_MCR_REQ, req_val);

This is open coding regmap_update_bits:

  regmap_update_bits(aspeed_regmap, ASPEED_MCR_REQ, BIT(req), BIT(req));

> +}
> +EXPORT_SYMBOL(aspeed_sdmc_disable_mem_protection);

I don't think any of these functions need to be exported. The same
comment applies to the functions below this one; you can make them all
static and drop the extern and the EXPORT_SYMBOL.

> +
> +static const u32 ast2400_dram_table[] = {
> +       64 << 20,
> +       128 << 20,
> +       256 << 20,
> +       512 << 20,
> +};
> +
> +static const u32 ast2500_dram_table[] = {
> +       128 << 20,
> +       256 << 20,
> +       512 << 20,
> +       1024 << 20,
> +};
> +
> +static const u32 ast2600_dram_table[] = {
> +       256 << 20,
> +       512 << 20,
> +       1024 << 20,
> +       2048 << 20,
> +};
> +
> +extern u32 aspeed_get_dram_size(void)
> +{
> +       u32 reg04;
> +       u32 size;
> +       u8 type;
> +
> +       regmap_read(aspeed_regmap, ASPEED_MCR_CONF, &reg04);
> +
> +       type = (reg04 & ASPEED_MCR_CONF_DRAM_CTRL_TYPE) >> 28;
> +
> +       if (type == ASPEED_MCR_CONF_DRAM_CTRL_TYPE_AST2600)
> +               size = ast2600_dram_table[reg04 & 0x3];
> +       else if (type == ASPEED_MCR_CONF_DRAM_CTRL_TYPE_AST2500)
> +               size = ast2500_dram_table[reg04 & 0x3];
> +       else
> +               size = ast2400_dram_table[reg04 & 0x3];
> +
> +       return size;
> +}
> +EXPORT_SYMBOL(aspeed_get_dram_size);
> +
> +static const u32 aspeed_vga_table[] = {
> +       8 << 20,
> +       16 << 20,
> +       32 << 20,
> +       64 << 20,
> +};
> +
> +extern u32 aspeed_get_vga_size(void)
> +{
> +       u32 reg04;
> +       u32 size;
> +
> +       regmap_read(aspeed_regmap, ASPEED_MCR_CONF, &reg04);
> +
> +       size = aspeed_vga_table[((reg04 & 0xC) >> 2)];
> +       return size;

If you do this:

 return aspeed_vga_table[((reg04 & 0xC) >> 2)]

You can drop 'size'.

> +}
> +EXPORT_SYMBOL(aspeed_get_vga_size);
> +
>  static bool regmap_is_volatile(struct device *dev, unsigned int reg)
>  {
>         switch (reg) {
> @@ -227,7 +300,6 @@ static int config_irq(void *ctx, struct platform_device *pdev)
>         return 0;
>  }
>
> -
>  static int init_csrows(struct mem_ctl_info *mci)
>  {
>         struct csrow_info *csrow = mci->csrows[0];
> @@ -239,7 +311,7 @@ static int init_csrows(struct mem_ctl_info *mci)
>         int rc;
>
>         /* retrieve info about physical memory from device tree */
> -       np = of_find_node_by_path("/memory");
> +       np = of_find_node_by_name(NULL, "memory");
>         if (!np) {
>                 dev_err(mci->pdev, "dt: missing /memory node\n");
>                 return -ENODEV;
> @@ -275,14 +347,12 @@ static int init_csrows(struct mem_ctl_info *mci)
>         return 0;
>  }
>
> -
>  static int aspeed_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
>         struct edac_mc_layer layers[2];
>         struct mem_ctl_info *mci;
>         void __iomem *regs;
> -       u32 reg04;
>         int rc;
>
>         regs = devm_platform_ioremap_resource(pdev, 0);
> @@ -294,13 +364,6 @@ static int aspeed_probe(struct platform_device *pdev)
>         if (IS_ERR(aspeed_regmap))
>                 return PTR_ERR(aspeed_regmap);
>
> -       /* bail out if ECC mode is not configured */
> -       regmap_read(aspeed_regmap, ASPEED_MCR_CONF, &reg04);
> -       if (!(reg04 & ASPEED_MCR_CONF_ECC)) {
> -               dev_err(&pdev->dev, "ECC mode is not configured in u-boot\n");
> -               return -EPERM;
> -       }
> -
>         edac_op_state = EDAC_OPSTATE_INT;
>
>         /* allocate & init EDAC MC data structure */
> @@ -373,12 +436,13 @@ static int aspeed_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> -
>  static const struct of_device_id aspeed_of_match[] = {
> +       { .compatible = "aspeed,ast2400-sdram-edac" },
>         { .compatible = "aspeed,ast2500-sdram-edac" },
> +       { .compatible = "aspeed,ast2600-sdram-edac" },
>         {},
>  };
> -
> +MODULE_DEVICE_TABLE(of, aspeed_of_match);
>
>  static struct platform_driver aspeed_driver = {
>         .driver         = {
> @@ -395,18 +459,15 @@ static int __init aspeed_init(void)
>         return platform_driver_register(&aspeed_driver);
>  }
>
> -
>  static void __exit aspeed_exit(void)
>  {
>         platform_driver_unregister(&aspeed_driver);
>  }
>
> -
>  module_init(aspeed_init);
>  module_exit(aspeed_exit);

Unrelated, you can clean up the above 6 lines with module_platform_driver().

Actually, looking at the kernel tree this was already done in v5.9.
Please send your next version based on the latest kernel, eg
v5.10-rc1.

Cheers,

Joel

>
> -
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Stefan Schaeckeler <sschaeck@cisco.com>");
> -MODULE_DESCRIPTION("Aspeed AST2500 EDAC driver");
> +MODULE_DESCRIPTION("Aspeed EDAC driver");
>  MODULE_VERSION("1.0");
> --
> 2.17.1
>
