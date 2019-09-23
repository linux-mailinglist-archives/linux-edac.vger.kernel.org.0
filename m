Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 628A6BB929
	for <lists+linux-edac@lfdr.de>; Mon, 23 Sep 2019 18:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388175AbfIWQKU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 23 Sep 2019 12:10:20 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55442 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387819AbfIWQKU (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 23 Sep 2019 12:10:20 -0400
Received: from zn.tnic (p200300EC2F060400F50F96FF27F9741F.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:400:f50f:96ff:27f9:741f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E9A9C1EC06F3;
        Mon, 23 Sep 2019 18:10:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1569255019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0bYHJtGISqNLfydtAdxQkWGpoo+d0+T8UOA0chvqHlw=;
        b=jS3wfbvgqiJdEaJhcbl1NZ9T3NsvZykOI3R0zqhcICq0S3Hm8baZ2GDBrjVuDcUATFeLYi
        TkcUGJd1TJA11Smq0lLKO9cIuaVPOfb7GkjvFz61pbalctaGxEXGlNlF2GDo3lP5zICRiH
        KJh2EPdWb9Cx/83PZ3mAfZM9ZJyIopw=
Date:   Mon, 23 Sep 2019 18:10:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Lei Wang <leiwang_git@outlook.com>
Cc:     "james.morse@arm.com" <james.morse@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "hangl@microsoft.com" <hangl@microsoft.com>,
        "lewan@microsoft.com" <lewan@microsoft.com>,
        "ruizhao@microsoft.com" <ruizhao@microsoft.com>,
        "scott.branden@broadcom.com" <scott.branden@broadcom.com>,
        "yuqing.shen@broadcom.com" <yuqing.shen@broadcom.com>,
        "ray.jui@broadcom.com" <ray.jui@broadcom.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: edac: arm-dmc520.txt
Message-ID: <20190923161015.GI15355@zn.tnic>
References: <BY5PR04MB6599EAA659A53B2331CB812586890@BY5PR04MB6599.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BY5PR04MB6599EAA659A53B2331CB812586890@BY5PR04MB6599.namprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Sep 19, 2019 at 06:37:00PM +0000, Lei Wang wrote:
> This is the device tree bindings for new EDAC driver dmc520_edac.c.
> 
> Signed-off-by: Lei Wang <leiwang_git@outlook.com>
> Reviewed-by: James Morse <james.morse@arm.com>
> 
> ---
>     No change in v6.
> ---
>  .../devicetree/bindings/edac/arm-dmc520.txt   | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/arm-dmc520.txt
> 
> diff --git a/Documentation/devicetree/bindings/edac/arm-dmc520.txt b/Documentation/devicetree/bindings/edac/arm-dmc520.txt
> new file mode 100644
> index 000000000000..71e7aa32971a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/edac/arm-dmc520.txt
> @@ -0,0 +1,26 @@
> +* ARM DMC-520 EDAC node
> +
> +Required properties:
> +- compatible		: "brcm,dmc-520", "arm,dmc-520".
> +- reg			: Address range of the DMC-520 registers.
> +- interrupts		: DMC-520 interrupt numbers. The example below specifies
> +			  two interrupt lines for dram_ecc_errc_int and
> +			  dram_ecc_errd_int.
> +- interrupt-config	: This is an array of interrupt masks. For each of the
> +			  above interrupt line, add one interrupt mask element to
> +			  it. That is, there is a 1:1 mapping from each interrupt
> +			  line to an interrupt mask. An interrupt mask can represent
> +			  multiple interrupts being enabled. Refer to interrupt_control
> +			  register in DMC-520 TRM for interrupt mapping. In the example
> +			  below, the interrupt configuration enables dram_ecc_errc_int
> +			  and dram_ecc_errd_int. And each interrupt is connected to
> +			  a separate interrupt line.
> +
> +Example:
> +
> +dmc0: dmc@200000 {
> +	compatible = "brcm,dmc-520", "arm,dmc-520";
> +	reg = <0x200000 0x80000>;
> +	interrupts = <0x0 0x349 0x4>, <0x0 0x34B 0x4>;
> +	interrupt-config = <0x4>, <0x8>;
> +};
> -- 

Still needs a DT person ACK.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
