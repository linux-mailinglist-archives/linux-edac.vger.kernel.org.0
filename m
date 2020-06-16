Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA7D1FBD90
	for <lists+linux-edac@lfdr.de>; Tue, 16 Jun 2020 20:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgFPSIb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 Jun 2020 14:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgFPSIa (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 16 Jun 2020 14:08:30 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654BEC061573;
        Tue, 16 Jun 2020 11:08:30 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f4c001d7e5f403e90d72b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:4c00:1d7e:5f40:3e90:d72b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E984A1EC035B;
        Tue, 16 Jun 2020 20:08:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592330909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=55p4gDchXhxo2cVul8FBBJghAN73Fe1E/I9Qo+fvFR4=;
        b=JeU7EpLxHLDz3HPWQjyrRBA4x1W7JBV7hP0MRJ65ygLx2EXtb1gYNK8T9TQTLCj0GX73bF
        YhdNjU15p5/c4awo9vzaRy4N/BWbyIVe1xyWK6Mx0+xack1sps8rdQUIdRGCYZOl9jyE2c
        JZnPwQuK22d7Q4pu5KylY07YWD6gpp4=
Date:   Tue, 16 Jun 2020 20:08:27 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jacky Hu <hengqing.hu@gmail.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/2] x86/amd_nb: Add Family 17h, Model 60h PCI IDs
Message-ID: <20200616180827.GM13515@zn.tnic>
References: <20200607043709.48178-1-hengqing.hu@gmail.com>
 <20200607043709.48178-2-hengqing.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200607043709.48178-2-hengqing.hu@gmail.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Jun 07, 2020 at 12:37:08PM +0800, Jacky Hu wrote:
> Add the new Family 17h, Model 60h PCI IDs for AMD Zen2 APU systems.
> 
> Signed-off-by: Jacky Hu <hengqing.hu@gmail.com>
> ---
>  arch/x86/kernel/amd_nb.c | 5 +++++
>  drivers/hwmon/k10temp.c  | 2 ++
>  include/linux/pci_ids.h  | 1 +
>  3 files changed, 8 insertions(+)

Blergh, this shows that I need a vacation. That's already upstream:

a4e91825d7e1 ("x86/amd_nb: Add AMD family 17h model 60h PCI IDs")

modulo the k10temp bits.

Jacky, I'll let you sort this out with Guenter.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
