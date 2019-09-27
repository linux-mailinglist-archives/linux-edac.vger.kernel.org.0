Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE49BC0E26
	for <lists+linux-edac@lfdr.de>; Sat, 28 Sep 2019 00:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbfI0WxI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 27 Sep 2019 18:53:08 -0400
Received: from verein.lst.de ([213.95.11.211]:48244 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfI0WxI (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 27 Sep 2019 18:53:08 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0CB9E68B05; Sat, 28 Sep 2019 00:53:05 +0200 (CEST)
Date:   Sat, 28 Sep 2019 00:53:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Borislav Petkov <bp@alien8.de>,
        paul.walmsley@sifive.com, palmer@sifive.com,
        linux-riscv@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yash Shah <yash.shah@sifive.com>
Subject: Re: [PATCH] riscv: move sifive_l2_cache.c to drivers/soc
Message-ID: <20190927225304.GA18456@lst.de>
References: <20190818082935.14869-1-hch@lst.de> <20190819060904.GA4841@zn.tnic> <20190819062619.GA20211@lst.de> <20190822062635.00f6e507@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822062635.00f6e507@coco.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Aug 22, 2019 at 06:26:35AM -0300, Mauro Carvalho Chehab wrote:
> Em Mon, 19 Aug 2019 08:26:19 +0200
> Christoph Hellwig <hch@lst.de> escreveu:
> 
> > On Mon, Aug 19, 2019 at 08:09:04AM +0200, Borislav Petkov wrote:
> > > On Sun, Aug 18, 2019 at 10:29:35AM +0200, Christoph Hellwig wrote:  
> > > > The sifive_l2_cache.c is in no way related to RISC-V architecture
> > > > memory management.  It is a little stub driver working around the fact
> > > > that the EDAC maintainers prefer their drivers to be structured in a
> > > > certain way  
> > > 
> > > That changed recently so I guess we can do the per-IP block driver after
> > > all, if people would still prefer it.  
> > 
> > That would seem like the best idea.  But I don't really know this code
> > well enough myself, and I really need to get this code out of the
> > forced on RISC-V codebase as some SOCs I'm working with simply don't
> > have the memory for it..
> > 
> > So unless someone signs up to do a per-IP block edac drivers instead
> > very quickly I'd still like to see something like this go into 5.4
> > for now.
> 
> I'm wandering if we should at least add an entry for this one at
> MAINTAINERS, pointing it to the EDAC mailing list. Something like:

Sounds fine.  Can you also ACK the patch with that, as Paul mention
in another thread he wants an EDAC ACK for it.
