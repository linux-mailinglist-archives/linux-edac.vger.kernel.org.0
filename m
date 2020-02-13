Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13A5215BD50
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2020 12:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbgBMLFX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 13 Feb 2020 06:05:23 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50462 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729557AbgBMLFX (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 13 Feb 2020 06:05:23 -0500
Received: from zn.tnic (p200300EC2F07F600746843EFEB191E44.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:f600:7468:43ef:eb19:1e44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 334EB1EC0CAA;
        Thu, 13 Feb 2020 12:05:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1581591921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QxZQZm32jCMDX4unKZfixNUHgtvoBLsEoMQK1TCXr7M=;
        b=iOpxFbUBMXVHTFwtpXT0hhrD4TbzbNXg731SF2bxQsLn/GQ/UWJK1fbmZ2ctfV4d49J4rX
        WGT1psOSmXRDjKNBYxOb+vTvnNBnSsMAda7vxjV/38ZA6QNrXXuZyOH1+lLaGaWWtqPj8i
        bf5rPO7x1jrI66kT/jz5ol4/MTxvm8g=
Date:   Thu, 13 Feb 2020 12:05:12 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>,
        John Garry <john.garry@huawei.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] EDAC/mc: Fixes for mci device removal
Message-ID: <20200213110512.GH31799@zn.tnic>
References: <20200212120340.4764-1-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200212120340.4764-1-rrichter@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Feb 12, 2020 at 01:03:36PM +0100, Robert Richter wrote:
> This series is a split of
> 
>  [v2] EDAC/mc: Fix use-after-free and memleaks during device removal
>  https://lore.kernel.org/patchwork/patch/1190002/
> 
> in smaller patches to better handle stable backports.
> 
> Patch #1 helps to ease backports of patch #2 to 5.3 and earlier
> kernels, see patch descriptions of both for details.
> 
> Patch #2 is the smallest possible fix to address use-after-free and
> memleak issues aimed for backports.
> 
> Patch #3 is another small patch that is split off for stable. This
> fixes code already commited to stable trees.
> 
> Patch #4 is the all remaining code containing the rework of the mci
> device removal. Resulting code is the same as in v2 except for the
> changes outlined for v3:
> 
> v3:
>  * split patch into smaller pieces to ease backports,
>  * removed edac_remove_sysfs_mci_device() in edac_mc_free(), at this
>    point the mci device is always unregistered
> 
> Robert Richter (4):
>   Revert parts of "EDAC/mc_sysfs: Make debug messages consistent"
>   EDAC/mc: Fix use-after-free and memleaks during device removal
>   EDAC/sysfs: Remove csrow objects on errors
>   EDAC/mc: Change mci device removal to use put_device()
> 
>  drivers/edac/edac_mc.c       |  20 +++----
>  drivers/edac/edac_mc_sysfs.c | 100 +++++++++++++----------------------
>  drivers/edac/edac_module.h   |   1 -
>  3 files changed, 48 insertions(+), 73 deletions(-)

Thanks, first three (1+2 squashed) pushed here:

https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git/log/?h=edac-urgent

@John: if you could run them one more time on your machines, that would
be great!

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
