Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9A64719E1
	for <lists+linux-edac@lfdr.de>; Sun, 12 Dec 2021 12:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhLLLsZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 12 Dec 2021 06:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhLLLsY (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 12 Dec 2021 06:48:24 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E34C061714;
        Sun, 12 Dec 2021 03:48:24 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 931C21EC0298;
        Sun, 12 Dec 2021 12:48:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1639309697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+4/Sx6gmNK9SJMBx25ANJ7tuuVUMf5npkh2k4RvknAo=;
        b=SBeXCB1QhGVQ+r9WlnwS+OuJjaPkIN2TtCWAnds1+a1WBEPqAqkcjqbc+yzn7cAJYqr98E
        UFyQ3oxraFVEnSgaLd3J/7hadYlFxgDrh0uwkWAA8t9gQA2wJQDQost8Otp7HYvkE25mzr
        RZwkLhHgTjw6vpNWfpyWc4Ye12IBC8c=
Date:   Sun, 12 Dec 2021 12:48:19 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     yazen.ghannam@amd.com, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/amd64: fix typo in a comment
Message-ID: <YbXhg699DSJNm3JK@zn.tnic>
References: <20211212032653.56459-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211212032653.56459-1-wangborong@cdjrlc.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Dec 12, 2021 at 11:26:53AM +0800, Jason Wang wrote:
> The double `reads' in the comment in line 126 is repeated. Remove one
> of them from the comment.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  drivers/edac/amd64_edac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

If you're going to waste your time fixing comments, then please fix your
commit message like I did for your previous patch:

https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git/commit/?h=edac-misc&id=b011a57e41ccbd402ecdcb53514ba76b898ec22e

And then I'd strongly suggest you try fixing real bugs - there's no
shortage of those - instead of wasting your and others' time with
comments fixes. Those can be addressed when someone is changing the code
in that area too.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
