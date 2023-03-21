Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0906C3E69
	for <lists+linux-edac@lfdr.de>; Wed, 22 Mar 2023 00:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjCUXV7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 21 Mar 2023 19:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCUXV6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 21 Mar 2023 19:21:58 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21892591EF;
        Tue, 21 Mar 2023 16:21:56 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 31A7B1EC0373;
        Wed, 22 Mar 2023 00:21:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1679440914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PGCFWeab8ZV/Tn/2SCNtHE0y9R5qY4L9uu7+uRgdIFc=;
        b=bHDtlXwPPZfyZUtmVdx+n+imrELBclzn+YdkHGeqzFHTO6xTxdLdsap5QgXMUeAvQEp/yg
        YahQrVz/13z7M7p4USx9Beu5fHvtb+E49ynAwmQnT3S6KJsDLCp44l3usOmqOymv8j2CCH
        QLfOa1GaywPHv7eHK1y5EIJHKCgt/1k=
Date:   Wed, 22 Mar 2023 00:21:48 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Deepak R Varma <drv@mailo.com>
Cc:     Dinh Nguyen <dinguyen@kernel.org>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        pk.drv@ubun2204.myguest.virtualbox.org
Subject: Re: [PATCH RESEND] EDAC/altera: Remove redundant error logging
Message-ID: <20230321232148.GDZBo8DNnxBNmvOUhP@fat_crate.local>
References: <Y/+j27kqdhflPtaj@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/+j27kqdhflPtaj@ubun2204.myguest.virtualbox.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Mar 02, 2023 at 12:43:31AM +0530, Deepak R Varma wrote:
> A call to platform_get_irq() already prints an error on failure within
> its own implementation. So printing another error based on its return
> value in the caller is redundant and should be removed. The clean up
> also makes if condition block braces unnecessary. Remove that as well.
> 
> Issue identified using platform_get_irq.cocci coccinelle semantic patch.
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
> Note:
>    The change was compile tested only.
>    Resending the patch for a review and feedback.
>      
>  drivers/edac/altera_edac.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
