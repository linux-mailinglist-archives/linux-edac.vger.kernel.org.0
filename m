Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2F0251CD0
	for <lists+linux-edac@lfdr.de>; Tue, 25 Aug 2020 18:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgHYQDY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 25 Aug 2020 12:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgHYQCx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 25 Aug 2020 12:02:53 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0C0C0613ED
        for <linux-edac@vger.kernel.org>; Tue, 25 Aug 2020 09:02:53 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g33so7130431pgb.4
        for <linux-edac@vger.kernel.org>; Tue, 25 Aug 2020 09:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=KPkLZJgZoXiLJffiihBupgXf4zrj4jokhwZeTXsnTGE=;
        b=aDlbWI41jY6pIx7QLbALlOlZ4VvpjQBnUpX9orTDHefzfXPlapLoMkrMZ01zGUGjk8
         5ahNPY6spEthv1QWrR2y6eWmBHQrMNSONkdxxlTzXsffWrylY9+6K8P6ryiPVZ5WC1i+
         4z/KKPpPw2+JBaAMNJd6/0F8hO4uMJesatg0sZ4G4KGpZvLHTNAJrIMjLsgAEPspW9/V
         F667p0bwmn6FmU5BjKJYD3VnPBir5RlBT8DF/w92lvjhisgnwK9VX0c+gBBptGF/KWl8
         aAR9hrR6lVF4ylWYCyLoToNz+ozfJSwdPXe6pbX1Xr2Mg3ImhrSwbrwNFnWxfJR7L7B8
         ukoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=KPkLZJgZoXiLJffiihBupgXf4zrj4jokhwZeTXsnTGE=;
        b=fN3duVy+LCjRrASlwuKhjaBrsyopVhvvrFvdoRLremKXwToNbBz4BvW64G2c+xZpkx
         MOgxxVwL1k6DpB5VmeoFuaUZbklsp8C4WxKTC8JtmN9MVMhLDWHFv/BcnJ2d0se1D3kz
         YVPGf8o4hFOARfOz5fAcAhY7ci4NpVbfVap0OalW3AOULieC+BufF0TQ711z5BdHQRQw
         /1lqqobZyLYcJAmcmVeoFVn1eZb4DAzZZueZGoSHdnJyKLLj1MKyCdh9rEFwLBLjZbKv
         WSe1Law27OdR+mFPnYGq4O7QNIq/c5KCDfltxXSzumyg6zuO541bt+7uYJmuT8TSGhdS
         7yWQ==
X-Gm-Message-State: AOAM530568wVhCROOwNQKzSL2fR1wBwXbWvFu+SnQuDyFgTGa2FtEGgv
        7AJrXL272XIJ9zQNHOoR2dD/ow==
X-Google-Smtp-Source: ABdhPJwFkVnCpRijagKF/eo1R4lg5/JWfJN9V6X1I79qjxwyzwaRx8jYAPMLkIGwV6qy4eXXe+qikQ==
X-Received: by 2002:a63:4f22:: with SMTP id d34mr7393022pgb.320.1598371372168;
        Tue, 25 Aug 2020 09:02:52 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id s125sm15564588pfb.125.2020.08.25.09.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 09:02:51 -0700 (PDT)
Date:   Tue, 25 Aug 2020 09:02:51 -0700 (PDT)
X-Google-Original-Date: Tue, 25 Aug 2020 08:24:30 PDT (-0700)
Subject:     Re: [PATCH 1/3] dt-bindings: riscv: Add DT documentation for DDR Controller in SiFive SoCs
In-Reply-To: <1598357182-4226-2-git-send-email-yash.shah@sifive.com>
CC:     robh+dt@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        aou@eecs.berkeley.edu, james.morse@arm.com, rrichter@marvell.com,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        sachin.ghadi@sifive.com, yash.shah@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     yash.shah@sifive.com
Message-ID: <mhng-45ab2484-537a-45da-8fb2-b19329728caa@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, 25 Aug 2020 05:06:20 PDT (-0700), yash.shah@sifive.com wrote:
> Add device tree bindings for SiFive FU540 DDR controller driver
>
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> ---
>  .../devicetree/bindings/riscv/sifive-ddr.yaml      | 41 ++++++++++++++++++++++
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

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
