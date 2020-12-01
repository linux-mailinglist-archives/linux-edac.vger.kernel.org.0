Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7E62C9E1B
	for <lists+linux-edac@lfdr.de>; Tue,  1 Dec 2020 10:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgLAJiE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Tue, 1 Dec 2020 04:38:04 -0500
Received: from mail-eopbgr1300138.outbound.protection.outlook.com ([40.107.130.138]:34473
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725955AbgLAJiE (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 1 Dec 2020 04:38:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwOisIr557I4urYrvRluOlTlrUOfeewfDwOB1gMwnSqb6MCW6dCM7JxWsIrtrED6HUhDY42CYPJD3xwrTJU9+rqKkW7EygE6bt4xX7QbmK4Wtb5Z9oEbUnk8KL3FTz8RTQQwtCZBSWpiVwnZpV8TY/udCC//fMXlYp04Zu2jN5ZNVNfNC12rVIeBGugJR7Slw3PP407mpA1NtjU1JBh/+Q1pya6ugIqdr4mPIiqzEHIUOhRLshlyqVlHths1cxRoHhp3heiD6vuaodMd1++SrKLCszVul6urFwuMNuywBlnxslRwqwR0OZpEMVfVqBIH9pUBxWEawXrdfuJscVSzNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akPEsnARS/1rqXyDYJ+ZBFJqw9b/DzwLclcllG1TZNI=;
 b=jHjIZe6LiDUR78ngTEHfUS0bi5qy/ztV57ne7x0lLq1jBaX2PBeUB9pFYY7Df4fQJ8j/iM1rB0qLu4b1kf1dCFMmwpIFRz1f4OZOUOP7wq5+6EQq0by9XLl2s3e8Dnkv++XhSpFPj6NIzEeFdx6AOi7IWE8SKiuexfz1TZ4GDqRys+IbZRS7LBzJk7cWlan7OyoawbIv0T23YTrvl4a4d0fC1vRrYrMEy38EtTgldtGg+7HAgFdULgBp7pNF+AMFNSi4NiYOVU3yWGUIRo735rxvzhWYzC/Dmt/ilGXiC8VABzfdHZyeBYCySEsC+InSxhlXrvZ3tbgC222ab2BBzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
Received: from PS1PR06MB2600.apcprd06.prod.outlook.com (2603:1096:803:4d::19)
 by PS1PR06MB2629.apcprd06.prod.outlook.com (2603:1096:803:4a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.31; Tue, 1 Dec
 2020 09:36:26 +0000
Received: from PS1PR06MB2600.apcprd06.prod.outlook.com
 ([fe80::7d57:cb3c:146c:36e3]) by PS1PR06MB2600.apcprd06.prod.outlook.com
 ([fe80::7d57:cb3c:146c:36e3%4]) with mapi id 15.20.3611.031; Tue, 1 Dec 2020
 09:36:26 +0000
From:   Troy Lee <troy_lee@aspeedtech.com>
To:     Andrew Jeffery <andrew@aj.id.au>,
        Stefan M Schaeckeler <sschaeck@cisco.com>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Borislav Petkov <bp@alien8.de>,
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
        "open list:EDAC-CORE" <linux-edac@vger.kernel.org>
CC:     "leetroy@gmail.com" <leetroy@gmail.com>,
        Ryan Chen <ryan_chen@aspeedtech.com>
Subject: RE: [PATCH 3/3] edac: Supporting AST2400 and AST2600 edac driver
Thread-Topic: [PATCH 3/3] edac: Supporting AST2400 and AST2600 edac driver
Thread-Index: AQHWxvOZHTlrFWqSykaazJ8oPL0cyKnhb/yAgABzVqA=
Date:   Tue, 1 Dec 2020 09:36:26 +0000
Message-ID: <PS1PR06MB2600A3B6B961FAA7BB5621878AF40@PS1PR06MB2600.apcprd06.prod.outlook.com>
References: <20201130083345.4814-1-troy_lee@aspeedtech.com>
 <20201130083345.4814-3-troy_lee@aspeedtech.com>
 <d6138f1e-f054-4a1e-8c49-f0c32a9352e8@www.fastmail.com>
In-Reply-To: <d6138f1e-f054-4a1e-8c49-f0c32a9352e8@www.fastmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: aj.id.au; dkim=none (message not signed)
 header.d=none;aj.id.au; dmarc=none action=none header.from=aspeedtech.com;
x-originating-ip: [118.99.190.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 092f84cf-4acc-40fb-fb13-08d895dc931e
x-ms-traffictypediagnostic: PS1PR06MB2629:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PS1PR06MB262962C9F4C53FB215969DA18AF40@PS1PR06MB2629.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9sCWX3a2x4+9posQMk1oih38YmGe5eEopi0oErKk41NjJ7Bv9Ujh2PZvcbwWzqyYPtvLqH1ofJAY+goIs0jM23Su5AhJG+SWl6AjyT/fohYxna5WsVEFCn9lRE7qKIPoZ5gTao8vsimzZkxJBZKaX73nJ7/j0KlonvPYBOSLoT9EHkwIz/1CsqREiuZSiGAq8Sj7FRNgQ42uTXKWsF9GuvWiWdNX+Vnn7B26DI4+v9CYJG6TTQVrx3xgAw1cyLffzVkSKWUrv7x5wbo31KJ8zsn4mCT42qhiPdUeo4/3AjSLN2fZCm/wmku88oUOb+VXafYeK/Z+z1jpM7GwleQEuyNGbc5C2ZL2clzvv/CU5PoM+zhq+o74hUAa+MQ+kPdk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR06MB2600.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(136003)(346002)(366004)(396003)(376002)(7696005)(8676002)(2906002)(83380400001)(110136005)(33656002)(9686003)(316002)(6506007)(71200400001)(53546011)(54906003)(55016002)(7416002)(107886003)(52536014)(86362001)(8936002)(478600001)(26005)(5660300002)(4326008)(64756008)(66946007)(76116006)(66556008)(66476007)(921005)(66446008)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?mTAx3n2L8JSOBOlYYWFn4SLQE7CeqvOIoq3uFt6FuarJFph8SqZz+RCp7FC+?=
 =?us-ascii?Q?yvjsOfnRAmXcU/asGhx763MjFmw/dW0WVg/RadtH4CERBWpIKNbZXhJOzGls?=
 =?us-ascii?Q?wynm2jBDEEBnL9TOwDEuMGpaYuekf2X4CvoM3ht3iMXbFwopoIXJ9a82Yc4D?=
 =?us-ascii?Q?ilU7yHDHndyb8oTp4ewpvGyxVOMmQW/DsZVv/BFlDSGG9b/G/QGeaJGjzUWc?=
 =?us-ascii?Q?y5oyjMWxTOUe81GCNEuVJB+HGVmGfjmGJtifruFw8Hd+eVlNid1OGVR0BsUb?=
 =?us-ascii?Q?X/ldbru0fpdXywsomyTDVTvS5yh8hF+K+SU749JXHZCoFnqB17FKi3GMTul0?=
 =?us-ascii?Q?7a+Yq5yxN7xTswREV90qURdZggKVQC66afTDMI6bQISwqLEWKX5O4KmfzWUv?=
 =?us-ascii?Q?C49dLFGITdBO6r3GrFTjylAvPJfpBBNjDY9TJV9uQjlWmYVRjR0jAjLD7YuO?=
 =?us-ascii?Q?zjCimwvgcY1IQGq6geZBTvX/RBQrOQvUH3+Bta/FciRBBIpjT3LzjZc2pgpi?=
 =?us-ascii?Q?Kdx+WGttM0iCg9TSea1RzOuA1YRfmoJQCPLeRb5T8tFFzP/s3myTTyMQCRiK?=
 =?us-ascii?Q?WJGVdl03Km1QFgTbC2ckdXGEn8HgEBc6a09fl5+L4uB7uz0wUVtcXbT0p0ng?=
 =?us-ascii?Q?6VpgoiWRJomlD7VF/CpSxc/ySmYYn02k2/+2RRalzl64uQbdxWoLU6e4jzr3?=
 =?us-ascii?Q?QNU22HYY2arY0WSsMj+aPMIvYpSF+TwxHJlOLXWbak2xNYuI8M/8RUw9t6GO?=
 =?us-ascii?Q?G7y96FpXkNzoRD56WTCPuUy/vIz6JVncJ2V4DmA0nN4XkT3BUCeub7aAkQgp?=
 =?us-ascii?Q?ijmVbaZZef4W7IZP80bxwvtmTUAykgG0naJcsY76xmQxfqyZTbwI4ZasKdcu?=
 =?us-ascii?Q?hv3q/5HdZiloyI/WN1VZta49cZ0/GBlsUDpSy6LjcPGjQ3SaSQqGjdhcItnk?=
 =?us-ascii?Q?nem1lU0Gxjk3VxnuRlNXoeQa0c63/8xf4uKlDZTYyjk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS1PR06MB2600.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 092f84cf-4acc-40fb-fb13-08d895dc931e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 09:36:26.5470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TBHbKq4fKJeRO+Ck3LBGD13dSn4/kM1L/42Aoj/EDGrl4L3JbDqHAUF6yWdROxgZC2a8vgH/JVdilMxLuZ6Plw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PR06MB2629
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Andrew,

Great suggestion, responses inline below. We'll remove build-time SoC dependency driver code and submit an updated v2 patch.

Thanks,
Troy Lee

> -----Original Message-----
> From: Andrew Jeffery <andrew@aj.id.au>
> Sent: Tuesday, December 1, 2020 9:12 AM
> To: Troy Lee <troy_lee@aspeedtech.com>; Stefan M Schaeckeler
> <sschaeck@cisco.com>; Rob Herring <robh+dt@kernel.org>; Joel Stanley
> <joel@jms.id.au>; Borislav Petkov <bp@alien8.de>; Mauro Carvalho Chehab
> <mchehab@kernel.org>; Tony Luck <tony.luck@intel.com>; James Morse
> <james.morse@arm.com>; Robert Richter <rrichter@marvell.com>; open
> list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> <devicetree@vger.kernel.org>; moderated list:ARM/ASPEED MACHINE
> SUPPORT <linux-arm-kernel@lists.infradead.org>; moderated
> list:ARM/ASPEED MACHINE SUPPORT <linux-aspeed@lists.ozlabs.org>; open
> list <linux-kernel@vger.kernel.org>; open list:EDAC-CORE
> <linux-edac@vger.kernel.org>
> Cc: leetroy@gmail.com; Ryan Chen <ryan_chen@aspeedtech.com>
> Subject: Re: [PATCH 3/3] edac: Supporting AST2400 and AST2600 edac driver
> 
> Hi Troy,
> 
> I like the idea of expanding the driver's support to cover the other SoC
> generations, but not at the cost of making the build of the driver SoC-specific.
> I've made some comments below in this regard.
> 
> On Mon, 30 Nov 2020, at 19:03, Troy Lee wrote:
> > Adding AST2400 and AST2600 edac driver support.
> >
> > Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> > ---
> >  drivers/edac/Kconfig       |   6 +-
> >  drivers/edac/aspeed_edac.c | 114
> > +++++++++++++++++++++++++++++--------
> >  2 files changed, 94 insertions(+), 26 deletions(-)
> >
> > diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig index
> > fc30f2ef9782..8ea70746d0bf 100644
> > --- a/drivers/edac/Kconfig
> > +++ b/drivers/edac/Kconfig
> > @@ -508,10 +508,10 @@ config EDAC_QCOM
> >  	  health, you should probably say 'Y' here.
> >
> >  config EDAC_ASPEED
> > -	tristate "Aspeed AST 2500 SoC"
> > -	depends on MACH_ASPEED_G5
> > +	tristate "Aspeed AST BMC SoC"
> > +	depends on (MACH_ASPEED_G4 || MACH_ASPEED_G5 ||
> MACH_ASPEED_G6)
> >  	help
> > -	  Support for error detection and correction on the Aspeed AST 2500 SoC.
> > +	  Support for error detection and correction on the Aspeed AST BMC SoC.
> >
> >  	  First, ECC must be configured in the bootloader. Then, this driver
> >  	  will expose error counters via the EDAC kernel framework.
> > diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
> > index fbec28dc661d..03a3c12f6bf6 100644
> > --- a/drivers/edac/aspeed_edac.c
> > +++ b/drivers/edac/aspeed_edac.c
> > @@ -14,12 +14,11 @@
> >  #include <linux/regmap.h>
> >  #include "edac_module.h"
> >
> > -
> >  #define DRV_NAME "aspeed-edac"
> >
> > -
> >  #define ASPEED_MCR_PROT        0x00 /* protection key register */
> >  #define ASPEED_MCR_CONF        0x04 /* configuration register */
> > +#define ASPEED_MCR_REQ         0x08 /* Graphics Memory Protection
> register */
> >  #define ASPEED_MCR_INTR_CTRL   0x50 /* interrupt control/status
> register */
> >  #define ASPEED_MCR_ADDR_UNREC  0x58 /* address of first
> un-recoverable error */
> >  #define ASPEED_MCR_ADDR_REC    0x5c /* address of last recoverable
> error */
> > @@ -34,10 +33,8 @@
> >  #define ASPEED_MCR_INTR_CTRL_CNT_UNREC GENMASK(15, 12)
> #define
> > ASPEED_MCR_INTR_CTRL_ENABLE  (BIT(0) | BIT(1))
> >
> > -
> >  static struct regmap *aspeed_regmap;
> >
> > -
> >  static int regmap_reg_write(void *context, unsigned int reg, unsigned
> > int val)  {
> >  	void __iomem *regs = (void __iomem *)context; @@ -53,7 +50,6 @@
> > static int regmap_reg_write(void *context, unsigned int reg, unsigned
> > int val)
> >  	return 0;
> >  }
> >
> > -
> >  static int regmap_reg_read(void *context, unsigned int reg, unsigned
> > int *val)  {
> >  	void __iomem *regs = (void __iomem *)context; @@ -63,6 +59,76 @@
> > static int regmap_reg_read(void *context, unsigned int reg, unsigned
> > int *val)
> >  	return 0;
> >  }
> >
> > +extern void aspeed_sdmc_disable_mem_protection(u8 req) {
> > +	u32 req_val = 0;
> > +
> > +	regmap_read(aspeed_regmap, ASPEED_MCR_REQ, &req_val);
> > +
> > +	req_val &= ~BIT(req);
> > +
> > +	regmap_write(aspeed_regmap, ASPEED_MCR_REQ, req_val); }
> > +EXPORT_SYMBOL(aspeed_sdmc_disable_mem_protection);
> > +
> > +static const u32 ast2400_dram_table[] = {
> > +	0x04000000,	//64MB
> > +	0x08000000,	//128MB
> > +	0x10000000,	//256MB
> > +	0x20000000,	//512MB
> > +};
> 
> You could perhaps save us from the size comments here by using e.g.
> 
> static const u32 ast2400_dram_table[] = {
>     64 << 20,
>     128 << 20,
>     256 << 20,
>     512 << 20,
> };
> 
Fixed all in v2.

> > +
> > +static const u32 ast2500_dram_table[] = {
> > +	0x08000000,	//128MB
> > +	0x10000000,	//256MB
> > +	0x20000000,	//512MB
> > +	0x40000000,	//1024MB
> > +};
> > +
> > +static const u32 ast2600_dram_table[] = {
> > +	0x10000000,	//256MB
> > +	0x20000000,	//512MB
> > +	0x40000000,	//1024MB
> > +	0x80000000,	//2048MB
> > +};
> > +
> > +extern u32 aspeed_get_dram_size(void) {
> > +	u32 reg04;
> > +	u32 size;
> > +
> > +	regmap_read(aspeed_regmap, ASPEED_MCR_CONF, &reg04);
> > +
> > +#if defined(CONFIG_MACH_ASPEED_G6)
> > +	size = ast2600_dram_table[reg04 & 0x3]; #elif
> > +defined(CONFIG_MACH_ASPEED_G5)
> > +	size = ast2500_dram_table[reg04 & 0x3]; #else
> > +	size = ast2400_dram_table[reg04 & 0x3]; #endif
> > +	return size;
> > +}
> > +EXPORT_SYMBOL(aspeed_get_dram_size);
> 
> The driver must support running on any of the SoC generations without being
> recompiled. This requires the driver be compiled for a specific SoC generation.
> 
> The right way to do this is to use the OF match table data. Please fix it.
> 
Fixed in v2, driver can check the DRAM controller hardware version from MCR_CONF [31:28].

> > +
> > +static const u32 aspeed_vga_table[] = {
> > +	0x800000,	//8MB
> > +	0x1000000,	//16MB
> > +	0x2000000,	//32MB
> > +	0x4000000,	//64MB
> > +};
> > +
> > +extern u32 aspeed_get_vga_size(void)
> > +{
> > +	u32 reg04;
> > +	u32 size;
> > +
> > +	regmap_read(aspeed_regmap, ASPEED_MCR_CONF, &reg04);
> > +
> > +	size = aspeed_vga_table[((reg04 & 0xC) >> 2)];
> > +	return size;
> > +}
> > +EXPORT_SYMBOL(aspeed_get_vga_size);
> > +
> >  static bool regmap_is_volatile(struct device *dev, unsigned int reg)
> > {
> >  	switch (reg) {
> > @@ -209,8 +275,8 @@ static int config_irq(void *ctx, struct
> > platform_device *pdev)
> >  	/* register interrupt handler */
> >  	irq = platform_get_irq(pdev, 0);
> >  	dev_dbg(&pdev->dev, "got irq %d\n", irq);
> > -	if (irq < 0)
> > -		return irq;
> > +	if (!irq)
> > +		return -ENODEV;
> 
> The documentation for platform_get_irq() says "Return: IRQ number on
> success, negative error number on failure."
> 
> So this change doesn't look right.
> 
Fixed in v2.

> >
> >  	rc = devm_request_irq(&pdev->dev, irq, mcr_isr, IRQF_TRIGGER_HIGH,
> >  			      DRV_NAME, ctx);
> > @@ -239,7 +305,11 @@ static int init_csrows(struct mem_ctl_info *mci)
> >  	int rc;
> >
> >  	/* retrieve info about physical memory from device tree */
> > -	np = of_find_node_by_path("/memory");
> > +#ifdef CONFIG_MACH_ASPEED_G4
> > +	np = of_find_node_by_path("/memory@40000000");
> > +#else
> > +	np = of_find_node_by_path("/memory@80000000");
> > +#endif
> 
> Again, this makes the driver SoC-specific at compile time, and that's not going
> to fly. If we need it, this should be solved with a phandle to the appropriate
> memory node.
> 
Fixed in v2 by using of_find_node_by_name(NULL, "memory") instead.

> >  	if (!np) {
> >  		dev_err(mci->pdev, "dt: missing /memory node\n");
> >  		return -ENODEV;
> > @@ -281,11 +351,19 @@ static int aspeed_probe(struct platform_device
> *pdev)
> >  	struct device *dev = &pdev->dev;
> >  	struct edac_mc_layer layers[2];
> >  	struct mem_ctl_info *mci;
> > +	struct device_node *np;
> > +	struct resource *res;
> >  	void __iomem *regs;
> > -	u32 reg04;
> >  	int rc;
> >
> > -	regs = devm_platform_ioremap_resource(pdev, 0);
> > +	/* setup regmap */
> > +	np = dev->of_node;
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (!res)
> > +		return -ENOENT;
> > +
> > +	regs = devm_ioremap_resource(dev, res);
> >  	if (IS_ERR(regs))
> >  		return PTR_ERR(regs);
> 
> Why is this change necessary?
> 
Not necessary, so I'll reverted this part of change in v2.

> >
> > @@ -294,13 +372,6 @@ static int aspeed_probe(struct platform_device
> *pdev)
> >  	if (IS_ERR(aspeed_regmap))
> >  		return PTR_ERR(aspeed_regmap);
> >
> > -	/* bail out if ECC mode is not configured */
> > -	regmap_read(aspeed_regmap, ASPEED_MCR_CONF, &reg04);
> > -	if (!(reg04 & ASPEED_MCR_CONF_ECC)) {
> > -		dev_err(&pdev->dev, "ECC mode is not configured in u-boot\n");
> > -		return -EPERM;
> > -	}
> > -
> 
> Why shouldn't we do this check?
The driver can handle both ECC on and off, so this check might not be necessary.

> >  	edac_op_state = EDAC_OPSTATE_INT;
> >
> >  	/* allocate & init EDAC MC data structure */ @@ -373,13 +444,13 @@
> > static int aspeed_remove(struct platform_device *pdev)
> >  	return 0;
> >  }
> >
> > -
> >  static const struct of_device_id aspeed_of_match[] = {
> > +	{ .compatible = "aspeed,ast2400-sdram-edac" },
> >  	{ .compatible = "aspeed,ast2500-sdram-edac" },
> > +	{ .compatible = "aspeed,ast2600-sdram-edac" },
> 
> The .data member of struct of_device_id is where you need to attach your
> SoC-generation-specific data.
> 
> Cheers,
> 
> Andrew
> 
> >  	{},
> >  };
> >
> > -
> >  static struct platform_driver aspeed_driver = {
> >  	.driver		= {
> >  		.name	= DRV_NAME,
> > @@ -395,18 +466,15 @@ static int __init aspeed_init(void)
> >  	return platform_driver_register(&aspeed_driver);
> >  }
> >
> > -
> >  static void __exit aspeed_exit(void)
> >  {
> >  	platform_driver_unregister(&aspeed_driver);
> >  }
> >
> > -
> >  module_init(aspeed_init);
> >  module_exit(aspeed_exit);
> >
> > -
> >  MODULE_LICENSE("GPL");
> >  MODULE_AUTHOR("Stefan Schaeckeler <sschaeck@cisco.com>");
> > -MODULE_DESCRIPTION("Aspeed AST2500 EDAC driver");
> > +MODULE_DESCRIPTION("Aspeed EDAC driver");
> >  MODULE_VERSION("1.0");
> > --
> > 2.17.1
> >
> >
