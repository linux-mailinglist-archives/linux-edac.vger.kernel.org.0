Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68DB43EEB30
	for <lists+linux-edac@lfdr.de>; Tue, 17 Aug 2021 12:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236215AbhHQKro (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 17 Aug 2021 06:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235380AbhHQKrn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 17 Aug 2021 06:47:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01333C061764
        for <linux-edac@vger.kernel.org>; Tue, 17 Aug 2021 03:47:10 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1mFwcV-00084f-9I; Tue, 17 Aug 2021 12:46:59 +0200
Received: from localhost ([127.0.0.1])
        by ptx.hi.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1mFwcT-0000h1-T6; Tue, 17 Aug 2021 12:46:57 +0200
Message-ID: <17798cb01c5d699738f57118d4deb53504759818.camel@pengutronix.de>
Subject: Re: [PATCH 1/2] dt-bindings: memory: convert Marvell MVEBU SDRAM
 controller to dtschema
From:   Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Date:   Tue, 17 Aug 2021 12:46:57 +0200
In-Reply-To: <20210817093807.59531-1-krzysztof.kozlowski@canonical.com>
References: <20210817093807.59531-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 (by Flathub.org) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: jlu@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-edac@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, 2021-08-17 at 11:38 +0200, Krzysztof Kozlowski wrote:
> Convert Marvell MVEBU SDRAM controller bindings to DT schema format
> using json-schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../marvell,mvebu-sdram-controller.yaml       | 31 +++++++++++++++++++
>  .../mvebu-sdram-controller.txt                | 21 -------------
>  2 files changed, 31 insertions(+), 21 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/marvell,mvebu-sdram-controller.yaml
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mvebu-sdram-controller.txt
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/marvell,mvebu-sdram-controller.yaml b/Documentation/devicetree/bindings/memory-controllers/marvell,mvebu-sdram-controller.yaml
> new file mode 100644
> index 000000000000..14a6bc8f421f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/marvell,mvebu-sdram-controller.yaml
> @@ -0,0 +1,31 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/marvell,mvebu-sdram-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell MVEBU SDRAM controller
> +
> +maintainers:
> +  - Jan Luebbe <jlu@pengutronix.de>
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> +
> +properties:
> +  compatible:
> +    const: marvell,armada-xp-sdram-controller
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    memory-controller@1400 {
> +        compatible = "marvell,armada-xp-sdram-controller";
> +        reg = <0x1400 0x500>;
> +    };
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mvebu-sdram-controller.txt b/Documentation/devicetree/bindings/memory-controllers/mvebu-sdram-controller.txt
> deleted file mode 100644
> index 89657d1d4cd4..000000000000
> --- a/Documentation/devicetree/bindings/memory-controllers/mvebu-sdram-controller.txt
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -Device Tree bindings for MVEBU SDRAM controllers
> -
> -The Marvell EBU SoCs all have a SDRAM controller. The SDRAM controller
> -differs from one SoC variant to another, but they also share a number
> -of commonalities.
> -
> -For now, this Device Tree binding documentation only documents the
> -Armada XP SDRAM controller.

Please keep the description, otherwise it would be confusing why the binding is
named marvell,mvebu-sdram-controller.yaml although it (currenly) only applies to
the Armada XP.

Jan

> -
> -Required properties:
> -
> - - compatible: for Armada XP, "marvell,armada-xp-sdram-controller"
> - - reg: a resource specifier for the register space, which should
> -   include all SDRAM controller registers as per the datasheet.
> -
> -Example:
> -
> -sdramc@1400 {
> -	compatible = "marvell,armada-xp-sdram-controller";
> -	reg = <0x1400 0x500>;
> -};

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

