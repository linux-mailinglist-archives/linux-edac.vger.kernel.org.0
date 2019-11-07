Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1DDF2D13
	for <lists+linux-edac@lfdr.de>; Thu,  7 Nov 2019 12:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388224AbfKGLHP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 7 Nov 2019 06:07:15 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50732 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388064AbfKGLHP (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 7 Nov 2019 06:07:15 -0500
Received: from zn.tnic (p200300EC2F0EAD00D550E8D60855E7CD.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:ad00:d550:e8d6:855:e7cd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0C8691EC0CA8;
        Thu,  7 Nov 2019 12:07:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573124834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZMLD3a5M0MxniTpn02MzZp+4bP849vKFA4oIJpLz5+c=;
        b=h9nIY/55AsZe9BPwxfFxGH6gvG/Si/eLOqk+r8d5N/C6Nbo7MG3I+DkjY/R7m6OPSWtG+w
        QVT4mn8BLBojaFGdQLnwsTDh1TyPpB4Uwcw4jkSHc38ci0b/1wz9YjLchHXOBQWcZc0lYs
        QkQvReP5eJPOAKWoDkpJaFOxruWcvyY=
Date:   Thu, 7 Nov 2019 12:07:08 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rrichter@marvell.com,
        yash.shah@sifive.com, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH v2] riscv: move sifive_l2_cache.c to drivers/soc
Message-ID: <20191107110707.GE19501@zn.tnic>
References: <20191107092039.32240-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191107092039.32240-1-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Nov 07, 2019 at 10:20:39AM +0100, Christoph Hellwig wrote:
> The sifive_l2_cache.c is in no way related to RISC-V architecture
> memory management.  It is a little stub driver working around the fact
> that the EDAC maintainers prefer their drivers to be structured in a
> certain way that doesn't fit the SiFive SOCs.
> 
> Move the file to drivers/soc and add a Kconfig option for it, as well
> as the whole drivers/soc boilerplate for CONFIG_SOC_SIFIVE.
> 
> Fixes: a967a289f169 ("RISC-V: sifive_l2_cache: Add L2 cache controller driver for SiFive SoCs")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> 
> Changes since v2:
>  - don't allow modular builds
>  - remove the empty last line in the new Makefile
> 
>  MAINTAINERS                                            |  1 +
>  arch/riscv/mm/Makefile                                 |  1 -
>  drivers/edac/Kconfig                                   |  2 +-
>  drivers/soc/Kconfig                                    |  1 +
>  drivers/soc/Makefile                                   |  1 +
>  drivers/soc/sifive/Kconfig                             | 10 ++++++++++
>  drivers/soc/sifive/Makefile                            |  3 +++
>  .../riscv/mm => drivers/soc/sifive}/sifive_l2_cache.c  |  0
>  8 files changed, 17 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/soc/sifive/Kconfig
>  create mode 100644 drivers/soc/sifive/Makefile
>  rename {arch/riscv/mm => drivers/soc/sifive}/sifive_l2_cache.c (100%)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
