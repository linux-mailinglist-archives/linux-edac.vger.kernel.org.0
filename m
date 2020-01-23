Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE5014696D
	for <lists+linux-edac@lfdr.de>; Thu, 23 Jan 2020 14:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgAWNoq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Jan 2020 08:44:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:33630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbgAWNoq (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 23 Jan 2020 08:44:46 -0500
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C9E024688;
        Thu, 23 Jan 2020 13:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579787085;
        bh=ehtW9l9ACdNUpNo6gsMIkwoNpfOA6s3D+OSmNLbylzQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f6itICyEccPeU2EkmbAw44eFVsEnQiCvVRTYc3RMmfw1f5V5rghHrFdF6dnC+r1wV
         LW0nDwCzxH/GTTtVFZtYGJLOP+nJu1VWepUnkNyHvE63DC36JQuxG/BFcyxUuYXolx
         hnkuLUgk7s2DCpWGgBq76zQCpyZ5Of2xjyCLBDDQ=
Received: by mail-qk1-f169.google.com with SMTP id c17so3403985qkg.7;
        Thu, 23 Jan 2020 05:44:45 -0800 (PST)
X-Gm-Message-State: APjAAAVGqpIIeB5KV3T+3vZXkfcRfIR9lYyS07oqlxR+975ItnwWTjCS
        hGYipOYanfuv1/Pzjs8/SQjtSXIWl9u92Es0lQ==
X-Google-Smtp-Source: APXvYqwj1kYyeJq3Ccl1DyDpR3KLsILueUjym2UJmfupNznTqTkOSej7+FQVm2ExBXPWgHI5dXhLnNyU9f/PKwvhq6E=
X-Received: by 2002:a05:620a:1eb:: with SMTP id x11mr16326677qkn.254.1579787084251;
 Thu, 23 Jan 2020 05:44:44 -0800 (PST)
MIME-Version: 1.0
References: <09a2fe69-842f-01cf-1cfa-d5fc639b158a@gmail.com>
In-Reply-To: <09a2fe69-842f-01cf-1cfa-d5fc639b158a@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 23 Jan 2020 07:44:32 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+1S=mOS0-eb0=ibSn81ReDmDjrA9=bHpKC16w8B6Aq3Q@mail.gmail.com>
Message-ID: <CAL_Jsq+1S=mOS0-eb0=ibSn81ReDmDjrA9=bHpKC16w8B6Aq3Q@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] dt-bindings: edac: dmc-520.yaml
To:     Shiping Ji <shiping.linux@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, hangl@microsoft.com,
        Lei Wang <lewan@microsoft.com>, ruizhao@microsoft.com,
        shji@microsoft.com, Scott Branden <scott.branden@broadcom.com>,
        Yuqing Shen <yuqing.shen@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jan 22, 2020 at 6:31 PM Shiping Ji <shiping.linux@gmail.com> wrote:
>
> This is the device tree bindings for new EDAC driver dmc520_edac.c.
>
> From: Lei Wang <leiwang_git@outlook.com>
>
> Signed-off-by: Lei Wang <leiwang_git@outlook.com>
> Signed-off-by: Shiping Ji <shiping.linux@gmail.com>
> Reviewed-by: James Morse <james.morse@arm.com>
>
> ---
>      Changes in v10:
>          - Convert to the YAML format for binding description
>
> ---
>  .../devicetree/bindings/edac/dmc-520.yaml     | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/dmc-520.yaml
>
> diff --git a/Documentation/devicetree/bindings/edac/dmc-520.yaml b/Documentation/devicetree/bindings/edac/dmc-520.yaml
> new file mode 100644
> index 000000000000..dd5982b227b2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/edac/dmc-520.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license new bindings please:

(GPL-2.0-only OR BSD-2-Clause)

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/edac/dmc-520.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ARM DMC-520 EDAC bindings
> +
> +maintainers:
> +  - Lei Wang <lewan@microsoft.com>
> +
> +description: |+
> +  DMC-520 node is defined to describe DRAM error detection and correction.
> +
> +  https://static.docs.arm.com/100000/0200/corelink_dmc520_trm_100000_0200_01_en.pdf
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: brcm,dmc-520
> +      - const: arm,dmc-520
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 1
> +
> +  interrupt-names:
> +    minItems: 1
> +    items:
> +      - const: ram_ecc_errc
> +      - const: ram_ecc_errd
> +      - const: dram_ecc_errc
> +      - const: dram_ecc_errd
> +      - const: failed_access
> +      - const: failed_prog
> +      - const: link_err
> +      - const: temperature_event
> +      - const: arch_fsm
> +      - const: phy_request

This defines not just the names, but the index they must be at which I
don't think you want.

minItems: 1
maxItems: 10
items:
  enum:
    - ram_ecc_errc
    - ram_ecc_errd
    ...

Note the lack of '-' under 'items' making it a schema that applies to all items.

Run 'make dt_binding_check' as that would have caught this issue on the example.

Rob
