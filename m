Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 071801257D5
	for <lists+linux-edac@lfdr.de>; Thu, 19 Dec 2019 00:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfLRXhR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 18 Dec 2019 18:37:17 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36505 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLRXhR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 18 Dec 2019 18:37:17 -0500
Received: by mail-ot1-f65.google.com with SMTP id w1so4607351otg.3;
        Wed, 18 Dec 2019 15:37:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rVq3FctMUlxxbFCAv4Hq3F1IucA62kHuaSw0yCHlOq8=;
        b=beH6OFUWr5JKlMtvSveZhc4RtA5nbTOiRLI19KLI8OXc7pE5AdYZK1D+eNZ3/LUV5c
         nMLWAx+I7VSTSn4ycvSFbqCuTfP95CwiC2FZhd2i8EfYpIHSz+bhzW/tCJaec3qGvvsI
         ++XTzSgYa5teSPCfd0Snf0wVBw2k2+S3a4VhWJMXgbzhsu1kiLUnxEP6N6EEpA29iess
         OKPeJVpM2C4p9v0+CQBnY0WaM7ZcSSQcivKQllDFJbkQVbIvWYz6XAsZ2UCglkAGnM/l
         ggWoikGUEVjfBRjIa+oyokyA+zZcQhKpU9bCxKjqwYDJrKGj5T+BxSm76t0OXeTYFlhG
         mrzg==
X-Gm-Message-State: APjAAAUEYegaIh3iDUR6LCxmvTU/isEeOkh2xZAGI3L+FhmfAhtArURa
        aDWM2Sngm2SOb4Kdpz9GWA==
X-Google-Smtp-Source: APXvYqyPh+4IInW14BHCfGHQzEnJR270O8hYZIX77r6+KeTYekhQCeI3drPFmDyVwEvselhJDCNYTg==
X-Received: by 2002:a9d:2482:: with SMTP id z2mr5197001ota.279.1576712236059;
        Wed, 18 Dec 2019 15:37:16 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c12sm1358241oic.27.2019.12.18.15.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 15:37:15 -0800 (PST)
Date:   Wed, 18 Dec 2019 17:37:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        linux-edac@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>, tsoni@codeaurora.org,
        psodagud@codeaurora.org
Subject: Re: [PATCH 1/2] dt-bindings: edac: Add DT bindings for Kryo EDAC
Message-ID: <20191218233714.GA30302@bogus>
References: <cover.1575529553.git.saiprakash.ranjan@codeaurora.org>
 <0101016ed57a3259-eee09e9e-e99a-40f1-ab1c-63e58a42615c-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0101016ed57a3259-eee09e9e-e99a-40f1-ab1c-63e58a42615c-000000@us-west-2.amazonses.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Dec 05, 2019 at 09:53:05AM +0000, Sai Prakash Ranjan wrote:
> This adds DT bindings for Kryo EDAC implemented with RAS
> extensions on KRYO{3,4}XX CPU cores for reporting of cache
> errors.
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  .../bindings/edac/qcom-kryo-edac.yaml         | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/qcom-kryo-edac.yaml
> 
> diff --git a/Documentation/devicetree/bindings/edac/qcom-kryo-edac.yaml b/Documentation/devicetree/bindings/edac/qcom-kryo-edac.yaml
> new file mode 100644
> index 000000000000..1a39429a73b4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/edac/qcom-kryo-edac.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/edac/qcom-kryo-edac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Kryo Error Detection and Correction(EDAC)
> +
> +maintainers:
> +  - Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> +
> +description: |
> +  Kryo EDAC is defined to describe on-chip error detection and correction
> +  for the Kryo CPU cores which implement RAS extensions. It will report
> +  all Single Bit Errors and Double Bit Errors found in L1/L2 caches in
> +  in two registers ERXSTATUS_EL1 and ERXMISC0_EL1. L3-SCU cache errors
> +  are reported in ERR1STATUS and ERR1MISC0 registers.
> +    ERXSTATUS_EL1 - Selected Error Record Primary Status Register, EL1
> +    ERXMISC0_EL1 - Selected Error Record Miscellaneous Register 0, EL1
> +    ERR1STATUS - Error Record Primary Status Register
> +    ERR1MISC0 - Error Record Miscellaneous Register 0
> +  Current implementation of Kryo ECC(Error Correcting Code) mechanism is
> +  based on interrupts.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,kryo-edac
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 4
> +    items:
> +      - description: l1-l2 cache faultirq interrupt
> +      - description: l1-l2 cache errirq interrupt
> +      - description: l3-scu cache errirq interrupt
> +      - description: l3-scu cache faultirq interrupt
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 4

You are saying only these combinations are valid:

l1-l2-faultirq

l1-l2-faultirq
l1-l2-errirq

l1-l2-faultirq
l1-l2-errirq
l3-scu-errirq

l1-l2-faultirq
l1-l2-errirq
l3-scu-errirq
l3-scu-faultirq

Is that your intent?

> +    items:
> +      - const: l1-l2-faultirq
> +      - const: l1-l2-errirq
> +      - const: l3-scu-errirq
> +      - const: l3-scu-faultirq
> +
> +required:
> +  - compatible
> +  - interrupts
> +  - interrupt-names
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    kryo_edac {
> +      compatible = "qcom,kryo-edac";
> +      interrupts = <GIC_PPI 6 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> +      interrupt-names = "l1-l2-faultirq",
> +                        "l1-l2-errirq",
> +                        "l3-scu-errirq",
> +                        "l3-scu-faultirq";
> +    };
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
