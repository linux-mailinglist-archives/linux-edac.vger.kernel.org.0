Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F59D48FE71
	for <lists+linux-edac@lfdr.de>; Sun, 16 Jan 2022 19:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbiAPS3t (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 16 Jan 2022 13:29:49 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33694 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232456AbiAPS3t (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 16 Jan 2022 13:29:49 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 79CA71EC0104;
        Sun, 16 Jan 2022 19:29:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642357783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=SM4OKV9Mv+s2Q5kz4yzPv56ShBZelcFLXXBsRc0m6d0=;
        b=NDIcNZQlCqkxEEr8l8uJ6fsjOfPcy6ZNU8F8+h1+3hoAUXvWwwYa/4ImLpbXYTtQJoA9O2
        CeEbdcZegdIz+VpjD2A6dDsslpP1hnucCv5prm9Ir5u8CLEGjg60aCryKIA8+M5AcmA5e8
        Pngtj8n4haYf/NXmTHq/mB6bTv5L6JM=
Date:   Sun, 16 Jan 2022 19:29:46 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Lei Wang <lewan@microsoft.com>, Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        Shiping Ji <shiping.linux@gmail.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/dmc520: Don't print an error for each unconfigured
 interrupt line
Message-ID: <YeRkGvestiloCAUV@zn.tnic>
References: <20220111163800.22362-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220111163800.22362-1-tyhicks@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jan 11, 2022 at 10:38:00AM -0600, Tyler Hicks wrote:
> The dmc520 driver requires that at least one interrupt line, out of the ten
> possible, is configured. The driver prints an error and returns -EINVAL
> from its .probe function if there are no interrupt lines configured.
> 
> Don't print a KERN_ERR level message for each interrupt line that's
> unconfigured as that can confuse users into thinking that there is an
> error condition.
> 
> Before this change, the following KERN_ERR level messages would be
> reported if only dram_ecc_errc and dram_ecc_errd were configured in the
> device tree:
> 
>  dmc520 68000000.dmc: IRQ ram_ecc_errc not found
>  dmc520 68000000.dmc: IRQ ram_ecc_errd not found
>  dmc520 68000000.dmc: IRQ failed_access not found
>  dmc520 68000000.dmc: IRQ failed_prog not found
>  dmc520 68000000.dmc: IRQ link_err not
>  dmc520 68000000.dmc: IRQ temperature_event not found
>  dmc520 68000000.dmc: IRQ arch_fsm not found
>  dmc520 68000000.dmc: IRQ phy_request not found
> 
> Fixes: 1088750d7839 ("EDAC: Add EDAC driver for DMC520")
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> Cc: <stable@vger.kernel.org>

Why stable? AFAICT, this is fixing only the spew of some error messages
but the driver is still functional.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
