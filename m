Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 312DBE1F6F
	for <lists+linux-edac@lfdr.de>; Wed, 23 Oct 2019 17:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392451AbfJWPhx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Oct 2019 11:37:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390400AbfJWPhx (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 23 Oct 2019 11:37:53 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60F0021A4A;
        Wed, 23 Oct 2019 15:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571845071;
        bh=4CP2ycU+E6K5fjkBXPL4B0R3el922R8lqyX1rX3+y/Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xhyz2fKUP6xWdPpOnNhE3QoNFZoi+xgI4KmrIfstsv2MJRBuQBMfqeIM3T6W+k3Oc
         FavuXjHQcKWIUbvYRpaTAgd6FdTC7wpqrCck3u4UY+r/7eIFezjnRVbmxlsXbNEiVr
         Ngz7TndveHL0+z8GdQDpYm9AwCVPxqyad/8D8YBA=
Received: by mail-qk1-f181.google.com with SMTP id 71so16291186qkl.0;
        Wed, 23 Oct 2019 08:37:51 -0700 (PDT)
X-Gm-Message-State: APjAAAV2tiDh4VoehHaN+jgmTRuBDdn5hfj8I5l/TMbJGsqxzDa5mYWz
        aBIIWQOpLWGxhzRKpy+ttli7GmGmR0B2wH8Lng==
X-Google-Smtp-Source: APXvYqxHwHxGB2KG39VmZoeZDpBh35nE31eyksvPPkWeP0mtHx0PqbFk5yhV6ecorTgDYforRDBf+vXgZrZpHZA43ms=
X-Received: by 2002:a05:620a:12f1:: with SMTP id f17mr9010262qkl.152.1571845070465;
 Wed, 23 Oct 2019 08:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <BY5PR04MB6599EAA659A53B2331CB812586890@BY5PR04MB6599.namprd04.prod.outlook.com>
In-Reply-To: <BY5PR04MB6599EAA659A53B2331CB812586890@BY5PR04MB6599.namprd04.prod.outlook.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 23 Oct 2019 10:37:38 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJxcUr06+O_Ht5Kw0KXCWfSVC+6WMQqNxt-JehHh874hw@mail.gmail.com>
Message-ID: <CAL_JsqJxcUr06+O_Ht5Kw0KXCWfSVC+6WMQqNxt-JehHh874hw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: edac: arm-dmc520.txt
To:     Lei Wang <leiwang_git@outlook.com>
Cc:     "bp@alien8.de" <bp@alien8.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Sep 19, 2019 at 1:37 PM Lei Wang <leiwang_git@outlook.com> wrote:
>
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
> +- compatible           : "brcm,dmc-520", "arm,dmc-520".
> +- reg                  : Address range of the DMC-520 registers.
> +- interrupts           : DMC-520 interrupt numbers. The example below specifies
> +                         two interrupt lines for dram_ecc_errc_int and
> +                         dram_ecc_errd_int.
> +- interrupt-config     : This is an array of interrupt masks. For each of the

Not a standard property, so would need a vendor prefix...

> +                         above interrupt line, add one interrupt mask element to
> +                         it. That is, there is a 1:1 mapping from each interrupt
> +                         line to an interrupt mask. An interrupt mask can represent
> +                         multiple interrupts being enabled. Refer to interrupt_control
> +                         register in DMC-520 TRM for interrupt mapping. In the example
> +                         below, the interrupt configuration enables dram_ecc_errc_int
> +                         and dram_ecc_errd_int. And each interrupt is connected to
> +                         a separate interrupt line.

I've gone and read thru the TRM some. This binding doesn't seem to
correspond to the TRM at all. There are a bunch of interrupts and a
combined interrupt, and then there's the same set for 'overflow'
interrupts.

There's only one 'interrupt_control' reg. How do you have more that 1
32-bit value?

> +
> +Example:
> +
> +dmc0: dmc@200000 {
> +       compatible = "brcm,dmc-520", "arm,dmc-520";
> +       reg = <0x200000 0x80000>;
> +       interrupts = <0x0 0x349 0x4>, <0x0 0x34B 0x4>;
> +       interrupt-config = <0x4>, <0x8>;
> +};
> --
> 2.17.1
>
