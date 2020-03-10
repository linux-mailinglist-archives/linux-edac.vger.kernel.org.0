Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5D6180732
	for <lists+linux-edac@lfdr.de>; Tue, 10 Mar 2020 19:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgCJSou (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 10 Mar 2020 14:44:50 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35580 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgCJSou (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 10 Mar 2020 14:44:50 -0400
Received: by mail-ot1-f68.google.com with SMTP id k26so6958285otr.2;
        Tue, 10 Mar 2020 11:44:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PJfOBTObVWYVfiIlBNgR4fIlBc7lQjhtjwMHAHY2r38=;
        b=jspXlkV46wtCr5ljGYqKvjDyr+EwDuPGKHiLmx/sCjBmb4vqXOh3wTuAGCE3rKOjwL
         pmg7xhaE9Di16irRmxlDpDWhhJLXUIF6YSFuXsLsmkmYkF74gRGG6H9wOZsyyJz+Gdqx
         PojiqmB2+ONmhHfoDMy/ZSNV8faJblnJRPWQMmG7wDJpWuwlgO3skHR08DKHlD34RDVE
         23jrH4/wWnENPnJ6Wrka7oTDxiNDiHZoZqKjoO2bkpOQpFb7sYYzCVIG0qgjkAAZyU4/
         8hQ2tEfLXmaG4aS11mCxfxddmQdMGvMgD6Z9SnsG004rnv4nvgobEZieHDv7XB2pahXR
         QZqA==
X-Gm-Message-State: ANhLgQ13lEhGdSuTQsiEqyOT4HFyZg4/f6ORGHdVuzREuo7IperG2fgH
        ZcYNZgY6Ad4brI4iaER6Hg==
X-Google-Smtp-Source: ADFU+vuQs0OnawS9/ynUCTc8EKkO5VNO4tLlfeFjHbA8Jtq0UYFCWakGTmg55xZxtKimji/atijdSQ==
X-Received: by 2002:a9d:6a91:: with SMTP id l17mr13893256otq.29.1583865889501;
        Tue, 10 Mar 2020 11:44:49 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b11sm2077211otj.64.2020.03.10.11.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 11:44:48 -0700 (PDT)
Received: (nullmailer pid 8866 invoked by uid 1000);
        Tue, 10 Mar 2020 18:44:47 -0000
Date:   Tue, 10 Mar 2020 13:44:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dhananjay Kangude <dkangude@cadence.com>
Cc:     linux-edac@vger.kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org, mparab@cadence.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 2/2] dt-bindings: edac: Add cadence ddr mc support
Message-ID: <20200310184447.GB2508@bogus>
References: <20200228094322.13617-1-dkangude@cadence.com>
 <20200228094322.13617-3-dkangude@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228094322.13617-3-dkangude@cadence.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Feb 28, 2020 at 10:43:22AM +0100, Dhananjay Kangude wrote:
> Add documentation for cadence ddr memory controller EDAC DTS bindings
> 
> Signed-off-by: Dhananjay Kangude <dkangude@cadence.com>
> ---
>  .../devicetree/bindings/edac/cdns,ddr-edac.yaml    | 59 ++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml
> 
> diff --git a/Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml b/Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml
> new file mode 100644
> index 000000000000..d83d8840d57b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/edac/cdns,ddr-edac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cadence DDR IP with ECC support (EDAC)
> +
> +description:
> +  This binding describes the Cadence DDR/LPDDR IP with ECC feature enabled
> +  to detect and correct CE/UE errors.
> +
> +maintainers:
> +  - Dhananjay Kangdue <dkangude@cadence.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - cdns,cadence-ddr4-mc-edac

You have Cadence twice effectively.

'edac' is a linuxism. The binding should be for the DDR controller 
unless this block only does ECC. Name it based on what the h/w is 
called.

> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +
> +  ranges: true

You don't have any children defined, so you don't need these 3 
properties.

> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - description:
> +          Register block of DDR/LPDDR apb registers up to mapped area.
> +          Mapped area contains the register set for memory controller,
> +          phy and PI module register set doesn't part of this mapping.
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - ranges
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    edac: edac@fd100000 {
> +        compatible = "cdns,cadence-ddr4-mc-edac";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges;
> +        reg = <0xfd100000 0x4000>;
> +        interrupts = <0x00 0x01 0x04>;
> +        };

Wrong indent.

> +...
> -- 
> 2.15.0
> 
