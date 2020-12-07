Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E01A2D0EDC
	for <lists+linux-edac@lfdr.de>; Mon,  7 Dec 2020 12:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgLGLUT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 7 Dec 2020 06:20:19 -0500
Received: from mail.skyhub.de ([5.9.137.197]:60950 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbgLGLUT (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 7 Dec 2020 06:20:19 -0500
Received: from zn.tnic (p4fed31e1.dip0.t-ipconnect.de [79.237.49.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B320C1EC0426;
        Mon,  7 Dec 2020 12:19:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1607339977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XYWwByMWitnTEsriHnMquiuoxbw9xmBiP+xQcZ42uX4=;
        b=K6WHIa2SoRS6q4VIUPe4HJd5VmZEJmehKXp5SsjskOBJvvF0eDYdwCSzDL0lo73Ak+6Exc
        7l0UqIk+eoklpvjoARYuh4z69Gnm0ppa8OvDSixAtY3bSIj8IApn/BvgOs7aOfBvUkZn3p
        rrAH7XqXww1P6eeoDudEnGhesjgXU1c=
Date:   Mon, 7 Dec 2020 12:17:27 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] EDAC/mv64x60: Remove orphan mv64x60 driver
Message-ID: <20201207111727.GC20489@zn.tnic>
References: <20201207040253.628528-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201207040253.628528-1-mpe@ellerman.id.au>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Dec 07, 2020 at 03:02:53PM +1100, Michael Ellerman wrote:
> The mv64x60 EDAC driver depends on CONFIG_MV64X60. But that symbol is
> not user-selectable, and the last code that selected it was removed
> with the C2K board support in 2018, see:
> 
>   92c8c16f3457 ("powerpc/embedded6xx: Remove C2K board support")
> 
> That means the driver is now dead code, so remove it.
> 
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  drivers/edac/Kconfig        |   7 -
>  drivers/edac/Makefile       |   1 -
>  drivers/edac/mv64x60_edac.c | 883 ------------------------------------
>  drivers/edac/mv64x60_edac.h | 114 -----
>  4 files changed, 1005 deletions(-)
>  delete mode 100644 drivers/edac/mv64x60_edac.c
>  delete mode 100644 drivers/edac/mv64x60_edac.h

Gladly taken and applied, thanks!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
