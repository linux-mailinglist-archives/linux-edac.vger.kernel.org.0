Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAFFC185FA1
	for <lists+linux-edac@lfdr.de>; Sun, 15 Mar 2020 20:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbgCOTuX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 15 Mar 2020 15:50:23 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40486 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727329AbgCOTuW (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 15 Mar 2020 15:50:22 -0400
Received: from zn.tnic (p200300EC2F28D000ACB9AA06AD32AB36.dip0.t-ipconnect.de [IPv6:2003:ec:2f28:d000:acb9:aa06:ad32:ab36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9346E1EC027B;
        Sun, 15 Mar 2020 20:50:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1584301820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=17Mj+NXZZqXgw9A9yH5A54NytjZGqmWKL11usy+lGKE=;
        b=cGhe2zh6Z5MfYnkcm812fY0mGNV4bikyhGUZz4pjtjPGwIZBC+Djdj3qubwnXODOtdvcOb
        PjhR+fsyiYZ/wkkj27llHp6ISA+/UhVhO5Xqz9rOwClVs3Df1TGansURqGMMY8lhbdB8yS
        yYd+BdoR0b0lr3PyAvXYVueBROvlzZc=
Date:   Sun, 15 Mar 2020 20:50:24 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rrichter@marvell.com, michal.simek@xilinx.com,
        manish.narani@xilinx.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com, frank.li@nxp.com
Subject: Re: [PATCH v2] EDAC: synopsys: Fix the wrong call of pinf->col
 parameter
Message-ID: <20200315195024.GB10926@zn.tnic>
References: <1582856183-5007-1-git-send-email-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1582856183-5007-1-git-send-email-sherry.sun@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Feb 28, 2020 at 10:16:23AM +0800, Sherry Sun wrote:
> Since ZynqMP platform call zynqmp_get_error_info() function to get ce/ue
> information. In this function, pinf->col parameter is not used, this
> parameter is only used by Zynq platforme in zynq_get_error_info(). So
> here pinf->col should not be called and printed for ZynqMP, need remove
> it.

Err, the interrupt handler intr_handler() calls the ->get_error_info()
function pointer and then calls handle_error(). I.e, the same path
ending in handle_error() is called on both: Zynq and ZynqMP, one through
the interrupt and the other through the poller.

Because it looks like the interrupt support is only on ZynqMP? I'm
looking at that DDR_ECC_INTR_SUPPORT thing.

If so, then you need to rename the interrupt handler to
zynqmp_intr_handler().

And normal Zynq platform uses check_errors() which then calls
handle_error().

So still not good enough: you probably "fixed" it on ZynqMP but broke
it on Zynq because check_errors() calls ->get_error_info() which is
zynq_get_error_info() and will have populated pinf->col.

You need to differentiate between Zynq and ZynqMP in handle_error() and
issue the proper string depending on the platform.

AFAICT.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
