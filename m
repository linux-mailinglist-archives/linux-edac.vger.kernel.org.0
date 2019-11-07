Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDA67F2A67
	for <lists+linux-edac@lfdr.de>; Thu,  7 Nov 2019 10:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfKGJT3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 7 Nov 2019 04:19:29 -0500
Received: from verein.lst.de ([213.95.11.211]:55982 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727562AbfKGJT3 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 7 Nov 2019 04:19:29 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0DC8C68B05; Thu,  7 Nov 2019 10:19:26 +0100 (CET)
Date:   Thu, 7 Nov 2019 10:19:25 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Christoph Hellwig <hch@lst.de>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rrichter@marvell.com, yash.shah@sifive.com,
        linux-riscv@lists.infradead.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH, resend] riscv: move sifive_l2_cache.c to drivers/soc
Message-ID: <20191107091925.GA10676@lst.de>
References: <20191106011723.2110-1-hch@lst.de> <20191106091013.GA28380@zn.tnic> <20191106144859.GA17326@lst.de> <20191106150259.GB28380@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106150259.GB28380@zn.tnic>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Nov 06, 2019 at 04:02:59PM +0100, Borislav Petkov wrote:
> On Wed, Nov 06, 2019 at 03:48:59PM +0100, Christoph Hellwig wrote:
> > On Wed, Nov 06, 2019 at 10:10:13AM +0100, Borislav Petkov wrote:
> > > Also, building with a cross-compiler fails here:
> > 
> > What config?  riscv defconfig + CONFIG_SIFIVE_L2 works just fine for me.
> 
> Do you not see the one I attached?

Sorry, missed it.

The problem is that you have a modular build, which doesn't make much
sense given that the actual EDAC_SIFIVE needs to be built-in anyway.

I've changed it to bool and will resend.
