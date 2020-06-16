Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF81B1FB47E
	for <lists+linux-edac@lfdr.de>; Tue, 16 Jun 2020 16:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgFPOfZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 Jun 2020 10:35:25 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40202 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgFPOfZ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 16 Jun 2020 10:35:25 -0400
Received: from zn.tnic (p200300ec2f0f4c00b15c06cc69c9587d.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:4c00:b15c:6cc:69c9:587d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B2F611EC0289;
        Tue, 16 Jun 2020 16:35:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592318123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=EcoBlamw+xTPMLRvT+GpzdkCpC6DAYKigFf4Z2daiJY=;
        b=ZkENWgVQ1RIyBGyzqnYB1OVikjSQAJjJD6hneI8RWOab3aW73TuqicbzCStRRaf8g023Fu
        9QG3UIPXBF103ec5vb/SPcvGXB63twhaUiSPDNNIRoFVTvbTWH2+Ykqsp4+wqx7WR4Cb3M
        Y5j59ENZ+cYDWnoIloXbzCEB1M56ayc=
Date:   Tue, 16 Jun 2020 16:35:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jacky Hu <hengqing.hu@gmail.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 0/2] MCA and EDAC updates for AMD Family 17h, Model 60h
Message-ID: <20200616143517.GH13515@zn.tnic>
References: <20200607043709.48178-1-hengqing.hu@gmail.com>
 <20200615115950.GG14668@zn.tnic>
 <a9d0cfc4-1aed-d6ed-c6f2-336b56d91f20@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a9d0cfc4-1aed-d6ed-c6f2-336b56d91f20@roeck-us.net>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jun 15, 2020 at 08:01:22AM -0700, Guenter Roeck wrote:
> Looks like we may have to black-list current measurements
> for that chip, though.
> 
> Guenter
> 
> >> Jacky Hu (2):
> >>   x86/amd_nb: Add Family 17h, Model 60h PCI IDs
> >>   EDAC/amd64: Add family ops for Family 17h Models 60h-6Fh
> >>
> >>  arch/x86/kernel/amd_nb.c  |  5 +++++
> >>  drivers/edac/amd64_edac.c | 14 ++++++++++++++
> >>  drivers/edac/amd64_edac.h |  3 +++
> >>  drivers/hwmon/k10temp.c   |  2 ++

... meaning I should not take the k10temp changes yet? I can drop them
and take the rest...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
