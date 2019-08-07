Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC6D084FC8
	for <lists+linux-edac@lfdr.de>; Wed,  7 Aug 2019 17:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387888AbfHGPYn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 7 Aug 2019 11:24:43 -0400
Received: from verein.lst.de ([213.95.11.211]:38537 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387815AbfHGPYm (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 7 Aug 2019 11:24:42 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 20D6D68B20; Wed,  7 Aug 2019 17:24:39 +0200 (CEST)
Date:   Wed, 7 Aug 2019 17:24:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, palmer@sifive.com, arnd@arndb.de,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, mchehab@kernel.org, james.morse@arm.com
Subject: Re: [PATCH] riscv: move sifive_l2_cache.c to drivers/misc
Message-ID: <20190807152438.GA16495@lst.de>
References: <20190807151009.31971-1-hch@lst.de> <20190807152215.GA26690@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807152215.GA26690@kroah.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Aug 07, 2019 at 05:22:15PM +0200, Greg KH wrote:
> > Fixes: a967a289f169 ("RISC-V: sifive_l2_cache: Add L2 cache controller driver for SiFive SoCs")
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  arch/riscv/mm/Makefile                            | 1 -
> >  drivers/misc/Makefile                             | 1 +
> >  {arch/riscv/mm => drivers/misc}/sifive_l2_cache.c | 0
> >  3 files changed, 1 insertion(+), 1 deletion(-)
> >  rename {arch/riscv/mm => drivers/misc}/sifive_l2_cache.c (100%)
> 
> Why isn't this in drivers/edac/ ?
> why is this a misc driver?  Seems like it should sit next to the edac
> stuff.

No idea.  EDAC maintainers, would you object to taking what is 
currently in arch/riscv/mm//sifive_l2_cache.c to drivers/edac/ ?
