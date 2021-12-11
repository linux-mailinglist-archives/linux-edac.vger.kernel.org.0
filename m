Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5619D47138E
	for <lists+linux-edac@lfdr.de>; Sat, 11 Dec 2021 12:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhLKLJJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 11 Dec 2021 06:09:09 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36566 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230413AbhLKLJJ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 11 Dec 2021 06:09:09 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2F63B1EC04DE;
        Sat, 11 Dec 2021 12:09:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1639220944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=L2nTyHnglfV/p1fdhAPCEoans1duqzNgPre3L5/aOXw=;
        b=lHuiAvT5cppLfCX+hGKadtns5er3eQ/avQGs6hzhnQ8vmJBkXfhQuu4oz17rb3ecf7kdi1
        nNWs1xxzztsMRROZmijYMFdREpajnLzC4+jyhVlogK0j9aMdnCslJwzrTZVTVk5C4nLMFz
        /cbi7LTfqVZYOY8ofjc8IInTtYdwxpQ=
Date:   Sat, 11 Dec 2021 12:09:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     tony.luck@intel.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RAS/CEC: fix typo in a comment
Message-ID: <YbSG0ap1a+jhgKe3@zn.tnic>
References: <20211211091914.268823-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211211091914.268823-1-wangborong@cdjrlc.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sat, Dec 11, 2021 at 05:19:14PM +0800, Jason Wang wrote:
> The double `an' in the comment in line 41 is repeated. Remove one
> of them from the comment.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  drivers/ras/cec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
