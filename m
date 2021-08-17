Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804FC3EEC20
	for <lists+linux-edac@lfdr.de>; Tue, 17 Aug 2021 14:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239771AbhHQMHB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 17 Aug 2021 08:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239885AbhHQMG6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 17 Aug 2021 08:06:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AA2C0617AD
        for <linux-edac@vger.kernel.org>; Tue, 17 Aug 2021 05:06:19 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1mFxr6-0007vX-0F; Tue, 17 Aug 2021 14:06:08 +0200
Received: from localhost ([127.0.0.1])
        by ptx.hi.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1mFxr4-00069j-0j; Tue, 17 Aug 2021 14:06:06 +0200
Message-ID: <fc237c522f0ac226d6727761134925601627910a.camel@pengutronix.de>
Subject: Re: [PATCH 1/2] dt-bindings: memory: convert Marvell MVEBU SDRAM
 controller to dtschema
From:   Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date:   Tue, 17 Aug 2021 14:06:05 +0200
In-Reply-To: <75d49c7d-764d-4416-1899-a7d5d7c955e6@canonical.com>
References: <20210817093807.59531-1-krzysztof.kozlowski@canonical.com>
         <17798cb01c5d699738f57118d4deb53504759818.camel@pengutronix.de>
         <9872ed05-28d6-15aa-dc61-228776d20819@canonical.com>
         <294664184613324453f34ee581d9c5e97bab4f31.camel@pengutronix.de>
         <75d49c7d-764d-4416-1899-a7d5d7c955e6@canonical.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 (by Flathub.org) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: jlu@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-edac@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, 2021-08-17 at 13:06 +0200, Krzysztof Kozlowski wrote:
> On 17/08/2021 12:58, Jan Lübbe wrote:
> > On Tue, 2021-08-17 at 12:52 +0200, Krzysztof Kozlowski wrote:
> > > On 17/08/2021 12:46, Jan Lübbe wrote:
> > > > On Tue, 2021-08-17 at 11:38 +0200, Krzysztof Kozlowski wrote:
> > > > > Convert Marvell MVEBU SDRAM controller bindings to DT schema format
> > > > > using json-schema.
> > > > > 
> > > > > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> > > > > ---
> > > > >  .../marvell,mvebu-sdram-controller.yaml       | 31 +++++++++++++++++++
> > > > >  .../mvebu-sdram-controller.txt                | 21 -------------
> > > > >  2 files changed, 31 insertions(+), 21 deletions(-)
> > > > >  create mode 100644 Documentation/devicetree/bindings/memory-controllers/marvell,mvebu-sdram-controller.yaml
> > > > >  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mvebu-sdram-controller.txt
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/memory-controllers/marvell,mvebu-sdram-controller.yaml b/Documentation/devicetree/bindings/memory-controllers/marvell,mvebu-sdram-controller.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..14a6bc8f421f
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/memory-controllers/marvell,mvebu-sdram-controller.yaml
> > > > > @@ -0,0 +1,31 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/memory-controllers/marvell,mvebu-sdram-controller.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: Marvell MVEBU SDRAM controller
> > > > > +
> > > > > +maintainers:
> > > > > +  - Jan Luebbe <jlu@pengutronix.de>
> > > > > +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    const: marvell,armada-xp-sdram-controller
> > > > > +
> > > > > +  reg:
> > > > > +    maxItems: 1
> > > > > +
> > > > > +required:
> > > > > +  - compatible
> > > > > +  - reg
> > > > > +
> > > > > +additionalProperties: false
> > > > > +
> > > > > +examples:
> > > > > +  - |
> > > > > +    memory-controller@1400 {
> > > > > +        compatible = "marvell,armada-xp-sdram-controller";
> > > > > +        reg = <0x1400 0x500>;
> > > > > +    };
> > > > > diff --git a/Documentation/devicetree/bindings/memory-controllers/mvebu-sdram-controller.txt b/Documentation/devicetree/bindings/memory-controllers/mvebu-sdram-controller.txt
> > > > > deleted file mode 100644
> > > > > index 89657d1d4cd4..000000000000
> > > > > --- a/Documentation/devicetree/bindings/memory-controllers/mvebu-sdram-controller.txt
> > > > > +++ /dev/null
> > > > > @@ -1,21 +0,0 @@
> > > > > -Device Tree bindings for MVEBU SDRAM controllers
> > > > > -
> > > > > -The Marvell EBU SoCs all have a SDRAM controller. The SDRAM controller
> > > > > -differs from one SoC variant to another, but they also share a number
> > > > > -of commonalities.
> > > > > -
> > > > > -For now, this Device Tree binding documentation only documents the
> > > > > -Armada XP SDRAM controller.
> > > > 
> > > > Please keep the description, otherwise it would be confusing why the binding is
> > > > named marvell,mvebu-sdram-controller.yaml although it (currenly) only applies to
> > > > the Armada XP.
> > > > 
> > > 
> > > The description does not explain why it only documents Armada XP, so it
> > > just duplicates what is in "compatible" part of bindings. How is the
> > > confusion removed by saying "we document currently only Armada XP"? What
> > > changes?
> > 
> > Then perhaps the binding should be named marvell,armada-xp-sdram-
> > controller.yaml? It find it unlikely that support for the other SoC's
> > controllers will be added, given their age.
> 
> Sure, could be like this but there is no confusion here and no need to
> fix anything. It is understandable and common to name bindings file as
> general (e.g. for group of devices) even though only limited amount of
> devices are currently documented/described. It's almost everywhere like
> this, when the bindings are not complete. I don't see where is the
> confusion.
> 
> Look at: arm/marvell/armada-cpu-reset.txt which mentions several SoCs
> while only three compatibles are documented.
> arm/marvell/armada-cpu-reset.txt has generic name and describes only one
> reset controller (370) while being used on multiple SoC (370, 375, 38x,
> 39x). I could go like this all over the bindings...

OK, you convinced me. Thanks for the explanation.

Jan
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

