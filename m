Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7DBF1469AA
	for <lists+linux-edac@lfdr.de>; Thu, 23 Jan 2020 14:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgAWNsY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Jan 2020 08:48:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:35894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727194AbgAWNsX (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 23 Jan 2020 08:48:23 -0500
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BB2A24688;
        Thu, 23 Jan 2020 13:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579787302;
        bh=FoxHytvieeiMR5w2vCjs+iRWN/xe1IbjBrRYYeIbBXI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1AS+dHLPP5rAH9T5VHs73GXahPyDACd7SwtCJD7VthNa8rx17bY8byQrbZdLVw6st
         /McONvPTX31f0ZJEautzgUfWGlos9MYkPATUg7nOUBZrdeGgNfy+FlwtBpEwdmxnNE
         u2QibjRJJeoNrPtP39MgM13THZKJCOfzOCTNaVJU=
Received: by mail-qt1-f174.google.com with SMTP id c24so2475643qtp.5;
        Thu, 23 Jan 2020 05:48:22 -0800 (PST)
X-Gm-Message-State: APjAAAXKuxRZTOQmoiUrYjuSIMALCSfn0oJa/JIzrfJF4SonCBnu6tTp
        WTRRDGH6j0aih2zQ5+4bWp7VoeInTfYxWSjUig==
X-Google-Smtp-Source: APXvYqzeZnbmbU5C7iKeSjGcGtjCWg8yrdnvL6IUNbFeEnrmCjkbaCvNa0W8VIm6gLl/nyiVJznT6alXW1omCkLRUg0=
X-Received: by 2002:ac8:6747:: with SMTP id n7mr15914499qtp.224.1579787301560;
 Thu, 23 Jan 2020 05:48:21 -0800 (PST)
MIME-Version: 1.0
References: <09a2fe69-842f-01cf-1cfa-d5fc639b158a@gmail.com>
In-Reply-To: <09a2fe69-842f-01cf-1cfa-d5fc639b158a@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 23 Jan 2020 07:48:09 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKvFt=BM2BD9HXSEZOAzEnDwAzj7f8pGRnApA8Mp7qxBg@mail.gmail.com>
Message-ID: <CAL_JsqKvFt=BM2BD9HXSEZOAzEnDwAzj7f8pGRnApA8Mp7qxBg@mail.gmail.com>
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

You also need 'maxItems: 10' here.
