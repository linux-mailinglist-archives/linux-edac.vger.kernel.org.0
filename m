Return-Path: <linux-edac+bounces-3389-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A52A6AE7A
	for <lists+linux-edac@lfdr.de>; Thu, 20 Mar 2025 20:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9152618907A4
	for <lists+linux-edac@lfdr.de>; Thu, 20 Mar 2025 19:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5801227E84;
	Thu, 20 Mar 2025 19:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jqn0+a7f"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AA1221F24;
	Thu, 20 Mar 2025 19:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742498858; cv=none; b=cfUskZsgvWhHvR+Ppna5Ic8+5k2FWjm32piuj6boBifvyxLcLAfKPje1JiINwX99TqI2jynOVvfyxNWJbOOvQw8I6WYa+Ldb9htNVAtYfeqoeFZCiMNbCIbfm36O/GnWDiXcFqMgLhRSkQrnDusuH6SZEz4HNwbpBKwoNx7xexg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742498858; c=relaxed/simple;
	bh=/4F2kk1DkmslwqC3zPtCcRTZx+N5DCW6yzA9L9t77P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBG0cE5llPz828NoN/jhTZqEez4uz7Sfdmg2zkpNSbzTvgRQYKKKZtPE+jRF2QFRIcOvxRCOdyKK3vU1+5lWUogJoFBJzhmoodG8RpPvk2PqR9UrjpaUUabfqeR/S46J5s8bc/s2nqX2xwBPqMgAi2BmGGBKU4yOd7VKBeGFxjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jqn0+a7f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971BAC4CEDD;
	Thu, 20 Mar 2025 19:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742498857;
	bh=/4F2kk1DkmslwqC3zPtCcRTZx+N5DCW6yzA9L9t77P4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jqn0+a7fN7yfnTTnV7NRTZ0XaK2c2vIVQpZ3q5ftcVhBTgPCBa/7tMEBMxAfmL+4w
	 WYObx/xuy7LIuU5xLm4clga9dMf+n9hCvI392mtUw38pOkXAmlOLlXOQH6FsQ41YOz
	 sQqxJV3bRuivtCma/ExxWvdvp6l1aY10WvSB6KuWKVC2PU5aMDZL+7LL9oSqfkecIK
	 mbqMVkiYw2bKFFEXDZ4N/NmwDWAdVmufd4nHm9ZeNUCnm2/M1DoN/J9MTBMPWT+h+e
	 eKZqMbt9lJ0EBD+GKS4vc8Opd4LSLZo0X7Jr3T+SK8MOiiefJHmycjPvaYqvycyUv5
	 TdK7xoaM1oGtA==
Date: Thu, 20 Mar 2025 14:27:31 -0500
From: Rob Herring <robh@kernel.org>
To: Matthew Gerlach <matthew.gerlach@altera.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, dinguyen@kernel.org,
	bp@alien8.de, tony.luck@intel.com, james.morse@arm.com,
	mchehab@kernel.org, rric@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: edac: altera-s10: Convert to YAML
Message-ID: <20250320192731.GA750632-robh@kernel.org>
References: <20250320164622.6971-1-matthew.gerlach@altera.com>
 <20250320164622.6971-2-matthew.gerlach@altera.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320164622.6971-2-matthew.gerlach@altera.com>

On Thu, Mar 20, 2025 at 09:46:19AM -0700, Matthew Gerlach wrote:
> Convert the device tree bindings for the Altera Stratix10 SoCFPGA ECC
> Manager from text to yaml. The hardware for the device tree subnodes
> have not changed since Arria10; so don't change the compatible strings
> to include "-s10-".

Nice to see this.

> Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
> ---
>  .../edac/altr,socfpga-s10-ecc-manager.yaml    | 228 ++++++++++++++++++
>  .../bindings/edac/socfpga-eccmgr.txt          | 150 ------------
>  MAINTAINERS                                   |   5 +
>  3 files changed, 233 insertions(+), 150 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/edac/altr,socfpga-s10-ecc-manager.yaml
> 
> diff --git a/Documentation/devicetree/bindings/edac/altr,socfpga-s10-ecc-manager.yaml b/Documentation/devicetree/bindings/edac/altr,socfpga-s10-ecc-manager.yaml
> new file mode 100644
> index 000000000000..ad057a63e88b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/edac/altr,socfpga-s10-ecc-manager.yaml
> @@ -0,0 +1,228 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) 2025 Altera Corporation
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/altr,socfpga-s10-ecc-manager.yaml#

schemas/edac/...

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Altera Stratix10 SoCFPGA ECC Manager (ARM64)
> +
> +maintainers:
> +  - Matthew Gerlach <matthew.gerlach@altera.com
> +
> +description: |

Don't need '|'.

> +  The Stratix10 implementation of the SoCFPGA ECC Manager counts and corrects
> +  single bit errors. Double bit errors are treated as SErrors in ARM64. This
> +  implementation requires access to registers only available to the Secure
> +  Device Manager (SDM) via Secure Monitor Calls (SMC).
> +
> +properties:
> +
> +  compatible:
> +    items:
> +      - const: altr,socfpga-s10-ecc-manager
> +
> +  altr,sysmgr-syscon:
> +    maxItems: 1

Vendor properties last (but before child nodes).

> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 2
> +
> +  ranges: true
> +
> +  sdramedac:
> +    type: object
> +    additionalProperties: false

blank line

> +    properties:
> +      compatible:
> +        const: altr,sdram-edac-s10

