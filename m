Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0433B46EC
	for <lists+linux-edac@lfdr.de>; Fri, 25 Jun 2021 17:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhFYPwI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 25 Jun 2021 11:52:08 -0400
Received: from angie.orcam.me.uk ([78.133.224.34]:59976 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhFYPwH (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 25 Jun 2021 11:52:07 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id E9E1592009C; Fri, 25 Jun 2021 17:49:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id E628892009B;
        Fri, 25 Jun 2021 17:49:44 +0200 (CEST)
Date:   Fri, 25 Jun 2021 17:49:44 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kurt Martin <kmartin@wavecomp.com>
cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Tiezhu Yang <yangtiezhu@loongson.cn>,
        Willy Tarreau <w@1wt.eu>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-edac@vger.kernel.org, linux-hams@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Remove dead linux-mips.org references
In-Reply-To: <20210625110419.24503-1-lukas.bulwahn@gmail.com>
Message-ID: <alpine.DEB.2.21.2106251722470.37803@angie.orcam.me.uk>
References: <20210625110419.24503-1-lukas.bulwahn@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

[Adding Ralf and Kurt to the list of recipients.]

On Fri, 25 Jun 2021, Lukas Bulwahn wrote:

> The domain lookup for linux-mips.org fails for quite some time now. Hence,
> webpages, the patchwork instance and Ralf Baechle's email there is not
> reachable anymore.

 Well, mail forwarding has now been set up for my old LMO address, and so 
I believe for Ralf's.  Any other resources remain unavailable.

> In the discussion of that patch series, Kurt Martin promised to get
> linux-mips.org back online. Four months have now passed and the webpage is
> still not back online. So, I suggest to remove these dead references.
> Probably, we do not lose much if the linux-mips.org webpage never comes back.

 While most resources have been migrated I think the wiki was unique and 
valuable.  Perhaps we could preserve read-only references to archive.org 
dumps?  It's not clear to me what our policy is here though, if any.

> The domain lookup for linux-mips.org fails for quite some time now. Hence,
> webpages, the patchwork instance and Ralf Baechle's email there is not
> reachable anymore.

 Let's see if the copy of this message intended for Ralf bounces.

> I removed dead references or replaced them with their living counterparts if
> available. However, these two cases remain and somebody might want to have a look:
> 
>   1. case in ./arch/mips/include/asm/page.h:
> 
> <snip>
> /*
>  * RELOC_HIDE was originally added by 6007b903dfe5f1d13e0c711ac2894bdd4a61b1ad
>  * (lmo) rsp. 8431fd094d625b94d364fe393076ccef88e6ce18 (kernel.org).  The
>  * discussion can be found in
>  * https://lore.kernel.org/lkml/a2ebde260608230500o3407b108hc03debb9da6e62c@mail.gmail.com
>  *
>  * It is unclear if the misscompilations mentioned in
>  * https://lore.kernel.org/lkml/1281303490-390-1-git-send-email-namhyung@gmail.com
>  * also affect MIPS so we keep this one until GCC 3.x has been retired
>  * before we can apply https://patchwork.linux-mips.org/patch/1541/
>  */
> </snip>
> 
>   Decision: Keep as is. Although GCC 3.x is long retired, it is unclear what
>   https://patchwork.linux-mips.org/patch/1541/ is and if it has been already
>   applied or not.
>   Question: does anyone know how to identify this patch?

 It's on archive.org, marked rejected:

<https://web.archive.org/web/20180829170737/https://patchwork.linux-mips.org/patch/1541/>

or alternatively: <https://lore.kernel.org/patchwork/patch/210989/> (with 
no proper status).  Given the note it might make sense to re-evaluate the 
patch.  Thanks for the heads-up!

>   2. case in ./drivers/parport/parport_ip32.c:
> 
>     linux-mips.org tree is referred to in an old To do item:
> 
> <snip>
>  * To do:
>  *
>  *      Fully implement ECP mode.
>  *      EPP and ECP mode need to be tested.  I currently do not own any
>  *      peripheral supporting these extended mode, and cannot test them.
>  *      If DMA mode works well, decide if support for PIO FIFO modes should be
>  *      dropped.
>  *      Use the io{read,write} family functions when they become available in
>  *      the linux-mips.org tree.  Note: the MIPS specific functions readsb()
>  *      and writesb() are to be translated by ioread8_rep() and iowrite8_rep()
>  *      respectively.
> </snip>
> 
>   Decision: Keep as is; anyone that wants to follow up on this will probably
>   understand that the reference is outdated anyway.

 Note that a copy of the LMO tree remains available online at: 
<git://git.kernel.org/pub/scm/linux/kernel/git/ralf/linux.git>, so any 
references or git commit IDs are reachable.  Perhaps it would be good to 
add an actual reference somewhere though.

  Maciej
