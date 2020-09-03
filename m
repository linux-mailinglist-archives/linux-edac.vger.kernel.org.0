Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF27A25BFDC
	for <lists+linux-edac@lfdr.de>; Thu,  3 Sep 2020 13:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgICLFm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 3 Sep 2020 07:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgICK67 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 3 Sep 2020 06:58:59 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F035C061244;
        Thu,  3 Sep 2020 03:58:56 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d7a005419317048ee0789.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:7a00:5419:3170:48ee:789])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 901D21EC04CB;
        Thu,  3 Sep 2020 12:58:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1599130732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jFgR8B43svgkJTAQLtPGLdTbywp8lqxgXaF2hdYHOxI=;
        b=iQOezLnuceBdy6FP5f1e+/Ky22aTiU2sbh7poxpJvORa7KBnNk66Rcr39qYjUCfFei0Tdo
        QYChFscC2jEOZemAyZEtVFZhEtxKsPpJ/nx0yFkwjJ+Us6VUXojXdpblNYqjeZOLxzrHRm
        zZMkFiKoqAPbmPzSCP9I904zpWEkViY=
Date:   Thu, 3 Sep 2020 12:58:49 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Gregor Herburger <gregor.herburger@ew.tq-group.com>
Cc:     york.sun@nxp.com, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rrichter@marvell.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] edac: fsl_ddr_edac: fix expected data message
Message-ID: <20200903105849.GC5462@zn.tnic>
References: <20200817095302.GD549@zn.tnic>
 <20200827075600.22335-1-gregor.herburger@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200827075600.22335-1-gregor.herburger@ew.tq-group.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Aug 27, 2020 at 09:56:00AM +0200, Gregor Herburger wrote:
> When a correctable single bit error occurs, the driver calculates the
> bad_data_bit respectively the bad_ecc_bit. If there is no error in the
> corresponding data, the value becomes -1. With this the expected data
> message is calculated.
> 
> In the case of an error in the lower 32 bits or no error (-1) the right
> side operand of the bit-shift becomes negative which is undefined
> behavior.
> 
> This can result in wrong and misleading messages like this:
> [  311.103794] EDAC FSL_DDR MC0: Faulty Data bit: 36
> [  311.108490] EDAC FSL_DDR MC0: Expected Data / ECC:   0xffffffef_ffffffff / 0x80000059
> [  311.116135] EDAC FSL_DDR MC0: Captured Data / ECC:   0xffffffff_ffffffef / 0x59
> 
> Fix this by only calculating the expected data where the error occurred.
> 
> With the fix the dmesg output looks like this:
> [  311.103794] EDAC FSL_DDR MC0: Faulty Data bit: 36
> [  311.108490] EDAC FSL_DDR MC0: Expected Data / ECC:   0xffffffef_ffffffef / 0x59
> [  311.116135] EDAC FSL_DDR MC0: Captured Data / ECC:   0xffffffff_ffffffef / 0x59
> 
> Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
> ---
>  drivers/edac/fsl_ddr_edac.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/edac/fsl_ddr_edac.c b/drivers/edac/fsl_ddr_edac.c
> index 6d8ea226010d..4b6989cf1947 100644
> --- a/drivers/edac/fsl_ddr_edac.c
> +++ b/drivers/edac/fsl_ddr_edac.c
> @@ -343,9 +343,9 @@ static void fsl_mc_check(struct mem_ctl_info *mci)
>  
>  		fsl_mc_printk(mci, KERN_ERR,
>  			"Expected Data / ECC:\t%#8.8x_%08x / %#2.2x\n",
> -			cap_high ^ (1 << (bad_data_bit - 32)),
> -			cap_low ^ (1 << bad_data_bit),
> -			syndrome ^ (1 << bad_ecc_bit));
> +			(bad_data_bit > 31) ? cap_high ^ (1 << (bad_data_bit - 32)) : cap_high,
> +			(bad_data_bit <= 31) ? cap_low ^ (1 << (bad_data_bit)) : cap_low,

But if bad_data_bit is -1, this check above will hit and you'd still
shift by -1, IINM.

How about you fix it properly, clean it up and make it more readable in
the process (pasting the code directly instead of a diff because a diff
is less readable):

        if ((err_detect & DDR_EDE_SBE) && (bus_width == 64)) {
                sbe_ecc_decode(cap_high, cap_low, syndrome,
                                &bad_data_bit, &bad_ecc_bit);

                if (bad_data_bit != -1) {
                        if (bad_data_bit > 31)
                                cap_high ^= 1 << (bad_data_bit - 32);
                        else
                                cap_low  ^= 1 << bad_data_bit;

                        fsl_mc_printk(mci, KERN_ERR, "Faulty Data bit: %d\n", bad_data_bit);
                        fsl_mc_printk(mci, KERN_ERR, "Expected Data: %#8.8x_%08x\n",
                                      cap_high, cap_low);
                }

                if (bad_ecc_bit != -1) {
                        fsl_mc_printk(mci, KERN_ERR, "Faulty ECC bit: %d\n", bad_ecc_bit);
                        fsl_mc_printk(mci, KERN_ERR, "Expected ECC: %#2.2x\n",
                                      syndrome ^ (1 << bad_ecc_bit));
                }
        }

This way you print only when the respective faulty bits have been
properly found and not print anything otherwise.

Hmm?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