blank line

> +      altr,sdr-syscon:
> +        $ref: /schemas/types.yaml#/definitions/phandle
> +        description: phandle to SDRAM parent

blank line

> +      interrupts:
> +        maxItems: 1

blank line

And similar on the rest.

> +    required:
> +      - compatible
> +      - altr,sdr-syscon
> +      - interrupts
> +
> +  ocram-ecc@ff8cc000:
> +    type: object
> +    additionalProperties: false
> +    properties:
> +      compatible:
> +        items:

You can drop 'items' if there's only 1 entry.

> +          - const: altr,socfpga-a10-ocram-ecc
> +
> +      reg:
> +        maxItems: 1
> +      altr,ecc-parent:
> +        $ref: /schemas/types.yaml#/definitions/phandle
> +        description: phandle to OCRAM parent
> +      interrupts:
> +        maxItems: 1
> +    required:
> +      - compatible
> +      - reg
> +      - altr,ecc-parent
> +      - interrupts
> +
> +  usb0-ecc@ff8c4000:
> +    type: object
> +    additionalProperties: false
> +    properties:
> +      compatible:
> +        items:
> +          - const: altr,socfpga-usb-ecc
> +      reg:
> +        maxItems: 1
> +      altr,ecc-parent:
> +        $ref: /schemas/types.yaml#/definitions/phandle
> +        description: phandle to USB parent
> +      interrupts:
> +        maxItems: 1
> +    required:
> +      - compatible
> +      - reg
> +      - altr,ecc-parent
> +      - interrupts
> +
> +  emac0-rx-ecc@ff8c0000:
> +    type: object
> +    additionalProperties: false
> +    properties:
> +      compatible:
> +        items:
> +          - const: altr,socfpga-eth-mac-ecc
> +      reg:
> +        maxItems: 1
> +      altr,ecc-parent:
> +        $ref: /schemas/types.yaml#/definitions/phandle
> +        description: phandle to ethernet parent
> +      interrupts:
> +        maxItems: 1
> +    required:
> +      - compatible
> +      - reg
> +      - altr,ecc-parent
> +      - interrupts
> +
> +  emac0-tx-ecc@ff8c0400:
> +    type: object
> +    additionalProperties: false
> +    properties:
> +      compatible:
> +        items:
> +          - const: altr,socfpga-eth-mac-ecc
> +      reg:
> +        maxItems: 1
> +      altr,ecc-parent:
> +        $ref: /schemas/types.yaml#/definitions/phandle
> +        description: phandle to ethernet parent
> +      interrupts:
> +        maxItems: 1
> +    required:
> +      - compatible
> +      - reg
> +      - altr,ecc-parent
> +      - interrupts
> +
> +  sdmmca-ecc@ff8c8c00:
> +    type: object
> +    additionalProperties: false
> +    properties:
> +      compatible:
> +        items:
> +          - const: altr,socfpga-sdmmc-ecc
> +      reg:
> +        maxItems: 1
> +      altr,ecc-parent:
> +        $ref: /schemas/types.yaml#/definitions/phandle
> +        description: phandle to ethernet parent
> +      interrupts:
> +        maxItems: 2
> +    required:
> +      - compatible
> +      - reg
> +      - altr,ecc-parent
> +      - interrupts
> +
> +required:
> +  - compatible
> +  - altr,sysmgr-syscon
> +  - "#address-cells"
> +  - "#size-cells"
> +  - interrupts
> +  - interrupt-controller
> +  - "#interrupt-cells"
> +  - ranges
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    eccmgr {
> +        compatible = "altr,socfpga-s10-ecc-manager";
> +        altr,sysmgr-syscon = <&sysmgr>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-controller;
> +        #interrupt-cells = <2>;
> +        ranges;
> +
> +        sdramedac {
> +            compatible = "altr,sdram-edac-s10";
> +            altr,sdr-syscon = <&sdr>;
> +            interrupts = <16 IRQ_TYPE_LEVEL_HIGH>;
> +        };
> +
> +        ocram-ecc@ff8cc000 {
> +            compatible = "altr,socfpga-a10-ocram-ecc";
> +            reg = <0xff8cc000 0x100>;
> +            altr,ecc-parent = <&ocram>;
> +            interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
> +        };
> +
> +        usb0-ecc@ff8c4000 {
> +            compatible = "altr,socfpga-usb-ecc";
> +            reg = <0xff8c4000 0x100>;
> +            altr,ecc-parent = <&usb0>;
> +            interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
> +        };
> +
> +        emac0-rx-ecc@ff8c0000 {
> +            compatible = "altr,socfpga-eth-mac-ecc";
> +            reg = <0xff8c0000 0x100>;
> +            altr,ecc-parent = <&gmac0>;
> +            interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
> +        };
> +
> +        emac0-tx-ecc@ff8c0400 {
> +            compatible = "altr,socfpga-eth-mac-ecc";
> +            reg = <0xff8c0400 0x100>;
> +            altr,ecc-parent = <&gmac0>;
> +            interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
> +        };
> +
> +        sdmmca-ecc@ff8c8c00 {
> +            compatible = "altr,socfpga-sdmmc-ecc";
> +            reg = <0xff8c8c00 0x100>;
> +            altr,ecc-parent = <&mmc>;
> +            interrupts = <14 IRQ_TYPE_LEVEL_HIGH>,
> +                         <15 IRQ_TYPE_LEVEL_HIGH>;
> +        };
> +    };

