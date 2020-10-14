Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2A428E2EF
	for <lists+linux-edac@lfdr.de>; Wed, 14 Oct 2020 17:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgJNPSM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 14 Oct 2020 11:18:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:39830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbgJNPSM (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 14 Oct 2020 11:18:12 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE6CB2222E;
        Wed, 14 Oct 2020 15:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602688691;
        bh=g5Odsy97hE63ujD6OzFFr0luCFwvVxMLG1f0d17fUGk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aZfS9AxoA/cWQwgBd3e4c9XBYET/zekkeXTW+yKn6lSAr4o/KBIUwyi4SkDunNgnE
         Cs8uQ2DFoU9GKhO4DwrnsQxEDw3hlm3hOyLxK+25CsBeUStoWJgIDCKkyBSZkRgJzy
         pjy3BqpEZ7UvkZwBlh8PF2w42INTiCRsVqRIVSx4=
Received: by mail-oi1-f172.google.com with SMTP id u17so3612424oie.3;
        Wed, 14 Oct 2020 08:18:11 -0700 (PDT)
X-Gm-Message-State: AOAM532M3KCVOnpxF88Yn3cxsvcdHtUH+Pku85UN+6QROHSzmbhPaGjB
        dQICyclDI5yYvdTYhHiKS7F97VV8mTJG5HZ8Dg==
X-Google-Smtp-Source: ABdhPJw0z7IxHV0VjnkKuH4FjyCr19QksUI7nGjrI/1n8jpQqHTeNiKErSGZ6Ovb7Yebe4VAxpR4RyzCJNclCQt+tlo=
X-Received: by 2002:a54:4f89:: with SMTP id g9mr2579598oiy.106.1602688690960;
 Wed, 14 Oct 2020 08:18:10 -0700 (PDT)
MIME-Version: 1.0
References: <20201013125033.4749-1-s.hauer@pengutronix.de> <20201014132511.GA1517487@bogus>
 <20201014140429.GE13710@pengutronix.de>
In-Reply-To: <20201014140429.GE13710@pengutronix.de>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 14 Oct 2020 10:17:59 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ_CSY_cEe2T=RMsznMA2AZjxdyvW2eJebi2QzpwOTW+g@mail.gmail.com>
Message-ID: <CAL_JsqJ_CSY_cEe2T=RMsznMA2AZjxdyvW2eJebi2QzpwOTW+g@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Add L1 and L2 error detection for A53 and A57
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        York Sun <york.sun@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Oct 14, 2020 at 9:04 AM Sascha Hauer <s.hauer@pengutronix.de> wrote:
>
> On Wed, Oct 14, 2020 at 08:25:11AM -0500, Rob Herring wrote:
> > On Tue, Oct 13, 2020 at 02:50:30PM +0200, Sascha Hauer wrote:
> > > This driver is based on an earlier version from York Sun which can
> > > be found here: https://lkml.org/lkml/2018/3/14/1203.
> > >
> > > At that time the conclusion was that this driver is not suitable for
> > > mainline as it used IMPLEMENTATION DEFINED CPU registers and also
> > > NXP specific SMC calls. All this was used for the error injection only,
> > > for error reporting it is not needed.
> >
> > Have you looked at Amazon's version:
> > http://lore.kernel.org/r/20200510151310.17372-2-hhhawa@amazon.com
>
> No, I was not aware of that driver. It's basically the same driver, but
> limited to a single SoC. Looks like at least some things are better in
> that driver, read_sysreg_s(ARM_CA57_L2MERRSR_EL1) reads better than my
> open coded variant.
>
> >
> > Which is an A57 EDAC driver. Looks like it never got upstream though,
> > but it's not clear why.
> >
> > You'll note that it doesn't have a virtual DT node either.
>
> Testing the SoC type in an initcall looks odd to me. Wouldn't a
> dedicated node be preferred?

Yes, the one with "arm,cortex-a57". But no, a virtual node isn't
preferred. We discussed this at length on Amazon's version IIRC. I
could perhaps be convinced to add a property in the cpu nodes that ECC
is present/enabled. Then you'd just match on cpu compatible(s) and
check for the property. You're still creating the device yourself, but
that's the kernel's problem which shouldn't dictate how you design
your bindings.

Rob
