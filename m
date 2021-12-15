Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59EF2475FE2
	for <lists+linux-edac@lfdr.de>; Wed, 15 Dec 2021 18:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238406AbhLORxa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 15 Dec 2021 12:53:30 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37030 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238305AbhLORx1 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 15 Dec 2021 12:53:27 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2C0AD1EC02B9;
        Wed, 15 Dec 2021 18:53:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1639590801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ArO9V6sxes1VIyXWbwZ4JToUjKhvshQl15JWyKJqQPc=;
        b=L7C49ZZF4yil3990IgXq2G6YqPT0pxuVzjDC54OH8q4EJNgZqRKFSJZ39mSacCnwfSNMEk
        7W8lnEatu/1uzwkwkmIN2Zh13IYc9I6kMJHg2y3vDL3cElmwrRrli091ryfm74FzxCbn8b
        JTM1yO3LCBdosTN70CLvnWmw7FMF8Dc=
Date:   Wed, 15 Dec 2021 18:53:22 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, Smita.KoralahalliChannabasappa@amd.com,
        william.roche@oracle.com
Subject: Re: [PATCH v2 0/2] AMD Family 19h Models 10h-1Fh Updates
Message-ID: <YborkrhtP3Is1FLe@zn.tnic>
References: <20211215155309.2711917-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211215155309.2711917-1-yazen.ghannam@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Dec 15, 2021 at 03:53:07PM +0000, Yazen Ghannam wrote:
> The following commit in hwmon-next is needed for functional support of
> this set.
> 
>   49e90c39d0be ("x86/amd_nb: Add AMD Family 19h Models (10h-1Fh) and (A0h-AFh) PCI IDs")

I'd normally want do cross-merge that one so that stuff can get tested
but am being told that those models are not shipping yet so we're not
going to break anything even if those go separately Linus-wards.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
