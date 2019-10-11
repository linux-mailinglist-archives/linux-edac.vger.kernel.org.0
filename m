Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15117D4123
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2019 15:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfJKN3H (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Oct 2019 09:29:07 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46716 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbfJKN3H (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 11 Oct 2019 09:29:07 -0400
Received: by mail-oi1-f193.google.com with SMTP id k25so7944334oiw.13;
        Fri, 11 Oct 2019 06:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=noJDdn0TxhdYjyfk41LUPauSPjsaXFCx0lOssfNVaEg=;
        b=kqGLcntihVrD6oILZAgntsL4MBjDQKH85VEOIpzs32ot6wxpmcdsf/Ukk/Pc6T4HvL
         iPn9cIsqyHvqE9sbdMZfPTDJKRxb3n5LvlBItRYeYyMwm/9ahbottk8gFwdiJXE9MwyJ
         UuU3o9jkJNGOTEsMYrRbmpOaP+w3KPOrhLfkmYoj//rVGpWZPm4mt7BcN0+SHEv6rewW
         0G4DxGtib0ba/SDHEgxB2qHnL7+7Md1xI4vQFbIgKoC5C7wsWEI7IkcdLuKjJa6Yn71G
         CQcyPRssjXffJMNZdCsaUAsGpO2HHsC3QuxhZgTWu90WntFNTB3Jy2Zmt9KHbluHhlFE
         1kMQ==
X-Gm-Message-State: APjAAAV66l49wPeojBojrrTjU13pRelswTuyQ2Be0T8aSvFeiQOEJywm
        nzBW7uQC+QxDqrNa/kvWzG7bxQ8=
X-Google-Smtp-Source: APXvYqwKOk7arASTVemLrM2FAbjAq/ATjlhLgHDbKr9NhgryydYK8tSNhsrhwGk9cf1KW+MhSvvP8A==
X-Received: by 2002:aca:4794:: with SMTP id u142mr12433837oia.159.1570800546341;
        Fri, 11 Oct 2019 06:29:06 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 11sm2868239otg.62.2019.10.11.06.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 06:29:05 -0700 (PDT)
Date:   Fri, 11 Oct 2019 08:29:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Talel Shenhar <talel@amazon.com>
Cc:     maz@kernel.org, mark.rutland@arm.com, arnd@arndb.de, bp@alien8.de,
        mchehab@kernel.org, james.morse@arm.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, paulmck@linux.ibm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, dwmw@amazon.co.uk,
        benh@kernel.crashing.org, hhhawa@amazon.com, ronenk@amazon.com,
        jonnyc@amazon.com, hanochu@amazon.com, amirkl@amazon.com,
        barakw@amazon.com
Subject: Re: [PATCH v4 1/2] dt-bindings: edac: al-mc-edac: Amazon's Annapurna
 Labs Memory Controller EDAC
Message-ID: <20191011132904.GA15595@bogus>
References: <1570708454-10784-1-git-send-email-talel@amazon.com>
 <1570708454-10784-2-git-send-email-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570708454-10784-2-git-send-email-talel@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Oct 10, 2019 at 02:54:13PM +0300, Talel Shenhar wrote:
> Document Amazon's Annapurna Labs Memory Controller EDAC SoC binding.
> 
> Signed-off-by: Talel Shenhar <talel@amazon.com>
> ---
>  .../bindings/edac/amazon,al-mc-edac.yaml           | 50 ++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml
> 
> diff --git a/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml b/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml
> new file mode 100644
> index 00000000..f66b094
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: GPL-2.0

Forgot to mention, please make new bindings (GPL-2.0-only OR BSD-2-Clause).

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/edac/amazon,al-mc-edac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amazon's Annapurna Labs Memory Controller EDAC
> +
> +maintainers:
> +  - Talel Shenhar <talel@amazon.com>
> +  - Talel Shenhar <talelshenhar@gmail.com>
> +
> +description: |
> +  EDAC node is defined to describe on-chip error detection and correction for
> +  Amazon's Annapurna Labs Memory Controller.
> +
> +properties:
> +
> +  compatible:
> +    const: amazon,al-mc-edac
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 2
> +    items:
> +      - description: uncorrectable error interrupt
> +      - description: correctable error interrupt
> +
> +  interrupt-names:
> +    maxItems: 2
> +    items:
> +      - const: ue
> +      - const: ce

Now the example fails to build:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.example.dt.yaml: 
edac@f0080000: interrupt-names: ['ue'] is too short
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.example.dt.yaml: 
edac@f0080000: interrupts: [[20, 4]] is too short

You either need to always have the CE irq or add 'minItems: 1' to both. 

> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    edac@f0080000 {
> +      compatible = "amazon,al-mc-edac";
> +      reg = <0x0 0xf0080000 0x0 0x00010000>;
> +      interrupt-parent = <&amazon_al_system_fabric>;
> +      interrupt-names = "ue";
> +      interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
> +    };
> -- 
> 2.7.4
> 
