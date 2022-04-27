Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E57C5120D8
	for <lists+linux-edac@lfdr.de>; Wed, 27 Apr 2022 20:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240256AbiD0Pue (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 27 Apr 2022 11:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240319AbiD0Puc (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 27 Apr 2022 11:50:32 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9391E527C1;
        Wed, 27 Apr 2022 08:47:18 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CB1711EC0543;
        Wed, 27 Apr 2022 17:47:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1651074432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Lt3GxniXnRoWoJUqZqeKopFvru36t9301XWclg1MR5c=;
        b=O/qADz0GSG6wpef5NqUkwAxdk1nB4ihRKoGzDflmlM/Jz/3dptTGnwS8hTyTeT7kgdU5X5
        GK2Uas+XToy33Dx5xeXZuksQcSg8Xme3t5vyfcQYJEvOINv+RTxnfWz+A90f8LN3nJ+KW1
        D4dxxujGR91F/9GMCgSqWVJxU7zMgm8=
Date:   Wed, 27 Apr 2022 17:47:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     michal.simek@xilinx.com, Shubhrajyoti.datta@xilinx.com,
        dinguyen@kernel.org, linux-edac@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH V4 0/2] EDAC: synopsys: fix some bugs in v3.x Synopsys
 EDAC DDR driver
Message-ID: <YmllfFyEl9MokUeN@zn.tnic>
References: <20220427015137.8406-1-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220427015137.8406-1-sherry.sun@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Apr 27, 2022 at 09:51:35AM +0800, Sherry Sun wrote:
> The two patches fix some issues for v3.x Synopsys EDAC DDR in synopsys_edac.c.
> For the details, please check the patch commit log. This has been verified on
> i.MX8MP platform.
> 
> Sherry Sun (2):
>   EDAC/synopsys: Disable the error interrupt on Synopsys EDAC v3.x
>     hardware
>   EDAC/synopsys: Re-enable the interrupts in intr_handler for v3.x
>     Synopsys EDAC DDR
> 
>  drivers/edac/synopsys_edac.c | 44 ++++++++++++++++++++----------------
>  1 file changed, 25 insertions(+), 19 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
