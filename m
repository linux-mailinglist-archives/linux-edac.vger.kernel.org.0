Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52422A4846
	for <lists+linux-edac@lfdr.de>; Sun,  1 Sep 2019 10:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbfIAIBC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 1 Sep 2019 04:01:02 -0400
Received: from verein.lst.de ([213.95.11.211]:40643 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbfIAIBC (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 1 Sep 2019 04:01:02 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B3211227A8B; Sun,  1 Sep 2019 10:00:56 +0200 (CEST)
Date:   Sun, 1 Sep 2019 10:00:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Borislav Petkov <bp@alien8.de>,
        palmer@sifive.com, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yash Shah <yash.shah@sifive.com>
Subject: Re: [PATCH] riscv: move sifive_l2_cache.c to drivers/soc
Message-ID: <20190901080055.GA12035@lst.de>
References: <20190818082935.14869-1-hch@lst.de> <20190819060904.GA4841@zn.tnic> <20190819062619.GA20211@lst.de> <20190822062635.00f6e507@coco.lan> <alpine.DEB.2.21.9999.1908301951080.16731@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1908301951080.16731@viisi.sifive.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Aug 30, 2019 at 07:53:17PM -0700, Paul Walmsley wrote:
> There's already a MAINTAINERS entry that should cover drivers/soc/sifive.  
> Probably it's not needed to add another one here.

So are you going to apply the original patch to the riscv tree?
I dont want to keep this file lingering around as a force built part
of the riscv build for another merge window.
