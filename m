Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE5FAAC4A5
	for <lists+linux-edac@lfdr.de>; Sat,  7 Sep 2019 06:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfIGEkV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 7 Sep 2019 00:40:21 -0400
Received: from verein.lst.de ([213.95.11.211]:34316 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfIGEkV (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 7 Sep 2019 00:40:21 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 263C368B05; Sat,  7 Sep 2019 06:40:18 +0200 (CEST)
Date:   Sat, 7 Sep 2019 06:40:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Christoph Hellwig <hch@lst.de>, palmer@sifive.com, bp@alien8.de,
        mchehab@kernel.org, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: move sifive_l2_cache.c to drivers/soc
Message-ID: <20190907044017.GB21510@lst.de>
References: <20190818082935.14869-1-hch@lst.de> <alpine.DEB.2.21.9999.1909061525040.6292@viisi.sifive.com> <alpine.DEB.2.21.9999.1909061533260.6292@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1909061533260.6292@viisi.sifive.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Sep 06, 2019 at 03:36:09PM -0700, Paul Walmsley wrote:
> One other comment on this patch:
> 
> On Fri, 6 Sep 2019, Paul Walmsley wrote:
> 
> > On Sun, 18 Aug 2019, Christoph Hellwig wrote:
> >
> > > diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> > > index 200c04ce5b0e..9241b3e7a050 100644
> > > --- a/drivers/edac/Kconfig
> > > +++ b/drivers/edac/Kconfig
> > > @@ -462,7 +462,7 @@ config EDAC_ALTERA_SDMMC
> > >  
> > >  config EDAC_SIFIVE
> > >  	bool "Sifive platform EDAC driver"
> > > -	depends on EDAC=y && RISCV
> > > +	depends on EDAC=y && SIFIVE_L2
> 
> Since the guidance from the EDAC maintainers is that this driver is to be 
> a platform driver -- which would, for example, also include EDAC support for 
> other IP blocks (e.g., DRAM controllers) on SiFive SoCs -- this should 
> depend on SOC_SIFIVE, not SIFIVE_L2.

But as-is without major changes it depends on SIFIVE_L2.  And given that
it supports nothing else as-is there is no point in making the code
conditional either.
