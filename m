Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDFC26B2E8
	for <lists+linux-edac@lfdr.de>; Wed, 16 Sep 2020 00:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbgIOWzh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Sep 2020 18:55:37 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36338 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbgIOPYm (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 15 Sep 2020 11:24:42 -0400
Received: by mail-io1-f66.google.com with SMTP id d190so4523138iof.3;
        Tue, 15 Sep 2020 08:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TQwbsrSpPsblvvewNTAvygU6LX9JkoPG3XT5duFS2B8=;
        b=pMa5QV6rMAf2UdR/IH7HVyXxjxlV9j/Ul8p4ApSo4Kx8qYkfv1XQ8mo3567ojZEszO
         5ozjTyPxqBj5MSdOqddKPzohM6EW0AEiPY5yWuUG0K30hx9hGSixEpmZEsqk/Jgjsp11
         5Amn2G9hyTLVcbf0jCq5nFFEE6eN4PNB+rgD0vfRV+evLEV6OeR+I/ywK8lGeoRsSoD8
         dM5tAXYfC35vmXY7eXaqSD1qp9ZMe95bsyUNJXa6MHrCoMYuos5R1/BOnsb1rsXl50/1
         UA7MASY7RDgFcjKXo6BRHTN1OitNgM6/MwbfEJPIe6sltOOYpLmE6jIbTWp/1lhvDJT9
         jXbA==
X-Gm-Message-State: AOAM5332WGfC6JA3bWEU4g8v9YIudeuQQxFSYiM0NVDlF0f6bsKsjb+R
        9eTmsaaKRVDkfdhOIjNnQA==
X-Google-Smtp-Source: ABdhPJyqKFyTIVHyJqHIrEsdIMGqq15HhgpOa6nWJTDsqIgRo7dmwPY2ATDZsR/bup7/2N61XSAUZw==
X-Received: by 2002:a05:6602:2c4d:: with SMTP id x13mr10837671iov.94.1600183478508;
        Tue, 15 Sep 2020 08:24:38 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id i9sm4609484ils.34.2020.09.15.08.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 08:24:37 -0700 (PDT)
Received: (nullmailer pid 1973925 invoked by uid 1000);
        Tue, 15 Sep 2020 15:24:35 -0000
Date:   Tue, 15 Sep 2020 09:24:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com, bp@alien8.de,
        mchehab@kernel.org, tony.luck@intel.com, aou@eecs.berkeley.edu,
        james.morse@arm.com, rrichter@marvell.com,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        sachin.ghadi@sifive.com
Subject: Re: [PATCH v2 1/3] dt-bindings: riscv: Add DT documentation for DDR
 Controller in SiFive SoCs
Message-ID: <20200915152435.GB1940827@bogus>
References: <1599457679-8947-1-git-send-email-yash.shah@sifive.com>
 <1599457679-8947-2-git-send-email-yash.shah@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599457679-8947-2-git-send-email-yash.shah@sifive.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Sep 07, 2020 at 11:17:57AM +0530, Yash Shah wrote:
> Add device tree bindings for SiFive FU540 DDR controller driver
> 
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
> ---
>  .../devicetree/bindings/riscv/sifive-ddr.yaml      | 41 ++++++++++++++++++++++

Bindings are organized by function, not vendor/arch generally. This goes 
in bindings/memory-controllers/.

>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/riscv/sifive-ddr.yaml
> 
> diff --git a/Documentation/devicetree/bindings/riscv/sifive-ddr.yaml b/Documentation/devicetree/bindings/riscv/sifive-ddr.yaml
> new file mode 100644
> index 0000000..0288119
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/riscv/sifive-ddr.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/riscv/sifive-ddr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SiFive DDR memory controller binding
> +
> +description: |
> +  The Sifive DDR controller driver is used to manage the Cadence DDR
> +  controller present in SiFive FU540-C000 SoC. Currently the driver is
> +  used to manage EDAC feature of the DDR controller.

Bindings describe h/w not drivers. What a driver supports is irrelevant.

> +
> +maintainers:
> +  - Yash Shah <yash.shah@sifive.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sifive,fu540-c000-ddr
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
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    memory-controller@100b0000 {
> +        compatible = "sifive,fu540-c000-ddr";
> +        reg = <0x100b0000 0x4000>;
> +        interrupts = <31>;
> +    };
> -- 
> 2.7.4
> 
