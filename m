Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D35322AEA
	for <lists+linux-edac@lfdr.de>; Tue, 23 Feb 2021 13:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbhBWM5y (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 23 Feb 2021 07:57:54 -0500
Received: from elvis.franken.de ([193.175.24.41]:49451 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232601AbhBWM5v (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 23 Feb 2021 07:57:51 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1lEXFU-0002LK-03; Tue, 23 Feb 2021 13:57:08 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 28562C07B1; Tue, 23 Feb 2021 13:29:28 +0100 (CET)
Date:   Tue, 23 Feb 2021 13:29:28 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-mips@vger.kernel.org,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Tiezhu Yang <yangtiezhu@loongson.cn>, Willy Tarreau <w@1wt.eu>,
        linux-edac@vger.kernel.org, linux-hams@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] arch: mips: update references to current linux-mips
 list
Message-ID: <20210223122928.GD7765@alpha.franken.de>
References: <20210222161905.1153-1-lukas.bulwahn@gmail.com>
 <20210222161905.1153-4-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222161905.1153-4-lukas.bulwahn@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Feb 22, 2021 at 05:19:03PM +0100, Lukas Bulwahn wrote:
> The linux-mips mailing list now lives at kernel.org. Update all references
> in the kernel tree.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  arch/mips/kernel/r4k-bugs64.c | 2 +-
>  arch/mips/lib/iomap-pci.c     | 2 +-
>  arch/mips/sgi-ip32/ip32-irq.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

applied only this patch to mips-next.

For the other patches I'll wait for how the resolution for linux-mips.org
looks like.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
