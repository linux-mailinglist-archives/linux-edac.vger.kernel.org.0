Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC6585C03
	for <lists+linux-edac@lfdr.de>; Thu,  8 Aug 2019 09:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731031AbfHHHud (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 8 Aug 2019 03:50:33 -0400
Received: from verein.lst.de ([213.95.11.211]:44193 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbfHHHud (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 8 Aug 2019 03:50:33 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 32BFA68B02; Thu,  8 Aug 2019 09:50:30 +0200 (CEST)
Date:   Thu, 8 Aug 2019 09:50:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Greg KH <gregkh@linuxfoundation.org>, arnd@arndb.de,
        palmer@sifive.com, linux-kernel@vger.kernel.org,
        james.morse@arm.com, linux-riscv@lists.infradead.org,
        mchehab@kernel.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH] riscv: move sifive_l2_cache.c to drivers/misc
Message-ID: <20190808075029.GB30308@lst.de>
References: <20190807151009.31971-1-hch@lst.de> <20190807152215.GA26690@kroah.com> <20190807152438.GA16495@lst.de> <alpine.DEB.2.21.9999.1908070832500.13971@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1908070832500.13971@viisi.sifive.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Aug 07, 2019 at 08:40:58AM -0700, Paul Walmsley wrote:
> On Wed, 7 Aug 2019, Christoph Hellwig wrote:
> 
> > On Wed, Aug 07, 2019 at 05:22:15PM +0200, Greg KH wrote:
> > > > Fixes: a967a289f169 ("RISC-V: sifive_l2_cache: Add L2 cache controller driver for SiFive SoCs")
> > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > > ---
> > > >  arch/riscv/mm/Makefile                            | 1 -
> > > >  drivers/misc/Makefile                             | 1 +
> > > >  {arch/riscv/mm => drivers/misc}/sifive_l2_cache.c | 0
> > > >  3 files changed, 1 insertion(+), 1 deletion(-)
> > > >  rename {arch/riscv/mm => drivers/misc}/sifive_l2_cache.c (100%)
> > > 
> > > Why isn't this in drivers/edac/ ?
> > > why is this a misc driver?  Seems like it should sit next to the edac
> > > stuff.
> > 
> > No idea.  EDAC maintainers, would you object to taking what is 
> > currently in arch/riscv/mm//sifive_l2_cache.c to drivers/edac/ ?
> 
> If this driver is moved out of arch/riscv/mm, it should ideally go into 
> some sort of common L2 cache controller driver directory, along 
> with other L2 cache controller drivers like arch/arm/mm/*l2c*. 
> 
> Like many L2 cache controllers, this controller also supports cache 
> flushing operations and SoC-specific way operations.  We just don't use 
> those on RISC-V - yet.

Well, another reason to not have it under arch/riscv/ as it is a SOC
specific driver, which we all have somewhere else, just like arm64
and new arm ports do.  And especially not unconditionally built.
