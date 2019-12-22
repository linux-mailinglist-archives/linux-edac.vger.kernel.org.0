Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46021128DE0
	for <lists+linux-edac@lfdr.de>; Sun, 22 Dec 2019 13:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfLVMPP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 22 Dec 2019 07:15:15 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42446 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbfLVMPP (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 22 Dec 2019 07:15:15 -0500
Received: from zn.tnic (p200300EC2F0ED600400AE6D5F72017D0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:d600:400a:e6d5:f720:17d0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 151981EC0985;
        Sun, 22 Dec 2019 13:15:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1577016913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5rKqrB8hrZ40tpd1/keewAhz5uKnVB4+kjIFyrWnvyo=;
        b=Mm0r9Uc0UVTsTeLDpK9wrcPfeJ/WrFa3dMKSZHP0j7ebRFAmkdrRURFQPqdDc/Epf+Qirw
        OuxwIUFRntZLUx9AWRcupRKh3jOHtyKyscQn7MFc4L/x0pIp6+SaRSjg/AIjVKKhNjXz6Y
        a8ni0nOFSCeYvwb+Iy7WDpYmg2/JYPA=
Date:   Sun, 22 Dec 2019 13:15:00 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH] EDAC/mc: Fix use-after-free and memleaks during device
 removal
Message-ID: <20191222121500.GA5485@zn.tnic>
References: <20191218062129.7400-1-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191218062129.7400-1-rrichter@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Dec 18, 2019 at 06:22:08AM +0000, Robert Richter wrote:
> A test kernel with the options set below revealed several issues when
> removing a mci device:
> 
>  DEBUG_TEST_DRIVER_REMOVE
>  KASAN
>  DEBUG_KMEMLEAK
> 
> Issues seen:
> 
> 1) Use-after-free:
> 
> On 27.11.19 17:07:33, John Garry wrote:
> > [   22.104498] BUG: KASAN: use-after-free in
> > edac_remove_sysfs_mci_device+0x148/0x180
> 
> The use-after-free is triggered in edac_remove_sysfs_mci_device(). It
> became an issue with commit c498afaf7df8 ("EDAC: Introduce an
> mci_for_each_dimm() iterator").

... which means:

Fixes: c498afaf7df8 ("EDAC: Introduce an mci_for_each_dimm() iterator")

?

> The reason for it is that device_unregister(&dimm->dev) not only
> removes the sysfs entry, it also frees the dimm struct in
> dimm_attr_release(). When incrementing the loop in
> mci_for_each_dimm(), the dimm struct is accessed again by the loop
> iterator which causes the use-after-free.
> 
> In function edac_remove_sysfs_mci_device() all the mci device's
> subsequent dimm and csrow objects are removed. When unregistering from
> sysfs, instead of removing that data it should be kept until it is
> removed together with the mci device. This keeps the data structures
> intact and the mci device can be fully used until it will be removed.
> 
> 2) Memory leaks:
> 
> Following memory leaks have been detected:
> 
>  # grep edac /sys/kernel/debug/kmemleak | sort | uniq -c
>        1     [<000000003c0f58f9>] edac_mc_alloc+0x3bc/0x9d0      # mci->csrows
>       16     [<00000000bb932dc0>] edac_mc_alloc+0x49c/0x9d0      # csr->channels
>       16     [<00000000e2734dba>] edac_mc_alloc+0x518/0x9d0      # csr->channels[chn]
>        1     [<00000000eb040168>] edac_mc_alloc+0x5c8/0x9d0      # mci->dimms
>       34     [<00000000ef737c29>] ghes_edac_register+0x1c8/0x3f8 # see edac_mc_alloc()
> 
> There are two implementions for device removal in the driver.

Which driver? ghes_edac?

> One is
> used before edac_mc_add_mc(), the other afterwards after the device
> had been registered in sysfs. The later lacks the removal of some data
> allocated in edac_mc_alloc(). All the above issues are fixed as
> follows:

This paragraph needs clarification as I have no clue what you mean here.

> 
> Unify release code in a single mci_release() function and use this one

I think you mean s/single/separate/

> together with put_device() to release the struct mci once there are no
> users. Free all subsequent data structures of the children devices in
> that release function too. An effect of this is that no data is freed
> in edac_mc_sysfs.c (except the "mc" sysfs root node). All sysfs
> entries have the mci device as a parent, so its refcount will keep the
> struct from being removed as long as sysfs entries exist. Before
> freeing struct mci, all sysfs entries are removed now in edac_remove_
> sysfs_mci_device(). With the changes made the mci_for_each_dimm() loop
> is now save to remove dimm devices from sysfs.
> 
> The patch has been tested with the above kernel options, no issues
> seen any longer.
> 
> This patch should be marked as stable.
> 
> Reported-by: John Garry <john.garry@huawei.com>
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---
>  drivers/edac/edac_mc.c       |  20 +++----
>  drivers/edac/edac_mc_sysfs.c | 100 +++++++++++++----------------------
>  drivers/edac/edac_module.h   |   1 -
>  3 files changed, 49 insertions(+), 72 deletions(-)

Other than that, I don't see anything out of the ordinary with it and it
passes some smoke testing on boxes here so I'll queue v2 and expose it
in linux-next for wider testing...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
