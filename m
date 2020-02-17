Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAA3E16169E
	for <lists+linux-edac@lfdr.de>; Mon, 17 Feb 2020 16:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgBQPtn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 17 Feb 2020 10:49:43 -0500
Received: from mail.skyhub.de ([5.9.137.197]:40616 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728873AbgBQPtm (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 17 Feb 2020 10:49:42 -0500
Received: from zn.tnic (p200300EC2F060D009DD3216986B5E5B9.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:d00:9dd3:2169:86b5:e5b9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0BA9F1EC0C31;
        Mon, 17 Feb 2020 16:49:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1581954581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lCpw4h+ZBhACDgatFQJ0CmkYnNpKLvrCrLlPhbcNDjM=;
        b=dP3vD8N598PWlBE9Jsr+On4H9hxu0f09RvqumZ8VfqQlPDDINlBdrdbE/Gxig8TmO3Yfyc
        TRog+kTopZ2fylegcYDCORWiJ1GlxvqtbIOSHiE1h/Fu0WlMFLvLsdQ6ckZY6pnxk8K1ws
        Fn8ojyFoJCGeQotHjZRArrqIJ0zpFsE=
Date:   Mon, 17 Feb 2020 16:49:36 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 00/10] EDAC: Rework core and ghes drivers, part two
Message-ID: <20200217154936.GA2796@zn.tnic>
References: <20200123090210.26933-1-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200123090210.26933-1-rrichter@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jan 23, 2020 at 09:02:47AM +0000, Robert Richter wrote:
> This patch set is part two of a rework of the ghes_edac and edac_mc
> driver. It addresses issues found during code review and while working
> with the code. Part one has been included to v5.5, see:
> 
>  https://lore.kernel.org/patchwork/cover/1093488/
> 
> The changes of this series include:
> 
>  * add helper functions and factor out code (#1, #2, #5)
> 
>  * improve function interfaces and data structures to decrease
>    complexity such as number of function arguments, unused data, etc.
>    (#3, #4, #7, #8, #9, #10),
> 
>  * minor functional fixes (#6)
> 
>  * improve code readability (#9)
> 
> V3:
>  * rebased onto edac-for-next + "EDAC/mc: Fix use-after-free and
>    memleaks during device removal", no code changes:
>    7e5d6cf35329 ("EDAC/amd64: Do not warn when removing instances")
>    https://lore.kernel.org/patchwork/patch/1169444/
>  * added Aristeu's ACKs
> 
> V2:
>  * fixed documentation issue in #3 found by "kbuild test robot
>    <lkp@intel.com>"
> 
> Changes compared to part one:
>  * rebased onto 5781823fd0d3 ("EDAC/altera: Use the Altera System
>    Manager driver")
>  * reworded patch subjects
>  * reordered patches
>  * collected Mauro's Reviewed-by-tags (note: I kept them though there
>    has been small conflicts but dropped it when reworked)
>  * dropped: "EDAC/mc: Rework edac_raw_mc_handle_error() to use struct
>    dimm_info"
>  * split "EDAC/mc: Remove per layer counters" into smaller changes
>  * added:
>    "EDAC/mc: Report "unknown memory" on too many DIMM labels found"
>    "EDAC/mc: Remove enable_per_layer_report function arguments"
>    "EDAC/mc: Pass the error descriptor to error reporting functions"
>    "EDAC/mc: Remove detail[] string and cleanup error string
>    generation"
>  * moved to the end:
>    "EDAC/mc: Remove per layer counters"
> 
> 
> Robert Richter (10):
>   EDAC/mc: Split edac_mc_alloc() into smaller functions
>   EDAC/mc: Reorder functions edac_mc_alloc*()
>   EDAC: Store error type in struct edac_raw_error_desc
>   EDAC/mc: Determine mci pointer from the error descriptor
>   EDAC/mc: Create new function edac_inc_csrow()
>   EDAC/mc: Report "unknown memory" on too many DIMM labels found
>   EDAC/mc: Remove enable_per_layer_report function arguments
>   EDAC/mc: Pass the error descriptor to error reporting functions
>   EDAC/mc: Remove detail[] string and cleanup error string generation
>   EDAC/mc: Remove per layer counters
> 
>  drivers/edac/edac_mc.c       | 502 ++++++++++++++++-------------------
>  drivers/edac/edac_mc.h       |   6 +-
>  drivers/edac/edac_mc_sysfs.c |  20 +-
>  drivers/edac/ghes_edac.c     |  16 +-
>  include/linux/edac.h         |   9 +-
>  5 files changed, 252 insertions(+), 301 deletions(-)

Ok, all queued and will appear in linux-next soon. Let's see what falls
out.

Thx for the nice cleanup!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
