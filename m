Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E741FD189B
	for <lists+linux-edac@lfdr.de>; Wed,  9 Oct 2019 21:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731612AbfJITQ2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 9 Oct 2019 15:16:28 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33198 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731144AbfJITQ1 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 9 Oct 2019 15:16:27 -0400
Received: by mail-ot1-f67.google.com with SMTP id 60so2724147otu.0;
        Wed, 09 Oct 2019 12:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NsEhGh1kFaBNKGsSiEy6NKNPiYELx9hdX+GfRAKSPVg=;
        b=YjVfrtKrMEzOZ+WLkmgXY7tbQUdOTvzkr6Wg1olFXtPslH3gjHM9zaCvp6R6zCu1lR
         YnoftlxFNuiGADq+KxcUEgb5KV6JCmUHI8rEK2TzoQUXuxQXHtCcCTqvs9tEkQjNLy9J
         eZxox+A8adI6PrpDOqnxOHcDaT3QucAcb8ScSMLgkRQrbAv7wt23NlvPMC36pgUo1A5u
         /nb42/E2Iy5RBhcitd7iTPV6/X5CV5hKJz0qgOwOKNUNLkJ6iYW+mTp4k5KLaSNWy7SF
         UUagTwm63asMsysFN24/2Y0Zb0Wk+Zmuj9mUO0MKc9K6MdLElKOLcl68HqRkwgt/k56C
         CtoQ==
X-Gm-Message-State: APjAAAXXja3OtUZugE+1G7iNBxkdKyCyQed33wlEBaD5gL/uKdZv6eFb
        JzsOuPvbY6z3kk1ULdUwFw==
X-Google-Smtp-Source: APXvYqxM9n9jUehaPoDUkjLcg71MT46PUEqivMh5AfPwwaW1yPIijflLW5J8dPQdilMcg/UbuPNGhg==
X-Received: by 2002:a9d:4501:: with SMTP id w1mr4457932ote.239.1570648586846;
        Wed, 09 Oct 2019 12:16:26 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y6sm959195oiy.45.2019.10.09.12.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 12:16:26 -0700 (PDT)
Date:   Wed, 9 Oct 2019 14:16:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Talel Shenhar <talel@amazon.com>
Cc:     mark.rutland@arm.com, bp@alien8.de, mchehab@kernel.org,
        james.morse@arm.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, paulmck@linux.ibm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, dwmw@amazon.co.uk,
        benh@kernel.crashing.org, hhhawa@amazon.com, ronenk@amazon.com,
        jonnyc@amazon.com, hanochu@amazon.com, amirkl@amazon.com,
        barakw@amazon.com
Subject: Re: [PATCH v3 1/2] dt-bindings: edac: al-mc-edac: Amazon's Annapurna
 Labs Memory Controller EDAC
Message-ID: <20191009191625.GA8179@bogus>
References: <1570103363-21486-1-git-send-email-talel@amazon.com>
 <1570103363-21486-2-git-send-email-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570103363-21486-2-git-send-email-talel@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Oct 03, 2019 at 02:49:22PM +0300, Talel Shenhar wrote:
> Document Amazon's Annapurna Labs Memory Controller EDAC SoC binding.
> 
> Signed-off-by: Talel Shenhar <talel@amazon.com>
> ---
>  .../bindings/edac/amazon,al-mc-edac.yaml           | 40 ++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml
> 
> diff --git a/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml b/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml
> new file mode 100644
> index 0000000..33da051
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: GPL-2.0
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
> +    - const: "amazon,al-mc-edac"

Fails 'make dt_binding_check'. Drop the '-' as a property is not a list.

The "" are also unnecessary.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    edac@f0080000 {
> +      compatible = "amazon,al-mc-edac";
> +      reg = <0x0 0xf0080000 0x0 0x00010000>;
> +      interrupt-parent = <&amazon_al_system_fabric>;
> +      interrupt-names = "ue";

Need to document the name or drop as -names on a single entry is 
pointless.

> +      interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
> +    };
> -- 
> 2.7.4
> 
