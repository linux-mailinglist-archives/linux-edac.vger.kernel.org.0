Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFCB9F1917
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2019 15:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbfKFOtD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Nov 2019 09:49:03 -0500
Received: from verein.lst.de ([213.95.11.211]:51706 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727958AbfKFOtD (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 6 Nov 2019 09:49:03 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2937668AFE; Wed,  6 Nov 2019 15:49:00 +0100 (CET)
Date:   Wed, 6 Nov 2019 15:48:59 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Christoph Hellwig <hch@lst.de>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rrichter@marvell.com, yash.shah@sifive.com,
        linux-riscv@lists.infradead.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH, resend] riscv: move sifive_l2_cache.c to drivers/soc
Message-ID: <20191106144859.GA17326@lst.de>
References: <20191106011723.2110-1-hch@lst.de> <20191106091013.GA28380@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106091013.GA28380@zn.tnic>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Nov 06, 2019 at 10:10:13AM +0100, Borislav Petkov wrote:
> Also, building with a cross-compiler fails here:

What config?  riscv defconfig + CONFIG_SIFIVE_L2 works just fine for me.
