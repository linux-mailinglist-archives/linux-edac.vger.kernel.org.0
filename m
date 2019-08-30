Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F38EEA3FF7
	for <lists+linux-edac@lfdr.de>; Fri, 30 Aug 2019 23:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbfH3Vui (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 30 Aug 2019 17:50:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728111AbfH3Vui (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 30 Aug 2019 17:50:38 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7D7623777;
        Fri, 30 Aug 2019 21:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567201836;
        bh=BMFO/ja6VS575JdKNAgPGs67fG/E1rzTU5Hcuyhlp3Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Xr9EVH03o73fNeuckzt6dLa3FfxpH2GW0Qn7velEm+IuPIc7/1LrPkZz48VRLey21
         PJmaWr/pvtrKOdFuSti/pogGgcUyo+BEHaQUmy7VEFRuPQjhyb70rv7DEtXD+6mq1k
         nuFl+OxgnCkudyUoGKmDHFuuRQsxrnRNbDQDa+BQ=
Received: by mail-qk1-f172.google.com with SMTP id i78so6055249qke.11;
        Fri, 30 Aug 2019 14:50:36 -0700 (PDT)
X-Gm-Message-State: APjAAAWjX9IRdrCZjLH1YCiB/Y90Gk4SGSkWbojJ6QAh9J2obcbbIcej
        RlYZZvSsF2txnTAHMPdBe666KR0yjBguwvtpNw==
X-Google-Smtp-Source: APXvYqw1u/Fyzf4M/pGE0WKEgY1r+h6iNzEwpmsmQCOY+XNy4hoICxOp5eBbsmTiZ2KtNobLJuNgVEJMuuTQythKs2k=
X-Received: by 2002:a37:682:: with SMTP id 124mr17209455qkg.393.1567201835797;
 Fri, 30 Aug 2019 14:50:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190805143911.12185-1-hhhawa@amazon.com> <20190805143911.12185-2-hhhawa@amazon.com>
 <20190821191704.GA32425@bogus> <1d23d7c5-cd7b-1512-5300-d43e82ba6dc1@amazon.com>
 <CAL_Jsq+8jGbR4u7FA8r0gP5i2H+nSgOkGU_5mfiL=i=c0sOW8A@mail.gmail.com> <d46ac081-1867-2997-e2a3-bcfea42b74f3@arm.com>
In-Reply-To: <d46ac081-1867-2997-e2a3-bcfea42b74f3@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 30 Aug 2019 16:50:24 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+95qZyHWT_A-=L+SSbR0vmMqQDq8N2XcxwFJVG2HCthA@mail.gmail.com>
Message-ID: <CAL_Jsq+95qZyHWT_A-=L+SSbR0vmMqQDq8N2XcxwFJVG2HCthA@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] dt-bindings: EDAC: Add Amazon's Annapurna Labs L1 EDAC
To:     James Morse <james.morse@arm.com>
Cc:     "Hawa, Hanna" <hhhawa@amazon.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>, benh@amazon.com,
        "Krupnik, Ronen" <ronenk@amazon.com>,
        Talel Shenhar <talel@amazon.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        "Hanoch, Uri" <hanochu@amazon.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Aug 30, 2019 at 7:45 AM James Morse <james.morse@arm.com> wrote:
>
> Hi guys,
>
> On 27/08/2019 14:49, Rob Herring wrote:
> > On Mon, Aug 26, 2019 at 9:49 AM Hawa, Hanna <hhhawa@amazon.com> wrote:
> >> On 8/21/2019 10:17 PM, Rob Herring wrote:
> >>> Why is this even in DT? AFAICT, this is all just CortexA57 core features
> >>> (i.e. nothing Amazon specific). The core type and the ECC capabilities
> >>> are discoverable.
> >>
> >> Added to the DT in order to easily enable/disable the driver.
> >
> > That alone is not reason enough to put it in DT. From a DT
> > perspective, I have no idea what the whims of a OS maintainer are
> > regarding whether they want all this to be 1 driver or 2 drivers.
> > (IMO, it should be 1 as this is ECC for an A57. For a core and memory
> > controller, then 2 seems appropriate.)
> >
> >> You are
> >> correct that they are CortexA57 core features and nothing Amazon
> >> specific, but it's IMPLEMENTATION DEFINED, meaning that in different
> >> cortex revisions (e.g. A57) the register bitmap may change. Because of
> >> that we added an Amazon compatible which corresponds to the specific
> >> core we are using.
>
> I think its that the instruction encoding is in the imp-def space that is important.
>
> CPU-implementers can add whatever registers they find useful here. A57 and A72 both
> implemented some ECC registers here. (They are not guaranteed to be the same, but I can't
> find any differences).

Two cores potentially being the same only furthers my argument that
this shouldn't be an Amazon driver.

> We need some information from DT because the TRM doesn't say what happens when you read
> from these registers on an A57 that doesn't have the 'optional ECC protection'. It could
> take an exception due to an unimplemented system register.

My read of the TRM is that L2 ECC is always there and L1 ECC/parity is
optional. Furthermore, bit 22 of L2CTRL_EL1 indicates if L1 ECC/parity
is supported or not and there's other non-ECC stuff like cache RAM
timing values in that register.

> The imp-def instruction space may also be trapped by a higher exception level. KVM does
> this, and emulates these registers as if they were all undefined.

So KVM provides a semi-CortexA57? Code that runs on real h/w won't as a guest.

However, if we do need DT to indicate ECC support in a core or not,
then we already have an A57 node and should put that info there.

Rob
