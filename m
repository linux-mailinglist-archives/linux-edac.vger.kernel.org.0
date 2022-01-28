Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527214A03D4
	for <lists+linux-edac@lfdr.de>; Fri, 28 Jan 2022 23:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351750AbiA1Wj1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 28 Jan 2022 17:39:27 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50880 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232883AbiA1Wj1 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 28 Jan 2022 17:39:27 -0500
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D129A1EC0523;
        Fri, 28 Jan 2022 23:39:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643409562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=KB3JCIVlyZGYGTmTYfjmRFOcXBSQCdtYzo7NB0VRODg=;
        b=PwgLCKWxZS1RqiizkwSaI9u0poXq0scesRczip8tDfOECQgCXB2WCAYbTEd4aGoJ35BsVq
        0VuaCqhhXVft5Eog5P0VND7LyqZGz9/z5xrFfpVtSuFGcJGqoWLFRf20KxlPpZp3X26TtU
        AjZM8QZt0yYRr+EQ2ZqZN7SZL5DEh/U=
Date:   Fri, 28 Jan 2022 23:39:17 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix deferred probing in the EDAC drivers
Message-ID: <YfRwla8q57s27+PZ@zn.tnic>
References: <20220124185503.6720-1-s.shtylyov@omp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220124185503.6720-1-s.shtylyov@omp.ru>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jan 24, 2022 at 09:55:01PM +0300, Sergey Shtylyov wrote:
> Here are 2 patches against the 'edac-for-next' branch of the 'ras.git' repo
> (for the lack of a better branch for fixes?).  The affected drivers call
> platform_get_irq[_optional]() but override its result in case of error --
> which prevents the deferred probing from working.
> 
> Sergey Shtylyov (2):
>   edac: altera: fix deferred probing
>   edac: xgene: fix deferred probing
> 
>  drivers/edac/altera_edac.c | 2 +-
>  drivers/edac/xgene_edac.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> -- 

Both applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
