Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2A3B91D02
	for <lists+linux-edac@lfdr.de>; Mon, 19 Aug 2019 08:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbfHSG0Y (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 19 Aug 2019 02:26:24 -0400
Received: from verein.lst.de ([213.95.11.211]:44855 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbfHSG0Y (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 19 Aug 2019 02:26:24 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2018B68B02; Mon, 19 Aug 2019 08:26:20 +0200 (CEST)
Date:   Mon, 19 Aug 2019 08:26:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Christoph Hellwig <hch@lst.de>, paul.walmsley@sifive.com,
        palmer@sifive.com, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yash Shah <yash.shah@sifive.com>
Subject: Re: [PATCH] riscv: move sifive_l2_cache.c to drivers/soc
Message-ID: <20190819062619.GA20211@lst.de>
References: <20190818082935.14869-1-hch@lst.de> <20190819060904.GA4841@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819060904.GA4841@zn.tnic>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Aug 19, 2019 at 08:09:04AM +0200, Borislav Petkov wrote:
> On Sun, Aug 18, 2019 at 10:29:35AM +0200, Christoph Hellwig wrote:
> > The sifive_l2_cache.c is in no way related to RISC-V architecture
> > memory management.  It is a little stub driver working around the fact
> > that the EDAC maintainers prefer their drivers to be structured in a
> > certain way
> 
> That changed recently so I guess we can do the per-IP block driver after
> all, if people would still prefer it.

That would seem like the best idea.  But I don't really know this code
well enough myself, and I really need to get this code out of the
forced on RISC-V codebase as some SOCs I'm working with simply don't
have the memory for it..

So unless someone signs up to do a per-IP block edac drivers instead
very quickly I'd still like to see something like this go into 5.4
for now.
