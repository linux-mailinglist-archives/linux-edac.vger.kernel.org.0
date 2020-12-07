Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6F02D08BA
	for <lists+linux-edac@lfdr.de>; Mon,  7 Dec 2020 02:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgLGBLz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 6 Dec 2020 20:11:55 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:50797 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726046AbgLGBLz (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 6 Dec 2020 20:11:55 -0500
X-Greylist: delayed 448 seconds by postgrey-1.27 at vger.kernel.org; Sun, 06 Dec 2020 20:11:54 EST
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id D8A5A5802DF;
        Sun,  6 Dec 2020 20:03:20 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Sun, 06 Dec 2020 20:03:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=cB1Dw0K4Q6rFJj1QuyI/XjHiNBx6kkb
        +GjcfpOtl/kI=; b=jcf93RNPtDBmqCAVJFH4i6r3+KCL9HzRLtj/83g25fy9YHF
        EGMS7D5V1AKrCms0uRV+a9r3+Grl1m1P/HDPNzeNPIEWt+a9YcM+i4FowIQAhJi3
        0fduLdwDspAOqhL/8m6B421xUKkLsQ+rqrWUWJYXveQjzzjEMtaoH96Hx1c2/BG7
        +uAoCErJeTTAwEaB94PiBTgk1LJLKytKSTtAqa7+0KPg2kVqPJyBY0y3j3v4RYMu
        VW2Si0BovZECkWKXClveGRpHUxe8YnWQujcIM/TjefN8q17eIVhyfwae1Z8Yu9/U
        bjsmlP2x3vv9puZYFbJw0MdzmEyKTqtVk3txPFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=cB1Dw0
        K4Q6rFJj1QuyI/XjHiNBx6kkb+GjcfpOtl/kI=; b=g9bS9X1AI+fTriVltBFOfY
        Dg1vk0NJn58J+l12bWZmtYTTZSXg8ZQ6Khdd4ITKKrtYSOWmrdW2CcU8o+k8DcIL
        16mn1w21JykdKOnLnvu/WYRjSbJ+nHMsNzcN0+b9BjcxRiHk9b8fOjRgj2mPzhJs
        /d99nvVTwJEBLhpXNV05IuquXLkRxiou3/8tXVUYXrR+xCDMN2DwH+ZSIQGZwdgX
        dEruhzYU2it4boL/ThdVic4DlaJii7aX5WVgYq+F06uZ5aksMj+02X97vegtwU74
        rjA5alr4Vicmszl2p/6WtZDmTXDbZB9GPxjmMj3c1dfVNB6WJPh8wM1zh0QE/TAw
        ==
X-ME-Sender: <xms:Vn_NX47sKyI0ilQ2jKIWwoxcNSf-9SDl2mX-20ulI8W7WxCOURnwcw>
    <xme:Vn_NX55oGYJs6K2zd75P14FT3HRmzHEmR9TiPFKQTIZGZVAPSEt_U2ctS_eJiHTdx
    4YGAWa-ZUWmQGwDyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudejfedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhephefhfeekgfekudevheffheeihedujeefjeevjeefudfgfeeutdeuvdeh
    hfevueffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:Vn_NX3fX16Vhs0CcvU0rXK-Efp-OI61hg49nnrQ4thWp2Y18bbIgpw>
    <xmx:Vn_NX9ITE6H9ObvVkV8jAaVFKiILH4cwlXdc2IVHSPLoSITgVmA0RA>
    <xmx:Vn_NX8LgyVb9us__IVMf81VcEqRVWEQX_d6F6FKYcvChrLt4O85utg>
    <xmx:WH_NX_Yelpm7n0UBaBSvVLnYMpgkACGwIxCsi7RgiI5XTuhn4HrBkw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 733F4E00DF; Sun,  6 Dec 2020 20:03:16 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-622-g4a97c0b-fm-20201115.001-g4a97c0b3
Mime-Version: 1.0
Message-Id: <21488758-f839-4762-93d6-0e6c3397394f@www.fastmail.com>
In-Reply-To: <20201202101218.18393-3-troy_lee@aspeedtech.com>
References: <20201202101218.18393-1-troy_lee@aspeedtech.com>
 <20201202101218.18393-3-troy_lee@aspeedtech.com>
Date:   Mon, 07 Dec 2020 11:32:57 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Troy Lee" <troy_lee@aspeedtech.com>,
        "Stefan M Schaeckeler" <sschaeck@cisco.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Joel Stanley" <joel@jms.id.au>, "Borislav Petkov" <bp@alien8.de>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "Tony Luck" <tony.luck@intel.com>,
        "James Morse" <james.morse@arm.com>,
        "Robert Richter" <rric@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        "open list" <linux-kernel@vger.kernel.org>,
        "open list:EDAC-CORE" <linux-edac@vger.kernel.org>
Cc:     leetroy@gmail.com, "Ryan Chen" <ryan_chen@aspeedtech.com>
Subject: Re: [PATCH v3 3/3] edac: Supporting AST2400 and AST2600 edac driver
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On Wed, 2 Dec 2020, at 20:42, Troy Lee wrote:
> Adding AST2400 and AST2600 edac driver support.
> 
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> ---
> Changes since v2:
> - Remove cross dependencies export functions
> - Update Kconfig depends on ARCH_ASPEED
> - Patch create against latest Linux kernel mainline
> 
> ---
>  drivers/edac/Kconfig       |  6 +++---
>  drivers/edac/aspeed_edac.c | 15 +++++----------
>  2 files changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 7a47680d6f07..c410331e8ee8 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -515,10 +515,10 @@ config EDAC_QCOM
>  	  health, you should probably say 'Y' here.
>  
>  config EDAC_ASPEED
> -	tristate "Aspeed AST 2500 SoC"
> -	depends on MACH_ASPEED_G5
> +	tristate "Aspeed AST BMC SoC"
> +	depends on ARCH_ASPEED
>  	help
> -	  Support for error detection and correction on the Aspeed AST 2500 SoC.
> +	  Support for error detection and correction on the Aspeed AST BMC SoC.
>  
>  	  First, ECC must be configured in the bootloader. Then, this driver
>  	  will expose error counters via the EDAC kernel framework.
> diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
> index fde809efc520..c9d1d8a8fcba 100644
> --- a/drivers/edac/aspeed_edac.c
> +++ b/drivers/edac/aspeed_edac.c
> @@ -239,7 +239,7 @@ static int init_csrows(struct mem_ctl_info *mci)
>  	int rc;
>  
>  	/* retrieve info about physical memory from device tree */
> -	np = of_find_node_by_path("/memory");
> +	np = of_find_node_by_name(NULL, "memory");
>  	if (!np) {
>  		dev_err(mci->pdev, "dt: missing /memory node\n");
>  		return -ENODEV;
> @@ -282,7 +282,6 @@ static int aspeed_probe(struct platform_device *pdev)
>  	struct edac_mc_layer layers[2];
>  	struct mem_ctl_info *mci;
>  	void __iomem *regs;
> -	u32 reg04;
>  	int rc;
>  
>  	regs = devm_platform_ioremap_resource(pdev, 0);
> @@ -294,13 +293,6 @@ static int aspeed_probe(struct platform_device *pdev)
>  	if (IS_ERR(aspeed_regmap))
>  		return PTR_ERR(aspeed_regmap);
>  
> -	/* bail out if ECC mode is not configured */
> -	regmap_read(aspeed_regmap, ASPEED_MCR_CONF, &reg04);
> -	if (!(reg04 & ASPEED_MCR_CONF_ECC)) {
> -		dev_err(&pdev->dev, "ECC mode is not configured in u-boot\n");
> -		return -EPERM;
> -	}
> -

It might pay to separate this out as I think it's unrelated to the supporting 
the AST2[45]00?

Other than that I think the patch is on the right track.

Thanks for the quick responses Troy!

Andrew

>  	edac_op_state = EDAC_OPSTATE_INT;
>  
>  	/* allocate & init EDAC MC data structure */
> @@ -375,10 +367,13 @@ static int aspeed_remove(struct platform_device *pdev)
>  
>  
>  static const struct of_device_id aspeed_of_match[] = {
> +	{ .compatible = "aspeed,ast2400-sdram-edac" },
>  	{ .compatible = "aspeed,ast2500-sdram-edac" },
> +	{ .compatible = "aspeed,ast2600-sdram-edac" },
>  	{},
>  };
>  
> +MODULE_DEVICE_TABLE(of, aspeed_of_match);
>  
>  static struct platform_driver aspeed_driver = {
>  	.driver		= {
> @@ -392,5 +387,5 @@ module_platform_driver(aspeed_driver);
>  
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Stefan Schaeckeler <sschaeck@cisco.com>");
> -MODULE_DESCRIPTION("Aspeed AST2500 EDAC driver");
> +MODULE_DESCRIPTION("Aspeed BMC SoC EDAC driver");
>  MODULE_VERSION("1.0");
> -- 
> 2.17.1
> 
>
