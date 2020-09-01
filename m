Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2B8258C82
	for <lists+linux-edac@lfdr.de>; Tue,  1 Sep 2020 12:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgIAKNy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 1 Sep 2020 06:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgIAKNx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 1 Sep 2020 06:13:53 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4144EC061244;
        Tue,  1 Sep 2020 03:13:53 -0700 (PDT)
Received: from zn.tnic (p200300ec2f111c000c6e903c2b8b7428.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:1c00:c6e:903c:2b8b:7428])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C4D711EC0246;
        Tue,  1 Sep 2020 12:13:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1598955230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NY4YDSEDfN5GOV9jqboSUJfKtJ2U0iuZgeu2bas8HPA=;
        b=WKMbQ7cOUg0o41V7Svb+yFavjB/WLzXiMmdevAkS6ZVd3vPEPCMvMPXTgTn9NlQp4hKqpr
        n2Yblg31FxkJ4cky3yLidaq1+YZyxoADfCQfoO48tgVBL+TVC2awZALlNBB9TCCudug6vX
        E6/1AAGrwk3S3TuStT+BxopN57N43gg=
Date:   Tue, 1 Sep 2020 12:13:45 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ericsson.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC: i5100_edac: Fix error handling code in
 i5100_init_one
Message-ID: <20200901101345.GA8392@zn.tnic>
References: <20200826121437.31606-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200826121437.31606-1-dinghao.liu@zju.edu.cn>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Aug 26, 2020 at 08:14:37PM +0800, Dinghao Liu wrote:
> When pci_get_device_func() fails, we don't need to execute
> pci_dev_put(). But mci should be freed to prevent memleak.
> When pci_enable_device() fails, we don't need to disable
> einj either.
> 
> Fixes: 52608ba205461 ("i5100_edac: probe for device 19 function 0")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/edac/i5100_edac.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
