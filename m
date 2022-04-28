Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A5C51359D
	for <lists+linux-edac@lfdr.de>; Thu, 28 Apr 2022 15:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347644AbiD1Nt4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Apr 2022 09:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiD1Ntx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 28 Apr 2022 09:49:53 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24FF9E9EB
        for <linux-edac@vger.kernel.org>; Thu, 28 Apr 2022 06:46:38 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1E3CF1EC04A6;
        Thu, 28 Apr 2022 15:46:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1651153593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=GCiWFkwrOfWrWkC1BToDvOQs1Fu2CNqbcyGhgQdHtwo=;
        b=o+a4CLGfl435RsiWh5sWLyVy74V0weGcYhXDOsAN9zl3VIi3ehkBEQmTuDYHskToHenxwo
        qt7ic43kIbtmfo7qxbu31EWhoF1LlM5RyGxtbPcDcUkKCCXcp05VwrID0BRSyHvL2fdGNH
        z3v0XF1yA5XwJPjXQchznDlD5rajNNo=
Date:   Thu, 28 Apr 2022 15:46:33 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     linux-edac@vger.kernel.org, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com
Subject: Re: [PATCH] EDAC/synopsys: Fix the spdx header
Message-ID: <YmqauTh7rvR62EJt@zn.tnic>
References: <20220428044051.2842687-1-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220428044051.2842687-1-shubhrajyoti.datta@xilinx.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Apr 28, 2022 at 10:10:51AM +0530, Shubhrajyoti Datta wrote:
> Also fixes the below warning
> 
> WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> +/*
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
>  drivers/edac/synopsys_edac.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
> index f05ff02c0656..fbe2aa1e334a 100644
> --- a/drivers/edac/synopsys_edac.c
> +++ b/drivers/edac/synopsys_edac.c
> @@ -1,22 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Synopsys DDR ECC Driver
>   * This driver is based on ppc4xx_edac.c drivers
>   *
>   * Copyright (C) 2012 - 2014 Xilinx, Inc.
> - *
> - * This program is free software: you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation, either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * This file is subject to the terms and conditions of the GNU General Public
> - * License.  See the file "COPYING" in the main directory of this archive
> - * for more details
>   */
>  
>  #include <linux/edac.h>
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
