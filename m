Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85FA1A8F4B
	for <lists+linux-edac@lfdr.de>; Wed, 15 Apr 2020 01:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634411AbgDNXty (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 Apr 2020 19:49:54 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42099 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731575AbgDNXtu (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 14 Apr 2020 19:49:50 -0400
Received: by mail-ot1-f68.google.com with SMTP id l21so1594100otd.9;
        Tue, 14 Apr 2020 16:49:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ErGz/RmN1nNcMdKysMZ4QZyfLOTmTqEmcgzrHidWa00=;
        b=ZWlJ/WpzzGu9qjM6IHUPGp3r7lcNJkd1Jz/xzLAVSkcFmlle0/tn4byoxvyup8gVxF
         QVCUtEzU5gBMY/AJ3x1AqFf93UKvnZsglCX7mfvtVQggSDqHVuOWVtVlptvz0JS8rZkN
         oRWMSGFgaM9mqxz6lxbcxVg/hHv5Kk0HXZtf8WVJe7aq1hGsAJ5elcURsdbVaffCh1NZ
         0WK7oNIK2GnKEG4ONV/2wAhDcQpndjuiBTi5XzCNPcwCe2zZdHPu6CFruRO3arwzfqX/
         NOQjg9xyfxz7F16hmNB8NPD9+c1uVFU/T/a/4HrONSxajZZp/CbXqaWVUhmKA0th6yeU
         dkVg==
X-Gm-Message-State: AGi0PuY14HRlCkA/ovHyYmvirOqpIjHJ1QUEFYq7k0/lCX8mrzxt7ft2
        Fq7Ivb/21VIvFSYZPVc2kA==
X-Google-Smtp-Source: APiQypJZufTrwX1G/fitQmoTtHPOYT+eQR62XJjFIzEKrvQjyVS3XgX0fIR0P3iFCf2lzUhQvtbcGw==
X-Received: by 2002:a9d:441:: with SMTP id 59mr10612961otc.236.1586908189851;
        Tue, 14 Apr 2020 16:49:49 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l7sm5632301otj.52.2020.04.14.16.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 16:49:49 -0700 (PDT)
Received: (nullmailer pid 28246 invoked by uid 1000);
        Tue, 14 Apr 2020 23:49:48 -0000
Date:   Tue, 14 Apr 2020 18:49:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dhananjay Kangude <dkangude@cadence.com>
Cc:     linux-edac@vger.kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org, mparab@cadence.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: edac: Add cadence ddr mc support
Message-ID: <20200414234947.GA24554@bogus>
References: <20200406131341.1253-1-dkangude@cadence.com>
 <20200406131341.1253-2-dkangude@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406131341.1253-2-dkangude@cadence.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Apr 06, 2020 at 03:13:40PM +0200, Dhananjay Kangude wrote:
> Add documentation for cadence ddr memory controller EDAC DTS bindings
> 
> Signed-off-by: Dhananjay Kangude <dkangude@cadence.com>
> ---
>  .../devicetree/bindings/edac/cdns,ddr-edac.yaml    |   47 ++++++++++++++++++++
>  1 files changed, 47 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml
> 
> diff --git a/Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml b/Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml
> new file mode 100644
> index 0000000..30ea757
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml
> @@ -0,0 +1,47 @@
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
> +      - cdns,ddr4-mc

Surely there's more than 1 version?

> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - description:
> +          Register block of DDR/LPDDR apb registers up to mapped area.
> +          Mapped area contains the register set for memory controller,
> +          phy and PI module register set doesn't part of this mapping.

doesn't part of this mapping?

Need a description for the 2nd region.

> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    edac: edac@fd100000 {

memory-controller@

> +        compatible = "cdns,ddr4-mc-edac";

Doesn't match.

> +        reg = <0xfd100000 0x4000>;
> +        interrupts = <0x00 0x01 0x04>;
> +    };
> +...
> -- 
> 1.7.1
> 
