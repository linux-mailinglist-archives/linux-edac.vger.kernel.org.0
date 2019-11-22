Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8A01068C4
	for <lists+linux-edac@lfdr.de>; Fri, 22 Nov 2019 10:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfKVJYJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 22 Nov 2019 04:24:09 -0500
Received: from mail.skyhub.de ([5.9.137.197]:41836 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbfKVJYJ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 22 Nov 2019 04:24:09 -0500
Received: from zn.tnic (p200300EC2F0E97008857C615A913C712.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:9700:8857:c615:a913:c712])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 20DBF1EC0CFE;
        Fri, 22 Nov 2019 10:24:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574414648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=RuqK6rdw+kOj5d/goa9PzdaaZY05Qs1SpmtZlzCNFXs=;
        b=BmIyYK3xFWOz56JiFtvKpzg2kdCM6/MW1a2gtAMukB4KUiuapSUp2ieMIKiG84xkaAogBL
        QqlL93BvTIA0LGtNQ1B6i7cQnj4ssaoDhJkO8E0AsXoTQBN0hSQkk58z5Z6VnFC7vtMzs8
        7eO86KAxTbUKsUAsIIiNqiV+US/DtLA=
Date:   Fri, 22 Nov 2019 10:24:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     thor.thayer@linux.intel.com
Cc:     mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rrichter@marvell.com, Meng.Li@windriver.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 0/3] Altera EDAC Fix & Cleanup Patches
Message-ID: <20191122092405.GE6289@zn.tnic>
References: <1574361048-17572-1-git-send-email-thor.thayer@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1574361048-17572-1-git-send-email-thor.thayer@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Nov 21, 2019 at 12:30:45PM -0600, thor.thayer@linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> This patchset includes a fix for the Stratix10 IRQ regmap
> and cleanup of the driver as it has evolved.
> 
> Patch 2 and 3 were accepted into the edac-for-next branch [1]
> but the fix should be included. Version 2 of the patches
> rebase on top of the fix.
> 
> This patchset should replace the current patches[1].
> 
> [1] https://lore.kernel.org/linux-edac/1573156890-26891-1-git-send-email-thor.thayer@linux.intel.com/
> 
> Meng Li (1):
>   EDAC/altera: Use fast register IO for S10 IRQs
> 
> Thor Thayer (2):
>   EDAC/altera: Cleanup the ECC Manager
>   EDAC/altera: Use the Altera System Manager driver
> 
>  drivers/edac/altera_edac.c | 152 +++------------------------------------------
>  1 file changed, 9 insertions(+), 143 deletions(-)
> 
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
