Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 156C1AC4A0
	for <lists+linux-edac@lfdr.de>; Sat,  7 Sep 2019 06:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389124AbfIGEjP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 7 Sep 2019 00:39:15 -0400
Received: from verein.lst.de ([213.95.11.211]:34310 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387398AbfIGEjP (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 7 Sep 2019 00:39:15 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 95CBF68B05; Sat,  7 Sep 2019 06:39:11 +0200 (CEST)
Date:   Sat, 7 Sep 2019 06:39:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Christoph Hellwig <hch@lst.de>, palmer@sifive.com, bp@alien8.de,
        mchehab@kernel.org, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: move sifive_l2_cache.c to drivers/soc
Message-ID: <20190907043911.GA21510@lst.de>
References: <20190818082935.14869-1-hch@lst.de> <alpine.DEB.2.21.9999.1909061525040.6292@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1909061525040.6292@viisi.sifive.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Sep 06, 2019 at 03:27:44PM -0700, Paul Walmsley wrote:
> - Since the patch doesn't fix any bugs, there shouldn't be a Fixes: line.  
> Please let me know whether I can drop the line locally before I apply the 
> patch, or whether you'd like to resend it.

It fixes the bug that we build code into a default RISC-V image that
we absolutely should not.  And it fixes the bug that the patch placed
code in absolutely the wrong place.
