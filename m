Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECAF0126418
	for <lists+linux-edac@lfdr.de>; Thu, 19 Dec 2019 14:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfLSN6f (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 19 Dec 2019 08:58:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:44810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726712AbfLSN6f (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 19 Dec 2019 08:58:35 -0500
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB73024680;
        Thu, 19 Dec 2019 13:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576763914;
        bh=JOfDuzbX5KhFQruw5/hk7NXJKA6KWbQ5U0uen+8uMe8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W/fJRZXBUvYkHq3JlwObr/7TxhyVP73UtkCQDHeP+pZ0z2sFRgmyKrlQRpaf9uD8O
         jR8ZeleXC8Rgbf8v2xJT4CPTvh/cUiNjKj1UhTWbOHHGBu4aEJQwJF8vImJN1phNY6
         exOXosUCscOy4yKa7VEWdiEgSdYqzmkhIc/Z2TIc=
Received: by mail-qk1-f174.google.com with SMTP id z76so5046023qka.2;
        Thu, 19 Dec 2019 05:58:33 -0800 (PST)
X-Gm-Message-State: APjAAAWmTcCt7Tfqb7Av36vibksl2RcpNQpmRWVsAE59ReCj363Q4BgC
        5PQZMcqhDXOnbxePZZcCBJKeCc7+WW0zQYuUrg==
X-Google-Smtp-Source: APXvYqxIEdSdLGQ1r7BdWufTzQ/ecvo0rjriE1A6fphicM+PwzjpRWbhhJbCCHPqP1QOATmIWvV31zWPninmnAf8LbY=
X-Received: by 2002:a37:a70b:: with SMTP id q11mr8042276qke.393.1576763912999;
 Thu, 19 Dec 2019 05:58:32 -0800 (PST)
MIME-Version: 1.0
References: <cover.1575529553.git.saiprakash.ranjan@codeaurora.org>
 <0101016ed57a3259-eee09e9e-e99a-40f1-ab1c-63e58a42615c-000000@us-west-2.amazonses.com>
 <20191218233714.GA30302@bogus> <7469b239edd4beed3e8fefdf02f10ada@codeaurora.org>
In-Reply-To: <7469b239edd4beed3e8fefdf02f10ada@codeaurora.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 19 Dec 2019 07:58:21 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL-uBGy5ekHUZAJB4L1QYoCpnOw-4QPpZraXnsZ49wZ6w@mail.gmail.com>
Message-ID: <CAL_JsqL-uBGy5ekHUZAJB4L1QYoCpnOw-4QPpZraXnsZ49wZ6w@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: edac: Add DT bindings for Kryo EDAC
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        linux-edac <linux-edac@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Trilok Soni <tsoni@codeaurora.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Dec 19, 2019 at 12:50 AM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Hi Rob,
>
> On 2019-12-19 05:07, Rob Herring wrote:
> > On Thu, Dec 05, 2019 at 09:53:05AM +0000, Sai Prakash Ranjan wrote:
> >> This adds DT bindings for Kryo EDAC implemented with RAS
> >> extensions on KRYO{3,4}XX CPU cores for reporting of cache
> >> errors.
> >>
> >> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> >> ---
> >>  .../bindings/edac/qcom-kryo-edac.yaml         | 67
> >> +++++++++++++++++++
> >>  1 file changed, 67 insertions(+)
> >>  create mode 100644
> >> Documentation/devicetree/bindings/edac/qcom-kryo-edac.yaml
> >>
> >> diff --git
> >> a/Documentation/devicetree/bindings/edac/qcom-kryo-edac.yaml
> >> b/Documentation/devicetree/bindings/edac/qcom-kryo-edac.yaml
> >> new file mode 100644
> >> index 000000000000..1a39429a73b4
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/edac/qcom-kryo-edac.yaml
> >> @@ -0,0 +1,67 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/edac/qcom-kryo-edac.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Kryo Error Detection and Correction(EDAC)
> >> +
> >> +maintainers:
> >> +  - Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> >> +
> >> +description: |
> >> +  Kryo EDAC is defined to describe on-chip error detection and
> >> correction
> >> +  for the Kryo CPU cores which implement RAS extensions. It will
> >> report
> >> +  all Single Bit Errors and Double Bit Errors found in L1/L2 caches
> >> in
> >> +  in two registers ERXSTATUS_EL1 and ERXMISC0_EL1. L3-SCU cache
> >> errors
> >> +  are reported in ERR1STATUS and ERR1MISC0 registers.
> >> +    ERXSTATUS_EL1 - Selected Error Record Primary Status Register,
> >> EL1
> >> +    ERXMISC0_EL1 - Selected Error Record Miscellaneous Register 0,
> >> EL1
> >> +    ERR1STATUS - Error Record Primary Status Register
> >> +    ERR1MISC0 - Error Record Miscellaneous Register 0
> >> +  Current implementation of Kryo ECC(Error Correcting Code) mechanism
> >> is
> >> +  based on interrupts.
> >> +
> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - qcom,kryo-edac
> >> +
> >> +  interrupts:
> >> +    minItems: 1
> >> +    maxItems: 4
> >> +    items:
> >> +      - description: l1-l2 cache faultirq interrupt
> >> +      - description: l1-l2 cache errirq interrupt
> >> +      - description: l3-scu cache errirq interrupt
> >> +      - description: l3-scu cache faultirq interrupt
> >> +
> >> +  interrupt-names:
> >> +    minItems: 1
> >> +    maxItems: 4
> >
> > You are saying only these combinations are valid:
> >
> > l1-l2-faultirq
> >
> > l1-l2-faultirq
> > l1-l2-errirq
> >
> > l1-l2-faultirq
> > l1-l2-errirq
> > l3-scu-errirq
> >
> > l1-l2-faultirq
> > l1-l2-errirq
> > l3-scu-errirq
> > l3-scu-faultirq
> >
> > Is that your intent?
> >
>
> No, I want any combination of interrupts to be valid with atleast one
> interrupt as mandatory.
> I thought specifying minItems as 1 and maxItems as 4 will take care of
> this,  am I doing something wrong?

Interrupts (really all properties) have a defined order in DT and an
'items' list defines both the order and index. You'll need to use
oneOf and list out the possibilities. Stick to ones you actually need.

Rob
