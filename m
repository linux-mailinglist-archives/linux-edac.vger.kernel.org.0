Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD40476010
	for <lists+linux-edac@lfdr.de>; Wed, 15 Dec 2021 19:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245430AbhLOSBW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 15 Dec 2021 13:01:22 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38198 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245258AbhLOSBV (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 15 Dec 2021 13:01:21 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 021051EC02B9;
        Wed, 15 Dec 2021 19:01:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1639591276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=sZMSLl7gMfO9tgE70syzeGUYLUkmrYOd9G7LNY2SSlI=;
        b=MHd/H2++YbKBVIZ895aN6AoXZSWtHntu+S60uosYQHqnZzpGpjtZEBD1TaiMea1HidfW4D
        RvLOoG/hIuRzlVqGSkmdStfEAHrMtGcan9aFOYfUUuEpwgium4HFpVuHaHilkM83pZ02T6
        d3FZKmyFHSVuokec4sT+7aPio6zxm1c=
Date:   Wed, 15 Dec 2021 19:01:22 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, Smita.KoralahalliChannabasappa@amd.com,
        william.roche@oracle.com
Subject: Re: [PATCH v2 1/2] EDAC/amd64: Check register values from all UMCs
Message-ID: <YbotciKVDsH1Fl1H@zn.tnic>
References: <20211215155309.2711917-1-yazen.ghannam@amd.com>
 <20211215155309.2711917-2-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211215155309.2711917-2-yazen.ghannam@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Dec 15, 2021 at 03:53:08PM +0000, Yazen Ghannam wrote:
> -		if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(5))
> +		u32 umc_cfg = 0, dimm_cfg = 0, i = 0;
> +
> +		for_each_umc(i) {
> +			umc_cfg  |= pvt->umc[i].umc_cfg;
> +			dimm_cfg |= pvt->umc[i].dimm_cfg;
> +		}
> +
> +		if (dimm_cfg & BIT(5))
>  			pvt->dram_type = MEM_LRDDR4;
> -		else if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(4))
> +		else if (dimm_cfg & BIT(4))

You're working here under the assumption that bit 4 and 5 will have the
same value on all those UMCs.

You're probably going to say that that is how the BIOS is programming
them so they should be all the same and any other configuration is
invalid but lemme still ask about it explicitly.

And if so, this would probably need a comment above it which I can add
when applying...

Hmm?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
