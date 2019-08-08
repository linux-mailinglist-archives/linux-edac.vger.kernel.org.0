Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6325085C76
	for <lists+linux-edac@lfdr.de>; Thu,  8 Aug 2019 10:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731762AbfHHIHn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 8 Aug 2019 04:07:43 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34778 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731737AbfHHIHn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 8 Aug 2019 04:07:43 -0400
Received: by mail-qt1-f195.google.com with SMTP id k10so22096870qtq.1;
        Thu, 08 Aug 2019 01:07:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zpfTTWIVTM8a0np0YvcvEQ5LKGlmAj7NsTRFbsCvaus=;
        b=PCIzaS+ZqeLxF7wCoLcHb35L3rCJbcM6ck4N6qyOoTrEsO1bRksbqTsKcZjpf3tv9n
         hO5qRtHk2+x2dpExZuDeKa/tKfhcGYhtxJburSkp7wzpgO2vVx0Ur2QzhP5CJWuIXII7
         +qwlEn2vFk1Z4YcCkE5c0rwp2flCrYqr50fhUY6Du/mZKAoEIBT4VOTlmtK9r8vhF5hG
         MckfOYG3WLJRrrNOzneBRqmCUenK08QRz1ALop5wF+LQrktxZp6Li3WbIiTTDJ/n/ong
         Lc6hmVMb0F5Y3tsVBX5UIpNM6ZIHe+D3TlLGyYr1qOxX+FsKeZ9thVj7qL2rccfaO/JL
         MJRw==
X-Gm-Message-State: APjAAAXFNZkW4QNBWxCEu7exHrAtL4Tt8qc+7Zf+z4ylLCL73y2H5qxJ
        pEDcUvnToH2/k99Ls1DkyfpXR/PndvFVEIFb/II=
X-Google-Smtp-Source: APXvYqwZZW9N6HttLUMOUHu8OVQ7m6alCwA745gemlJdjpV2mFtSjU3BCMjNtw+/B8K/8fMOgXq8xsaod0+xpp8WY4U=
X-Received: by 2002:ac8:6684:: with SMTP id d4mr6915506qtp.204.1565251662202;
 Thu, 08 Aug 2019 01:07:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190807151009.31971-1-hch@lst.de> <20190807152215.GA26690@kroah.com>
 <20190807152438.GA16495@lst.de> <alpine.DEB.2.21.9999.1908070832500.13971@viisi.sifive.com>
 <20190808075029.GB30308@lst.de>
In-Reply-To: <20190808075029.GB30308@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 8 Aug 2019 10:07:26 +0200
Message-ID: <CAK8P3a1nwTjt7gbL7bCa11-smQ0c6o-6QUL0vLZnZxzT_aa4-g@mail.gmail.com>
Subject: Re: [PATCH] riscv: move sifive_l2_cache.c to drivers/misc
To:     Christoph Hellwig <hch@lst.de>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        linux-riscv@lists.infradead.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Aug 8, 2019 at 9:50 AM Christoph Hellwig <hch@lst.de> wrote:
> On Wed, Aug 07, 2019 at 08:40:58AM -0700, Paul Walmsley wrote:
> > On Wed, 7 Aug 2019, Christoph Hellwig wrote:
> > > On Wed, Aug 07, 2019 at 05:22:15PM +0200, Greg KH wrote:
> > > > > Fixes: a967a289f169 ("RISC-V: sifive_l2_cache: Add L2 cache controller driver for SiFive SoCs")
> > > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > > > ---
> > > > >  arch/riscv/mm/Makefile                            | 1 -
> > > > >  drivers/misc/Makefile                             | 1 +
> > > > >  {arch/riscv/mm => drivers/misc}/sifive_l2_cache.c | 0
> > > > >  3 files changed, 1 insertion(+), 1 deletion(-)
> > > > >  rename {arch/riscv/mm => drivers/misc}/sifive_l2_cache.c (100%)
> > > >
> > > > Why isn't this in drivers/edac/ ?
> > > > why is this a misc driver?  Seems like it should sit next to the edac
> > > > stuff.
> > >
> > > No idea.  EDAC maintainers, would you object to taking what is
> > > currently in arch/riscv/mm//sifive_l2_cache.c to drivers/edac/ ?
> >
> > If this driver is moved out of arch/riscv/mm, it should ideally go into
> > some sort of common L2 cache controller driver directory, along
> > with other L2 cache controller drivers like arch/arm/mm/*l2c*.
> >
> > Like many L2 cache controllers, this controller also supports cache
> > flushing operations and SoC-specific way operations.  We just don't use
> > those on RISC-V - yet.
>
> Well, another reason to not have it under arch/riscv/ as it is a SOC
> specific driver, which we all have somewhere else, just like arm64
> and new arm ports do.  And especially not unconditionally built.

soc specific drivers that don't have their own subsystem can
go into drivers/soc/$VENDOR/.

For this driver, I would also think that the edac subsystem is the
best fit. Right now, the driver is split in two halves: there
is drivers/edac/sifive_edac.c and arch/riscv/mm/sifive_l2_cache.c,
with neither of those working without the other.

Moving both into a single file would seem to allow simplifying
it as a proper 'platform_driver', which the drivers/edac side today
is not (it just registers a platform device in its module_init call).

      Arnd
