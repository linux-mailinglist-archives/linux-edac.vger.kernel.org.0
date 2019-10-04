Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1BC1CBE81
	for <lists+linux-edac@lfdr.de>; Fri,  4 Oct 2019 17:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389086AbfJDPGH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 4 Oct 2019 11:06:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388802AbfJDPGG (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 4 Oct 2019 11:06:06 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2F84222C5;
        Fri,  4 Oct 2019 15:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570201566;
        bh=ifVQrGSy8sTxcjfmw09jKYMnUsVYPbqc/k1c/mJKx7U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KMJxwZjWxsiCtY2+bK+rBWW85cXT26aQdJuMBhbBHMQ5MtInnXOa8mz0sL/4HO8vb
         DIA0N4foWLqxE3eIorWOUFa08zx8K2zeiUJrmR+bw2D5mQjE9dnKpijXb++oMvBY/s
         np0rKLh7T0jHJvElwIVnEpt3jb9WAbzoiEc4xTdU=
Received: by mail-qk1-f179.google.com with SMTP id u22so6058885qkk.11;
        Fri, 04 Oct 2019 08:06:05 -0700 (PDT)
X-Gm-Message-State: APjAAAWkxWE2pWM6OWcz0+28RyP4yhsTKu3wNnSlOrgQWhBvPQohvTaK
        yAZTC3yXQV9qcaDs87kuZgP+nLj0e3Px2pnUGA==
X-Google-Smtp-Source: APXvYqyhSeo813U5at2ypaS7hws+Iuy5Gbmn3hYo0nmzLOaFg0AkHoBwe3JoLdt+swzNRA9tK0SlsVqKUS+auwmrFdI=
X-Received: by 2002:a05:620a:7da:: with SMTP id 26mr9666137qkb.119.1570201564956;
 Fri, 04 Oct 2019 08:06:04 -0700 (PDT)
MIME-Version: 1.0
References: <1570102361-11696-1-git-send-email-talel@amazon.com> <1570102361-11696-2-git-send-email-talel@amazon.com>
In-Reply-To: <1570102361-11696-2-git-send-email-talel@amazon.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 4 Oct 2019 10:05:53 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJDJF7h=nSw3dkNF=H3ghJeLR=MUgrEh+qxw0jhDnfxFw@mail.gmail.com>
Message-ID: <CAL_JsqJDJF7h=nSw3dkNF=H3ghJeLR=MUgrEh+qxw0jhDnfxFw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: soc: al-pos: Amazon's Annapurna Labs POS
To:     Talel Shenhar <talel@amazon.com>
Cc:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Hawa, Hanna" <hhhawa@amazon.com>,
        "Krupnik, Ronen" <ronenk@amazon.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        "Hanoch, Uri" <hanochu@amazon.com>, amirkl@amazon.com,
        "Wasserstrom, Barak" <barakw@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Oct 3, 2019 at 6:33 AM Talel Shenhar <talel@amazon.com> wrote:
>
> Document Amazon's Annapurna Labs POS SoC binding.
>
> Signed-off-by: Talel Shenhar <talel@amazon.com>
> ---
>  .../bindings/edac/amazon,al-pos-edac.yaml          | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-pos-edac.yaml
>
> diff --git a/Documentation/devicetree/bindings/edac/amazon,al-pos-edac.yaml b/Documentation/devicetree/bindings/edac/amazon,al-pos-edac.yaml
> new file mode 100644
> index 00000000..7936da0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/edac/amazon,al-pos-edac.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/edac/amazon,al-pos-edac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amazon's Annapurna Labs POS
> +
> +maintainers:
> +  - Talel Shenhar <talel@amazon.com>
> +  - Talel Shenhar <talelshenhar@gmail.com>
> +
> +description: |
> +  POS node is defined to describe the Point Of Serialization (POS) error
> +  detection capability.
> +
> +properties:
> +
> +  compatible:
> +    - const: "amazon,al-pos-edac"

Fails 'make dt_binding_check' (drop the '-'):

warning: no schema found in file:
Documentation/devicetree/bindings/edac/amazon,al-pos-edac.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/edac/amazon,al-pos-edac.yaml:
ignoring, error in schema 'compatible'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/edac/amazon,al-pos-edac.yaml:
properties:compatible: [{'const': 'amazon,al-pos-edac'}] is not of
type 'object', 'boolean'
Documentation/devicetree/bindings/Makefile:12: recipe for target
'Documentation/devicetree/bindings/edac/amazon,al-pos-edac.example.dts'
failed
make[1]: *** [Documentation/devicetree/bindings/edac/amazon,al-pos-edac.example.dts]
Error 1
Makefile:1282: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

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
> +    al_pos_edac@f0070084 {

edac@...

> +      compatible = "amazon,al-pos-edac";
> +      reg = <0x0 0xf0070084 0x0 0x00000008>;
> +      interrupt-parent = <&amazon_system_fabric>;
> +      interrupts = <24 IRQ_TYPE_LEVEL_HIGH>;

Not documented.

> +    };
> --
> 2.7.4
>
