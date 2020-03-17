Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5C41885FA
	for <lists+linux-edac@lfdr.de>; Tue, 17 Mar 2020 14:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgCQNiX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 17 Mar 2020 09:38:23 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53120 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbgCQNiX (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 17 Mar 2020 09:38:23 -0400
Received: from zn.tnic (p200300EC2F0C960055604FE4C38CEC9D.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:9600:5560:4fe4:c38c:ec9d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 41C631EC0CE0;
        Tue, 17 Mar 2020 14:38:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1584452301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=apBU1oiP7OfJ/UWSLrJmTfdlSC73HgPnz+pcwjgiq7E=;
        b=pmDGx6UxB4G2stpVI+6ivyn6Grfk/RwDOmSYvJFqZZQrEaLYSOxrrbkVJ6Za0c1cRJeZ3Q
        CfZh6xDqdisRJteR7FVFSAm4BwK4V5sf7Zfc+dCzroU8eW8Cdd2jPYoOKO/I47NStiZhA2
        Mo+mmJOXFfde1rmi+m910TC0xZI4nuU=
Date:   Tue, 17 Mar 2020 14:38:23 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rrichter@marvell.com, michal.simek@xilinx.com,
        manish.narani@xilinx.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com, frank.li@nxp.com
Subject: Re: [patch v3] EDAC: synopsys: Fix the wrong call of pinf->col
 parameter
Message-ID: <20200317133823.GB15609@zn.tnic>
References: <1584365679-27443-1-git-send-email-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1584365679-27443-1-git-send-email-sherry.sun@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Mar 16, 2020 at 09:34:39PM +0800, Sherry Sun wrote:
> Since ZynqMP platform call zynqmp_get_error_info() function to get ce/ue
> information. In this function, pinf->col parameter is not used, this
> parameter is only used by Zynq platforme in zynq_get_error_info(). So
> here pinf->col should not be called and printed for ZynqMP, need remove
> it.
> 
> In order to show which function called handle_error() explicitly, here
> use DDR_ECC_INTR_SUPPORT as check condition to distinguish Zynq and
> ZynqMP platform instead the current way.
> 
> Fixes: b500b4a029d57 ("EDAC, synopsys: Add ECC support for ZynqMP DDR controller")
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> Reviewed-by: Manish Narani <manish.narani@xilinx.com>
> ---
> Changes in V3:
> - Make the check condition in handle_error() more explicitly, use 
> quirks & DDR_ECC_INTR_SUPPORT instead !quirks, and exchange the context in
> if/else.
> 
> Changes in V2:
> - Separated this patch from the original patchset.
> 
> ---
>  drivers/edac/synopsys_edac.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
